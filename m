From: George Wang <xuw2015-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: dma_ops_domain_alloc causes kernel 4.1.0-next-20150626+ panic
Date: Tue, 30 Jun 2015 01:44:34 +0800
Message-ID: <CAPBX1x+zagVVYebbXU0M7VkEaDkzvqBGnkt6PW_N42fRQRQ9Gg@mail.gmail.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,
  I am trying to do some tests for kernel 4.1.0-next-20150626+, but
panic in amd_iommu_attach_dev. After some digging inside amd_iommu.c,
I found the suspecting code:

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index d3e5e9a..4f6da17 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1882,6 +1882,7 @@ static struct dma_ops_domain *dma_ops_domain_alloc(void)
                return NULL;

        spin_lock_init(&dma_dom->domain.lock);
+       mutex_init(&dma_dom->domain.api_lock);

When I initialize the api_lock, then I can go forward with another problem.

Thanks,

George
