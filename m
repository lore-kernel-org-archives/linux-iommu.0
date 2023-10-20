Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843B91DA49
	for <iommu@lists.linux.dev>; Fri, 20 Oct 2023 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wERCsEK0"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-d9bc6447193so1226794276.3
        for <iommu@lists.linux.dev>; Fri, 20 Oct 2023 08:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697816538; x=1698421338; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSLHEcMIztGYBTo6xVAEhhfF1F5jUZmJAk48UL6Ld3c=;
        b=wERCsEK0BvuErPBGEzxzXgyhdk7vKC8x7AsZmJyRBxULTbqt6B5iS8SJE0KXLXxoEz
         Moiufzc4R6WcxSdLe6ChgeWggfAGzRTBDAFGIvNH43G3wVl4hNMc+nig0MqpnnlLmQ0l
         TwSV606MmvEF0DpfLJuUtdYKwd09eMFfvFNgw3/NGvIcvca3YajMI+B6J5YOcYKpylUk
         lyyiTDwcv0+WDezcV3q3sCxz97cB8AM7epNN6oSzjJj3n/If9lBuDJxJ0ohxU/XvSMfk
         rVqd9ZXbyyDT1vxRJZQNxnIq0PAQ2+kSFr9snKuprzsXVeN5eZ2Gamod+noQri4H7jqV
         25zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697816538; x=1698421338;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jSLHEcMIztGYBTo6xVAEhhfF1F5jUZmJAk48UL6Ld3c=;
        b=cz6i9MvSkM9m9XG0iKNwCGtoMH37ya3D4YdOTAuvIerUjT2C8p8aq0QWq+sDnDhx4X
         Fus1OQPEbuM4VpfM0ByoCOWZe9RhMGAaXFwrdciHG7dUT33qlbZmiShqOwmB15F0Gk/r
         d07y7oOjF/2ICwO52IEb+QfLbYsZzOwFeOZ9Jiww4Fnw9kEolOMivO3W4Z/C3gkX9xlV
         UbCAzUHzm08ms8o7zBU/rgkHNsFrz0DirHFCGLhHzzhtscuQ3UjV08BzKQNmwz0aPTHX
         s1X2XNaIMtIzUDiH1bGfsoyLfKQu5D+PNEg3AyLBcRLiW0gIeBWrEoUUeL+PeGFg+ML4
         py8w==
X-Gm-Message-State: AOJu0YwHcdov7IE3Tydds0UcpACdH4O93rTFT0lVrO+M7yGlW1p7nesy
	p4sxJ7EEn+0Tjcfuc5lKWox0ohCS2jA=
X-Google-Smtp-Source: AGHT+IGhtVqmbhmyJB3o1gXFA1kvTKqCvhyQl8OMzZz2qJpav2nsj7ZAINPu/3UyJ5C0TJe5CDGuJudpgf0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:c5c1:0:b0:d9a:ce79:6298 with SMTP id
 v184-20020a25c5c1000000b00d9ace796298mr41424ybe.2.1697816538334; Fri, 20 Oct
 2023 08:42:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 20 Oct 2023 08:42:15 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231020154215.2191840-1-seanjc@google.com>
Subject: [PATCH v2] swiotlb: Rewrite comment explaining why the source is
 preserved on DMA_FROM_DEVICE
From: Sean Christopherson <seanjc@google.com>
To: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Robin Murphy <robin.murphy@arm.com>, Sean Christopherson <seanjc@google.com>
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/all/ZN5elYQ5szQndN8n@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

v2: Rephrase blurb about memory corruption to make it clear that not clobbering
    unwritten memory is hardware behavior (I'm belly laughing at how stupidly
    obvious that sounds). [Robin]

v1: https://lore.kernel.org/all/20231018173409.1871540-1-seanjc@google.com

 kernel/dma/swiotlb.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 01637677736f..fd5dacd0628d 100644
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
+	 * hardware behavior.  Use of swiotlb is supposed to be transparent,
+	 * i.e. swiotlb must not corrupt memory by clobbering unwritten bytes.
 	 */
 	swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_TO_DEVICE);
 	return tlb_addr;

base-commit: 213f891525c222e8ed145ce1ce7ae1f47921cb9c
-- 
2.42.0.655.g421f12c284-goog

