Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAAB386422
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 02:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811708; cv=none; b=T9Ak0iFac70Juq/Aca6iLZ7p1Sj15kuHq1hMEUWcpmeHNrO2ia58RB8F6wylmnFl4F1APkBhbqGnbK4QoNsa4vE/vKmU6ddYywIJykr6xsBNywYXUBpSfeuskgsU+pPWJtrlBZ+2jSBTh4myyI34SKYRwHXD1HZFdcopY2MFEq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811708; c=relaxed/simple;
	bh=fSdEyytzPOzQz2lGc2NNfCDE0HdpxFXJSWsj0N4NZno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8NaY7LFvnAdCKSujix8kMsFAvGqW2Zx1DPqZM5YTvhZAZb/LGKIkxBIkAlFHjFOCMAldtyj4/DnvHp+B61pr5bJpM4O8flwR4OyGd9bZ0/+omKNtfDs1sM6+2kCliN4TaktqjvuT+wHKkNWn1nqYOCgSJE2ZAmqtODubsBFmeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GYFpQv/H; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GYFpQv/H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785811707; x=1817347707;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fSdEyytzPOzQz2lGc2NNfCDE0HdpxFXJSWsj0N4NZno=;
  b=GYFpQv/HHunsF982W1K42/meydh0NV+x5jbg0L6ImA9CAYCTwfg7WpM8
   AlR6hMrbhVaBJf9IRHCSev+eTkYi0NORnsm6BeZima/777TUJeN3Ar3TS
   9wybkgbdv468ymTBsj4l2WgwKkHQa/2ZgqNYGVJFFELJ8UlJz1f93kDRS
   L0YAjY0hokoUd6fSdIaUn9CUbJ2iCeMaqecy1zhkIBNEwpYVHJyrt6/7d
   7AHeJIQaaFejegzpKi+iHQEbJbv+fyan2dMgpz22rRNWZONAY96uw5a7r
   68F3+80sTFySm4LgWJ/PWyTUM6VAyNJJw3VbYO7k/WEoQrK0Hh4XbLx0w
   Q==;
X-CSE-ConnectionGUID: yULE8qJwQrmMqguJn5UUsg==
X-CSE-MsgGUID: 9UYQd/5dSlSQDZ7CYR4XQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86231224"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86231224"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:48:26 -0700
X-CSE-ConnectionGUID: 8MEKhmSASJ6FRK5VIRwXzg==
X-CSE-MsgGUID: AsScwTSGQ7yVnFSvUjfpBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="259587393"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa006.jf.intel.com with ESMTP; 03 Aug 2026 19:48:24 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: ZhaoJinming <zhaojinming@uniontech.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Li RongQing <lirongqing@baidu.com>,
	Desnes Nunes <desnesn@redhat.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/20] iommu/vt-d: Fix UCTP context table slot when copying root entries
Date: Tue,  4 Aug 2026 10:36:55 +0800
Message-ID: <20260804023714.3080506-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804023714.3080506-1-baolu.lu@linux.intel.com>
References: <20260804023714.3080506-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Desnes Nunes <desnesn@redhat.com>

When translation is already enabled at boot (e.g. kdump), the vt-d driver
copies context tables from the previous kernel's root table. In scalable
mode, buses that only populate the upper root half (UCTP, devfn >= 0x80)
should be written to ctxt_tbls[tbl_idx + 1] through copy_context_table().
However, the current copy path always uses tbl[tbl_idx + 0] in this situa-
tion. Since idx wraps to 0 at devfn 0x80 due to a zeroed LCTP, new_ce for
LCTP will be NULL and keep pos equals to 0. Thus, UCTP entries will be co-
pied into tbl[tbl_idx + 0] instead of tbl[tbl_idx + 1], and written after-
wards to root_entry[bus].lo instead of .hi in copy_translation_tables().

In short, devices on bus 0x80 with devfn >= 0x80 fail DMA with fault 0x39,
which will break drivers running in kernels with translation pre-enabled.
This fixes NO_PASID DMAR faults for UCTP-only buses such as:

DMAR: [DMA Read NO_PASID] Request device [80:14.0] fault addr 0xe81759000
      [fault reason 0x39] SM: Present bit in Root Entry is clear

