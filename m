From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 0/4] dma-mapping: Constify dma_attrs
Date: Tue, 24 May 2016 08:28:06 +0200
Message-ID: <1464071290-15948-1-git-send-email-k.kozlowski@samsung.com>
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
To: Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Stefano Stabellini <sstabellini-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

The patchset is divided into two parts:
1. (patch 1-3): Constify dma_attrs passed to some of functions. The
   first patch is a dependency for all other. This is not intrusive.

2. patch 4: request for comments, constify dma_attrs everywhere (struct
   dma_map_ops and implementations).
   Constness may protect from certain coding bugs and, what is more
   important, is a direct documentation of how the core deals
   with passed data. Some of the dma-mapping users allocate attrs
   on the stack so the ownership cannot be transferred. 'Const' here
   means exactly that - the ownership stays with the caller.

   Unfortunately this cannot be done separately per-implementation
   without introducing build warnings so the patch touches multiple
   subsystems. Maybe using some casts in intermediate steps might help
   splitting it into separate patches?

   This is not finished because there is no point of my effort if
   I will hear short NACK soon. :)

Comments are welcomed.

Best regards,
Krzysztof

Krzysztof Kozlowski (4):
  dma-mapping: Constify attrs passed to dma_get_attr
  ARM: dma-mapping: Constify attrs passed to internal functions
  arm64: dma-mapping: Constify attrs passed to internal functions
  dma-mapping: Constify dma_attrs

 arch/arm/include/asm/dma-mapping.h | 12 +++---
 arch/arm/mm/dma-mapping.c          | 87 ++++++++++++++++++++------------------
 arch/arm/xen/mm.c                  |  4 +-
 arch/arm64/mm/dma-mapping.c        | 53 +++++++++++------------
 drivers/iommu/dma-iommu.c          |  6 +--
 include/linux/dma-attrs.h          |  3 +-
 include/linux/dma-iommu.h          |  6 +--
 include/linux/dma-mapping.h        | 34 ++++++++-------
 include/linux/swiotlb.h            |  9 ++--
 lib/dma-noop.c                     |  9 ++--
 lib/swiotlb.c                      |  9 ++--
 11 files changed, 123 insertions(+), 109 deletions(-)

-- 
1.9.1
