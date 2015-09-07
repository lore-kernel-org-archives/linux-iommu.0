From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/3] Docs: dt: Add PCI MSI map bindings
Date: Mon, 7 Sep 2015 18:56:43 +0100
Message-ID: <20150907175643.GB18079@leverpostej>
References: <1437670365-20704-1-git-send-email-mark.rutland@arm.com>
	<1437670365-20704-3-git-send-email-mark.rutland@arm.com>
	<55B5E8C1.4030707@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55B5E8C1.4030707-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org" <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "tirumalesh.chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org" <tirumalesh.chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "majun258-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <majun258-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

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
> > +
> > +- msi-parent: Describes the MSI parent of the root complex itself. Where
> > +  the root complex and MSI controller do not pass sideband data with MSI
> > +  writes, this property may be used to describe the MSI controller(s)
> > +  used by PCI devices under the root complex, if defined as such in the
> > +  binding for the root complex.
> 
> Right, this is where I'd expect some details about #msi-cells. Is it
> meant to be ignored? The lack of symmetry between the PCI and non-PCI
> use cases feels a bit inelegant (not to mention that it precludes having
> an unified parser for both cases).

I would expect that the msi-parent's #msi-cells could be non-zero.

As I see it, there are three possible interpretations (and the choice
between these would be specific to a PCI root complex):

(1) Devices under the root complex generate MSIs via the MSI parent,
    using common sideband data described in the msi cells (and therefore
    cannot be distingushed from each other).

(2) The root complex itself generates MSIs via the MSI parent, with any
    sideband data described in the msi cells.

(3) Both the root complex and devices underneath it generate MSIs via
    the MSI parent, using common sideband data described in the msi
    cells (and therefore cannot be distinguished from each other).

Of these, (1) is the common case today, though (2) would be more in
keeping with how this style of property usually works.

I'm not sure how to capture that.

Thanks,
Mark.
