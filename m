Return-Path: <SRS0=vLlZ=GM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A51C433E0
	for <iommu@archiver.kernel.org>; Sat,  9 Jan 2021 01:50:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BE6623A1E
	for <iommu@archiver.kernel.org>; Sat,  9 Jan 2021 01:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE6623A1E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CE813203EF;
	Sat,  9 Jan 2021 01:50:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 71JhETKQ6Lyr; Sat,  9 Jan 2021 01:50:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 32F9F20444;
	Sat,  9 Jan 2021 01:50:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D757C088B;
	Sat,  9 Jan 2021 01:50:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5345AC013A
 for <iommu@lists.linux-foundation.org>; Sat,  9 Jan 2021 01:50:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3C394203EF
 for <iommu@lists.linux-foundation.org>; Sat,  9 Jan 2021 01:50:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UvSuWpIBtdz7 for <iommu@lists.linux-foundation.org>;
 Sat,  9 Jan 2021 01:50:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m43-15.mailgun.net (m43-15.mailgun.net [69.72.43.15])
 by silver.osuosl.org (Postfix) with ESMTPS id 230432001A
 for <iommu@lists.linux-foundation.org>; Sat,  9 Jan 2021 01:50:46 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1610157046; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=4VlYJjycp9thhHjeXNULwYOSsBipk6tgLXy1jq906Q8=;
 b=SyNarBiKJQh690fB01bc405WO4wIV0/+QYB/hSj1c5F4lROgThndA4eUXCU1fjIIR18RiI6P
 X43Jht3Cn2uyD8pUV9V1HFGUGVoCdgvEbIEuzmHZ9MuRepbMltoV5iQLdeV/KWdXEdBbm81T
 rfXkvMe4mD8pQKxRF0GHBF8STO0=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5ff90bf4d84bad354727cdb6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 09 Jan 2021 01:50:44
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 5C59FC43462; Sat,  9 Jan 2021 01:50:44 +0000 (UTC)
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 32180C433C6;
 Sat,  9 Jan 2021 01:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 32180C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=isaacm@codeaurora.org
From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
To: will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org
Subject: [PATCH 1/5] iommu/io-pgtable: Introduce map_sg() as a page table op
Date: Fri,  8 Jan 2021 17:50:27 -0800
Message-Id: <1610157031-26301-2-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610157031-26301-1-git-send-email-isaacm@codeaurora.org>
References: <1610157031-26301-1-git-send-email-isaacm@codeaurora.org>
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>, pdaly@codeaurora.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 pratikp@codeaurora.org, linux-arm-kernel@lists.infradead.org
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

While mapping a scatter-gather list, iommu_map_sg() calls
into the IOMMU driver through an indirect call, which can
call into the io-pgtable code through another indirect call.

This sequence of going through the IOMMU core code, the IOMMU
driver, and finally the io-pgtable code, occurs for every
element in the scatter-gather list, in the worse case, which
is not optimal.

Introduce a map_sg callback in the io-pgtable ops so that
IOMMU drivers can invoke it with the complete scatter-gather
list, so that it can be processed within the io-pgtable
code entirely, reducing the number of indirect calls, and
boosting overall iommu_map_sg() performance.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
---
 include/linux/io-pgtable.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index ea727eb..6d0e731 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -147,6 +147,9 @@ struct io_pgtable_cfg {
  * struct io_pgtable_ops - Page table manipulation API for IOMMU drivers.
  *
  * @map:          Map a physically contiguous memory region.
+ * @map_sg:       Map a scatter-gather list of physically contiguous memory
+ *                chunks. The mapped pointer argument is used to store how
+ *                many bytes are mapped.
  * @unmap:        Unmap a physically contiguous memory region.
  * @iova_to_phys: Translate iova to physical address.
  *
@@ -156,6 +159,9 @@ struct io_pgtable_cfg {
 struct io_pgtable_ops {
 	int (*map)(struct io_pgtable_ops *ops, unsigned long iova,
 		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
+	int (*map_sg)(struct io_pgtable_ops *ops, unsigned long iova,
+		      struct scatterlist *sg, unsigned int nents, int prot,
+		      gfp_t gfp, size_t *mapped);
 	size_t (*unmap)(struct io_pgtable_ops *ops, unsigned long iova,
 			size_t size, struct iommu_iotlb_gather *gather);
 	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
