Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64CA382394;
	Mon, 20 Apr 2026 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776665703; cv=none; b=BcZ3E3M1mA1gdrWU2LsssnpV9KHFAtqMjDpXdPKHbdxOPbdj/4GRJztOA6W2atP30omoBYJRnm8gtSdCJG1Wm8PBk8JiXQ5caq3/YlykzKvIrbfSpgO3kFOO0aKhrFa360/S7sQQ20JewdBhFhny9kl1QHgVk2kiKsmnHIrsTFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776665703; c=relaxed/simple;
	bh=3eMn2u2YEN6En5447o5RZhZklJlk3dOyuwVq1PI0vqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5FAWMkR/cf63USC4YHdjQkvOIUiUM8JJEyhDsp7aLOzpUoXuhulBuMtskahpNHb3xzEBubXo7o/3RaN/wv1Om6oWmWK/IMjje45ASA0kJkjq3aP3+dptjj8brTiV+09+VuEPaOLdkpYFjLplAGax1It53jtguIAmje220nMb90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZtir5u5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZtir5u5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF1FC19425;
	Mon, 20 Apr 2026 06:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776665703;
	bh=3eMn2u2YEN6En5447o5RZhZklJlk3dOyuwVq1PI0vqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fZtir5u5me2V49coOeNhc//fHF32hm46phYjWiTdCSfh7T3f/4O8hAyyCgXoXc+wS
	 dnIeFsWVOyfUd0HunEQKAUNhLVf4Y5uDuURr0QjOdzn7cITgQQoE/wUE08ZGNmkrkf
	 oiCl9j4agLcpqHrezSV2zYkAilwSE5rCAbzsOIeyPSn4rqTDnoAiJNeZHVG818EIHW
	 QvxbCwwmUl0XIekoUn/gmOGmYLuW4dK4NTHSrMgW54KNjc83uWMQFzZBrCzKmyRllD
	 8rz+1etgtH5SwRsxZUHr6zbDGdV6ZKM9FWHpEsighoJOEhHfsVBqsXQ6zUI+YPRvVS
	 lkU2bqi1yy+wg==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com,
	m.szyprowski@samsung.com,
	will@kernel.org,
	maz@kernel.org,
	suzuki.poulose@arm.com,
	catalin.marinas@arm.com,
	jiri@resnulli.us,
	jgg@ziepe.ca,
	aneesh.kumar@kernel.org,
	Mostafa Saleh <smostafa@google.com>
Subject: [PATCH v2 6/8] dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED
Date: Mon, 20 Apr 2026 11:44:13 +0530
Message-ID: <20260420061415.3650870-7-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420061415.3650870-1-aneesh.kumar@kernel.org>
References: <20260420061415.3650870-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach dma_direct_map_phys() to select the DMA address encoding based on
DMA_ATTR_CC_SHARED.

Use phys_to_dma_unencrypted() for decrypted mappings and
phys_to_dma_encrypted() otherwise. If a device requires unencrypted DMA
but the source physical address is still encrypted, force the mapping
through swiotlb so the DMA address and backing memory attributes remain
consistent.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.h | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index 7140c208c123..928671ef01e9 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -86,9 +86,14 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 		phys_addr_t phys, size_t size, enum dma_data_direction dir,
 		unsigned long attrs, bool flush)
 {
+	bool force_swiotlb_map = false;
 	dma_addr_t dma_addr;
 
-	if (is_swiotlb_force_bounce(dev)) {
+	/* if phys addr attribute is encrypted but the device is forcing an encrypted dma addr */
+	if (!(attrs & DMA_ATTR_CC_SHARED) && force_dma_unencrypted(dev))
+		force_swiotlb_map = true;
+
+	if (is_swiotlb_force_bounce(dev) || force_swiotlb_map) {
 		if (!(attrs & DMA_ATTR_CC_SHARED)) {
 			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
 				return DMA_MAPPING_ERROR;
@@ -105,18 +110,16 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 			goto err_overflow;
 	} else if (attrs & DMA_ATTR_CC_SHARED) {
 		dma_addr = phys_to_dma_unencrypted(dev, phys);
-		if (unlikely(!dma_capable(dev, dma_addr, size, false)))
-			goto err_overflow;
 	} else {
-		dma_addr = phys_to_dma(dev, phys);
-		if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
-		    dma_kmalloc_needs_bounce(dev, size, dir)) {
-			if (is_swiotlb_active(dev) &&
-			    !(attrs & DMA_ATTR_REQUIRE_COHERENT))
-				return swiotlb_map(dev, phys, size, dir, attrs);
+		dma_addr = phys_to_dma_encrypted(dev, phys);
+	}
 
-			goto err_overflow;
-		}
+	if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
+	    dma_kmalloc_needs_bounce(dev, size, dir)) {
+		if (is_swiotlb_active(dev) &&
+		    !(attrs & DMA_ATTR_REQUIRE_COHERENT))
+			return swiotlb_map(dev, phys, size, dir, attrs);
+		goto err_overflow;
 	}
 
 	if (!dev_is_dma_coherent(dev) &&
-- 
2.43.0

