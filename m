From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [bug report] iommu: Implement common IOMMU ops for DMA mapping
Date: Tue, 15 Nov 2016 12:44:25 +0300
Message-ID: <20161115094425.GA13139@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: robin.murphy-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello Robin Murphy,

The patch 0db2e5d18f76: "iommu: Implement common IOMMU ops for DMA
mapping" from Oct 1, 2015, leads to the following static checker
warning:

	drivers/iommu/dma-iommu.c:377 iommu_dma_alloc()
	warn: use 'gfp' here instead of GFP_XXX?

drivers/iommu/dma-iommu.c
   343  struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
                                                                       ^^^^^^^^^

   344                  unsigned long attrs, int prot, dma_addr_t *handle,
   345                  void (*flush_page)(struct device *, const void *, phys_addr_t))
   346  {
   347          struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
   348          struct iova_domain *iovad = cookie_iovad(domain);
   349          struct iova *iova;
   350          struct page **pages;
   351          struct sg_table sgt;
   352          dma_addr_t dma_addr;
   353          unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
   354  
   355          *handle = DMA_ERROR_CODE;
   356  
   357          min_size = alloc_sizes & -alloc_sizes;
   358          if (min_size < PAGE_SIZE) {
   359                  min_size = PAGE_SIZE;
   360                  alloc_sizes |= PAGE_SIZE;
   361          } else {
   362                  size = ALIGN(size, min_size);
   363          }
   364          if (attrs & DMA_ATTR_ALLOC_SINGLE_PAGES)
   365                  alloc_sizes = min_size;
   366  
   367          count = PAGE_ALIGN(size) >> PAGE_SHIFT;
   368          pages = __iommu_dma_alloc_pages(count, alloc_sizes >> PAGE_SHIFT, gfp);
                                                                                  ^^^^
Here we use gfp.

   369          if (!pages)
   370                  return NULL;
   371  
   372          iova = __alloc_iova(domain, size, dev->coherent_dma_mask);
   373          if (!iova)
   374                  goto out_free_pages;
   375  
   376          size = iova_align(iovad, size);
   377          if (sg_alloc_table_from_pages(&sgt, pages, count, 0, size, GFP_KERNEL))
                                                                           ^^^^^^^^^^
Here we're using GFP_KERNEL.  I don't know the code well enough to say
if it was intentional.

   378                  goto out_free_iova;
   379  
   380          if (!(prot & IOMMU_CACHE)) {
   381                  struct sg_mapping_iter miter;
   382                  /*
   383                   * The CPU-centric flushing implied by SG_MITER_TO_SG isn't
   384                   * sufficient here, so skip it by using the "wrong" direction.
   385                   */
   386                  sg_miter_start(&miter, sgt.sgl, sgt.orig_nents, SG_MITER_FROM_SG);

regards,
dan carpenter
