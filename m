Return-Path: <SRS0=9mGv=N7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1763C433F5
	for <iommu@archiver.kernel.org>; Thu,  9 Sep 2021 11:18:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6938461104
	for <iommu@archiver.kernel.org>; Thu,  9 Sep 2021 11:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6938461104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1064060AF5;
	Thu,  9 Sep 2021 11:18:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O3kFLYUukgiO; Thu,  9 Sep 2021 11:18:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D28FF60ADE;
	Thu,  9 Sep 2021 11:18:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89062C0011;
	Thu,  9 Sep 2021 11:18:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 308D5C000D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Sep 2021 11:18:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0AAF540576
 for <iommu@lists.linux-foundation.org>; Thu,  9 Sep 2021 11:18:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QnQe5t0NF6eB for <iommu@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 11:18:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D73EC40566
 for <iommu@lists.linux-foundation.org>; Thu,  9 Sep 2021 11:18:06 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 405EB60F; Thu,  9 Sep 2021 13:18:03 +0200 (CEST)
Date: Thu, 9 Sep 2021 13:17:57 +0200
From: Joerg Roedel <joro@8bytes.org>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH 0/3] iommu/amd: Fix unable to handle page fault due to AVIC
Message-ID: <YTntZSVDjQ5yb0NQ@8bytes.org>
References: <20210820202957.187572-1-suravee.suthikulpanit@amd.com>
 <f2ec4e5c-3bb1-b703-8842-34357e084bad@amd.com>
 <YTB/jWr9vb6xvTQp@8bytes.org>
 <5c7921f4-70ad-5d14-f44c-22a49c2ac068@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5c7921f4-70ad-5d14-f44c-22a49c2ac068@amd.com>
Cc: iommu@lists.linux-foundation.org, Jon.Grimm@amd.com,
 linux-kernel@vger.kernel.org, wei.huang2@amd.com
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

Okay, after this triggered a defconfig compile warning, I squashed patch
1 and 2 into one and also #ifdef'ed check_feature_on_all_iommus(). The
result is here:

From c3811a50addd23b9bb5a36278609ee1638debcf6 Mon Sep 17 00:00:00 2001
From: Wei Huang <wei.huang2@amd.com>
Date: Fri, 20 Aug 2021 15:29:55 -0500
Subject: [PATCH] iommu/amd: Relocate GAMSup check to early_enable_iommus

Currently, iommu_init_ga() checks and disables IOMMU VAPIC support
(i.e. AMD AVIC support in IOMMU) when GAMSup feature bit is not set.
However it forgets to clear IRQ_POSTING_CAP from the previously set
amd_iommu_irq_ops.capability.

This triggers an invalid page fault bug during guest VM warm reboot
if AVIC is enabled since the irq_remapping_cap(IRQ_POSTING_CAP) is
incorrectly set, and crash the system with the following kernel trace.

    BUG: unable to handle page fault for address: 0000000000400dd8
    RIP: 0010:amd_iommu_deactivate_guest_mode+0x19/0xbc
    Call Trace:
     svm_set_pi_irte_mode+0x8a/0xc0 [kvm_amd]
     ? kvm_make_all_cpus_request_except+0x50/0x70 [kvm]
     kvm_request_apicv_update+0x10c/0x150 [kvm]
     svm_toggle_avic_for_irq_window+0x52/0x90 [kvm_amd]
     svm_enable_irq_window+0x26/0xa0 [kvm_amd]
     vcpu_enter_guest+0xbbe/0x1560 [kvm]
     ? avic_vcpu_load+0xd5/0x120 [kvm_amd]
     ? kvm_arch_vcpu_load+0x76/0x240 [kvm]
     ? svm_get_segment_base+0xa/0x10 [kvm_amd]
     kvm_arch_vcpu_ioctl_run+0x103/0x590 [kvm]
     kvm_vcpu_ioctl+0x22a/0x5d0 [kvm]
     __x64_sys_ioctl+0x84/0xc0
     do_syscall_64+0x33/0x40
     entry_SYSCALL_64_after_hwframe+0x44/0xae

Fixes by moving the initializing of AMD IOMMU interrupt remapping mode
(amd_iommu_guest_ir) earlier before setting up the
amd_iommu_irq_ops.capability with appropriate IRQ_POSTING_CAP flag.

[joro:	Squashed the two patches and limited
	check_features_on_all_iommus() to CONFIG_IRQ_REMAP
	to fix a compile warning.]

Signed-off-by: Wei Huang <wei.huang2@amd.com>
Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Link: https://lore.kernel.org/r/20210820202957.187572-2-suravee.suthikulpanit@amd.com
Link: https://lore.kernel.org/r/20210820202957.187572-3-suravee.suthikulpanit@amd.com
Fixes: 8bda0cfbdc1a ("iommu/amd: Detect and initialize guest vAPIC log")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/init.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index bdcf167b4afe..4e753d1860b3 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -297,6 +297,22 @@ int amd_iommu_get_num_iommus(void)
 	return amd_iommus_present;
 }
 
+#ifdef CONFIG_IRQ_REMAP
+static bool check_feature_on_all_iommus(u64 mask)
+{
+	bool ret = false;
+	struct amd_iommu *iommu;
+
+	for_each_iommu(iommu) {
+		ret = iommu_feature(iommu, mask);
+		if (!ret)
+			return false;
+	}
+
+	return true;
+}
+#endif
+
 /*
  * For IVHD type 0x11/0x40, EFR is also available via IVHD.
  * Default to IVHD EFR since it is available sooner
@@ -853,13 +869,6 @@ static int iommu_init_ga(struct amd_iommu *iommu)
 	int ret = 0;
 
 #ifdef CONFIG_IRQ_REMAP
-	/* Note: We have already checked GASup from IVRS table.
-	 *       Now, we need to make sure that GAMSup is set.
-	 */
-	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
-	    !iommu_feature(iommu, FEATURE_GAM_VAPIC))
-		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
-
 	ret = iommu_init_ga_log(iommu);
 #endif /* CONFIG_IRQ_REMAP */
 
@@ -2479,6 +2488,14 @@ static void early_enable_iommus(void)
 	}
 
 #ifdef CONFIG_IRQ_REMAP
+	/*
+	 * Note: We have already checked GASup from IVRS table.
+	 *       Now, we need to make sure that GAMSup is set.
+	 */
+	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
+	    !check_feature_on_all_iommus(FEATURE_GAM_VAPIC))
+		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
+
 	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
 		amd_iommu_irq_ops.capability |= (1 << IRQ_POSTING_CAP);
 #endif
-- 
2.33.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
