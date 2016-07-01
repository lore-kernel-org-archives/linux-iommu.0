From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 2/9] iommu/of: Consolidate device creation workarounds
Date: Fri, 1 Jul 2016 13:29:55 +0100
Message-ID: <20160701122955.GI12735@arm.com>
References: <cover.1467123945.git.robin.murphy@arm.com>
 <dc8ac0f397ea5c90937fb5c9974e4ab02e264bd8.1467123945.git.robin.murphy@arm.com>
 <611b2a77-e7e8-e1e2-85b5-4f469f3ebdf4@samsung.com>
 <577651D7.4030309@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <577651D7.4030309-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 01, 2016 at 12:19:51PM +0100, Robin Murphy wrote:
> On 01/07/16 11:32, Marek Szyprowski wrote:
> > Frankly, I would avoid moving this workaround to the iommu core. IMHO the
> > best solution would be to let IOMMU controllers to be instantiated as
> > normal
> > devices and implement proper support in the device core for waiting for the
> > iommu controller. Then the workaround can be removed from exynos and mtk
> > iommu drivers. What's the status of IOMMU deferred probe patches?
> 
> I think revisiting probe ordering is now second-from-top on my to-do
> list after this lot. This patch was kind of thinking ahead to get the
> "touch all the drivers" aspect out of the way before it grows any
> bigger, and all the development can then happen in the core code alone,
> but I admit it's not a particularly strong argument.
> 
> > I've encountered a serious problems with current code (the one which
> > instantiates iommu controller devices from iommu driver) and its
> > integration
> > with power domains, clocks and runtime pm, which were not possible to
> > resolve
> > without iommu deferred probe.
> 
> OK. Do you have any plans to try tweaking the current workaround, or is
> it really not worth it? FWIW I do have an Exynos 5410 (Odroid-XU) on my
> desk which I could theoretically test things on, but I suspect it would
> take a fair amount of work to get the SYSMMUs and relevant media bits up
> and running on top of Krzysztof's basic support.
> 
> Will: for the time being, the alternative to this patch would be to
> squash the following change into patch 7/9 (without either, patch 8/9
> doesn't really work).

It's ugly, but I'm fine with it for the moment. No need to wait for the
probe deferral stuff before getting this in.

Will
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
