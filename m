Return-Path: <SRS0=DOhO=I7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBA3C43461
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 01:35:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F57E6108B
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 01:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F57E6108B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4055B60D5E;
	Fri,  2 Apr 2021 01:35:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kiZwktpXwz3q; Fri,  2 Apr 2021 01:35:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 314D560D5A;
	Fri,  2 Apr 2021 01:35:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7774DC0018;
	Fri,  2 Apr 2021 01:35:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D0CFC0011
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 01:35:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id B216A41934
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 01:35:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id IS02NZw18eDv for <iommu@lists.linux-foundation.org>;
 Fri,  2 Apr 2021 01:35:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id BD850418F8
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 01:35:14 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1617327316; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=n5zYC0BYKy0nogtYZy+GfxMC3+LNKp7fbIHX0iNHV+4=;
 b=ZVTk5qpmvd5OcQ5ZixvYZ2sasSyUIknhTtWNfKYSPsxGivyxaPfKDlfOEIEr+OZyYaYIsGyX
 oaOEr2Y8R2STjnjOgo7fswd089V1jrw6CneZwCOl2ux3FeMFZ8bS0G8T6bRKOJV5HhhZijQi
 2OhZgcuKmPaPNc/s1WVspF0noH8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 606674cefebcffa80f984ce4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 02 Apr 2021 01:35:10
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id CE708C43467; Fri,  2 Apr 2021 01:35:10 +0000 (UTC)
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 9DEB8C433CA;
 Fri,  2 Apr 2021 01:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9DEB8C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=isaacm@codeaurora.org
From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
To: iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 08/12] iommu: Add support for the map_pages() callback
Date: Thu,  1 Apr 2021 18:34:47 -0700
Message-Id: <20210402013452.4013-9-isaacm@codeaurora.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210402013452.4013-1-isaacm@codeaurora.org>
References: <20210402013452.4013-1-isaacm@codeaurora.org>
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

Since iommu_pgsize can calculate how many pages of the
same size can be mapped/unmapped before the next largest
page size boundary, add support for invoking an IOMMU
driver's map_pages() callback, if it provides one.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Suggested-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/iommu.c | 41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5cae2a29fdc9..167983195858 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2412,6 +2412,30 @@ static size_t iommu_pgsize(struct iommu_domain *domain, unsigned long iova,
 	return pgsize;
 }
 
+static int __iommu_map_pages(struct iommu_domain *domain, unsigned long iova,
+			     phys_addr_t paddr, size_t size, int prot,
+			     gfp_t gfp, size_t *mapped)
+{
+	const struct iommu_ops *ops = domain->ops;
+	size_t pgsize, count;
+	int ret;
+
+	pgsize = iommu_pgsize(domain, iova, paddr, size, &count);
+
+	pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx count %ld\n",
+			 iova, &paddr, pgsize, count);
+
+	if (ops->map_pages) {
+		ret = ops->map_pages(domain, iova, paddr, pgsize, count, prot,
+				     gfp, mapped);
+	} else {
+		ret = ops->map(domain, iova, paddr, pgsize, prot, gfp);
+		*mapped = ret ? 0 : pgsize;
+	}
+
+	return ret;
+}
+
 static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
 		       phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
 {
@@ -2446,18 +2470,21 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
 	pr_debug("map: iova 0x%lx pa %pa size 0x%zx\n", iova, &paddr, size);
 
 	while (size) {
-		size_t pgsize = iommu_pgsize(domain, iova, paddr, size, NULL);
+		size_t mapped = 0;
 
-		pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx\n",
-			 iova, &paddr, pgsize);
-		ret = ops->map(domain, iova, paddr, pgsize, prot, gfp);
+		ret = __iommu_map_pages(domain, iova, paddr, size, prot, gfp,
+					&mapped);
+		/*
+		 * Some pages may have been mapped, even if an error occurred,
+		 * so we should account for those so they can be unmapped.
+		 */
+		size -= mapped;
 
 		if (ret)
 			break;
 
-		iova += pgsize;
-		paddr += pgsize;
-		size -= pgsize;
+		iova += mapped;
+		paddr += mapped;
 	}
 
 	/* unroll mapping in case something went wrong */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
