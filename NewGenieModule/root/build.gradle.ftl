<#if !(perModuleRepositories??) || perModuleRepositories>
buildscript {
    repositories {
        jcenter()
<#if mavenUrl != "mavenCentral">
        maven {
            url '${mavenUrl}'
        }
</#if>
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:${gradlePluginVersion}'
    }
}
</#if> 
apply plugin: 'com.android.library'
 
<#if !(perModuleRepositories??) || perModuleRepositories>

repositories {
        jcenter()
<#if mavenUrl != "mavenCentral">
        maven {
            url '${mavenUrl}'
        }
</#if>
}
</#if>

android {
    compileSdkVersion rootProject.ext.compileSdkVersion
    buildToolsVersion rootProject.ext.buildToolsVersion

    defaultConfig {  
        minSdkVersion rootProject.ext.minSdkVersion
        targetSdkVersion rootProject.ext.targetSdkVersion
        versionCode rootProject.ext.versionCode
        versionName rootProject.ext.versionName
    }
<#if javaVersion?? && (javaVersion != "1.6" && buildApi lt 21 || javaVersion != "1.7")>

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_${javaVersion?replace('.','_','i')}
        targetCompatibility JavaVersion.VERSION_${javaVersion?replace('.','_','i')}
    }
</#if>
<#if enableProGuard>
    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }
</#if>
} 


task info {
    group 'Modular'
    description 'Modular Build.Gradle Description Set'

    doFirst {
        println "CompileSdkVersion :" +rootProject.ext.compileSdkVersion
        println "BuildToolsVersion :" +rootProject.ext.buildToolsVersion
        println "MinSdk Version :" + rootProject.ext.minSdkVersion
        println "TargetSdkVersion :" + rootProject.ext.targetSdkVersion
        println "VersionCode :" +rootProject.ext.versionCode
        println "VersionNae :" +rootProject.ext.versionName
    }
    doLast {
        println ''
    }
}


dependencies {
    <#if dependencyList?? >
    <#list dependencyList as dependency>
    compile '${dependency}'
    </#list>
    </#if> 
    compile 'com.android.support:appcompat-v7:${buildApi}.+'
    compile fileTree(dir: 'libs', include: ['*.jar'])
 
<#if unitTestsSupported>
    testCompile 'junit:junit:${junitVersion}' 
    testCompile 'org.robolectric:robolectric:3.1.1'      
    androidTestCompile ('com.android.support.test.espresso:espresso-core:2.2') {
        exclude group: 'com.android.support', module: 'support-annotations'
    }

    androidTestCompile ('com.android.support.test:runner:0.3') {
        exclude group: 'com.android.support', module: 'support-annotations'
    }
    androidTestCompile ('com.android.support.test:rules:0.3') {
        exclude group: 'com.android.support', module: 'support-annotations'
    }

</#if>
}
