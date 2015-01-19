From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v10] iopoll: Introduce memory-mapped IO polling macros
Date: Mon, 19 Jan 2015 16:19:18 +0100
Message-ID: <3657890.a3eGsv4NQj@wuerfel>
References: <1418687243-16395-1-git-send-email-mitchelh@codeaurora.org> <20150119124348.GA2806@suse.de> <20150119144028.GA2373@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150119144028.GA2373@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>, Joerg Roedel <jroedel@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Thierry Reding <thierry.reding@gmail.com>, Matt Wagantall <mattw@codeaurora.org>, Robert Elliott <elliott@hp.com>, Andrew Morton <akpm@linux-foundation.org>, Mitchel Humpherys <mitchelh@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

On Monday 19 January 2015 14:40:28 Will Deacon wrote:
> On Mon, Jan 19, 2015 at 12:43:48PM +0000, Joerg Roedel wrote:
> > On Thu, Jan 15, 2015 at 10:25:11AM +0000, Will Deacon wrote:
> > > If you get an Ack from any of Arnd/Joerg/akpm then I'm happy to take it via
> > > the arm-smmu pull (along with the patch making use of it).
> > > 
> > > Joerg, would you be ok with that?
> > 
> > I am ok with that, but like to have another Ack for it.
> 
> That's fair enough.
> 
> Arnd, could you take another look at this patch please? You had some
> comments in the past.

No further objections from my side. I don't think it's really needed,
but it seems harmless, so

Acked-by: Arnd Bergmann <arnd@arndb.de>
