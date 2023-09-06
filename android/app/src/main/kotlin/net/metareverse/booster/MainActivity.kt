package net.metareverse.booster

import android.content.Context
import android.media.AudioManager
import android.media.audiofx.LoudnessEnhancer
import android.os.Build
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import androidx.annotation.NonNull
import android.media.audiofx.BassBoost

import android.content.BroadcastReceiver
import android.content.Intent
import android.media.MediaMetadataRetriever
import android.media.session.MediaController
import android.media.session.MediaSessionManager
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.PluginRegistry


import android.Manifest
import android.content.pm.PackageManager
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat

class MainActivity : FlutterActivity() {
    private val CHANNEL = "your_channel_name_here"
    private lateinit var loudnessEnhancerManager: LoudnessEnhancerManager
    private lateinit var bassBoostManager: BassBoostManager // BassBoost yöneticisi
    private lateinit var musicInfoPlugin: MusicInfoPlugin // Müzik bilgisi eklentisi

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        loudnessEnhancerManager = LoudnessEnhancerManager(getSystemService(Context.AUDIO_SERVICE) as AudioManager)
        bassBoostManager = BassBoostManager(getSystemService(Context.AUDIO_SERVICE) as AudioManager)
        musicInfoPlugin = MusicInfoPlugin(this) // Eklentiyi oluştur

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "disableLoudnessEnhancer") {
                loudnessEnhancerManager.disableLoudnessEnhancer()
                result.success("LoudnessEnhancer disabled")
            } else if (call.method == "setTargetGain") {
                val targetGain = call.argument<Int>("targetGain")
                if (targetGain != null) {
                    loudnessEnhancerManager.setTargetGain(targetGain)
                    result.success("Target gain set to $targetGain")
                } else {
                    result.error("INVALID_ARGUMENT", "Target gain argument missing", null)
                }
            } else if (call.method == "enableBassBoost") { // BassBoost işlevi ekleniyor
                val targetStrength = call.argument<Int>("targetStrength")
                if (targetStrength != null) {
                    bassBoostManager.enableBassBoost(targetStrength.toShort())
                    result.success("BassBoost enabled")
                } else {
                    result.error("INVALID_ARGUMENT", "Target strength argument missing", null)
                }
            } else if (call.method == "disableBassBoost") { // BassBoost işlevi ekleniyor
                bassBoostManager.disableBassBoost()
                result.success("BassBoost disabled")
            } else if (call.method == "getMusicInfo") { // Müzik bilgisi alma işlevi ekleniyor
                val musicInfo = musicInfoPlugin.getMusicInfo()
                if (musicInfo != null) {
                    result.success(musicInfo)
                } else {
                    result.error("MUSIC_NOT_FOUND", "No music is currently playing.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}

@RequiresApi(Build.VERSION_CODES.KITKAT)
class LoudnessEnhancerManager(private val audioManager: AudioManager) {
    private var loudnessEnhancer: LoudnessEnhancer? = null

    fun disableLoudnessEnhancer() {
        loudnessEnhancer!!.enabled = false
        loudnessEnhancer?.release()
        loudnessEnhancer = null
    }

    fun setTargetGain(targetGain: Int) {
        loudnessEnhancer = LoudnessEnhancer(0)
        loudnessEnhancer!!.enabled = true

        loudnessEnhancer?.setTargetGain(targetGain)
    }
}

class BassBoostManager(private val audioManager: AudioManager) {
    private var bassBoost: BassBoost? = null

    fun enableBassBoost(targetStrength: Short) {
        //val audioSessionId = audioManager.generateAudioSessionId()
        bassBoost = BassBoost(0, 0)
        bassBoost?.enabled = true
        bassBoost?.setStrength(targetStrength)
    }

    fun disableBassBoost() {
        bassBoost?.enabled = false
        bassBoost?.release()
        bassBoost = null
    }
}

class MusicInfoPlugin(private val context: Context) {

    fun getMusicInfo(): Map<String, String>? {
        val mediaSessionManager = context.getSystemService(Context.MEDIA_SESSION_SERVICE) as MediaSessionManager
        val mediaController = mediaSessionManager.getActiveSessions(null)

        if (mediaController.isNotEmpty()) {
            val controller = mediaController[0]
            val retriever = MediaMetadataRetriever()

            try {
                 retriever.setDataSource(controller!!.packageName)
                val title = retriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_TITLE) ?: ""
                val artist = retriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_ARTIST) ?: ""
                val album = retriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_ALBUM) ?: ""

                return mapOf(
                    "title" to title,
                    "artist" to artist,
                    "album" to album
                )
            } catch (e: Exception) {
                return null
            }
             finally {
                retriever.release()
            }
        } else {
            return null
        }
    }
}
