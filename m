From: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] swiotlb: drop pointless static qualifier in
 swiotlb_dma_supported()
Date: Thu, 14 Feb 2019 16:39:29 +0800
Message-ID: <c73333ab-18b9-c846-7f03-c91721cbd1ba@huawei.com>
References: <20190214014147.108653-1-yuehaibing@huawei.com>
 <20190214072658.GA10416@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214072658.GA10416@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 2019/2/14 15:26, Christoph Hellwig wrote:
> On Thu, Feb 14, 2019 at 01:41:47AM +0000, YueHaibing wrote:
>> There is no need to have the 'struct dentry *d_swiotlb_usage' variable
>> static since new value always be assigned before use it.
> 
> FYI, this is in swiotlb_create_debugfs, not swiotlb_dma_supported.

Thank you, I will fix it.

> 
> .
> 
