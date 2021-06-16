Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AEEC49EA4
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 17:34:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 678C661241
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 17:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678C661241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 41844404CA;
	Wed, 16 Jun 2021 17:34:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bky3JP1G-wRZ; Wed, 16 Jun 2021 17:34:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1FD6F404DF;
	Wed, 16 Jun 2021 17:34:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5F11C0028;
	Wed, 16 Jun 2021 17:34:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA66CC0024
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 17:34:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 861848322E
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 17:34:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vxnx-93e8a8Z for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 17:34:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F24118321B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 17:34:33 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id p13so2824838pfw.0
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 10:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TtYQyL17NXLLpd8+5ExNmMBmbaQCRFOGIzgQ/aCfSeo=;
 b=osZrJ4WYIlJ61BclVIFe2+s1W/jbU27ZXJFZHNkTruocrdtfL0YG5EPsmrHn1dvAXd
 MO3P1d+RVZiAjnuyetS34JsTPQyo71cXezXHjaWOWAoQFBvnZ61gtEsSOL+OTpRUAydr
 5xCGn+FzuT6gyBu5UR5p8d3O1bKWMolqa2R9ed+HHdPpZ5NncAZRAJsucO6Bd29R+8Si
 GtYNUuZvLayo6bCAPMGMyOsK8L2FgFQlZIiQrQIO34dKRja1FgCBAhEqSH/2VgnauDB/
 nf/nqqZO4/cnoB2dJdnN0wjGRhvOqVKh+HRr1pQUNHbgSVfnGm0HaiRpzX3IY8H7f4+h
 68kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TtYQyL17NXLLpd8+5ExNmMBmbaQCRFOGIzgQ/aCfSeo=;
 b=rCsYidZYbUks4+m1Ais3xw529SY+UWLWQcprYL30LGy/vfgu7J5vsAHizcqZPgFQoi
 WoemctrSHulPbvfJkbomGdyPmdcJvmo6kg6YwI+ZXGkCb9cDS/Nb9T4nFv526EoL9DWx
 CwTm2r/9E/mu7sBq1SGlfR8kSfoAv5S+0asV86yoXe3zxXcEwPDMUESMEU3T+J6Bgcr/
 goNe7vmmScQA6YCLtsKgfb8kD/h/Sd7rtu2kBdhRlDfljMX1+HUXFf3IbqIEOU7DAvpl
 wv+6p5Jk8HuwsYTxo3r7FFIRFI4FHaODCipeZatdQs+nq1U91K2wnTzd7qhUjf0IFcuy
 lfzw==
X-Gm-Message-State: AOAM530uUB5315svMGWxLj4rA1lNbLKDRx8C+5F7yKWXat4iYUW0Nq7b
 ljwTdLw8jhyvOj7pJvwvnJU=
X-Google-Smtp-Source: ABdhPJy4TGe1/L0cKdOSHYY6tdqLsx5sS5YYkFi6Ks+/40geabirSgT8s1I6NfYaiN0lDnC6au++gQ==
X-Received: by 2002:a62:aa01:0:b029:2ea:743:6693 with SMTP id
 e1-20020a62aa010000b02902ea07436693mr902083pff.68.1623864873264; 
 Wed, 16 Jun 2021 10:34:33 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id m3sm2933901pfh.174.2021.06.16.10.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jun 2021 10:34:32 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v4 7/7] iommu/amd: Use only natural aligned flushes in a VM
Date: Wed, 16 Jun 2021 03:05:00 -0700
Message-Id: <20210616100500.174507-8-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616100500.174507-1-namit@vmware.com>
References: <20210616100500.174507-1-namit@vmware.com>
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

When running on an AMD vIOMMU, it is better to avoid TLB flushes
of unmodified PTEs. vIOMMUs require the hypervisor to synchronize the
virtualized IOMMU's PTEs with the physical ones. This process induce
overheads.

AMD IOMMU allows us to flush any range that is aligned to the power of
2. So when running on top of a vIOMMU, break the range into sub-ranges
that are naturally aligned, and flush each one separately. This apporach
is better when running with a vIOMMU, but on physical IOMMUs, the
penalty of IOTLB misses due to unnecessary flushed entries is likely to
be low.

Repurpose (i.e., keeping the name, changing the logic)
domain_flush_pages() so it is used to choose whether to perform one
flush of the whole range or multiple ones to avoid flushing unnecessary
ranges. Use NpCache, as usual, to infer whether the IOMMU is physical or
virtual.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/iommu/amd/iommu.c | 47 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ce8e970aac9a..ec0b6ad27e48 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1262,15 +1262,52 @@ static void __domain_flush_pages(struct protection_domain *domain,
 }
 
 static void domain_flush_pages(struct protection_domain *domain,
-			       u64 address, size_t size)
+			       u64 address, size_t size, int pde)
 {
-	__domain_flush_pages(domain, address, size, 0);
+	if (likely(!amd_iommu_np_cache)) {
+		__domain_flush_pages(domain, address, size, pde);
+		return;
+	}
+
+	/*
+	 * When NpCache is on, we infer that we run in a VM and use a vIOMMU.
+	 * In such setups it is best to avoid flushes of ranges which are not
+	 * naturally aligned, since it would lead to flushes of unmodified
+	 * PTEs. Such flushes would require the hypervisor to do more work than
+	 * necessary. Therefore, perform repeated flushes of aligned ranges
+	 * until you cover the range. Each iteration flush the smaller between
+	 * the natural alignment of the address that we flush and the highest
+	 * bit that is set in the remaining size.
+	 */
+	while (size != 0) {
+		int addr_alignment = __ffs(address);
+		int size_alignment = __fls(size);
+		int min_alignment;
+		size_t flush_size;
+
+		/*
+		 * size is always non-zero, but address might be zero, causing
+		 * addr_alignment to be negative. As the casting of the
+		 * argument in __ffs(address) to long might trim the high bits
+		 * of the address on x86-32, cast to long when doing the check.
+		 */
+		if (likely((unsigned long)address != 0))
+			min_alignment = min(addr_alignment, size_alignment);
+		else
+			min_alignment = size_alignment;
+
+		flush_size = 1ul << min_alignment;
+
+		__domain_flush_pages(domain, address, flush_size, pde);
+		address += flush_size;
+		size -= flush_size;
+	}
 }
 
 /* Flush the whole IO/TLB for a given protection domain - including PDE */
 void amd_iommu_domain_flush_tlb_pde(struct protection_domain *domain)
 {
-	__domain_flush_pages(domain, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS, 1);
+	domain_flush_pages(domain, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS, 1);
 }
 
 void amd_iommu_domain_flush_complete(struct protection_domain *domain)
@@ -1297,7 +1334,7 @@ static void domain_flush_np_cache(struct protection_domain *domain,
 		unsigned long flags;
 
 		spin_lock_irqsave(&domain->lock, flags);
-		domain_flush_pages(domain, iova, size);
+		domain_flush_pages(domain, iova, size, 1);
 		amd_iommu_domain_flush_complete(domain);
 		spin_unlock_irqrestore(&domain->lock, flags);
 	}
@@ -2205,7 +2242,7 @@ static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
 	unsigned long flags;
 
 	spin_lock_irqsave(&dom->lock, flags);
-	__domain_flush_pages(dom, gather->start, gather->end - gather->start, 1);
+	domain_flush_pages(dom, gather->start, gather->end - gather->start, 1);
 	amd_iommu_domain_flush_complete(dom);
 	spin_unlock_irqrestore(&dom->lock, flags);
 }
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
