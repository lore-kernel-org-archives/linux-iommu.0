From: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 12/14] drivers: acpi: iort: replace rid map type with
	type mask
Date: Tue, 13 Sep 2016 16:26:12 +0800
Message-ID: <1dee1475-79e1-257a-1ebd-d1a9ac033ca4@linaro.org>
References: <20160909142343.13314-1-lorenzo.pieralisi@arm.com>
	<20160909142343.13314-13-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160909142343.13314-13-lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dennis Chen <dennis.chen-5wv7dgnIgG8@public.gmane.org>, Prem Mallappa <prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Lorenzo,

On 2016/9/9 22:23, Lorenzo Pieralisi wrote:
> IORT tables provide data that allow the kernel to carry out
> device ID mappings between endpoints and system components
> (eg interrupt controllers, IOMMUs). When the mapping for a
> given device ID is carried out, the translation mechanism
> is done on a per-subsystem basis rather than a component
> subtype (ie the IOMMU kernel layer will look for mappings
> from a device to all IORT node types corresponding to IOMMU
> components), therefore the corresponding mapping API should
> work on a range (ie mask) of IORT node types corresponding
> to a common set of components (eg IOMMUs) rather than a
> specific node type.
>
> Upgrade the IORT iort_node_map_rid() API to work with a
> type mask instead of a single node type so that it can
> be used for mappings that span multiple components types
> (ie IOMMUs).
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
> Cc: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
> Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
> ---
>  drivers/acpi/arm64/iort.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index a12dda9..36ea93e 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -25,6 +25,9 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>
> +#define IORT_TYPE_MASK(type)	(1 << (type))
> +#define IORT_MSI_TYPE		(1 << ACPI_IORT_NODE_ITS_GROUP)
> +
>  struct iort_its_msi_chip {
>  	struct list_head	list;
>  	struct fwnode_handle	*fw_node;
> @@ -283,7 +286,7 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
>
>  static struct acpi_iort_node *iort_node_map_rid(struct acpi_iort_node *node,
>  						u32 rid_in, u32 *rid_out,
> -						u8 type)
> +						u8 type_mask)
>  {
>  	u32 rid = rid_in;
>
> @@ -292,7 +295,7 @@ static struct acpi_iort_node *iort_node_map_rid(struct acpi_iort_node *node,
>  		struct acpi_iort_id_mapping *map;
>  		int i;
>
> -		if (node->type == type) {
> +		if (IORT_TYPE_MASK(node->type) & type_mask) {
>  			if (rid_out)
>  				*rid_out = rid;
>  			return node;
> @@ -365,7 +368,7 @@ u32 iort_msi_map_rid(struct device *dev, u32 req_id)
>  	if (!node)
>  		return req_id;
>
> -	iort_node_map_rid(node, req_id, &dev_id, ACPI_IORT_NODE_ITS_GROUP);
> +	iort_node_map_rid(node, req_id, &dev_id, IORT_MSI_TYPE);
>  	return dev_id;
>  }

I think you forgot to update another function which is ok in your v4
patch set:

@@ -411,7 +414,7 @@ iort_dev_find_its_id(struct device *dev, u32 req_id, 
unsigned int idx,
  		return -ENXIO;
  	}

-	node = iort_node_map_rid(node, req_id, NULL, ACPI_IORT_NODE_ITS_GROUP);
+	node = iort_node_map_rid(node, req_id, NULL, IORT_MSI_TYPE);
  	if (!node) {
  		dev_err(dev, "can't find related ITS node\n");
  		return -ENXIO;

Others are look good to me.

Thanks
Hanjun
