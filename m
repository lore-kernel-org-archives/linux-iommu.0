From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
Date: Thu, 31 Jul 2014 10:22:41 +0100
Message-ID: <20140731092241.GA21850@leverpostej>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
	<20140730152646.GC20162@leverpostej> <20140731083923.GA31218@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140731083923.GA31218@ulmo>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Varun Sethi <varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave P Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

[...]

> > > +Examples:
> > > +=========
> > > +
> > > +Single-master IOMMU:
> > > +--------------------
> > > +
> > > +	iommu {
> > > +		#iommu-cells = <0>;
> > > +	};
> > > +
> > > +	master {
> > > +		iommus = <&/iommu>;
> > 
> > Nit: this should be iommus = <&{/iommu}>, or it's not valid dts syntax.
> 
> Done.

Cheers. I take it that was done for the other occurrences too?

> 
> > > +	};
> > > +
> > > +Multiple-master IOMMU with fixed associations:
> > > +----------------------------------------------
> > > +
> > > +	/* multiple-master IOMMU */
> > > +	iommu {
> > > +		/*
> > > +		 * Masters are statically associated with this IOMMU and
> > > +		 * address translation is always enabled.
> > > +		 */
> > > +		#iommu-cells = <0>;
> > 
> > I don't follow why translation being always enabled is relevant to the
> > example; that would seem to be independent from the binding.
> > 
> > Surely the key point is that with no way to distinguish devices, they
> > presumably share the same translations?
> 
> Both aspects are important I think. For #iommu-cells = <0> there is no
> way for the IOMMU driver to know how to enable translation for a given
> device. So it must be either always on or always off.

Sure. But "always on or off" is not the same as "always enabled", which
was what confused me.

> I guess one could say that this is implicit if all masters share the
> same translations. And I guess translations don't always have to be on
> or off technically. Let me try to rephrase this:
> 
> 		/*
> 		 * Masters are statically associated with this IOMMU and share
> 		 * the same address translations because the IOMMU does not
> 		 * have sufficient information to distinguish between masters.
> 		 *
> 		 * Consequently address translation is always on or off for
> 		 * all masters at any given point in time.
> 		 */
> 
> Does that sound better?

That addresses my concern, so yes.

Given these are minor and everyone wants this in now, I'm happy for
these to go through in a fixup patch later.

Cheers,
Mark.
