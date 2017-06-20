From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
	erratum 161010801
Date: Tue, 20 Jun 2017 16:16:18 +0100
Message-ID: <d6e824b0-17bd-dd41-2d11-0491d8f66759@arm.com>
References: <20170619154500.92336-1-shameerali.kolothum.thodi@huawei.com>
	<20170619154500.92336-3-shameerali.kolothum.thodi@huawei.com>
	<20170620102906.GA26908@red-moon>
	<5FC3163CFD30C246ABAA99954A238FA83838617D@FRAEML521-MBS.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA83838617D-WFPaWmAhWqvVoO+7gWNeMAK1hpo4iccwjNknBlVQO8k@public.gmane.org>
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
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: "Guohanjun (Hanjun Guo)" <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "marc.zyngier-5wv7dgnIgG8@public.gmane.org" <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Wangzhou (B)" <wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "sudeep.holla-5wv7dgnIgG8@public.gmane.org" <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org" <devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 20/06/17 15:07, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org]
>> Sent: Tuesday, June 20, 2017 11:29 AM
>> To: Shameerali Kolothum Thodi
>> Cc: marc.zyngier-5wv7dgnIgG8@public.gmane.org; sudeep.holla-5wv7dgnIgG8@public.gmane.org; will.deacon-5wv7dgnIgG8@public.gmane.org;
>> robin.murphy-5wv7dgnIgG8@public.gmane.org; hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; Gabriele Paoloni; John
>> Garry; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-arm-
>> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org;
>> Linuxarm; Wangzhou (B); Guohanjun (Hanjun Guo)
>> Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3:Enable ACPI based
>> HiSilicon erratum 161010801
>>
>> Hi Shameer,
>>
>> On Mon, Jun 19, 2017 at 04:45:00PM +0100, shameer wrote:
>>> The HiSilicon erratum 161010801 describes the limitation of HiSilicon
>>> platforms Hip06/Hip07 to support the SMMU mappings for MSI
>> transactions.
>>>
>>> On these platforms GICv3 ITS translator is presented with the deviceID
>>> by extending the MSI payload data to 64 bits to include the deviceID.
>>> Hence, the PCIe controller on this platforms has to differentiate the
>>> MSI payload against other DMA payload and has to modify the MSI
>> payload.
>>> This basically makes it difficult for this platforms to have a SMMU
>>> translation for MSI.
>>>
>>> This patch implements a ACPI table based quirk to reserve the hw msi
>>> regions in the smmu-v3 driver which means these address regions will
>>> not be translated and will be excluded from iova allocations.
>>>
>>> Signed-off-by: shameer <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>>> ---
>>>  drivers/iommu/arm-smmu-v3.c | 29 ++++++++++++++++++++++++-----
>>>  1 file changed, 24 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-
>> v3.c
>>> index abe4b88..f03c63b 100644
>>> --- a/drivers/iommu/arm-smmu-v3.c
>>> +++ b/drivers/iommu/arm-smmu-v3.c
>>> @@ -597,6 +597,7 @@ struct arm_smmu_device {
>>>  	u32				features;
>>>
>>>  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
>>> +#define ARM_SMMU_OPT_RESV_HW_MSI	(1 << 1)
>>>  	u32				options;
>>>
>>>  	struct arm_smmu_cmdq		cmdq;
>>> @@ -1904,14 +1905,31 @@ static void arm_smmu_get_resv_regions(struct
>> device *dev,
>>>  				      struct list_head *head)
>>>  {
>>>  	struct iommu_resv_region *region;
>>> +	struct arm_smmu_device *smmu;
>>> +	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
>>>  	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>>>
>>> -	region = iommu_alloc_resv_region(MSI_IOVA_BASE,
>> MSI_IOVA_LENGTH,
>>> -					 prot, IOMMU_RESV_SW_MSI);
>>> -	if (!region)
>>> -		return;
>>> +	smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
>>> +
>>> +	if (smmu && (smmu->options & ARM_SMMU_OPT_RESV_HW_MSI)
>> &&
>>> +		      dev_is_pci(dev)) {
>>
>> IORT changes are fine to me, I am still no big fan of this supposedly
>> generic option that is _really_ platform specific (in particular as I
>> said before the quirk depends on the PCI host bridge but in this
>> patchset I see no such dependency. In short - the quirk is hooked off
>> the SMMUv3 model which implicitly implies a PCI host bridge
>> configuration IIUC). It is Will and Robin decision though, I am not sure
>> you can make it any tidier (given that on ACPI you may not even have
>> a PCI host bridge specific _HID to base your check above on).
> 
> Thanks Lorenzo. I understand your point. As far as our platform is 
> concerned, I think It is ok to remove the dev_is_pci() check and make
> it generic, if that helps.  I don't think it will harm us other than couple of
>  "HW MSI region resv failed: " logs  for our platform devices.

I think the answer there is that iort_iommu_its_get_resv_regions()
really should distinguish between "this device just doesn't have an ITS
mapping" and "something actually went wrong", such that you don't treat
the former as an error. That's almost certainly cleaner than e.g. trying
to check if dev has an associated MSI domain here before calling it.

Robin.

> 
> Hi Will/Robin,
> Please let me know your thoughts.
> 
> Thanks,
> Shameer
> 
> 
