From: Jerry Snitselaar <jsnitsel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Question about out_unmap section of map_sg in amd_iommu.c
Date: Sat, 19 Jan 2019 00:16:21 -0700
Message-ID: <20190119071621.xh5s3rkqiabgjwo4@cantor>
Reply-To: Jerry Snitselaar <jsnitsel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



  out_unmap:
          pr_err("%s: IOMMU mapping error in map_sg (io-pages: %d)\n",
                 dev_name(dev), npages);

          for_each_sg(sglist, s, nelems, i) {
                  int j, pages = iommu_num_pages(sg_phys(s), s->length, PAGE_SIZE);

                  for (j = 0; j < pages; ++j) {
                          unsigned long bus_addr;

                          bus_addr  = address + s->dma_address + (j << PAGE_SHIFT);
                          iommu_unmap_page(domain, bus_addr, PAGE_SIZE);

                          if (--mapped_pages)
                                  goto out_free_iova;

Is this condition correct?  My thought is this was meant to break out of the loop early if
all the mapped pages have been unmapped. So if (--mapped == 0) instead?

                  }
          }
