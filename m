From: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>
Subject: RE: RFC: extend iommu-map binding to support #iommu-cells > 1
Date: Fri, 16 Dec 2016 15:06:04 +0000
Message-ID: <VI1PR0401MB26386D2F42E6EB15B80993CD8D9C0@VI1PR0401MB2638.eurprd04.prod.outlook.com>
References: <VI1PR0401MB2638DE2D30F8423F6F8C7A6E8D9C0@VI1PR0401MB2638.eurprd04.prod.outlook.com>
	<AM5PR0401MB25455AE3850ED6E724B025EF9A9C0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <AM5PR0401MB25455AE3850ED6E724B025EF9A9C0-oQ3wXcTHOqrg6d/1FbYcvI3W/0Ik+aLCnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "robin.murphy-5wv7dgnIgG8@public.gmane.org" <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Bharat Bhushan
> Sent: Thursday, December 15, 2016 9:46 PM
> To: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>; Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>; robin.murphy-5wv7dgnIgG8@public.gmane.org;
> will.deacon-5wv7dgnIgG8@public.gmane.org
> Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>; Diana Madalina Craciun
> <diana.craciun-3arQi8VN3Tc@public.gmane.org>; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> Subject: RE: RFC: extend iommu-map binding to support #iommu-cells > 1
> 
> 
> 
> > -----Original Message-----
> > From: Stuart Yoder
> > Sent: Friday, December 16, 2016 8:07 AM
> > To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>; robin.murphy-5wv7dgnIgG8@public.gmane.org;
> > will.deacon-5wv7dgnIgG8@public.gmane.org
> > Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>;
> > Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>; Diana Madalina Craciun
> > <diana.craciun-3arQi8VN3Tc@public.gmane.org>; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> > foundation.org
> > Subject: RFC: extend iommu-map binding to support #iommu-cells > 1
> >
> > For context, please see the thread:
> > https://www.spinics.net/lists/arm-kernel/msg539066.html
> >
> > The existing iommu-map binding did not account for the situation where
> > #iommu-cells == 2, as permitted in the ARM SMMU binding.  The 2nd cell of
> > the IOMMU specifier being the SMR mask.  The existing binding defines the
> > mapping as:
> >    Any RID r in the interval [rid-base, rid-base + length) is associated with
> >    the listed IOMMU, with the iommu-specifier (r - rid-base + iommu-base).
> >
> > ...and that does not work if iommu-base is 2 cells, the second being the SMR
> > mask.
> >
> > While this can be worked around by always having length=1, it seems we can
> > get this cleaned up by updating the binding definition for iommu-map.
> >
> > See patch below.  Thoughts?
> >
> > Thanks,
> > Stuart
> >
> > -------------------------------------------------------------------------
> >
> > diff --git a/Documentation/devicetree/bindings/pci/pci-iommu.txt
> > b/Documentation/devicetree/bindings/pci/pci-iommu.txt
> > index 56c8296..e81b461 100644
> > --- a/Documentation/devicetree/bindings/pci/pci-iommu.txt
> > +++ b/Documentation/devicetree/bindings/pci/pci-iommu.txt
> > @@ -38,8 +38,20 @@ Optional properties
> >    The property is an arbitrary number of tuples of
> >    (rid-base,iommu,iommu-base,length).
> >
> > -  Any RID r in the interval [rid-base, rid-base + length) is associated with
> > -  the listed IOMMU, with the iommu-specifier (r - rid-base + iommu-base).
> > +  If the associated IOMMU has an #iommu-cells value of 1, any RID r in
> > + the  interval [rid-base, rid-base + length) is associated with the
> > + listed IOMMU,  with the iommu-specifier (r - rid-base + iommu-base).
> > +
> > +  ARM SMMU Note:
> > +    The ARM SMMU binding permits an #iommu-cells value of 2 and in this
> > +    case defines an IOMMU specifier to be: (stream-id,smr-mask)
> > +
> > +    In an iommu-map this means the iommu-base consists of 2 cells:
> > +        (rid-base,iommu,[stream-id,smr-mask],length).
> > +
> > +    In this case the RID to IOMMU specifier mapping is defined to be:
> > +    any RID r in the interval [rid-base, rid-base + length) is associated
> > +    with the listed IOMMU, with the iommu-specifier (r - rid-base + stream-
> > id).
> 
> Should not this be (r - rid-base + (stream-id & smr-mask)) ?

No, the SMR mask is not applied here-- that is programmed in the SMMU
hardware and not applied by software.  The SMR mask in the case of NXP
is 0x7C00, and so is the inverse of a typical mask of 1 bits.

If the map was defined as:  <0x0 &smmu 0x10 0x7c00 10>;

An RID value of 0x2 would get mapped to the 2-cell specifier: <0x12 0x7c00>

Stuart
