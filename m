Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD19021C9E0
	for <iommu@lists.linux.dev>; Tue,  4 Feb 2025 23:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738712219; cv=none; b=ubo5AX74y3wDAAZ29mkbx7wi+Po5TrC2k6T0FNT+l8Kxa8GrCWxjkTBsPtSrGGbjQecH2+mUKBoEXYxjeWu64vhnGZGSaovuAIop3LHW7a84ARGrWBqfktlelUk0XHhX1RSivKAYrFGjVi1ATuar1enVMLm5ynnun7aZmV+BgmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738712219; c=relaxed/simple;
	bh=vdpE6FKEK+tIdypmeVGyluw0ueezFl306pBW567p/90=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QCJGVcMc1IsvsgDZBg7MLpGjr5I2zTQepQkABtZVf3A9k98k/GhAFI48kxG/rxVVKPsmd31oFUSzbfgyXHaNXOtAb6xE5OlJGK04N65fNeg5Fzp8ZVmTagCrEHpkbRDaUtPcXoz5rc9B0dnkdHZSDaZzU12zmfbXvXYeXDe0CVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jxgao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sA0/BKdC; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jxgao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sA0/BKdC"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f129f7717fso12119531a91.0
        for <iommu@lists.linux.dev>; Tue, 04 Feb 2025 15:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738712216; x=1739317016; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c1qL4ZnXFfT00K7n5zOtqnft++xXZTvzfh0tC//JmKg=;
        b=sA0/BKdCHF3Y4seSK541m9QdcouIVQBsLEjfrDCGq++mk7uYwsTYONnFTuq1Y6at1N
         1Vlw5lim1kbnfxCWNmhA+rQqOH8LZuYahi8a8ZNoXrb32a2xFQP+VeNSmX1nHpDrS/48
         Z9Oi+ljkv+aNVzDdeBpwqThAV3JDYUG/oSXHxS+IgPCtp+Uu2Qe0gBKTTsmzABGlH4GN
         EVe7x7Pq0rxSZT4ga+JRYtzwLfq5PWkRY3Wl8oK6fs6Y0Ba1wZM4YNfPS48NfPtkL8Nu
         ki/wP8rqoFITWpPSdEbsfTtHt1aqcMT8bu8BgG6/r9nYZ3LbHQ6eAc4BBEsKlPvdJhb0
         hspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738712216; x=1739317016;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1qL4ZnXFfT00K7n5zOtqnft++xXZTvzfh0tC//JmKg=;
        b=pDJKy4zAStF6xgZnmYgkDF3EOM8LhXeCkPZuz0ZQO1KcZpXx38lSA6z9BYNxFzqwgb
         l7B1iZBERCSdzn4KVx9dznYAKdNGNThORFnDXlXjN2PEnhjaNzNekhdUyhOF/ixAzHS6
         Ew/PoGjQ+Ljxve0YakHgsAN39zr/ktkl1qiIR1HsO3o17AU4l5qr67HbVDR0vC1LLbhr
         /5uBvojoGcCjvsaY5dM4ZqcVwd2jc+mE2pqHpMyiVLm15Rw3EYTPuCOfYKzoIFUuVGvU
         /M9KI7MvyqJvMDQ0DQblP8EYEK2VQ+fajvqpe2UUqr0ztpZLKLttuBtGtACJLgu5Rt/c
         gpCA==
X-Forwarded-Encrypted: i=1; AJvYcCXlpCXbDD1PTw9AnCUX6fel2JQb2tlkKa8eKX72vai8JaQS4Tb2IHQOnm9cFicOSskXyvgPrQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YytDnrZvt2W5scnKJLi6aYtGRM0dsk4w/EmX0YpZoXyBg72Hbiy
	9uG8WqeMGE4UV9rKZPB+y7Sgba6AryEitdou2zhd5AZd3ACvdmTqrAA8KJhd09T6H4OyVgiHQg=
	=
X-Google-Smtp-Source: AGHT+IG1RFAavC3DUQIa1KEGMmHkvtnWsmq5/N2XOmTYW1ZVDvUvfOelUHO4cFQ9z2pdoiyU8JI1A4ubzg==
X-Received: from pfgt33.prod.google.com ([2002:a05:6a00:13a1:b0:725:1e74:6a17])
 (user=jxgao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3296:b0:1e1:aab8:3887
 with SMTP id adf61e73a8af0-1ede88dd04amr934764637.39.1738712216103; Tue, 04
 Feb 2025 15:36:56 -0800 (PST)
Date: Tue,  4 Feb 2025 23:36:29 +0000
In-Reply-To: <20250204233630.3407878-1-jxgao@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250204233630.3407878-1-jxgao@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250204233630.3407878-3-jxgao@google.com>
Subject: [RFC PATCH 2/3] skip swiotlb pre copy if the device does full buffer write.
From: Jianxiong Gao <jxgao@google.com>
To: Keith Busch <kbusch@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Robin Murphy <robin.murphy@arm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, Ryan Afranji <afranji@google.com>, 
	linux-nvme@lists.infradead.org, iommu@lists.linux.dev, 
	Jianxiong Gao <jxgao@google.com>
Content-Type: text/plain; charset="UTF-8"

In cases that the device is known to do a full buffer write, we
can skip the pre copy of the swiotlb buffer.

Signed-off-by: Jianxiong Gao <jxgao@google.com>
---
 kernel/dma/swiotlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index abcf3fa63a56..12124d4fd44f 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1436,7 +1436,8 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	 * hardware behavior.  Use of swiotlb is supposed to be transparent,
 	 * i.e. swiotlb must not corrupt memory by clobbering unwritten bytes.
 	 */
-	swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_TO_DEVICE, pool);
+	if ((dir == DMA_TO_DEVICE) || !dma_is_full_buffer_write(dev))
+		swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_TO_DEVICE, pool);
 	return tlb_addr;
 }
 
-- 
2.48.1.362.g079036d154-goog

