From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] MAINTAINERS: add the iommu list for swiotlb and
        xen-swiotlb
Date: Fri, 26 Jan 2018 08:51:53 +0100
Message-ID: <20180126075153.GA2356@lst.de>
References: <20180116075624.5191-1-hch@lst.de> <20180125142618.GB25449@char.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180125142618.GB25449@char.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 25, 2018 at 09:26:18AM -0500, Konrad Rzeszutek Wilk wrote:
> On Tue, Jan 16, 2018 at 08:56:24AM +0100, Christoph Hellwig wrote:
> > All other discussions related to the dma mapping interfaces are on the
> > iommu list, so let's make it the official list for swiotlb and the
> > second list for xen-swiotlb.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> I am so behind emails.. I am not sure if I had replied to this, but just
> in case I hadn't:
> 
> Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thanks, I've added this patch to the dma-mapping tree.
