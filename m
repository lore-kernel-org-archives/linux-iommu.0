Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AF7313E2C
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601383; cv=none; b=qF7vPcT48LwRt/txGd1deuErIVbfwLCiJ6TnWLxj+13K1tDpepR06IofZjLIx6ED2R7esVsyeteL0ypT4TZ0CTxQ7ZpTx3tD2QHsd8kiEG0hptUyNrH6kmpjz37BazzWhrKhXis0qRLLHwXdjkasKi1XMTfhziAE8Tf67Td2oQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601383; c=relaxed/simple;
	bh=OKICx5FGcs8IaWdKqJAnv5nr30MUEvkMmLH/rtLJg90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OWsW4nRXRlySi6l6TCV2W/8YrLTuDXYhs/fzuw4I/HSWBqUSn1AwOeZMRK7p9qOD+LtOZLsGtZMFN8uYQXkbTq9XsxHV47BWCpgJE1n8F46E/2HNf4Cqr0oHk1tyNuDzYRvTPtjeiSjxIswrFn2AwKcps8tX6mv+AWEqlWMgDbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WqVz3irm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqVz3irm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=flvV58rpfI6B2CbimOq4yKlcklsexX+NampJykNGX78=;
	b=WqVz3irmgl/1ZpP+3Mg4itom3mhS8h0Rbrdtt95M6DwQFX+h30kcTMJGJZHFGGTXx46C9n
	k7QD5ZNc1cE4PvrTUNGjMkSJ8cUXCc4UItybwSIPOawmPH1Lus9RXtQaNSe6Q6nmbZntyM
	9kSdOgbhWt0yWZ60HwGundSiE5kWm3A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-d1qyJxN_MYKVU-HO-jdy7g-1; Mon, 05 Jan 2026 03:22:59 -0500
X-MC-Unique: d1qyJxN_MYKVU-HO-jdy7g-1
X-Mimecast-MFC-AGG-ID: d1qyJxN_MYKVU-HO-jdy7g_1767601378
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477563a0c75so51121765e9.1
        for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 00:22:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601378; x=1768206178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flvV58rpfI6B2CbimOq4yKlcklsexX+NampJykNGX78=;
        b=e3eO6UsyQWT5bJzb7acFuu64p8m9F+72FdLyFkFOBhnF0DJFNgpX0aQqT2e/2WXNvb
         vxBVLoXmhukDbOKTHA++n+WHzbUaEelh5HuILHhPxtL99llk+Ab8ZDf0JhH0ntF6ZWxH
         WCG5bhtv1rbOif8N817vn8mWxw6DPrFQ2ZQ7wQD6/8cDLWkCTUqxNQk/kZb2WS36g0eM
         poY3clMKLqYDb2dLkeYlPvXzd2MP/gQ1cuwqbPIngWqd4gOEhXndI24BqPFNwFd8TDlz
         l48Pig2/ifZdcfXZAtto9tec55TnTSb+yEkDzkYfTss5OZTqg2ixj+QeHZdFOpONd9ag
         /Aeg==
X-Forwarded-Encrypted: i=1; AJvYcCWir2FztFacz1xZW9cb+Dk6AXfEt38kphjGDYdE/cM+nkqn8GYOhPDpF4WxxlgZPsfnMQ34bQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFlZihFT3I4Vtmrq5RBkFH1nwjaimtAU0XSmpUCwKvG62cXBw9
	K1wk9GWF3Odg+WVHYW0LUBybWcrL2z+7Oe8KqDcW0LIVu9ZeQXwx4T5Z54MI1YQx5KhkxMu9gqP
	FjdYUQdSi5WYu0/DA7rzktyw1DpheHpUe6Vq+zPE3G+LpYBXoj6BSwiZ1
X-Gm-Gg: AY/fxX6NVQz7FWsjBGp5qRiE3a6tGmomPTcRDj1DDzJ/O4c5R0QMKoJvG5rf/hVrN1T
	j39t0offEwPleUtT3+heXkkU6fosFJlI/KqBMbjGsuwi5hIinzSaZZPcENequCUDXyTIGGiWe5r
	iUUgkCZSbkbJGrHjsgaN7ReShLqZOG0gIgAFFbVMYnGyM23y7M7b2CGB6oO76TeSADbqC0j3UtI
	SMLxRoaGcHDsuQZVHJbeJ8qpx4HXzaCZsYeMpT4O5JTxQ5Iz4ieWy3Q7vnPodNrUmFurwpc/pR7
	V+xFRMpQTJYomU4dAz06zab2hNrMooFAUQ56ALJ7qnzviIkb15OyvQA4cCcv6vqYGtcHmX81bDJ
	cKET7SAr6Gi8QCHvY1qLUcdw/IT+JXhV9bg==
X-Received: by 2002:a05:600c:a31a:b0:477:b48d:ba7a with SMTP id 5b1f17b1804b1-47d1afcd9e2mr472221615e9.32.1767601378028;
        Mon, 05 Jan 2026 00:22:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuXSIOihQGqTUh73UD1lwUxn/oQlvSzbaEszKjq8q7pmaQg9MTKbAK1XIofFksKZVCqoImYw==
X-Received: by 2002:a05:600c:a31a:b0:477:b48d:ba7a with SMTP id 5b1f17b1804b1-47d1afcd9e2mr472221315e9.32.1767601377489;
        Mon, 05 Jan 2026 00:22:57 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d13ed0asm147684535e9.3.2026.01.05.00.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:22:57 -0800 (PST)
Date: Mon, 5 Jan 2026 03:22:54 -0500
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
	Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 01/15] dma-mapping: add
 __dma_from_device_group_begin()/end()
Message-ID: <19163086d5e4704c316f18f6da06bc1c72968904.1767601130.git.mst@redhat.com>
References: <cover.1767601130.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1767601130.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IFazUIR4K5GsLZN298PO-kmZtGY5FCwTo8Ks8gP9-Iw_1767601378
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When a structure contains a buffer that DMA writes to alongside fields
that the CPU writes to, cache line sharing between the DMA buffer and
CPU-written fields can cause data corruption on non-cache-coherent
platforms.

Add __dma_from_device_group_begin()/end() annotations to ensure proper
alignment to prevent this:

struct my_device {
	spinlock_t lock1;
	__dma_from_device_group_begin();
	char dma_buffer1[16];
	char dma_buffer2[16];
	__dma_from_device_group_end();
	spinlock_t lock2;
};

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/dma-mapping.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index aa36a0d1d9df..29ad2ce700f0 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -7,6 +7,7 @@
 #include <linux/dma-direction.h>
 #include <linux/scatterlist.h>
 #include <linux/bug.h>
+#include <linux/cache.h>
 
 /**
  * List of possible attributes associated with a DMA mapping. The semantics
@@ -703,6 +704,18 @@ static inline int dma_get_cache_alignment(void)
 }
 #endif
 
+#ifdef ARCH_HAS_DMA_MINALIGN
+#define ____dma_from_device_aligned __aligned(ARCH_DMA_MINALIGN)
+#else
+#define ____dma_from_device_aligned
+#endif
+/* Mark start of DMA buffer */
+#define __dma_from_device_group_begin(GROUP)			\
+	__cacheline_group_begin(GROUP) ____dma_from_device_aligned
+/* Mark end of DMA buffer */
+#define __dma_from_device_group_end(GROUP)			\
+	__cacheline_group_end(GROUP) ____dma_from_device_aligned
+
 static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp)
 {
-- 
MST

