Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD32291D
	for <iommu@lists.linux.dev>; Sat, 28 Oct 2023 10:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A7AC1424;
	Sat, 28 Oct 2023 03:21:59 -0700 (PDT)
Received: from entos-ampere02.shanghai.arm.com (unknown [10.169.212.228])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 56FC53F64C;
	Sat, 28 Oct 2023 03:21:15 -0700 (PDT)
From: Jia He <justin.he@arm.com>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	nd@arm.com,
	Jia He <justin.he@arm.com>
Subject: [PATCH v4 2/2] dma-mapping: fix dma_addressing_limited() if dma_range_map can't cover all system RAM
Date: Sat, 28 Oct 2023 10:20:59 +0000
Message-Id: <20231028102059.66891-3-justin.he@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231028102059.66891-1-justin.he@arm.com>
References: <20231028102059.66891-1-justin.he@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is an unusual case that the range map covers right up to the top
of system RAM, but leaves a hole somewhere lower down. Then it prevents
the nvme device dma mapping in the checking path of phys_to_dma() and
causes the hangs at boot.

E.g. On an Armv8 Ampere server, the dsdt ACPI table is:
 Method (_DMA, 0, Serialized)  // _DMA: Direct Memory Access
            {
                Name (RBUF, ResourceTemplate ()
                {
                    QWordMemory (ResourceConsumer, PosDecode, MinFixed,
MaxFixed, Cacheable, ReadWrite,
                        0x0000000000000000, // Granularity
                        0x0000000000000000, // Range Minimum
                        0x00000000FFFFFFFF, // Range Maximum
                        0x0000000000000000, // Translation Offset
                        0x0000000100000000, // Length
                        ,, , AddressRangeMemory, TypeStatic)
                    QWordMemory (ResourceConsumer, PosDecode, MinFixed,
MaxFixed, Cacheable, ReadWrite,
                        0x0000000000000000, // Granularity
                        0x0000006010200000, // Range Minimum
                        0x000000602FFFFFFF, // Range Maximum
                        0x0000000000000000, // Translation Offset
                        0x000000001FE00000, // Length
                        ,, , AddressRangeMemory, TypeStatic)
                    QWordMemory (ResourceConsumer, PosDecode, MinFixed,
MaxFixed, Cacheable, ReadWrite,
                        0x0000000000000000, // Granularity
                        0x00000060F0000000, // Range Minimum
                        0x00000060FFFFFFFF, // Range Maximum
                        0x0000000000000000, // Translation Offset
                        0x0000000010000000, // Length
                        ,, , AddressRangeMemory, TypeStatic)
                    QWordMemory (ResourceConsumer, PosDecode, MinFixed,
MaxFixed, Cacheable, ReadWrite,
                        0x0000000000000000, // Granularity
                        0x0000007000000000, // Range Minimum
                        0x000003FFFFFFFFFF, // Range Maximum
                        0x0000000000000000, // Translation Offset
                        0x0000039000000000, // Length
                        ,, , AddressRangeMemory, TypeStatic)
                })

But the System RAM ranges are:
cat /proc/iomem |grep -i ram
90000000-91ffffff : System RAM
92900000-fffbffff : System RAM
880000000-fffffffff : System RAM
8800000000-bff5990fff : System RAM
bff59d0000-bff5a4ffff : System RAM
bff8000000-bfffffffff : System RAM
So some RAM ranges are out of dma_range_map.

Fix it by checking whether each of the system RAM resources can be
properly encompassed within the dma_range_map.

Signed-off-by: Jia He <justin.he@arm.com>
---
 kernel/dma/direct.c  | 41 +++++++++++++++++++++++++++++++++++++++++
 kernel/dma/direct.h  |  1 +
 kernel/dma/mapping.c | 12 ++++++++++--
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 9596ae1aa0da..76cc6daa3ffd 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -598,6 +598,47 @@ int dma_direct_supported(struct device *dev, u64 mask)
 	return mask >= phys_to_dma_unencrypted(dev, min_mask);
 }
 
+/*
+ * To check whether all ram resource ranges are covered by dma range map
+ * Returns 0 when further check is needed
+ * Returns 1 if there is some RAM range can't be covered by dma_range_map
+ */
+static int check_ram_in_range_map(unsigned long start_pfn,
+				  unsigned long nr_pages, void *data)
+{
+	unsigned long end_pfn = start_pfn + nr_pages;
+	const struct bus_dma_region *bdr = NULL;
+	const struct bus_dma_region *m;
+	struct device *dev = data;
+
+	while (start_pfn < end_pfn) {
+		for (m = dev->dma_range_map; PFN_DOWN(m->size); m++) {
+			unsigned long cpu_start_pfn = PFN_DOWN(m->cpu_start);
+
+			if (start_pfn >= cpu_start_pfn &&
+			    start_pfn - cpu_start_pfn < PFN_DOWN(m->size)) {
+				bdr = m;
+				break;
+			}
+		}
+		if (!bdr)
+			return 1;
+
+		start_pfn = PFN_DOWN(bdr->cpu_start) + PFN_DOWN(bdr->size);
+	}
+
+	return 0;
+}
+
+bool dma_direct_all_ram_mapped(struct device *dev)
+{
+	if (!dev->dma_range_map)
+		return true;
+
+	return !walk_system_ram_range(0, PFN_DOWN(ULONG_MAX) + 1, dev,
+				      check_ram_in_range_map);
+}
+
 size_t dma_direct_max_mapping_size(struct device *dev)
 {
 	/* If SWIOTLB is active, use its maximum mapping size */
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index 97ec892ea0b5..18d346118fe8 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -20,6 +20,7 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 bool dma_direct_need_sync(struct device *dev, dma_addr_t dma_addr);
 int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		enum dma_data_direction dir, unsigned long attrs);
+bool dma_direct_all_ram_mapped(struct device *dev);
 size_t dma_direct_max_mapping_size(struct device *dev);
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 5bfe782f9a7f..26eaaf4ac996 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -803,8 +803,16 @@ EXPORT_SYMBOL(dma_set_coherent_mask);
  */
 bool dma_addressing_limited(struct device *dev)
 {
-	return min_not_zero(dma_get_mask(dev), dev->bus_dma_limit) <
-			    dma_get_required_mask(dev);
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (min_not_zero(dma_get_mask(dev), dev->bus_dma_limit) <
+			 dma_get_required_mask(dev))
+		return true;
+
+	if (likely(!ops))
+		return !dma_direct_all_ram_mapped(dev);
+
+	return false;
 }
 EXPORT_SYMBOL(dma_addressing_limited);
 
-- 
2.25.1

