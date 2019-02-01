From: Christoph Hellwig <hch@lst.de>
Subject: Re: fix a layering violation in videobuf2 and improve
 dma_map_resource v2
Date: Fri, 1 Feb 2019 10:07:55 +0100
Message-ID: <20190201090755.GA16464@lst.de>
References: <CGME20190118113751epcas2p2d7d678dcf247806a119316aabb4dde21@epcas2p2.samsung.com> <20190118113727.3270-1-hch@lst.de> <774dc557-b690-203f-898f-38755b099068@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <774dc557-b690-203f-898f-38755b099068@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Pawel Osciak <pawel@osciak.com>, Kyungmin Park <kyungmin.park@samsung.com>, Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>, Russell King <linux@armlinux.org.uk>, Mauro Carvalho Chehab <mchehab@kernel.org>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Feb 01, 2019 at 08:05:21AM +0100, Marek Szyprowski wrote:
> Works fine on older Exynos based boards with IOMMU and CMA disabled.
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks.  I've merged the ѕeries into the dma-mapping tree, and I've
also made a stable branch available at:

    git://git.infradead.org/users/hch/dma-mapping.git videobuf-map-resource

in case it needs to be pulled into the media tree.
