From: Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH 0/2] SWIOTLB fixes for 4.20
Date: Tue, 27 Nov 2018 12:39:33 -0800 (PST)
Message-ID: <alpine.DEB.2.10.1811271239080.4577@sstabellini-ThinkPad-X260>
References: <cover.1542722463.git.robin.murphy@arm.com> <20181120160818.GC2492@lst.de> <20181120163441.GD31199@char.us.oracle.com> <20181121130331.GA1373@lst.de> <20181121151133.GC26925@char.us.oracle.com>
 <alpine.DEB.2.10.1811271106460.4577@sstabellini-ThinkPad-X260>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.10.1811271106460.4577@sstabellini-ThinkPad-X260>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, m.szyprowski@samsung.com, john.stultz@linaro.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 27 Nov 2018, Stefano Stabellini wrote:
> On Wed, 21 Nov 2018, Konrad Rzeszutek Wilk wrote:
> > On Wed, Nov 21, 2018 at 02:03:31PM +0100, Christoph Hellwig wrote:
> > > On Tue, Nov 20, 2018 at 11:34:41AM -0500, Konrad Rzeszutek Wilk wrote:
> > > > > Konrad, are you ok with me picking up both through the dma-mapping
> > > > > tree?
> > > > 
> > > > Yes, albeit I would want Stefano to take a peek at patch #2 just in case.
> > > 
> > > Stefano, can you take a look asap?  This is a pretty trivial fix for
> > > a nasty bug that breaks boot on real life systems.  I'd like to merge
> > > it by tomorrow so that I can send it off to Linus for the next rc
> > > (I will be offline for about two days after Friday morning)
> > 
> > It is Turkey Day in US so he may be busy catching those pesky turkeys.
> > How about Tuesday? And in can also send the GIT PULL.
> 
> I have just come back to the office. I'll give it a look today.

Everything looks good to me, thanks for keeping me in the loop.
