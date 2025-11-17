Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C076329AAF7
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 21:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413971; cv=none; b=SLFQxFc2S3tOi/bHczq0A+FkoOJNGWpKShgaj3rykCNJN9DcXt9JqKlaDa8A9OkcFMHsN83TjpmmCc2gVXT3+7jtqnWbT3WKHdQR9YYKxEI115CZMX3oQaLELgKVJadOy1wLLuA+g4uAvTTHyfEj0cokGUbR/9SV2horpJ3/ZnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413971; c=relaxed/simple;
	bh=06g6Ze5++elbefzL2fov8fU8vPKEBx2BVXi1ANCwzv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1qRsMitVviCBCEswm8orUmWss5L7Euq2l6By3cJHevecGvegq4Ik1YfuSRIsjwQ8re0eE1cBuOkzlRtZxfaMZNIfc9qEmQpsS/ObYbwtHNRbVMcC/+9heAE8DdlYlk6YGDeGdsuWj9rNToahCqn1IHqXkWzcTW/3Rqf96J95Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKB+2Wzy; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKB+2Wzy"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a435a3fc57so4478668b3a.1
        for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 13:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763413968; x=1764018768; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuXcd6ZXNfZRwCh9su49jDLB1TDteKCX2U/VlZmUj0o=;
        b=LKB+2Wzyvm1MBZAiM9NPuzOEsveZzS3ciaBYenm5iEDr6toGAPHUIfyyeskiT7S1Gc
         VVWjA7gP1UW9zY611qX+VRfTD4j+kiV4o4v5LdJfCNK8oeY7zz6n9BbfSBm8JCdgYPJc
         AULYWOP4jdWb49/8/Riw0lguFb/kOrs/DwMg0K/CnTy54p+T3GZcExQvRjzBJMzlj8Gx
         nKnHVVfaOf3mCAKGO+1Qf4xVoCYwg+Rd4MLqh+IOagCNgGEgNF06kLaJHgcXucwzWUnK
         28/XzHFtPxaVgiHB2c1K84A+3H8ARwAjJ4xHDgDgSOIdvz6IrdKtZJl4OFf9gzXRHiTV
         vDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763413968; x=1764018768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DuXcd6ZXNfZRwCh9su49jDLB1TDteKCX2U/VlZmUj0o=;
        b=eik9MxYF3VvrCnHkZscNZ4u9UzqPeyofYZljbzt1uuzOZMri/xkjKqPsbYiL4E0BqH
         te9VrHuPFRwLmHSQ+YLtvel0UussbjiFytiIvEeI3xJbVdI+mGHxAcA8Sp2UGEM/hAVZ
         vULDa7b+YPzDGBZv65cmhdf53/9cEFwZuHHWJun6YHFcK/mpFBvXIB0Oo90ATtrOZF22
         epeazBQ+Cgx0sqEx2bjC0nVTMwxmOdmrXkqXbmj5svShwd4lfBg1AFy8GShFWWLhlnL+
         mnLdt0bEtDXSAaOQ7DvokqmG3uxR8vJvMDFkzXqFEcJh04E5EbGLiSfIDrSts29hFxyz
         0afw==
X-Forwarded-Encrypted: i=1; AJvYcCUlS/JmAUWcrTS4HK0lJVZbKNZ9DgXOR4Dcu3fyqQLXaHU37ivfkNtdKYHUG5DV1bW0qmS1wg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yze58ta/hvskZTvGM2zVkA134YGd2KMtq4vrlBgebkv/QV0xRb6
	+f+w8+nmZ+ptGUEUCHBA1fmT7VXIzSX0MLZYB/qJOwOBliyY4QxvETY8
