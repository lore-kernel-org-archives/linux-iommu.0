From: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH 1/7 v5] Docs: dt: add fsl-mc iommu-map device-tree binding
Date: Fri, 6 Jul 2018 12:10:53 +0000
Message-ID: <HE1PR0401MB2425F74655E5DFE4DDE38EE3E6470@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
	<1526824191-7000-2-git-send-email-nipun.gupta@nxp.com>
	<cd70dc56-ce6a-f6ef-1362-143d9c31bb46@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cd70dc56-ce6a-f6ef-1362-143d9c31bb46-5wv7dgnIgG8@public.gmane.org>
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Laurentiu Tudor <laurentiu.tudor-3arQi8VN3Tc@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Leo Li <leoyang.li-3arQi8VN3Tc@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy-5wv7dgnIgG8@public.gmane.org]
> Sent: Tuesday, July 3, 2018 8:10 PM
> To: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>; will.deacon-5wv7dgnIgG8@public.gmane.org;
> robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org;
> catalin.marinas-5wv7dgnIgG8@public.gmane.org; gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org; Laurentiu Tudor
> <laurentiu.tudor-3arQi8VN3Tc@public.gmane.org>; bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
> Cc: hch-jcswGhMUV9g@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org;
> shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> foundation.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-
> pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>;
> stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; Leo Li <leoyang.li-3arQi8VN3Tc@public.gmane.org>
> Subject: Re: [PATCH 1/7 v5] Docs: dt: add fsl-mc iommu-map device-tree
> binding
> 
> On 20/05/18 14:49, Nipun Gupta wrote:
> > The existing IOMMU bindings cannot be used to specify the relationship
> > between fsl-mc devices and IOMMUs. This patch adds a generic binding for
> > mapping fsl-mc devices to IOMMUs, using iommu-map property.
> >
> > Signed-off-by: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
> > Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > ---
> >   .../devicetree/bindings/misc/fsl,qoriq-mc.txt      | 39
> ++++++++++++++++++++++
> >   1 file changed, 39 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> > index 6611a7c..8cbed4f 100644
> > --- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> > +++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> > @@ -9,6 +9,25 @@ blocks that can be used to create functional hardware
> objects/devices
> >   such as network interfaces, crypto accelerator instances, L2 switches,
> >   etc.
> >
> > +For an overview of the DPAA2 architecture and fsl-mc bus see:
> > +drivers/staging/fsl-mc/README.txt
> 
> Nit: Looks like that's Documentation/networking/dpaa2/overview.rst now.
> 
> > +
> > +As described in the above overview, all DPAA2 objects in a DPRC share the
> > +same hardware "isolation context" and a 10-bit value called an ICID
> > +(isolation context id) is expressed by the hardware to identify
> > +the requester.
> > +
> > +The generic 'iommus' property is insufficient to describe the relationship
> > +between ICIDs and IOMMUs, so an iommu-map property is used to
> define
> > +the set of possible ICIDs under a root DPRC and how they map to
> > +an IOMMU.
> > +
> > +For generic IOMMU bindings, see
> > +Documentation/devicetree/bindings/iommu/iommu.txt.
> > +
> > +For arm-smmu binding, see:
> > +Documentation/devicetree/bindings/iommu/arm,smmu.txt.
> > +
> >   Required properties:
> >
> >       - compatible
> > @@ -88,14 +107,34 @@ Sub-nodes:
> >                 Value type: <phandle>
> >                 Definition: Specifies the phandle to the PHY device node associated
> >                             with the this dpmac.
> > +Optional properties:
> > +
> > +- iommu-map: Maps an ICID to an IOMMU and associated iommu-
> specifier
> > +  data.
> > +
> > +  The property is an arbitrary number of tuples of
> > +  (icid-base,iommu,iommu-base,length).
> > +
> > +  Any ICID i in the interval [icid-base, icid-base + length) is
> > +  associated with the listed IOMMU, with the iommu-specifier
> > +  (i - icid-base + iommu-base).
> >
> >   Example:
> >
> > +        smmu: iommu@5000000 {
> > +               compatible = "arm,mmu-500";
> > +               #iommu-cells = <2>;
> 
> This should be 1 if stream-match-mask is present. Bad example is bad :)

Agree :). Ill update it.

> 
> Robin.
> 
> > +               stream-match-mask = <0x7C00>;
> > +               ...
> > +        };
> > +
> >           fsl_mc: fsl-mc@80c000000 {
> >                   compatible = "fsl,qoriq-mc";
> >                   reg = <0x00000008 0x0c000000 0 0x40>,    /* MC portal base */
> >                         <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
> >                   msi-parent = <&its>;
> > +                /* define map for ICIDs 23-64 */
> > +                iommu-map = <23 &smmu 23 41>;
> >                   #address-cells = <3>;
> >                   #size-cells = <1>;
> >
> >
