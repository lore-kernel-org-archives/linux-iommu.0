Return-Path: <SRS0=sMz+=LM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BEAC49361
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 02:51:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64FFD61241
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 02:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64FFD61241
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2409640332;
	Fri, 18 Jun 2021 02:51:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mq1mwDLRMnYt; Fri, 18 Jun 2021 02:51:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AED50415A4;
	Fri, 18 Jun 2021 02:51:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 980A9C000D;
	Fri, 18 Jun 2021 02:51:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BA7FC000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 02:51:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id 4B4044022B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 02:51:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id oYTM88UJNL7x for <iommu@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 02:51:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id EDC2A40236
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 02:51:47 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1623984709; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=xxSjvx9FX3p13QwnOpawsCd6aq6mAIMLGM9MTx8atwg=;
 b=xg7yukJh5xgQii0QY/bpK5NwYiWKfeFze19nGZ1K8k4ASxTEpd0aZOHBKlgjz7tG8kcdiWc4
 0X2H1hkSF/hvnQZF21JtUiJQzqyB4pd/UHn33m6rzzMsOkKFn2qprB5XXmKXJZzJLl2152GK
 nZ7tLYS2XYIRHWokPOr2D7ol2zs=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60cc0a34ed59bf69ccb3588f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Jun 2021 02:51:32
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 1980CC433F1; Fri, 18 Jun 2021 02:51:32 +0000 (UTC)
Received: from blr-ubuntu-253.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 2260DC43460;
 Fri, 18 Jun 2021 02:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2260DC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCHv2 2/3] iommu/io-pgtable: Optimize partial walk flush for large
 scatter-gather list
Date: Fri, 18 Jun 2021 08:21:04 +0530
Message-Id: <150fc7ab1c7f9b70a95dae1f4bc3b9018c0f9e04.1623981933.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <cover.1623981933.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1623981933.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Cc: Thierry Reding <treding@nvidia.com>, linux-arm-msm@vger.kernel.org,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
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

Currently for iommu_unmap() of large scatter-gather list with page size
elements, the majority of time is spent in flushing of partial walks in
__arm_lpae_unmap() which is a VA based TLB invalidation invalidating
page-by-page on iommus like arm-smmu-v2 (TLBIVA) which do not support
range based invalidations like on arm-smmu-v3.2.

For example: to unmap a 32MB scatter-gather list with page size elements
(8192 entries), there are 16->2MB buffer unmaps based on the pgsize (2MB
for 4K granule) and each of 2MB will further result in 512 TLBIVAs (2MB/4K)
resulting in a total of 8192 TLBIVAs (512*16) for 16->2MB causing a huge
overhead.

So instead use tlb_flush_all() callback (TLBIALL/TLBIASID) to invalidate
the entire context for partial walk flush on select few platforms where
cost of over-invalidation is less than unmap latency using the newly
introduced quirk IO_PGTABLE_QUIRK_TLB_INV_ALL. We also do this for
non-strict mode given its all about over-invalidation saving time on
individual unmaps and non-deterministic generally.

For this example of 32MB scatter-gather list unmap, this results in just
16 ASID based TLB invalidations (TLBIASIDs) as opposed to 8192 TLBIVAs
thereby increasing the performance of unmaps drastically.

Test on QTI SM8150 SoC for 10 iterations of iommu_{map_sg}/unmap:
(average over 10 iterations)

Before this optimization:

    size        iommu_map_sg      iommu_unmap
      4K            2.067 us         1.854 us
     64K            9.598 us         8.802 us
      1M          148.890 us       130.718 us
      2M          305.864 us        67.291 us
     12M         1793.604 us       390.838 us
     16M         2386.848 us       518.187 us
     24M         3563.296 us       775.989 us
     32M         4747.171 us      1033.364 us

After this optimization:

    size        iommu_map_sg      iommu_unmap
      4K            1.723 us         1.765 us
     64K            9.880 us         8.869 us
      1M          155.364 us       135.223 us
      2M          303.906 us         5.385 us
     12M         1786.557 us        21.250 us
     16M         2391.890 us        27.437 us
     24M         3570.895 us        39.937 us
     32M         4755.234 us        51.797 us

This is further reduced once the map/unmap_pages() support gets in which
will result in just 1 TLBIASID as compared to 16 TLBIASIDs.

Real world data also shows big difference in unmap performance as below:

There were reports of camera frame drops because of high overhead in
iommu unmap without this optimization because of frequent unmaps issued
by camera of about 100MB/s taking more than 100ms thereby causing frame
drops.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 include/linux/io-pgtable.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 45441592a0e6..fd6b30cfdbf7 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -219,6 +219,12 @@ static inline void
 io_pgtable_tlb_flush_walk(struct io_pgtable *iop, unsigned long iova,
 			  size_t size, size_t granule)
 {
+	if (iop->cfg.quirks & IO_PGTABLE_QUIRK_NON_STRICT ||
+	    iop->cfg.quirks & IO_PGTABLE_QUIRK_TLB_INV_ALL) {
+		iop->cfg.tlb->tlb_flush_all(iop->cookie);
+		return;
+	}
+
 	if (iop->cfg.tlb && iop->cfg.tlb->tlb_flush_walk)
 		iop->cfg.tlb->tlb_flush_walk(iova, size, granule, iop->cookie);
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
