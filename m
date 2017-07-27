From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH v4 1/2] acpi:iort: Add an IORT helper function to
	reserve HW ITS address regions for IOMMU drivers
Date: Thu, 27 Jul 2017 13:26:14 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8383C04A2@FRAEML521-MBX.china.huawei.com>
References: <20170725111732.41792-1-shameerali.kolothum.thodi@huawei.com>
	<20170725111732.41792-2-shameerali.kolothum.thodi@huawei.com>
	<20170725171100.GA1663@red-moon>
	<b7512f89-4fe7-940e-0fa9-9274d8b1e935@arm.com>
	<20170726095208.GA2468@red-moon>
	<5FC3163CFD30C246ABAA99954A238FA8383C0268@FRAEML521-MBX.china.huawei.com>
	<989fec76-45e7-d744-3411-78ec2764cb7d@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <989fec76-45e7-d744-3411-78ec2764cb7d-5wv7dgnIgG8@public.gmane.org>
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: "sudeep.holla-5wv7dgnIgG8@public.gmane.org" <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "marc.zyngier-5wv7dgnIgG8@public.gmane.org" <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Wangzhou (B)" <wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "Guohanjun (Hanjun Guo)" <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org" <devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy-5wv7dgnIgG8@public.gmane.org]
> Sent: Thursday, July 27, 2017 12:13 PM
> To: Shameerali Kolothum Thodi; Lorenzo Pieralisi
> Cc: Guohanjun (Hanjun Guo); Gabriele Paoloni; marc.zyngier-5wv7dgnIgG8@public.gmane.org;
> John Garry; will.deacon-5wv7dgnIgG8@public.gmane.org; Linuxarm; linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; Wangzhou (B);
> sudeep.holla-5wv7dgnIgG8@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org;
> devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org
> Subject: Re: [PATCH v4 1/2] acpi:iort: Add an IORT helper function to reserve
> HW ITS address regions for IOMMU drivers
> 
[...]

> >>>> I can make these changes but I suspect this series will go via IOMMU
> >>>> tree, let me know how you want to handle it.
> >>>>
> >>>> Lorenzo
> >>>>
> >>>>> +	node = iort_find_dev_node(dev);
> >>>>> +	if (!node)
> >>>>> +		return -ENODEV;
> >>>>> +
> >>>
> >>> I'd suggest we also want a comment here to clarify that we're currently
> >>> assuming straightforward topologies where all mappings for a given root
> >>> complex/named component target the same ITS group. Otherwise
> we're
> >> going
> >>> to need somewhat more logic to iterate the its_node processing over
> >>> every mapping (or every alias in the PCI case), but avoid creating
> >>> duplicate entries.
> >>
> >> You have a point and we have time to update the code. Short of reserving
> >> all ITS regions for every device that maps to one at least, we could (even
> >> pre-compute instead of looking it up on the fly) create a list of ITS
> >> identifiers a given IORT node may map to and use that to reserve the
> >> regions.
> >
> > I am trying to understand the use case scenario discussed here. Apologies
> > if it is a dumb query.
> >
> > My understanding is that, it is possible to have a PCI  RC iort node mapped
> to
> > multiple ITS group nodes.  That is perfectly fine and given a dev input RID
> we
> > can identify the ITS group the device points to using - iort_node_map_id().
> >
> > But the above discussion seems to suggest that there might be situations
> where
> > we have to go through all the mapped ITS groups and identify all the ITSs
> associated
> > with the RC.  Clearly I am missing something.
> 
> I was mostly thinking of a situation like this:
> 
> +----Node 0-----+  +----Node 1-----+
> |  [CPU 0..n]   |  |  [CPU n+1..]  |
> | [ITS group 0] |  | [ITS group 1] |
> +---------------+  +---------------+
>         ^                  ^
>          \_______  _______/
>                  \/
>             +--Node 2--+
>             |  [SMMU]  |
>             |     ^    |
>             |     |    |
>             | [Device] |
>             +----------+
> 
> where the (named component) device has IDs for both ITS groups (to help
> optimise affining, or allow physically hotplugging CPU nodes, or
> whatever - I'm hypothesising here ;)).  A generic IORT function isn't in
> a position to decide *which* ITS region the device may be targeting at
> any given time, so can only correctly describe both.

Thanks Robin. That makes it clear.
 
> I'm perfectly happy not to even try to support such crazy configurations
> until they actually exist, if ever; I'd just prefer to document whatever
> assumptions we do make, so that we don't have to remember or re-derive
> them when looking at the code in future.

So I think the conclusion here is we will document the assumption that we are
only taking care of the straightforward topologies for now.

Hi Lorenzo,
If you are ok with the above, please let me know if it make sense to send out
a v5 with this and your other comments or you can take care of them. I am fine
either way.

Many thanks,
Shameer
