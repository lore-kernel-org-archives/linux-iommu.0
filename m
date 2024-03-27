Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEF922EE9
	for <iommu@lists.linux.dev>; Wed, 27 Mar 2024 03:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711511170; cv=none; b=Nbj+Ksa4vUXAqy2q3An/jAM1EJCD8dxyQqmF7mwLHfXnK1gkFzPGItfVb5x0D+z9EBv07nJ89imRjh1JXZaFCrqECrxxqgZzScnJyO9Dt3sIIA1fUc2XTOUxRayiB2rns8x7OVMa8twrmEHtiOa0xFRyVQP6nC3a+KiEQ4zh6Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711511170; c=relaxed/simple;
	bh=ZeAFsxPtacnd3+C+1rJ30gAV/hVdWc3kQmPPpMzcr04=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iOBTJV1yOzu+L3VLknRxrhN2LtpGQW+OHrr8A1yQFsRt4M30By0OeH2l63BHuUPqgZb9vuLHT/8Ia7V6ZXYJjIriwc7QJsUyCAldKpgLYYs/eXfIfap6AeaDcAStDa5Wm4Ak0LVNBIVJsDfIdL4sGey6sypAVyl906bt7VijOK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loqxVv6B; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loqxVv6B"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29f93c4946cso4218358a91.1
        for <iommu@lists.linux.dev>; Tue, 26 Mar 2024 20:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711511167; x=1712115967; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KNqU8sxkAGV2sIPTWHyuNFg/2BkpL0OA+B81hrWr0ZA=;
        b=loqxVv6BEw1FBXpqtZy499O1ImSaDzecidt5PoFXcKYZswCcHuLYoBBbymitT+5FrO
         CmL0PstYxAz09Org4pss7SRAqDXeocsSpbfYa3s2m1zU5A4I+MbmMq7LXJzLai2WOIAu
         9/h79PK7V4NLL576e9q8/ZvmKO/3MBXTJfvSrvLz8NwRj+zF62wfvHtPaHvBIaUzlM3O
         OHpLjzKJemDljjNA8/MPGafHgerb/gELFivfTPDUjD1sjF0QtiufnPdzZO5t+P3nPqiO
         Mg5pFHvlryeRuLhidY3+o4ql0CSSMzjyR5TD4NGOBxY6aLics7J4jr/AVAh7voRs7iHo
         NnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711511167; x=1712115967;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNqU8sxkAGV2sIPTWHyuNFg/2BkpL0OA+B81hrWr0ZA=;
        b=CBEKOv/vsN33hdzRTKy6tC4O7seXRR4MITihUbOgaXBAnX/CZZK/ti8sZ8THM/tDLi
         U5F+9vmvfwFMlhXaa6zHNBIFCaVPiIAhbzod6CnX3iKCi01dKEb/VgfLfl2ufKWcdzp0
         K9xKS2ipEQKKrJyDy40DnUB2ef/VC2scq2X61Ab29JV799QTNqQAxWtZoyGylw4QU/1q
         oiiAh8DiZhVH0pynH/XrnoHgPaKngqatee1+ZKhcKiBaC0V8Jr/f85QXqRFNtHWRl+KK
         UDrEKUzbqla1cRkzKx+NmDaggdgIyhrs3hYKbG+IY4xBZApZe3DCxWXcrlaavM2RR05+
         tG2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6UqQewFAjohq7o1QBDDjLhiA/qlmpV2IrEFszHUKhOxn2TpxFM2XuNn+1VroA9taTLcaEwn7YQhnAUrvLSCnM8lVzJvQ=
X-Gm-Message-State: AOJu0YxGCk2wjyE1At75NZ8ZXWRhITVf8sy1mNCoeVNaXigrnKWErs9K
	4bDxYwQ0wwWI2Cg5NAcGvGIuuQHBT0lAk41iA0HpGQvHswuJmopY
X-Google-Smtp-Source: AGHT+IFni7awmeeUlQh91WaJ34jqzPWLRRorhThWvS+SZRo4JHZ/K8HkM4/wAg69Vd1NoLiIDpvN8g==
X-Received: by 2002:a17:90b:4b0b:b0:29b:a9b2:f98c with SMTP id lx11-20020a17090b4b0b00b0029ba9b2f98cmr1538518pjb.24.1711511167137;
        Tue, 26 Mar 2024 20:46:07 -0700 (PDT)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id c16-20020a17090ad91000b0029c741ca894sm440382pjv.29.2024.03.26.20.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 20:46:06 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: hch@lst.de,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	petrtesarik@huaweicloud.com,
	konrad.wilk@oracle.com,
	chanho61.park@samsung.com,
	bumyong.lee@samsung.com,
	dominique.martinet@atmark-techno.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: will@kernel.org,
	petr@tesarici.cz,
	roberto.sassu@huaweicloud.com
