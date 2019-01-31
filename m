From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/3] videobuf2: replace a layering violation with
 dma_map_resource
Date: Thu, 31 Jan 2019 16:31:50 +0100
Message-ID: <20190131153150.GA754@lst.de>
References: <20190111181731.11782-1-hch@lst.de> <CGME20190111181812epcas2p1eeb68a16701631513eaf297073f7299f@epcas2p1.samsung.com> <20190111181731.11782-4-hch@lst.de> <6f8892ac-c2aa-10df-c74f-ba032bf75160@samsung.com> <20190117172152.GA32292@lst.de> <f4222474-0515-c0a2-ef5e-523b56869210@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f4222474-0515-c0a2-ef5e-523b56869210@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Pawel Osciak <pawel@osciak.com>, Kyungmin Park <kyungmin.park@samsung.com>, Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>, Russell King <linux@armlinux.org.uk>, Mauro Carvalho Chehab <mchehab@kernel.org>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Marek,

can chance you could retest the v2 version?
