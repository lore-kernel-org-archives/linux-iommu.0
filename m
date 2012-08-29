From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [RFC 0/5] ARM: dma-mapping: New dma_map_ops to control IOVA more precisely
Date: Wed, 29 Aug 2012 09:55:30 +0300
Message-ID: <1346223335-31455-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, chunsang.jeong-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, vdumpa-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, subashrp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, minchan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

The following APIs are needed for us to support the legacy Tegra
memory manager for devices("NvMap") with *DMA mapping API*.

New API:

 ->iova_alloc(): To allocate IOVA area.
 ->iova_alloc_at(): To allocate IOVA area at specific address.
 ->iova_free():  To free IOVA area.

 ->map_page_at(): To map page at specific IOVA.

misc:
 ->iova_get_free_total(): To return how much IOVA is available totally.
 ->iova_get_free_max():   To return the size of biggest IOVA area.

Although  NvMap itself will be replaced soon, there are cases for the
above API where we need to specify IOVA explicitly.

(1) HWAs may require the address for special purpose, like reset vector.
(2) IOVA linear mapping: ex: [RFC 5/5] ARM: dma-mapping: Introduce
    dma_map_linear_attrs() for IOVA linear map
(3) To support different heaps. To have allocation and mapping
    independently.

Some of them could be supported with creating different mappings, but
currently a device can have a single contiguous mapping, and we cannot
specifiy any address inside of a map since all IOVA alloction is done
implicitly now.

This is the revised version of:

 http://lists.linaro.org/pipermail/linaro-mm-sig/2012-May/001947.html
 http://lists.linaro.org/pipermail/linaro-mm-sig/2012-May/001948.html
 http://lists.linaro.org/pipermail/linaro-mm-sig/2012-May/001949.html

Any comment would be really appreciated.

Hiroshi Doyu (5):
  ARM: dma-mapping: New dma_map_ops->iova_get_free_{total,max}
    functions
  ARM: dma-mapping: New dma_map_ops->iova_{alloc,free}() functions
  ARM: dma-mapping: New dma_map_ops->iova_alloc*_at* function
  ARM: dma-mapping: New dma_map_ops->map_page*_at* function
  ARM: dma-mapping: Introduce dma_map_linear_attrs() for IOVA linear
    map

 arch/arm/include/asm/dma-mapping.h       |   55 +++++++++++++
 arch/arm/mm/dma-mapping.c                |  124 ++++++++++++++++++++++++++++++
 include/asm-generic/dma-mapping-common.h |   20 +++++
 include/linux/dma-mapping.h              |   14 ++++
 4 files changed, 213 insertions(+), 0 deletions(-)

-- 
1.7.5.4
