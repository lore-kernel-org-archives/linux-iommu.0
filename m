From: Christian Zander <christian-dt00mrq0sMmU+1/U8MakDg@public.gmane.org>
Subject: [PATCH] iommu/vt-d: fix range computation when making room for large
	pages
Date: Wed, 10 Jun 2015 09:41:45 -0700
Message-ID: <20150610164145.GA7583@oriole.nervanasys.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

In preparation for the installation of a large page, any small page
tables that may still exist in the target IOV address range are
removed.  However, if a scatter/gather list entry is large enough to
fit more than one large page, the address space for those secondary
large pages is not cleared of conflicting small page tables.

This can cause legitimate mapping requests to fail with errors of the
form below, potentially followed by a series of IOMMU faults:

ERROR: DMA PTE for vPFN 0xfde00 already set (to 7f83a4003 not 7e9e00083)

In this example, a 4MB scatter/gather list entry resulted in the
successful installation of a large page @ vPFN 0xfdc00, followed by
a failed attempt to install another large page @ vPFN 0xfde00, due to
the presence of a pointer to a small page table @ 0x7f83a4000.

To address this problem, compute the number of large pages that fit
into a given scatter/gather list entry, and use it to derive the
last vPFN covered by the large page(s).

Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Christian Zander <christian-dt00mrq0sMmU+1/U8MakDg@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 2ffe589..cf81237 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1986,6 +1986,7 @@ static int __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 	unsigned long sg_res = 0;
 	unsigned int largepage_lvl = 0;
 	unsigned long lvl_pages = 0;
+	unsigned long nr_superpages, end_pfn;
 
 	BUG_ON(!domain_pfn_supported(domain, iov_pfn + nr_pages - 1));
 
@@ -2020,13 +2021,16 @@ static int __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 			if (largepage_lvl > 1) {
 				pteval |= DMA_PTE_LARGE_PAGE;
 				lvl_pages = lvl_to_nr_pages(largepage_lvl);
+
+				nr_superpages = sg_res / lvl_pages;
+				end_pfn = iov_pfn + nr_superpages * lvl_pages - 1;
+
 				/*
 				 * Ensure that old small page tables are
-				 * removed to make room for superpage,
-				 * if they exist.
+				 * removed, if any exist, to make room for the
+				 * superpage(s).
 				 */
-				dma_pte_free_pagetable(domain, iov_pfn,
-						       iov_pfn + lvl_pages - 1);
+				dma_pte_free_pagetable(domain, iov_pfn, end_pfn);
 			} else {
 				pteval &= ~(uint64_t)DMA_PTE_LARGE_PAGE;
 			}
