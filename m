From: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
Subject: [PATCH 0/4] iommu: remove lock contention in iova allocation
Date: Tue, 24 Nov 2015 13:54:06 -0800
Message-ID: <cover.1448401089.git.shli@fb.com>
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

The lock contention in iova allocation is very significant. In my iperf test
with intel 10Gbps NIC card with 48 threads, I observed 99% cpu time is spending
on the lock contention. In the test:

CPU utilization 100%, iperf reports ~1Gbps

The patches introduce a bitmap based approach for dma address allocation. It
completetly avoids the lock contention. Run the same test:

CPU utilization 1%, iperf reports 9.3Gbps

I also tried the test with the patch, but disable bitmap. The result is the
same as that without the patch.

The patches only work for DMA less than 8k, which is the most comman case we
have highest request(DMA) per second. Bigger size DMA still fallback to rbtree
based allocation. But if required and DAC is enabled by default, it's easy to
support bigger size DMA in the bitmap allocation.

Thanks,
Shaohua


Shaohua Li (4):
  iommu: alloc_iova returns a pfn
  iommu: add a bitmap based dma address allocator
  iommu: enable bitmap allocation for intel iommu
  iommu: free_iova doesn't need lock twice

 drivers/iommu/dma-iommu.c   |  32 ++++-----
 drivers/iommu/intel-iommu.c |  96 ++++++++++++++++-----------
 drivers/iommu/iova.c        | 157 +++++++++++++++++++++++++++++++++-----------
 include/linux/iova.h        |  21 ++++--
 4 files changed, 210 insertions(+), 96 deletions(-)

-- 
2.4.6
