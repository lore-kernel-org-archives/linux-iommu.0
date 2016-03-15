From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC 3/3] iommu: dma-iommu: use common implementation also on ARM
	architecture
Date: Tue, 15 Mar 2016 11:45:24 +0000
Message-ID: <56E7F5D4.1020201@arm.com>
References: <1455870164-25337-1-git-send-email-m.szyprowski@samsung.com>
	<1455870164-25337-4-git-send-email-m.szyprowski@samsung.com>
	<CANqRtoRiZOPhCBo38zVLL6tQB2aBLy3uWWbqJJypxEFDXJwF1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CANqRtoRiZOPhCBo38zVLL6tQB2aBLy3uWWbqJJypxEFDXJwF1Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Mark Yao <mark.yao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

On 15/03/16 11:18, Magnus Damm wrote:
> Hi Marek,
>
> On Fri, Feb 19, 2016 at 5:22 PM, Marek Szyprowski
> <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>> This patch replaces ARM-specific IOMMU-based DMA-mapping implementation
>> with generic IOMMU DMA-mapping code shared with ARM64 architecture. The
>> side-effect of this change is a switch from bitmap-based IO address space
>> management to tree-based code. There should be no functional changes
>> for drivers, which rely on initialization from generic arch_setup_dna_ops()
>> interface. Code, which used old arm_iommu_* functions must be updated to
>> new interface.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> ---
>
> Thanks for your efforts and my apologies for late comments. Just FYI
> I'll try your patch (and this series) with the ipmmu-vmsa.c driver on
> 32-bit ARM and see how it goes. Nice not to have to support multiple
> interfaces depending on architecture!
>
> One question that comes to mind is how to handle features.
>
> For instance, the 32-bit ARM code supports DMA_ATTR_FORCE_CONTIGUOUS
> while the shared code in drivers/iommu/dma-iommu.c does not. I assume
> existing users may rely on such features so from my point of view it
> probably makes sense to carry over features from the 32-bit ARM code
> into the shared code before pulling the plug.

Indeed - the patch I posted the other day doing proper scatterlist 
merging in the common code is largely to that end.

> I also wonder if it is possible to do a step-by-step migration and
> support both old and new interfaces in the same binary? That may make
> things easier for multiplatform enablement. So far I've managed to
> make one IOMMU driver support both 32-bit ARM and 64-bit ARM with some
> ugly magic, so adjusting 32-bit ARM dma-mapping code to coexist with
> the shared code in drivers/iommu/dma-iommu.c may also be possible. And
> probably involving even more ugly magic. =)

That was also my thought when I tried to look at this a while ago - I 
started on some patches moving the bitmap from dma_iommu_mapping into 
the iommu_domain->iova_cookie so that the existing code and users could 
then be converted to just passing iommu_domains around, after which it 
should be fairly painless to swap out the back-end implementation 
transparently. That particular effort ground to a halt upon realising 
the number of the IOMMU and DRM drivers I'd have no way of testing - if 
you're interested I've dug out the diff below from an old 
work-in-progress branch (which probably doesn't even compile).

Robin.

>
> Cheers,
>
> / magnus

--->8---
diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
index 4111592..6ea939c 100644
--- a/arch/arm/include/asm/device.h
+++ b/arch/arm/include/asm/device.h
@@ -14,9 +14,6 @@ struct dev_archdata {
  #ifdef CONFIG_IOMMU_API
  	void *iommu; /* private IOMMU data */
  #endif
-#ifdef CONFIG_ARM_DMA_USE_IOMMU
-	struct dma_iommu_mapping	*mapping;
-#endif
  	bool dma_coherent;
  };

@@ -28,10 +25,4 @@ struct pdev_archdata {
  #endif
  };

-#ifdef CONFIG_ARM_DMA_USE_IOMMU
-#define to_dma_iommu_mapping(dev) ((dev)->archdata.mapping)
-#else
-#define to_dma_iommu_mapping(dev) NULL
-#endif
-
  #endif
diff --git a/arch/arm/include/asm/dma-iommu.h 
b/arch/arm/include/asm/dma-iommu.h
index 2ef282f..e15197d 100644
--- a/arch/arm/include/asm/dma-iommu.h
+++ b/arch/arm/include/asm/dma-iommu.h
@@ -24,13 +24,12 @@ struct dma_iommu_mapping {
  	struct kref		kref;
  };

-struct dma_iommu_mapping *
+struct iommu_domain *
  arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, u64 size);

