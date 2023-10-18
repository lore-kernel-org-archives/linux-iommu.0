Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60973F4AF
	for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O18ROSno"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-d9ab7badadeso9781166276.1
        for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 10:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697650451; x=1698255251; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RelinbZSLZ3//bk7xHba+uKbmxohgasnEf6j21oUpLw=;
        b=O18ROSno+dlgGSUNKS4zBnmci3WvaKsewU2MLr6tge5aqsTCLDb++bHhvefD51Are6
         nW5tRIC478ZucKmf4B2EmJumIr/kCZr2i3zOn6ivaJ4X32WsdKy1yOcxL/Q9MgnxT0No
         nCF4xQVnWyRP9zXKEuZDTBCnoGxWCST6I35zg3jQcFR4M7AFt5mxabGNuOV2VJuVsndK
         FxhQrf/QTy2AIBiqh63UOwyrirRGRUE2z/6aNwxn+EIl2uV1fIWm1DdS6+8t5sHROH60
         pTDNiUGOm9+/hnkpUqVmA+gAeatH8hTPCQtmAGzmm3/Fxr9w7tAQltYuJ99xdD8LSpqB
         GVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697650451; x=1698255251;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RelinbZSLZ3//bk7xHba+uKbmxohgasnEf6j21oUpLw=;
        b=nBOLANW4tG/+i2xXH+BWT22HGKoCeqROPGmX/U8Ghje7b9RWOO+RSZRY//U7+dtf3I
         Z56cdmsyG78xYy8oPQv8La47wqPkU7Wj+RgBtujTRKElEW0kLJN/9SIBQrtmWL5sbb/e
         /MfAQ/hjWBdtrdJG+g8FOTWAnAXH+RWJTslBD6u5j2iYWW13ieD65zq4/OdqzDz+Icic
         YJgM2I7wbLBZtneqDdEuku5wXG0JtznGLnRq2Woj0tJyIG+kd/5MNMBVCt5USICxsdQT
         DmPI70MxK6KMzRpcR+fxuilnWNCGdxh77/RsWJGNrC+yvH6qR8l32QoLvd0KEwIbSjE8
         g0iA==
X-Gm-Message-State: AOJu0YyBRKeV5GvKpN8czxAHntZ2nFa+/aPRtiobAAKOfAV13clz1P24
	1J/Fhv8ls7yL6OXVYxWOOmVMq4upxxc=
X-Google-Smtp-Source: AGHT+IFsiXcsp74Srqa0t0XCrzb4lqNGBNpOooFM5tTTgsZ8v+vnRddeh9lJC9B5z3FHszNA4IPr1HJdIwM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:e89:0:b0:d9a:ce79:6298 with SMTP id
 z9-20020a5b0e89000000b00d9ace796298mr1114ybr.2.1697650451779; Wed, 18 Oct
 2023 10:34:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 18 Oct 2023 10:34:09 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231018173409.1871540-1-seanjc@google.com>
Subject: [PATCH] swiotlb: Rewrite comment explaining why the source is
 preserved on DMA_FROM_DEVICE
From: Sean Christopherson <seanjc@google.com>
To: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Rewrite the comment explaining why swiotlb copies the original buffer to
the TLB buffer before initiating DMA *from* the device, i.e. before the
device DMAs into the TLB buffer.  The existing comment's argument that
preserving the original data can prevent a kernel memory leak is bogus.

If the driver that triggered the mapping _knows_ that the device will
overwrite the entire mapping, or the driver will consume only the written
parts, then copying from the original memory is completely pointless.

If neither of the above holds true, then copying from the original adds
value only if preserving the data is necessary for functional correctness,
or the driver explicitly initialized the original memory.  If the driver
didn't initialize the memory, then copying the original buffer to the TLB
buffer simply changes what kernel data is leaked to userspace.

Writing the entire TLB buffer _does_ prevent leaking stale TLB buffer data
from a previous bounce, but that can be achieved by simply zeroing the TLB
buffer when grabbing a slot.

The real reason swiotlb ended up initializing the TLB buffer with the
original buffer is that it's necessary to make swiotlb operate as
transparently as possible, i.e. to behave as closely as possible to
hardware, and to avoid corrupting the original buffer, e.g. if the driver
knows the device will do partial writes and is relying on the unwritten
data to be preserved.

Cc: Yan Zhao <yan.y.zhao@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/all/ZN5elYQ5szQndN8n@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 kernel/dma/swiotlb.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 01637677736f..e071415a75dc 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1296,11 +1296,13 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		pool->slots[index + i].orig_addr = slot_addr(orig_addr, i);
 	tlb_addr = slot_addr(pool->start, index) + offset;
 	/*
-	 * When dir == DMA_FROM_DEVICE we could omit the copy from the orig
-	 * to the tlb buffer, if we knew for sure the device will
-	 * overwrite the entire current content. But we don't. Thus
-	 * unconditional bounce may prevent leaking swiotlb content (i.e.
-	 * kernel memory) to user-space.
+	 * When the device is writing memory, i.e. dir == DMA_FROM_DEVICE, copy
+	 * the original buffer to the TLB buffer before initiating DMA in order
+	 * to preserve the original's data if the device does a partial write,
+	 * i.e. if the device doesn't overwrite the entire buffer.  Preserving
+	 * the original data, even if it's garbage, is necessary to match
+	 * hardware behavior (use of swiotlb is supposed to be transparent) and
+	 * so that swiotlb doesn't corrupt bytes that the device does NOT write.
 	 */
 	swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_TO_DEVICE);
 	return tlb_addr;

base-commit: 213f891525c222e8ed145ce1ce7ae1f47921cb9c
-- 
2.42.0.655.g421f12c284-goog

