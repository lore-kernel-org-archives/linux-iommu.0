Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20F230F94D
	for <iommu@lists.linux.dev>; Fri, 26 Dec 2025 22:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766789657; cv=none; b=XHL4Jiha/TXJ3PY8E87w1ehDJrdtsEtOa7uh2QoByen/3PA43e2DxTOHcvfpGj3wZz9RWIWJtmfJ0ukRu95pSStfcDDlhgpNkHNyCStxxSA0RqtHvtZOpxqHysE9obtXdNhPg4UTnGAlMN1JaObEI4gkzpFFLWH2hjuqOCJFXP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766789657; c=relaxed/simple;
	bh=tT7PtF41A77X6yZ13NHHIhgroMHXFQkhSKzdCIl4WmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/HEDdQtCwzlHTlG1c3p5VwAM+4oariL5mO9NeAI1uuDlxaePfg9ENpaWqRCg+b0dq3kkooz4azJVcI7cn9cUKKpFaDbqpaCMPw+oGssvdSe8p3QjIIsR9iuzdPK7CGSfYo+8sWtrgwSFEvYibjbQgSbmxivYTBo5A1LGWJxvCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqVwziM+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqVwziM+"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a09757004cso96804125ad.3
        for <iommu@lists.linux.dev>; Fri, 26 Dec 2025 14:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766789652; x=1767394452; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mp0y7L70LQWZn3MNrpl8AtI1agZhiyYjI11ja2HdtI=;
        b=HqVwziM+irugX8vxxq4pRpL0JCgKfbzd6EnEL2FJXTJg7vHnaz92sHqRBlsb39auBp
         y1m163UJvg4y+5kcXqD4F72Ijo4MGyYiPDpYKM2fwW4TcPAMb0jnswW+O2zXMFjzmlIv
         1V6hnzgU0eaGdUBghOhlwpC6snJaTfjO8PKD92vnsEGyMR9ckJEks2q3Bbo60UIi+HVy
         Rd6RzKu/KVZQQ3YYDdI6Y23yZFpyaF5CB4JMCYI0rPkQ6B9DOUMXAu1bDpFBF22Sgpal
         fFfpRdcA8e4H5JAjW0L50PUmev4OozOLPk5HfPyRygd72b64qtDh0a0/h9id0+gZQkmM
         7tvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766789652; x=1767394452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9mp0y7L70LQWZn3MNrpl8AtI1agZhiyYjI11ja2HdtI=;
        b=ZQavOf1lA1aAaiC4vi3kFa5dr6fC4xpMwYAzwT1XNNZeea6CQverIylM1CmGmWfOZ6
         vYFmdalSdVCDli5uLNrkUob8lkHOVqcHyJonbTfw1VrMKvHNJfuMo1ulniKORN6bSWVL
         5plnC1sAAN23r4aHT8/GeP8gxYczvRZbSyuKwlbImRMuvugljVm4dC6BCvcSvLyqRhX9
         n3i+3JO0MsHU7O+tQQKMz8SDmtfW1Sa2zicihtmSUk83hqvh+WL+C0ULBNS/m4dmOg+O
         KAxU9sDXiJqZp0fK2uoI7ETi8dGmRZoTpGpVN5rFwGiwPzAKana+XLwXo3DK+2wR60Ce
         fpmw==
X-Forwarded-Encrypted: i=1; AJvYcCW0Pq3QH9skMJD7mosROVdBayspAQ/xjfC4f3wS9n48Qf1V+e9npPU0BEH6pgluKk3Y/wGN9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXIlc+w65EZyvBb6Em0Xg70A8azbLSfYjR72k5WlfU+1KPCME1
	zacYJQrxrJFKPs3rvvk/5/SsaRv+29mt91oJJtvSU1Irq68KNaaOnymb
X-Gm-Gg: AY/fxX7c0ysRiwu2kNuFIOUn+MrM4GEg6ZaKp55snp2GYNEXd+BN0hWw4ulH9OI0nPN
	GQLBgho5sw47SQefoCxMi5/61xFdsjxk9vNaxx47LiefwdbnRmA3Wcp2/UgrfTrXy4kPqG5RMBQ
	9uztSeLEdCa4fvxm3/u2pwsxbI6ajyrnqnMJthPAwf6vb0PMMNXMqUrWw6HjpgPAl05mz4JHCAR
	3HAj02b2r1dOpf2aDmrh7aH/T2xRtFTOVEy5FgmiQ3WxaMYd+cmfhRKGGQtzVYrMNE0VS0+BfW+
	I24mwyzat0c+mBX/Qokz3L0t0G0h8kzUMVD7DjIUSHf6YludfjqOi3F/oh5j0kX5D78CIw/yvSf
	aKgQotRmI64Aw/S2X19La8mY+zWs8whTnMtWFU14mD09FKXH4fLwHC4HNFwuum+Veh93FM1wlZb
	YsOsnZl2NehUn7
