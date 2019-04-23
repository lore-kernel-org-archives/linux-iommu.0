Return-Path: <SRS0=UFM6=SZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35688C10F14
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 13:19:52 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1032920645
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 13:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1032920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C54B61354;
	Tue, 23 Apr 2019 13:19:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 77253134B
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 13:19:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 1D94A786
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 13:19:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B266DA78;
	Tue, 23 Apr 2019 06:19:49 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB3EF3F706;
	Tue, 23 Apr 2019 06:19:47 -0700 (PDT)
Subject: Re: [PATCH 1/7] genirq/msi: Add a new field in msi_desc to store an
	IOMMU cookie
To: Marc Zyngier <marc.zyngier@arm.com>, Julien Grall <julien.grall@arm.com>, 
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20190418172611.21561-1-julien.grall@arm.com>
	<20190418172611.21561-2-julien.grall@arm.com>
	<7e77331c-4adf-5bb4-0c23-4d01a6ac5ab4@arm.com>
	<1bcdb72f-2116-756b-b74d-a48f89870782@arm.com>
	<48d14d10-0484-a7dd-cd84-a933158906ff@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <468df11c-fe2a-2584-7306-185531653331@arm.com>
Date: Tue, 23 Apr 2019 14:19:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <48d14d10-0484-a7dd-cd84-a933158906ff@arm.com>
Content-Language: en-GB
Cc: jason@lakedaemon.net, douliyangs@gmail.com, miquel.raynal@bootlin.com,
	tglx@linutronix.de, logang@deltatee.com, bigeasy@linutronix.de,
	linux-rt-users@vger.kernel.org
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
Message-ID: <20190423131945.5GswoH2UyyfF2r52vC4ek9I0GAjWDbWzRXZnvwb8Xsc@z>

On 23/04/2019 12:46, Marc Zyngier wrote:
> On 23/04/2019 11:51, Julien Grall wrote:
>> On 4/23/19 11:23 AM, Marc Zyngier wrote:
>>> Hi Julien,
>>
>> Hi Marc,
>>
>>> On 18/04/2019 18:26, Julien Grall wrote:
>>>> When an MSI doorbell is located downstream of an IOMMU, it is required
>>>> to swizzle the physical address with an appropriately-mapped IOVA for any
>>>> device attached to one of our DMA ops domain.
>>>>
>>>> At the moment, the allocation of the mapping may be done when composing
>>>> the message. However, the composing may be done in non-preemtible
>>>> context while the allocation requires to be called from preemptible
>>>> context.
>>>>
>>>> A follow-up patch will split the current logic in two functions
>>>> requiring to keep an IOMMU cookie per MSI.
>>>>
>>>> This patch introduces a new field in msi_desc to store an IOMMU cookie
>>>> when CONFIG_IOMMU_DMA is selected.
>>>>
>>>> Signed-off-by: Julien Grall <julien.grall@arm.com>
>>>> ---
>>>>    include/linux/msi.h | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/include/linux/msi.h b/include/linux/msi.h
>>>> index 7e9b81c3b50d..d7907feef1bb 100644
>>>> --- a/include/linux/msi.h
>>>> +++ b/include/linux/msi.h
>>>> @@ -77,6 +77,9 @@ struct msi_desc {
>>>>    	struct device			*dev;
>>>>    	struct msi_msg			msg;
>>>>    	struct irq_affinity_desc	*affinity;
>>>> +#ifdef CONFIG_IOMMU_DMA
>>>> +	const void			*iommu_cookie;
>>>> +#endif
>>>>    
>>>>    	union {
>>>>    		/* PCI MSI/X specific data */
>>>>
>>>
>>> Given that this is the only member in this structure that is dependent
>>> on a config option, you could also add a couple of accessors that would
>>> do nothing when IOMMU_DMA is not selected (and use that in the DMA code).
>>
>> I haven't seen any use of the helpers so far because the DMA code is
>> also protected by IOMMU_DMA.
>>
>> I can add the helpers in the next version if you see any use outside of
>> the DMA code.
> 
> There may not be any user user yet, but I'd surely like to see the
> accessors. This isn't very different from the stub functions you add in
> patch #2.

If you foresee this being useful in general, do you reckon it would be 
worth decoupling it under its own irqchip-layer Kconfig which can then 
be selected by IOMMU_DMA?

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