X-Gm-Gg: ASbGnctnDANAZIGSDyNddtoMZpif3/I5+1hnXIY2Y8MgpKzWo3YPPtOBzWUOGaOQ/EG
	fro4K3s+acJXhYbj2tgizC7fxfZUCsml1zPUNc0IY4+dVAVLIOdqK3qRhm54utCEKbBIfK0gBcc
	OrEOHTmu2ciq4DYOCOUtisOKjZzck4uK8XryLjOobWyWZQ/A3s2kFAftp0yMS3z7KhEa9rA6/yt
	WeoeIqotHheK151y8mMV/qQR/myjl6zMryjG9rHCQhFUujbUaPd85yEZK7NwYZ4zWuLcqu+mxkT
	DBuaIpwjE7+dARQRWLP/AZyaQCJItNA28wB9j6UvAc6RKRMX0tu95FL6cMHU0SMSgHkFMqSblCP
	r6p68yXhKmiBmBo9Vwjiz9/GxGeG/KzU0Ni8cXgs8bRNruFopOHkjE35U++4cuD0kbYioYDYkBq
	x3ImJnRbRhwv8LUEkoaAwXhiZveWQvfriyVjo=
X-Google-Smtp-Source: AGHT+IFSEUgsiZktulUmeB8pXWguWvj7s6zr3OozfhUDrxizwYtKAoo18Qyw1X6M+Z13BxEn5inB/Q==
X-Received: by 2002:a05:6a20:7352:b0:34f:ce39:1f42 with SMTP id adf61e73a8af0-35b9f88dec1mr14685872637.8.1763413967976;
        Mon, 17 Nov 2025 13:12:47 -0800 (PST)
Received: from Barrys-MBP.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc37703a0d9sm12820297a12.31.2025.11.17.13.12.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Nov 2025 13:12:47 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: catalin.marinas@arm.com
Cc: 21cnbao@gmail.com,
	ada.coupriediaz@arm.com,
	anshuman.khandual@arm.com,
	ardb@kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	m.szyprowski@samsung.com,
	maz@kernel.org,
	robin.murphy@arm.com,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	will@kernel.org,
	zhengtangquan@oppo.com
Subject: Re: [RFC PATCH 5/5] dma-mapping: Allow batched DMA sync operations if supported by the arch
Date: Tue, 18 Nov 2025 05:12:38 +0800
Message-Id: <20251117211238.50126-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <aRYhJO9_eR9W-EnZ@arm.com>
References: <aRYhJO9_eR9W-EnZ@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Nov 14, 2025 at 2:19 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Wed, Oct 29, 2025 at 10:31:15AM +0800, Barry Song wrote:
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 1f9ee9759426..a0b45f84a91f 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -403,9 +403,16 @@ void dma_direct_sync_sg_for_device(struct device *dev,
> >               swiotlb_sync_single_for_device(dev, paddr, sg->length, dir);
> >
> >               if (!dev_is_dma_coherent(dev))
> > -                     arch_sync_dma_for_device(paddr, sg->length,
> > -                                     dir);
> > +#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
> > +                     arch_sync_dma_for_device_batch_add(paddr, sg->length, dir);
> > +#else
> > +                     arch_sync_dma_for_device(paddr, sg->length, dir);
> > +#endif
> >       }
> > +#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
> > +     if (!dev_is_dma_coherent(dev))
> > +             arch_sync_dma_batch_flush();
> > +#endif
> >  }
> >  #endif
>
> Just a high-level comment for now. I'm not opposed to the idea of
> batching the DSB barriers, we do this for ptes. However, the way it's


Thanks, Catalin. I agree we need batching, as phones and embedded systems
could use many DMA buffers while some chips lack DMA-coherency.


> implemented in the generic files, with lots of #ifdefs, makes the code
> pretty unreadable.
>
> Can we have something like arch_sync_dma_begin/end() and let the arch
> code handle the barriers as they see fit?


