From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] swiotlb: Update the comment of swiotlb
Date: Wed, 9 May 2018 13:39:57 +0200
Message-ID: <20180509113957.GA25787@lst.de>
References: <1525691185-55657-1-git-send-email-xieyisheng1@huawei.com> <20180509073838.GA20874@lst.de> <b6246d95-7d9c-2904-6298-9c5ca3506a5f@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b6246d95-7d9c-2904-6298-9c5ca3506a5f@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>, konrad.wilk@oracle.com, mingo@kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, May 09, 2018 at 05:08:30PM +0800, Yisheng Xie wrote:
> Hi Christoph,
> 
> On 2018/5/9 15:38, Christoph Hellwig wrote:
> > Thanks,
> > 
> > applied to the dma-mapping tree.
> 
> Thanks
> 
> BTW, should lib/swiotlb.c also add to DMA MAPPING HELPERS, or
> add yourself as a maintainer of SWIOTLB SUBSYSTEM ? It will make
> get_maintainer.pl get you :)

Konrad is the maintainer, but due to me touching the file a lot
lately I keep merging the patches for now.  But anything non-trivial
absolutely requires an Ack from Konrad.
