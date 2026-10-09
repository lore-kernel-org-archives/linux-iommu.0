Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F244265CA8
	for <iommu@lists.linux.dev>; Fri,  9 Oct 2026 00:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791505292; cv=none; b=PCNX1+Y8Ihf2DYQkaFysDlw4Bhytsc/0+aoTkoR703m50lKcR2aHEBaN2mrts0eSDPr4NUrGn/RmvjVjVrvzv0m0AwtRYD/NASEa891nxaHTaBi6iPpx/5GgoFOQEepj8xzJi/8CLwTZktiV1O4+gfvNkvD+5vnWFNFtV1wkBKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791505292; c=relaxed/simple;
	bh=81q18fEwGnKX+7eGBet0/jWI0M1XpVvgscSWDRtUeFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y2bwCEQ0s0Wb/iYkNEhLC/dHKGxOZY9VbglsUorKO6UUIctNrEkFWloEQUFFrMJ7/5fvGUhOvprN2d6NM4k+5Vgwk51Tz8jiJluwm3/lhnG4XIx4vVCJfhq1JQucObBGVzJtZOgwG4WZZiNSzTLuFlmJFA/Zx4QWDOE/NKTleYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8yAz0v3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8yAz0v3"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1698ea378so30742445e9.2
        for <iommu@lists.linux.dev>; Thu, 08 Oct 2026 17:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791505289; x=1792110089; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SuA9XknANPL6VvC11pYgn0IAp4/AWH6zzAsKWJ2B0W4=;
        b=F8yAz0v3yfTyDswzIY1HuHd6WGHhxBAE520TqDz7diaDqE9RyRt625gAL9i6FuhMC5
         yEy8e2+/akUCyHPpmkA7a7dnrtQP2OP9PxKx+Aeo7hv6xbhmW2OifVOLvO+fX6kSfhGX
         eAZkCbG1uSoArTSzNc8Jp1YW7R4bRaypQzJYW/FxtRtjTUOUH0+NxCSWonYx1LJhHxLZ
         RuhfDn3geq46UTF81rp9cBnfwK6nnzV111WSwVeUBRuBXslq1warEo7eM+SOIMt5ZPam
         zoecVFwdh9kfNfd0CxIm3sw5J8FdpY+VaLKYSBEPohVd7hgrycKN1WGVZA1azWn5vv1E
         jKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791505289; x=1792110089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SuA9XknANPL6VvC11pYgn0IAp4/AWH6zzAsKWJ2B0W4=;
        b=Pe0ktbJFN+mm7QV7at0j7TasiexNChLcEvrhh9GByubnqOMoo6NYImwLABq7Rrouqh
         JEynRWCbCshNtLiW6iqI3B5ZNUyYtuKLe3lFSVyErSoBgS+LhDsHJgAxbGfrNeO7ZpHg
         fqoGfEPozyzt1F1MTfm/kjDZ1nApLHhMEn7Tn5hDpbH935PaFhVw+TvNIReyk1ARaTFD
         876W2k7fbaCuSnHX7+JcO6U4LRh5y1PFt1x9bHZ2Px7iXmRa3PiyeX8QE9Jz313QQ73Y
         aAt8EVAyhuIUKmRVTJV0lXw4tBOl+jMqxwMK+LGpZHU7InHUIpPThbF3tOX+xFoD56yP
         DH0A==
X-Gm-Message-State: AFuF++kJwLWemH91E2oI9RcB5NqydE0CFlloRlpXk1ayuq5YjwuCRwOn
	+pSxg4UWo5sn3y44bMawUwGS6YOxvqLoSf3yD00UWcO/keYgXmsb9HkIsvEg0Lpf
