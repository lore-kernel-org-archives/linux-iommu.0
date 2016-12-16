From: Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>
Subject: RE: RFC: extend iommu-map binding to support #iommu-cells > 1
Date: Fri, 16 Dec 2016 15:07:44 +0000
Message-ID: <AM5PR0401MB2545FEFDCB1A6F42180417D89A9C0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <VI1PR0401MB2638DE2D30F8423F6F8C7A6E8D9C0@VI1PR0401MB2638.eurprd04.prod.outlook.com>
	<20161216113914.GC20265@leverpostej>
	<VI1PR0401MB26387C2712FC4BF74B4B96028D9C0@VI1PR0401MB2638.eurprd04.prod.outlook.com>
	<07c70fde-2bce-a517-0f5f-a2405049c87c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <07c70fde-2bce-a517-0f5f-a2405049c87c-5wv7dgnIgG8@public.gmane.org>
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy-5wv7dgnIgG8@public.gmane.org]
> Sent: Friday, December 16, 2016 8:21 PM
> To: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>; Mark Rutland
> <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> Cc: will.deacon-5wv7dgnIgG8@public.gmane.org; robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; Bharat Bhushan
> <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>; Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>; Diana
> Madalina Craciun <diana.craciun-3arQi8VN3Tc@public.gmane.org>; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> Subject: Re: RFC: extend iommu-map binding to support #iommu-cells > 1
> 
> On 16/12/16 14:21, Stuart Yoder wrote:
> >
> >
> >> -----Original Message-----
> >> From: Mark Rutland [mailto:mark.rutland-5wv7dgnIgG8@public.gmane.org]
> >> Sent: Friday, December 16, 2016 5:39 AM
> >> To: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>
> >> Cc: robin.murphy-5wv7dgnIgG8@public.gmane.org; will.deacon-5wv7dgnIgG8@public.gmane.org;
> robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org;
> >> Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>; Nipun Gupta
> >> <nipun.gupta-3arQi8VN3Tc@public.gmane.org>; Diana Madalina Craciun
> >> <diana.craciun-3arQi8VN3Tc@public.gmane.org>; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> >> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> >> Subject: Re: RFC: extend iommu-map binding to support #iommu-cells >
> >> 1
> >>
> >> On Fri, Dec 16, 2016 at 02:36:57AM +0000, Stuart Yoder wrote:
> >>> For context, please see the thread:
> >>>
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fw
> >>> ww.spinics.net%2Flists%2Farm-
> >>
> kernel%2Fmsg539066.html&data=01%7C01%7Cstuart.yoder%40nxp.com%7C
> 0464e
> >> 12bddfd42e0f0a508d425a847cb%7C686ea
> >>
> 1d3bc2b4c6fa92cd99c5c301635%7C0&sdata=KnzeOlbts271GwD1cpx2FLMsKn
> xw%2F
> >> OdiGVTp6%2BKFrbM%3D&reserved=0
> >>>
> >>> The existing iommu-map binding did not account for the situation
> >>> where #iommu-cells == 2, as permitted in the ARM SMMU binding.  The
> >>> 2nd cell of the IOMMU specifier being the SMR mask.  The existing
> >>> binding defines the mapping as:
> >>>    Any RID r in the interval [rid-base, rid-base + length) is associated with
> >>>    the listed IOMMU, with the iommu-specifier (r - rid-base + iommu-
> base).
> >>>
> >>> ...and that does not work if iommu-base is 2 cells, the second being
> >>> the SMR mask.
> >>>
> >>> While this can be worked around by always having length=1, it seems
> >>> we can get this cleaned up by updating the binding definition for iommu-
> map.
> >>
> >> To reiterate, I'm very much not keen on the pci-iommu binding having
> >> knowledge of the decomposition of iommu-specifiers from other
> bindings.
> >
> > With the current definition of iommu-map we already have baked in an
> > assumption that an iommu-specifier is a value that can be incremented
> > by 1 to get to the next sequential specifier.  So the binding already
> > has "knowledge" that applies in most, but not all cases.
> >
> > The generic iommu binding also defines a case where #iommu-cells=4 for
> > some IOMMUs.
> >
> > Since the ARM SMMU is a special case, perhaps the intepretation of an
> > iommu-specifier in the context of iommu-map should be moved into the
> > SMMU binding.
> >
> >> As mentioned previously, there's an intended interpretation [1] that
> >> we need to fix up the pci-iommu binding with. With that, I don't
> >> think it's even necessary to bodge iommu-cells = <1> AFAICT.
> >
> > You had said in the previous thread:
> >
> >   > I had intended that the offset was added to the final cell of the
> >   > iommu-specifier (i.e. that the iommu-specifier was treated as a large
> >   > number).
> >
> >   > You can handle this case by adding additional entries in the map table,
> >   > with a single entry length.
> >
> > I understand that, and it works, but I don't see why the definition
> > has to be that the offset is added to the "final cell".
> 
> Because the cells of a specifier form a single opaque big-endian value.
> Were DT little-endian it would be the "first cell". To be pedantic, both of
> those descriptions are technically wrong because they fail to account for
> overflow and carry up into the next cell (in whichever direction).
> 
> >  Why can't it be
> > an iommu specific definition that makes sense for a given IOMMU?
> 
> Because the implementation would then become a nightmarish rabbit-
> warren of special-cases, largely defeating the point of a *generic* binding. At
> the very least it'd have to chase every phandle and determine its compatible
> just to work out what to do with any given specifier - merely thinking about
> the complexity of the error handling for the number of additional failure
> modes that introduces is enough to put me off.

Currently if iommu-cells = 2 then SMMU treats the 2 cells as stream-id  + stream-id mask. While DT binding is silent on how 2 cells, which means that actually stream-id could be more than 32bit, but SMMU uses it in the way it wants to, which is not correct. If we be more explicit on defining the meaning of two cells than it will avoid confusion and implementation will match the DT binding definition. 

Thanks
-Bharat

> 
> Robin.
> 
> >
> > Stuart
> >
