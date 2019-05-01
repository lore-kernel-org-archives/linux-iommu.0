Return-Path: <SRS0=GORt=TB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDD6C43219
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 11:15:11 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA3F21670
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 11:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA3F21670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0556589A9;
	Wed,  1 May 2019 11:15:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1FFC784AE
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 11:14:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id BDDC9876
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 11:14:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49B7480D;
	Wed,  1 May 2019 04:14:33 -0700 (PDT)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 300633F5C1;
	Wed,  1 May 2019 04:14:31 -0700 (PDT)
Subject: Re: [PATCH v2 4/7] irqchip/gic-v3-its: Don't map the MSI page in
	its_irq_compose_msi_msg()
To: Auger Eric <eric.auger@redhat.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
References: <20190429144428.29254-1-julien.grall@arm.com>
	<20190429144428.29254-5-julien.grall@arm.com>
	<17855fd3-7f7b-a962-e2bd-c9a0c2dbf765@redhat.com>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <59ff2eda-74d4-6925-6ed0-8d40e8a892fa@arm.com>
Date: Wed, 1 May 2019 12:14:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <17855fd3-7f7b-a962-e2bd-c9a0c2dbf765@redhat.com>
Content-Language: en-US
Cc: jason@lakedaemon.net, douliyangs@gmail.com, marc.zyngier@arm.com,
	logang@deltatee.com, bigeasy@linutronix.de,
	miquel.raynal@bootlin.com, tglx@linutronix.de,
	robin.murphy@arm.com, linux-rt-users@vger.kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190501111429.PkgQ8Chy1EfWWV4ZAuizToeOGwIPcu-nAFeZsVGEqGA@z>

On 30/04/2019 13:34, Auger Eric wrote:
> Hi Julien,

Hi Eric,

Thank you for the review!

> 
> On 4/29/19 4:44 PM, Julien Grall wrote:
>> its_irq_compose_msi_msg() may be called from non-preemptible context.
>> However, on RT, iommu_dma_map_msi_msg requires to be called from a
>> preemptible context.
>>
>> A recent change split iommu_dma_map_msi_msg() in two new functions:
>> one that should be called in preemptible context, the other does
>> not have any requirement.
>>
>> The GICv3 ITS driver is reworked to avoid executing preemptible code in
>> non-preemptible context. This can be achieved by preparing the MSI
>> maping when allocating the MSI interrupt.
> mapping
>>
>> Signed-off-by: Julien Grall <julien.grall@arm.com>
>>
>> ---
>>      Changes in v2:
>>          - Rework the commit message to use imperative mood
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 7577755bdcf4..12ddbcfe1b1e 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -1179,7 +1179,7 @@ static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
>>   	msg->address_hi		= upper_32_bits(addr);
>>   	msg->data		= its_get_event_id(d);
>>   
>> -	iommu_dma_map_msi_msg(d->irq, msg);
>> +	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(d), msg);
>>   }
>>   
>>   static int its_irq_set_irqchip_state(struct irq_data *d,
>> @@ -2566,6 +2566,7 @@ static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>>   {
>>   	msi_alloc_info_t *info = args;
>>   	struct its_device *its_dev = info->scratchpad[0].ptr;
>> +	struct its_node *its = its_dev->its;
>>   	irq_hw_number_t hwirq;
>>   	int err;
>>   	int i;
>> @@ -2574,6 +2575,8 @@ static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>>   	if (err)
>>   		return err;
>>   
>> +	err = iommu_dma_prepare_msi(info->desc, its->get_msi_base(its_dev));
> Test err as in gicv2m driver?

Hmmm yes. Marc, do you want me to respin the patch?

Cheers,

-- 
Julien Grall
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
