From: Christoph Hellwig <hch@lst.de>
Subject: Re: use the generic dma-noncoherent code for sh V3
Date: Tue, 31 Jul 2018 09:24:13 +0200
Message-ID: <20180731072413.GA22837@lst.de>
References: <20180725094043.32443-1-hch@lst.de> <877elcrlbe.wl-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <877elcrlbe.wl-ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Christoph Hellwig <hch@lst.de>, Rich Felker <dalias@libc.org>, Jacopo Mondi <jacopo+renesas@jmondi.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-sh@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 31, 2018 at 03:06:13PM +0900, Yoshinori Sato wrote:
> On Wed, 25 Jul 2018 18:40:38 +0900,
> Christoph Hellwig wrote:
> > 
> > Hi all,
> > 
> > can you review these patches to switch sh to use the generic
> > dma-noncoherent code?  All the requirements are in mainline already
> > and we've switched various architectures over to it already.
> > 
> > Changes since V2:
> >  - drop a now obsolete export
> > 
> > Changes since V1:
> >  - fixed two stupid compile errors and verified them using a local
> >    cross toolchain instead of the 0day buildbot
> 
> Acked-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Do you want to pull this in through the sh tree?  If not I'd be happy
to take it through the dma mapping tree.
