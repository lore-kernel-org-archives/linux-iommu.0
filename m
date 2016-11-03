From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v14 14/16] vfio/type1: Check doorbell safety
Date: Thu, 3 Nov 2016 15:14:56 +0100
Message-ID: <ea9b83b0-d591-eeb2-773f-2d76be2a589a@redhat.com>
References: <1476278544-3397-1-git-send-email-eric.auger@redhat.com>
 <1476278544-3397-15-git-send-email-eric.auger@redhat.com>
 <HE1PR04MB1321EAD1CE91D2B6FC04BB55FFA30@HE1PR04MB1321.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <HE1PR04MB1321EAD1CE91D2B6FC04BB55FFA30@HE1PR04MB1321.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Diana Madalina Craciun <diana.craciun@nxp.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "jason@lakedaemon.net" <jason@lakedaemon.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "drjones@redhat.com" <drjones@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Manish.Jaggi@caviumnetworks.com" <Manish.Jaggi@caviumnetworks.com>, "p.fedin@samsung.com" <p.fedin@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "pranav.sawargaonkar@gmail.com" <pranav.sawargaonkar@gmail.com>, "yehuday@marvell.com" <yehuday@marvell.com>
List-Id: iommu@lists.linux-foundation.org

Hi Diana,

On 03/11/2016 14:45, Diana Madalina Craciun wrote:
> Hi Eric,
> 
> On 10/12/2016 04:23 PM, Eric Auger wrote:
>> On x86 IRQ remapping is abstracted by the IOMMU. On ARM this is abstracted
>> by the msi controller.
>>
>> Since we currently have no way to detect whether the MSI controller is
>> upstream or downstream to the IOMMU we rely on the MSI doorbell information
>> registered by the interrupt controllers. In case at least one doorbell
>> does not implement proper isolation, we state the assignment is unsafe
>> with regard to interrupts. This is a coarse assessment but should allow to
>> wait for a better system description.
>>
>> At this point ARM sMMU still advertises IOMMU_CAP_INTR_REMAP. This is
>> removed in next patch.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>> v13 -> v15:
>> - check vfio_msi_resv before checking whether msi doorbell is safe
>>
>> v9 -> v10:
>> - coarse safety assessment based on MSI doorbell info
>>
>> v3 -> v4:
>> - rename vfio_msi_parent_irq_remapping_capable into vfio_safe_irq_domain
>>   and irq_remapping into safe_irq_domains
>>
>> v2 -> v3:
>> - protect vfio_msi_parent_irq_remapping_capable with
>>   CONFIG_GENERIC_MSI_IRQ_DOMAIN
>> ---
>>  drivers/vfio/vfio_iommu_type1.c | 30 +++++++++++++++++++++++++++++-
>>  1 file changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index e0c97ef..c18ba9d 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -442,6 +442,29 @@ static void vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma)
>>  }
>>  
>>  /**
>> + * vfio_msi_resv - Return whether any VFIO iommu domain requires
>> + * MSI mapping
>> + *
>> + * @iommu: vfio iommu handle
>> + *
>> + * Return: true of MSI mapping is needed, false otherwise
>> + */
>> +static bool vfio_msi_resv(struct vfio_iommu *iommu)
>> +{
>> +	struct iommu_domain_msi_resv msi_resv;
>> +	struct vfio_domain *d;
>> +	int ret;
>> +
>> +	list_for_each_entry(d, &iommu->domain_list, next) {
>> +		ret = iommu_domain_get_attr(d->domain, DOMAIN_ATTR_MSI_RESV,
>> +					    &msi_resv);
>> +		if (!ret)
>> +			return true;
>> +	}
>> +	return false;
>> +}
>> +
>> +/**
>>   * vfio_set_msi_aperture - Sets the msi aperture on all domains
>>   * requesting MSI mapping
>>   *
>> @@ -945,8 +968,13 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>>  	INIT_LIST_HEAD(&domain->group_list);
>>  	list_add(&group->next, &domain->group_list);
>>  
>> +	/*
>> +	 * to advertise safe interrupts either the IOMMU or the MSI controllers
>> +	 * must support IRQ remapping (aka. interrupt translation)
>> +	 */
>>  	if (!allow_unsafe_interrupts &&
>> -	    !iommu_capable(bus, IOMMU_CAP_INTR_REMAP)) {
>> +	    (!iommu_capable(bus, IOMMU_CAP_INTR_REMAP) &&
>> +		!(vfio_msi_resv(iommu) && iommu_msi_doorbell_safe()))) {
>>  		pr_warn("%s: No interrupt remapping support.  Use the module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU support on this platform\n",
>>  		       __func__);
>>  		ret = -EPERM;
> 
> I understand from the other discussions that you will respin these
> series, but anyway I have tested this version with GICV3 + ITS and it
> stops here. As I have a GICv3 I am not supposed to enable allow unsafe
> interrupts. What I see is that vfio_msi_resv returns false just because
> the iommu->domain_list list is empty. The newly created domain is
> actually added to the domain_list at the end of this function, so it
> seems normal for the list to be empty at this point.

Thanks for reporting the issue. You are fully right. I must have missed
that test. I should just check the current iommu_domain attribute I think.

waiting for a fix, please probe the vfio_iommu_type1 module with
allow_unsafe_interrupts=1

Thanks

Eric
> 
> Thanks,
> 
> Diana
> 
> 
