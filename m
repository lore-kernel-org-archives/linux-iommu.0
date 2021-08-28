Return-Path: <SRS0=VAik=NT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B412C432BE
	for <iommu@archiver.kernel.org>; Sat, 28 Aug 2021 07:09:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3259D6108D
	for <iommu@archiver.kernel.org>; Sat, 28 Aug 2021 07:09:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3259D6108D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3557425D2;
	Sat, 28 Aug 2021 07:09:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nXKgv18w5eM5; Sat, 28 Aug 2021 07:09:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A59D04262B;
	Sat, 28 Aug 2021 07:09:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D157C0010;
	Sat, 28 Aug 2021 07:09:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41108C000E
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 07:09:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3166E8340C
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 07:09:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r5YqgBi_KxEO for <iommu@lists.linux-foundation.org>;
 Sat, 28 Aug 2021 07:09:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 38B9983134
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 07:09:26 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10089"; a="216222593"
X-IronPort-AV: E=Sophos;i="5.84,358,1620716400"; d="scan'208";a="216222593"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2021 00:09:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,358,1620716400"; d="scan'208";a="495954845"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga008.fm.intel.com with ESMTP; 28 Aug 2021 00:09:24 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/2] iommu/vt-d: Fix a deadlock in intel_svm_drain_prq()
Date: Sat, 28 Aug 2021 15:06:22 +0800
Message-Id: <20210828070622.2437559-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210828070622.2437559-1-baolu.lu@linux.intel.com>
References: <20210828070622.2437559-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, iommu@lists.linux-foundation.org,
 Dave Jiang <dave.jiang@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Fenghua Yu <fenghua.yu@intel.com>

pasid_mutex and dev->iommu->param->lock are held while unbinding mm is
flushing IO page fault workqueue and waiting for all page fault works to
finish. But an in-flight page fault work also need to hold the two locks
while unbinding mm are holding them and waiting for the work to finish.
This may cause an ABBA deadlock issue as shown below:

[  186.588324] idxd 0000:00:0a.0: unbind PASID 2
[  186.598239] ======================================================
[  186.604664] WARNING: possible circular locking dependency detected
[  186.611074] 5.14.0-rc7+ #549 Not tainted [  186.615245] ----------
[  186.621670] dsa_test/898 is trying to acquire lock:
[  186.626818] ffff888100d854e8 (&param->lock){+.+.}-{3:3}, at:
               iopf_queue_flush_dev+0x29/0x60
[  186.635433] but task is already holding lock:
[  186.641835] ffffffff82b2f7c8 (pasid_mutex){+.+.}-{3:3}, at:
               intel_svm_unbind+0x34/0x1e0
[  186.650120] which lock already depends on the new lock.
[  186.650120]
[  186.659225]
[  186.659225] the existing dependency chain (in reverse order) is:
[  186.667340]
[  186.667340] -> #2 (pasid_mutex){+.+.}-{3:3}:
[  186.673744]        __mutex_lock+0x75/0x730
[  186.678164]        mutex_lock_nested+0x1b/0x20
[  186.682934]        intel_svm_page_response+0x8e/0x260
[  186.688324]        iommu_page_response+0x122/0x200
[  186.693448]        iopf_handle_group+0x1c2/0x240
[  186.698405]        process_one_work+0x2a5/0x5a0
[  186.703278]        worker_thread+0x55/0x400
[  186.707797]        kthread+0x13b/0x160
[  186.711885]        ret_from_fork+0x22/0x30
[  186.716323]
[  186.716323] -> #1 (&param->fault_param->lock){+.+.}-{3:3}:
[  186.723966]        __mutex_lock+0x75/0x730
[  186.728421]        mutex_lock_nested+0x1b/0x20
[  186.733214]        iommu_report_device_fault+0xc2/0x170
[  186.738788]        prq_event_thread+0x28a/0x580
[  186.743662]        irq_thread_fn+0x28/0x60
[  186.748105]        irq_thread+0xcf/0x180
[  186.752373]        kthread+0x13b/0x160
[  186.756465]        ret_from_fork+0x22/0x30
[  186.760907]
[  186.760907] -> #0 (&param->lock){+.+.}-{3:3}:
[  186.767430]        __lock_acquire+0x1134/0x1d60
[  186.772303]        lock_acquire+0xc6/0x2e0
[  186.776748]        __mutex_lock+0x75/0x730
[  186.781192]        mutex_lock_nested+0x1b/0x20
[  186.786069]        iopf_queue_flush_dev+0x29/0x60
[  186.791118]        intel_svm_drain_prq+0x127/0x210
[  186.796266]        intel_svm_unbind+0xc5/0x1e0
[  186.801047]        iommu_sva_unbind_device+0x62/0x80
[  186.806346]        idxd_cdev_release+0x15a/0x200 [idxd]
[  186.811913]        __fput+0x9c/0x250
[  186.815833]        ____fput+0xe/0x10
[  186.819741]        task_work_run+0x64/0xa0
[  186.824165]        exit_to_user_mode_prepare+0x227/0x230
[  186.829805]        syscall_exit_to_user_mode+0x2c/0x60
[  186.835260]        do_syscall_64+0x48/0x90
[  186.839681]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  186.845560]
[  186.845560] other info that might help us debug this:
[  186.845560]
[  186.854476] Chain exists of:
[  186.854476]   &param->lock --> &param->fault_param->lock --> pasid_mutex
[  186.854476]
[  186.866386]  Possible unsafe locking scenario:
[  186.866386]
[  186.872942]        CPU0                    CPU1
[  186.877754]        ----                    ----
[  186.882571]   lock(pasid_mutex);
[  186.886131]                                lock(&param->fault_param->lock);
[  186.893368]                                lock(pasid_mutex);
[  186.899405]   lock(&param->lock);
[  186.903009]
[  186.903009]  *** DEADLOCK ***
[  186.903009]
[  186.909791] 2 locks held by dsa_test/898:
[  186.914079]  #0: ffff888100cc1cc0 (&group->mutex){+.+.}-{3:3}, at:
                iommu_sva_unbind_device+0x53/0x80
