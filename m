From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v4 0/8] Introduce automatic DMA configuration for
	IOMMU masters
Date: Wed, 19 Nov 2014 11:41:50 +0000
Message-ID: <20141119114150.GD15985@arm.com>
References: <1415991397-9618-1-git-send-email-will.deacon@arm.com>
	<546C7D36.7030400@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <546C7D36.7030400-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Marek,

On Wed, Nov 19, 2014 at 11:21:26AM +0000, Marek Szyprowski wrote:
> On 2014-11-14 19:56, Will Deacon wrote:
> > Hello everybody,
> >
> > Here is the fourth iteration of the RFC I've previously posted here:
> >
> >    RFCv1: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/283023.html
> >    RFCv2: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/283752.html
> >    RFCv3: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/287031.html
> >
> > Changes since RFCv3 include:
> >
> >    - Drastic simplification of the data structures, so that we no longer
> >      pass around lists of domains. Instead, dma-mapping is expected to
> >      allocate the domain (Joerg talked about adding a get_default_domain
> >      operation to iommu_ops).
> >
> >    - iommu_ops is used to hold the per-instance IOMMU data
> >
> >    - Configuration of DMA segments added to of_dma_configure
> >
> > All feedback welcome.
> 
> I've rebased my Exynos SYSMMU patches on top of this patchset and it 
> works fine,
> You can find them in the "[PATCH v3 00/19] Exynos SYSMMU (IOMMU) 
> integration with DT
> and DMA-mapping subsystem" thread.

I just saw that and it looks great, thanks! FWIW, I'll take the first 3
patches you have into my series in some shape or another.

> You can add to all your patches:
> Acked-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Cheers.

> I'm also interested in adding get_default_domain() callback, but I 
> assume that this
> can be done once the basic patchset get merged. Do you plan to work on 
> it, do you want
> me to implement it?

If Joerg isn't working on it already (I don't think he is), then please
do have a go if you have time. You'll probably want to avoid adding devices
with addressing restrictions (i.e. non-zero dma_pfn_offset, weird dma masks)
to the default domain, otherwise you'll run into issues initialising the
iova allocator.

I had a go at getting ARM dma-mapping to use a hypothetical
get_default_domain function, so I've included the diff I ended up with below,
in case it's at all useful.

Will

--->8

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index f3c0d953f6a2..5071553bf6b8 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -121,14 +121,9 @@ static inline unsigned long dma_max_pfn(struct device *dev)
 }
 #define dma_max_pfn(dev) dma_max_pfn(dev)
 
-static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
-				      u64 size, struct iommu_ops *iommu,
-				      bool coherent)
-{
-	if (coherent)
-		set_dma_ops(dev, &arm_coherent_dma_ops);
-}
 #define arch_setup_dma_ops arch_setup_dma_ops
+extern void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+			       struct iommu_ops *iommu, bool coherent);
 
 static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index c245d903927f..da2c2667bbb1 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1849,7 +1849,8 @@ struct dma_map_ops iommu_coherent_ops = {
  * arm_iommu_attach_device function.
  */
 struct dma_iommu_mapping *
-arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size)
+__arm_iommu_create_mapping(struct iommu_domain *domain, dma_addr_t base,
+			   size_t size)
 {
 	unsigned int bits = size >> PAGE_SHIFT;
 	unsigned int bitmap_size = BITS_TO_LONGS(bits) * sizeof(long);
@@ -1883,17 +1884,12 @@ arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size)
 	mapping->extensions = extensions;
 	mapping->base = base;
 	mapping->bits = BITS_PER_BYTE * bitmap_size;
+	mapping->domain = domain;
 
 	spin_lock_init(&mapping->lock);
 
-	mapping->domain = iommu_domain_alloc(bus);
-	if (!mapping->domain)
-		goto err4;
-
 	kref_init(&mapping->kref);
 	return mapping;
-err4:
-	kfree(mapping->bitmaps[0]);
 err3:
 	kfree(mapping->bitmaps);
 err2:
@@ -1901,6 +1897,23 @@ err2:
 err:
 	return ERR_PTR(err);
 }
+
+struct dma_iommu_mapping *
+arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size)
+{
+	struct dma_iommu_mapping *mapping;
+	struct iommu_domain *domain;
+
+	domain = iommu_domain_alloc(bus);
+	if (!domain)
+		return ERR_PTR(-ENOMEM);
+
+	mapping = __arm_iommu_create_mapping(domain, base, size);
+	if (IS_ERR(mapping))
+		iommu_domain_free(domain);
+
+	return mapping;
+}
 EXPORT_SYMBOL_GPL(arm_iommu_create_mapping);
 
 static void release_iommu_mapping(struct kref *kref)
@@ -1948,9 +1961,8 @@ EXPORT_SYMBOL_GPL(arm_iommu_release_mapping);
  *	arm_iommu_create_mapping)
  *
  * Attaches specified io address space mapping to the provided device,
- * this replaces the dma operations (dma_map_ops pointer) with the
- * IOMMU aware version. More than one client might be attached to
- * the same io address space mapping.
+ * More than one client might be attached to the same io address space
+ * mapping.
  */
 int arm_iommu_attach_device(struct device *dev,
 			    struct dma_iommu_mapping *mapping)
