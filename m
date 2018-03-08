From: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH 1/6] Docs: dt: add fsl-mc iommu-parent device-tree binding
Date: Thu, 8 Mar 2018 12:32:28 +0000
Message-ID: <HE1PR0401MB24257DC948C69C7A9080ED66E6DF0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
	<1520260166-29387-2-git-send-email-nipun.gupta@nxp.com>
	<20180307224019.oowh74pkbi5izuft@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180307224019.oowh74pkbi5izuft@rob-hp-laptop>
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
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Leo Li <leoyang.li-3arQi8VN3Tc@public.gmane.org>, "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Rob,

> -----Original Message-----
> From: Rob Herring [mailto:robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org]
> Sent: Thursday, March 08, 2018 4:10
> To: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
> Cc: will.deacon-5wv7dgnIgG8@public.gmane.org; robin.murphy-5wv7dgnIgG8@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org;
> catalin.marinas-5wv7dgnIgG8@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
> Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>; gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org;
> joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> Leo Li <leoyang.li-3arQi8VN3Tc@public.gmane.org>; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Laurentiu
> Tudor <laurentiu.tudor-3arQi8VN3Tc@public.gmane.org>; shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; hch-jcswGhMUV9g@public.gmane.org; linux-
> arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
> Subject: Re: [PATCH 1/6] Docs: dt: add fsl-mc iommu-parent device-tree binding
> 
> On Mon, Mar 05, 2018 at 07:59:21PM +0530, Nipun Gupta wrote:
> > The existing IOMMU bindings cannot be used to specify the relationship
> > between fsl-mc devices and IOMMUs. This patch adds a binding for
> > mapping fsl-mc devices to IOMMUs, using a new iommu-parent property.
> >
> > Signed-off-by: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
> > ---
> >  .../devicetree/bindings/misc/fsl,qoriq-mc.txt      | 31
> ++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> > index 6611a7c..011c7d6 100644
> > --- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> > +++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> > @@ -9,6 +9,24 @@ blocks that can be used to create functional hardware
> objects/devices
> >  such as network interfaces, crypto accelerator instances, L2 switches,
> >  etc.
> >
> > +For an overview of the DPAA2 architecture and fsl-mc bus see:
> > +drivers/staging/fsl-mc/README.txt
> > +
> > +As described in the above overview, all DPAA2 objects in a DPRC share the
> > +same hardware "isolation context" and a 10-bit value called an ICID
> > +(isolation context id) is expressed by the hardware to identify
> > +the requester.
> > +
> > +The generic 'iommus' property is cannot be used to describe the relationship
> > +between fsl-mc and IOMMUs, so an iommu-parent property is used to define
> > +the same.
> 
> Why not? It is just a link between 2 nodes.

We have #iommu-cells as '1' i.e. iommu will have one stream ID configured for a device.
Once USB and other devices start to use IOMMU we will also need this iommu-cells.

When #iommu-cells is defined as '1' and we have 'iommus=<&smmu>' compilation
reports warning about the mismatch.
In fsl-mc bus case we do not have any stream id associated with the bus.

As suggested by Robin, we can simply use the iommu-map property.

> 
> > +
> > +For generic IOMMU bindings, see
> > +Documentation/devicetree/bindings/iommu/iommu.txt.
> > +
> > +For arm-smmu binding, see:
> > +Documentation/devicetree/bindings/iommu/arm,smmu.txt.
> > +
> >  Required properties:
> >
> >      - compatible
> > @@ -88,14 +106,27 @@ Sub-nodes:
> >                Value type: <phandle>
> >                Definition: Specifies the phandle to the PHY device node associated
> >                            with the this dpmac.
> > +Optional properties:
> > +
> > +- iommu-parent: Maps the devices on fsl-mc bus to an IOMMU.
> > +  The property specifies the IOMMU behind which the devices on
> > +  fsl-mc bus are residing.
> 
> If you want a generic property, this should be documented in the common
> binding.

We can use the iommu-map property which is already documented.

> 
> Couldn't you have more than 1 IOMMU upstream of a MC?

There is no such device currently with which fsl-mc bus uses more than one iommu.
Infact, our current systems have only single IOMMU :).

Even in future if such devices are there then we can use iommu-map to specify
more than one iommu with separate requester ID's (RID's).

Thank you for review...

Regards,
Nipun

> 
> >
> >  Example:
> >
> > +        smmu: iommu@5000000 {
> > +               compatible = "arm,mmu-500";
> > +               #iommu-cells = <1>;
> > +               stream-match-mask = <0x7C00>;
> > +               ...
> > +        };
> > +
> >          fsl_mc: fsl-mc@80c000000 {
> >                  compatible = "fsl,qoriq-mc";
> >                  reg = <0x00000008 0x0c000000 0 0x40>,    /* MC portal base */
> >                        <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
> >                  msi-parent = <&its>;
> > +                iommu-parent = <&smmu>;
> >                  #address-cells = <3>;
> >                  #size-cells = <1>;
> >
> > --
> > 1.9.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> >
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infr
> adead.org%2Fmailman%2Flistinfo%2Flinux-arm-
> kernel&data=02%7C01%7Cnipun.gupta%40nxp.com%7Cf64b4fe9c5cf45ce8a9a
> 08d5847c6919%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636560
> 592302736942&sdata=iOwv%2Fzd8UTLm7YCapDOWzrtd48VQeYY2vlufck7eYZI
> %3D&reserved=0