[  186.923486]  #1: ffffffff82b2f7c8 (pasid_mutex){+.+.}-{3:3}, at:
                intel_svm_unbind+0x34/0x1e0
[  186.932214]
[  186.932214] stack backtrace:
[  186.937191] CPU: 2 PID: 898 Comm: dsa_test Not tainted 5.14.0-rc7+ #549
[  186.944108] Hardware name: Intel Corporation Kabylake Client platform/KBL S
               DDR4 UD IMM CRB, BIOS KBLSE2R1.R00.X050.P01.1608011715 08/01/2016
[  186.957346] Call Trace:
[  186.960131]  dump_stack_lvl+0x5b/0x74
[  186.964133]  dump_stack+0x10/0x12
[  186.967789]  print_circular_bug.cold+0x13d/0x142
[  186.972784]  check_noncircular+0xf1/0x110
[  186.977138]  __lock_acquire+0x1134/0x1d60
[  186.981483]  lock_acquire+0xc6/0x2e0
[  186.985397]  ? iopf_queue_flush_dev+0x29/0x60
[  186.990088]  ? pci_mmcfg_read+0xde/0x240
[  186.994355]  __mutex_lock+0x75/0x730
[  186.998276]  ? iopf_queue_flush_dev+0x29/0x60
[  187.002982]  ? pci_mmcfg_read+0xfd/0x240
[  187.007247]  ? iopf_queue_flush_dev+0x29/0x60
[  187.011948]  mutex_lock_nested+0x1b/0x20
[  187.016217]  iopf_queue_flush_dev+0x29/0x60
[  187.020788]  intel_svm_drain_prq+0x127/0x210
[  187.025396]  ? intel_pasid_tear_down_entry+0x22e/0x240
[  187.030881]  intel_svm_unbind+0xc5/0x1e0
[  187.035156]  iommu_sva_unbind_device+0x62/0x80
[  187.039955]  idxd_cdev_release+0x15a/0x200

pasid_mutex protects pasid and svm data mapping data. It's unnecessary
to hold pasid_mutex while flushing the workqueue. To fix the deadlock
issue, unlock pasid_pasid during flushing the workqueue to allow the works
to be handled.

Fixes: d5b9e4bfe0d8 ("iommu/vt-d: Report prq to io-pgfault framework")
Reported-and-tested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Link: https://lore.kernel.org/r/20210826215918.4073446-1-fenghua.yu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index a3f84f2ff1ba..0c228787704f 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -789,7 +789,19 @@ static void intel_svm_drain_prq(struct device *dev, u32 pasid)
 		goto prq_retry;
 	}
 
+	/*
+	 * A work in IO page fault workqueue may try to lock pasid_mutex now.
+	 * Holding pasid_mutex while waiting in iopf_queue_flush_dev() for
+	 * all works in the workqueue to finish may cause deadlock.
+	 *
+	 * It's unnecessary to hold pasid_mutex in iopf_queue_flush_dev().
+	 * Unlock it to allow the works to be handled while waiting for
+	 * them to finish.
+	 */
+	lockdep_assert_held(&pasid_mutex);
+	mutex_unlock(&pasid_mutex);
 	iopf_queue_flush_dev(dev);
+	mutex_lock(&pasid_mutex);
 
 	/*
 	 * Perform steps described in VT-d spec CH7.10 to drain page
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
