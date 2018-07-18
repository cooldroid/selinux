LOCAL_PATH:= $(call my-dir)

libselinux_src_files := \
  libselinux/src/audit2why.c \
  libselinux/src/avc.c \
  libselinux/src/avc_internal.c \
  libselinux/src/avc_sidtab.c \
  libselinux/src/booleans.c \
  libselinux/src/callbacks.c \
  libselinux/src/canonicalize_context.c \
  libselinux/src/checkAccess.c \
  libselinux/src/check_context.c \
  libselinux/src/checkreqprot.c \
  libselinux/src/compute_av.c \
  libselinux/src/compute_create.c \
  libselinux/src/compute_member.c \
  libselinux/src/compute_relabel.c \
  libselinux/src/compute_user.c \
  libselinux/src/context.c \
  libselinux/src/deny_unknown.c \
  libselinux/src/disable.c \
  libselinux/src/enabled.c \
  libselinux/src/fgetfilecon.c \
  libselinux/src/freecon.c \
  libselinux/src/freeconary.c \
  libselinux/src/fsetfilecon.c \
  libselinux/src/get_context_list.c \
  libselinux/src/get_default_type.c \
  libselinux/src/get_initial_context.c \
  libselinux/src/getenforce.c \
  libselinux/src/getfilecon.c \
  libselinux/src/getpeercon.c \
  libselinux/src/init.c \
  libselinux/src/is_customizable_type.c \
  libselinux/src/label.c \
  libselinux/src/label_backends_android.c \
  libselinux/src/label_db.c \
  libselinux/src/label_file.c \
  libselinux/src/label_media.c \
  libselinux/src/label_support.c \
  libselinux/src/label_x.c \
  libselinux/src/lgetfilecon.c \
  libselinux/src/load_policy.c \
  libselinux/src/lsetfilecon.c \
  libselinux/src/mapping.c \
  libselinux/src/matchmediacon.c \
  libselinux/src/matchpathcon.c \
  libselinux/src/policyvers.c \
  libselinux/src/procattr.c \
  libselinux/src/query_user_context.c \
  libselinux/src/regex.c \
  libselinux/src/selinux_check_securetty_context.c \
  libselinux/src/selinux_config.c \
  libselinux/src/selinux_restorecon.c \
  libselinux/src/sestatus.c \
  libselinux/src/setenforce.c \
  libselinux/src/setexecfilecon.c \
  libselinux/src/setfilecon.c \
  libselinux/src/setrans_client.c \
  libselinux/src/seusers.c \
  libselinux/src/sha1.c \
  libselinux/src/stringrep.c

libselinux_android_srcs := \
  libselinux/src/android/android.c \
  libselinux/src/android/android_host.c \

libpcre2_src_files := \
  pcre/dist2/src/pcre2_auto_possess.c \
  pcre/dist2/src/pcre2_compile.c \
  pcre/dist2/src/pcre2_config.c \
  pcre/dist2/src/pcre2_context.c \
  pcre/dist2/src/pcre2_dfa_match.c \
  pcre/dist2/src/pcre2_error.c \
  pcre/dist2/src/pcre2_find_bracket.c \
  pcre/dist2/src/pcre2_maketables.c \
  pcre/dist2/src/pcre2_match.c \
  pcre/dist2/src/pcre2_match_data.c \
  pcre/dist2/src/pcre2_jit_compile.c \
  pcre/dist2/src/pcre2_newline.c \
  pcre/dist2/src/pcre2_ord2utf.c \
  pcre/dist2/src/pcre2_pattern_info.c \
  pcre/dist2/src/pcre2_serialize.c \
  pcre/dist2/src/pcre2_string_utils.c \
  pcre/dist2/src/pcre2_study.c \
  pcre/dist2/src/pcre2_substitute.c \
  pcre/dist2/src/pcre2_substring.c \
  pcre/dist2/src/pcre2_tables.c \
  pcre/dist2/src/pcre2_ucd.c \
  pcre/dist2/src/pcre2_valid_utf.c \
  pcre/dist2/src/pcre2_xclass.c \
  pcre/dist2/src/pcre2_chartables.c


common_cflags := \
  -Wall -W -Wundef \
  -Wshadow -Wmissing-noreturn \
  -Wmissing-format-attribute \
  -Wno-implicit-function-declaration -Wno-undef \
  -Wno-suggest-attribute=noreturn -Wno-unused-function \
  -Wno-unused-but-set-variable \
  -std=gnu99 -O2 -fpic -fPIC \
  -pipe -fno-strict-aliasing \
  -D_GNU_SOURCE  \
  -D__BIONIC__ -DANDROID \
  -D__ANDROID__