Subject: [PATCH 1/1] swiotlb: Fix swiotlb_bounce() to do partial sync's correctly
Date: Tue, 26 Mar 2024 20:45:48 -0700
Message-Id: <20240327034548.1959-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

In current code, swiotlb_bounce() may do partial sync's correctly in
some circumstances, but may incorrectly fail in other circumstances.
The failure cases require both of these to be true:

1) swiotlb_align_offset() returns a non-zero "offset" value
2) the tlb_addr of the partial sync area points into the first
"offset" bytes of the _second_ or subsequent swiotlb slot allocated
for the mapping

Code added in commit 868c9ddc182b ("swiotlb: add overflow checks
to swiotlb_bounce") attempts to WARN on the invalid case where
tlb_addr points into the first "offset" bytes of the _first_
allocated slot. But there's no way for swiotlb_bounce() to distinguish
the first slot from the second and subsequent slots, so the WARN
can be triggered incorrectly when #2 above is true.

Related, current code calculates an adjustment to the orig_addr stored
in the swiotlb slot. The adjustment compensates for the difference
in the tlb_addr used for the partial sync vs. the tlb_addr for the full
mapping. The adjustment is stored in the local variable tlb_offset.
But when #1 and #2 above are true, it's valid for this adjustment to
be negative. In such case the arithmetic to adjust orig_addr produces
the wrong result due to tlb_offset being declared as unsigned.

Fix these problems by removing the over-constraining validations added
in 868c9ddc182b. Change the declaration of tlb_offset to be signed
instead of unsigned so the adjustment arithmetic works correctly.

Tested with a test-only hack to how swiotlb_tbl_map_single() calls
swiotlb_bounce(). Instead of calling swiotlb_bounce() just once
for the entire mapped area, do a loop with each iteration doing
only a 128 byte partial sync until the entire mapped area is
sync'ed. Then with swiotlb=force on the kernel boot line, run a
variety of raw disk writes followed by read and verification of
all bytes of the written data. The storage device has DMA
min_align_mask set, and the writes are done with a variety of
original buffer memory address alignments and overall buffer
sizes. For many of the combinations, current code triggers the
WARN statements, or the data verification fails. With the fixes,
no WARNs occur and all verifications pass.

Fixes: 5f89468e2f06 ("swiotlb: manipulate orig_addr when tlb_addr has offset")
Fixes: 868c9ddc182b ("swiotlb: add overflow checks to swiotlb_bounce")
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
This patch is built against the 6.9-rc1 tree plus Petr Tesarik's
"swiotlb: extend buffer pre-padding to alloc_align_mask" patch
that's in-flight.

 kernel/dma/swiotlb.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index d7a8cb93ef2d..d57c8837c813 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -863,27 +863,23 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 	size_t alloc_size = mem->slots[index].alloc_size;
 	unsigned long pfn = PFN_DOWN(orig_addr);
 	unsigned char *vaddr = mem->vaddr + tlb_addr - mem->start;
-	unsigned int tlb_offset, orig_addr_offset;
+	int tlb_offset;
 
 	if (orig_addr == INVALID_PHYS_ADDR)
 		return;
 
-	tlb_offset = tlb_addr & (IO_TLB_SIZE - 1);
-	orig_addr_offset = swiotlb_align_offset(dev, 0, orig_addr);
-	if (tlb_offset < orig_addr_offset) {
-		dev_WARN_ONCE(dev, 1,
-			"Access before mapping start detected. orig offset %u, requested offset %u.\n",
-			orig_addr_offset, tlb_offset);
-		return;
-	}
-
-	tlb_offset -= orig_addr_offset;
-	if (tlb_offset > alloc_size) {
-		dev_WARN_ONCE(dev, 1,
-			"Buffer overflow detected. Allocation size: %zu. Mapping size: %zu+%u.\n",
-			alloc_size, size, tlb_offset);
-		return;
-	}
+	/*
+	 * It's valid for tlb_offset to be negative. This can happen when the
+	 * "offset" returned by swiotlb_align_offset() is non-zero, and the
+	 * tlb_addr is pointing within the first "offset" bytes of the second
+	 * or subsequent slots of the allocated swiotlb area. While it's not
+	 * valid for tlb_addr to be pointing within the first "offset" bytes
+	 * of the first slot, there's no way to check for such an error since
+	 * this function can't distinguish the first slot from the second and
+	 * subsequent slots.
+	 */
+	tlb_offset = (tlb_addr & (IO_TLB_SIZE - 1)) -
+		     swiotlb_align_offset(dev, 0, orig_addr);
 
 	orig_addr += tlb_offset;
 	alloc_size -= tlb_offset;
-- 
2.25.1

