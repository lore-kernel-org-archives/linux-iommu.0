From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/5] dma-mapping: move the dma_coherent flag to struct
 device
Date: Tue, 11 Sep 2018 08:48:02 +0200
Message-ID: <20180911064802.GB6214@lst.de>
References: <20180910060533.27172-1-hch@lst.de> <20180910060533.27172-3-hch@lst.de> <71ec3eef-54c1-f692-5a17-4302c4dd4b05@arm.com> <20180910154747.GA23578@lst.de> <aa6f49f8-24ea-f166-9c58-aecb13df0418@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <aa6f49f8-24ea-f166-9c58-aecb13df0418@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Marek Szyprowski <m.szyprowski@samsung.com>, Paul Burton <paul.burton@mips.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Sep 10, 2018 at 05:06:40PM +0100, Robin Murphy wrote:
>>> Nits aside, this otherwise looks sane to me for factoring out the
>>> equivalent Xen and arm64 DMA ops cases.
>>
>> Like this? :)
>>
>> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-maybe-coherent
>
> Man, that's going to take me a *lot* of time to pick through. All those 
> horrendous subtleties that I barely remember!

The good thing is that if I remember correctly there is just a single
patch that (intentionally) changes behavior.  The rest is just
refactoring and moving code around.

Anyway, I want to get this series in now, and the kick off the swiotlb
discussion with Konread.  We might not even get to the iommu patches
for this merge window depending on how long it takes.
