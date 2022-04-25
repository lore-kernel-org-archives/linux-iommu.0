Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A675C433FE
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 12:42:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0EBF4404D5;
	Mon, 25 Apr 2022 12:42:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JBkKcH0vMWdC; Mon, 25 Apr 2022 12:42:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E7BF8404C3;
	Mon, 25 Apr 2022 12:42:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5541C0032;
	Mon, 25 Apr 2022 12:42:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02838C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 12:42:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D648D404EF
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 12:42:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gIHkttDRcvNA for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 12:42:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 03968404D5
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 12:42:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54670ED1;
 Mon, 25 Apr 2022 05:42:16 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E000E3F5A1;
 Mon, 25 Apr 2022 05:42:14 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Subject: [PATCH v4 2/4] iommu: Add capability for pre-boot DMA protection
Date: Mon, 25 Apr 2022 13:42:03 +0100
Message-Id: <d6218dff2702472da80db6aec2c9589010684551.1650878781.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.35.3.dirty
In-Reply-To: <cover.1650878781.git.robin.murphy@arm.com>
References: <cover.1650878781.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: michael.jamet@intel.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, YehezkelShB@gmail.com,
 iommu@lists.linux-foundation.org, mario.limonciello@amd.com,
 andreas.noever@gmail.com, mika.westerberg@linux.intel.com, hch@lst.de
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

VT-d's dmar_platform_optin() actually represents a combination of
properties fairly well standardised by Microsoft as "Pre-boot DMA
Protection" and "Kernel DMA Protection"[1]. As such, we can provide
interested consumers with an abstracted capability rather than
driver-specific interfaces that won't scale. We name it for the former
aspect since that's what external callers are most likely to be
interested in; the latter is for the IOMMU layer to handle itself.

[1] https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/oem-kernel-dma-protection

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v4: No change

 drivers/iommu/intel/iommu.c | 2 ++
 include/linux/iommu.h       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index df5c62ecf942..0edf6084dc14 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4551,6 +4551,8 @@ static bool intel_iommu_capable(enum iommu_cap cap)
 		return domain_update_iommu_snooping(NULL);
 	if (cap == IOMMU_CAP_INTR_REMAP)
 		return irq_remapping_enabled == 1;
+	if (cap == IOMMU_CAP_PRE_BOOT_PROTECTION)
+		return dmar_platform_optin();
 
 	return false;
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e26cf84e5d82..4123693ae319 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -107,6 +107,8 @@ enum iommu_cap {
 					   transactions */
 	IOMMU_CAP_INTR_REMAP,		/* IOMMU supports interrupt isolation */
 	IOMMU_CAP_NOEXEC,		/* IOMMU_NOEXEC flag */
+	IOMMU_CAP_PRE_BOOT_PROTECTION,	/* Firmware says it used the IOMMU for
+					   DMA protection and we should too */
 };
 
 /* These are the possible reserved region types */
-- 
2.35.3.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
