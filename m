From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
Date: Mon, 16 Jun 2014 13:57:04 +0100
Message-ID: <20140616125704.GE16758@arm.com>
References: <1400877395-4235-1-git-send-email-thierry.reding@gmail.com>
 <538757B6.4010109@wwwdotorg.org>
 <20140530073006.GA24748@ulmo>
 <20140530112728.GB3949@e103592.cambridge.arm.com>
 <20140604211237.GC18710@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140604211237.GC18710@mithrandir>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Dave P Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TbrhsbdSgBK9A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jun 04, 2014 at 10:12:38PM +0100, Thierry Reding wrote:
> On Fri, May 30, 2014 at 12:27:28PM +0100, Dave Martin wrote:
> > On Fri, May 30, 2014 at 08:30:08AM +0100, Thierry Reding wrote:
> [...]
> > > Arnd, can you take another look at this binding and see if there's
> > > anything else missing? If not I'll go through the document again and
> > > update all #address-cells/#size-cells references with #iommu-cells as
> > > appropriate and submit v3.
> > 
> > How do you envisage propagation of the master ID bits downstream of the
> > IOMMU would be described?
> > 
> > We will definitely need a way to describe this for GICv3.  How those
> > values are propagated is likely to vary between related SoCs and doesn't
> > feel like it should be baked into a driver, especially for the ARM SMMU
> > which may get reused in radically different SoC families from different
> > vendors.
> 
> Well, we've had cases like these in the past (power sequences come to
> mind). Some concepts are just too difficult or unwieldy to be put into
> device tree. I think that this is one of them.
> 
> > The most likely types of remapping are the adding of a base offset or
> > some extra bits to the ID -- because not all MSIs to the GIC will
> > necessarily pass through the IOMMU.  It's also possible that we might
> > see ID squashing or folding in some systems.
> 
> It can easily be argued that if the algorithm used to remap the ID
> varies, the compatibility of the device changes. Therefore I would
> expect any variant of the GICv3 that deviates from the "standard"
> mapping (if there is such a thing) to have its own compatible string.

There is no standard mapping; it's a property defined at system integration
time. I fully expect different SoCs to do different things here.

Will
