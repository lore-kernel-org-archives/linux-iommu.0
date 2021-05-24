Return-Path: <SRS0=tLZ8=KU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA1FC4707F
	for <iommu@archiver.kernel.org>; Tue, 25 May 2021 06:11:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABA1561413
	for <iommu@archiver.kernel.org>; Tue, 25 May 2021 06:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA1561413
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8EC5C83C02;
	Tue, 25 May 2021 06:11:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LZ5TfiTXzWE8; Tue, 25 May 2021 06:11:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 74C2C83C27;
	Tue, 25 May 2021 06:11:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D281C000D;
	Tue, 25 May 2021 06:11:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9DE99C000F
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 06:11:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8B702403FA
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 06:11:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OCS4yYKlVgRo for <iommu@lists.linux-foundation.org>;
 Tue, 25 May 2021 06:11:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0165E402C5
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 06:11:18 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id kr9so8132236pjb.5
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 23:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5X0JTQzlcxqdyb4573dS6/kX2Ui7vOskaKMybRf6Z5M=;
 b=QgBp8x8FA2KPnES/dXAn7UcCsCOFA05H9EKrKDO48k6YYBUAhh07XYM9uYgjpSP//s
 wjwVjOuQhIZOhQEECLcGg8hM8x+tMr0DhXvrv5JX8aKFXsjnPjpkcv4A2+6/39D+JqYl
 yj1Dr3DlNH5pqAVISRx7Q3riYVQKMkhHsNkGwMBNAMBIEMyO7VSDyXBv45RvG8FvFEUM
 QJcXdStU7Sj+E3O4JNeMoKi649ar/p8H8qDeGIhvzpyAU8557NGj2Ny3YEXafUcmU7sP
 /gVg9F81tv19dJtui3KYYQdnwvAe/jUiVUViABHrxt5r7+NzvmCP1gwfe9V2ceyQoIrf
 6q1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5X0JTQzlcxqdyb4573dS6/kX2Ui7vOskaKMybRf6Z5M=;
 b=XZwqrptPZo0VtPnSWUaW4sFcspNdHy+UDODu1nEK5gPfKFIOro1/dbfjNr/gr4E2Py
 E0Kkqm7pKjgTqXnIMRBR4n9Hl6MTC9cIFQL7LxTE4uk2ox+Yx3/ft4+whvt9hTtwohIk
 nmLpx5O1ARS4V4dDXt6QdBVlqj8a6yp8Klfk+CNZJrYWu9EwtWC0sEKojJU4GQio1t2B
 J+sZwabZN0bzsNs5IyQ+lF3lqiiw7/G/iy8EmlFmryQVH3WD5iz0DS/f1tHOfNYfJj5s
 G5rpSEdqds3NiYNBeCKnU5NbknVZjyuNzxi3+wf7HY3s0GegoSNBqiEAUCfLUAM7czRj
 Sw7Q==
X-Gm-Message-State: AOAM532Po+SqTrELsfAxh0ZEj1JMwRo/5EbhC1pPJkPL+oayevOW9cIK
 VrABMFJsFyxOTUFmH7zmJHw=
X-Google-Smtp-Source: ABdhPJwhUvJIWH0mcgvnZ+wLhlOua8AfWHv+OxZnzNEVOB4+EUASL4Y1XAHQzwLi8Mqxf+5g9X+giA==
X-Received: by 2002:a17:902:d643:b029:ef:62cd:eeed with SMTP id
 y3-20020a170902d643b02900ef62cdeeedmr29296314plh.42.1621923078362; 
 Mon, 24 May 2021 23:11:18 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id h3sm12452301pgp.10.2021.05.24.23.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 May 2021 23:11:17 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 3/4] iommu/amd: Do not sync on page size changes
Date: Mon, 24 May 2021 15:41:58 -0700
Message-Id: <20210524224159.32807-4-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210524224159.32807-1-namit@vmware.com>
References: <20210524224159.32807-1-namit@vmware.com>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
 Nadav Amit <namit@vmware.com>, Jiajun Cao <caojiajun@vmware.com>,
 linux-kernel@vger.kernel.org
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

From: Nadav Amit <namit@vmware.com>

Some IOMMU architectures perform invalidations regardless of the page
size. In such architectures there is no need to sync when the page size
changes or to regard pgsize when making interim flush in
iommu_iotlb_gather_add_page().

Add a "ignore_gather_pgsize" property for each IOMMU-ops to decide
whether gather's pgsize is tracked and triggers a flush.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/iommu/amd/iommu.c | 1 +
 include/linux/iommu.h     | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b8cabbbeed71..1849b53f2149 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2215,6 +2215,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.put_resv_regions = generic_iommu_put_resv_regions,
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
+	.ignore_gather_pgsize = true,
 	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
 	.iotlb_sync = amd_iommu_iotlb_sync,
 	.def_domain_type = amd_iommu_def_domain_type,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 32d448050bf7..1fb2695418e9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -284,6 +284,7 @@ struct iommu_ops {
 	int (*def_domain_type)(struct device *dev);
 
 	unsigned long pgsize_bitmap;
+	bool ignore_gather_pgsize;
 	struct module *owner;
 };
 
@@ -508,7 +509,7 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
 	 * a different granularity, then sync the TLB so that the gather
 	 * structure can be rewritten.
 	 */
-	if (gather->pgsize != size ||
+	if ((gather->pgsize != size && !domain->ops->ignore_gather_pgsize) ||
 	    end + 1 < gather->start || start > gather->end + 1) {
 		if (gather->pgsize)
 			iommu_iotlb_sync(domain, gather);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
