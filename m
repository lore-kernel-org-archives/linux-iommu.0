From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v10 2/3] iommu/dma: Add HW MSI(GICv3 ITS) address regions
 reservation
Date: Mon, 11 Dec 2017 14:54:12 +0000
Message-ID: <431dd431-1c22-32aa-b3a0-2fd5d4a7ec11@arm.com>
References: <20171129141449.120316-1-shameerali.kolothum.thodi@huawei.com>
 <20171129141449.120316-3-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171129141449.120316-3-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-GB
Sender: linux-acpi-owner@vger.kernel.org
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, lorenzo.pieralisi@arm.com, will.deacon@arm.com, marc.zyngier@arm.com, joro@8bytes.org
Cc: john.garry@huawei.com, xuwei5@hisilicon.com, guohanjun@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, linuxarm@huawei.com
List-Id: iommu@lists.linux-foundation.org

On 29/11/17 14:14, Shameer Kolothum wrote:
> Modified iommu_dma_get_resv_regions() to include GICv3 ITS
> region on ACPI based ARM platfiorms which may require HW MSI
> reservations.

Assuming this builds correctly for all the various combinations of 
CONFIG_ACPI and CONFIG_ACPI_IORT,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   drivers/iommu/dma-iommu.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 25914d3..f05f3cf 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -19,6 +19,7 @@
>    * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>    */
>   
> +#include <linux/acpi_iort.h>
>   #include <linux/device.h>
>   #include <linux/dma-iommu.h>
>   #include <linux/gfp.h>
> @@ -167,13 +168,18 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
>    *
>    * IOMMU drivers can use this to implement their .get_resv_regions callback
>    * for general non-IOMMU-specific reservations. Currently, this covers host
> - * bridge windows for PCI devices.
> + * bridge windows for PCI devices and GICv3 ITS region reservation on ACPI
> + * based ARM platforms that may require HW MSI reservation.
>    */
>   void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
>   {
>   	struct pci_host_bridge *bridge;
>   	struct resource_entry *window;
>   
> +	if (!is_of_node(dev->iommu_fwspec->iommu_fwnode) &&
> +		iort_iommu_msi_get_resv_regions(dev, list) < 0)
> +		return;
> +
>   	if (!dev_is_pci(dev))
>   		return;
>   
> 