X-Google-Smtp-Source: AGHT+IH3Qyivahvz1Re89nhjkOGapFSbuTfRVGKZtZJZOQKn2pFT9vJfuh0AHXHFbf1hI+2p00nHuQ==
X-Received: by 2002:a17:902:f607:b0:2a1:4c31:335 with SMTP id d9443c01a7336-2a2f2717b88mr227808145ad.26.1766789652012;
        Fri, 26 Dec 2025 14:54:12 -0800 (PST)
Received: from barry-desktop.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e772ac1acsm9981428a91.9.2025.12.26.14.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 14:54:11 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: catalin.marinas@arm.com,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	will@kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	Barry Song <baohua@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	Tangquan Zheng <zhengtangquan@oppo.com>
Subject: [PATCH RFC v2 7/8] dma-iommu: Support DMA sync batch mode for IOVA link and unlink
Date: Sat, 27 Dec 2025 11:52:47 +1300
Message-ID: <20251226225254.46197-8-21cnbao@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251226225254.46197-1-21cnbao@gmail.com>
References: <20251226225254.46197-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <baohua@kernel.org>

Apply batched DMA synchronization to __dma_iova_link() and
iommu_dma_iova_unlink_range_slow(). For multiple
sync_dma_for_device() and sync_dma_for_cpu() calls, we only
need to wait once for the completion of all sync operations,
rather than waiting for each one individually.

I do not have the hardware to test this, so it is marked as
RFC. I would greatly appreciate it if someone could test it.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Tangquan Zheng <zhengtangquan@oppo.com>
Signed-off-by: Barry Song <baohua@kernel.org>
---
 drivers/iommu/dma-iommu.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 6827763a3877..ffa940bdbbaf 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1849,10 +1849,8 @@ static int __dma_iova_link(struct device *dev, dma_addr_t addr,
 	bool coherent = dev_is_dma_coherent(dev);
 	int prot = dma_info_to_prot(dir, coherent, attrs);
 
-	if (!coherent && !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))) {
+	if (!coherent && !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
 		arch_sync_dma_for_device(phys, size, dir);
-		arch_sync_dma_flush();
-	}
 
 	return iommu_map_nosync(iommu_get_dma_domain(dev), addr, phys, size,
 			prot, GFP_ATOMIC);
@@ -1995,6 +1993,8 @@ int dma_iova_sync(struct device *dev, struct dma_iova_state *state,
 	dma_addr_t addr = state->addr + offset;
 	size_t iova_start_pad = iova_offset(iovad, addr);
 
+	if (!dev_is_dma_coherent(dev))
+		arch_sync_dma_flush();
 	return iommu_sync_map(domain, addr - iova_start_pad,
 		      iova_align(iovad, size + iova_start_pad));
 }
@@ -2008,6 +2008,8 @@ static void iommu_dma_iova_unlink_range_slow(struct device *dev,
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	size_t iova_start_pad = iova_offset(iovad, addr);
+	bool need_sync_dma = !dev_is_dma_coherent(dev) &&
+			!(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO));
 	dma_addr_t end = addr + size;
 
 	do {
@@ -2023,16 +2025,17 @@ static void iommu_dma_iova_unlink_range_slow(struct device *dev,
 			end - addr, iovad->granule - iova_start_pad);
 
 		if (!dev_is_dma_coherent(dev) &&
-		    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))) {
+		    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
 			arch_sync_dma_for_cpu(phys, len, dir);
-			arch_sync_dma_flush();
-		}
 
 		swiotlb_tbl_unmap_single(dev, phys, len, dir, attrs);
 
 		addr += len;
 		iova_start_pad = 0;
 	} while (addr < end);
+
+	if (need_sync_dma)
+		arch_sync_dma_flush();
 }
 
 static void __iommu_dma_iova_unlink(struct device *dev,
-- 
2.43.0