X-Gm-Gg: AYBFou27nOaPVOrt09kGhu3cDddlg3OdbNJ5ZFiCsOUqQolNhQHY1jL3NuEld0a/H22
	RUF+1bvexisRhCw2hfurXZOIkQHHNnlUbtHvKONY6FcLBok+qANbHQNNXQa3KQsEDeXxGJ/QwO6
	OZ3/XA949ePd+BYJrMviqOxv3de6wSCW4dUzHBjMzZw3IVArA5xKFxSXnfPmbN/iETEvyf8oiN2
	TDp/CIYXiqgt4sYGCzMDi9yXy+VR/5xIzcANMcm8agTSzQB8GUi2KRUtslPpodX1RVIQ9PKRLRT
	xWu/v6ht5Hxi7V5iIof4I1vIBKera8O3MbKhWnAUjrc0c+nGbji1oO6oIaIw71UHEkQ0KmzFK2G
	mNd8glasu6spefN7OEXt7+AcBFN2ym7RDJtVjy6k71NX1XRfSYSuDMBlF/8KRcjEQ+qeNB2vPpU
	5RjLL7RH9PsPgKNXCxUvpOh2zGpEhrcNH6GGXl82bV/sKfNJUv+97hwwSbabkXtbLmZkgmUQCli
	vciOnsm8mm+n9SUHd94B60OE4kLd88ghFIEq4nUhlyJQwDuc8A+X6zsgTNb9stCRvPjXWoTv9Ri
	rlins3e92fEMMmwLSVnTpR5Ayso5PldzU5RuoMwIHf+X03wSQgn1It8aVlyBArBeJpUGlWAQ/HB
	vLssJLzw=
X-Received: by 2002:a05:600c:8706:b0:4a0:1efa:c74a with SMTP id 5b1f17b1804b1-4a18e4b0f6amr2065355e9.20.1791505289240;
        Thu, 08 Oct 2026 17:21:29 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad61-5a01-743c-891f-b33c-cae7.310.pool.telefonica.de. [2a02:3100:ad61:5a01:743c:891f:b33c:cae7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18e4987casm3364605e9.1.2026.10.08.17.21.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 17:21:27 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Diederik de Haas <diederik@cknow-tech.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andyshrk@163.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] iommu: Add iommu_map_sgtable_dma()
Date: Fri,  9 Oct 2026 02:21:13 +0200
Message-Id: <20261009002114.67851-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261009002114.67851-1-kmehltretter@gmail.com>
References: <20261009002114.67851-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DMA-BUF attachments provide DMA addresses, not CPU-side pages.
iommu_map_sgtable() needs those pages, so private-domain importers such
as Rockchip cannot use it with strict DMABUF_DEBUG.

Add an iommu-dma helper to map a live attachment into another domain by
translating through the device's default DMA domain. Roll back target
mappings on error. This still recovers physical addresses internally.

Only non-bounced iommu-dma mappings are supported. Other DMA backends,
marked bus addresses and zero translations return -EOPNOTSUPP, as does
the IOMMU_DMA=n stub. A zero lookup cannot distinguish a hole from PA0.
Reject bounce slots because a second mapping cannot keep them in sync
with writes to the original buffer.

DMABUF_DEBUG currently drops DMA flags from its copy, so the bus-address
check depends on the input retaining that mark.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/iommu/dma-iommu.c | 131 ++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h     |  12 ++++
 2 files changed, 143 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 58c624513cd4..b9a1f91ec5db 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -38,6 +38,137 @@
 #include "dma-iommu.h"
 #include "iommu-pages.h"
 
