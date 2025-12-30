Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1A52E22AB
	for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089774; cv=none; b=YSG8SHdHh0TniytgeEzA414mqAwlVjoLDh3ZW3G3nI1lFHLwZLNetRqdTPtUIQxgKtzJ1BINsnBWl/q0njoUPweca3aeEV/5JTemj1Q5yNpTZukrFPq1W6cqK+cSqu5N/GBO+Co4Md4TCEiC+xkp6zWbDGj7HCAGRpc4ByMKMd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089774; c=relaxed/simple;
	bh=N4HR0a5dn05GuDoktJG7BnG9Lq/5EUgyVWUyfL7k7BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Nf1FJ5AxQsobt4TdTpZozItgvfLWeds8zR8+ioB3d9kncU7cqN7Hbr9aNTl0Mker/LbEYTccHL+P6OKx17xBGfshufowrKZUjaCfd3UJqshJ8E7uOrRDG0/q1tQc3rHr+u5xp80TCCW4z+tLmAs5qF/x3EvsoGC45nCaAxyi9Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gsyT/re7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsyT/re7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5P8nBFllNyVQLFQFLwvEGLPOI82khKcPXA1snN92gfM=;
	b=gsyT/re7zBghS/yQntGAGJu/ISHw3WlYNSYuOoI3O5bVjjfEChnWJYC8bfiysfM7cdsytI
	mC1VU/x0p9sSZcPopYpSC8DxVm38YZ7jhJABhGAUEAI/psZFsU4ReqN0GjJ5mGfM899Qof
	2dYKGMpN2Pc62ofKcAndOkY+dEAyPcI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-tSPBgxsvP6600KUCmMUTEA-1; Tue, 30 Dec 2025 05:16:08 -0500
X-MC-Unique: tSPBgxsvP6600KUCmMUTEA-1
X-Mimecast-MFC-AGG-ID: tSPBgxsvP6600KUCmMUTEA_1767089768
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430fcb6b2ebso5739127f8f.2
        for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 02:16:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089767; x=1767694567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5P8nBFllNyVQLFQFLwvEGLPOI82khKcPXA1snN92gfM=;
        b=F78ExpTNkkMYEYgAq2xSgIICPNT6OBps4tJtPTlYzw9mhACBUjYn6WnNpMJRljUuR/
         fR0OOuMcqAfm/UnmLThfDmgHB+YBGNhKrDekxwfATCqq8icGrZJnex8AergXahDTXa3s
         u/JGr+BjOPHB54uGqe+NTSoS3Ydxi9pTqme7QudJ92XJ6gySaxsTDmIBcs0R7YnuuTxa
         ZHNslfInbmMTonkNu4NeMhefI6FwMs07enLCJ6Md9X22mNzUatmVBXxGU+bn7PdxdMdW
         lq44j6ldsUwQpLrz06sSMaqQnXYUa8oLOXwhkZID65uUkutebhQnFKC3N1JyO10VUopU
         g5Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVOjgmAHzZfjKlwtEdlgBeiYcOlZOY19vejQ6+3WF1M1Ig7CgY5EkPwiPUptJSlJ1genYazNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwptslNyHf5VvMIwTzibIrhY7BfqUbDP2vzBjKRioZzEaDIeEQ1
	Xd7b/uKnkcY+mqTEuuYouy6N2VEnzTRRoPcoQj2ElRjkA8oJ6PFhMze4k3Ir+pSSpUvMF9CIpWW
	wIq/ber2IPAqJlhYLsksYMEG90cTYnEWQ/zmn4its/hMcPNCigecifrU9
X-Gm-Gg: AY/fxX6vT4YU8TKkFEBYZRvzAMjKZmzUNOY+UulY4j4uJf/eD9H4+BAxCfqhQDiCViE
	3R7R2SVnnC2WX6o1adk9kN7dz40Ug7IJtdOiWqh16JHcT0DBKuq78wFI0sdBQpZkjLXZviHOcpC
	nWLDLFgfAxiGEFkMfcw6Tmn/1ek/ekWK3t5SiQzsh1ugxQ/t27pfxuFPcsL3BlClwg9jxtIENxo
	A5HPfzaVCWl+rPTz4n4mhMXYzPt6XdthBeC89DDvJoUk30gy6DAwY1W7hOJm2TM0tE4EiCAoQaJ
	PM3tQu+gKoEICI9um44V7itn6tQpfo2MKaECcjpoEGIuBAOAyElNmuCDx+cCe/3PprA5K0NISrR
	ge5c/ZHpaQGRzrosFJ6j7dac6VJFWFBsSPQ==
