Return-Path: <SRS0=yZZ9=MP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_RED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BBDC43214
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 17:02:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42BBD60EB5
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 17:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 42BBD60EB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1DDF560BAB;
	Fri, 23 Jul 2021 17:02:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QvD7wwElntFn; Fri, 23 Jul 2021 17:02:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ED123608EF;
	Fri, 23 Jul 2021 17:02:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0589C0022;
	Fri, 23 Jul 2021 17:02:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27452C000E
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 17:02:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 148A4406A3
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 17:02:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V9juoCGYWLyT for <iommu@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 17:02:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4E6D440693
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 17:02:09 +0000 (UTC)
Received: by mail-pl1-x632.google.com with SMTP id u8so3982302plr.1
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 10:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A0INaGmwcF2KYhrXOp1c817JL5QEuWK4ejcza4aRKbI=;
 b=Mzria5QLEIIaxfKeWVY9kN0L009L0dESyRZOPPZZhZghHNbg5NUrVCX6YbEnUNZyUH
 Jn7ae65cz8cOPxoTvrTuEnkDGSrOl+6LvZ4MLIxS+0Vz8H5HD1pZrBG91hfrWb8aC/kC
 C6SDLWUGRehoGFWRbzGgqtdYFdaGslE6LlbXMauVX5RPYfni9HVri97fFczKcsyYKGDg
 VlsUwOnkbGYuyLRpktOpSoxm/IlBEoi1PSD2MLUs2bOkvWq5f2yZovpdJztIcN/Unpuh
 yrKl1NgMrYLMCH/+qG2ORsE5sO0DvFcTippqr/grnkjiTBTux1w2BVULWPTH9U/sF1UR
 iCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A0INaGmwcF2KYhrXOp1c817JL5QEuWK4ejcza4aRKbI=;
 b=nIGt4/1A3RHKCq0OvfppQqHoQ7wX389qSFQX9lafG14oI2P6AjfrKIh0Ao2yIwrgEb
 jtbL3guWOCUa430yHTNy7IwhcV2wKKfBnyk6ys9jdvvlbtxVsPFh9Ll5SlaZZL4bqTHM
 j10nbEbYXNbVthW0YKv5wHHvHYrIOMzQobeS7nOpw4ITbzgSz/v4z5PSZZve+amGvPAq
 mXOsv+0FgoZ23GkhI/cVvGAPM/yLKzDr0Nnfa+8FWlvz54uGVliCF+aU6U/Jk0xqYE+b
 uTv9Y9XEWfZ2p7+A1emCZzLrwu7QV7lA3RivYCaYZKjYLkRXlikTUQYdBxzGm02b+umW
 TQAQ==
X-Gm-Message-State: AOAM530P08uYqUAnrNWJ2pkLJNLGR8kniWlE+ohEF8V98SrvEgPwL07G
 K2rgp99vyJ5gFdzOsko8R8w=
X-Google-Smtp-Source: ABdhPJzYzPan6NB/50zb11zliDqlwUfAV0lnD+3epo+lXInk+xL0xUNTc8dPlFmsmi660UZk77sgsg==
X-Received: by 2002:a17:902:9a81:b029:12b:567:6eef with SMTP id
 w1-20020a1709029a81b029012b05676eefmr4448023plp.35.1627059728580; 
 Fri, 23 Jul 2021 10:02:08 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id d15sm33479004pfl.82.2021.07.23.10.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jul 2021 10:02:08 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v6 7/7] iommu/amd: Use only natural aligned flushes in a VM
Date: Fri, 23 Jul 2021 02:32:09 -0700
Message-Id: <20210723093209.714328-8-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210723093209.714328-1-namit@vmware.com>
References: <20210723093209.714328-1-namit@vmware.com>
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
index 7846fcb1e92b..3f6428aa68cd 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1261,15 +1261,52 @@ static void __domain_flush_pages(struct protection_domain *domain,
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
+	 * until you cover the range. Each iteration flushes the smaller
+	 * between the natural alignment of the address that we flush and the
+	 * greatest naturally aligned region that fits in the range.
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
@@ -1296,7 +1333,7 @@ static void domain_flush_np_cache(struct protection_domain *domain,
 		unsigned long flags;
 
 		spin_lock_irqsave(&domain->lock, flags);
-		domain_flush_pages(domain, iova, size);
+		domain_flush_pages(domain, iova, size, 1);
 		amd_iommu_domain_flush_complete(domain);
 		spin_unlock_irqrestore(&domain->lock, flags);
 	}
@@ -2200,7 +2237,7 @@ static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
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
