Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC9B3905E4
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 05:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790573969; cv=none; b=VxNJsB45ulP7PyEYWjeICWjFLadM0g1jq329JmDe+kzTlhaq6Vu4LSDP88m2wk4OTQQImw3zBCIGf0bglrf1XDyVLd+mQ70K6CRT69y97dVw9oTTWxjJ+k4un4jdPIae3Dh4whrvechMZ78YUYt93RpY6wIBib07vDCP9cqWxOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790573969; c=relaxed/simple;
	bh=vU3G+Dpf20aZ+9WW19yBDyvOCi9xmow7DgGMoyE68S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BuZF3VvElFrmZ4t3PPQssTnQCAMhRLRb/E/NwJIp3rjf/103G09Wtjg5mn9HguQMZLUZWogMqIDlhhXqhJJYKI6UTC9d2gsPciDmrL40xwbtFiecUjVctnW9LEomYGnNCTJCmmq4GGhWDOTSsWvsMRu/rhrBIoREJtZPMAy4CGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSVELFyH; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSVELFyH"
Received: by mail-pz2-f37.google.com with SMTP id d2e1a72fcca58-880a6cea1f7so73211b3a.0
        for <iommu@lists.linux.dev>; Sun, 27 Sep 2026 22:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790573959; x=1791178759; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x+ooTTX9f0Dee2MM//tZyofUwOPATbbov9mICSl7hdg=;
        b=aSVELFyHEANCw2F7t+DFoFr5f1ZY0u+2xnYlbx6FVXero5uwUwlHw0UVfJdsCgZuuE
         rWKBWHjho3WbMUr69cnIhB82YeA2q71E5nKWsgSAKRemwrcaMvRwNTa8KbX22X73lC3J
         skBuxe56SnNkbRl0XI7406PyNXeHPsZWzXTUZAu98dAwQcrPsgH6LCNzSq1ON7D9ML5a
         s3RBYcyOOrl4LPA6yl1eJcVrQwEiChIl/IVYtvnXYAuZZc2Lq+As95y+gsuQ5meDIPzz
         bXvqEnPM6VnuNn0pXcuZe8BrSJ9yjJcnAegFDGdjh+XemI5p2EFk9g4x2VO9yRKdP3jN
         91Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790573959; x=1791178759;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x+ooTTX9f0Dee2MM//tZyofUwOPATbbov9mICSl7hdg=;
        b=I4DGcZC/7K7FsdotNNvqYd22yHEPC4X0+2PDXws7cCRg8ib0C9opRNVq9zgsrSk9ZL
         mctoXgQYzuwkUcQR5VK+QO636zTKz/xWWNZsCr0l4UWLp34fig6T/l3GcY1C6v7bty+u
         y3WQ4DMEg2GsBA0bxJ7eImEtBxUZEo/ZID9SGKtcabdJVvtltKa5jjMOAAehY27sBINF
         xLtmYF18cR/MAgEumdD+zvpjvGOuxBvV1eD1ELKrFgPG1uZwcYHsqIQLgDCYor76WipE
         hLuu6wRMNL/L7UAPtY0G8c5uaxlvL2q02wYK/bHPusy3A6gVsF9zXYidRsO6CBUoa5/2
         /N3A==
X-Forwarded-Encrypted: i=1; AKwUvByMNZbN7LCeT7LktVhF2bi+BbdRnVqBMkIgv3blYSQd0rDmEPM8IPE6njQx0Wq2TJAFNtLlMg==@lists.linux.dev
X-Gm-Message-State: AFuF++mEud0ehE2khrTXl2PN4Hf2L+McLwuvqpKSRnuC8Ki6F5Dy3pQY
	3N/43fBLN2F+6zW9RnYibIwREnyjJiCsrRyeYctswzDNSrYQLAAcIH8G
X-Gm-Gg: AYBFou2keSYQC9doS8NY0R7wBpY898R1rWjNEv5ai9lASsi+weuKoSs5jJLHYV/L/ZH
	5apCRtJrXHo4NOzIdOAX7Osyc7a8MI65hcr0QUO3QlCGhsh9/j5j9JFTjQLTj3cx9gadkd0Tlfx
	aaaJeapOphYUrZIN0qEzS2gKMAhEKLGj/3xHNxEHWHuEwh41tGT1k99faH+PHo0FEkjXBCX0/GD
	u4A/uCzOBYnrHu21+HIVtrlu0lyaXR1/SoK7tu4pK5ZAjDl6/bt2DOLuf6EP1lU42WoFtuhMs1m
	uOgsBTaH2C3GUrNqVYYPKqlxOkE6zEk58g3HK2L7epTlwO9kTwrnczJ/TKJiQG3Gsp9MvEBZLVp
	AUWpwjkhH8ljhBldWTxt5DGNJC4WvFPYtkpSk3L1K+fOeXWA8e9ym9r+MqPXoErVhnaTwNbxzol
	zfhsooigLZLi7MEWMvDZMq7R/oo/6q5UGgXPKurg0KFDWnxMsJkkIpVxNyKn3jeAlQ5jYMP7RG5
	uXenordxlrV3Q==
