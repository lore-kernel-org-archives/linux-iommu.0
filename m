Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750DC26E10
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 476632F4;
	Mon, 16 Oct 2023 05:53:52 -0700 (PDT)
Received: from entos-ampere02.shanghai.arm.com (unknown [10.169.212.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5040C3F5A1;
	Mon, 16 Oct 2023 05:53:09 -0700 (PDT)
From: Jia He <justin.he@arm.com>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	nd@arm.com,
	Jia He <justin.he@arm.com>
Subject: [PATCH v3 2/2] dma-mapping: fix dma_addressing_limited() if dma_range_map can't cover all system RAM
Date: Mon, 16 Oct 2023 12:52:54 +0000
Message-Id: <20231016125254.1875-3-justin.he@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231016125254.1875-1-justin.he@arm.com>
References: <20231016125254.1875-1-justin.he@arm.com>
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
 kernel/dma/mapping.c | 49 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 5bfe782f9a7f..9889d1d25a7f 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -7,6 +7,7 @@
  */
 #include <linux/memblock.h> /* for max_pfn */
 #include <linux/acpi.h>
+#include <linux/dma-direct.h> /* for bus_dma_region */
 #include <linux/dma-map-ops.h>
 #include <linux/export.h>
 #include <linux/gfp.h>
@@ -793,6 +794,47 @@ int dma_set_coherent_mask(struct device *dev, u64 mask)
 }
 EXPORT_SYMBOL(dma_set_coherent_mask);
 
+/*
+ * To check whether all ram resource ranges are covered by dma range map
+ * Returns 0 when continuous check is needed
+ * Returns 1 if there is some RAM range can't be covered by dma_range_map
+ */
+static int check_ram_in_range_map(unsigned long start_pfn,
+				  unsigned long nr_pages, void *data)
+{
+	unsigned long end_pfn = start_pfn + nr_pages;
+	struct device *dev = (struct device *)data;
+	struct bus_dma_region *bdr = NULL;
+	const struct bus_dma_region *m;
+
+	while (start_pfn < end_pfn) {
+		for (m = dev->dma_range_map; PFN_DOWN(m->size); m++) {
+			unsigned long cpu_start_pfn = PFN_DOWN(m->cpu_start);
+
+			if (start_pfn >= cpu_start_pfn
+			    && start_pfn - cpu_start_pfn < PFN_DOWN(m->size)) {
+				bdr = (struct bus_dma_region *)m;
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
+static bool all_ram_in_dma_range_map(struct device *dev)
+{
+	if (!dev->dma_range_map)
+		return 1;
+
+	return !walk_system_ram_range(0, PFN_DOWN(ULONG_MAX) + 1, dev,
+				      check_ram_in_range_map);
+}
+
 /**
  * dma_addressing_limited - return if the device is addressing limited
  * @dev:	device to check
@@ -803,8 +845,11 @@ EXPORT_SYMBOL(dma_set_coherent_mask);
  */
 bool dma_addressing_limited(struct device *dev)
 {
-	return min_not_zero(dma_get_mask(dev), dev->bus_dma_limit) <
-			    dma_get_required_mask(dev);
+	if (min_not_zero(dma_get_mask(dev), dev->bus_dma_limit) <
+			 dma_get_required_mask(dev))
+		return true;
+
+	return !all_ram_in_dma_range_map(dev);
 }
 EXPORT_SYMBOL(dma_addressing_limited);
 
-- 
2.25.1

