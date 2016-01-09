From: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
Subject: [PATCH V2 0/4]IOMMU: avoid lock contention in iova allocation
Date: Fri, 8 Jan 2016 16:44:45 -0800
Message-ID: <cover.1452297604.git.shli@fb.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Kernel-team-b10kYP2dOMg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

iova alloc/free causes big lock contention, which could be easily demonstrated
with iperf workload. Previously I posted a patchset:
http://lists.linuxfoundation.org/pipermail/iommu/2015-November/014984.html

the concern is it's not generic. This is another try for the issue. This
version implements a per-cpu iova cache for small size DMA allocation (<= 64k),
which should be generic enough and so we can do batch allocation. iova free
could be easily batched too. With batch alloc/free, iova lock contention
disappears. Performance result with this patchset is nearly the same as the
previous one in the same test.

After this patchset, async_umap_flush_lock becomes the hotest lock in
intel-iommu, but not very bad. That will be something we need work on in the
future.

Thanks,
Shaohua

Shaohua Li (4):
  IOMMU: add a percpu cache for iova allocation
  iommu: free_iova doesn't need lock twice
  intel-iommu: remove find_iova in unmap path
  intel-iommu: do batch iova free

 drivers/iommu/intel-iommu.c |  77 +++++++++++++------
 drivers/iommu/iova.c        | 177 +++++++++++++++++++++++++++++++++++---------
 include/linux/iova.h        |  10 +++
 3 files changed, 208 insertions(+), 56 deletions(-)

-- 
2.4.6