X-Received: by 2002:aa7:9193:0:b0:880:4b51:af11 with SMTP id d2e1a72fcca58-8804b51b2e5mr8040887b3a.2.1790573959042;
        Sun, 27 Sep 2026 22:39:19 -0700 (PDT)
Received: from jfliu-sfa1411.. ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87febb82357sm3591121b3a.61.2026.09.27.22.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 22:39:18 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
	freedreno@lists.freedesktop.org,
	iommu@lists.linux.dev,
	Dmitry Baryshkov <lumag@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	linux-media@vger.kernel.org,
	Bryan O'Donoghue <bod.linux@nxsw.ie>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Sean Paul <sean@poorly.run>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v1 2/2] drm/msm: map page-less imported sg_tables from their DMA addresses
Date: Mon, 28 Sep 2026 13:38:51 +0800
Message-ID: <20260928053901.7270-3-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928053901.7270-1-liujianfeng1994@gmail.com>
References: <20260928053901.7270-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With CONFIG_DMABUF_DEBUG=y, dma_buf_map_attachment() hands importers a
copy of the attachment sg_table with the struct page pointers stripped
and sg->length zeroed; only sg_dma_address()/sg_dma_len() are carried
over.  msm consumes sg->length and sg_phys() in both of its map paths:

 - msm_iommu_pagetable_map() (userspace managed, per-process GPU
   pagetables) walks the sg_table with sg->length and sg_phys()

 - msm_iommu_map() (kernel managed mappings: display, and TTBR1 for the
   GPU), via iommu_map_sgtable(), which consumes sg->length and
   sg_phys() as well

With a page-stripped sg_table both paths silently map nothing and
return success.  Userspace then observes arm-smmu translation faults
once the GPU first touches the mapping, e.g. during hardware video
decode:

  gpu fault: ttbr0=000000088a889000 iova=000000010741c000 dir=READ
  type=TRANSLATION source=UCHE

and __arm_lpae_unmap() WARNs for the never-mapped ranges when the GEM
handles are closed (a WARN storm of ~470 traces within a minute of
video playback on my x1e78100 laptop).

For sg entries that still carry a struct page (native objects, and
imports without the DMABUF_DEBUG wrapper) keep using sg_phys(), so
native objects which msm never dma-maps itself (non-MSM_BO_WC) are
unaffected.  For page-less entries, recover the physical address from
the DMA address instead: dmabuf attachments are dma-mapped against
the msm drm device, so the dma_addr -> phys lookup can be done with
iommu_iova_to_phys() in that device's DMA-API domain, cached per VM
in struct msm_mmu::dma_domain at msm_gem_vm_create() time.  If the
drm device is direct mapped the DMA address already is a physical
address and the lookup degenerates to the identity.

Applied on top of "drm/msm/gem: Drop use of pages for imported
dma-bufs" [1], which removes the remaining struct page consumers for
imported buffers.  With both, hardware video decode works with
DMABUF_DEBUG=y, tested with clapper and chromium on x1e78100
(Snapdragon X1E78100): zero arm-smmu faults, zero io-pgtable WARNs,
correct frames.  Without this patch, the same system logs a WARN
trace per unmap and falls back to a copy path for video playback.

[1] <20260926183051.25754-1-robin.clark@oss.qualcomm.com>

Suggested-by: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>
Cc: Christian König <christian.koenig@amd.com>

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---

 drivers/gpu/drm/msm/msm_gem_vma.c |  9 ++++
 drivers/gpu/drm/msm/msm_iommu.c   | 90 ++++++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/msm_mmu.h     | 13 +++++
 3 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index f687a629629d3..322b96e0e07ec 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -840,6 +840,15 @@ msm_gem_vm_create(struct drm_device *drm, struct msm_mmu *mmu, const char *name,
 		goto err_free_vm;
 	}
 
