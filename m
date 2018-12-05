From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/9] ACPI/IORT: Use helper functions to access
 dev->iommu_fwspec
Date: Wed, 5 Dec 2018 17:50:23 +0000
Message-ID: <ecfaa990-9257-0592-ee4d-ca3f8537783d@arm.com>
References: <20181204163002.15800-1-joro@8bytes.org>
 <20181204163002.15800-3-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204163002.15800-3-joro@8bytes.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
Cc: Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 04/12/2018 16:29, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Use the new helpers dev_iommu_fwspec_get()/set() to access
> the dev->iommu_fwspec pointer. This makes it easier to move
> that pointer later into another struct.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   drivers/acpi/arm64/iort.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 70f4e80b9246..754a67ba49e5 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -779,7 +779,7 @@ static inline bool iort_iommu_driver_enabled(u8 type)
>   static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
>   {
>   	struct acpi_iort_node *iommu;
> -	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>   
>   	iommu = iort_get_iort_node(fwspec->iommu_fwnode);
>   
> @@ -824,6 +824,7 @@ static inline int iort_add_device_replay(const struct iommu_ops *ops,
>    */
>   int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>   {
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>   	struct acpi_iort_its_group *its;
>   	struct acpi_iort_node *iommu_node, *its_node = NULL;
>   	int i, resv = 0;
> @@ -841,9 +842,9 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>   	 * a given PCI or named component may map IDs to.
>   	 */
>   
> -	for (i = 0; i < dev->iommu_fwspec->num_ids; i++) {
> +	for (i = 0; i < fwspec->num_ids; i++) {
>   		its_node = iort_node_map_id(iommu_node,
> -					dev->iommu_fwspec->ids[i],
> +					fwspec->ids[i],
>   					NULL, IORT_MSI_TYPE);
>   		if (its_node)
>   			break;
> @@ -1036,6 +1037,7 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>    */
>   const struct iommu_ops *iort_iommu_configure(struct device *dev)
>   {
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>   	struct acpi_iort_node *node, *parent;
>   	const struct iommu_ops *ops;
>   	u32 streamid = 0;
> @@ -1045,7 +1047,7 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
>   	 * If we already translated the fwspec there
>   	 * is nothing left to do, return the iommu_ops.
>   	 */
> -	ops = iort_fwspec_iommu_ops(dev->iommu_fwspec);
> +	ops = iort_fwspec_iommu_ops(fwspec);
>   	if (ops)
>   		return ops;
>   
> @@ -1084,7 +1086,7 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
>   	 * add_device callback for dev, replay it to get things in order.
>   	 */
>   	if (!err) {
> -		ops = iort_fwspec_iommu_ops(dev->iommu_fwspec);
> +		ops = iort_fwspec_iommu_ops(fwspec);

This needs to reload the new fwspec initialised by iort_iommu_xlate(), 
in the same manner as the OF code. I think the best thing to do is 
encapsulate the dev_iommu_fwspec_get() call in iort_fwspec_iommu_ops(), 
and have that take dev as its argument directly.

Robin.

>   		err = iort_add_device_replay(ops, dev);
>   	}
>   
> 
