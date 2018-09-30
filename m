From: christoph hellwig <hch@lst.de>
Subject: Re: [PATCH, RFC] unicore32: remove swiotlb support
Date: Mon, 1 Oct 2018 01:08:18 +0200
Message-ID: <20180930230818.GA20776@lst.de>
References: <20180927135434.6866-1-hch@lst.de> <467b89ea.5028.166258f1945.Coremail.gxt@pku.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <467b89ea.5028.166258f1945.Coremail.gxt@pku.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Guan Xuetao <gxt@pku.edu.cn>
Cc: christoph hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Sat, Sep 29, 2018 at 09:40:27PM +0800, Guan Xuetao wrote:
> That's right and really good to use direct.c, not swiotlb.c
> No special limitation for dma zone in unicore32.

Thanks.  Added to the dma-mapping tree for 4.20.
