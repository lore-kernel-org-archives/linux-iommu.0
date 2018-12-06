From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC] avoid indirect calls for DMA direct mappings
Date: Thu, 6 Dec 2018 20:24:38 +0000
Message-ID: <e3e4c17e-ba6d-d743-04e5-7f240211b9bc@arm.com>
References: <20181206153720.10702-1-hch@lst.de>
	<CAHk-=wgz6PFCm+XMWN31dRHzA3JcNP0x0Y-z5NMMw3dHhrDXAw@mail.gmail.com>
	<20181206184330.GB30039@lst.de>
	<173bfba7-033d-93c4-6ef1-48c9e39c9efc@arm.com>
	<20181206200006.GA31548@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181206200006.GA31548-jcswGhMUV9g@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: toke-LJ9M9ZcSy1A@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Linux List Kernel Mailing <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, brouer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, tariqt-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 06/12/2018 20:00, Christoph Hellwig wrote:
> On Thu, Dec 06, 2018 at 06:54:17PM +0000, Robin Murphy wrote:
>> I'm pretty sure we used to assign dummy_dma_ops explicitly to devices at
>> the point we detected the ACPI properties are wrong - that shouldn't be too
>> much of a headache to go back to.
> 
> Ok.  I've cooked up a patch to use NULL as the go direct marker.
> This cleans up a few things nicely, but also means we now need to
> do the bypass scheme for all ops, not just the fast path.  But we
> probably should just move the slow path ops out of line anyway,
> so I'm not worried about it.  This has survived some very basic
> testing on x86, and really needs to be cleaned up and split into
> multiple patches..

I've also just finished hacking something up to keep the arm64 status 
quo - I'll need to actually test it tomorrow, but the overall diff looks 
like the below.

Robin.

----->8-----
diff --git a/arch/arm64/include/asm/dma-mapping.h 
b/arch/arm64/include/asm/dma-mapping.h
index 0626c3a93730..fe6287f68adb 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -19,15 +19,13 @@
  #include <linux/types.h>
  #include <linux/vmalloc.h>

-extern const struct dma_map_ops dummy_dma_ops;
-
  static inline const struct dma_map_ops *get_arch_dma_ops(struct 
bus_type *bus)
  {
  	/*
  	 * We expect no ISA devices, and all other DMA masters are expected to
  	 * have someone call arch_setup_dma_ops at device creation time.
  	 */
-	return &dummy_dma_ops;
+	return &dma_dummy_ops;
  }

  void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 17f8fc784de2..574aee2d04e7 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -255,98 +255,6 @@ static int __init atomic_pool_init(void)
  	return -ENOMEM;
  }

