Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E47EC43334
	for <iommu@archiver.kernel.org>; Mon, 27 Jun 2022 19:39:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B1D68400F1;
	Mon, 27 Jun 2022 19:39:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B1D68400F1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ozrlqk8zHPsh; Mon, 27 Jun 2022 19:39:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 48ADF40242;
	Mon, 27 Jun 2022 19:39:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 48ADF40242
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1A88C0039;
	Mon, 27 Jun 2022 19:39:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84D23C002D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 19:39:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5F35340242
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 19:39:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5F35340242
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ifzIEPmT1Pi5 for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 19:39:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 12713400F1
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 12713400F1
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 19:39:45 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65D001758;
 Mon, 27 Jun 2022 12:39:45 -0700 (PDT)
Received: from [10.57.84.159] (unknown [10.57.84.159])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE96A3F792;
 Mon, 27 Jun 2022 12:39:43 -0700 (PDT)
Message-ID: <8b237fd0-96f0-ad48-dfcb-e4a46e4463eb@arm.com>
Date: Mon, 27 Jun 2022 20:39:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 1/2] vfio/type1: Simplify bus_type determination
Content-Language: en-GB
To: Alex Williamson <alex.williamson@redhat.com>
References: <194a12d3434d7b38f84fa96503c7664451c8c395.1656092606.git.robin.murphy@arm.com>
 <20220627132136.2b902875.alex.williamson@redhat.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220627132136.2b902875.alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, cohuck@redhat.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, jgg@nvidia.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022-06-27 20:21, Alex Williamson wrote:
> On Fri, 24 Jun 2022 18:51:44 +0100
> Robin Murphy <robin.murphy@arm.com> wrote:
> 
>> Since IOMMU groups are mandatory for drivers to support, it stands to
>> reason that any device which has been successfully added to a group
>> must be on a bus supported by that IOMMU driver, and therefore a domain
>> viable for any device in the group must be viable for all devices in
>> the group. This already has to be the case for the IOMMU API's internal
>> default domain, for instance. Thus even if the group contains devices on
>> different buses, that can only mean that the IOMMU driver actually
>> supports such an odd topology, and so without loss of generality we can
>> expect the bus type of any device in a group to be suitable for IOMMU
>> API calls.
>>
>> Furthermore, scrutiny reveals a lack of protection for the bus being
>> removed while vfio_iommu_type1_attach_group() is using it; the reference
>> that VFIO holds on the iommu_group ensures that data remains valid, but
>> does not prevent the group's membership changing underfoot.
>>
>> We can address both concerns by recycling vfio_bus_type() into some
>> superficially similar logic to indirect the IOMMU API calls themselves.
>> Each call is thus protected from races by the IOMMU group's own locking,
>> and we no longer need to hold group-derived pointers beyond that scope.
>> It also gives us an easy path for the IOMMU API's migration of bus-based
>> interfaces to device-based, of which we can already take the first step
>> with device_iommu_capable(). As with domains, any capability must in
>> practice be consistent for devices in a given group - and after all it's
>> still the same capability which was expected to be consistent across an
>> entire bus! - so there's no need for any complicated validation.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> v3: Complete rewrite yet again, and finally it doesn't feel like we're
>> stretching any abstraction boundaries the wrong way, and the diffstat
>> looks right too. I did think about embedding IOMMU_CAP_INTR_REMAP
>> directly in the callback, but decided I like the consistency of minimal
>> generic wrappers. And yes, if the capability isn't supported then it
>> does end up getting tested for the whole group, but meh, it's harmless.
>>
>>   drivers/vfio/vfio_iommu_type1.c | 42 +++++++++++++++++----------------
>>   1 file changed, 22 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index c13b9290e357..a77ff00c677b 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -1679,18 +1679,6 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
>>   	return ret;
>>   }
>>   
>> -static int vfio_bus_type(struct device *dev, void *data)
>> -{
>> -	struct bus_type **bus = data;
>> -
>> -	if (*bus && *bus != dev->bus)
>> -		return -EINVAL;
>> -
>> -	*bus = dev->bus;
>> -
>> -	return 0;
>> -}
>> -
>>   static int vfio_iommu_replay(struct vfio_iommu *iommu,
>>   			     struct vfio_domain *domain)
>>   {
>> @@ -2153,13 +2141,25 @@ static void vfio_iommu_iova_insert_copy(struct vfio_iommu *iommu,
>>   	list_splice_tail(iova_copy, iova);
>>   }
>>   
> 
> Any objection if I add the following comment:
> 
> /* Redundantly walks non-present capabilities to simplify caller */

Not at all, feel free - I guess if I felt it was worth pre-empting the 
review question then it probably is subtle enough to deserve a code comment!

Thanks,
Robin.

> 
> Thanks,
> Alex
> 
>> +static int vfio_iommu_device_capable(struct device *dev, void *data)
>> +{
>> +	return device_iommu_capable(dev, (enum iommu_cap)data);
>> +}
>> +
>> +static int vfio_iommu_domain_alloc(struct device *dev, void *data)
>> +{
>> +	struct iommu_domain **domain = data;
>> +
>> +	*domain = iommu_domain_alloc(dev->bus);
>> +	return 1; /* Don't iterate */
>> +}
>> +
>>   static int vfio_iommu_type1_attach_group(void *iommu_data,
>>   		struct iommu_group *iommu_group, enum vfio_group_type type)
>>   {
>>   	struct vfio_iommu *iommu = iommu_data;
>>   	struct vfio_iommu_group *group;
>>   	struct vfio_domain *domain, *d;
>> -	struct bus_type *bus = NULL;
>>   	bool resv_msi, msi_remap;
>>   	phys_addr_t resv_msi_base = 0;
>>   	struct iommu_domain_geometry *geo;
>> @@ -2192,18 +2192,19 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>>   		goto out_unlock;
>>   	}
>>   
>> -	/* Determine bus_type in order to allocate a domain */
>> -	ret = iommu_group_for_each_dev(iommu_group, &bus, vfio_bus_type);
>> -	if (ret)
>> -		goto out_free_group;
>> -
>>   	ret = -ENOMEM;
>>   	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
>>   	if (!domain)
>>   		goto out_free_group;
>>   
>> +	/*
>> +	 * Going via the iommu_group iterator avoids races, and trivially gives
>> +	 * us a representative device for the IOMMU API call. We don't actually
>> +	 * want to iterate beyond the first device (if any).
>> +	 */
>>   	ret = -EIO;
>> -	domain->domain = iommu_domain_alloc(bus);
>> +	iommu_group_for_each_dev(iommu_group, &domain->domain,
>> +				 vfio_iommu_domain_alloc);
>>   	if (!domain->domain)
>>   		goto out_free_domain;
>>   
>> @@ -2258,7 +2259,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>>   	list_add(&group->next, &domain->group_list);
>>   
>>   	msi_remap = irq_domain_check_msi_remap() ||
>> -		    iommu_capable(bus, IOMMU_CAP_INTR_REMAP);
>> +		    iommu_group_for_each_dev(iommu_group, (void *)IOMMU_CAP_INTR_REMAP,
>> +					     vfio_iommu_device_capable);
>>   
>>   	if (!allow_unsafe_interrupts && !msi_remap) {
>>   		pr_warn("%s: No interrupt remapping support.  Use the module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU support on this platform\n",
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
