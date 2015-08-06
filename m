From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/3] Docs: dt: Add PCI MSI map bindings
Date: Thu, 6 Aug 2015 19:14:53 +0100
Message-ID: <20150806181453.GD6437@leverpostej>
References: <1437670365-20704-1-git-send-email-mark.rutland@arm.com>
	<1437670365-20704-3-git-send-email-mark.rutland@arm.com>
	<CALRxmdA32xiSX7DDKAJPLR8=bh_9j-6MN124u4KjYGRT8bAKNg@mail.gmail.com>
	<CY1PR0301MB07486794749E499F71BDFCD287750@CY1PR0301MB0748.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CY1PR0301MB07486794749E499F71BDFCD287750-YrwGdl+PljkyhdUd3pz1uJwN6zqB+hSMnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org" <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "tirumalesh.chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org" <tirumalesh.chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "majun258-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <majun258-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

[...]

> > +PCI root complex
> > +================
> > +
> > +Optional properties
> > +-------------------
> > +
> > +- msi-map: Maps a Requester ID to an MSI controller and associated
> > +  msi-specifier data. The property is an arbitrary number of tuples of
> > +  (rid-base,msi-controller,msi-base,length), where:
> > +
> > +  * rid-base is a single cell describing the first RID matched by the entry.
> > +
> > +  * msi-controller is a single phandle to an MSI controller
> > +
> > +  * msi-base is an msi-specifier describing the msi-specifier produced for the
> > +    first RID matched by the entry.
> > +
> > +  * length is a single cell describing how many consecutive RIDs are matched
> > +    following the rid-base.
> > +
> > +  Any RID r in the interval [rid-base, rid-base + length) is associated with
> > +  the listed msi-controller, with the msi-specifier (r - rid-base + msi-base).
> > +
> > +- msi-map-mask: A mask to be applied to each Requester ID prior to being mapped
> > +  to an msi-specifier per the msi-map property.
> 
> Can we extend the msi-map-mask definition to say:  "A mask value of 0x0 is valid
> and indicates that no RIDs are _currently_ mapped to any msi-specifier."

That would break a valid case of the mask being all zeroes.

Consider the case that all RIDs get mapped to a single msi-specifier;
the obvious way to write that is:

msi-map-mask = <0x0000>;
msi-map = <0x0000 &msi (msi-specifier) 1>;

In this case all RIDS are always mapped to the single msi-specifier.

> We have an SoC with a programmable hardware table in the PCI controller that maps
> requester ID to stream ID, so the overall msi-map (and iommu-map) definition fit
> into that scheme.  But, we would like to be able make the RID->stream-ID mapping
> decision _lazily_, in Linux, based on actual usage of PCI devices.

Dynamically programming the mapping is at odds to this binding. I don't
see how that can fit.

Why can the RID->SID mapping not be statically configured prior to
entering the OS?

Thanks,
Mark.
