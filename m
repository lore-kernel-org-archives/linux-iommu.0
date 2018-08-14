From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 0/3] iommu: Avoid DMA ops domain refcount contention
Date: Tue, 14 Aug 2018 14:04:15 +0100
Message-ID: <cover.1534250425.git.robin.murphy@arm.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org
Cc: linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

John raised the issue[1] that we have some unnecessary refcount contention
in the DMA ops path which shows scalability problems now that we have more
real high-performance hardware using iommu-dma. The x86 IOMMU drivers are
sidestepping this by stashing domain references in archdata, but since
that's not very nice for architecture-agnostic code, I think it's time to
look at a generic API-level solution.

These are a couple of quick patches based on the idea I had back when
first implementing this lot, but didn't have any way to justify at the
time. The third patch can be ignored for the sake of API discussion, but
is included for completeness. 

Robin.


[1] https://lists.linuxfoundation.org/pipermail/iommu/2018-August/029303.html

Robin Murphy (3):
  iommu: Add fast hook for getting DMA domains
  iommu/dma: Use fast DMA domain lookup
  arm64/dma-mapping: Mildly optimise non-coherent IOMMU ops

 arch/arm64/mm/dma-mapping.c | 10 +++++-----
 drivers/iommu/dma-iommu.c   | 23 ++++++++++++-----------
 drivers/iommu/iommu.c       |  9 +++++++++
 include/linux/iommu.h       |  1 +
 4 files changed, 27 insertions(+), 16 deletions(-)

-- 
2.17.1.dirty
