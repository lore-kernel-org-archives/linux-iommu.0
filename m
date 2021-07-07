Return-Path: <SRS0=iPMr=L7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0F0C07E95
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 05:13:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE58A61CAA
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 05:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE58A61CAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B0F27607F6;
	Wed,  7 Jul 2021 05:13:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DBPzRirvtJ2P; Wed,  7 Jul 2021 05:13:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 31A7760760;
	Wed,  7 Jul 2021 05:13:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2B25C001A;
	Wed,  7 Jul 2021 05:13:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF4A1C000E
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 05:13:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9E0AC82786
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 05:13:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NleCK2U9rrAR for <iommu@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 05:13:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
 by smtp1.osuosl.org (Postfix) with ESMTP id B6D8F826C7
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 05:13:19 +0000 (UTC)
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
 by gw2.atmark-techno.com (Postfix) with ESMTP id 12DF020D1D
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 14:13:18 +0900 (JST)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by gw2.atmark-techno.com (Postfix) with ESMTPS id 69E4E20D1D
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 14:13:17 +0900 (JST)
Received: by mail-pf1-f197.google.com with SMTP id
 s5-20020aa78d450000b02902ace63a7e93so784446pfe.8
 for <iommu@lists.linux-foundation.org>; Tue, 06 Jul 2021 22:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3/lUbYTDaeXrb/TOvjVfoe26NBjr4owCaAB/8eFrqFc=;
 b=tv76A14Ll0ZtCQTUiNtfYgsZTXO1+nc75/U9ITsSxgaee/EUWIKM8zdEUmkFXV7HhO
 DNG4BoFgJgF928OpS7eD0pnCjxtYU+AXdBzRZvkheODUyGcYZ2OSMkjTfyWagIgX8jCN
 LNAmZYI6nVcDiXimWLF1+gpQNsVg+Iz2f1NOwY0s9nUgrUajEBqxML25pObWw1aU/gEr
 bz5Zzm2rOl/jfsN4k9RCIxd3lP9ZOmHU9S0i8Kfa/uwiAKsS7rjUajniP4oh1u8fLjVo
 /gQnmUx6b3zes6HfZPQo4mFXcOIKoaUcyMo0xS7EF8Fv1EnM+hXfFPhQZ+DLZmjZaBFl
 uGKg==
X-Gm-Message-State: AOAM530L/IDdTS9crOTEC4mTWiMBbWDVdHhWURuWM9Hr27PhYVyGy9Jx
 Hf0E3Zk575GtNdUXJjndcllPrcFNTZEC6xF29udcwD22VNzwO0RKKy+C2nrCaU4+wAVpD0Rj2xh
 hny94cKrMb4PkwilfC6VwVxY/Kz4YFEo=
X-Received: by 2002:a65:62d3:: with SMTP id m19mr24728282pgv.225.1625634796521; 
 Tue, 06 Jul 2021 22:13:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWE9lqwa5L5juVNgKdjfPF7Uy1NnEZfGHcsPDXkkvUuTeooGFCmbsKgaK9nG/PZvdNhTwfQA==
X-Received: by 2002:a65:62d3:: with SMTP id m19mr24728260pgv.225.1625634796228; 
 Tue, 06 Jul 2021 22:13:16 -0700 (PDT)
Received: from pc-0115 (162.198.187.35.bc.googleusercontent.com.
 [35.187.198.162])
 by smtp.gmail.com with ESMTPSA id h9sm11555634pgi.43.2021.07.06.22.13.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 06 Jul 2021 22:13:15 -0700 (PDT)
Received: from martinet by pc-0115 with local (Exim 4.94.2)
 (envelope-from <martinet@pc-0115>)
 id 1m0zs2-008twv-8v; Wed, 07 Jul 2021 14:13:14 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH] swiotlb: add overflow checks to swiotlb_bounce
Date: Wed,  7 Jul 2021 14:12:54 +0900
Message-Id: <20210707051254.2121603-1-dominique.martinet@atmark-techno.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Cc: Dominique Martinet <dominique.martinet@atmark-techno.com>,
 linux-kernel@vger.kernel.org, Bumyong Lee <bumyong.lee@samsung.com>,
 iommu@lists.linux-foundation.org, Chanho Park <chanho61.park@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

This is a follow-up on 5f89468e2f06 ("swiotlb: manipulate orig_addr
when tlb_addr has offset") which fixed unaligned dma mappings,
making sure the following overflows are caught:

- offset of the start of the slot within the device bigger than
requested address' offset, in other words if the base address
given in swiotlb_tbl_map_single to create the mapping (orig_addr)
was after the requested address for the sync (tlb_offset) in the
same block:

 |------------------------------------------| block
              <----------------------------> mapped part of the block
              ^
              orig_addr
       ^
       invalid tlb_addr for sync

- if the resulting offset was bigger than the allocation size
this one could happen if the mapping was not until the end. e.g.

 |------------------------------------------| block
      <---------------------> mapped part of the block
      ^                               ^
      orig_addr                       invalid tlb_addr

Both should never happen so print a warning and bail out without trying
to adjust the sizes/offsets: the first one could try to sync from
orig_addr to whatever is left of the requested size, but the later
really has nothing to sync there...

Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Bumyong Lee <bumyong.lee@samsung.com>
Cc: Chanho Park <chanho61.park@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>
---

Hi Konrad,

here's the follow up for the swiotlb/caamjr regression I had promissed.
It doesn't really change anything, and I confirmed I don't hit either of
the warnings on our board, but it's probably best to have as either
could really happen.


 kernel/dma/swiotlb.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index e50df8d8f87e..23f8d0b168c5 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -354,13 +354,27 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 	size_t alloc_size = mem->slots[index].alloc_size;
 	unsigned long pfn = PFN_DOWN(orig_addr);
 	unsigned char *vaddr = phys_to_virt(tlb_addr);
-	unsigned int tlb_offset;
+	unsigned int tlb_offset, orig_addr_offset;
 
 	if (orig_addr == INVALID_PHYS_ADDR)
 		return;
 
-	tlb_offset = (tlb_addr & (IO_TLB_SIZE - 1)) -
-		     swiotlb_align_offset(dev, orig_addr);
+	tlb_offset = tlb_addr & (IO_TLB_SIZE - 1);
+	orig_addr_offset = swiotlb_align_offset(dev, orig_addr);
+	if (tlb_offset < orig_addr_offset) {
+		dev_WARN_ONCE(dev, 1,
+			"Access before mapping start detected. orig offset %u, requested offset %u.\n",
+			orig_addr_offset, tlb_offset);
+		return;
+	}
+
+	tlb_offset -= orig_addr_offset;
+	if (tlb_offset > alloc_size) {
+		dev_WARN_ONCE(dev, 1,
+			"Buffer overflow detected. Allocation size: %zu. Mapping size: %zu+%u.\n",
+			alloc_size, size, tlb_offset);
+		return;
+	}
 
 	orig_addr += tlb_offset;
 	alloc_size -= tlb_offset;
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
