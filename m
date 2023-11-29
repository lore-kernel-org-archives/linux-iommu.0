Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC344B5BA
	for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 17:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 410FD1595;
	Wed, 29 Nov 2023 09:44:20 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3A6DA3F73F;
	Wed, 29 Nov 2023 09:43:29 -0800 (PST)
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
	devicetree@vger.kernel.org
Subject: [PATCH 4/7] dma-mapping: Add helpers for dma_range_map bounds
Date: Wed, 29 Nov 2023 17:43:01 +0000
Message-Id: <b6626985d97ddc33a23b4b9fafa881b35001547e.1701268753.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1701268753.git.robin.murphy@arm.com>
References: <cover.1701268753.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several places want to compute the lower and/or upper bounds of a
dma_range_map, so let's factor that out into reusable helpers.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/loongarch/kernel/dma.c |  9 ++-------
 drivers/acpi/arm64/dma.c    |  8 +-------
 drivers/of/device.c         | 11 ++---------
 include/linux/dma-direct.h  | 18 ++++++++++++++++++
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/loongarch/kernel/dma.c b/arch/loongarch/kernel/dma.c
index 7a9c6a9dd2d0..429555fb4e13 100644
--- a/arch/loongarch/kernel/dma.c
+++ b/arch/loongarch/kernel/dma.c
@@ -8,17 +8,12 @@
 void acpi_arch_dma_setup(struct device *dev)
 {
 	int ret;
-	u64 mask, end = 0;
+	u64 mask, end;
 	const struct bus_dma_region *map = NULL;
 
 	ret = acpi_dma_get_range(dev, &map);
 	if (!ret && map) {
-		const struct bus_dma_region *r = map;
-
-		for (end = 0; r->size; r++) {
-			if (r->dma_start + r->size - 1 > end)
-				end = r->dma_start + r->size - 1;
-		}
+		end = dma_range_map_max(map);
 
 		mask = DMA_BIT_MASK(ilog2(end) + 1);
 		dev->bus_dma_limit = end;
diff --git a/drivers/acpi/arm64/dma.c b/drivers/acpi/arm64/dma.c
index b98a149f8d50..52b2abf88689 100644
--- a/drivers/acpi/arm64/dma.c
+++ b/drivers/acpi/arm64/dma.c
@@ -28,13 +28,7 @@ void acpi_arch_dma_setup(struct device *dev)
 
 	ret = acpi_dma_get_range(dev, &map);
 	if (!ret && map) {
-		const struct bus_dma_region *r = map;
-
-		for (end = 0; r->size; r++) {
-			if (r->dma_start + r->size - 1 > end)
-				end = r->dma_start + r->size - 1;
-		}
-
+		end = dma_range_map_max(map);
 		dev->dma_range_map = map;
 	}
 
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 51062a831970..66879edb4a61 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -117,16 +117,9 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 		if (!force_dma)
 			return ret == -ENODEV ? 0 : ret;
 	} else {
-		const struct bus_dma_region *r = map;
-
 		/* Determine the overall bounds of all DMA regions */
-		for (dma_start = ~0; r->size; r++) {
-			/* Take lower and upper limits */
-			if (r->dma_start < dma_start)
-				dma_start = r->dma_start;
-			if (r->dma_start + r->size > end)
-				end = r->dma_start + r->size;
-		}
+		dma_start = dma_range_map_min(map);
+		end = dma_range_map_max(map);
 	}
 
 	/*
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 3eb3589ff43e..b77e3863daab 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -54,6 +54,24 @@ static inline phys_addr_t translate_dma_to_phys(struct device *dev,
 	return (phys_addr_t)-1;
 }
 
+static inline dma_addr_t dma_range_map_min(const struct bus_dma_region *map)
+{
+	dma_addr_t ret = U64_MAX;
+
+	for (; map->size; map++)
+		ret = min(ret, map->dma_start);
+	return ret;
+}
+
+static inline dma_addr_t dma_range_map_max(const struct bus_dma_region *map)
+{
+	dma_addr_t ret = 0;
+
+	for (; map->size; map++)
+		ret = max(ret, map->dma_start + map->size - 1);
+	return ret;
+}
+
 #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
 #include <asm/dma-direct.h>
 #ifndef phys_to_dma_unencrypted
-- 
2.39.2.101.g768bb238c484.dirty

