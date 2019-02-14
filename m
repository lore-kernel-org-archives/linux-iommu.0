From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH -next] swiotlb: drop pointless static qualifier in
 swiotlb_dma_supported()
Date: Thu, 14 Feb 2019 08:26:58 +0100
Message-ID: <20190214072658.GA10416@lst.de>
References: <20190214014147.108653-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190214014147.108653-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Feb 14, 2019 at 01:41:47AM +0000, YueHaibing wrote:
> There is no need to have the 'struct dentry *d_swiotlb_usage' variable
> static since new value always be assigned before use it.

FYI, this is in swiotlb_create_debugfs, not swiotlb_dma_supported.