-void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping);
+void arm_iommu_release_mapping(struct iommu_domain *mapping);

-int arm_iommu_attach_device(struct device *dev,
-					struct dma_iommu_mapping *mapping);
+int arm_iommu_attach_device(struct device *dev, struct iommu_domain 
*mapping);
  void arm_iommu_detach_device(struct device *dev);

  #endif /* __KERNEL__ */
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index e62400e..dfb5001 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1246,7 +1246,8 @@ __iommu_alloc_remap(struct page **pages, size_t 
size, gfp_t gfp, pgprot_t prot,
  static dma_addr_t
  __iommu_create_mapping(struct device *dev, struct page **pages, size_t 
size)
  {
-	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+	struct iommu_domain *dom = iommu_get_domain_for_dev(dev);
+	struct dma_iommu_mapping *mapping = dom->iova_cookie;
  	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
  	dma_addr_t dma_addr, iova;
  	int i;
@@ -1268,8 +1269,7 @@ __iommu_create_mapping(struct device *dev, struct 
page **pages, size_t size)
  				break;

  		len = (j - i) << PAGE_SHIFT;
-		ret = iommu_map(mapping->domain, iova, phys, len,
-				IOMMU_READ|IOMMU_WRITE);
+		ret = iommu_map(dom, iova, phys, len, IOMMU_READ|IOMMU_WRITE);
  		if (ret < 0)
  			goto fail;
  		iova += len;
@@ -1277,14 +1277,14 @@ __iommu_create_mapping(struct device *dev, 
struct page **pages, size_t size)
  	}
  	return dma_addr;
  fail:
-	iommu_unmap(mapping->domain, dma_addr, iova-dma_addr);
+	iommu_unmap(dom, dma_addr, iova-dma_addr);
  	__free_iova(mapping, dma_addr, size);
  	return DMA_ERROR_CODE;
  }

  static int __iommu_remove_mapping(struct device *dev, dma_addr_t iova, 
size_t size)
  {
-	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+	struct iommu_domain *dom = iommu_get_domain_for_dev(dev);

  	/*
  	 * add optional in-page offset from iova to size and align
@@ -1293,8 +1293,8 @@ static int __iommu_remove_mapping(struct device 
*dev, dma_addr_t iova, size_t si
  	size = PAGE_ALIGN((iova & ~PAGE_MASK) + size);
  	iova &= PAGE_MASK;

-	iommu_unmap(mapping->domain, iova, size);
-	__free_iova(mapping, iova, size);
+	iommu_unmap(dom, iova, size);
+	__free_iova(dom->iova_cookie, iova, size);
  	return 0;
  }

@@ -1506,7 +1506,8 @@ static int __map_sg_chunk(struct device *dev, 
struct scatterlist *sg,
  			  enum dma_data_direction dir, struct dma_attrs *attrs,
  			  bool is_coherent)
  {
-	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+	struct iommu_domain *dom = iommu_get_domain_for_dev(dev);
+	struct dma_iommu_mapping *mapping = dom->iova_cookie;
  	dma_addr_t iova, iova_base;
  	int ret = 0;
  	unsigned int count;
@@ -1530,7 +1531,7 @@ static int __map_sg_chunk(struct device *dev, 
struct scatterlist *sg,

  		prot = __dma_direction_to_prot(dir);

-		ret = iommu_map(mapping->domain, iova, phys, len, prot);
+		ret = iommu_map(dom, iova, phys, len, prot);
  		if (ret < 0)
  			goto fail;
  		count += len >> PAGE_SHIFT;
@@ -1540,7 +1541,7 @@ static int __map_sg_chunk(struct device *dev, 
struct scatterlist *sg,

  	return 0;
  fail:
-	iommu_unmap(mapping->domain, iova_base, count * PAGE_SIZE);
+	iommu_unmap(dom, iova_base, count * PAGE_SIZE);
  	__free_iova(mapping, iova_base, size);
  	return ret;
  }
@@ -1727,7 +1728,8 @@ static dma_addr_t 
arm_coherent_iommu_map_page(struct device *dev, struct page *p
  	     unsigned long offset, size_t size, enum dma_data_direction dir,
  	     struct dma_attrs *attrs)
  {
-	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+	struct iommu_domain *dom = iommu_get_domain_for_dev(dev);
+	struct dma_iommu_mapping *mapping = dom->iova_cookie;
  	dma_addr_t dma_addr;
  	int ret, prot, len = PAGE_ALIGN(size + offset);

@@ -1737,7 +1739,7 @@ static dma_addr_t 
arm_coherent_iommu_map_page(struct device *dev, struct page *p

  	prot = __dma_direction_to_prot(dir);

-	ret = iommu_map(mapping->domain, dma_addr, page_to_phys(page), len, prot);
+	ret = iommu_map(dom, dma_addr, page_to_phys(page), len, prot);
  	if (ret < 0)
  		goto fail;

@@ -1780,7 +1782,7 @@ static void arm_coherent_iommu_unmap_page(struct 
device *dev, dma_addr_t handle,
  		size_t size, enum dma_data_direction dir,
  		struct dma_attrs *attrs)
  {
-	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+	struct iommu_domain *dom = iommu_get_domain_for_dev(dev);
  	dma_addr_t iova = handle & PAGE_MASK;
  	int offset = handle & ~PAGE_MASK;
  	int len = PAGE_ALIGN(size + offset);
@@ -1788,8 +1790,8 @@ static void arm_coherent_iommu_unmap_page(struct 
device *dev, dma_addr_t handle,
  	if (!iova)
  		return;

-	iommu_unmap(mapping->domain, iova, len);
-	__free_iova(mapping, iova, len);
+	iommu_unmap(dom, iova, len);
+	__free_iova(dom->iova_cookie, iova, len);
  }

  /**
@@ -1805,9 +1807,9 @@ static void arm_iommu_unmap_page(struct device 
*dev, dma_addr_t handle,
  		size_t size, enum dma_data_direction dir,
  		struct dma_attrs *attrs)
  {
-	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+	struct iommu_domain *dom = iommu_get_domain_for_dev(dev);
  	dma_addr_t iova = handle & PAGE_MASK;
-	struct page *page = phys_to_page(iommu_iova_to_phys(mapping->domain, 
iova));
+	struct page *page = phys_to_page(iommu_iova_to_phys(dom, iova));
  	int offset = handle & ~PAGE_MASK;
  	int len = PAGE_ALIGN(size + offset);

@@ -1817,16 +1819,16 @@ static void arm_iommu_unmap_page(struct device 
*dev, dma_addr_t handle,
  	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
  		__dma_page_dev_to_cpu(page, offset, size, dir);

-	iommu_unmap(mapping->domain, iova, len);
-	__free_iova(mapping, iova, len);
+	iommu_unmap(dom, iova, len);
+	__free_iova(dom->iova_cookie, iova, len);
  }

  static void arm_iommu_sync_single_for_cpu(struct device *dev,
  		dma_addr_t handle, size_t size, enum dma_data_direction dir)
  {
-	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+	struct iommu_domain *dom = iommu_get_domain_for_dev(dev);
  	dma_addr_t iova = handle & PAGE_MASK;
-	struct page *page = phys_to_page(iommu_iova_to_phys(mapping->domain, 
iova));
+	struct page *page = phys_to_page(iommu_iova_to_phys(dom, iova));
  	unsigned int offset = handle & ~PAGE_MASK;

  	if (!iova)
@@ -1838,9 +1840,9 @@ static void arm_iommu_sync_single_for_cpu(struct 
device *dev,
  static void arm_iommu_sync_single_for_device(struct device *dev,
  		dma_addr_t handle, size_t size, enum dma_data_direction dir)
  {
-	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+	struct iommu_domain *dom = iommu_get_domain_for_dev(dev);
  	dma_addr_t iova = handle & PAGE_MASK;
-	struct page *page = phys_to_page(iommu_iova_to_phys(mapping->domain, 
iova));
+	struct page *page = phys_to_page(iommu_iova_to_phys(dom, iova));
  	unsigned int offset = handle & ~PAGE_MASK;

  	if (!iova)
@@ -1896,12 +1898,13 @@ struct dma_map_ops iommu_coherent_ops = {
   * The client device need to be attached to the mapping with
   * arm_iommu_attach_device function.
   */
-struct dma_iommu_mapping *
+struct iommu_domain *
  arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, u64 size)
  {
  	unsigned int bits = size >> PAGE_SHIFT;
  	unsigned int bitmap_size = BITS_TO_LONGS(bits) * sizeof(long);
  	struct dma_iommu_mapping *mapping;
+	struct iommu_domain *dom;
  	int extensions = 1;
  	int err = -ENOMEM;

@@ -1938,12 +1941,14 @@ arm_iommu_create_mapping(struct bus_type *bus, 
dma_addr_t base, u64 size)

  	spin_lock_init(&mapping->lock);

-	mapping->domain = iommu_domain_alloc(bus);
-	if (!mapping->domain)
+	dom = iommu_domain_alloc(bus);
+	if (!dom)
  		goto err4;

+	mapping->domain = dom;
+	dom->iova_cookie = mapping;
  	kref_init(&mapping->kref);
-	return mapping;
+	return dom;
  err4:
  	kfree(mapping->bitmaps[0]);
  err3:
@@ -1986,24 +1991,27 @@ static int extend_iommu_mapping(struct 
dma_iommu_mapping *mapping)
  	return 0;
  }

