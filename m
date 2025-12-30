Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337CDA41
	for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089756; cv=none; b=rNyvXyOvsK34xDVoN4kgjSb6hiq7cj18gDafHtJkbI0dQnKtUgKgC+IB0dFvzOQ8mDttzN219tm0TqGg/PmFDfBzXRk2ByobDO0QD/rQL6oqhmis9xEIxYN3oD2pT35z1b6OD9qQ6FrlnrMB2uB77FRv6YVyHZicFaDsh/BhY4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089756; c=relaxed/simple;
	bh=D8i5fx1UC1/6nmNgw58hQGeu+7fSwjalMhDNBy/e6FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CeZOI2LY1bdz5KQTL/R0+wPBMYbke/VX7cCiDsG6fzIVg8G/Vr4VRHAc7PDCxNuP/Qmbt/wS74PYxqsb+tnJXv4iemQ80jf2HA/vIt07oYgdhHjckoQ+CdNvuusbhQMnyagW2Aol9X5os3OFanLc307RzkmRhM0Cqrqm6LJGcz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qx9dAkvu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qx9dAkvu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HL5OM1OGVzMUVxTMh8EvcAcQ4aesQjltxTtrn5MVxlA=;
	b=Qx9dAkvuDwrSpKE415UMHo5eSJ/9JvXU02SOI2TJdmEvg4EHVgttF3MOSq398i+DpcZO9r
	WgeAGnv9o97l8cfDn4luQ61Lt0dmE7I1B+PxUlMXDdcESCplvqu18hU3iRVmjlVJqdPaVh
	wdX2OhzgbYH4VWe7RIh31gYDnVxMYPE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-G6eb06rrMPqHPtiNm0WQUg-1; Tue, 30 Dec 2025 05:15:51 -0500
X-MC-Unique: G6eb06rrMPqHPtiNm0WQUg-1
X-Mimecast-MFC-AGG-ID: G6eb06rrMPqHPtiNm0WQUg_1767089750
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477a1e2b372so77920305e9.2
        for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 02:15:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089750; x=1767694550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HL5OM1OGVzMUVxTMh8EvcAcQ4aesQjltxTtrn5MVxlA=;
        b=CAdkhB8liaws5+ko/GgaHWpNwnRaEZVpwUKZCW6CuULmbQGH1zJiRZJgqlsCrAK/MA
         D0GuwDybElEw0uGpl9mcC79KOHfWM85953PbCICYndPpDXn8mHw4Yp8CpoPYRpP+tmQG
         YqEdoEt1qFg5LjYBefeAaGvq4uiVWbMXgJpUcCRz/71zhqXY4EJfKnZfTyMRTE0ojnhC
         hqW6NKGMdj2HnA0tljYH8KRtjllD1PQxfYdcmLrEc6E9rtWlYBcwboOfHit/jmSmpMwc
         2Qhc6srNX7f/knZDCuPTMzdw7++R6kSKswHgwlMu5yq9X/bQMYOOIUhr7TCw3g5L76ev
         4kVw==
X-Forwarded-Encrypted: i=1; AJvYcCXNltdvjL+/xd/E4j5dz7E0plMgFCekdbZqKoIT5eTaoMzJPbx8gtD/28jtIfO/jkV1uYHtYA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9O7xo1DDotKBjoniMAGTMsTXlWXQYP3sdcc+6mS9xnrFaqctt
	I7RRRNnQ+QjXG103DGlHPXvwb/o1GJoX1rPHGTBaG2chr24GXTpXD9yRJ/uUfHzB8H2M85XgG9m
	E7OKqlQI9Qj0BuESTei4jJDDmQjxC4uWvUzfxiiDKcIaB8Sj47hjisP/N
X-Gm-Gg: AY/fxX65h4M/d5Ytq3Zm2zgfr5coZ22SFiHwR0ACOFTcpuzCPe+YGMOTWGScM56SDws
	8lgJ4dPEoY2Hoe2+nBEXWYsangv6ufrKEKultXzR5/4saZDO7BrMQvTNRQFodeIXvoQYds7QnMu
	ahvrlvWrAOlvQvzEs4+Zrcnx02lXdoic6KLpz8NBZmt0muzO36hf5erVp8StaVKfOkuy0lAgjJg
	nh+C/x3EC13qchLfZYYUPzGPeOsftkTAQ/MAixht3sY0oQ4DmFxfgCxESUwEdwdeJG5md2DRsqL
	jZaVZM3K/A+ycHz4OWWXkatoktlgQN+lT3iVwcdpK4BFTpOQgL13Tiy7uBSdK7XWDcgJ/eEkZ3n
	HUIozKYwM7Buiv4pvpl6pUNqTk3AZZqqCOw==
X-Received: by 2002:a05:600c:8b8c:b0:477:af07:dd1c with SMTP id 5b1f17b1804b1-47d195aaf01mr352296825e9.35.1767089749957;
        Tue, 30 Dec 2025 02:15:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGA32W4P8fpeNgmYgRIg4EUZ5pS0m5VtW0uNekoNCHVjCXEfha8FeJZQUcsP4e9hP9jnxKeEQ==
X-Received: by 2002:a05:600c:8b8c:b0:477:af07:dd1c with SMTP id 5b1f17b1804b1-47d195aaf01mr352296575e9.35.1767089749551;
        Tue, 30 Dec 2025 02:15:49 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193e329asm588350835e9.15.2025.12.30.02.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:15:49 -0800 (PST)
Date: Tue, 30 Dec 2025 05:15:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Petr Tesarik <ptesarik@suse.com>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH RFC 01/13] dma-mapping: add __dma_from_device_align_begin/end
Message-ID: <ca12c790f6dee2ca0e24f16c0ebf3591867ddc4a.1767089672.git.mst@redhat.com>
References: <cover.1767089672.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1767089672.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bW0gDPxZVBxCeCpmCKu2tmgLV76otUgdOeV_DHbkvPA_1767089750
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When a structure contains a buffer that DMA writes to alongside fields
that the CPU writes to, cache line sharing between the DMA buffer and
CPU-written fields can cause data corruption on non-cache-coherent
platforms.

Add __dma_from_device_aligned_begin/__dma_from_device_aligned_end
annotations to ensure proper alignment to prevent this:

struct my_device {
	spinlock_t lock1;
	__dma_from_device_aligned_begin char dma_buffer1[16];
	char dma_buffer2[16];
	__dma_from_device_aligned_end spinlock_t lock2;
};

When the DMA buffer is the last field in the structure, just
__dma_from_device_aligned_begin is enough - the compiler's struct
padding protects the tail:

struct my_device {
	spinlock_t lock;
	struct mutex mlock;
	__dma_from_device_aligned_begin char dma_buffer1[16];
	char dma_buffer2[16];
};

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/dma-mapping.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index aa36a0d1d9df..47b7de3786a1 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -703,6 +703,16 @@ static inline int dma_get_cache_alignment(void)
 }
 #endif
 
+#ifdef ARCH_HAS_DMA_MINALIGN
+#define ____dma_from_device_aligned __aligned(ARCH_DMA_MINALIGN)
+#else
+#define ____dma_from_device_aligned
+#endif
+/* Apply to the 1st field of the DMA buffer */
+#define __dma_from_device_aligned_begin ____dma_from_device_aligned
+/* Apply to the 1st field beyond the DMA buffer */
+#define __dma_from_device_aligned_end ____dma_from_device_aligned
+
 static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp)
 {
-- 
MST

