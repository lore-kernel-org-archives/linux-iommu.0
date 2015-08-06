From: Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 2/3] Docs: dt: Add PCI MSI map bindings
Date: Thu, 6 Aug 2015 19:46:49 +0000
Message-ID: <CY1PR0301MB07483BBD1B779122D58D2E0887740@CY1PR0301MB0748.namprd03.prod.outlook.com>
References: <1437670365-20704-1-git-send-email-mark.rutland@arm.com>
	<1437670365-20704-3-git-send-email-mark.rutland@arm.com>
	<CALRxmdA32xiSX7DDKAJPLR8=bh_9j-6MN124u4KjYGRT8bAKNg@mail.gmail.com>
	<CY1PR0301MB07486794749E499F71BDFCD287750@CY1PR0301MB0748.namprd03.prod.outlook.com>
	<20150806181453.GD6437@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150806181453.GD6437@leverpostej>
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
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org" <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "tirumalesh.chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org" <tirumalesh.chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "majun258-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <majun258-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland-5wv7dgnIgG8@public.gmane.org]
> Sent: Thursday, August 06, 2015 1:15 PM
> To: Yoder Stuart-B08248; Marc Zyngier; Will Deacon
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Lorenzo Pieralisi; arnd-r2nGTMty4D4@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; tirumalesh.chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org;
> laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org; thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org; treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org; linux-arm-
> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; majun258-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
> Subject: Re: [PATCH 2/3] Docs: dt: Add PCI MSI map bindings
> 
> [...]
> 
> > > +PCI root complex
> > > +================
> > > +
> > > +Optional properties
> > > +-------------------
> > > +
> > > +- msi-map: Maps a Requester ID to an MSI controller and associated
> > > +  msi-specifier data. The property is an arbitrary number of tuples of
> > > +  (rid-base,msi-controller,msi-base,length), where:
> > > +
> > > +  * rid-base is a single cell describing the first RID matched by the entry.
> > > +
> > > +  * msi-controller is a single phandle to an MSI controller
> > > +
> > > +  * msi-base is an msi-specifier describing the msi-specifier produced for the
> > > +    first RID matched by the entry.
> > > +
> > > +  * length is a single cell describing how many consecutive RIDs are matched
> > > +    following the rid-base.
> > > +
> > > +  Any RID r in the interval [rid-base, rid-base + length) is associated with
> > > +  the listed msi-controller, with the msi-specifier (r - rid-base + msi-base).
> > > +
> > > +- msi-map-mask: A mask to be applied to each Requester ID prior to being mapped
> > > +  to an msi-specifier per the msi-map property.
> >
> > Can we extend the msi-map-mask definition to say:  "A mask value of 0x0 is valid
> > and indicates that no RIDs are _currently_ mapped to any msi-specifier."
> 
> That would break a valid case of the mask being all zeroes.
> 
> Consider the case that all RIDs get mapped to a single msi-specifier;
> the obvious way to write that is:
> 
> msi-map-mask = <0x0000>;
> msi-map = <0x0000 &msi (msi-specifier) 1>;
> 
> In this case all RIDS are always mapped to the single msi-specifier.

Does it really break that case?

We could have this (your example):

  msi-map-mask = <0x0000>;
  msi-map = <0x0000 &msi 7 1>;  // map all RIDs to msi-spec 7

Or, my example:

  msi-map-mask = <0x0000>;
  msi-map = <0x0000 &msi 7 4>;  // all RIDs map to any of msi-spec 7,8,9,10

> > We have an SoC with a programmable hardware table in the PCI controller that maps
> > requester ID to stream ID, so the overall msi-map (and iommu-map) definition fit
> > into that scheme.  But, we would like to be able make the RID->stream-ID mapping
> > decision _lazily_, in Linux, based on actual usage of PCI devices.
> 
> Dynamically programming the mapping is at odds to this binding. I don't
> see how that can fit.

My example above obviously doesn't make sense for a static
binding, but can't we allow both a mask value of 0x0 and
a length > 1 at the same time.
 
> Why can the RID->SID mapping not be statically configured prior to
> entering the OS?

The problem for us is the limited number of SIDs available on our SoC.  We
have an SMMU-500 with 128 SIDs / 64-contexts total.  An SR-IOV card could
enable VFs dynamically and suddenly there are 64 new RIDs on a PCI
bus.  There are 4 PCI controllers and firmware doesn't know what
might be enabled on which bus.  We run out of available SIDs.

In that example we want all RIDs mapped to one SID by default, but want
the option of setting our dynamic RID->SID table for a situation where
say someone assigns a VF to a KVM VM and thus needs an SID to use
for SMMU mappings.

I think the binding can work for the dynamic case as long as we allow
the example I showed above.  So, I would propose changing
my proposed text to:

   "A mask value of 0x0 is valid and indicates that all RIDS map to
    the specified msi-specifier(s).  If the mask is 0x0 and length > 1
    it indicates that all RIDs map to any of the msi-specifiers with
    the actual mapping left unspecified by the msi-map property."

Thanks,
Stuart
