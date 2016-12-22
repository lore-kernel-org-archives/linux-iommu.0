From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [RFC v4 15/16] vfio/type1: Check MSI remapping at irq domain
 level
Date: Thu, 22 Dec 2016 14:02:40 +0100
Message-ID: <3ead0cc1-7798-3e39-da56-c18a5989c00c@redhat.com>
References: <1481661034-3088-1-git-send-email-eric.auger@redhat.com>
 <1481661034-3088-16-git-send-email-eric.auger@redhat.com>
 <HE1PR04MB13219CC90CE2BBE62356D94CFF920@HE1PR04MB1321.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <HE1PR04MB13219CC90CE2BBE62356D94CFF920@HE1PR04MB1321.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Diana Madalina Craciun <diana.craciun@nxp.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "jason@lakedaemon.net" <jason@lakedaemon.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "drjones@redhat.com" <drjones@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pranav.sawargaonkar@gmail.com" <pranav.sawargaonkar@gmail.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "punit.agrawal@arm.com" <punit.agrawal@arm.com>, "gpkulkarni@gmail.com" <gpkulkarni@gmail.com>, "shankerd@codeaurora.org" <shankerd@codeaurora.org>, Bharat Bhushan <bharat.bhushan@nxp.com>
List-Id: iommu@lists.linux-foundation.org

Hi Diana,

On 22/12/2016 13:41, Diana Madalina Craciun wrote:
> Hi Eric,
> 
> On 12/13/2016 10:32 PM, Eric Auger wrote:
>> In case the IOMMU does not bypass MSI transactions (typical
>> case on ARM), we check all MSI controllers are IRQ remapping
>> capable. If not the IRQ assignment may be unsafe.
>>
>> At this stage the arm-smmu-(v3) still advertise the
>> IOMMU_CAP_INTR_REMAP capability at IOMMU level. This will be
>> removed in subsequent patches.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  drivers/vfio/vfio_iommu_type1.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index d07fe73..a05648b 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -37,6 +37,7 @@
>>  #include <linux/vfio.h>
>>  #include <linux/workqueue.h>
>>  #include <linux/dma-iommu.h>
>> +#include <linux/irqdomain.h>
>>  
>>  #define DRIVER_VERSION  "0.2"
>>  #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"
>> @@ -765,7 +766,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>>  	struct vfio_domain *domain, *d;
>>  	struct bus_type *bus = NULL;
>>  	int ret;
>> -	bool resv_msi;
>> +	bool resv_msi, msi_remap;
>>  	phys_addr_t resv_msi_base;
>>  
>>  	mutex_lock(&iommu->lock);
>> @@ -818,8 +819,10 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>>  	INIT_LIST_HEAD(&domain->group_list);
>>  	list_add(&group->next, &domain->group_list);
>>  
>> -	if (!allow_unsafe_interrupts &&
>> -	    !iommu_capable(bus, IOMMU_CAP_INTR_REMAP)) {
>> +	msi_remap = resv_msi ? irq_domain_check_msi_remap() :
>> +			       iommu_capable(bus, IOMMU_CAP_INTR_REMAP);
>> +
>> +	if (!allow_unsafe_interrupts && !msi_remap) {
>>  		pr_warn("%s: No interrupt remapping support.  Use the module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU support on this platform\n",
>>  		       __func__);
>>  		ret = -EPERM;
> 
> I tested your v4.9-reserved-v4 branch on a ITS capable hardware (NXP
> LS2080), so I did not set allow_unsafe_interrupts. It fails here
> complaining that the there is no interrupt remapping support. The
> irq_domain_check_msi_remap function returns false as none of the checked
> domains has the IRQ_DOMAIN_FLAG_MSI_REMAP flag set. I think the reason
> is that the flags are not propagated through the domain hierarchy when
> the domain is created.

Hum OK. Please apologize for the inconvenience, all the more so this is
the second time you report the same issue for different cause :-( At the
moment I can't test on a GICv3 ITS based system. I will try to fix that
though.

I would like to get the confirmation introducing this flag is the right
direction though.

Thanks

Eric
> 
> Thanks,
> 
> Diana
> 
> 
> 
