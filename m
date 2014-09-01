From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 1/7] iommu: provide early initialisation hook for
	IOMMU drivers
Date: Mon, 1 Sep 2014 17:36:12 +0100
Message-ID: <20140901163612.GL24594@arm.com>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
	<1409327670-3495-2-git-send-email-will.deacon@arm.com>
	<20140901075216.GA24430@ulmo> <4386980.goxm0OjCmJ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4386980.goxm0OjCmJ@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Sep 01, 2014 at 03:31:28PM +0100, Arnd Bergmann wrote:
> On Monday 01 September 2014 09:52:19 Thierry Reding wrote:
> > I don't think this is the right direction. We've been preaching that
> > using initcall ordering is a bad thing and people should be using
> > deferred probe instead. Now we have a bunch of these OF tables that do
> > the exact opposite. Note that these are nothing more than a variant of
> > initcalls that get called at platform-specific points in time.
> > 
> > There are also ongoing discussions about how to change the device probe
> > order to use dependencies (such as phandles from device tree) to prevent
> > excessive deferred probing. With that in place this would be solved in a
> > much more generic way.
> 
> We are not creating an ABI here, so it can always be changed later.
> For now, I think iommus are clearly in the same category as irqchips,
> timers, clock controllers and smp operations: we really want them
> to be available before we set up any other devices.

I'm also trying to move the SMMU driver to the generic bindings before the
existing bindings start getting used. The sooner we have parsing of the
generic binding in the core code, the sooner that can happen.

Will
