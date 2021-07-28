Return-Path: <SRS0=45t2=MU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8139C4338F
	for <iommu@archiver.kernel.org>; Wed, 28 Jul 2021 15:59:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8638460D07
	for <iommu@archiver.kernel.org>; Wed, 28 Jul 2021 15:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8638460D07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66F6940271;
	Wed, 28 Jul 2021 15:59:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id el2gMauQikS6; Wed, 28 Jul 2021 15:59:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 59568405FA;
	Wed, 28 Jul 2021 15:59:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1629AC001A;
	Wed, 28 Jul 2021 15:59:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 732E4C000E
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 15:59:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 44D3C608A3
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 15:59:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kQ8jB_0ejFEK for <iommu@lists.linux-foundation.org>;
 Wed, 28 Jul 2021 15:59:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6E4B66089B
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 15:59:47 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 031BE1FB;
 Wed, 28 Jul 2021 08:59:47 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 862A93F70D;
 Wed, 28 Jul 2021 08:59:45 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v2 23/24] iommu/arm-smmu: Allow non-strict in pgtable_quirks
 interface
Date: Wed, 28 Jul 2021 16:58:44 +0100
Message-Id: <0fcd1f5225a6b435cbc697551a6247cd435c04db.1627468310.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1627468308.git.robin.murphy@arm.com>
References: <cover.1627468308.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

To make io-pgtable aware of a flush queue being dynamically enabled,
allow IO_PGTABLE_QUIRK_NON_STRICT to be set even after a domain has been
attached to, and hook up the final piece of the puzzle in iommu-dma.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 +++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 11 +++++++++++
 drivers/iommu/dma-iommu.c                   |  3 +++
 3 files changed, 29 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 19400826eba7..40fa9cb382c3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2711,6 +2711,20 @@ static int arm_smmu_enable_nesting(struct iommu_domain *domain)
 	return ret;
 }
 
+static int arm_smmu_set_pgtable_quirks(struct iommu_domain *domain,
+		unsigned long quirks)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+
+	if (quirks == IO_PGTABLE_QUIRK_NON_STRICT && smmu_domain->pgtbl_ops) {
+		struct io_pgtable *iop = io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops);
+
+		iop->cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
+		return 0;
+	}
+	return -EINVAL;
+}
+
 static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
 	return iommu_fwspec_add_ids(dev, args->args, 1);
@@ -2825,6 +2839,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.release_device		= arm_smmu_release_device,
 	.device_group		= arm_smmu_device_group,
 	.enable_nesting		= arm_smmu_enable_nesting,
+	.set_pgtable_quirks	= arm_smmu_set_pgtable_quirks,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 109e4723f9f5..f18684f308b9 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1518,6 +1518,17 @@ static int arm_smmu_set_pgtable_quirks(struct iommu_domain *domain,
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	int ret = 0;
 
+	if (quirks == IO_PGTABLE_QUIRK_NON_STRICT) {
+		struct io_pgtable *iop;
+
+		if (!smmu_domain->pgtbl_ops)
+			return -EINVAL;
+
+		iop = io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops);
+		iop->cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
+		return 0;
+	}
+
 	mutex_lock(&smmu_domain->init_mutex);
 	if (smmu_domain->smmu)
 		ret = -EPERM;
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 304a3ec71223..6e3eca778267 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -16,6 +16,7 @@
 #include <linux/huge_mm.h>
 #include <linux/iommu.h>
 #include <linux/iova.h>
+#include <linux/io-pgtable.h>
 #include <linux/irq.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
@@ -326,6 +327,8 @@ int iommu_dma_init_fq(struct iommu_domain *domain)
 		return -ENODEV;
 	}
 	cookie->fq_domain = domain;
+	if (domain->ops->set_pgtable_quirks)
+		domain->ops->set_pgtable_quirks(domain, IO_PGTABLE_QUIRK_NON_STRICT);
 	return 0;
 }
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
