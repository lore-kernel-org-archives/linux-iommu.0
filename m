From: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [RFC PATCH] iommu/arm-smmu: Add global SMR masking property
Date: Fri, 3 Mar 2017 03:42:57 +0000
Message-ID: <AM5PR0401MB2514A195633CE5496E74A861E62B0@AM5PR0401MB2514.eurprd04.prod.outlook.com>
References: <ad6b6a4937b1fe183e6d48ccbaf4cb46db92fed4.1481893907.git.robin.murphy@arm.com>
	<DB6PR0402MB2694957C2D7C648CC342627FE69F0@DB6PR0402MB2694.eurprd04.prod.outlook.com>
	<AM5PR0401MB251438AFDE691D570353B537E6280@AM5PR0401MB2514.eurprd04.prod.outlook.com>
	<72610bd3-71b2-0b4b-eb6c-5e9df7ec1aac@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <72610bd3-71b2-0b4b-eb6c-5e9df7ec1aac-5wv7dgnIgG8@public.gmane.org>
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Cc: "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Thanks Robin,
This would be of great help.

Regards,
Nipun

> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy-5wv7dgnIgG8@public.gmane.org]
> Sent: Thursday, March 02, 2017 22:18
> To: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org; will.deacon-5wv7dgnIgG8@public.gmane.org; stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
> Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>
> Subject: Re: [RFC PATCH] iommu/arm-smmu: Add global SMR masking property
> 
> On 02/03/17 04:18, Nipun Gupta wrote:
> >
> > Hi Robin/Will,
> >
> > This patch is currently not applied on the tree.
> > I had verified the patch and it seems good.
> > Is ack required on the patch or do I need to send a non RFC patch (with Robin's
> signoff)?
> > This is very much required to support SMMU on NXP platform.
> 
> It's still sat in my "patches to do something with" queue - I don't
> think we ever reached a concrete decision on the property name for a DT
> maintainer ack, but I've tweaked the description per Will's comment;
> thanks for the reminder. I'll send an rc1-based version out next week to
> reboot the discussion.
> 
> Robin.
> 
> >
> > Thanks,
> > Nipun
> >
> >
> >> -----Original Message-----
> >> From: Nipun Gupta
> >> Sent: Sunday, December 18, 2016 2:37
> >> To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> >> foundation.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-
> >> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> >> Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org; will.deacon-5wv7dgnIgG8@public.gmane.org; Stuart Yoder
> >> <stuart.yoder-3arQi8VN3Tc@public.gmane.org>
> >> Subject: RE: [RFC PATCH] iommu/arm-smmu: Add global SMR masking
> property
> >>
> >>
> >>
> >>> -----Original Message-----
> >>> From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> >>> bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Robin Murphy
> >>> Sent: Friday, December 16, 2016 18:49
> >>> To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> >> arm-
> >>> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> >>> Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org; will.deacon-5wv7dgnIgG8@public.gmane.org; Stuart Yoder
> >>> <stuart.yoder-3arQi8VN3Tc@public.gmane.org>
> >>> Subject: [RFC PATCH] iommu/arm-smmu: Add global SMR masking property
> >>>
> >>> The current SMR masking support using a 2-cell iommu-specifier is
> >>> primarily intended to handle individual masters with large and/or
> >>> complex Stream ID assignments; it quickly gets a bit clunky in other SMR
> >>> use-cases where we just want to consistently mask out the same part of
> >>> every Stream ID (e.g. for MMU-500 configurations where the appended TBU
> >>> number gets in the way unnecessarily). Let's add a new property to allow
> >>> a single global mask value to better fit the latter situation.
> >>>
> >>> CC: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>
> >>
> >> Tested-by: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
> >>
> >>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> >>> ---
> >>>
> >>> Compile-tested only...
> >>>
> >>>  Documentation/devicetree/bindings/iommu/arm,smmu.txt | 8 ++++++++
> >>>  drivers/iommu/arm-smmu.c                             | 4 +++-
> >>>  2 files changed, 11 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> >>> b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> >>> index e862d1485205..98f5cbe5fdb4 100644
> >>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> >>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> >>> @@ -60,6 +60,14 @@ conditions.
> >>>                    aliases of secure registers have to be used during
> >>>                    SMMU configuration.
> >>>
> >>> +- stream-match-mask : Specifies a fixed SMR mask value to combine with
> >>> +                  the Stream ID value from every iommu-specifier. This
> >>> +                  may be used instead of an "#iommu-cells" value of 2
> >>> +                  when there is no need for per-master SMR masks, but
> >>> +                  it is still desired to mask some portion of every
> >>> +                  Stream ID (e.g. for certain MMU-500 configurations
> >>> +                  given globally unique external IDs).
> >>> +
> >>>  ** Deprecated properties:
> >>>
> >>>  - mmu-masters (deprecated in favour of the generic "iommus" binding) :
> >>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> >>> index 8f7281444551..f1abcb7dde36 100644
> >>> --- a/drivers/iommu/arm-smmu.c
> >>> +++ b/drivers/iommu/arm-smmu.c
> >>> @@ -1534,13 +1534,15 @@ static int arm_smmu_domain_set_attr(struct
> >>> iommu_domain *domain,
> >>>
> >>>  static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args
> >> *args)
> >>>  {
> >>> -	u32 fwid = 0;
> >>> +	u32 mask, fwid = 0;
> >>>
> >>>  	if (args->args_count > 0)
> >>>  		fwid |= (u16)args->args[0];
> >>>
> >>>  	if (args->args_count > 1)
> >>>  		fwid |= (u16)args->args[1] << SMR_MASK_SHIFT;
> >>> +	else if (!of_property_read_u32(args->np, "stream-match-mask",
> >>> &mask))
> >>> +		fwid |= (u16)mask << SMR_MASK_SHIFT;
> >>>
> >>>  	return iommu_fwspec_add_ids(dev, &fwid, 1);
> >>>  }
> >>> --
> >>> 2.10.2.dirty
> >>>
> >>> _______________________________________________
> >>> iommu mailing list
> >>> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> >>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
