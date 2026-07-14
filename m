Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992B64657DA
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034520; cv=none; b=N245tYBadvLA+KdJO7CzIkXUD6uLDuDtoPTn379i5fH2r58OFBahcTRYHvdfa0hxPyjygY04DxSSJT+vDAgnpDRJGNmXrx09CHlXYFrCG5x2ZxTsOvTNqLoff8T9z7kFc1xiZuWHNpcqcUHuPrSi/EnadITrjBvV2TZSaCcJ+Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034520; c=relaxed/simple;
	bh=5Y43Y7fyHYZyPGuirU3OoYI1Mwv1k+B9YukPppo9vUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+gMfxbmywpFOh7J2xT59xfqwoPg/UkXtTB7rBwALMp4w6aGsboPme9Fo3Zc2WZx91Dbh2haGreoZiPGb2dytbsL9QXJZ7LDd2U/cZHABjcTLCIslFErefRNy4XDez38uWJZRcwuqv2PlFAW71+nSZ6zN3+RrIR8MArX7AF0ALs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VkGMaTA2; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VkGMaTA2"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7eb3865ea6fso2901564a34.2
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 06:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784034517; x=1784639317; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=emzLt0cm2On/W2Ip4YweG2bRFCgDp+q5PQrHqypf35c=;
        b=VkGMaTA2VzeEeceepVLG8XfB8LapMOf8VkJJL4SC1YKRGKfDLhQfHEBbeY3lAD83hD
         3OHoBXEr6bDhilCfn7jApYnFm3xg6IAk0Ym4qX0/ICJ137g5sJ6lxIKsD9JJtA7cXYVQ
         gg/JFmjWR9WWDWvYvXbc6fhNNkx2Zmn8lhJo8TM5UzwZiW9gJasFPdp+P4s6OUm1eNbu
         MCx5FZWfYTqLKUECa5Zs9hqmc5haIcgJv/SCeGeZzy1Hp4lGAJfqjpZiQ7nfjkee8jIw
         qVLQs0uHq+WMO9TDBLlNx37/QWN1YGzZOhQPbp8j9ge7QuUXu2mAcJb+KDkNTrGadc2P
         Hicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784034517; x=1784639317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=emzLt0cm2On/W2Ip4YweG2bRFCgDp+q5PQrHqypf35c=;
        b=MZ8S6+dOH0hsTCLs0PUif70xv2i4CRG7DrAQ6GqNReWjxR5NAhDgJMRh6Xxo0Fvq1j
         tPaY0OSTVfUCTJ31tHMAH74t+3sIPpJwJpQkc5PDN/gEA8wDP9bKTRRIRj8f4uzyLQY9
         0j4FHkZKL1VA4NQGdYZIu3Htk29BTTYTFkAdiDzJR+PcOJ1vjpKGDyMJN61sqWL47LqU
         3I5j1q11N1eQaVBq+flSGRKa1VyXwvZsrqZcMb0b5FF1Cz2uq+UqlxL4E9w2byVGCSJe
         4LRfZFE5Pi2+f0mvzeahhWzmV2lUuyFokLC/k2ADUldsajIhHQEjN01KCytZOQJpoZQu
         74uw==
X-Forwarded-Encrypted: i=1; AFNElJ9sHLAAVoELQCjc6xWv3PLgsKhsfHIpAjLhAmn/JAcFzMgfsbpUkdAhYj8U6J/FoPSxWAa7HQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy31dMEtdvDjdy7TIOdIxRjogiyDrlQ4Pir/p8c1N0kqKg3uzLA
	UV0rCLxnxISl0EnDfTSVqzkwzqVPc9Xdr0sNWiA9UmWjsy3FrUEqnH8SgOO1RseMbgE=
X-Gm-Gg: AfdE7cmIR/pskXaXd3zikS3h+/HEs3Dk9bfS+fCh72ky/ilYXShhW4+VC2PCahHAz+Y
	X+/Z1AtRCOdP4oH3BUd4oo1/cdl0kjc9elDnjcbPSUpbaYM518lS/5zvuOAEDosGqPZSvb3NEb6
	R3ZTnbsqQsDdHJh/Xcrzy3DyOODtdDeBDLHd6Cq4TiDwjtr6nNglZL9qmoVeRzx8sx/uxBYkK1c
	8UrgVDrZELIhUdOVv0wX/ktQNcOWdD3IGRJpiG1UBZQ6WYnsbIvK7r8qpW+lYPfPD4D8OT4Htgw
	hx4nwRW12U2mBA7daC5OhxndZjUYo5eCKhddK5x3LQ+C17Q3vUVB5IYkVeAkvBTR92ZpcTU5IlQ
	zHcZ11ZCdIqCzGfPx+2+3xIXWe5XoX4wDa3+OWaDi334nzCnWS4JigXfXP04nszwB2SyoS6cSbZ
	ADpHs2w5gBDMNCjE2wp13R+KkVxWTHSwzr1PHBuabqFLSGCUzB31YTtAxvh2tqEw==
