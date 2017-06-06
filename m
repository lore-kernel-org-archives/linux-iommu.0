From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: RE: [RFCv2 1/2] acpi:iort: Add new helper function to retrieve ITS
	base addr from dev IORT node
Date: Tue, 6 Jun 2017 15:17:20 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838362112@FRAEML521-MBX.china.huawei.com>
References: <20170531143213.82100-1-shameerali.kolothum.thodi@huawei.com>
	<20170531143213.82100-2-shameerali.kolothum.thodi@huawei.com>
	<20170606141019.GC20126@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170606141019.GC20126@red-moon>
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
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: "Guohanjun (Hanjun Guo)" <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "marc.zyngier-5wv7dgnIgG8@public.gmane.org" <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Wangzhou (B)" <wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "sudeep.holla-5wv7dgnIgG8@public.gmane.org" <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org" <devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org]
> Sent: Tuesday, June 06, 2017 3:10 PM
> To: Shameerali Kolothum Thodi
> Cc: marc.zyngier-5wv7dgnIgG8@public.gmane.org; sudeep.holla-5wv7dgnIgG8@public.gmane.org; will.deacon-5wv7dgnIgG8@public.gmane.org;
> robin.murphy-5wv7dgnIgG8@public.gmane.org; hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; Gabriele Paoloni; John
> Garry; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-arm-
> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org;
> Linuxarm; Wangzhou (B); Guohanjun (Hanjun Guo)
> Subject: Re: [RFCv2 1/2] acpi:iort: Add new helper function to retrieve ITS
> base addr from dev IORT node
> 
> On Wed, May 31, 2017 at 03:32:12PM +0100, shameer wrote:
> > This provides a helper function to find and retrieve the ITS base
> > address from the ID mappings array reference of a device IORT node(if
> > any).
> >
> > This is used in the subsequent patch to retrieve the ITS base address
> > associated with a pci dev IORT node.
> 
> "Add an IORT helper function to retrieve the ITS data through IORT device<-
> >ITS mappings".
> 
> > Signed-off-by: shameer <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/acpi/arm64/iort.c        | 47
> +++++++++++++++++++++++++++++++++++++---
> >  drivers/irqchip/irq-gic-v3-its.c |  3 ++-
> >  include/linux/acpi_iort.h        |  8 ++++++-
> >  3 files changed, 53 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index c5fecf9..12d7347 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -34,6 +34,7 @@
> >  struct iort_its_msi_chip {
> >  	struct list_head	list;
> >  	struct fwnode_handle	*fw_node;
> > +	u64			base_addr;
> 
> phys_addr_t
> 
> >  	u32			translation_id;
> >  };
> >
> > @@ -132,13 +133,14 @@ typedef acpi_status (*iort_find_node_callback)
> >
> >  /**
> >   * iort_register_domain_token() - register domain token and related
> > ITS ID
> > - * to the list from where we can get it back later on.
> > + * and base address to the list from where we can get it back later on.
> >   * @trans_id: ITS ID.
> 
> Missing something here
> 
> >   * @fw_node: Domain token.
> >   *
> >   * Returns: 0 on success, -ENOMEM if no memory when allocating list
> element
> >   */
> > -int iort_register_domain_token(int trans_id, struct fwnode_handle
> > *fw_node)
> > +int iort_register_domain_token(int trans_id, u64 base,
> 
> phys_addr_t
> 
> > +			       struct fwnode_handle *fw_node)
> >  {
> >  	struct iort_its_msi_chip *its_msi_chip;
> >
> > @@ -148,6 +150,7 @@ int iort_register_domain_token(int trans_id,
> > struct fwnode_handle *fw_node)
> >
> >  	its_msi_chip->fw_node = fw_node;
> >  	its_msi_chip->translation_id = trans_id;
> > +	its_msi_chip->base_addr = base;
> >
> >  	spin_lock(&iort_msi_chip_lock);
> >  	list_add(&its_msi_chip->list, &iort_msi_chip_list); @@ -370,7 +373,6
> > @@ static struct acpi_iort_node *iort_node_map_id(struct
> > acpi_iort_node *node,
> >
> >  		if (!node->mapping_offset || !node->mapping_count)
> >  			goto fail_map;
> > -
> 
> Unrelated change.
> 
> >  		map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
> >  				   node->mapping_offset);
> >
> > @@ -491,6 +493,45 @@ int iort_pmsi_get_dev_id(struct device *dev, u32
> *dev_id)
> >  	return -ENODEV;
> >  }
> >
> > +int iort_dev_find_its_base(struct device *dev, u32 req_id,
> > +			   unsigned int idx, u64 *its_base) {
> > +	struct acpi_iort_its_group *its;
> > +	struct acpi_iort_node *node;
> > +	struct iort_its_msi_chip *its_msi_chip;
> > +	u32  trans_id;
> > +
> > +	node = iort_find_dev_node(dev);
> > +	if (!node)
> > +		return -ENXIO;
> 
> -ENODEV, throughout

Ok. The reason for -ENXIO use is that this function is based on the existing
iort_dev_find_its_id() and it returns -ENXIO for those error cases.

I will incorporate all the other comments in the next revision.

Many thanks,
Shameer
 
