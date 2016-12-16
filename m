From: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>
Subject: RE: RFC: extend iommu-map binding to support #iommu-cells > 1
Date: Fri, 16 Dec 2016 17:05:43 +0000
Message-ID: <VI1PR0401MB26382DB9B60A7A4C1BD21BCD8D9C0@VI1PR0401MB2638.eurprd04.prod.outlook.com>
References: <VI1PR0401MB2638DE2D30F8423F6F8C7A6E8D9C0@VI1PR0401MB2638.eurprd04.prod.outlook.com>
	<20161216113914.GC20265@leverpostej>
	<VI1PR0401MB26387C2712FC4BF74B4B96028D9C0@VI1PR0401MB2638.eurprd04.prod.outlook.com>
	<07c70fde-2bce-a517-0f5f-a2405049c87c@arm.com>
	<VI1PR0401MB2638870C58173D5906AE0D9E8D9C0@VI1PR0401MB2638.eurprd04.prod.outlook.com>
	<41edab27-c73a-7a1a-4369-fb43d7f57f78@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <41edab27-c73a-7a1a-4369-fb43d7f57f78-5wv7dgnIgG8@public.gmane.org>
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy-5wv7dgnIgG8@public.gmane.org]
> Sent: Friday, December 16, 2016 10:50 AM
> To: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>; Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> Cc: will.deacon-5wv7dgnIgG8@public.gmane.org; robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>; Nipun Gupta
> <nipun.gupta-3arQi8VN3Tc@public.gmane.org>; Diana Madalina Craciun <diana.craciun-3arQi8VN3Tc@public.gmane.org>; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> Subject: Re: RFC: extend iommu-map binding to support #iommu-cells > 1
> 
> On 16/12/16 15:56, Stuart Yoder wrote:
> >>>>> The existing iommu-map binding did not account for the situation where
> >>>>> #iommu-cells == 2, as permitted in the ARM SMMU binding.  The 2nd cell
> >>>>> of the IOMMU specifier being the SMR mask.  The existing binding defines
> >>>>> the mapping as:
> >>>>>    Any RID r in the interval [rid-base, rid-base + length) is associated with
> >>>>>    the listed IOMMU, with the iommu-specifier (r - rid-base + iommu-base).
> >>>>>
> >>>>> ...and that does not work if iommu-base is 2 cells, the second being the
> >>>>> SMR mask.
> >>>>>
> >>>>> While this can be worked around by always having length=1, it seems we
> >>>>> can get this cleaned up by updating the binding definition for iommu-map.
> >>>>
> >>>> To reiterate, I'm very much not keen on the pci-iommu binding having
> >>>> knowledge of the decomposition of iommu-specifiers from other bindings.
> >>>
> >>> With the current definition of iommu-map we already have baked in an
> >>> assumption that an iommu-specifier is a value that can be incremented
> >>> by 1 to get to the next sequential specifier.  So the binding already
> >>> has "knowledge" that applies in most, but not all cases.
> >>>
> >>> The generic iommu binding also defines a case where #iommu-cells=4
> >>> for some IOMMUs.
> >>>
> >>> Since the ARM SMMU is a special case, perhaps the intepretation
> >>> of an iommu-specifier in the context of iommu-map should be moved
> >>> into the SMMU binding.
> >>>
> >>>> As mentioned previously, there's an intended interpretation [1] that we
> >>>> need to fix up the pci-iommu binding with. With that, I don't think it's
> >>>> even necessary to bodge iommu-cells = <1> AFAICT.
> >>>
> >>> You had said in the previous thread:
> >>>
> >>>   > I had intended that the offset was added to the final cell of the
> >>>   > iommu-specifier (i.e. that the iommu-specifier was treated as a large
> >>>   > number).
> >>>
> >>>   > You can handle this case by adding additional entries in the map table,
> >>>   > with a single entry length.
> >>>
> >>> I understand that, and it works, but I don't see why the definition has
> >>> to be that the offset is added to the "final cell".
> >>
> >> Because the cells of a specifier form a single opaque big-endian value.
> >> Were DT little-endian it would be the "first cell". To be pedantic, both
> >> of those descriptions are technically wrong because they fail to account
> >> for overflow and carry up into the next cell (in whichever direction).
> >
> > If it is really opaque how can we reliably add 1 to it?
> 
> The pci-iommu binding isn't adding 1 to an opaque value. It is
> *generating* an IOMMU specifier of the form of a single numeric value,
> as defined by some linear translation of a PCI RID relative to a numeric
> base value appropriate for the IOMMU topology. It is explicit therein
> that a single numeric value must be the appropriate interpretation of
> that specifier. That happens to be true of a 1-cell arm-smmu specifier,
> therefore iommu-map can be used with arm-smmu with #iommu-cells=1. It is
> also true of a 2-cell some-other-iommu specifier, therefore iommu-map
> can be used with some-other-iommu with #iommu-cells=2 (if we fix the
> fact that the current implementation fails to consider more than one
> cell). It is not, however, true of a 2-cell arm-smmu specifier,
> therefore iommu-map cannot be used with arm-smmu with #iommu-cells=2,
> although the fact that of_pci_iommu_configure() unconditionally
> generates a 1-cell specifier at the moment does happen to sidestep that.
> 
> The point of the 2-cell arm-smmu specifier is really to handle the
> devices (which exist) with dozens or hundreds of stream IDs, which are
> *only* usable via SMR masking, and particularly with a hand-crafted mask
> that is able to assume the non-existence of overlapping IDs (that aspect
> being actually quite significant for optimal allocation - one of the
> reasons my automatic-mask-generation prototype is now gathering dust).
> 
> The MMU-500 TBU use-case is really an entirely different kettle of fish,
> hence the RFC I posted earlier.

I had not seen your RFC when I replied previously...the global SMR mask
is actually much preferred and more straightforward.  We will test it.

Thanks,
Stuart