common_ldlibs := \
  -lc

common_includes := \
  $(LOCAL_PATH)/include \
  $(LOCAL_PATH)/checkpolicy/ \
  $(LOCAL_PATH)/libsepol/include/ \
  $(LOCAL_PATH)/libsepol/src/ \
  $(LOCAL_PATH)/pcre/dist2 \
  $(LOCAL_PATH)/pcre/include_internal \
  $(LOCAL_PATH)/pcre/include \
  $(LOCAL_PATH)/libpcre/dist \
  $(LOCAL_PATH)/libselinux/src \
  $(LOCAL_PATH)/libselinux/include \
  $(LOCAL_PATH)/libselinux/include/selinux \
  /usr/include/python2.7 \
  /usr/include/python3.* \
  /usr/local/include

yacc_flags := -x c -std=gnu89

FIND_HOSTOS := $(shell uname -s)
HOST_NAME := $(shell echo $(FIND_HOSTOS) |sed -e s/L/l/ |sed -e s/D/d/ |sed s/W/w/ )

mkdir-android := $(shell mkdir -vp $(addprefix $(LOCAL_PATH)/libselinux/src/, android))
mkdir-include := $(shell mkdir -vp $(addprefix $(LOCAL_PATH)/include/, openssl private))

include-common-exists := $(shell test -f $(LOCAL_PATH)/include/android/log.h || echo "true")
ifdef include-common-exists
  get-openssl := $(shell wget -qO - "https://android.googlesource.com/platform/external/boringssl/+archive/master/src/include/openssl.tar.gz" -O - | tar -xz -C $(LOCAL_PATH)/include/openssl)
  get-private := $(shell wget -qO - "https://android.googlesource.com/platform/system/core/+archive/master/libcutils/include/private.tar.gz" -O - | tar -xz -C $(LOCAL_PATH)/include/private)
  get-log := $(shell wget -qO - "https://android.googlesource.com/platform/system/core/+archive/master/liblog/include.tar.gz" -O - | tar -xz -C $(LOCAL_PATH)/include)
else
  get-openssl :=
  get-private :=
  get-log :=
endif

include-android-exists := $(shell test -f $(LOCAL_PATH)/libselinux/src/android/android.c || echo "true")
ifdef include-android-exists
  cmds := \
    $(shell wget -qO - "https://android.googlesource.com/platform/external/selinux/+/master/libselinux/include/selinux/android.h?format=text" | \
    base64 -d > $(LOCAL_PATH)/libselinux/include/selinux/android.h) \
    $(shell wget -qO - "https://android.googlesource.com/platform/external/selinux/+/master/libselinux/src/android/android.c?format=text" | \
    base64 -d >  $(LOCAL_PATH)/libselinux/src/android/android.c) \
    $(shell wget -qO - "https://android.googlesource.com/platform/external/selinux/+/master/libselinux/src/android/android_common.h?format=text" | \
    base64 -d >  $(LOCAL_PATH)/libselinux/src/android/android_common.h) \
    $(shell wget -qO - "https://android.googlesource.com/platform/external/selinux/+/master/libselinux/src/android/android_host.c?format=text" | \
    base64 -d >  $(LOCAL_PATH)/libselinux/src/android/android_host.c)
else
  cmds :=
endif


libselinux_prepare := $(mkdir-android) $(mkdir-include) $(get-openssl) $(get-private) $(get-log) $(cmds)

##
# libpcre2.a
#
include $(CLEAR_VARS)

LOCAL_MODULE := libpcre2
LOCAL_CFLAGS += -DHAVE_CONFIG_H
LOCAL_C_INCLUDES := $(common_includes)
LOCAL_SRC_FILES := $(libpcre2_src_files)
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)

include $(BUILD_STATIC_LIBRARY)

##
# libselinux_static
#
include $(CLEAR_VARS)

LOCAL_MODULE := libselinux_static
LOCAL_MODULE_TAGS := optional
LOCAL_WHOLE_STATIC_LIBRARIES := libpcre2
LOCAL_CFLAGS := -std=gnu89 -DAUDITD_LOG_TAG=1003 -DUSE_PCRE2 $(common_cflags)
LOCAL_STATIC_LIBRARIES := libpcre2
LOCAL_C_INCLUDES := $(common_includes)
LOCAL_SRC_FILES := $(libselinux_prepare) $(libselinux_src_files) $(libselinux_android_srcs)

include $(BUILD_STATIC_LIBRARY)
