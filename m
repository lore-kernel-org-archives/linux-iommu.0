From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH] iommu/amd: flush IOTLB for specific domains only (v3)
Date: Tue, 30 May 2017 07:38:29 +0000
Message-ID: <MWHPR12MB1518926453E8BAF205F3492D9CF00@MWHPR12MB1518.namprd12.prod.outlook.com>
References: <20170407102039.GW7266@8bytes.org>
 <1495439281-24005-1-git-send-email-arindam.nath@amd.com>
 <20170529143831.GA30388@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170529143831.GA30388@8bytes.org>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Bridgman, John" <John.Bridgman@amd.com>, "drake@endlessm.com" <drake@endlessm.com>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>, "linux@endlessm.com" <linux@endlessm.com>, Craig Stein <stein12c@gmail.com>, "michel@daenzer.net" <michel@daenzer.net>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

>-----Original Message-----
>From: Joerg Roedel [mailto:joro@8bytes.org]
>Sent: Monday, May 29, 2017 8:09 PM
>To: Nath, Arindam <Arindam.Nath@amd.com>; Lendacky, Thomas
><Thomas.Lendacky@amd.com>
>Cc: iommu@lists.linux-foundation.org; amd-gfx@lists.freedesktop.org;
>Deucher, Alexander <Alexander.Deucher@amd.com>; Bridgman, John
><John.Bridgman@amd.com>; drake@endlessm.com; Suthikulpanit, Suravee
><Suravee.Suthikulpanit@amd.com>; linux@endlessm.com; Craig Stein
><stein12c@gmail.com>; michel@daenzer.net; Kuehling, Felix
><Felix.Kuehling@amd.com>; stable@vger.kernel.org
>Subject: Re: [PATCH] iommu/amd: flush IOTLB for specific domains only (v3)
>
>Hi Arindam,
>
>I met Tom Lendacky last week in Nuremberg last week and he told me he is
>working on the same area of the code that this patch is for. His reason
>for touching this code was to solve some locking problems. Maybe you two
>can work together on a joint approach to improve this?

Sure Joerg, I will work with Tom.

Thanks.

>
>On Mon, May 22, 2017 at 01:18:01PM +0530, arindam.nath@amd.com wrote:
>> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>> index 63cacf5..1edeebec 100644
>> --- a/drivers/iommu/amd_iommu.c
>> +++ b/drivers/iommu/amd_iommu.c
>> @@ -2227,15 +2227,26 @@ static struct iommu_group
>*amd_iommu_device_group(struct device *dev)
>>
>>  static void __queue_flush(struct flush_queue *queue)
>>  {
>> -	struct protection_domain *domain;
>> -	unsigned long flags;
>>  	int idx;
>>
>> -	/* First flush TLB of all known domains */
>> -	spin_lock_irqsave(&amd_iommu_pd_lock, flags);
>> -	list_for_each_entry(domain, &amd_iommu_pd_list, list)
>> -		domain_flush_tlb(domain);
>> -	spin_unlock_irqrestore(&amd_iommu_pd_lock, flags);
>> +	/* First flush TLB of all domains which were added to flush queue */
>> +	for (idx =3D 0; idx < queue->next; ++idx) {
>> +		struct flush_queue_entry *entry;
>> +
>> +		entry =3D queue->entries + idx;
>> +
>> +		/*
>> +		 * There might be cases where multiple IOVA entries for the
>> +		 * same domain are queued in the flush queue. To avoid
>> +		 * flushing the same domain again, we check whether the
>> +		 * flag is set or not. This improves the efficiency of
>> +		 * flush operation.
>> +		 */
>> +		if (!entry->dma_dom->domain.already_flushed) {
>> +			entry->dma_dom->domain.already_flushed =3D true;
>> +			domain_flush_tlb(&entry->dma_dom->domain);
>> +		}
>> +	}
>
>There is also a race condition here I have to look into. It is not
>introduced by your patch, but needs fixing anyway. I'll look into this
>too.
>
>
>Regards,
>
>	Joerg