X-Received: by 2002:a5d:5f54:0:b0:431:2b2:9628 with SMTP id ffacd0b85a97d-4324e506ba3mr39259954f8f.52.1767089767430;
        Tue, 30 Dec 2025 02:16:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtsdMUlb1wS6GR5OayFkymlWIYaYAnUxOGKY8jeZK45Dwg0ymMw4lZ1+63FGBt0jVsyojNrA==
X-Received: by 2002:a5d:5f54:0:b0:431:2b2:9628 with SMTP id ffacd0b85a97d-4324e506ba3mr39259899f8f.52.1767089766895;
        Tue, 30 Dec 2025 02:16:06 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa477bsm67834948f8f.36.2025.12.30.02.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:16:06 -0800 (PST)
Date: Tue, 30 Dec 2025 05:16:03 -0500
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
Subject: [PATCH RFC 06/13] virtio: add virtqueue_add_inbuf_cache_clean API
Message-ID: <e5a7240e7c8e590c4745a76c4ab4d76f7f8bd88c.1767089672.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: Kv4PW1E8ThG3A9WrMSGDEBSV6I4oiaf6Bxp7rLMkwao_1767089768
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add virtqueue_add_inbuf_cache_clean() for passing DMA_ATTR_CPU_CACHE_CLEAN
to virtqueue operations. This suppresses DMA debug cacheline overlap
warnings for buffers where proper cache management is ensured by the
caller.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c | 72 ++++++++++++++++++++++++++----------
 include/linux/virtio.h       |  5 +++
 2 files changed, 58 insertions(+), 19 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 1832ea7982a6..19a4a8cd22f9 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -382,7 +382,7 @@ static int vring_mapping_error(const struct vring_virtqueue *vq,
 /* Map one sg entry. */
 static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist *sg,
 			    enum dma_data_direction direction, dma_addr_t *addr,
-			    u32 *len, bool premapped)
+			    u32 *len, bool premapped, unsigned long attr)
 {
 	if (premapped) {
 		*addr = sg_dma_address(sg);
@@ -410,7 +410,7 @@ static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist
 	 */
 	*addr = virtqueue_map_page_attrs(&vq->vq, sg_page(sg),
 					 sg->offset, sg->length,
-					 direction, 0);
+					 direction, attr);
 
 	if (vring_mapping_error(vq, *addr))
 		return -ENOMEM;
@@ -539,7 +539,8 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 				      void *data,
 				      void *ctx,
 				      bool premapped,
-				      gfp_t gfp)
+				      gfp_t gfp,
+				      unsigned long attr)
 {
 	struct vring_desc_extra *extra;
 	struct scatterlist *sg;
@@ -605,7 +606,8 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 			dma_addr_t addr;
 			u32 len;
 
-			if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr, &len, premapped))
+			if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr, &len,
+					     premapped, attr))
 				goto unmap_release;
 
 			prev = i;
@@ -622,7 +624,8 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 			dma_addr_t addr;
 			u32 len;
 
-			if (vring_map_one_sg(vq, sg, DMA_FROM_DEVICE, &addr, &len, premapped))
+			if (vring_map_one_sg(vq, sg, DMA_FROM_DEVICE, &addr, &len,
+					     premapped, attr))
 				goto unmap_release;
 
 			prev = i;
@@ -1315,7 +1318,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 					 unsigned int in_sgs,
 					 void *data,
 					 bool premapped,
