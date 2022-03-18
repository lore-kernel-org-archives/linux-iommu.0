Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8091AC433F5
	for <iommu@archiver.kernel.org>; Fri, 18 Mar 2022 17:43:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F7ED408D5;
	Fri, 18 Mar 2022 17:43:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kpRwJGKI5May; Fri, 18 Mar 2022 17:43:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 17844402E2;
	Fri, 18 Mar 2022 17:43:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0B37C0033;
	Fri, 18 Mar 2022 17:43:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC140C0012
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 17:43:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DA76360A82
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 17:43:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SwjZtoGw-SLg for <iommu@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 17:43:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 07C96606ED
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 17:43:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B36D1515;
 Fri, 18 Mar 2022 10:43:08 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 254333F7B4;
 Fri, 18 Mar 2022 10:43:07 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org, baolu.lu@linux.intel.com, andreas.noever@gmail.com,
 michael.jamet@intel.com, mika.westerberg@linux.intel.com,
 YehezkelShB@gmail.com
Subject: [PATCH v2 1/2] iommu: Add capability for pre-boot DMA protection
Date: Fri, 18 Mar 2022 17:42:57 +0000
Message-Id: <797c70d255f946c4d631f2ffc67f277cfe0cb97c.1647624084.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1647624084.git.robin.murphy@arm.com>
References: <cover.1647624084.git.robin.murphy@arm.com>
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

Also use this as an opportunity to draw a line in the sand and add a
new interface so as not to introduce any more callers of iommu_capable()
which I also want to get rid of. For now it's a quick'n'dirty wrapper
function, but will evolve to subsume the internal interface in future.

[1] https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/oem-kernel-dma-protection

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: New patch

 drivers/iommu/intel/iommu.c | 2 ++
 include/linux/iommu.h       | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 0c7975848972..20d8e1f60068 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4817,6 +4817,8 @@ static bool intel_iommu_capable(enum iommu_cap cap)
 		return domain_update_iommu_snooping(NULL);
 	if (cap == IOMMU_CAP_INTR_REMAP)
 		return irq_remapping_enabled == 1;
+	if (cap == IOMMU_CAP_PRE_BOOT_PROTECTION)
+		return dmar_platform_optin();
 
 	return false;
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 4a25f8241207..e16d54e15fee 100644
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
@@ -1042,6 +1044,11 @@ static inline size_t iommu_map_sgtable(struct iommu_domain *domain,
 	return iommu_map_sg(domain, iova, sgt->sgl, sgt->orig_nents, prot);
 }
 
+static inline bool dev_iommu_capable(struct device *dev, enum iommu_cap cap)
+{
+	return device_iommu_mapped(dev) && iommu_capable(dev->bus, cap);
+}
+
 #ifdef CONFIG_IOMMU_DEBUGFS
 extern	struct dentry *iommu_debugfs_dir;
 void iommu_debugfs_setup(void);
-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
