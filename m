Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F109C3B27DC;
	Fri, 17 Apr 2026 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776416410; cv=none; b=EI+7tAoUOJBdkv4vHXWPIyu7Df/8D6KOmjn2pfGDTv4l2IC/ExsXpEP/7UPhIGYp+2uWif1CwaeoyMrCeR3uTyfICngVYgNKhUPTq+VU0e3Z7m8wKfL5ftggIgz0WvUdsoR5oFX6dfC3WNhv6/8FanicO499iB0q42uyx3KfreY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776416410; c=relaxed/simple;
	bh=NYO/ZaWM8DspsP7qrAyCMciTobaVhBewQVuwza9k9yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFwSdDFzdcINgCZZR2XD5YCzuppU1LYPe6k1yY9U57+6kzVeHtu7KYExVyEfBkKmQf2UoIUaYiM0lFCrW2+BtI5IA4S6fBJwIo0z0/Jr4sx0jIBk5lO/X/DzofUPYSiYshRcAW+6CNimg/D+79z4mbZkgiHKhUZAuLdu79afjzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnVbwAFN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnVbwAFN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628DFC19425;
	Fri, 17 Apr 2026 09:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776416409;
	bh=NYO/ZaWM8DspsP7qrAyCMciTobaVhBewQVuwza9k9yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YnVbwAFNZxABj4oWCJi4Kzzfe4qynC1Y8IeQgDp9wA0ZfufMTDxTDHEr5+lyG2Fg9
	 T+FTKst6wohzKXlWdsVgyMAw/Un29ReEcO59EYSexa5SwC7B9owCs2K8vyMjXu/SgK
	 pTbSS1IG+fn7fqEZXtaGponmKVWvSAFfVII1QbTHDLzhYtXEXKwxA7KJ8yteTH805i
	 Nzh8b7eIGTR52i8SXcxAYDfx1wxb/tZ+M6Pk/NMOICkIayuaEg+pDzzsIiyKLMcnJe
	 5jqhLmsjit5DhXQ2oR/8yQzN0+qf88wjces8bwzD6vWqPVcWqgyDYPR6E1mEwOH8BF
	 8zT7oRdpWxf3g==
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
Subject: [RFC PATCH 6/7] dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_DECRYPTED
Date: Fri, 17 Apr 2026 14:28:59 +0530
Message-ID: <20260417085900.3062416-7-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417085900.3062416-1-aneesh.kumar@kernel.org>
References: <20260417085900.3062416-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach dma_direct_map_phys() to select the DMA address encoding based on
DMA_ATTR_CC_DECRYPTED.

Use phys_to_dma_unencrypted() for decrypted mappings and
phys_to_dma_encrypted() otherwise. If a device requires unencrypted DMA
but the source physical address is still encrypted, force the mapping
through swiotlb so the DMA address and backing memory attributes remain
consistent.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.h | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index 6184ff303f08..421dcfb146d8 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -81,9 +81,14 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 		phys_addr_t phys, size_t size, enum dma_data_direction dir,
 		unsigned long attrs)
 {
+	bool force_swiotlb_map = false;
 	dma_addr_t dma_addr;
 
-	if (is_swiotlb_force_bounce(dev)) {
+	/* if phys addr attribute is encrypted but the device is forcing an encrypted dma addr */
+	if (!(attrs & DMA_ATTR_CC_DECRYPTED) && force_dma_unencrypted(dev))
+		force_swiotlb_map = true;
+
+	if (is_swiotlb_force_bounce(dev) || force_swiotlb_map) {
 		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
 			return DMA_MAPPING_ERROR;
 
@@ -94,16 +99,18 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 		dma_addr = phys;
 		if (unlikely(!dma_capable(dev, dma_addr, size, false)))
 			goto err_overflow;
+	} else if (attrs & DMA_ATTR_CC_DECRYPTED) {
+		dma_addr = phys_to_dma_unencrypted(dev, phys);
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

