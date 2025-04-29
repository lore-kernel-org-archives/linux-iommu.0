Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1495825B1C6;
	Tue, 29 Apr 2025 23:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970725; cv=none; b=PpVdDcAH04IUhFaR8kyGfMrCxgwMKI/ZQRftSU9EZKV8YKg6DHYxAmi70ghrEguzxFoKTMsHqtL6LgSVWS0PL5HTLz8Iz8zkVtCFoN4zTERKrqihOfxD8itsekYeLC/sTXmRrfMT+UhLJPzE/PoJictxOiUdhdlaxT0JqucOdrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970725; c=relaxed/simple;
	bh=sblt9djggLp1JCyF9tTDg57/72SfwRAstOcT03tuH0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FLqQyj2uWCEE/HTBTAipIzxb5vyuDyp+MqFz1ZyQeUKmmxb/+63w0BRwZKs5KwQ80Hvtmsp8bOC6fAdRewgTEGwkKRCM6l5z9RFOJDS1wsXFcrkVDHYzuuf7G4rp26MFmiH8sFIFIdDoZY1zmM6AFC7cycCkqsEv+pkFPgdxEOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eK3Sh+CM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eK3Sh+CM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F83C4CEE3;
	Tue, 29 Apr 2025 23:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970725;
	bh=sblt9djggLp1JCyF9tTDg57/72SfwRAstOcT03tuH0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eK3Sh+CMUkfGZoi9tSr8Qhtu/ZShCqtk4WvgeQ+ADATEiVHwriWPsjZOBB/UJ6Csl
	 47SdBwbS7fWzTaaHnjNGQsqFSwrssXYUyqHA1iPFP9tWAanvA80Lt/6Tv7RlUWSXWu
	 44GLULXnuNYYog6wFZD5Mm7VUw8NNHV2VH01qcOQlIBruP3Y9ErT8nhj6Cl5wi/Fxm
	 LfhzOXqYVKVWkcVvm/6A81n6N8kdswZLBWkQVCG3net3jGNSX8UlvNmw44MDBhmCRS
	 ikD+c6EcMU9g8isDQCDuNmCPiWwPr7o7K9rkDd/YS/wV8OYEwqoQaFD8nAyxc+eFty
	 FjL3VQAgkdDxA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Balbir Singh <balbirs@nvidia.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	kernel test robot <lkp@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 23/37] dma-mapping: Fix warning reported for missing prototype
Date: Tue, 29 Apr 2025 19:51:08 -0400
Message-Id: <20250429235122.537321-23-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235122.537321-1-sashal@kernel.org>
References: <20250429235122.537321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.25
Content-Transfer-Encoding: 8bit

From: Balbir Singh <balbirs@nvidia.com>

[ Upstream commit cae5572ec9261f752af834cdaaf5a0ba0afcf256 ]

lkp reported a warning about missing prototype for a recent patch.

The kernel-doc style comments are out of sync, move them to the right
function.

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202504190615.g9fANxHw-lkp@intel.com/

Signed-off-by: Balbir Singh <balbirs@nvidia.com>
[mszyprow: reformatted subject]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/20250422114034.3535515-1-balbirs@nvidia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/mapping.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index f7366083b4d00..74d453ec750a1 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -897,14 +897,6 @@ int dma_set_coherent_mask(struct device *dev, u64 mask)
 }
 EXPORT_SYMBOL(dma_set_coherent_mask);
 
-/**
- * dma_addressing_limited - return if the device is addressing limited
- * @dev:	device to check
- *
- * Return %true if the devices DMA mask is too small to address all memory in
- * the system, else %false.  Lack of addressing bits is the prime reason for
- * bounce buffering, but might not be the only one.
- */
 static bool __dma_addressing_limited(struct device *dev)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
@@ -918,6 +910,14 @@ static bool __dma_addressing_limited(struct device *dev)
 	return !dma_direct_all_ram_mapped(dev);
 }
 
+/**
+ * dma_addressing_limited - return if the device is addressing limited
+ * @dev:	device to check
+ *
+ * Return %true if the devices DMA mask is too small to address all memory in
+ * the system, else %false.  Lack of addressing bits is the prime reason for
+ * bounce buffering, but might not be the only one.
+ */
 bool dma_addressing_limited(struct device *dev)
 {
 	if (!__dma_addressing_limited(dev))
-- 
2.39.5

