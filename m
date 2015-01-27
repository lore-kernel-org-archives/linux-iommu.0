From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 3/5] iommu: implement common IOMMU ops for DMA mapping
Date: Tue, 27 Jan 2015 13:38:09 +0100
Message-ID: <20150127123809.GJ30345@8bytes.org>
References: <cover.1421086706.git.robin.murphy@arm.com>
	<09e5515a9afcb3235f4c425520cd18a6032d31b4.1421086706.git.robin.murphy@arm.com>
	<20150127002116.GI30345@8bytes.org> <54C7843B.3000605@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54C7843B.3000605-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org" <stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 27, 2015 at 12:27:39PM +0000, Robin Murphy wrote:
> Laz^WPragmatism - I'm expecting quite a lot of changes to get this
> looking good, so keeping the series as lean as possible to aid
> reviewing/rebasing/etc. seemed sensible. In the same vein, since the
> other architectures already have code that works, my priority is
> getting something in place to fill the gap in arm64 (my current
> remit is "get the SMMUs on Juno working"); it seemed logical to
> minimise disruption and dependencies by aiming to get this merged
> with the one user, then start porting the others (and making the
> inevitable necessary tweaks) once it's in.
> 
> I'll adjust the commit message to make that clearer - on re-reading
> it, it does come across as rather vague about that intent.

Yeah, probably we can add other architectures later (like x86). But can
you at least merge it with the existing version of this for ARM32? That
should be easier to achieve than extending it for x86 by now and we do
not end up with two similar implementations.

> >>  lib/dma-iommu.c           | 455 ++++++++++++++++++++++++++++++++++++++++++++++
> >
> >I'd like this to live in drivers/iommu, as most other dma-api
> >implementations for iommu-drivers also live there.
> >
> 
> That's reasonable - I was trying to model this on SWIOTLB, so it
> ended up in the same place. Mind you, I suppose there's a fair
> argument for moving SWIOTLB over to drivers/iommu too.

SWIOTLB is used outside of iommu code too, like in Xen for example. So I
think it could stay in lib/. But a dma-ops implemention using iommu-api
only used iommu-code and should be in drivers/iommu.

> Indeed, that comment is pretty ancient and the 'proper' one was
> already half-done when I posted this; It'll be in v2.

Thanks.

Regards,

	Joerg
