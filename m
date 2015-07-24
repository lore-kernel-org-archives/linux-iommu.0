From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 3/3] Docs: dt: add PCI IOMMU map bindings
Date: Fri, 24 Jul 2015 14:26:23 +0100
Message-ID: <20150724132623.GB21234@leverpostej>
References: <1437670365-20704-1-git-send-email-mark.rutland@arm.com>
	<1437670365-20704-4-git-send-email-mark.rutland@arm.com>
	<55B22E5B.7080208@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55B22E5B.7080208-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org" <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "tirumalesh.chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org" <tirumalesh.chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "majun258-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <majun258-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

> This looks sane, and lets me describe the thing I have on my desk, so 
> I'm happy. I have a couple of general thoughts below, but I don't intend 
> that they should stand in the way of this proposal as-is.

Good to hear that this doesn't fall apart at the sight of a real system!

> On 23/07/15 17:52, Mark Rutland wrote:
> > The existing IOMMU bindings are able to specify the relationship between
> > masters and IOMMUs, but they are insufficient for describing the general
> > case of hotpluggable busses such as PCI where the set of masters is not
> > known until runtime, and the relationship between masters and IOMMUs is
> > a property of the integration of the system.
> >
> > This patch adds a generic binding for mapping PCI devices to IOMMUs,
> > using a new iommu-map property (specific to PCI*) which may be used to
> > map devices (identified by their Requester ID) to sideband data for the
> > IOMMU which they master through.
> >
> > Signed-off-by: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> > ---
> >   .../devicetree/bindings/pci/pci-iommu.txt          | 171 +++++++++++++++++++++
> >   1 file changed, 171 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/pci/pci-iommu.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pci/pci-iommu.txt b/Documentation/devicetree/bindings/pci/pci-iommu.txt
> > new file mode 100644
> > index 0000000..56c8296
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/pci-iommu.txt
> > @@ -0,0 +1,171 @@
> > +This document describes the generic device tree binding for describing the
> > +relationship between PCI(e) devices and IOMMU(s).
> > +
> > +Each PCI(e) device under a root complex is uniquely identified by its Requester
> > +ID (AKA RID). A Requester ID is a triplet of a Bus number, Device number, and
> > +Function number.
> > +
> > +For the purpose of this document, when treated as a numeric value, a RID is
> > +formatted such that:
> > +
> > +* Bits [15:8] are the Bus number.
> > +* Bits [7:3] are the Device number.
> > +* Bits [2:0] are the Function number.
> > +* Any other bits required for padding must be zero.
> > +
> > +IOMMUs may distinguish PCI devices through sideband data derived from the
> > +Requester ID. While a given PCI device can only master through one IOMMU, a
> > +root complex may split masters across a set of IOMMUs (e.g. with one IOMMU per
> > +bus).
> > +
> > +The generic 'iommus' property is insufficient to describe this relationship,
> > +and a mechanism is required to map from a PCI device to its IOMMU and sideband
> > +data.
> > +
> > +For generic IOMMU bindings, see
> > +Documentation/devicetree/bindings/iommu/iommu.txt.
> > +
> > +
> > +PCI root complex
> > +================
> > +
> > +Optional properties
> > +-------------------
> > +
> > +- iommu-map: Maps a Requester ID to an IOMMU and associated iommu-specifier
> > +  data.
> > +
> > +  The property is an arbitrary number of tuples of
> > +  (rid-base,iommu,iommu-base,length).
> > +
> > +  Any RID r in the interval [rid-base, rid-base + length) is associated with
> > +  the listed IOMMU, with the iommu-specifier (r - rid-base + iommu-base).
> 
> Can we take as a guarantee that the system cannot present any ID at a 
> given IOMMU that is not represented in an appropriate output range (in 
> the sense that we may do things that could blow up horribly if spurious 
> IDs appeared)?

I would expect that for the root complex, the iommu-map should cover all
possible RIDs (and hence we would know their output IDs). In the case
that a possible RID was not translated by the property, I would hope
that we could either detect this at parse time, or prevent probing of
the device when it appeared.

The root complex could share IOMMUs with other masters, so in general
iommu-map alone would not be sufficient to detect all possible IDs.

> Furthermore, would representing one-to-many mappings by having multiple 
> matches for a given RID be legal? In the general case it's certainly 
> feasible for the IOMMU to see different IDs for e.g. reads vs. writes, 
> where the system munges extra bus lines into the sideband signals - 
> whether anyone would actually integrate a PCI host controller that way 
> is another matter, so I don't think it's something worth really worrying 
> about without a definite need.

I'd expect no-one would implement separate read and write IDs, given
that the IOMMU should distinguish reads and writes anyway.

Generally I don't think multiple matches for the same RID make sense.

> > +- iommu-map-mask: A mask to be applied to each Requester ID prior to being
> > +  mapped to an iommu-specifier per the iommu-map property.
> 
> Am I right to assume a mask of 0 would be a valid way to represent 
> "everything" (and if so, should rid-base and length just be ignored, or 
> mandated to be 0 and 1 respectively)? It looks a bit off at first 
> glance, but it does neatly address a genuine use-case.

I think that should be valid, yes.

> > +
> > +
> > +Example (1)
> > +===========
> > +
> > +/ {
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +
> > +	iommu: iommu@a {
> > +		reg = <0xa 0x1>;
> > +		compatible = "vendor,some-iommu";
> > +		#iommu-cells = <1>;
> 
> Troll question; what do we do when #iommu-cells > 1, where the IOMMU is 
> expecting some extra data associated with each ID (say, memory attributes)?

It really depends on the format of your iommu-specifier.

In the degenerate case, you can simply provide each RID with its own
translation and a full iommu-specifier, though that could take an
appeciable amount of space.

I would hope that for PCI you shouldn't need to describe the
transformation of memory attributes, however.

Thanks,
Mark.
