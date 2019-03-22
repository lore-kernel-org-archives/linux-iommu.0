From: =?utf-8?Q?Cl=C3=A9ment?= Leger <cleger@kalray.eu>
Subject: Re: [PATCH] dma: select GENERIC_ALLOCATOR for DMA_REMAP
Date: Fri, 22 Mar 2019 09:30:09 +0100 (CET)
Message-ID: <1443307786.4859175.1553243409888.JavaMail.zimbra@kalray.eu>
References: <1741404498.4767335.1553163629182.JavaMail.zimbra@kalray.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1741404498.4767335.1553163629182.JavaMail.zimbra@kalray.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
List-Id: iommu@lists.linux-foundation.org



----- Mail original -----
De: "Cl=C3=A9ment Leger" <cleger@kalray.eu>
=C3=80: "linux-kernel" <linux-kernel@vger.kernel.org>
Envoy=C3=A9: Jeudi 21 Mars 2019 11:20:29
Objet: [PATCH] dma: select GENERIC_ALLOCATOR for DMA_REMAP

When DMA_REMAP is enabled, code in remap.c needs generic allocator.
It currently worked since few architectures uses it (arm64, csky) and
they both select GENERIC_ALLOCATOR.

Signed-off-by: Clement Leger <clement.leger@kalray.eu>
---
 kernel/dma/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index a06ba3013b3b..6a43c4ae77f9 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -58,6 +58,7 @@ config SWIOTLB
 config DMA_REMAP
 =09depends on MMU
 =09bool
+=09select GENERIC_ALLOCATOR
=20
 config DMA_DIRECT_REMAP
 =09bool
--=20
2.15.0.276.g89ea799
