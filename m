From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: DMA mapping API(IOMMU) for ARM64?
Date: Tue, 18 Jun 2013 04:39:55 +0200
Message-ID: <20130618.053955.305832937374936961.hdoyu@nvidia.com>
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
To: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "Arnd-r2nGTMty4D4@public.gmane.org" <Arnd-r2nGTMty4D4@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

Currently ARM64 supports swiotlb only as below[1]. AFAIU, swiotlb
provides some kind of bounce buffer for some restricted H/Ws, and it
cannot replace IOMMU H/W completely. So I'm wondering that we would
need the IOMMU versions of dma_map_ops as Marek did for ARM32. If my
understanding is correct, do you guys have any idea how it's going to
be implemented? Can we reuse the current version of "iommu_ops" in
"arch/arm/mm/dma-mapping.c" for ARM64 as well? Or do we need to
rewrite 64bit version of iommu_ops completely in the same file as one
with swiotlb, "arch/arm64/mm/dma-mapping.c"?

Any feedback would be really appreciated.

[1]:
commit 09b55412469dfe6797244dc5836c17ed0c2f191b
Author: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Date:   Mon Mar 5 11:49:30 2012 +0000

    arm64: DMA mapping API
    
    This patch adds support for the DMA mapping API. It uses dma_map_ops for
    flexibility and it currently supports swiotlb. This patch could be
    simplified further if the DMA accesses are coherent (not mandated by the
    architecture) or if corresponding hooks are placed in the generic
    swiotlb code to deal with cache maintenance.
