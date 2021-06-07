Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C40C48BCD
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 01:55:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BE7361375
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 01:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE7361375
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D9244041C;
	Tue,  8 Jun 2021 01:55:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6z3puF1LdJ0L; Tue,  8 Jun 2021 01:55:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 404F6403DF;
	Tue,  8 Jun 2021 01:55:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DA23C000E;
	Tue,  8 Jun 2021 01:55:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F4B1C001C
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 01:55:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 490896089A
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 01:55:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RUEMTyVPLZOE for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 01:55:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B3B2E6088B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 01:55:22 +0000 (UTC)
Received: by mail-pf1-x42a.google.com with SMTP id u18so14478513pfk.11
 for <iommu@lists.linux-foundation.org>; Mon, 07 Jun 2021 18:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jWMknRbD8X1K6AG9lburjdKW9p491bZf6T9lQOWSxxM=;
 b=UfAkBGhzytTvY7tWO2nFI9gbpg7gzUZFQmZlmkhoLHVzezMdznstTDtKM8jB4JgeNL
 gWZEJMhiozQYik5Z26mB7KxyS5p5LTpD/ZiP/Uxyiu5gtnqDBo1pBUrXn45YPt0+ZVcG
 aCE3+b9R4o+HrmBCTknwtG9XAX+87es7bRRsFvIKABtU0AXVZK6Ye5Ms4ovvcPMIbsMD
 I0NrtcQI8XM4OyfgSjRLkon9m5+I2FU6a/xo/Im5VjjxAS9/OrbYri0V0jkeZY4SrTDw
 kTC8NgXhZ3J4W94L0S5tIwwc4nfyvzbfU24hiTGMEW4wY9pmnbzNMEA8T/lcW4KXMlzw
 kOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jWMknRbD8X1K6AG9lburjdKW9p491bZf6T9lQOWSxxM=;
 b=rvnoucLR9kGhpJwgAkL83DEdPX39Rh2AIG+ZBWOODZD5f44+mVKgyvEyQuvupxy6TS
 3KDe9rCRSIzRY3ODU/i/+IcXPk0xa61DtRaqCLe/AYVKcfi5Xg35KkiPmlHMxMsGBrCL
 alV0XCyJD2XiC3OOPUe44f687xTle1V8G/9FLD/IQ0SPywVsvwHyV/RpVngAX1W2FWdT
 v3zTXFFrafm44YeZ5SMAetkrTmlVct9thH2ejVpOy4ZimQ57Nyxuvzw66g86RIAJLEOl
 PxRr0nlOIiO3wknKIAEVOjGyKzM6DQ9QthFo/KerZaQRdwxIkhl9VPL9bpCoHRnXHeZg
 jB+A==
X-Gm-Message-State: AOAM531GSZe3cad62+NOhdStmMyHEy6VzwygGl6PcNVPaFxg6/1n6e5D
 ejfagGExpz6hiDID7M1xpOM=
X-Google-Smtp-Source: ABdhPJwGEQVYFg2a77oHAedrv7L7WnwzgJdO94nMtzoSPhpt1EFs6Z4XMU6b3oNq6dW9pWRYQBShgA==
X-Received: by 2002:a62:6491:0:b029:28e:8c90:6b16 with SMTP id
 y139-20020a6264910000b029028e8c906b16mr19157988pfb.24.1623117322049; 
 Mon, 07 Jun 2021 18:55:22 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id s24sm9284767pfh.104.2021.06.07.18.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jun 2021 18:55:21 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 1/6] iommu/amd: Selective flush on unmap
Date: Mon,  7 Jun 2021 11:25:36 -0700
Message-Id: <20210607182541.119756-2-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607182541.119756-1-namit@vmware.com>
References: <20210607182541.119756-1-namit@vmware.com>
MIME-Version: 1.0
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Nadav Amit <namit@vmware.com>,
 Jiajun Cao <caojiajun@vmware.com>, Will Deacon <will@kernel.org>
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

Recent patch attempted to enable selective page flushes on AMD IOMMU but
neglected to adapt amd_iommu_iotlb_sync() to use the selective flushes.

Adapt amd_iommu_iotlb_sync() to use selective flushes and change
amd_iommu_unmap() to collect the flushes. As a defensive measure, to
avoid potential issues as those that the Intel IOMMU driver encountered
recently, flush the page-walk caches by always setting the "pde"
parameter. This can be removed later.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/iommu/amd/iommu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3ac42bbdefc6..3e40f6610b6a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2059,12 +2059,17 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 {
 	struct protection_domain *domain = to_pdomain(dom);
 	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
+	size_t r;
 
 	if ((amd_iommu_pgtable == AMD_IOMMU_V1) &&
 	    (domain->iop.mode == PAGE_MODE_NONE))
 		return 0;
 
-	return (ops->unmap) ? ops->unmap(ops, iova, page_size, gather) : 0;
+	r = (ops->unmap) ? ops->unmap(ops, iova, page_size, gather) : 0;
+
+	iommu_iotlb_gather_add_page(dom, gather, iova, page_size);
+
+	return r;
 }
 
 static phys_addr_t amd_iommu_iova_to_phys(struct iommu_domain *dom,
@@ -2167,7 +2172,13 @@ static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
 static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
 				 struct iommu_iotlb_gather *gather)
 {
-	amd_iommu_flush_iotlb_all(domain);
+	struct protection_domain *dom = to_pdomain(domain);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dom->lock, flags);
+	__domain_flush_pages(dom, gather->start, gather->end - gather->start, 1);
+	amd_iommu_domain_flush_complete(dom);
+	spin_unlock_irqrestore(&dom->lock, flags);
 }
 
 static int amd_iommu_def_domain_type(struct device *dev)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
