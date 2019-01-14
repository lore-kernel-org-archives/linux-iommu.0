From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: fix a layering violation in videobuf2 and improve
 dma_map_resource
Date: Mon, 14 Jan 2019 12:43:03 +0100
Message-ID: <141501f5-a9f4-98d7-e958-ca40fc870454@samsung.com>
References: <CGME20190111181841epcas3p2d7c0bf8f5c11a9863e22ec1b12da6e1b@epcas3p2.samsung.com>
        <20190111181731.11782-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190111181731.11782-1-hch@lst.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Pawel Osciak <pawel@osciak.com>, Kyungmin Park <kyungmin.park@samsung.com>, =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Russell King <linux@armlinux.org.uk>, Mauro Carvalho Chehab <mchehab@kernel.org>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Christoph,

On 2019-01-11 19:17, Christoph Hellwig wrote:
> Hi all,
>
> this series fixes a rather gross layering violation in videobuf2, which
> pokes into arm DMA mapping internals to get a DMA address for memory that
> does not have a page structure, and to do so fixes up the dma_map_resource
> implementation to be practically useful.

Thanks for rewriting this 'temporary code'! It predates
dma_map_resource() and that time this was the only way to get it working
somehow. Good that now it is possible to implement in it a clean way
without any unwritten assumptions about the DMA mapping internals. Feel
free to add my:

Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
