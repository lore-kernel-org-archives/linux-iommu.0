From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH v7 3/5] iommu/of: Add msi address regions reservation
 helper
Date: Fri, 22 Sep 2017 15:37:52 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8384142E1@FRAEML521-MBX.china.huawei.com>
References: <20170914125756.14836-1-shameerali.kolothum.thodi@huawei.com>
 <20170914125756.14836-4-shameerali.kolothum.thodi@huawei.com>
 <20170922142758.GE3475@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170922142758.GE3475@red-moon>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Guohanjun
 (Hanjun Guo)" <guohanjun@huawei.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, John Garry <john.garry@huawei.com>, "will.deacon@arm.com" <will.deacon@arm.com>, Linuxarm <linuxarm@huawei.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devel@acpica.org" <devel@acpica.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com]
> Sent: Friday, September 22, 2017 3:28 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: marc.zyngier@arm.com; sudeep.holla@arm.com; will.deacon@arm.com;
> robin.murphy@arm.com; joro@8bytes.org; mark.rutland@arm.com;
> hanjun.guo@linaro.org; Gabriele Paoloni <gabriele.paoloni@huawei.com>;
> John Garry <john.garry@huawei.com>; iommu@lists.linux-foundation.org;
> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> devicetree@vger.kernel.org; devel@acpica.org; Linuxarm
> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
> Guohanjun (Hanjun Guo) <guohanjun@huawei.com>
> Subject: Re: [PATCH v7 3/5] iommu/of: Add msi address regions reservation
> helper
> 
> John, Shameer,
> 
> On Thu, Sep 14, 2017 at 01:57:54PM +0100, Shameer Kolothum wrote:
> > From: John Garry <john.garry@huawei.com>
> >
> > On some platforms msi-controller address regions have to be excluded
> > from normal IOVA allocation in that they are detected and decoded in
> > a HW specific way by system components and so they cannot be
> considered
> > normal IOVA address space.
> >
> > Add a helper function that retrieves msi address regions through device
> > tree msi mapping, so that these regions will not be translated by IOMMU
> > and will be excluded from IOVA allocations.
> >
> > Signed-off-by: John Garry <john.garry@huawei.com>
> > Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi@huawei.com>
> > ---
> >  drivers/iommu/of_iommu.c | 117
> +++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/of_iommu.h |  10 ++++
> >  2 files changed, 127 insertions(+)
> >
> > diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> > index 8cb6082..f2d1a76 100644
> > --- a/drivers/iommu/of_iommu.c
> > +++ b/drivers/iommu/of_iommu.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/iommu.h>
> >  #include <linux/limits.h>
> >  #include <linux/of.h>
> > +#include <linux/of_address.h>
> >  #include <linux/of_iommu.h>
> >  #include <linux/of_pci.h>
> >  #include <linux/slab.h>
> > @@ -246,6 +247,122 @@ const struct iommu_ops
> *of_iommu_configure(struct device *dev,
> >  	return ops;
> >  }
> >
> > +/**
> > + * of_iommu_msi_get_resv_regions - Reserved region driver helper
> > + * @dev: Device from iommu_get_resv_regions()
> > + * @list: Reserved region list from iommu_get_resv_regions()
> > + *
> > + * Returns: Number of reserved regions on success (0 if no associated
> > + *          msi parent), appropriate error value otherwise.
> > + */
> > +int of_iommu_msi_get_resv_regions(struct device *dev, struct list_head
> *head)
> > +{
> > +	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> > +	struct iommu_resv_region *region;
> > +	struct device_node *np;
> > +	struct resource res;
> > +	int i, resv = 0, mappings = 0;
> > +
> > +	if (dev_is_pci(dev)) {
> > +		struct device *dma_dev, *bridge;
> > +		struct of_phandle_args iommu_spec;
> > +		struct pci_dev *pdev = to_pci_dev(dev);
> > +		int err, count;
> > +		u32 rid, map_mask;
> > +		const __be32 *msi_map;
> > +
> > +		bridge = pci_get_host_bridge_device(pdev);
> > +		dma_dev = bridge->parent;
> > +		pci_put_host_bridge_device(bridge);
> > +
> > +		if (!dma_dev->of_node)
> > +			return -ENODEV;
> > +
> > +		iommu_spec.args_count = 1;
> > +		np = iommu_spec.np = dma_dev->of_node;
> > +		pci_for_each_dma_alias(pdev, __get_pci_rid,
> &iommu_spec);
> > +
> > +		rid = iommu_spec.args[0];
> > +		if (!of_property_read_u32(np, "msi-map-mask",
> &map_mask))
> > +			rid &= map_mask;
> > +
> > +		msi_map = of_get_property(np, "msi-map", NULL);
> > +		if (!msi_map)
> > +			return -ENODEV;
> > +
> > +		mappings = of_count_phandle_with_args(np, "msi-map",
> NULL) / 4;
> > +
> > +		for (i = 0, count = mappings; i < count; i++, msi_map += 4) {
> > +			struct device_node *msi_node;
> > +			u32 rid_base, rid_len, phandle;
> > +
> > +			rid_base = be32_to_cpup(msi_map + 0);
> > +			phandle = be32_to_cpup(msi_map + 1);
> > +			rid_len = be32_to_cpup(msi_map + 3);
> > +
> > +			/* check rid is within range */
> > +			if (rid < rid_base || rid >= rid_base + rid_len) {
> > +				mappings--;
> > +				continue;
> > +			}
> > +
> > +			msi_node = of_find_node_by_phandle(phandle);
> > +			if (!msi_node)
> > +				return -ENODEV;
> 
> This is basically of_pci_map_rid(), I wonder whether there is not
> a way to consolidate some code here - duplicating certainly does not
> help. To make MSI reservations generic this is probably the only way
> to do it but it would be nice to reuse some OF MSI code.
> 
> With the current kernel API there is a way but it is a bit whacky.
> 
> Just loop over "msi-controller" nodes and try to map the device to
> them through of_pci_map_rid, if mapping succeeds reserve region for
> the target node.
> 
> Not a big fan of what I am proposing but it certainly helps reuse
> some existing code that makes no sense to duplicate.

Right, lot of this is of_pci_map_rid() code. And just to confirm, 
I think the proposal  is to make use of the @target node param in 
of_pci_map_rid() for a matching "msi-controller".

> > +			err = of_address_to_resource(msi_node, 0, &res);
> > +			of_node_put(msi_node);
> > +			if (err)
> > +				return err;
> > +
> > +			region = iommu_alloc_resv_region(res.start,
> > +							 resource_size(&res),
> > +							 prot,
> IOMMU_RESV_MSI);
> > +			if (region) {
> > +				list_add_tail(&region->list, head);
> > +				resv++;
> > +			}
> > +		}
> > +	} else if (dev->of_node) {
> > +		struct device_node *msi_np;
> > +		int index = 0;
> > +		int tuples;
> > +
> > +		np = dev->of_node;
> > +
> > +		tuples = of_count_phandle_with_args(np, "msi-parent",
> NULL);
> > +
> > +		while (index < tuples) {
> 
> Would not be easier to have an of_parse_phandle_with_args() loop here ?

Ok. Many thanks for going through this. We will rework this based on your
suggestions and send out the next revision (rebased on -rc1).

Thanks,
Shameer