X-Received: by 2002:a05:6830:4884:b0:7e9:b537:102c with SMTP id 46e09a7af769-7ec4239b1acmr2074489a34.25.1784034516373;
        Tue, 14 Jul 2026 06:08:36 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([178.93.176.7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcab8efc3sm14657738a34.0.2026.07.14.06.08.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 06:08:35 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: joro@8bytes.org,
	palmer@dabbelt.com,
	tony.luck@intel.com,
	reinette.chatre@intel.com,
	tomasz.jeznach@linux.dev
Cc: will@kernel.org,
	robin.murphy@arm.com,
	fustini@kernel.org,
	pjw@kernel.org,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	Dave.Martin@arm.com,
	james.morse@arm.com,
	babu.moger@amd.com,
	corbet@lwn.net,
	shuah@kernel.org,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	cuiyunhui@bytedance.com,
	yuanzhu@bytedance.com,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: [RFC PATCH 7/7] selftests/iommu: Add RISC-V IOMMU QoS smoke test
Date: Tue, 14 Jul 2026 21:06:57 +0800
Message-ID: <20260714130657.46963-8-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com>
References: <20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a RISC-V IOMMU QoS smoke test for the resctrl devices assignment ABI
and the per-IOMMU global qosid sysfs attribute.

Probe for a usable IOMMU group with a non-default child-group assignment
without disturbing groups already assigned by the system. Cover valid
assignment and reset, devices-file readback, malformed and missing group
IDs, strict decimal parsing, tasks-file rejection, group removal and
pseudo-lock protection, and cleanup before child-group removal.

When the global qosid attribute is present, cover its readback format,
valid rewrite and restore, malformed input, missing separators, range
checking, and integer overflow. Keep child-group coverage optional so an
environment without allocatable resctrl resources can still exercise
the root IOMMU QoS paths.

Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/iommu/Makefile        |   2 +
 .../selftests/iommu/iommu_qos_smoke.sh        | 649 ++++++++++++++++++
 3 files changed, 652 insertions(+)
 create mode 100755 tools/testing/selftests/iommu/iommu_qos_smoke.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 162ad5a1780f..9facf8ac79a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23289,6 +23289,7 @@ L:	linux-riscv@lists.infradead.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-class-iommu-riscv-iommu
 F:	drivers/resctrl/cbqri_iommu.c
+F:	tools/testing/selftests/iommu/iommu_qos_smoke.sh
 
 RISC-V MICROCHIP SUPPORT
 M:	Conor Dooley <conor.dooley@microchip.com>
diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
index 84abeb2f0949..2d22a10c17fc 100644
--- a/tools/testing/selftests/iommu/Makefile
+++ b/tools/testing/selftests/iommu/Makefile
@@ -7,4 +7,6 @@ TEST_GEN_PROGS :=
 TEST_GEN_PROGS += iommufd
 TEST_GEN_PROGS += iommufd_fail_nth
 
+TEST_PROGS += iommu_qos_smoke.sh
+
 include ../lib.mk
diff --git a/tools/testing/selftests/iommu/iommu_qos_smoke.sh b/tools/testing/selftests/iommu/iommu_qos_smoke.sh
new file mode 100755
index 000000000000..1a81bca39460
--- /dev/null
+++ b/tools/testing/selftests/iommu/iommu_qos_smoke.sh
@@ -0,0 +1,649 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-only
+# Smoke test for RISC-V IOMMU QoS resctrl integration.
+#
+# This intentionally tests the IOMMU group QoS control path:
+#   resctrl/devices -> iommu_group:<id> parser -> IOMMU group QoS assignment
+#   explicit reset to the default group before resctrl group removal
+# and the per-IOMMU global default QoS ID sysfs path used by BARE mode.
+
+KSFT_PASS=0
+KSFT_FAIL=1
+KSFT_SKIP=4
+
+RESCTRL=/sys/fs/resctrl
+RESCTRL_FS=resctrl
+IOMMU_GROUPS=/sys/kernel/iommu_groups
+LAST_STATUS=$RESCTRL/info/last_cmd_status
+ROOT_DEVICES=$RESCTRL/devices
+IOMMU_CLASS=/sys/class/iommu
+
+pass_count=0
+fail_count=0
+skip_count=0
+group=""
+child_group=""
+qosid_file=""
+tmp_dir=""
+lock_dir=""
+lock_taken=0
+mounted_by_test=0
+qosid_rcid=""
+qosid_mcid=""
+
+log()
+{
+	printf '%s\n' "$*"
+}
+
+pass()
+{
+	pass_count=$((pass_count + 1))
+	log "PASS: $*"
+}
+
+fail()
+{
+	fail_count=$((fail_count + 1))
+	log "FAIL: $*"
+}
+
+skip()
+{
+	log "SKIP: $*"
+	exit $KSFT_SKIP
+}
+
+skip_optional()
+{
+	skip_count=$((skip_count + 1))
+	log "SKIP: $*"
+}
+
+cleanup()
+{
+	if [ -n "$child_group" ] && [ -d "$child_group" ]; then
+		if [ -n "$group" ]; then
+			printf '%s\n' "iommu_group:$group" > "$ROOT_DEVICES" 2>/dev/null || true
+		fi
+		rmdir "$child_group" 2>/dev/null || true
+	fi
+
+	if [ "$mounted_by_test" = "1" ]; then
+		umount "$RESCTRL" 2>/dev/null || true
+	fi
+
+	if [ "$lock_taken" = "1" ] && [ -n "$lock_dir" ]; then
+		rmdir "$lock_dir" 2>/dev/null || true
+	fi
+
+	if [ -n "$tmp_dir" ]; then
+		rm -rf "$tmp_dir"
+	fi
+}
+
+need_root()
+{
+	[ "$(id -u)" = "0" ] || skip "requires root"
+}
+
+init_tmp_dir()
+{
+	tmp_dir=$(mktemp -d "${TMPDIR:-/tmp}/iommu_qos_smoke.XXXXXX") ||
+		skip "failed to create temporary directory"
+}
+
+take_global_lock()
+{
+	lock_dir=${TMPDIR:-/tmp}/iommu_qos_smoke.lock
+
+	if mkdir "$lock_dir" 2>"$tmp_dir/lock.err"; then
+		lock_taken=1
+		pass "acquired global IOMMU QoS test lock"
+		return
+	fi
+
+	skip "another IOMMU QoS smoke test instance is running"
+}
+
+ensure_resctrl_mounted()
+{
+	if ! grep -qw resctrl /proc/filesystems; then
+		skip "resctrl filesystem is not available"
+	fi
+
+	mkdir -p "$RESCTRL" 2>/dev/null || true
+
+	if grep -qs " $RESCTRL resctrl " /proc/mounts; then
+		pass "resctrl already mounted"
+		return
+	fi
+
+	if mount -t resctrl "$RESCTRL_FS" "$RESCTRL" 2>"$tmp_dir/mount.err"; then
+		mounted_by_test=1
+		pass "mounted resctrl"
+	else
+		log "mount error: $(cat "$tmp_dir/mount.err" 2>/dev/null)"
+		skip "failed to mount resctrl"
+	fi
+}
+
+ensure_devices_file()
+{
+	[ -e "$ROOT_DEVICES" ] || skip "resctrl devices file is not available"
+	[ -w "$ROOT_DEVICES" ] || skip "$ROOT_DEVICES is not writable"
+}
+
+create_child_group()
+{
+	child_group=$RESCTRL/iommu_qos_test_$$
+
+	if mkdir "$child_group" 2>"$tmp_dir/mkdir.err"; then
+		pass "created child resctrl group"
+		return
+	fi
+
+	log "mkdir error: $(cat "$tmp_dir/mkdir.err" 2>/dev/null)"
+	child_group=""
+	skip "failed to create a child resctrl group"
+}
+
+iommu_group_is_assigned()
+{
+	candidate=$1
+
+	find "$RESCTRL" -type f -name devices \
+		-exec grep -qx "iommu_group:$candidate" {} \; -print \
+		2>/dev/null | grep -q .
+}
+
+pick_iommu_group()
+{
+	populated=0
+	unsupported=0
+
+	[ -d "$IOMMU_GROUPS" ] || skip "no IOMMU groups sysfs directory"
+
+	for path in "$IOMMU_GROUPS"/*; do
+		[ -d "$path" ] || continue
+		case "${path##*/}" in
+		*[!0-9]*|'')
+			continue
+			;;
+		esac
+
+		[ -d "$path/devices" ] || continue
+		if ! find "$path/devices" -mindepth 1 -maxdepth 1 2>/dev/null |
+			grep -q .; then
+			continue
+		fi
+
+		populated=$((populated + 1))
+		candidate=${path##*/}
+		if iommu_group_is_assigned "$candidate"; then
+			log "skip IOMMU group $candidate with an existing resctrl assignment"
+			continue
+		fi
+
+		if printf '%s\n' "iommu_group:$candidate" > "$child_group/devices" \
+				2>"$tmp_dir/group_$candidate.err"; then
+			group=$candidate
+			if ! printf '%s\n' "iommu_group:$group" > "$ROOT_DEVICES" \
+					2>"$tmp_dir/group_${candidate}_reset.err"; then
+				log "reset error:"
+				cat "$tmp_dir/group_${candidate}_reset.err" 2>/dev/null
+				fail "failed to restore probed IOMMU group $group"
+				return 1
+			fi
+			pass "selected group $group using non-default QoS assignment"
+			return 0
+		fi
+
+		if last_status_is_iommu_qos_unsupported; then
+			unsupported=$((unsupported + 1))
+			continue
+		fi
+
+		log "group $candidate write error:"
+		cat "$tmp_dir/group_$candidate.err" 2>/dev/null
+		log "last_cmd_status: $(cat "$LAST_STATUS" 2>/dev/null)"
+		fail "IOMMU group $candidate failed QoS capability probing"
+	done
+
+	[ "$populated" -gt 0 ] || skip "no populated IOMMU group found"
+	if [ "$unsupported" -eq "$populated" ]; then
+		skip "no populated IOMMU group supports QoS ID programming"
+	fi
+
+	return 1
+}
+
+last_status_contains()
+{
+	pattern=$1
+
+	[ -f "$LAST_STATUS" ] || return 1
+	grep -qi "$pattern" "$LAST_STATUS"
+}
+
+last_status_is_iommu_qos_unsupported()
+{
+	[ -f "$LAST_STATUS" ] || return 1
+	grep -Eiq \
+		'IOMMU group .* QoS \(-95\)|IOMMU QoSID.*not supported|not supported' \
+		"$LAST_STATUS"
+}
+
+pick_missing_iommu_group()
+{
+	max=0
+
+	for path in "$IOMMU_GROUPS"/*; do
+		[ -d "$path" ] || continue
+		id=${path##*/}
+		case "$id" in
+		*[!0-9]*|'')
+			continue
+			;;
+		esac
+		if [ "$id" -gt "$max" ]; then
+			max=$id
+		fi
+	done
+
+	if [ "$max" -ge 2147483647 ]; then
+		skip "cannot choose a missing IOMMU group id"
+	fi
+
+	missing=$((max + 1))
+	while [ -e "$IOMMU_GROUPS/$missing" ]; do
+		if [ "$missing" -ge 2147483647 ]; then
+			skip "cannot choose a missing IOMMU group id"
+		fi
+		missing=$((missing + 1))
+	done
+}
+
+pick_qosid_file()
+{
+	for file in "$IOMMU_CLASS"/*/qosid; do
+		[ -e "$file" ] || continue
+		qosid_file=$file
+		return 0
+	done
+
+	return 1
+}
+
+parse_qosid()
+{
+	line=$1
+
+	case "$line" in
+	rcid=[0-9]*" "mcid=[0-9]*)
+		qosid_rcid=${line%% *}
+		qosid_rcid=${qosid_rcid#rcid=}
+		qosid_mcid=${line##* }
+		qosid_mcid=${qosid_mcid#mcid=}
+		;;
+	*)
+		return 1
+		;;
+	esac
+
+	case "$qosid_rcid" in
+	*[!0-9]*|'')
+		return 1
+		;;
+	esac
+	case "$qosid_mcid" in
+	*[!0-9]*|'')
+		return 1
+		;;
+	esac
+
+	return 0
+}
+
+test_malformed_group_rejected()
+{
+	if printf '%s\n' 'iommu_group:bad' > "$ROOT_DEVICES" \
+			2>"$tmp_dir/badtoken.err"; then
+		fail "malformed IOMMU group token was accepted"
+		return
+	fi
+
+	if last_status_contains "IOMMU group parsing error"; then
+		pass "malformed IOMMU group token is rejected with useful status"
+	else
+		log "last_cmd_status: $(cat "$LAST_STATUS" 2>/dev/null)"
+		fail "malformed IOMMU group rejection status is unclear"
+	fi
+}
+
+test_trailing_separator_rejected()
+{
+	if printf '%s\n' "iommu_group:$group," > "$ROOT_DEVICES" \
+			2>"$tmp_dir/trailing_separator.err"; then
+		fail "IOMMU group token with trailing separator was accepted"
+		return
+	fi
+
+	if last_status_contains "Device list parsing error"; then
+		pass "trailing device-list separator is rejected"
+	else
+		log "last_cmd_status: $(cat "$LAST_STATUS" 2>/dev/null)"
+		fail "trailing separator rejection status is unclear"
+	fi
+}
+
+test_missing_group_rejected()
+{
+	pick_missing_iommu_group
+
+	if printf '%s\n' "iommu_group:$missing" > "$ROOT_DEVICES" \
+			2>"$tmp_dir/missing.err"; then
+		fail "missing IOMMU group was accepted"
+		return
+	fi
+
+	if last_status_contains "No IOMMU group $missing"; then
+		pass "missing IOMMU group is rejected with useful status"
+	else
+		log "last_cmd_status: $(cat "$LAST_STATUS" 2>/dev/null)"
+		fail "missing IOMMU group rejection status is unclear"
+	fi
+}
+
+test_non_decimal_group_rejected()
+{
+	if printf '%s\n' "iommu_group:0x$group" > "$ROOT_DEVICES" \
+			2>"$tmp_dir/non_decimal.err"; then
+		fail "non-decimal IOMMU group ID was accepted"
+		return
+	fi
+
+	if last_status_contains "IOMMU group parsing error"; then
+		pass "non-decimal IOMMU group ID is rejected"
+	else
+		log "last_cmd_status: $(cat "$LAST_STATUS" 2>/dev/null)"
+		fail "non-decimal IOMMU group rejection status is unclear"
+	fi
+}
+
+test_tasks_rejects_iommu_token()
+{
+	if printf '%s\n' "iommu_group:$group" > "$RESCTRL/tasks" \
+			2>"$tmp_dir/tasks_token.err"; then
+		fail "tasks accepted an IOMMU group token"
+		return
+	fi
+
+	if last_status_contains "Task list parsing error pid iommu_group:$group"; then
+		pass "tasks rejects IOMMU group tokens"
+	else
+		log "last_cmd_status: $(cat "$LAST_STATUS" 2>/dev/null)"
+		fail "tasks rejection status is unclear"
+	fi
+}
+
+test_global_qosid_sysfs()
+{
+	if ! pick_qosid_file; then
+		skip_optional "no RISC-V IOMMU qosid sysfs file is available"
+		return
+	fi
+
+	if ! line=$(cat "$qosid_file" 2>"$tmp_dir/qosid_read.err"); then
+		log "read error: $(cat "$tmp_dir/qosid_read.err" 2>/dev/null)"
+		fail "failed to read IOMMU global qosid"
+		return
+	fi
+
+	if parse_qosid "$line"; then
+		pass "read IOMMU global qosid from sysfs"
+	else
+		log "qosid content: $line"
+		fail "IOMMU global qosid has unexpected format"
+		return
+	fi
+
+	if printf '%s\n' "$line" > "$qosid_file" \
+			2>"$tmp_dir/qosid_rewrite.err"; then
+		pass "IOMMU global qosid accepts readback format"
+	else
+		log "write error: $(cat "$tmp_dir/qosid_rewrite.err" 2>/dev/null)"
+		fail "failed to rewrite IOMMU global qosid readback"
+		return
+	fi
+
+	if printf '%s\n' "bad" > "$qosid_file" 2>"$tmp_dir/qosid_bad.err"; then
+		fail "IOMMU global qosid accepted malformed input"
+		return
+	fi
+	pass "IOMMU global qosid rejects malformed input"
+
+	if printf '%s\n' "rcid=0mcid=1" > "$qosid_file" \
+			2>"$tmp_dir/qosid_separator.err"; then
+		fail "IOMMU global qosid accepted missing token separator"
+		return
+	fi
+	pass "IOMMU global qosid requires a token separator"
+
+	if printf '%s\n' "rcid=4096 mcid=0" > "$qosid_file" \
+			2>"$tmp_dir/qosid_range.err"; then
+		fail "IOMMU global qosid accepted out-of-range RCID"
+		return
+	fi
+	pass "IOMMU global qosid rejects out-of-range RCID"
+
+	if printf '%s\n' "rcid=4294967296 mcid=0" > "$qosid_file" \
+			2>"$tmp_dir/qosid_overflow.err"; then
+		fail "IOMMU global qosid accepted overflowed RCID"
+		return
+	fi
+	pass "IOMMU global qosid rejects overflowed RCID"
+
+	if printf '%s\n' "rcid=$qosid_rcid mcid=$qosid_mcid" > "$qosid_file" \
+			2>"$tmp_dir/qosid_restore.err"; then
+		pass "IOMMU global qosid accepts current RCID/MCID"
+	else
+		log "write error: $(cat "$tmp_dir/qosid_restore.err" 2>/dev/null)"
+		fail "failed to write current IOMMU global qosid"
+		return
+	fi
+
+	if line=$(cat "$qosid_file" 2>/dev/null) &&
+			[ "$line" = "rcid=$qosid_rcid mcid=$qosid_mcid" ]; then
+		pass "IOMMU global qosid readback matches restored value"
+	else
+		log "qosid content: $line"
+		fail "IOMMU global qosid readback mismatch"
+	fi
+}
+
+test_valid_group_write()
+{
+	if printf '%s\n' "iommu_group:$group" > "$ROOT_DEVICES" \
+		2>"$tmp_dir/valid.err"; then
+		pass "write iommu_group:$group to root resctrl devices"
+	else
+		log "write error: $(cat "$tmp_dir/valid.err" 2>/dev/null)"
+		fail "valid IOMMU group write failed"
+		return
+	fi
+
+	if last_status_contains ^ok; then
+		pass "last_cmd_status reports ok"
+	else
+		log "last_cmd_status: $(cat "$LAST_STATUS" 2>/dev/null)"
+		fail "last_cmd_status is not ok after valid write"
+	fi
+
+	# The root control group represents the default QoS IDs. The kernel
+	# applies the reset but intentionally does not keep a software binding
+	# for default assignments, so the root devices file should stay empty.
+	if grep -qx "iommu_group:$group" "$ROOT_DEVICES"; then
+		log "devices content:"
+		cat "$ROOT_DEVICES" 2>/dev/null
+		fail "root devices unexpectedly shows default iommu_group:$group"
+	else
+		pass "root devices omits default iommu_group:$group"
+	fi
+
+}
+
+test_child_group_write()
+{
+	if printf '%s\n' "iommu_group:$group" > "$child_group/devices" \
+			2>"$tmp_dir/child.err"; then
+		pass "write iommu_group:$group to child resctrl group"
+	else
+		log "write error: $(cat "$tmp_dir/child.err" 2>/dev/null)"
+		fail "valid child IOMMU group write failed"
+		return
+	fi
+
+	if last_status_contains ^ok; then
+		pass "last_cmd_status reports ok after child group write"
+	else
+		log "last_cmd_status: $(cat "$LAST_STATUS" 2>/dev/null)"
+		fail "last_cmd_status is not ok after child group write"
+	fi
+
+	if grep -qx "iommu_group:$group" "$child_group/devices"; then
+		pass "child devices shows iommu_group:$group after set/get"
+	else
+		log "child devices content:"
+		cat "$child_group/devices" 2>/dev/null
+		fail "child devices does not show iommu_group:$group"
+	fi
+
+	if grep -qx "iommu_group:$group" "$ROOT_DEVICES"; then
+		log "root devices content:"
+		cat "$ROOT_DEVICES" 2>/dev/null
+		fail "root devices still shows iommu_group:$group after child move"
+	else
+		pass "root devices no longer shows iommu_group:$group after child move"
+	fi
+
+}
+
+test_child_pseudo_locksetup_rejected()
+{
+	[ -d "$child_group" ] || return
+
+	if [ ! -e "$child_group/mode" ]; then
+		skip_optional "resctrl mode file is not available"
+		return
+	fi
+
+	if printf '%s\n' "pseudo-locksetup" > "$child_group/mode" \
+			2>"$tmp_dir/pseudo_locksetup.err"; then
+		printf '%s\n' "shareable" > "$child_group/mode" 2>/dev/null || true
+		fail "pseudo-locksetup accepted a group with assigned devices"
+		return
+	fi
+
+	if last_status_contains \
+			"Move devices out before entering pseudo-locksetup group"; then
+		pass "pseudo-locksetup rejects group with assigned devices"
+	elif last_status_contains "Unknown or unsupported mode"; then
+		skip_optional "pseudo-locksetup mode is not supported"
+	else
+		log "last_cmd_status: $(cat "$LAST_STATUS" 2>/dev/null)"
+		fail "pseudo-locksetup rejection status is unclear"
+	fi
+}
+
+test_child_group_rmdir()
+{
+	[ -d "$child_group" ] || return
+
+	if rmdir "$child_group" 2>"$tmp_dir/rmdir_busy.err"; then
+		fail "rmdir child resctrl group with IOMMU group was accepted"
+		# The child group no longer exists, so cleanup() cannot reset this.
+		if ! printf '%s\n' "iommu_group:$group" > "$ROOT_DEVICES" \
+				2>"$tmp_dir/rmdir_unexpected_move_root.err"; then
+			log "move error after unexpected rmdir:"
+			cat "$tmp_dir/rmdir_unexpected_move_root.err" 2>/dev/null
+		fi
+		child_group=""
+		return
+	fi
+
+	if last_status_contains "Move devices out before removing group"; then
+		pass "rmdir rejects child group while IOMMU group is assigned"
+	else
+		log "last_cmd_status: $(cat "$LAST_STATUS" 2>/dev/null)"
+		fail "rmdir rejection status is unclear"
+	fi
+
+	if printf '%s\n' "iommu_group:$group" > "$ROOT_DEVICES" \
+			2>"$tmp_dir/rmdir_move_root.err"; then
+		pass "move iommu_group:$group back to root before rmdir"
+	else
+		log "move error: $(cat "$tmp_dir/rmdir_move_root.err" 2>/dev/null)"
+		fail "failed to move iommu_group:$group back to root"
+		return
+	fi
+
+	if rmdir "$child_group" 2>"$tmp_dir/rmdir.err"; then
+		pass "rmdir child resctrl group after moving IOMMU group out"
+	else
+		log "rmdir error: $(cat "$tmp_dir/rmdir.err" 2>/dev/null)"
+		fail "failed to rmdir child resctrl group after moving IOMMU group out"
+		return
+	fi
+	child_group=""
+
+	if last_status_contains ^ok; then
+		pass "last_cmd_status reports ok after child group rmdir"
+	else
+		log "last_cmd_status: $(cat "$LAST_STATUS" 2>/dev/null)"
+		fail "last_cmd_status is not ok after child group rmdir"
+	fi
+
+	if grep -qx "iommu_group:$group" "$ROOT_DEVICES"; then
+		log "root devices content:"
+		cat "$ROOT_DEVICES" 2>/dev/null
+		fail "root devices still shows iommu_group:$group after default move"
+	else
+		pass "root devices does not show iommu_group:$group after default move"
+	fi
+
+}
+
+trap cleanup EXIT
+need_root
+init_tmp_dir
+take_global_lock
+ensure_resctrl_mounted
+ensure_devices_file
+create_child_group
+if ! pick_iommu_group; then
+	log "FAIL: $fail_count failure(s), $pass_count pass(es)"
+	exit $KSFT_FAIL
+fi
+test_malformed_group_rejected
+test_trailing_separator_rejected
+test_missing_group_rejected
+test_non_decimal_group_rejected
+test_tasks_rejects_iommu_token
+test_global_qosid_sysfs
+test_valid_group_write
+test_child_group_write
+test_child_pseudo_locksetup_rejected
+test_child_group_rmdir
+
+if [ "$fail_count" -gt 0 ]; then
+	log "FAIL: $fail_count failure(s), $pass_count pass(es)"
+	exit $KSFT_FAIL
+fi
+
+if [ "$skip_count" -gt 0 ]; then
+	log "PASS: $pass_count checks passed, $skip_count optional check(s) skipped"
+else
+	log "PASS: $pass_count checks passed"
+fi
+exit $KSFT_PASS
-- 
2.50.1 (Apple Git-155)