+	/*
+	 * dma-buf imports attach against the msm drm device, and their
+	 * sg_dma_address() lives in that device's DMA-API domain.  Keep it
+	 * so the map paths can translate page-less sg_table entries (the
+	 * DMABUF_DEBUG wrapper) back to physical addresses.
+	 */
+	if (device_iommu_mapped(drm->dev))
+		mmu->dma_domain = iommu_get_dma_domain(drm->dev);
+
 	if (!managed) {
 		struct drm_sched_init_args args = {
 			.ops = &msm_vm_bind_ops,
diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index da6782fca6bd2..8407a37f9efee 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -140,6 +140,24 @@ static int msm_iommu_pagetable_unmap(struct msm_mmu *mmu, u64 iova,
 	return ret;
 }
 
+/**
+ * msm_mmu_dma_to_phys() - recover the physical address of a dma address
+ *
+ * dma-buf attachments are dma-mapped against the msm drm device, so the
+ * DMA domain of that device (msm_mmu::dma_domain) holds the mapping.
+ * For a direct-mapped drm device the DMA address already is a physical
+ * address.
+ */
+static phys_addr_t msm_mmu_dma_to_phys(struct msm_mmu *mmu, dma_addr_t dma_addr)
+{
+	struct iommu_domain *dma_domain = mmu->dma_domain;
+
+	if (!dma_domain)
+		return (phys_addr_t)dma_addr;
+
+	return iommu_iova_to_phys(dma_domain, dma_addr);
+}
+
 static int msm_iommu_pagetable_map_prr(struct msm_mmu *mmu, u64 iova, size_t len, int prot)
 {
 	struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
@@ -184,8 +202,35 @@ static int msm_iommu_pagetable_map(struct msm_mmu *mmu, u64 iova,
 		return msm_iommu_pagetable_map_prr(mmu, iova, len, prot);
 
 	for_each_sgtable_sg(sgt, sg, i) {
-		size_t size = sg->length;
-		phys_addr_t phys = sg_phys(sg);
+		size_t size;
+		phys_addr_t phys;
+
+		if (sg_page(sg)) {
+			/* CPU-view entry: native objects, and imported
+			 * sg_tables that still carry struct page
+			 */
+			size = sg->length;
+			phys = sg_phys(sg);
+		} else {
+			/*
+			 * Page-less entry, e.g. the sg_table wrapper
+			 * that dma_buf_map_attachment() hands out when
+			 * CONFIG_DMABUF_DEBUG=y (page pointers stripped,
+			 * sg->length zeroed, only the DMA fields carried
+			 * over).  Recover the physical address by
+			 * translating the DMA address through the drm
+			 * device's DMA-API domain.
+			 */
+			size = sg_dma_len(sg);
+			phys = msm_mmu_dma_to_phys(mmu, sg_dma_address(sg));
+
+			if (!size || !phys) {
+				dev_err(mmu->dev,
+					"cannot map page-less sg entry: dma=%pad len=%zu\n",
+					&sg_dma_address(sg), size);
+				return -EINVAL;
+			}
+		}
 
 		if (!len)
 			break;
@@ -697,6 +742,47 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
 	if (iova & BIT_ULL(48))
 		iova |= GENMASK_ULL(63, 49);
 
+	/*
+	 * With CONFIG_DMABUF_DEBUG=y, imported sg_tables carry no struct
+	 * page and sg->length is zeroed; iommu_map_sgtable() would consume
+	 * zero length and silently map nothing.  Map from the (translated)
+	 * DMA addresses instead.
+	 */
+	if (!sg_page(sgt->sgl)) {
+		struct scatterlist *sg;
+		size_t mapped = 0;
+		unsigned int i;
+
+		for_each_sgtable_dma_sg(sgt, sg, i) {
+			phys_addr_t phys =
+				msm_mmu_dma_to_phys(mmu, sg_dma_address(sg));
+			size_t size = sg_dma_len(sg);
+
+			if (!phys || !size) {
+				ret = -EINVAL;
+				goto err_unmap;
+			}
+
+			ret = iommu_map(iommu->domain, iova + mapped, phys,
+					size, prot, GFP_KERNEL);
+			if (ret)
+				goto err_unmap;
+
+			mapped += size;
+		}
+
+		if (mapped != len) {
+			ret = -EINVAL;
+			goto err_unmap;
+		}
+
+		return 0;
+
+err_unmap:
+		iommu_unmap(iommu->domain, iova, mapped);
+		return ret;
+	}
+
 	ret = iommu_map_sgtable(iommu->domain, iova, sgt, prot);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/gpu/drm/msm/msm_mmu.h b/drivers/gpu/drm/msm/msm_mmu.h
index 8915662fbd4d0..116daf6ce47cb 100644
--- a/drivers/gpu/drm/msm/msm_mmu.h
+++ b/drivers/gpu/drm/msm/msm_mmu.h
@@ -64,6 +64,19 @@ struct msm_mmu {
 	 * msm_gem_vm::mmu_lock.
 	 */
 	struct msm_mmu_prealloc *prealloc;
+
+	/**
+	 * @dma_domain: DMA-API domain of the msm drm device
+	 *
+	 * dma-buf attachments are dma-mapped against the msm drm device,
+	 * so this domain holds the mapping dma_addr -> phys for imported
+	 * buffers.  Used to recover the physical address of sg_table
+	 * entries which carry no struct page (e.g. the page-stripped
+	 * sg_table wrapper that dma_buf_map_attachment() hands out when
+	 * CONFIG_DMABUF_DEBUG=y).  NULL if the drm device is direct
+	 * mapped, in which case DMA addresses are physical addresses.
+	 */
+	struct iommu_domain *dma_domain;
 };
 
 static inline void msm_mmu_init(struct msm_mmu *mmu, struct device *dev,
-- 
2.47.3

