Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E204A2B
	for <iommu@lists.linux.dev>; Thu,  1 Sep 2022 13:29:14 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id qh18so14411690ejb.7
        for <iommu@lists.linux.dev>; Thu, 01 Sep 2022 06:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=CA0Tu1QtRj1CuC30d2aawaIrEzLi0kZytJOI0Gq2tX8=;
        b=bhGYgTnQvyhLVFi0OIyswolIvFUgRdw1839k4Yye7jvNRi9m83S254tvyswacDzXte
         c/7SaCfEXPyVllpvKVenXumkvBeAjQHOVwxKY7/+vE9iFNXgGz9XtrsEnyCPsMaWRnWe
         BF9jEufZX9S7LKidZnhrJC8zQkoF17pE8d4S3VgdpN9j1JOp+KWkb7bEjR8/PKLDC9rH
         vUnGb2o4S5mGu+q6n/cRjLYQTlB25DQi2p72amXT87W6enqJdopkKIbCgWGb8DCTeoLr
         etFsCGSwzuYe0vOMtxJmO2klxCWkDseE5cR5tQrjsEOxccxwl5heCbs1TR/i4+dhUuCy
         UqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=CA0Tu1QtRj1CuC30d2aawaIrEzLi0kZytJOI0Gq2tX8=;
        b=EX4D1Hl3Zsfsmkw8FOdim9ibwCb1Fsgfi4tNvXraQEl71fdB8U2He5Uq43tBv1i4QM
         ktbbUkfDPBir1sv4yb9wHNXGl1k4ISRIq/jQQshlgyTPH+MAQkfdbQnYfHU1tAf6Egwz
         x91EhWJbX9dqsJJtGbiVaPPtmhQ8hrnYYSCiRBVHz3w+uFZIJvjnGeNkKYiYczINe7ZU
         ayKeWjjFIAxSapzf8JSKIIr0zGRrqG6T+yur4Mtd9ny4YZruPPANcBUJtyKWQwdn6BWA
         IPrIEdOZJt8iLbHw2Fgxx7DATt+BzpeFCJ9MyfmNRsfC1rFj82lAVM4fE43bN26ReOPG
         nlbw==
X-Gm-Message-State: ACgBeo3bCVlRQA4gWkBiOl7iSiPmryuEyIu212tfylSlopgIMt5KY59X
	yyw5tSnH3qP3fqB4Bhwh4pc=
X-Google-Smtp-Source: AA6agR7Jfbj56Zl7x6lrxkSTXRbOfYUL3n86WNDUy2lVZKh5xpDb3/epr0nEPm3L8DzGitMIw75Xdg==
X-Received: by 2002:a17:907:2894:b0:741:4e40:94fe with SMTP id em20-20020a170907289400b007414e4094femr16588744ejc.606.1662038953090;
        Thu, 01 Sep 2022 06:29:13 -0700 (PDT)
Received: from localhost.localdomain (host-87-1-103-238.retail.telecomitalia.it. [87.1.103.238])
        by smtp.gmail.com with ESMTPSA id n2-20020a170906088200b0073d678f50bfsm8460612eje.164.2022.09.01.06.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 06:29:11 -0700 (PDT)
From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To: Christoph Hellwig <hch@infradead.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] swiotlb: Replace kmap_atomic() with memcpy_{from,to}_page()
Date: Thu,  1 Sep 2022 15:29:06 +0200
Message-Id: <20220901132906.14063-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of kmap_atomic() is being deprecated in favor of
kmap_local_page(), which can also be used in atomic context (including
interrupts).

Replace kmap_atomic() with kmap_local_page(). Instead of open coding
mapping, memcpy(), and un-mapping, use the memcpy_{from,to}_page() helper.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 kernel/dma/swiotlb.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c5a9190b218f..a28ac23ad8db 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -549,9 +549,8 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 	}
 
 	if (PageHighMem(pfn_to_page(pfn))) {
-		/* The buffer does not have a mapping.  Map it in and copy */
 		unsigned int offset = orig_addr & ~PAGE_MASK;
-		char *buffer;
+		struct page *page;
 		unsigned int sz = 0;
 		unsigned long flags;
 
@@ -559,12 +558,11 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 			sz = min_t(size_t, PAGE_SIZE - offset, size);
 
 			local_irq_save(flags);
-			buffer = kmap_atomic(pfn_to_page(pfn));
+			page = pfn_to_page(pfn);
 			if (dir == DMA_TO_DEVICE)
-				memcpy(vaddr, buffer + offset, sz);
+				memcpy_from_page(vaddr, page, offset, sz);
 			else
-				memcpy(buffer + offset, vaddr, sz);
-			kunmap_atomic(buffer);
+				memcpy_to_page(page, offset, vaddr, sz);
 			local_irq_restore(flags);
 
 			size -= sz;
-- 
2.37.2

