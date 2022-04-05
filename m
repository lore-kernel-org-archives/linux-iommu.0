Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E42C433F5
	for <iommu@archiver.kernel.org>; Tue,  5 Apr 2022 10:41:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C63E60F56;
	Tue,  5 Apr 2022 10:41:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mhbdLRdDWhLN; Tue,  5 Apr 2022 10:41:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2CEEC60F4B;
	Tue,  5 Apr 2022 10:41:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08558C001D;
	Tue,  5 Apr 2022 10:41:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C033AC0012
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 10:41:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A012440614
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 10:41:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vd3_U_rDXrGq for <iommu@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 10:41:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id BC59040523
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 10:41:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1976D6E;
 Tue,  5 Apr 2022 03:41:13 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8A8D83F5A1;
 Tue,  5 Apr 2022 03:41:12 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org, baolu.lu@linux.intel.com, andreas.noever@gmail.com,
 michael.jamet@intel.com, mika.westerberg@linux.intel.com,
 YehezkelShB@gmail.com
Subject: [PATCH v3 2/4] iommu: Add capability for pre-boot DMA protection
Date: Tue,  5 Apr 2022 11:41:02 +0100
Message-Id: <2b5dc62a6325075cb5bd1ceec31ebad1833acf83.1649089693.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1649089693.git.robin.murphy@arm.com>
References: <cover.1649089693.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org, hch@lst.de,
 linux-kernel@vger.kernel.org, mario.limonciello@amd.com
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
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/intel/iommu.c | 2 ++
 include/linux/iommu.h       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 255304eb3b1f..49d552a96098 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4550,6 +4550,8 @@ static bool intel_iommu_capable(struct device *dev, enum iommu_cap cap)
 		return domain_update_iommu_snooping(NULL);
 	if (cap == IOMMU_CAP_INTR_REMAP)
 		return irq_remapping_enabled == 1;
+	if (cap == IOMMU_CAP_PRE_BOOT_PROTECTION)
+		return dmar_platform_optin();
 
 	return false;
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1fa927e6f1c6..64c02f472f7b 100644
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
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
