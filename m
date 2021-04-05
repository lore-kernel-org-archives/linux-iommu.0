Return-Path: <SRS0=tsXo=JC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ADCC433ED
	for <iommu@archiver.kernel.org>; Mon,  5 Apr 2021 19:11:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A626613A3
	for <iommu@archiver.kernel.org>; Mon,  5 Apr 2021 19:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A626613A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D3628481B;
	Mon,  5 Apr 2021 19:11:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wXSAzAlnsu7u; Mon,  5 Apr 2021 19:11:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3068A84818;
	Mon,  5 Apr 2021 19:11:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17A6DC000C;
	Mon,  5 Apr 2021 19:11:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 610D6C000A
 for <iommu@lists.linux-foundation.org>; Mon,  5 Apr 2021 19:11:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with UTF8SMTP id C8B9984802
 for <iommu@lists.linux-foundation.org>; Mon,  5 Apr 2021 19:11:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id gdBXait-djKo for <iommu@lists.linux-foundation.org>;
 Mon,  5 Apr 2021 19:11:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by smtp1.osuosl.org (Postfix) with UTF8SMTPS id 54E6184818
 for <iommu@lists.linux-foundation.org>; Mon,  5 Apr 2021 19:11:48 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1617649910; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=T1rDy9H/oQwVbF+T7wKkdUNYf11coYL1xpPz6J/DQUs=;
 b=Bsoimca0Kst9a1mTGm7q0qMrQ0lqVh+11NSFyhp4i5gXwobXWwSkng4VSsqRpO0tVjmsAW1s
 N65YUNmx3rGvmaATmO59IW2vWsInqaUjf+6hyLKc66h3lqRiGx5enye8hH2qyCH1/90gpgjk
 5XEnqWpMneoJaN1GbEoZrlmzKp0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 606b60e3f34440a9d4291546 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 05 Apr 2021 19:11:31
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id B23D2C43464; Mon,  5 Apr 2021 19:11:31 +0000 (UTC)
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id A682AC433CA;
 Mon,  5 Apr 2021 19:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A682AC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=isaacm@codeaurora.org
From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
To: iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v3 05/12] iommu: Use bitmap to calculate page size in
 iommu_pgsize()
Date: Mon,  5 Apr 2021 12:11:05 -0700
Message-Id: <20210405191112.28192-6-isaacm@codeaurora.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210405191112.28192-1-isaacm@codeaurora.org>
References: <20210405191112.28192-1-isaacm@codeaurora.org>
MIME-Version: 1.0
Cc: "Isaac J . Manjarres" <isaacm@codeaurora.org>, robin.murphy@arm.com,
 Will Deacon <will@kernel.org>, pratikp@codeaurora.org
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

From: Will Deacon <will@kernel.org>

Avoid the potential for shifting values by amounts greater than the
width of their type by using a bitmap to compute page size in
iommu_pgsize().

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
---
 drivers/iommu/iommu.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d0b0a15dba84..9006397b6604 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -8,6 +8,7 @@
 
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/bits.h>
 #include <linux/bug.h>
 #include <linux/types.h>
 #include <linux/init.h>
@@ -2360,30 +2361,22 @@ static size_t iommu_pgsize(struct iommu_domain *domain,
 			   unsigned long addr_merge, size_t size)
 {
 	unsigned int pgsize_idx;
+	unsigned long pgsizes;
 	size_t pgsize;
 
-	/* Max page size that still fits into 'size' */
-	pgsize_idx = __fls(size);
+	/* Page sizes supported by the hardware and small enough for @size */
+	pgsizes = domain->pgsize_bitmap & GENMASK_ULL(__fls(size), 0);
 
-	/* need to consider alignment requirements ? */
-	if (likely(addr_merge)) {
-		/* Max page size allowed by address */
-		unsigned int align_pgsize_idx = __ffs(addr_merge);
-		pgsize_idx = min(pgsize_idx, align_pgsize_idx);
-	}
-
-	/* build a mask of acceptable page sizes */
-	pgsize = (1UL << (pgsize_idx + 1)) - 1;
-
-	/* throw away page sizes not supported by the hardware */
-	pgsize &= domain->pgsize_bitmap;
+	/* Constrain the page sizes further based on the maximum alignment */
+	if (likely(addr_merge))
+		pgsizes &= GENMASK_ULL(__ffs(addr_merge), 0);
 
-	/* make sure we're still sane */
-	BUG_ON(!pgsize);
+	/* Make sure we have at least one suitable page size */
+	BUG_ON(!pgsizes);
 
-	/* pick the biggest page */
-	pgsize_idx = __fls(pgsize);
-	pgsize = 1UL << pgsize_idx;
+	/* Pick the biggest page size remaining */
+	pgsize_idx = __fls(pgsizes);
+	pgsize = BIT_ULL(pgsize_idx);
 
 	return pgsize;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
