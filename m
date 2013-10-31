From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3] iommu: shmobile: Enable the driver on all ARM
 platforms
Date: Thu, 31 Oct 2013 15:03:05 +0900
Message-ID: <20131031060305.GU1603@verge.net.au>
References: <1383132043-5190-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131030112625.GZ16735@n2100.arm.linux.org.uk>
 <1652955.Gs3XDiEUHO@avalon>
 <20131030162854.GB2493@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131030162854.GB2493@sirena.org.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Oct 30, 2013 at 09:28:54AM -0700, Mark Brown wrote:
> On Wed, Oct 30, 2013 at 12:40:12PM +0100, Laurent Pinchart wrote:
> 
> > > For similar reasons as x86, can we please think about using:
> 
> > > 	depends on ARM
> > > 	depends on ARCH_SHMOBILE || ARCH_SHMOBILE_MULTI || COMPILE_TEST
> 
> > I'm fine with your proposed option. As I don't want to respin the series 
> > dozens of time let's first agree on the course of action, I will then repost 
> > the patches. Mark, you've pushed towards as few platform dependencies as 
> > possible, what's your opinion on this ?
> 
> In general I think we should have whatever the real depedencies are or
> COMPILE_TEST (to the extent that they will actually build cleanly on
> other targets).  That way only people who explicitly go looking to
> compile test things for build coverage (eg, when doing global cleanups
> or API updates) need to be bothered by the extra compile test options.
> 
> I'd read the above as saying the code needs ARM to build at all and that
> the hardware will only ever appear on SHMOBILE.

I am curious to know the value of "depends ARM".
Is it to aid the reading that you spelt out?