For instance, this fault yielded to locking issues between systemd and
xHCI, blocking a system's reboot after a vmcore was captured with kdump:

 systemd-udevd[246]: usb3: Worker [255] processing SEQNUM=2193 is taking a long time
 dracut-initqueue[277]: Timed out while waiting for udev queue to empty.
 systemd-udevd[246]: usb3: Worker [255] processing SEQNUM=2193 killed
 systemd-udevd[246]: usb3: Worker [255] terminated by signal 9 (KILL).
 ...
 kdump[569]: saving vmcore complete
 ...
 systemd-shutdown[1]: Rebooting.
 INFO: task kworker/0:1:11 blocked for more than 122 seconds.
       Not tainted 7.0.0-clean #1
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:kworker/0:1 state:D stack:0 pid:11 tgid:11 ppid:2 task_flags:0x4208160 flags:0x00080000
 Workqueue: usb_hub_wq hub_event
 Call Trace:
  <TASK>
  __schedule+0x299/0x5c0
  schedule+0x27/0x80
  schedule_timeout+0xbd/0x100
  __wait_for_common+0x97/0x1b0
  ? __pfx_schedule_timeout+0x10/0x10
  xhci_alloc_dev+0x9e/0x2b0
  usb_alloc_dev+0x7a/0x3b0
  hub_port_connect+0x285/0x960
  hub_port_connect_change+0x94/0x290
  port_event+0x4bb/0x840
  hub_event+0x141/0x460
  process_one_work+0x196/0x390
  worker_thread+0x1af/0x320
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xe3/0x120
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x199/0x260
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 INFO: task systemd-shutdow:1 blocked for more than 122 seconds.
       Not tainted 7.0.0-clean #1
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:systemd-shutdow state:D stack:0 pid:1 tgid:1 ppid:0 task_flags:0x400100 flags:0x00080000
 Call Trace:
  <TASK>
  __schedule+0x299/0x5c0
  schedule+0x27/0x80
  schedule_preempt_disabled+0x15/0x30
  __mutex_lock.constprop.0+0x547/0xac0
  device_shutdown+0xac/0x1b0
  kernel_restart+0x3a/0x70
  __do_sys_reboot+0x147/0x240
  do_syscall_64+0x11b/0x6a0
  ? handle_mm_fault+0x110/0x350
  ? do_user_addr_fault+0x206/0x680
  ? irqentry_exit+0x7a/0x4d0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7fe2958da917
 RSP: 002b:00007ffc5c458618 EFLAGS: 00000206 ORIG_RAX: 00000000000000a9
 RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe2958da917
 RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
 RBP: 00007ffc5c458790 R08: 0000000000000069 R09: 00000000ffffffff
 R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
 R13: 0000000000000000 R14: 00007ffc5c4588b8 R15: 0000000000000000
  </TASK>
 INFO: task systemd-shutdow:1 is blocked on a mutex likely owned by task kworker/0:1:11.

Fixes: 091d42e43d21 ("iommu/vt-d: Copy translation tables from old kernel")
Signed-off-by: Desnes Nunes <desnesn@redhat.com>
Tested-by: Tao Liu <ltao@redhat.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 849d06dfe1ae..cf5f92619943 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1446,7 +1446,7 @@ static int copy_context_table(struct intel_iommu *iommu,
 			      struct context_entry **tbl,
 			      int bus, bool ext)
 {
-	int tbl_idx, pos = 0, idx, devfn, ret = 0, did;
+	int tbl_idx, tbl_slot = 0, idx, devfn, ret = 0, did;
 	struct context_entry *new_ce = NULL, ce;
 	struct context_entry *old_ce = NULL;
 	struct root_entry re;
@@ -1462,10 +1462,9 @@ static int copy_context_table(struct intel_iommu *iommu,
 		if (idx == 0) {
 			/* First save what we may have and clean up */
 			if (new_ce) {
-				tbl[tbl_idx] = new_ce;
+				tbl[tbl_idx + tbl_slot] = new_ce;
 				__iommu_flush_cache(iommu, new_ce,
 						    VTD_PAGE_SIZE);
-				pos = 1;
 			}
 
 			if (old_ce)
@@ -1487,6 +1486,9 @@ static int copy_context_table(struct intel_iommu *iommu,
 				}
 			}
 
+			/* Track if saving UCTP or LCTP entries in scalable mode */
+			tbl_slot = ext && devfn >= 0x80 ? 1 : 0;
+
 			ret = -ENOMEM;
 			old_ce = memremap(old_ce_phys, PAGE_SIZE,
 					MEMREMAP_WB);
@@ -1515,7 +1517,7 @@ static int copy_context_table(struct intel_iommu *iommu,
 		new_ce[idx] = ce;
 	}
 
-	tbl[tbl_idx + pos] = new_ce;
+	tbl[tbl_idx + tbl_slot] = new_ce;
 
 	__iommu_flush_cache(iommu, new_ce, VTD_PAGE_SIZE);
 
-- 
2.43.0

