Return-Path: <SRS0=UfLp=4C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEA6C35242
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 22:58:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8B9320848
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 22:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="OZY/DLxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B9320848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2D67886AD3;
	Fri, 14 Feb 2020 22:58:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uya2XKAA27s3; Fri, 14 Feb 2020 22:58:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EF2AA86422;
	Fri, 14 Feb 2020 22:58:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D23CDC08A4;
	Fri, 14 Feb 2020 22:58:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D596C0177
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 22:58:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3DC3C8834D
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 22:58:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kMHN9u+whdbV for <iommu@lists.linux-foundation.org>;
 Fri, 14 Feb 2020 22:58:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A1E5B8830D
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 22:58:25 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1581721105; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Crn3FL1RKeqIe9JQNOwhOeVTSYotuHa65B4DyFHfQgY=;
 b=OZY/DLxBLlmLs1FmQYN/+K7PWeIP3FqhFPgm3X3PnhO4Od6IJq7ooFuQVKR4svaGRYZGuA1A
 2JOBdlvR+Fx9CafvG1brE88s3ebITY4+o780gFiCWXII9r/txYffWlWubq8P7ZowatorKbdA
 vkYBwLe1TeOF5Y2Qil0k1iFZxFI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e472610.7f63e9011500-smtp-out-n01;
 Fri, 14 Feb 2020 22:58:24 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 5680CC447A3; Fri, 14 Feb 2020 22:58:24 +0000 (UTC)
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 5692AC4479C;
 Fri, 14 Feb 2020 22:58:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5692AC4479C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=isaacm@codeaurora.org
From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
To: iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] iommu/dma: Allow drivers to reserve an iova range
Date: Fri, 14 Feb 2020 14:58:16 -0800
Message-Id: <1581721096-16235-1-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>, kernel-team@android.com,
 pratikp@codeaurora.org, Liam Mark <lmark@codeaurora.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Liam Mark <lmark@codeaurora.org>

Some devices have a memory map which contains gaps or holes.
In order for the device to have as much IOVA space as possible,
allow its driver to inform the DMA-IOMMU layer that it should
not allocate addresses from these holes.

Change-Id: I15bd1d313d889c2572d0eb2adecf6bebde3267f7
Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
---
 drivers/iommu/dma-iommu.c | 28 ++++++++++++++++++++++++++++
 include/linux/dma-iommu.h |  9 +++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index a2e96a5..3b83e1a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -368,6 +368,34 @@ static int iommu_dma_deferred_attach(struct device *dev,
 	return 0;
 }
 
+/*
+ * Should be called prior to using dma-apis
+ */
+int iommu_dma_reserve_iova(struct device *dev, dma_addr_t base,
+			   u64 size)
+{
+	struct iommu_domain *domain;
+	struct iommu_dma_cookie *cookie;
+	struct iova_domain *iovad;
+	unsigned long pfn_lo, pfn_hi;
+
+	domain = iommu_get_domain_for_dev(dev);
+	if (!domain || !domain->iova_cookie)
+		return -EINVAL;
+
+	cookie = domain->iova_cookie;
+	iovad = &cookie->iovad;
+
+	/* iova will be freed automatically by put_iova_domain() */
+	pfn_lo = iova_pfn(iovad, base);
+	pfn_hi = iova_pfn(iovad, base + size - 1);
+	if (!reserve_iova(iovad, pfn_lo, pfn_hi))
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL(iommu_dma_reserve_iova);
+
 /**
  * dma_info_to_prot - Translate DMA API directions and attributes to IOMMU API
  *                    page flags.
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 2112f21..79eef7c 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -37,6 +37,9 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
 
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
+int iommu_dma_reserve_iova(struct device *dev, dma_addr_t base,
+			   u64 size);
+
 #else /* CONFIG_IOMMU_DMA */
 
 struct iommu_domain;
@@ -78,5 +81,11 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
 {
 }
 
+static inline int iommu_dma_reserve_iova(struct device *dev, dma_addr_t base,
+					 u64 size)
+{
+	return -ENODEV;
+}
+
 #endif	/* CONFIG_IOMMU_DMA */
 #endif	/* __DMA_IOMMU_H */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
