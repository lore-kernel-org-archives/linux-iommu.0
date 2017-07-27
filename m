From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v4 1/2] acpi:iort: Add an IORT helper function to reserve
 HW ITS address regions for IOMMU drivers
Date: Thu, 27 Jul 2017 11:12:55 +0100
Message-ID: <20170727101255.GA15067@red-moon>
References: <20170725111732.41792-1-shameerali.kolothum.thodi@huawei.com>
 <20170725111732.41792-2-shameerali.kolothum.thodi@huawei.com>
 <20170725171100.GA1663@red-moon>
 <b7512f89-4fe7-940e-0fa9-9274d8b1e935@arm.com>
 <20170726095208.GA2468@red-moon>
 <5FC3163CFD30C246ABAA99954A238FA8383C0268@FRAEML521-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA8383C0268@FRAEML521-MBX.china.huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Robin Murphy <robin.murphy@arm.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, John Garry <john.garry@huawei.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 27, 2017 at 09:13:42AM +0000, Shameerali Kolothum Thodi wrote:

[...]

> > > >> +int iort_iommu_its_get_resv_regions(struct device *dev, struct
> > list_head *head)
> > > >> +{
> > > >> +	int i;
> > > >> +	struct acpi_iort_its_group *its;
> > > >> +	struct acpi_iort_node *node, *its_node = NULL;
> > > >> +	int resv = 0;
> > > >
> > > > Nit: int i, resv = 0;
> > > >
> > > > I can make these changes but I suspect this series will go via IOMMU
> > > > tree, let me know how you want to handle it.
> > > >
> > > > Lorenzo
> > > >
> > > >> +	node = iort_find_dev_node(dev);
> > > >> +	if (!node)
> > > >> +		return -ENODEV;
> > > >> +
> > >
> > > I'd suggest we also want a comment here to clarify that we're currently
> > > assuming straightforward topologies where all mappings for a given root
> > > complex/named component target the same ITS group. Otherwise we're
> > going
> > > to need somewhat more logic to iterate the its_node processing over
> > > every mapping (or every alias in the PCI case), but avoid creating
> > > duplicate entries.
> > 
> > You have a point and we have time to update the code. Short of reserving
> > all ITS regions for every device that maps to one at least, we could (even
> > pre-compute instead of looking it up on the fly) create a list of ITS
> > identifiers a given IORT node may map to and use that to reserve the
> > regions.
> 
> I am trying to understand the use case scenario discussed here.
> Apologies if it is a dumb query. 
> 
> My understanding is that, it is possible to have a PCI  RC iort node
> mapped to multiple ITS group nodes.  That is perfectly fine and given
> a dev input RID we can identify the ITS group the device points to
> using - iort_node_map_id().
> 
> But the above discussion seems to suggest that there might be
> situations where we have to go through all the mapped ITS groups and
> identify all the ITSs associated with the RC.  Clearly I am missing
> something.

I reckon Robin was referring to this:

https://patchwork.kernel.org/patch/9757911/

Does this help ?

Thanks,
Lorenzo
