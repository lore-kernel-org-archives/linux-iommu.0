From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/3] videobuf2: replace a layering violation with
 dma_map_resource
Date: Thu, 17 Jan 2019 18:21:52 +0100
Message-ID: <20190117172152.GA32292@lst.de>
References: <20190111181731.11782-1-hch@lst.de> <CGME20190111181812epcas2p1eeb68a16701631513eaf297073f7299f@epcas2p1.samsung.com> <20190111181731.11782-4-hch@lst.de> <6f8892ac-c2aa-10df-c74f-ba032bf75160@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6f8892ac-c2aa-10df-c74f-ba032bf75160@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Pawel Osciak <pawel@osciak.com>, Kyungmin Park <kyungmin.park@samsung.com>, Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>, Russell King <linux@armlinux.org.uk>, Mauro Carvalho Chehab <mchehab@kernel.org>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 14, 2019 at 01:42:26PM +0100, Marek Szyprowski wrote:
> Hi Christoph,
> 
> On 2019-01-11 19:17, Christoph Hellwig wrote:
> > vb2_dc_get_userptr pokes into arm direct mapping details to get the
> > resemblance of a dma address for a a physical address that does is
> > not backed by a page struct.  Not only is this not portable to other
> > architectures with dma direct mapping offsets, but also not to uses
> > of IOMMUs of any kind.  Switch to the proper dma_map_resource /
> > dma_unmap_resource interface instead.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> There are checks for IOMMU presence in other places in vb2-dma-contig,
> so it was used only when no IOMMU is available, but I agree that the
> hacky code should be replaced by a generic code if possible.
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> V4L2 pipeline works fine on older Exynos-based boards with CMA and IOMMU
> disabled.

Do you know if these rely on the offsets?  E.g. would they still work
with the patch below applied on top.  That would keep the map_resource
semantics as-is as solve the issue pointed out by Robin for now.

If not I can only think of a flag to bypass the offseting for now, but
that would be pretty ugly.  Or go for the long-term solution of
discovering the relationship between the two devices, as done by the
PCIe P2P code..

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 8e0359b04957..25bd19974223 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -359,7 +359,7 @@ EXPORT_SYMBOL(dma_direct_map_sg);
 dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	dma_addr_t dma_addr = phys_to_dma(dev, paddr);
+	dma_addr_t dma_addr = paddr;
 
 	if (unlikely(!dma_direct_possible(dev, dma_addr, size))) {
 		report_addr(dev, dma_addr, size);
