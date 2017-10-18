From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v9 2/4] iommu/dma: Add a helper function to reserve HW MSI
	address regions for IOMMU drivers
Date: Wed, 18 Oct 2017 13:34:25 +0100
Message-ID: <1d49243a-4746-f189-7c5d-4b98937115fb@arm.com>
References: <20171006140450.89652-1-shameerali.kolothum.thodi@huawei.com>
	<20171006140450.89652-3-shameerali.kolothum.thodi@huawei.com>
	<20171013192350.GA32130@arm.com>
	<5FC3163CFD30C246ABAA99954A238FA83844672A@FRAEML521-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA83844672A-WFPaWmAhWqtUuCJht5byYAK1hpo4iccwjNknBlVQO8k@public.gmane.org>
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
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "marc.zyngier-5wv7dgnIgG8@public.gmane.org" <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "sudeep.holla-5wv7dgnIgG8@public.gmane.org" <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Guohanjun (Hanjun Guo)" <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org" <devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 16/10/17 17:09, Shameerali Kolothum Thodi wrote:
> Hi Robin,
> 
>> -----Original Message-----
>> From: Will Deacon [mailto:will.deacon-5wv7dgnIgG8@public.gmane.org]
>> Sent: Friday, October 13, 2017 8:24 PM
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>> Cc: lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org; marc.zyngier-5wv7dgnIgG8@public.gmane.org;
>> sudeep.holla-5wv7dgnIgG8@public.gmane.org; robin.murphy-5wv7dgnIgG8@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org;
>> bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org; Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>;
>> John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
>> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
>> pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org; Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>;
>> Wangzhou (B) <wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>; Guohanjun (Hanjun Guo)
>> <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>> Subject: Re: [PATCH v9 2/4] iommu/dma: Add a helper function to reserve HW
>> MSI address regions for IOMMU drivers
>>
>> On Fri, Oct 06, 2017 at 03:04:48PM +0100, Shameer Kolothum wrote:
>>> IOMMU drivers can use this to implement their .get_resv_regions callback
>>> for HW MSI specific reservations(e.g. ARM GICv3 ITS MSI region).
>>>
>>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>>> ---
>>>  drivers/iommu/dma-iommu.c | 20 ++++++++++++++++++++
>>>  include/linux/dma-iommu.h |  7 +++++++
>>>  2 files changed, 27 insertions(+)
>>
>> I'd like to see Robin's Ack on this, because this is his code and he had
>> ideas on ways to solve this problem properly.
> 
> Please let us know if it is ok to go ahead with ACPI support for now.
> It will help our customers to start using pass-through for PCIe.
> 
> Thanks,
> Shameer
> 
>>
>> Will
>>
>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>> index 9d1cebe..bae677e 100644
>>> --- a/drivers/iommu/dma-iommu.c
>>> +++ b/drivers/iommu/dma-iommu.c
>>> @@ -19,6 +19,7 @@
>>>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>>>   */
>>>
>>> +#include <linux/acpi_iort.h>
>>>  #include <linux/device.h>
>>>  #include <linux/dma-iommu.h>
>>>  #include <linux/gfp.h>
>>> @@ -27,6 +28,7 @@
>>>  #include <linux/iova.h>
>>>  #include <linux/irq.h>
>>>  #include <linux/mm.h>
>>> +#include <linux/of_iommu.h>
>>>  #include <linux/pci.h>
>>>  #include <linux/scatterlist.h>
>>>  #include <linux/vmalloc.h>
>>> @@ -198,6 +200,24 @@ void iommu_dma_get_resv_regions(struct device
>> *dev, struct list_head *list)
>>>  }
>>>  EXPORT_SYMBOL(iommu_dma_get_resv_regions);
>>>
>>> +/**
>>> + * iommu_dma_get_msi_resv_regions - Reserved region driver helper
>>> + * @dev: Device from iommu_get_resv_regions()
>>> + * @list: Reserved region list from iommu_get_resv_regions()
>>> + *
>>> + * IOMMU drivers can use this to implement their .get_resv_regions
>>> + * callback for HW MSI specific reservations. For now, this only

This doesn't make an awful lot of sense - there's only one reserved
region callback, so iommu-dma shouldn't be offering two separate and
non-overlapping implementations.

>>> + * covers ITS MSI region reservation using ACPI IORT helper function.
>>> + */
>>> +int iommu_dma_get_msi_resv_regions(struct device *dev, struct list_head
>> *list)
>>> +{
>>> +	if (!is_of_node(dev->iommu_fwspec->iommu_fwnode))
>>> +		return iort_iommu_msi_get_resv_regions(dev, list);

Either this call knows how to do the right thing for any platform and
should be made from iommu_dma_get_reserved_regions() directly, or it's
tightly coupled to the HiSilicon quirk in the SMMUv3 driver and
iommu-dma doesn't need to know - the middle ground presented here is
surely the worst of both worlds.

Robin.

>>> +
>>> +	return -ENODEV;
>>> +}
>>> +EXPORT_SYMBOL(iommu_dma_get_msi_resv_regions);
>>> +
>>>  static int cookie_init_hw_msi_region(struct iommu_dma_cookie *cookie,
>>>  		phys_addr_t start, phys_addr_t end)
>>>  {
>>> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
>>> index 92f2083..6062ef0 100644
>>> --- a/include/linux/dma-iommu.h
>>> +++ b/include/linux/dma-iommu.h
>>> @@ -74,6 +74,8 @@ void iommu_dma_unmap_resource(struct device *dev,
>> dma_addr_t handle,
>>>  void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
>>>  void iommu_dma_get_resv_regions(struct device *dev, struct list_head
>> *list);
>>>
>>> +int iommu_dma_get_msi_resv_regions(struct device *dev, struct list_head
>> *list);
>>> +
>>>  #else
>>>
>>>  struct iommu_domain;
>>> @@ -107,6 +109,11 @@ static inline void
>> iommu_dma_get_resv_regions(struct device *dev, struct list_he
>>>  {
>>>  }
>>>
>>> +static inline int iommu_dma_get_msi_resv_regions(struct device *dev,
>> struct list_head *list)
>>> +{
>>> +	return -ENODEV;
>>> +}
>>> +
>>>  #endif	/* CONFIG_IOMMU_DMA */
>>>  #endif	/* __KERNEL__ */
>>>  #endif	/* __DMA_IOMMU_H */
>>> --
>>> 1.9.1
>>>
>>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