-/********************************************
- * The following APIs are for dummy DMA ops *
- ********************************************/
-
-static void *__dummy_alloc(struct device *dev, size_t size,
-			   dma_addr_t *dma_handle, gfp_t flags,
-			   unsigned long attrs)
-{
-	return NULL;
-}
-
-static void __dummy_free(struct device *dev, size_t size,
-			 void *vaddr, dma_addr_t dma_handle,
-			 unsigned long attrs)
-{
-}
-
-static int __dummy_mmap(struct device *dev,
-			struct vm_area_struct *vma,
-			void *cpu_addr, dma_addr_t dma_addr, size_t size,
-			unsigned long attrs)
-{
-	return -ENXIO;
-}
-
-static dma_addr_t __dummy_map_page(struct device *dev, struct page *page,
-				   unsigned long offset, size_t size,
-				   enum dma_data_direction dir,
-				   unsigned long attrs)
-{
-	return 0;
-}
-
-static void __dummy_unmap_page(struct device *dev, dma_addr_t dev_addr,
-			       size_t size, enum dma_data_direction dir,
-			       unsigned long attrs)
-{
-}
-
-static int __dummy_map_sg(struct device *dev, struct scatterlist *sgl,
-			  int nelems, enum dma_data_direction dir,
-			  unsigned long attrs)
-{
-	return 0;
-}
-
-static void __dummy_unmap_sg(struct device *dev,
-			     struct scatterlist *sgl, int nelems,
-			     enum dma_data_direction dir,
-			     unsigned long attrs)
-{
-}
-
-static void __dummy_sync_single(struct device *dev,
-				dma_addr_t dev_addr, size_t size,
-				enum dma_data_direction dir)
-{
-}
-
-static void __dummy_sync_sg(struct device *dev,
-			    struct scatterlist *sgl, int nelems,
-			    enum dma_data_direction dir)
-{
-}
-
-static int __dummy_mapping_error(struct device *hwdev, dma_addr_t dma_addr)
-{
-	return 1;
-}
-
-static int __dummy_dma_supported(struct device *hwdev, u64 mask)
-{
-	return 0;
-}
-
-const struct dma_map_ops dummy_dma_ops = {
-	.alloc                  = __dummy_alloc,
-	.free                   = __dummy_free,
-	.mmap                   = __dummy_mmap,
-	.map_page               = __dummy_map_page,
-	.unmap_page             = __dummy_unmap_page,
-	.map_sg                 = __dummy_map_sg,
-	.unmap_sg               = __dummy_unmap_sg,
-	.sync_single_for_cpu    = __dummy_sync_single,
-	.sync_single_for_device = __dummy_sync_single,
-	.sync_sg_for_cpu        = __dummy_sync_sg,
-	.sync_sg_for_device     = __dummy_sync_sg,
-	.mapping_error          = __dummy_mapping_error,
-	.dma_supported          = __dummy_dma_supported,
-};
-EXPORT_SYMBOL(dummy_dma_ops);
-
  static int __init arm64_dma_init(void)
  {
  	WARN_TAINT(ARCH_DMA_MINALIGN < cache_line_size(),
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index bd1c59fb0e17..b75ae34ed188 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1456,6 +1456,11 @@ int acpi_dma_configure(struct device *dev, enum 
dev_dma_attr attr)
  	const struct iommu_ops *iommu;
  	u64 dma_addr = 0, size = 0;

+	if (attr == DEV_DMA_NOT_SUPPORTED) {
+		set_dma_ops(dev, &dma_dummy_ops);
+		return 0;
+	}
+
  	iort_dma_setup(dev, &dma_addr, &size);

  	iommu = iort_iommu_configure(dev);
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 41b91af95afb..c6daca875c17 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1138,8 +1138,7 @@ int platform_dma_configure(struct device *dev)
  		ret = of_dma_configure(dev, dev->of_node, true);
  	} else if (has_acpi_companion(dev)) {
  		attr = acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
-		if (attr != DEV_DMA_NOT_SUPPORTED)
-			ret = acpi_dma_configure(dev, attr);
+		ret = acpi_dma_configure(dev, attr);
  	}

  	return ret;
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index bef17c3fca67..f899a28b90f8 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1602,8 +1602,7 @@ static int pci_dma_configure(struct device *dev)
  		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
  		enum dev_dma_attr attr = acpi_get_dma_attr(adev);

-		if (attr != DEV_DMA_NOT_SUPPORTED)
-			ret = acpi_dma_configure(dev, attr);
+		ret = acpi_dma_configure(dev, attr);
  	}

  	pci_put_host_bridge_device(bridge);
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 15bd41447025..3a1928ea23c9 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -134,6 +134,7 @@ struct dma_map_ops {
  };

  extern const struct dma_map_ops dma_direct_ops;
+extern const struct dma_map_ops dma_dummy_ops;
  extern const struct dma_map_ops dma_virt_ops;

  #define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 58dec7a92b7b..957a42ebabcf 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -346,3 +346,57 @@ void dma_common_free_remap(void *cpu_addr, size_t 
size, unsigned long vm_flags)
  	vunmap(cpu_addr);
  }
  #endif
+
+/*
+ * Dummy DMA ops always fail
+ */
+
+static int dma_dummy_mmap(struct device *dev, struct vm_area_struct *vma,
+			  void *cpu_addr, dma_addr_t dma_addr, size_t size,
+			  unsigned long attrs)
+{
+	return -ENXIO;
+}
+
+static dma_addr_t dma_dummy_map_page(struct device *dev, struct page *page,
+				     unsigned long offset, size_t size,
+				     enum dma_data_direction dir,
+				     unsigned long attrs)
+{
+	return 0;
+}
+
+static int dma_dummy_map_sg(struct device *dev, struct scatterlist *sgl,
+			    int nelems, enum dma_data_direction dir,
+			    unsigned long attrs)
+{
+	return 0;
+}
+
+static dma_addr_t dma_dummy_map_resource(struct device *dev,
+					 phys_addr_t phys_addr, size_t size,
+					 enum dma_data_direction dir,
+					 unsigned long attrs)
+{
+	return 0;
+}
+
+static int dma_dummy_mapping_error(struct device *hwdev, dma_addr_t 
dma_addr)
+{
+	return 1;
+}
+
+static int dma_dummy_supported(struct device *hwdev, u64 mask)
+{
+	return 0;
+}
+
+const struct dma_map_ops dma_dummy_ops = {
+	.mmap		= dma_dummy_mmap,
+	.map_page	= dma_dummy_map_page,
+	.map_sg		= dma_dummy_map_sg,
+	.map_resource	= dma_dummy_map_resource,
+	.mapping_error	= dma_dummy_mapping_error,
+	.dma_supported	= dma_dummy_supported,
+};
+EXPORT_SYMBOL(dma_dummy_ops);