@@ -1963,7 +1975,6 @@ int arm_iommu_attach_device(struct device *dev,
 
 	kref_get(&mapping->kref);
 	dev->archdata.mapping = mapping;
-	set_dma_ops(dev, &iommu_ops);
 
 	pr_debug("Attached IOMMU controller to %s device.\n", dev_name(dev));
 	return 0;
@@ -1975,7 +1986,6 @@ EXPORT_SYMBOL_GPL(arm_iommu_attach_device);
  * @dev: valid struct device pointer
  *
  * Detaches the provided device from a previously attached map.
- * This voids the dma operations (dma_map_ops pointer)
  */
 void arm_iommu_detach_device(struct device *dev)
 {
@@ -1990,10 +2000,141 @@ void arm_iommu_detach_device(struct device *dev)
 	iommu_detach_device(mapping->domain, dev);
 	kref_put(&mapping->kref, release_iommu_mapping);
 	dev->archdata.mapping = NULL;
-	set_dma_ops(dev, NULL);
 
 	pr_debug("Detached IOMMU controller from %s device.\n", dev_name(dev));
 }
 EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
 
-#endif
+static struct dma_map_ops *arm_get_iommu_dma_map_ops(bool coherent)
+{
+	return coherent ? &iommu_coherent_ops : &iommu_ops;
+}
+
+struct dma_iommu_mapping_entry {
+	struct list_head		list;
+	struct dma_iommu_mapping	*mapping;
+	struct iommu_domain		*domain;
+	u64				dma_base;
+	u64				size;
+	struct kref			kref;
+};
+
+static DEFINE_SPINLOCK(dma_iommu_mapping_lock);
+static LIST_HEAD(dma_iommu_mapping_table);
+
+static void __remove_iommu_mapping_entry(struct kref *kref)
+{
+	struct dma_iommu_mapping_entry *entry;
+
+	entry = container_of(kref, struct dma_iommu_mapping_entry, kref);
+	list_del(&entry->list);
+}
+
+static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
+				    struct iommu_ops *iommu)
+{
+	struct iommu_domain *domain;
+	struct dma_iommu_mapping_entry *entry = NULL;
+
+	if (!iommu->get_default_domain)
+		return false;
+
+	domain = iommu->get_default_domain(dev);
+	if (!domain)
+		return false;
+
+	spin_lock(&dma_iommu_mapping_lock);
+
+	list_for_each_entry(entry, &dma_iommu_mapping_table, list) {
+		if (entry->domain == domain)
+			break;
+	}
+
+	/* Load entry->mapping after entry  -- not strictly necessary for ARM */
+	smp_read_barrier_depends();
+
+	if (!entry) {
+		struct dma_iommu_mapping *mapping;
+
+		entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
+		if (!entry)
+			goto err_unlock;
+
+		entry->domain	= domain;
+		entry->dma_base	= dma_base;
+		entry->size	= size;
+		kref_init(&entry->kref);
+		list_add(&entry->list, &dma_iommu_mapping_table);
+		spin_unlock(&dma_iommu_mapping_lock);
+
+		mapping = __arm_iommu_create_mapping(domain, dma_base, size);
+		if (!IS_ERR(mapping))
+			return false;
+
+		smp_wmb();
+		entry->mapping = mapping;
+	} else if (entry->mapping) {
+		if (entry->dma_base > dma_base || entry->size > size)
+			goto err_unlock;
+
+		kref_get(&entry->kref);
+		spin_unlock(&dma_iommu_mapping_lock);
+	} else {
+		/* Racing on the same IOMMU */
+		goto err_unlock;
+	}
+
+	if (arm_iommu_attach_device(dev, entry->mapping)) {
+		int entry_dead;
+
+		pr_warn("Failed to attached device %s to IOMMU mapping\n",
+				dev_name(dev));
+		spin_lock(&dma_iommu_mapping_lock);
+		entry_dead = kref_put(&entry->kref,
+				      __remove_iommu_mapping_entry);
+		spin_unlock(&dma_iommu_mapping_lock);
+
+		if (entry_dead) {
+			entry->mapping->domain = NULL;
+			arm_iommu_release_mapping(entry->mapping);
+		}
+
+		return false;
+	}
+
+	return true;
+
+err_unlock:
+	spin_unlock(&dma_iommu_mapping_lock);
+	return false;
+}
+
+#else
+
+static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
+				    struct iommu_ops *iommu)
+{
+	return false;
+}
+
+#define arm_get_iommu_dma_map_ops arm_get_dma_map_ops
+
+#endif	/* CONFIG_ARM_DMA_USE_IOMMU */
+
+static struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
+{
+	return coherent ? &arm_coherent_dma_ops : &arm_dma_ops;
+}
+
+void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+			struct iommu_ops *iommu, bool coherent)
+{
+	struct dma_map_ops *dma_ops;
+
+	if (arm_setup_iommu_dma_ops(dev, dma_base, size, iommu))
+		dma_ops = arm_get_iommu_dma_map_ops(coherent);
+	else
+		dma_ops = arm_get_dma_map_ops(coherent);
+
+	set_dma_ops(dev, dma_ops);
+}
