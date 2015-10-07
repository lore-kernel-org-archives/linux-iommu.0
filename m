From: Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH v6 2/3] arm64: Add IOMMU dma_ops
Date: Wed, 7 Oct 2015 14:33:04 +0530
Message-ID: <CAAhSdy2tpAfH+i=1axDkmRqZixsbVhd-_9VGvpyQ=5e06v=Kpg@mail.gmail.com>
References: <cover.1443718557.git.robin.murphy@arm.com>
 <80cb035144a2648a5d94eb1fec3336f17ad249f1.1443718557.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <80cb035144a2648a5d94eb1fec3336f17ad249f1.1443718557.git.robin.murphy@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: laurent.pinchart+renesas@ideasonboard.com, Anup Patel <anup.patel@broadcom.com>, Catalin Marinas <catalin.marinas@arm.com>, joro@8bytes.org, Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org, djkurtz@google.com, yong.wu@mediatek.com, thunder.leizhen@huawei.com, yingjoe.chen@mediatek.com, treding@nvidia.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Fri, Oct 2, 2015 at 12:43 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> Taking some inspiration from the arch/arm code, implement the
> arch-specific side of the DMA mapping ops using the new IOMMU-DMA layer.
>
> Since there is still work to do elsewhere to make DMA configuration happen
> in a more appropriate order and properly support platform devices in the
> IOMMU core, the device setup code unfortunately starts out carrying some
> workarounds to ensure it works correctly in the current state of things.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  arch/arm64/mm/dma-mapping.c | 435 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 435 insertions(+)
>
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 0bcc4bc..dd2d6e6 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -533,3 +533,438 @@ static int __init dma_debug_do_init(void)
>         return 0;
>  }
>  fs_initcall(dma_debug_do_init);
> +
> +
> +#ifdef CONFIG_IOMMU_DMA
> +#include <linux/dma-iommu.h>
> +#include <linux/platform_device.h>
> +#include <linux/amba/bus.h>
> +
> +/* Thankfully, all cache ops are by VA so we can ignore phys here */
> +static void flush_page(struct device *dev, const void *virt, phys_addr_t phys)
> +{
> +       __dma_flush_range(virt, virt + PAGE_SIZE);
> +}
> +
> +static void *__iommu_alloc_attrs(struct device *dev, size_t size,
> +                                dma_addr_t *handle, gfp_t gfp,
> +                                struct dma_attrs *attrs)
> +{
> +       bool coherent = is_device_dma_coherent(dev);
> +       int ioprot = dma_direction_to_prot(DMA_BIDIRECTIONAL, coherent);
> +       void *addr;
> +
> +       if (WARN(!dev, "cannot create IOMMU mapping for unknown device\n"))
> +               return NULL;
> +       /*
> +        * Some drivers rely on this, and we probably don't want the
> +        * possibility of stale kernel data being read by devices anyway.
> +        */
> +       gfp |= __GFP_ZERO;
> +
> +       if (gfp & __GFP_WAIT) {
> +               struct page **pages;
> +               pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, coherent);
> +
> +               pages = iommu_dma_alloc(dev, size, gfp, ioprot, handle,
> +                                       flush_page);
> +               if (!pages)
> +                       return NULL;
> +
> +               addr = dma_common_pages_remap(pages, size, VM_USERMAP, prot,
> +                                             __builtin_return_address(0));
> +               if (!addr)
> +                       iommu_dma_free(dev, pages, size, handle);
> +       } else {
> +               struct page *page;
> +               /*
> +                * In atomic context we can't remap anything, so we'll only
> +                * get the virtually contiguous buffer we need by way of a
> +                * physically contiguous allocation.
> +                */
> +               if (coherent) {
> +                       page = alloc_pages(gfp, get_order(size));
> +                       addr = page ? page_address(page) : NULL;
> +               } else {
> +                       addr = __alloc_from_pool(size, &page, gfp);
> +               }
> +               if (!addr)
> +                       return NULL;
> +
> +               *handle = iommu_dma_map_page(dev, page, 0, size, ioprot);
> +               if (iommu_dma_mapping_error(dev, *handle)) {
> +                       if (coherent)
> +                               __free_pages(page, get_order(size));
> +                       else
> +                               __free_from_pool(addr, size);
> +                       addr = NULL;
> +               }
> +       }
> +       return addr;
> +}
> +
> +static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
> +                              dma_addr_t handle, struct dma_attrs *attrs)
> +{
> +       /*
> +        * @cpu_addr will be one of 3 things depending on how it was allocated:
> +        * - A remapped array of pages from iommu_dma_alloc(), for all
> +        *   non-atomic allocations.
> +        * - A non-cacheable alias from the atomic pool, for atomic
> +        *   allocations by non-coherent devices.
> +        * - A normal lowmem address, for atomic allocations by
> +        *   coherent devices.
> +        * Hence how dodgy the below logic looks...
> +        */
> +       if (__in_atomic_pool(cpu_addr, size)) {
> +               iommu_dma_unmap_page(dev, handle, size, 0, NULL);
> +               __free_from_pool(cpu_addr, size);
> +       } else if (is_vmalloc_addr(cpu_addr)){
> +               struct vm_struct *area = find_vm_area(cpu_addr);
> +
> +               if (WARN_ON(!area || !area->pages))
> +                       return;
> +               iommu_dma_free(dev, area->pages, size, &handle);
> +               dma_common_free_remap(cpu_addr, size, VM_USERMAP);
> +       } else {
> +               iommu_dma_unmap_page(dev, handle, size, 0, NULL);
> +               __free_pages(virt_to_page(cpu_addr), get_order(size));
> +       }
> +}
> +
> +static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
> +                             void *cpu_addr, dma_addr_t dma_addr, size_t size,
> +                             struct dma_attrs *attrs)
> +{
> +       struct vm_struct *area;
> +       int ret;
> +
> +       vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot,
> +                                            is_device_dma_coherent(dev));
> +
> +       if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
> +               return ret;
> +
> +       area = find_vm_area(cpu_addr);
> +       if (WARN_ON(!area || !area->pages))
> +               return -ENXIO;
> +
> +       return iommu_dma_mmap(area->pages, size, vma);
> +}
> +
> +static int __iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
> +                              void *cpu_addr, dma_addr_t dma_addr,
> +                              size_t size, struct dma_attrs *attrs)
> +{
> +       unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> +       struct vm_struct *area = find_vm_area(cpu_addr);
> +
> +       if (WARN_ON(!area || !area->pages))
> +               return -ENXIO;
> +
> +       return sg_alloc_table_from_pages(sgt, area->pages, count, 0, size,
> +                                        GFP_KERNEL);
> +}
> +
> +static void __iommu_sync_single_for_cpu(struct device *dev,
> +                                       dma_addr_t dev_addr, size_t size,
> +                                       enum dma_data_direction dir)
> +{
> +       phys_addr_t phys;
> +
> +       if (is_device_dma_coherent(dev))
> +               return;
> +
> +       phys = iommu_iova_to_phys(iommu_get_domain_for_dev(dev), dev_addr);
> +       __dma_unmap_area(phys_to_virt(phys), size, dir);
> +}
> +
> +static void __iommu_sync_single_for_device(struct device *dev,
> +                                          dma_addr_t dev_addr, size_t size,
> +                                          enum dma_data_direction dir)
> +{
> +       phys_addr_t phys;
> +
> +       if (is_device_dma_coherent(dev))
> +               return;
> +
> +       phys = iommu_iova_to_phys(iommu_get_domain_for_dev(dev), dev_addr);
> +       __dma_map_area(phys_to_virt(phys), size, dir);
> +}
> +
> +static dma_addr_t __iommu_map_page(struct device *dev, struct page *page,
> +                                  unsigned long offset, size_t size,
> +                                  enum dma_data_direction dir,
> +                                  struct dma_attrs *attrs)
> +{
> +       bool coherent = is_device_dma_coherent(dev);
> +       int prot = dma_direction_to_prot(dir, coherent);
> +       dma_addr_t dev_addr = iommu_dma_map_page(dev, page, offset, size, prot);
> +
> +       if (!iommu_dma_mapping_error(dev, dev_addr) &&
> +           !dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
> +               __iommu_sync_single_for_device(dev, dev_addr, size, dir);
> +
> +       return dev_addr;
> +}
> +
> +static void __iommu_unmap_page(struct device *dev, dma_addr_t dev_addr,
> +                              size_t size, enum dma_data_direction dir,
> +                              struct dma_attrs *attrs)
> +{
> +       if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
> +               __iommu_sync_single_for_cpu(dev, dev_addr, size, dir);
> +
> +       iommu_dma_unmap_page(dev, dev_addr, size, dir, attrs);
> +}
> +
> +static void __iommu_sync_sg_for_cpu(struct device *dev,
> +                                   struct scatterlist *sgl, int nelems,
> +                                   enum dma_data_direction dir)
> +{
> +       struct scatterlist *sg;
> +       int i;
> +
> +       if (is_device_dma_coherent(dev))
> +               return;
> +
> +       for_each_sg(sgl, sg, nelems, i)
> +               __dma_unmap_area(sg_virt(sg), sg->length, dir);
> +}
> +
> +static void __iommu_sync_sg_for_device(struct device *dev,
> +                                      struct scatterlist *sgl, int nelems,
> +                                      enum dma_data_direction dir)
> +{
> +       struct scatterlist *sg;
> +       int i;
> +
> +       if (is_device_dma_coherent(dev))
> +               return;
> +
> +       for_each_sg(sgl, sg, nelems, i)
> +               __dma_map_area(sg_virt(sg), sg->length, dir);
> +}
> +
> +static int __iommu_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
> +                               int nelems, enum dma_data_direction dir,
> +                               struct dma_attrs *attrs)
> +{
> +       bool coherent = is_device_dma_coherent(dev);
> +
> +       if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
> +               __iommu_sync_sg_for_device(dev, sgl, nelems, dir);
> +
> +       return iommu_dma_map_sg(dev, sgl, nelems,
> +                       dma_direction_to_prot(dir, coherent));
> +}
> +
> +static void __iommu_unmap_sg_attrs(struct device *dev,
> +                                  struct scatterlist *sgl, int nelems,
> +                                  enum dma_data_direction dir,
> +                                  struct dma_attrs *attrs)
> +{
> +       if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
> +               __iommu_sync_sg_for_cpu(dev, sgl, nelems, dir);
> +
> +       iommu_dma_unmap_sg(dev, sgl, nelems, dir, attrs);
> +}
> +
> +static struct dma_map_ops iommu_dma_ops = {
> +       .alloc = __iommu_alloc_attrs,
> +       .free = __iommu_free_attrs,
> +       .mmap = __iommu_mmap_attrs,
> +       .get_sgtable = __iommu_get_sgtable,
> +       .map_page = __iommu_map_page,
> +       .unmap_page = __iommu_unmap_page,
> +       .map_sg = __iommu_map_sg_attrs,
> +       .unmap_sg = __iommu_unmap_sg_attrs,
> +       .sync_single_for_cpu = __iommu_sync_single_for_cpu,
> +       .sync_single_for_device = __iommu_sync_single_for_device,
> +       .sync_sg_for_cpu = __iommu_sync_sg_for_cpu,
> +       .sync_sg_for_device = __iommu_sync_sg_for_device,
> +       .dma_supported = iommu_dma_supported,
> +       .mapping_error = iommu_dma_mapping_error,
> +};
> +
> +/*
> + * TODO: Right now __iommu_setup_dma_ops() gets called too early to do
> + * everything it needs to - the device is only partially created and the
> + * IOMMU driver hasn't seen it yet, so it can't have a group. Thus we
> + * need this delayed attachment dance. Once IOMMU probe ordering is sorted
> + * to move the arch_setup_dma_ops() call later, all the notifier bits below
> + * become unnecessary, and will go away.
> + */
> +struct iommu_dma_notifier_data {
> +       struct list_head list;
> +       struct device *dev;
> +       const struct iommu_ops *ops;
> +       u64 dma_base;
> +       u64 size;
> +};
> +static LIST_HEAD(iommu_dma_masters);
> +static DEFINE_MUTEX(iommu_dma_notifier_lock);
> +
> +/*
> + * Temporarily "borrow" a domain feature flag to to tell if we had to resort
> + * to creating our own domain here, in case we need to clean it up again.
> + */
> +#define __IOMMU_DOMAIN_FAKE_DEFAULT            (1U << 31)
> +
> +static bool do_iommu_attach(struct device *dev, const struct iommu_ops *ops,
> +                          u64 dma_base, u64 size)
> +{
> +       struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +
> +       /*
> +        * Best case: The device is either part of a group which was
> +        * already attached to a domain in a previous call, or it's
> +        * been put in a default DMA domain by the IOMMU core.
> +        */
> +       if (!domain) {
> +               /*
> +                * Urgh. The IOMMU core isn't going to do default domains
> +                * for non-PCI devices anyway, until it has some means of
> +                * abstracting the entirely implementation-specific
> +                * sideband data/SoC topology/unicorn dust that may or
> +                * may not differentiate upstream masters.
> +                * So until then, HORRIBLE HACKS!
> +                */
> +               domain = ops->domain_alloc(IOMMU_DOMAIN_DMA);
> +               if (!domain)
> +                       goto out_no_domain;
> +
> +               domain->ops = ops;
> +               domain->type = IOMMU_DOMAIN_DMA | __IOMMU_DOMAIN_FAKE_DEFAULT;

We require iommu_get_dma_cookie(domain) here. If we dont
allocate iommu cookie then iommu_dma_init_domain() will fail.

> +
> +               if (iommu_attach_device(domain, dev))
> +                       goto out_put_domain;
> +       }
> +
> +       if (iommu_dma_init_domain(domain, dma_base, size))
> +               goto out_detach;
> +
> +       dev->archdata.dma_ops = &iommu_dma_ops;
> +       return true;
> +
> +out_detach:
> +       iommu_detach_device(domain, dev);
> +out_put_domain:
> +       if (domain->type & __IOMMU_DOMAIN_FAKE_DEFAULT)
> +               iommu_domain_free(domain);
> +out_no_domain:
> +       pr_warn("Failed to set up IOMMU for device %s; retaining platform DMA ops\n",
> +               dev_name(dev));
> +       return false;
> +}
> +
> +static void queue_iommu_attach(struct device *dev, const struct iommu_ops *ops,
> +                             u64 dma_base, u64 size)
> +{
> +       struct iommu_dma_notifier_data *iommudata;
> +
> +       iommudata = kzalloc(sizeof(*iommudata), GFP_KERNEL);
> +       if (!iommudata)
> +               return;
> +
> +       iommudata->dev = dev;
> +       iommudata->ops = ops;
> +       iommudata->dma_base = dma_base;
> +       iommudata->size = size;
> +
> +       mutex_lock(&iommu_dma_notifier_lock);
> +       list_add(&iommudata->list, &iommu_dma_masters);
> +       mutex_unlock(&iommu_dma_notifier_lock);
> +}
> +
> +static int __iommu_attach_notifier(struct notifier_block *nb,
> +                                  unsigned long action, void *data)
> +{
> +       struct iommu_dma_notifier_data *master, *tmp;
> +
> +       if (action != BUS_NOTIFY_ADD_DEVICE)
> +               return 0;
> +
> +       mutex_lock(&iommu_dma_notifier_lock);
> +       list_for_each_entry_safe(master, tmp, &iommu_dma_masters, list) {
> +               if (do_iommu_attach(master->dev, master->ops,
> +                               master->dma_base, master->size)) {
> +                       list_del(&master->list);
> +                       kfree(master);
> +               }
> +       }
> +       mutex_unlock(&iommu_dma_notifier_lock);
> +       return 0;
> +}
> +
> +static int register_iommu_dma_ops_notifier(struct bus_type *bus)
> +{
> +       struct notifier_block *nb = kzalloc(sizeof(*nb), GFP_KERNEL);
> +       int ret;
> +
> +       if (!nb)
> +               return -ENOMEM;
> +       /*
> +        * The device must be attached to a domain before the driver probe
> +        * routine gets a chance to start allocating DMA buffers. However,
> +        * the IOMMU driver also needs a chance to configure the iommu_group
> +        * via its add_device callback first, so we need to make the attach
> +        * happen between those two points. Since the IOMMU core uses a bus
> +        * notifier with default priority for add_device, do the same but
> +        * with a lower priority to ensure the appropriate ordering.
> +        */
> +       nb->notifier_call = __iommu_attach_notifier;
> +       nb->priority = -100;
> +
> +       ret = bus_register_notifier(bus, nb);
> +       if (ret) {
> +               pr_warn("Failed to register DMA domain notifier; IOMMU DMA ops unavailable on bus '%s'\n",
> +                       bus->name);
> +               kfree(nb);
> +       }
> +       return ret;
> +}
> +
> +static int __init __iommu_dma_init(void)
> +{
> +       int ret;
> +
> +       ret = iommu_dma_init();
> +       if (!ret)
> +               ret = register_iommu_dma_ops_notifier(&platform_bus_type);
> +       if (!ret)
> +               ret = register_iommu_dma_ops_notifier(&amba_bustype);
> +       return ret;
> +}
> +arch_initcall(__iommu_dma_init);
> +
> +static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +                                 const struct iommu_ops *ops)
> +{
> +       struct iommu_group *group;
> +
> +       if (!ops)
> +               return;
> +       /*
> +        * TODO: As a concession to the future, we're ready to handle being
> +        * called both early and late (i.e. after bus_add_device). Once all
> +        * the platform bus code is reworked to call us late and the notifier
> +        * junk above goes away, move the body of do_iommu_attach here.
> +        */
> +       group = iommu_group_get(dev);
> +       if (group) {
> +               do_iommu_attach(dev, ops, dma_base, size);
> +               iommu_group_put(group);
> +       } else {
> +               queue_iommu_attach(dev, ops, dma_base, size);
> +       }
> +}
> +
> +#else
> +
> +static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +                                 struct iommu_ops *iommu)
> +{ }
> +
> +#endif  /* CONFIG_IOMMU_DMA */
> +
> --
> 1.9.1
>

Regards,
Anup
