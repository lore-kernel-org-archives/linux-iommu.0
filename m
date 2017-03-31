From: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 0/7] iommu/iova: improve the allocation performance of dma64
Date: Fri, 31 Mar 2017 11:24:18 +0800
Message-ID: <1490930665-9696-1-git-send-email-thunder.leizhen@huawei.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Sudeep Dutt <sudeep.dutt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ashutosh Dixit <ashutosh.dixit-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Zefan Li <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tianhong Ding <dingtianhong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

v1 -> v2:
Because the problem of my email-server, all patches sent to Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> failed.
So I repost all these patches again, there is no changes.

v1:
64 bits devices is very common now. But currently we only defined a cached32_node
to optimize the allocation performance of dma32, and I saw some dma64 drivers chose
to allocate iova from dma32 space first, maybe becuase of current dma64 performance
problem or some other reasons.

For example:(in drivers/iommu/amd_iommu.c)
static unsigned long dma_ops_alloc_iova(......
{
	......
	if (dma_mask > DMA_BIT_MASK(32))
		pfn = alloc_iova_fast(&dma_dom->iovad, pages,
				      IOVA_PFN(DMA_BIT_MASK(32)));
	if (!pfn)
		pfn = alloc_iova_fast(&dma_dom->iovad, pages, IOVA_PFN(dma_mask));
		
For the details of why dma64 iova allocation performance is very bad, please refer the
description of patch-5.

In this patch series, I added a cached64_node to manage the dma64 iova space(iova>=4G), it
takes the same effect as cached32_node(iova<4G).

Below it's the performance data before and after my patch series:
(before)$ iperf -s
------------------------------------------------------------
Server listening on TCP port 5001
TCP window size: 85.3 KByte (default)
------------------------------------------------------------
[  4] local 192.168.1.106 port 5001 connected with 192.168.1.198 port 35898
[ ID] Interval       Transfer     Bandwidth
[  4]  0.0-10.2 sec  7.88 MBytes  6.48 Mbits/sec
[  5] local 192.168.1.106 port 5001 connected with 192.168.1.198 port 35900
[  5]  0.0-10.3 sec  7.88 MBytes  6.43 Mbits/sec
[  4] local 192.168.1.106 port 5001 connected with 192.168.1.198 port 35902
[  4]  0.0-10.3 sec  7.88 MBytes  6.43 Mbits/sec

(after)$ iperf -s
------------------------------------------------------------
Server listening on TCP port 5001
TCP window size: 85.3 KByte (default)
------------------------------------------------------------
[  4] local 192.168.1.106 port 5001 connected with 192.168.1.198 port 36330
[ ID] Interval       Transfer     Bandwidth
[  4]  0.0-10.0 sec  1.09 GBytes   933 Mbits/sec
[  5] local 192.168.1.106 port 5001 connected with 192.168.1.198 port 36332
[  5]  0.0-10.0 sec  1.10 GBytes   939 Mbits/sec
[  4] local 192.168.1.106 port 5001 connected with 192.168.1.198 port 36334
[  4]  0.0-10.0 sec  1.10 GBytes   938 Mbits/sec


Zhen Lei (7):
  iommu/iova: fix incorrect variable types
  iommu/iova: cut down judgement times
  iommu/iova: insert start_pfn boundary of dma32
  iommu/iova: adjust __cached_rbnode_insert_update
  iommu/iova: to optimize the allocation performance of dma64
  iommu/iova: move the caculation of pad mask out of loop
  iommu/iova: fix iovad->dma_32bit_pfn as the last pfn of dma32

 drivers/iommu/amd_iommu.c        |   7 +-
 drivers/iommu/dma-iommu.c        |  22 ++----
 drivers/iommu/intel-iommu.c      |  11 +--
 drivers/iommu/iova.c             | 143 +++++++++++++++++++++------------------
 drivers/misc/mic/scif/scif_rma.c |   3 +-
 include/linux/iova.h             |   7 +-
 6 files changed, 94 insertions(+), 99 deletions(-)

-- 
2.5.0
