Return-Path: <SRS0=Eb89=SH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F0CC282CE
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 16:36:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D03121738
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 16:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D03121738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DA344259C;
	Fri,  5 Apr 2019 16:36:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0F5642599
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 16:36:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 822B0FD
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 16:36:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C23F168F;
	Fri,  5 Apr 2019 09:36:14 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DEDF3F68F;
	Fri,  5 Apr 2019 09:36:12 -0700 (PDT)
Subject: Re: [PATCH 2/4] iommu/arm-smmu-v3: Link domains and devices
To: Will Deacon <will.deacon@arm.com>
References: <20190320173634.21895-1-jean-philippe.brucker@arm.com>
	<20190320173634.21895-3-jean-philippe.brucker@arm.com>
	<20190404143924.GB27823@fuggles.cambridge.arm.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <312d33a5-8eca-3fae-fd8b-8325e045761b@arm.com>
Date: Fri, 5 Apr 2019 17:35:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190404143924.GB27823@fuggles.cambridge.arm.com>
Content-Language: en-US
Cc: zhongmiao@hisilicon.com, okaya@kernel.org, rjw@rjwysocki.net,
	linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
	sudeep.holla@arm.com, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, lenb@kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190405163552.Y-r0N_IZLemBqY-1sivUAYmAMmwPS5BV0MK_03jhlwU@z>

On 04/04/2019 15:39, Will Deacon wrote:
> Hi Jean-Philippe,
> 
> First off, thanks for posting this: it's definitely something that I'm keen
> to support, and getting bits in a piece at a time is probably a good idea.
> 
> On Wed, Mar 20, 2019 at 05:36:32PM +0000, Jean-Philippe Brucker wrote:
>> When removing a mapping from a domain, we need to send an invalidation to
>> all devices that might have stored it in their Address Translation Cache
>> (ATC). In addition when updating the context descriptor of a live domain,
>> we'll need to send invalidations for all devices attached to it.
>>
>> Maintain a list of devices in each domain, protected by a spinlock. It is
>> updated every time we attach or detach devices to and from domains.
>>
>> It needs to be a spinlock because we'll invalidate ATC entries from
>> within hardirq-safe contexts, but it may be possible to relax the read
>> side with RCU later.
>>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>> ---
>>  drivers/iommu/arm-smmu-v3.c | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index d3880010c6cf..66a29c113dbc 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -594,6 +594,11 @@ struct arm_smmu_device {
>>  struct arm_smmu_master_data {
>>  	struct arm_smmu_device		*smmu;
>>  	struct arm_smmu_strtab_ent	ste;
>> +
>> +	struct arm_smmu_domain		*domain;
>> +	struct list_head		domain_head;
>> +
>> +	struct device			*dev;
>>  };
>>  
>>  /* SMMU private data for an IOMMU domain */
>> @@ -618,6 +623,9 @@ struct arm_smmu_domain {
>>  	};
>>  
>>  	struct iommu_domain		domain;
>> +
>> +	struct list_head		devices;
>> +	spinlock_t			devices_lock;
>>  };
>>  
>>  struct arm_smmu_option_prop {
>> @@ -1493,6 +1501,9 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>>  	}
>>  
>>  	mutex_init(&smmu_domain->init_mutex);
>> +	INIT_LIST_HEAD(&smmu_domain->devices);
>> +	spin_lock_init(&smmu_domain->devices_lock);
> 
> I'm wondering whether we can't take this a bit further and re-organise the
> data structures to make this a little simpler overall. Something along the
> lines of:
> 
> 	struct arm_smmu_master_data {
> 		struct list_head		list; // masters in the same domain
> 		struct arm_smmu_device		*smmu;
> 		unsigned int			num_sids;
> 		u32				*sids; // Points into fwspec
> 		struct arm_smmu_domain		*domain; // NULL -> !assigned
> 	};
> 
> and then just add a list_head into struct arm_smmu_domain to track the
> masters that have been attached (if you're feeling brave, you could put
> this into the s1_cfg).

I'm not sure about that last bit, shouldn't the list of masters apply to
both s1 and s2?

> 
> The ATC invalidation logic would then be:
> 
>   - Detaching a device: walk over the sids from the master data
>   - Unmapping a range from a domain: walk over the attached masters
> 
> I think this would also allow us to remove struct arm_smmu_strtab_ent
> completely.

Makes sense, it does work and simplifies the structures. It makes the
PASID and PRI patches slightly nicer as well. I'll resend once my tests
complete.

Thanks,
Jean

> 
> Dunno: this is one of the those things where you really have to try it
> to figure out why it doesn't work...
> 
> Will
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
