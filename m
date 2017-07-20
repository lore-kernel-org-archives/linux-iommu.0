From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
 erratum 161010801
Date: Thu, 20 Jul 2017 15:31:39 +0100
Message-ID: <f3ba9136-068a-280d-2849-f3a0081c1d90@arm.com>
References: <20170623145801.325244-1-shameerali.kolothum.thodi@huawei.com>
 <20170623145801.325244-3-shameerali.kolothum.thodi@huawei.com>
 <20170704173820.GO22175@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA83839DB59@FRAEML521-MBX.china.huawei.com>
 <20170714193322.GH26488@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA8383B9D5A@FRAEML521-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA8383B9D5A@FRAEML521-MBX.china.huawei.com>
Content-Language: en-GB
Sender: linux-acpi-owner@vger.kernel.org
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Will Deacon <will.deacon@arm.com>
Cc: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, John Garry <john.garry@huawei.com>, Linuxarm <linuxarm@huawei.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devel@acpica.org" <devel@acpica.org>
List-Id: iommu@lists.linux-foundation.org

On 19/07/17 11:48, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Will Deacon [mailto:will.deacon@arm.com]
>> Sent: Friday, July 14, 2017 8:33 PM
>> To: Shameerali Kolothum Thodi
>> Cc: lorenzo.pieralisi@arm.com; marc.zyngier@arm.com;
>> sudeep.holla@arm.com; robin.murphy@arm.com; hanjun.guo@linaro.org;
>> Gabriele Paoloni; John Garry; Linuxarm; linux-acpi@vger.kernel.org;
>> iommu@lists.linux-foundation.org; Wangzhou (B); Guohanjun (Hanjun Guo);
>> linux-arm-kernel@lists.infradead.org; devel@acpica.org
>> Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3:Enable ACPI based
>> HiSilicon erratum 161010801
>>
> [...]
>>>>> -	list_add_tail(&region->list, head);
>>>>> +	if ((smmu->options & ARM_SMMU_OPT_RESV_HW_MSI)) {
>>>>> +
>>>>> +		if (!is_of_node(smmu->dev->fwnode))
>>>>> +			resv = iort_iommu_its_get_resv_regions(dev, head);
>>>>
>>>> How does this work when we're not using ACPI? Shouldn't of vs ACPI
>>>> be abstracted from the driver?
>>>
>>> At present ARM_SMMU_OPT_RESV_HW_MSI is only set for ACPI and  DT
>>> support for this is a low priority for us at the moment. Is the
>>> suggestion is to have a common function outside the smmu driver for
>>> _iommu_its_get_resv_regions() ? I am not sure what is the best way here.
>>
>> Right, something like that. The driver shouldn't need to care whether or not
>> it's using ACPI or DT when setting these options.
> 
> Below is what I have in mind for the common function for msi reserve.
> But just wondering invoking iort_ functions from iommu code 
> is acceptable or not . Could you please take a look and let me know.

At that point, it seems like we might as well just roll it into
iommu_dma_get_resv_regions() directly[1]. It probably makes sense for
any DT equivalent to be described generically, rather than
SMMU-specific, so parsing that would fit into common code as well.

Then in the SMMU drivers we can skip creating the SW_MSI region if
iommu-dma gave us back any real ones (and remove the apparently
unnecessary resv_msi check in VFIO). Or be lazy and just leave it, as it
doesn't seem to do much harm to have both.

Robin.

[1] This is what I hacked up locally on top of patch #1:
----->8-----
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9d1cebe7f6cb..50292827da49 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -19,6 +19,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */

+#include <linux/acpi_iort.h>
 #include <linux/device.h>
 #include <linux/dma-iommu.h>
 #include <linux/gfp.h>
@@ -174,6 +175,10 @@ void iommu_dma_get_resv_regions(struct device *dev,
struct list_head *list)
 	struct pci_host_bridge *bridge;
 	struct resource_entry *window;

+	if (!is_of_node(dev->iommu_fwspec->iommu_fwnode) &&
+		iort_iommu_its_get_resv_regions(dev, list) < 0)
+		return;
+
 	if (!dev_is_pci(dev))
 		return;

