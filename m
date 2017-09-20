From: Tomasz Nowicki <tomasz.nowicki-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH V2 0/1] Optimise IOVA allocations for PCI devices
Date: Wed, 20 Sep 2017 10:52:01 +0200
Message-ID: <1505897522-9237-1-git-send-email-tomasz.nowicki@caviumnetworks.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: Jayachandran.Nair-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, Tomasz Nowicki <tomasz.nowicki-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ganapatrao.Kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Here is my test setup where I have stareted performance measurements.

 ------------  PCIe  -------------   TX   -------------  PCIe  -----
| ThunderX2  |------| Intel XL710 | ---> | Intel XL710 |------| X86 |
| (128 cpus) |      |   40GbE     |      |    40GbE    |       -----
 ------------        -------------        -------------

As the reference lets take v4.13 host, SMMUv3 off and 1-thread iperf
taskset to one CPU. The performance results I got:

SMMU off -> 100%
SMMU on -> 0,02%

I followed down the DMA mapping path and found out IOVA 32-bit space
full so that kernel was flushing rcaches for all CPUs in (1).
For 128 CPUs, this kills the performance. Furthermore, for my case, rcaches
contained PFNs > 32-bit mostly so the second round of IOVA allocation failed
as well. As the consequence IOVA had to be allocated outside of 32-bit (2)
from scratch since all rcaches have been flushed in (1).

    if (dma_limit > DMA_BIT_MASK(32) && dev_is_pci(dev))
(1)-->  iova = alloc_iova_fast(iovad, iova_len, DMA_BIT_MASK(32) >> shift);

    if (!iova)
(2)-->  iova = alloc_iova_fast(iovad, iova_len, dma_limit >> shift);

My fix simply introduces parameter for alloc_iova_fast() to decide whether
rcache flush has to be done or not. All users follow mentioned scenario
so they should let flush as the last chance to avoid time costly iteration
over all CPUs.

This bring my iperf performance back to 100% with SMMU on.

My bad feelings regarding this solution is that machines with relatively
small numbers of CPUs may get DAC addresses more frequently for PCI
devices. Please let me know your thoughts.

Changelog:

v1 --> v2
- add missing documentation
- fix typo

Tomasz Nowicki (1):
  iommu/iova: Make rcache flush optional on IOVA allocation failure

 drivers/iommu/amd_iommu.c   |  5 +++--
 drivers/iommu/dma-iommu.c   |  6 ++++--
 drivers/iommu/intel-iommu.c |  5 +++--
 drivers/iommu/iova.c        | 11 ++++++-----
 include/linux/iova.h        |  5 +++--
 5 files changed, 19 insertions(+), 13 deletions(-)

-- 
2.7.4
