Return-Path: <SRS0=WBHG=I5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7C4C433E0
	for <iommu@archiver.kernel.org>; Wed, 31 Mar 2021 03:01:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89A3761994
	for <iommu@archiver.kernel.org>; Wed, 31 Mar 2021 03:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A3761994
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 365FD401E4;
	Wed, 31 Mar 2021 03:01:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HlpaaSwDf6u1; Wed, 31 Mar 2021 03:01:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0B76640229;
	Wed, 31 Mar 2021 03:01:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F39A9C000B;
	Wed, 31 Mar 2021 03:01:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9DAB8C000B
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 03:01:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id 8996F401E4
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 03:01:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id oObCootL9ZpZ for <iommu@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 03:01:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id 8DB814021B
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 03:01:06 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1617159667; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=VdXHPZJSDmISZ6NDwwhdheg2c+ORHCKvYxeiioCDZBY=;
 b=nhs0fCHI2to7BrLC5mhHz97wC9naNwvrLnI0J1N2sqJme6V1za2srao+Yk2Q0zecxbB/h8Ib
 Veurk1029VqZW8K6mTOszKm90V9FXwpQVfk6iW1qGK5AVD8sPE2ird0+aQz872R1lwoVzWiG
 rNprtfxmVsPeiJ9YXy15FpfPm/s=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6063e5ed197975f05e067410 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 31 Mar 2021 03:01:01
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 5295FC433ED; Wed, 31 Mar 2021 03:01:01 +0000 (UTC)
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 8A340C43462;
 Wed, 31 Mar 2021 03:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8A340C43462
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=isaacm@codeaurora.org
From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
To: iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 3/5] iommu: Add support for the unmap_pages IOMMU callback
Date: Tue, 30 Mar 2021 20:00:40 -0700
Message-Id: <20210331030042.13348-4-isaacm@codeaurora.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210331030042.13348-1-isaacm@codeaurora.org>
References: <20210331030042.13348-1-isaacm@codeaurora.org>
MIME-Version: 1.0
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>, will@kernel.org,
 robin.murphy@arm.com, pratikp@codeaurora.org
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

The IOMMU framework currently unmaps memory one page block at a time,
per the page block sizes that are supported by the IOMMU hardware.
Now that IOMMU drivers can supply a callback for unmapping multiple
in one call, add support in the IOMMU framework to calculate how many
page mappings of the same size can be unmapped in one shot, and invoke the
IOMMU driver's unmap_pages callback if it has one. Otherwise, the
existing behavior will be used.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Suggested-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/iommu.c | 44 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d0b0a15dba84..dc4295f6bc7f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2356,8 +2356,8 @@ phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 }
 EXPORT_SYMBOL_GPL(iommu_iova_to_phys);
 
-static size_t iommu_pgsize(struct iommu_domain *domain,
-			   unsigned long addr_merge, size_t size)
+static size_t __iommu_pgsize(struct iommu_domain *domain,
+			     unsigned long addr_merge, size_t size)
 {
 	unsigned int pgsize_idx;
 	size_t pgsize;
@@ -2388,6 +2388,24 @@ static size_t iommu_pgsize(struct iommu_domain *domain,
 	return pgsize;
 }
 
+static size_t iommu_pgsize(struct iommu_domain *domain,
+			   unsigned long addr_merge, size_t size,
+			   size_t *pgcount)
+{
+	size_t pgsize = __iommu_pgsize(domain, addr_merge, size);
+	size_t pgs = 0;
+
+	do {
+		pgs++;
+		size -= pgsize;
+		addr_merge += pgsize;
+	} while (size && __iommu_pgsize(domain, addr_merge, size) == pgsize);
+
+	*pgcount = pgs;
+
+	return pgsize;
+}
+
 static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
 		       phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
 {
@@ -2422,7 +2440,7 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
 	pr_debug("map: iova 0x%lx pa %pa size 0x%zx\n", iova, &paddr, size);
 
 	while (size) {
-		size_t pgsize = iommu_pgsize(domain, iova | paddr, size);
+		size_t pgsize = __iommu_pgsize(domain, iova | paddr, size);
 
 		pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx\n",
 			 iova, &paddr, pgsize);
@@ -2473,6 +2491,21 @@ int iommu_map_atomic(struct iommu_domain *domain, unsigned long iova,
 }
 EXPORT_SYMBOL_GPL(iommu_map_atomic);
 
+static size_t __iommu_unmap_pages(struct iommu_domain *domain, unsigned long iova,
+				  size_t size, struct iommu_iotlb_gather *iotlb_gather)
+{
+	const struct iommu_ops *ops = domain->ops;
+	size_t pgsize, pgcount;
+
+	if (ops->unmap_pages) {
+		pgsize = iommu_pgsize(domain, iova, size, &pgcount);
+		return ops->unmap_pages(domain, iova, pgsize, pgcount, iotlb_gather);
+	}
+
+	pgsize = __iommu_pgsize(domain, iova, size);
+	return ops->unmap(domain, iova, pgsize, iotlb_gather);
+}
+
 static size_t __iommu_unmap(struct iommu_domain *domain,
 			    unsigned long iova, size_t size,
 			    struct iommu_iotlb_gather *iotlb_gather)
@@ -2510,9 +2543,8 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 	 * or we hit an area that isn't mapped.
 	 */
 	while (unmapped < size) {
-		size_t pgsize = iommu_pgsize(domain, iova, size - unmapped);
-
-		unmapped_page = ops->unmap(domain, iova, pgsize, iotlb_gather);
+		unmapped_page = __iommu_unmap_pages(domain, iova, size - unmapped,
+						    iotlb_gather);
 		if (!unmapped_page)
 			break;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
