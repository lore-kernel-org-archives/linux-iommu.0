From: Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: IOMMU DMA-mapping API for arm64 ?
Date: Sat, 26 Apr 2014 19:58:37 +0530
Message-ID: <CAD15aga3VAHH9aV134tfp+CgA8x25R_H4DKoPKNkFyAC9FTxBg@mail.gmail.com>
References: <CAD15agaps45rZT5ko9JKP2CfRF_iTV+0JMDwa239ExgKrRzBYQ@mail.gmail.com>
	<201402272006.51057.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <201402272006.51057.arnd-r2nGTMty4D4@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Guys,

Need again some help in deciding which all functions/Data structures
needs to be moved out from arch/arm/mm/dma-mapping to
lib/iommu-helper.c.

1. There is this dma_iommu_mapping structure defination in
arch/arm/include/asm/dma-iommu.h. In arm this structure is declared as
"mapping" which is part of dev_archdata structure, which is used for
IOVA management.
Now, does this make sense to move this structure out to
include/linux/iommu-helper.h ? And define a config like
CONFIG_IOMMU_USE_HELPER_MAPPING (default n) which will be used to,
have a variable("mapping") defined or not in dev_archdata of all
archs.

    a. With this IOVA management can be completely moved out
lib/iommu-helper.c. And as Arnd said(below) this will be
implementation specific and will not be visible to architectures in
the header file.
    b. buffer allocation can be either ways moved out to
lib/iommu-helper.c. Except the atomic allocations (as of 1st step
atleast) which is part of arch/arm/mm/dma-mapping.c

Taking this above step, following are functions can be moved out:

extern void __iommu_detach_device(struct device *dev);
extern int __iommu_attach_device(struct device *dev, struct
dma_iommu_mapping *mapping);
extern void __iommu_release_mapping(struct dma_iommu_mapping *mapping);
extern struct dma_iommu_mapping *__iommu_init_mapping(struct bus_type
*bus, dma_addr_t base, size_t size);

__iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
void *cpu_addr, dma_addr_t dma_addr, size_t size,
dma_addr_t iommu_coherent_map_page(struct device *dev, struct page
*page, unsigned long offset, size_t size, enum dma_data_direction dir,
struct dma_attrs *attrs)
void iommu_coherent_unmap_page(struct device *dev, dma_addr_t handle,
size_t size, enum dma_data_direction dir, struct dma_attrs *attrs)
int iommu_coherent_map_sg(struct device *dev, struct scatterlist *sg,
int nents, enum dma_data_direction dir, struct dma_attrs *attrs)

and there are some more...

Current users of this refactored code to lib/iommu-helper.c will be
arm and arm64.


2. Now, if we don't bring this structure outside, there will be little
code which can be moved out. Following functions are what I can think
of:

struct page **iommu_alloc_buffer(struct device *dev, size_t size,
gfp_t gfp, struct dma_attrs *attrs);
int iommu_free_buffer(struct device *dev, struct page **pages, size_t
size, struct dma_attrs *attrs);
int iommu_map_pages(struct iommu_domain *domain, struct page **pages,
dma_addr_t iova, size_t size);
int iommu_dma_direction_to_prot(enum dma_data_direction dir);
void *iommu_alloc_remap(struct page **pages, size_t size, unsigned
long flags, pgprot_t prot, const void *caller);
int iommu_mmap_pages_prot(struct vm_area_struct *vma, struct page
**pages, pgprot_t prot);
and also say iommu_map_sg (excluing alloc_iova).



This might sound like too much to ask, but because of many arch's
dev_archdata will be affected, its a bit confusing to take this
decision.
I felt its better to ask before and have a theoretical design ready,
instead of cribbing my head to redo the design after the incorrect
changes.


Please let me know your thought on this.



On Fri, Feb 28, 2014 at 12:36 AM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> On Thursday 27 February 2014, Ritesh Harjani wrote:
>> Hi Everyone,
>>
>> I was going through some iommu code in arch/arm and of some other
>> archs code. I have some doubts on this for refactoring and may need
>> some suggestions from you guys.
>>
>> 1. So, looking at other arch code, looks like they have their
>> different way of implementation of iova management and buffer
>> allocation. So to refactor the iommu common code out from arch/arm/ to
>> lib/iommu-helper, do we need to take care across all arch  ?
>
> I'd say not initially. The code can easily live in a generic place
> but not be shared by everyone. If it turns out that another architecture
> has a better allocator, then we can always change the common code
> later.
>
>> 2. Should the approach be like take the common code(between arm/arm64)
>> and move it into lib/iommu-helper.c ?
>>
>> Could someone give an example of what sort of code(will be better if
>> this is little more specific) we are talking here to be taken out to
>> lib/iommu-helper.c ? Earlier I was thinking of iova management can be
>> taken out but then I saw it might not be suited across all archs.
>>
>> I am ready to do this work, but need some guidance from the experts .
>
> I think we should start by splitting out the iommu_coherent_ops structure
> and everything that depends on. Noncoherent DMA is harder to do in
> an architecture independent way, since we don't have a common way
> to manage the cache across architectures. It would also be good
> to follow the example of include/linux/swiotlb.h regarding the
> public interface, to keep that part common. This way, ARM can easily
> implement the noncoherent ops on top.

I think we can follow step 1 above, and move most of code to
lib/iommu-helper.h. Currently anyways only arm and arm64 will be using
this code.
Later based on the need of different archs, this code can be modified ??


>
> I would leave the iova management as implementation details and
> not make that visible to architectures in the header file.
>
>         Arnd


Thanks
Ritesh
