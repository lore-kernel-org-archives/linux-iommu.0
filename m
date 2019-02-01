From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: fix a layering violation in videobuf2 and improve
 dma_map_resource v2
Date: Fri, 1 Feb 2019 08:05:21 +0100
Message-ID: <774dc557-b690-203f-898f-38755b099068@samsung.com>
References: <CGME20190118113751epcas2p2d7d678dcf247806a119316aabb4dde21@epcas2p2.samsung.com>
        <20190118113727.3270-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190118113727.3270-1-hch@lst.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Pawel Osciak <pawel@osciak.com>, Kyungmin Park <kyungmin.park@samsung.com>, =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Russell King <linux@armlinux.org.uk>, Mauro Carvalho Chehab <mchehab@kernel.org>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi All,

On 2019-01-18 12:37, Christoph Hellwig wrote:
> Hi all,
>
> this series fixes a rather gross layering violation in videobuf2, which
> pokes into arm DMA mapping internals to get a DMA address for memory that
> does not have a page structure, and to do so fixes up the dma_map_resource
> implementation to not provide a somewhat dangerous default and improve
> the error handling.
>
> Changes since v1:
>  - don't apply bus offsets in dma_direct_map_resource

Works fine on older Exynos based boards with IOMMU and CMA disabled.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
