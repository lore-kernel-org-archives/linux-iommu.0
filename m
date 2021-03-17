Return-Path: <SRS0=kdPY=IP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B5AC4332E
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 01:08:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60B9164EFC
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 01:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B9164EFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF96F83A65;
	Wed, 17 Mar 2021 01:07:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id odJUFpsXVHCR; Wed, 17 Mar 2021 01:07:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id B486B83857;
	Wed, 17 Mar 2021 01:07:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 975B4C000C;
	Wed, 17 Mar 2021 01:07:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 293CBC000A
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 01:07:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 115AA431D8
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 01:07:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R60JYzYT5BNr for <iommu@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 01:07:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 58DF1431D6
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 01:07:56 +0000 (UTC)
IronPort-SDR: Yxt2x726rErgV6LmKEyM8yZZJYC1bzTrIF+AzT+9waoY4IkyMSOwCzrEaW9ihycvnyhOQgQjf1
 iCdyXVLW5rOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="176495853"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; d="scan'208";a="176495853"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2021 18:07:55 -0700
IronPort-SDR: 5ESqZJpr09Vf0XxYYlkBPIf+V6tM3LPH9pyOCKYFkYtt+p3g3W2yafDGSwqh3Kvw1IFeEftrS9
 bsXrt30ki69Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; d="scan'208";a="511560007"
Received: from allen-box.sh.intel.com ([10.239.159.128])
 by fmsmga001.fm.intel.com with ESMTP; 16 Mar 2021 18:07:53 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 1/1] iommu/vt-d: Fix lockdep splat in intel_pasid_get_entry()
Date: Wed, 17 Mar 2021 08:58:34 +0800
Message-Id: <20210317005834.173503-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Dave Jiang <dave.jiang@intel.com>,
 linux-kernel@vger.kernel.org
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

The pasid_lock is used to synchronize different threads from modifying a
same pasid directory entry at the same time. It causes below lockdep splat.

[   83.296538] ========================================================
[   83.296538] WARNING: possible irq lock inversion dependency detected
[   83.296539] 5.12.0-rc3+ #25 Tainted: G        W
[   83.296539] --------------------------------------------------------
[   83.296540] bash/780 just changed the state of lock:
[   83.296540] ffffffff82b29c98 (device_domain_lock){..-.}-{2:2}, at:
           iommu_flush_dev_iotlb.part.0+0x32/0x110
[   83.296547] but this lock took another, SOFTIRQ-unsafe lock in the past:
[   83.296547]  (pasid_lock){+.+.}-{2:2}
[   83.296548]

           and interrupts could create inverse lock ordering between them.

[   83.296549] other info that might help us debug this:
[   83.296549] Chain exists of:
                 device_domain_lock --> &iommu->lock --> pasid_lock
[   83.296551]  Possible interrupt unsafe locking scenario:

[   83.296551]        CPU0                    CPU1
[   83.296552]        ----                    ----
[   83.296552]   lock(pasid_lock);
[   83.296553]                                local_irq_disable();
[   83.296553]                                lock(device_domain_lock);
[   83.296554]                                lock(&iommu->lock);
[   83.296554]   <Interrupt>
[   83.296554]     lock(device_domain_lock);
[   83.296555]
                *** DEADLOCK ***

Fix it by replacing the pasid_lock with an atomic exchange operation.

Reported-and-tested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 9fb3d3e80408..1ddcb8295f72 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -24,7 +24,6 @@
 /*
  * Intel IOMMU system wide PASID name space:
  */
-static DEFINE_SPINLOCK(pasid_lock);
 u32 intel_pasid_max_id = PASID_MAX;
 
 int vcmd_alloc_pasid(struct intel_iommu *iommu, u32 *pasid)
@@ -259,19 +258,18 @@ struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
 	dir_index = pasid >> PASID_PDE_SHIFT;
 	index = pasid & PASID_PTE_MASK;
 
-	spin_lock(&pasid_lock);
 	entries = get_pasid_table_from_pde(&dir[dir_index]);
 	if (!entries) {
 		entries = alloc_pgtable_page(info->iommu->node);
-		if (!entries) {
-			spin_unlock(&pasid_lock);
+		if (!entries)
 			return NULL;
-		}
 
-		WRITE_ONCE(dir[dir_index].val,
-			   (u64)virt_to_phys(entries) | PASID_PTE_PRESENT);
+		if (cmpxchg64(&dir[dir_index].val, 0ULL,
+			      (u64)virt_to_phys(entries) | PASID_PTE_PRESENT)) {
+			free_pgtable_page(entries);
+			entries = get_pasid_table_from_pde(&dir[dir_index]);
+		}
 	}
-	spin_unlock(&pasid_lock);
 
 	return &entries[index];
 }
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
