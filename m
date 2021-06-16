Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABEEC49361
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 13:39:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2190E6135C
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 13:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2190E6135C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E959960AAD;
	Wed, 16 Jun 2021 13:39:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CZo5O-bK_8HX; Wed, 16 Jun 2021 13:39:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 816FC6070F;
	Wed, 16 Jun 2021 13:39:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B557FC0025;
	Wed, 16 Jun 2021 13:39:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03159C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 13:39:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 88B0383A3E
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 13:39:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=quicinc.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WugwEmugVZA2 for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 13:39:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com
 [199.106.114.39])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CB82383B0B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 13:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1623850753; x=1655386753;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=+HFv+DKvnPCPsWuXWYMZKBwCYe6e05uqYXwhKa4C3YE=;
 b=p+O7poGs4vEBHIVltbfN7LovgLs6+OKAmUw8/yhYusL+A7PMGEyc/iQ1
 Zh/12HoLHduBANAFuTURCbX5uRCoX0yDk/DL/7VkXWqVBS5h3dButvMZQ
 wpQvB1kgBq3pF1o6fo3JvmQHzFmV1ImteP52nenXukEy32CvgDE07NsQB w=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 16 Jun 2021 06:39:12 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
 by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 16 Jun 2021 06:39:09 -0700
Received: from th-lint-040.qualcomm.com (10.80.80.8) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Wed, 16 Jun 2021 06:39:08 -0700
From: Georgi Djakov <quic_c_gdjako@quicinc.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH v7 08/15] iommu: Add support for the map_pages() callback
Date: Wed, 16 Jun 2021 06:38:49 -0700
Message-ID: <1623850736-389584-9-git-send-email-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623850736-389584-1-git-send-email-quic_c_gdjako@quicinc.com>
References: <1623850736-389584-1-git-send-email-quic_c_gdjako@quicinc.com>
MIME-Version: 1.0
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03h.na.qualcomm.com (10.85.0.50) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Cc: isaacm@codeaurora.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, djakov@kernel.org, pratikp@codeaurora.org,
 linux-arm-kernel@lists.infradead.org
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

From: "Isaac J. Manjarres" <isaacm@codeaurora.org>

Since iommu_pgsize can calculate how many pages of the
same size can be mapped/unmapped before the next largest
page size boundary, add support for invoking an IOMMU
driver's map_pages() callback, if it provides one.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 drivers/iommu/iommu.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 725622c7e603..70a729ce88b1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2429,6 +2429,30 @@ static size_t iommu_pgsize(struct iommu_domain *domain, unsigned long iova,
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
+	pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx count %zu\n",
+		 iova, &paddr, pgsize, count);
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
@@ -2439,7 +2463,7 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
 	phys_addr_t orig_paddr = paddr;
 	int ret = 0;
 
-	if (unlikely(ops->map == NULL ||
+	if (unlikely(!(ops->map || ops->map_pages) ||
 		     domain->pgsize_bitmap == 0UL))
 		return -ENODEV;
 
@@ -2463,18 +2487,21 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
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
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
