From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] iommu/dma: Don't put uninitialised IOVA domains
Date: Wed, 27 Jul 2016 16:46:06 +0100
Message-ID: <d88eb3dc42377b8aa7947d2b0141f28589ae645f.1469634042.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Due to the limitations of having to wait until we see a device's DMA
restrictions before we know how we want an IOVA domain initialised,
there is a window for error if a DMA ops domain is allocated but later
freed without ever being used. In that case, init_iova_domain() was
never called, so calling put_iova_domain() from iommu_put_dma_cookie()
ends up trying to take an uninitialised lock and crashing.

Make things robust by skipping the call unless the IOVA domain actually
has been initialised, as we probably should have done from the start.

Reported-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

I'm not sure this warrants a cc stable, as with the code currently in
mainline it's only at all likely if other things have already failed
elsewhere in a manner they should not be expected to.

 drivers/iommu/dma-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ea5a9ebf0f78..97a23082e18a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -68,7 +68,8 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 	if (!iovad)
 		return;
 
-	put_iova_domain(iovad);
+	if (iovad->granule)
+		put_iova_domain(iovad);
 	kfree(iovad);
 	domain->iova_cookie = NULL;
 }
-- 
2.8.1.dirty