-					 gfp_t gfp)
+					 gfp_t gfp,
+					 unsigned long attr)
 {
 	struct vring_desc_extra *extra;
 	struct vring_packed_desc *desc;
@@ -1346,7 +1350,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
 			if (vring_map_one_sg(vq, sg, n < out_sgs ?
 					     DMA_TO_DEVICE : DMA_FROM_DEVICE,
-					     &addr, &len, premapped))
+					     &addr, &len, premapped, attr))
 				goto unmap_release;
 
 			desc[i].flags = cpu_to_le16(n < out_sgs ?
@@ -1441,7 +1445,8 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
 				       void *data,
 				       void *ctx,
 				       bool premapped,
-				       gfp_t gfp)
+				       gfp_t gfp,
+				       unsigned long attr)
 {
 	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
@@ -1466,7 +1471,7 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
 
 	if (virtqueue_use_indirect(vq, total_sg)) {
 		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
-						    in_sgs, data, premapped, gfp);
+						    in_sgs, data, premapped, gfp, attr);
 		if (err != -ENOMEM) {
 			END_USE(vq);
 			return err;
@@ -1502,7 +1507,7 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
 
 			if (vring_map_one_sg(vq, sg, n < out_sgs ?
 					     DMA_TO_DEVICE : DMA_FROM_DEVICE,
-					     &addr, &len, premapped))
+					     &addr, &len, premapped, attr))
 				goto unmap_release;
 
 			flags = cpu_to_le16(vq->packed.avail_used_flags |
@@ -2244,14 +2249,17 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 				void *data,
 				void *ctx,
 				bool premapped,
-				gfp_t gfp)
+				gfp_t gfp,
+				unsigned long attr)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	return vq->packed_ring ? virtqueue_add_packed(vq, sgs, total_sg,
-					out_sgs, in_sgs, data, ctx, premapped, gfp) :
+					out_sgs, in_sgs, data, ctx, premapped, gfp,
+					attr) :
 				 virtqueue_add_split(vq, sgs, total_sg,
-					out_sgs, in_sgs, data, ctx, premapped, gfp);
+					out_sgs, in_sgs, data, ctx, premapped, gfp,
+					attr);
 }
 
 /**
@@ -2289,7 +2297,7 @@ int virtqueue_add_sgs(struct virtqueue *_vq,
 			total_sg++;
 	}
 	return virtqueue_add(_vq, sgs, total_sg, out_sgs, in_sgs,
-			     data, NULL, false, gfp);
+			     data, NULL, false, gfp, 0);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
 
@@ -2311,7 +2319,7 @@ int virtqueue_add_outbuf(struct virtqueue *vq,
 			 void *data,
 			 gfp_t gfp)
 {
-	return virtqueue_add(vq, &sg, num, 1, 0, data, NULL, false, gfp);
+	return virtqueue_add(vq, &sg, num, 1, 0, data, NULL, false, gfp, 0);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
 
@@ -2334,7 +2342,7 @@ int virtqueue_add_outbuf_premapped(struct virtqueue *vq,
 				   void *data,
 				   gfp_t gfp)
 {
-	return virtqueue_add(vq, &sg, num, 1, 0, data, NULL, true, gfp);
+	return virtqueue_add(vq, &sg, num, 1, 0, data, NULL, true, gfp, 0);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_outbuf_premapped);
 
@@ -2356,10 +2364,36 @@ int virtqueue_add_inbuf(struct virtqueue *vq,
 			void *data,
 			gfp_t gfp)
 {
-	return virtqueue_add(vq, &sg, num, 0, 1, data, NULL, false, gfp);
+	return virtqueue_add(vq, &sg, num, 0, 1, data, NULL, false, gfp, 0);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_inbuf);
 
+/**
+ * virtqueue_add_inbuf_cache_clean - expose input buffers with cache clean hint
+ * @vq: the struct virtqueue we're talking about.
+ * @sg: scatterlist (must be well-formed and terminated!)
+ * @num: the number of entries in @sg writable by other side
+ * @data: the token identifying the buffer.
+ * @gfp: how to do memory allocations (if necessary).
+ *
+ * Adds DMA_ATTR_CPU_CACHE_CLEAN attribute to suppress overlapping cacheline
+ * warnings in DMA debug builds. Has no effect in production builds.
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
+ */
+int virtqueue_add_inbuf_cache_clean(struct virtqueue *vq,
+				    struct scatterlist *sg, unsigned int num,
+				    void *data,
+				    gfp_t gfp)
+{
+	return virtqueue_add(vq, &sg, num, 0, 1, data, NULL, false, gfp,
+			     DMA_ATTR_CPU_CACHE_CLEAN);
+}
+EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_cache_clean);
+
 /**
  * virtqueue_add_inbuf_ctx - expose input buffers to other end
  * @vq: the struct virtqueue we're talking about.
@@ -2380,7 +2414,7 @@ int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
 			void *ctx,
 			gfp_t gfp)
 {
-	return virtqueue_add(vq, &sg, num, 0, 1, data, ctx, false, gfp);
+	return virtqueue_add(vq, &sg, num, 0, 1, data, ctx, false, gfp, 0);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
 
@@ -2405,7 +2439,7 @@ int virtqueue_add_inbuf_premapped(struct virtqueue *vq,
 				  void *ctx,
 				  gfp_t gfp)
 {
-	return virtqueue_add(vq, &sg, num, 0, 1, data, ctx, true, gfp);
+	return virtqueue_add(vq, &sg, num, 0, 1, data, ctx, true, gfp, 0);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_premapped);
 
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 3626eb694728..63bb05ece8c5 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -62,6 +62,11 @@ int virtqueue_add_inbuf(struct virtqueue *vq,
 			void *data,
 			gfp_t gfp);
 
+int virtqueue_add_inbuf_cache_clean(struct virtqueue *vq,
+				    struct scatterlist sg[], unsigned int num,
+				    void *data,
+				    gfp_t gfp);
+
 int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
 			    struct scatterlist sg[], unsigned int num,
 			    void *data,
-- 
MST