+/**
+ * iommu_map_sgtable_dma - map the DMA side of an sg_table into a domain
+ * @domain: domain to map into
+ * @iova: IOVA of the first byte
+ * @dev: device for which @sgt is mapped
+ * @sgt: live DMA-API mapping for @dev, backed by non-bounced RAM
+ * @prot: IOMMU protection flags
+ *
+ * Translate the DMA addresses through @dev's default iommu-dma domain and
+ * map the backing memory into @domain without reading the CPU side of @sgt.
+ * Direct DMA and other DMA backends are not supported. Entries marked as
+ * PCI P2P bus addresses and SWIOTLB bounce buffers are also not supported.
+ *
+ * The caller must keep the source mapping, DMA backend and default domain
+ * unchanged until the target mapping is removed. This function may sleep.
+ * DMA addresses and lengths must be aligned to the smaller of the source
+ * and target domains' minimum page sizes. @iova and the total length must
+ * be aligned to the target domain's minimum page size.
+ *
+ * A zero reverse translation is unsupported: iommu_iova_to_phys() cannot
+ * distinguish an absent mapping from a mapping to physical address zero.
+ *
+ * Return: the number of bytes mapped, -EOPNOTSUPP for unsupported source
+ * mappings or source alignment, or another negative errno on error. Any
+ * target mappings installed by this call are removed on error.
+ */
+ssize_t iommu_map_sgtable_dma(struct iommu_domain *domain, unsigned long iova,
+			      struct device *dev, struct sg_table *sgt,
+			      int prot)
+{
+	struct iommu_domain *dma_domain;
+	size_t len = 0, mapped = 0, total = 0;
+	struct scatterlist *sg;
+	size_t granule, target_granule;
+	phys_addr_t start = 0;
+	unsigned long last_iova;
+	unsigned int i;
+	int ret;
+
+	if (!domain->pgsize_bitmap)
+		return -EINVAL;
+
+	target_granule = 1UL << __ffs(domain->pgsize_bitmap);
+	if (!use_dma_iommu(dev))
+		return -EOPNOTSUPP;
+	dma_domain = iommu_get_dma_domain(dev);
+	if (!dma_domain || !dma_domain->pgsize_bitmap)
+		return -EOPNOTSUPP;
+	granule = min(target_granule,
+		      1UL << __ffs(dma_domain->pgsize_bitmap));
+
+	for_each_sgtable_dma_sg(sgt, sg, i) {
+		dma_addr_t last_dma;
+		size_t dma_len = sg_dma_len(sg);
+
+		if (sg_dma_is_bus_address(sg))
+			return -EOPNOTSUPP;
+		if (!dma_len || !IS_ALIGNED(sg_dma_address(sg), granule) ||
+		    !IS_ALIGNED(dma_len, granule))
+			return -EOPNOTSUPP;
+		if (check_add_overflow(sg_dma_address(sg), dma_len - 1,
+				       &last_dma) ||
+		    check_add_overflow(total, dma_len, &total))
+			return -EOVERFLOW;
+	}
+	if (!total)
+		return 0;
+	if (total > SSIZE_MAX || !IS_ALIGNED(iova, target_granule) ||
+	    !IS_ALIGNED(total, target_granule))
+		return -EINVAL;
+	if (check_add_overflow(iova, total - 1, &last_iova))
+		return -EOVERFLOW;
+
+	for_each_sgtable_dma_sg(sgt, sg, i) {
+		dma_addr_t dma_addr = sg_dma_address(sg);
+		size_t dma_len = sg_dma_len(sg);
+
+		while (dma_len) {
+			phys_addr_t next;
+			phys_addr_t phys;
+
+			phys = iommu_iova_to_phys(dma_domain, dma_addr);
+			if (!phys || swiotlb_find_pool(dev, phys)) {
+				ret = -EOPNOTSUPP;
+				goto out_err;
+			}
+
+			if (len && check_add_overflow(start, len, &next)) {
+				ret = -EOVERFLOW;
+				goto out_err;
+			}
+			if (len && phys != next) {
+				ret = iommu_map_nosync(domain, iova + mapped,
+						       start, len, prot,
+						       GFP_KERNEL);
+				if (ret)
+					goto out_err;
+				mapped += len;
+				len = 0;
+			}
+			if (!len)
+				start = phys;
+			if (check_add_overflow(len, granule, &len)) {
+				ret = -EOVERFLOW;
+				goto out_err;
+			}
+			dma_addr += granule;
+			dma_len -= granule;
+		}
+	}
+
+	if (len) {
+		ret = iommu_map_nosync(domain, iova + mapped, start, len, prot,
+				       GFP_KERNEL);
+		if (ret)
+			goto out_err;
+		mapped += len;
+	}
+
+	ret = iommu_sync_map(domain, iova, mapped);
+	if (ret)
+		goto out_err;
+
+	return mapped;
+
+out_err:
+	iommu_unmap(domain, iova, mapped);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_map_sgtable_dma);
+
 struct iommu_dma_msi_page {
 	struct list_head	list;
 	dma_addr_t		iova;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ac43b8b93f14..95d90c7f953b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1604,8 +1604,20 @@ static inline void iommu_debugfs_setup(void) {}
 #endif
 
 #ifdef CONFIG_IOMMU_DMA
+ssize_t iommu_map_sgtable_dma(struct iommu_domain *domain, unsigned long iova,
+			      struct device *dev, struct sg_table *sgt,
+			      int prot);
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
 #else /* CONFIG_IOMMU_DMA */
+static inline ssize_t iommu_map_sgtable_dma(struct iommu_domain *domain,
+					    unsigned long iova,
+					    struct device *dev,
+					    struct sg_table *sgt,
+					    int prot)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
 {
 	return -ENODEV;
-- 
2.53.0

