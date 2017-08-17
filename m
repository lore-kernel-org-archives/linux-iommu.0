From: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 06/13] drm/etnaviv: Use sychronized interface of the
	IOMMU-API
Date: Thu, 17 Aug 2017 16:30:48 +0200
Message-ID: <1502980248.19806.29.camel@pengutronix.de>
References: <1502974596-23835-1-git-send-email-joro@8bytes.org>
	<1502974596-23835-7-git-send-email-joro@8bytes.org>
	<1502976758.19806.25.camel@pengutronix.de>
	<20170817134539.GJ2853@suse.de>
	<1502978634.19806.27.camel@pengutronix.de>
	<20170817141858.GG16908@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170817141858.GG16908-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, etnaviv-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Russell King <linux+etnaviv-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Am Donnerstag, den 17.08.2017, 16:18 +0200 schrieb Joerg Roedel:
> On Thu, Aug 17, 2017 at 04:03:54PM +0200, Lucas Stach wrote:
> > There is no IOMMU driver in use. Etnaviv just uses part of the IOMMU API
> > to manage the GPU internal MMU, see
> > drivers/gpu/drm/etnaviv/etnaviv_iommu.c
> 
> That looks like a very fragile construct, because it relies on internal
> behavior of the iommu code that can change in the future.
> 
> I strongly suggest to either make etnaviv_iommu.c a real iommu driver an
> move it to drivers/iommu, or (prefered by me) just call directly into
> the map/unmap functions of this driver from the rest of the
> etnaviv_iommu.c. I don't really see a reason why the IOMMU-API needs to
> be used there as another layer of indirection.

Yeah, the IOMMU API being used internally is a historical accident, that
we didn't get around to rectify yet. It's on my things-we-need-to-do
list to prune the usage of the IOMMU API in etnaviv.

Regards,
Lucas