-void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping)
+void arm_iommu_release_mapping(struct iommu_domain *domain)
  {
-	if (mapping)
+	if (domain) {
+		struct dma_iommu_mapping *mapping = domain->iova_cookie;
+
  		kref_put(&mapping->kref, release_iommu_mapping);
+	}
  }
  EXPORT_SYMBOL_GPL(arm_iommu_release_mapping);

  static int __arm_iommu_attach_device(struct device *dev,
-				     struct dma_iommu_mapping *mapping)
+				     struct iommu_domain *domain)
  {
  	int err;
+	struct dma_iommu_mapping *mapping = domain->iova_cookie;

-	err = iommu_attach_device(mapping->domain, dev);
+	err = iommu_attach_device(domain, dev);
  	if (err)
  		return err;

  	kref_get(&mapping->kref);
-	to_dma_iommu_mapping(dev) = mapping;

  	pr_debug("Attached IOMMU controller to %s device.\n", dev_name(dev));
  	return 0;
@@ -2023,7 +2031,7 @@ static int __arm_iommu_attach_device(struct device 
*dev,
   * mapping.
   */
  int arm_iommu_attach_device(struct device *dev,
-			    struct dma_iommu_mapping *mapping)
+			    struct iommu_domain *mapping)
  {
  	int err;

@@ -2039,16 +2047,17 @@ EXPORT_SYMBOL_GPL(arm_iommu_attach_device);
  static void __arm_iommu_detach_device(struct device *dev)
  {
  	struct dma_iommu_mapping *mapping;
+	struct iommu_domain *dom;

-	mapping = to_dma_iommu_mapping(dev);
-	if (!mapping) {
+	dom = iommu_get_domain_for_dev(dev);
+	if (!dom) {
  		dev_warn(dev, "Not attached\n");
  		return;
  	}

-	iommu_detach_device(mapping->domain, dev);
+	mapping = dom->iova_cookie;
+	iommu_detach_device(dom, dev);
  	kref_put(&mapping->kref, release_iommu_mapping);
-	to_dma_iommu_mapping(dev) = NULL;

  	pr_debug("Detached IOMMU controller from %s device.\n", dev_name(dev));
  }
@@ -2075,7 +2084,7 @@ static struct dma_map_ops 
*arm_get_iommu_dma_map_ops(bool coherent)
  static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, 
u64 size,
  				    struct iommu_ops *iommu)
  {
-	struct dma_iommu_mapping *mapping;
+	struct iommu_domain *mapping;

  	if (!iommu)
  		return false;
@@ -2099,13 +2108,13 @@ static bool arm_setup_iommu_dma_ops(struct 
device *dev, u64 dma_base, u64 size,

  static void arm_teardown_iommu_dma_ops(struct device *dev)
  {
-	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+	struct iommu_domain *mapping = iommu_get_domain_for_dev(dev);

  	if (!mapping)
  		return;

  	__arm_iommu_detach_device(dev);
-	arm_iommu_release_mapping(mapping);
+	arm_iommu_release_mapping(mapping->iova_cookie);
  }

  #else
