Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72490137927
	for <iommu@lists.linux.dev>; Fri, 19 Apr 2024 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545716; cv=none; b=hND7W4Ezl8Kn1JwCM4699xYn3vh1KAVK3BrUutep5ljBiSLG5d1xFtPzJ4t9VYhN8vcMEE1L+BGWQS1wrVN8YEoISGgh9K7+jjWP+n35+nCmS/Uvz0QhPi7GaRh3xu15sij1RzSgG5Vg7WugXikFJFj5MgFcRRBHBTF+Dslr9e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545716; c=relaxed/simple;
	bh=pOu8SkBP1o2YI89QRW9IkEizSqtcRRWP9wRbqkcsIYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lNulAH/u7DkXo0EOlr32kZRfehcDofh1/jYA72/UZ/70GX3yUJlFtj+lKaEazCFBgtEOl3VHSv3F99FjkALV51pNQAnmiQAQqIOFlvM5RsnJwsHNP//KAVr1BjtlJV1x6eDnJesRjm9UpO2pbBzIks6G751srPZCdwzTY/HKkJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01596106F;
	Fri, 19 Apr 2024 09:55:42 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C13D73F792;
	Fri, 19 Apr 2024 09:55:08 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: Joerg Roedel <joro@8bytes.org>,
	Christoph Hellwig <hch@lst.de>
Cc: Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 2/7] OF: Simplify DMA range calculations
Date: Fri, 19 Apr 2024 17:54:41 +0100
Message-Id: <3e0a72fe3d79eae660e4284bb32f2cb39868ccd7.1713523152.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1713523152.git.robin.murphy@arm.com>
References: <cover.1713523152.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Juggling start, end, and size values for a range is somewhat redundant
and a little hard to follow. Consolidate down to just using inclusive
start and end, which saves us worrying about size overflows for full
64-bit ranges (note that passing a potentially-overflowed value through
to arch_setup_dma_ops() is benign for all current implementations, and
this is working towards removing that anyway).

Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/of/device.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index a988bee2ee5a..841ccd3a19d1 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -96,7 +96,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 	const struct bus_dma_region *map = NULL;
 	struct device_node *bus_np;
 	u64 dma_start = 0;
-	u64 mask, end, size = 0;
+	u64 mask, end = 0;
 	bool coherent;
 	int iommu_ret;
 	int ret;
@@ -118,17 +118,15 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 			return ret == -ENODEV ? 0 : ret;
 	} else {
 		const struct bus_dma_region *r = map;
-		u64 dma_end = 0;
 
 		/* Determine the overall bounds of all DMA regions */
 		for (dma_start = ~0; r->size; r++) {
 			/* Take lower and upper limits */
 			if (r->dma_start < dma_start)
 				dma_start = r->dma_start;
-			if (r->dma_start + r->size > dma_end)
-				dma_end = r->dma_start + r->size;
+			if (r->dma_start + r->size > end)
+				end = r->dma_start + r->size;
 		}
-		size = dma_end - dma_start;
 	}
 
 	/*
@@ -142,16 +140,15 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 		dev->dma_mask = &dev->coherent_dma_mask;
 	}
 
-	if (!size && dev->coherent_dma_mask)
-		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
-	else if (!size)
-		size = 1ULL << 32;
+	if (!end && dev->coherent_dma_mask)
+		end = dev->coherent_dma_mask;
+	else if (!end)
+		end = (1ULL << 32) - 1;
 
 	/*
 	 * Limit coherent and dma mask based on size and default mask
 	 * set by the driver.
 	 */
-	end = dma_start + size - 1;
 	mask = DMA_BIT_MASK(ilog2(end) + 1);
 	dev->coherent_dma_mask &= mask;
 	*dev->dma_mask &= mask;
@@ -185,7 +182,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 	} else
 		dev_dbg(dev, "device is behind an iommu\n");
 
-	arch_setup_dma_ops(dev, dma_start, size, coherent);
+	arch_setup_dma_ops(dev, dma_start, end - dma_start + 1, coherent);
 
 	if (iommu_ret)
 		of_dma_set_restricted_buffer(dev, np);
-- 
2.39.2.101.g768bb238c484.dirty