I guess I can refactor it as below and then remove the #ifdef/#else/#endif blocks.

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 8fcd0a9c1f39..73bca4d7149d 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -373,6 +373,20 @@ void arch_sync_dma_for_device_batch_add(phys_addr_t paddr, size_t size,
 void arch_sync_dma_for_cpu_batch_add(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir);
 void arch_sync_dma_batch_flush(void);
+#else
+static inline void arch_sync_dma_for_device_batch_add(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
+{
+	arch_sync_dma_for_device(paddr, size, dir);
+}
+static inline void arch_sync_dma_for_cpu_batch_add(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
+{
+	arch_sync_dma_for_cpu(paddr, size, dir);
+}
+static inline void arch_sync_dma_batch_flush(void)
+{
+}
 #endif
 
 #ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index a0b45f84a91f..69b14b0c0501 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -403,16 +403,10 @@ void dma_direct_sync_sg_for_device(struct device *dev,
 		swiotlb_sync_single_for_device(dev, paddr, sg->length, dir);
 
 		if (!dev_is_dma_coherent(dev))
-#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
 			arch_sync_dma_for_device_batch_add(paddr, sg->length, dir);
-#else
-			arch_sync_dma_for_device(paddr, sg->length, dir);
-#endif
 	}
-#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
 	if (!dev_is_dma_coherent(dev))
 		arch_sync_dma_batch_flush();
-#endif
 }
 #endif
 
@@ -429,11 +423,7 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 		phys_addr_t paddr = dma_to_phys(dev, sg_dma_address(sg));
 
 		if (!dev_is_dma_coherent(dev))
-#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
 			arch_sync_dma_for_cpu_batch_add(paddr, sg->length, dir);
-#else
-			arch_sync_dma_for_cpu(paddr, sg->length, dir);
-#endif
 
 		swiotlb_sync_single_for_cpu(dev, paddr, sg->length, dir);
 
@@ -443,9 +433,7 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 
 	if (!dev_is_dma_coherent(dev)) {
 		arch_sync_dma_for_cpu_all();
-#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
 		arch_sync_dma_batch_flush();
-#endif
 	}
 }
 
@@ -458,29 +446,19 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 {
 	struct scatterlist *sg;
 	int i;
-#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
 	bool need_sync = false;
-#endif
 
 	for_each_sg(sgl,  sg, nents, i) {
 		if (sg_dma_is_bus_address(sg)) {
 			sg_dma_unmark_bus_address(sg);
 		} else {
-#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
 			need_sync = true;
 			dma_direct_unmap_phys_batch_add(dev, sg->dma_address,
 					      sg_dma_len(sg), dir, attrs);
-
-#else
-			dma_direct_unmap_phys(dev, sg->dma_address,
-					      sg_dma_len(sg), dir, attrs);
-#endif
 		}
 	}
-#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
 	if (need_sync && !dev_is_dma_coherent(dev))
 		arch_sync_dma_batch_flush();
-#endif
 }
 #endif
 
@@ -490,9 +468,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 	struct pci_p2pdma_map_state p2pdma_state = {};
 	struct scatterlist *sg;
 	int i, ret;
-#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
 	bool need_sync = false;
-#endif
 
 	for_each_sg(sgl, sg, nents, i) {
 		switch (pci_p2pdma_state(&p2pdma_state, dev, sg_page(sg))) {
@@ -504,14 +480,9 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 			 */
 			break;
 		case PCI_P2PDMA_MAP_NONE:
-#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
 			need_sync = true;
 			sg->dma_address = dma_direct_map_phys_batch_add(dev, sg_phys(sg),
 					sg->length, dir, attrs);
-#else
-			sg->dma_address = dma_direct_map_phys(dev, sg_phys(sg),
-					sg->length, dir, attrs);
-#endif
 			if (sg->dma_address == DMA_MAPPING_ERROR) {
 				ret = -EIO;
 				goto out_unmap;
@@ -529,10 +500,8 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		sg_dma_len(sg) = sg->length;
 	}
 
-#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
 	if (need_sync && !dev_is_dma_coherent(dev))
 		arch_sync_dma_batch_flush();
-#endif
 	return nents;
 
 out_unmap:


Thanks
Barry
