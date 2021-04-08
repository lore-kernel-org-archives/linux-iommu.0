Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C190C433ED
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 17:14:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA7C3610D0
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 17:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7C3610D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8788607B5;
	Thu,  8 Apr 2021 17:14:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dNAZqMrm_Odr; Thu,  8 Apr 2021 17:14:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 08809607BC;
	Thu,  8 Apr 2021 17:14:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5D73C000B;
	Thu,  8 Apr 2021 17:14:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 238ABC000A
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:14:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with UTF8SMTP id E304484DF2
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:14:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id 1R9AZql9P-os for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 17:14:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
 by smtp1.osuosl.org (Postfix) with UTF8SMTPS id B61C384DA1
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:14:33 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1617902075; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Kinp2/XcznxYkI6yk4QzKyMTDgqXofgknrPIucEkt0E=;
 b=n+CN0308bKXps1aHDIZ8FYOc5yypW3Tbb8iGqndhPzfWJk8yE7QJnlCX1mfkWmsuzibCy2uc
 KSKWV8M7Nc4sUGmZoH2htpCWuDqpax9SZKUkNzsWflttlYQQdn4sWOaLSHH/mQbHTLHonaNo
 mjMU0TAlsIlyNTgjjwX/CcvdzPw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 606f39f19a9ff96d95d90ccd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 08 Apr 2021 17:14:25
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id EAD75C43464; Thu,  8 Apr 2021 17:14:24 +0000 (UTC)
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id D781FC433C6;
 Thu,  8 Apr 2021 17:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D781FC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=isaacm@codeaurora.org
From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
To: iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v5 13/15] iommu/io-pgtable-arm-v7s: Implement
 arm_v7s_map_pages()
Date: Thu,  8 Apr 2021 10:14:00 -0700
Message-Id: <20210408171402.12607-14-isaacm@codeaurora.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210408171402.12607-1-isaacm@codeaurora.org>
References: <20210408171402.12607-1-isaacm@codeaurora.org>
MIME-Version: 1.0
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>, robin.murphy@arm.com,
 will@kernel.org, pratikp@codeaurora.org
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

Implement the map_pages() callback for the ARM v7s io-pgtable
format.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 1af060686985..3331caafb273 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -519,11 +519,12 @@ static int __arm_v7s_map(struct arm_v7s_io_pgtable *data, unsigned long iova,
 	return __arm_v7s_map(data, iova, paddr, size, prot, lvl + 1, cptep, gfp);
 }
 
-static int arm_v7s_map(struct io_pgtable_ops *ops, unsigned long iova,
-			phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+static int arm_v7s_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
+			     phys_addr_t paddr, size_t pgsize, size_t pgcount,
+			     int prot, gfp_t gfp, size_t *mapped)
 {
 	struct arm_v7s_io_pgtable *data = io_pgtable_ops_to_data(ops);
-	int ret;
+	int ret = -EINVAL;
 
 	if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias) ||
 		    paddr >= (1ULL << data->iop.cfg.oas)))
@@ -533,7 +534,17 @@ static int arm_v7s_map(struct io_pgtable_ops *ops, unsigned long iova,
 	if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
 		return 0;
 
-	ret = __arm_v7s_map(data, iova, paddr, size, prot, 1, data->pgd, gfp);
+	while (pgcount--) {
+		ret = __arm_v7s_map(data, iova, paddr, pgsize, prot, 1, data->pgd,
+				    gfp);
+		if (ret)
+			break;
+
+		iova += pgsize;
+		paddr += pgsize;
+		if (mapped)
+			*mapped += pgsize;
+	}
 	/*
 	 * Synchronise all PTE updates for the new mapping before there's
 	 * a chance for anything to kick off a table walk for the new iova.
@@ -543,6 +554,12 @@ static int arm_v7s_map(struct io_pgtable_ops *ops, unsigned long iova,
 	return ret;
 }
 
+static int arm_v7s_map(struct io_pgtable_ops *ops, unsigned long iova,
+			phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+{
+	return arm_v7s_map_pages(ops, iova, paddr, size, 1, prot, gfp, NULL);
+}
+
 static void arm_v7s_free_pgtable(struct io_pgtable *iop)
 {
 	struct arm_v7s_io_pgtable *data = io_pgtable_to_data(iop);
@@ -797,6 +814,7 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 
 	data->iop.ops = (struct io_pgtable_ops) {
 		.map		= arm_v7s_map,
+		.map_pages	= arm_v7s_map_pages,
 		.unmap		= arm_v7s_unmap,
 		.unmap_pages	= arm_v7s_unmap_pages,
 		.iova_to_phys	= arm_v7s_iova_to_phys,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
