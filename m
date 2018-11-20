From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/2] SWIOTLB fixes for 4.20
Date: Tue, 20 Nov 2018 17:08:18 +0100
Message-ID: <20181120160818.GC2492@lst.de>
References: <cover.1542722463.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1542722463.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: hch@lst.de, konrad.wilk@oracle.com, m.szyprowski@samsung.com, john.stultz@linaro.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Nov 20, 2018 at 02:09:51PM +0000, Robin Murphy wrote:
> This is what I have so far, which at least resolves the most ovbious
> problems. I still haven't got very far with the USB corruption issue
> I see on Juno with -rc1, but I'm yet to confirm whether that's actually
> attributable to the SWIOTLB changes or something else entirely.

This looks good modulo the minor nitpicks.

Konrad, are you ok with me picking up both through the dma-mapping
tree?
