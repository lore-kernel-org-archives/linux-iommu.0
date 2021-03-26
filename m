Return-Path: <SRS0=A+5j=IY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF98FC433DB
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 01:02:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F26361A42
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 01:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F26361A42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1F81E405A8;
	Fri, 26 Mar 2021 01:02:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vo1YvRaLYF44; Fri, 26 Mar 2021 01:02:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 04FFA405A2;
	Fri, 26 Mar 2021 01:02:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4242C000E;
	Fri, 26 Mar 2021 01:02:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57CD7C000A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 01:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 46AE784BCF
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 01:02:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 46pn1E9fzg9S for <iommu@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 01:02:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EE37684BCE
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 01:02:53 +0000 (UTC)
IronPort-SDR: esBWeSC4bg0vp9RaSavOoh0JnTzPaxgHe+CGDiCy8V4O7UcmwL1GkXQNkUKNbayCWcbp1NdPUl
 /1mmQ1Pki2QQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="178173426"
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; d="scan'208";a="178173426"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2021 18:02:53 -0700
IronPort-SDR: UDjVUON9MNVL2rohRWqpB9EM7W7/zF4vDcaB4PowV6aLek7/WP4/rjNZWtDjs4gYTRNHM2jka3
 JoITW8peb0vw==
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; d="scan'208";a="525855122"
Received: from meghadey-mobl1.amr.corp.intel.com (HELO [10.209.174.55])
 ([10.209.174.55])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2021 18:02:50 -0700
Subject: Re: [Patch V2 13/13] genirq/msi: Provide helpers to return Linux
 IRQ/dev_msi hw IRQ number
To: Marc Zyngier <maz@kernel.org>
References: <1614370277-23235-1-git-send-email-megha.dey@intel.com>
 <1614370277-23235-14-git-send-email-megha.dey@intel.com>
 <87y2ebqfw5.wl-maz@kernel.org>
From: "Dey, Megha" <megha.dey@intel.com>
Message-ID: <5bed6fea-32e1-d909-0a5c-439d0f0a7dfe@intel.com>
Date: Thu, 25 Mar 2021 18:02:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <87y2ebqfw5.wl-maz@kernel.org>
Content-Language: en-US
Cc: alex.williamson@redhat.com, kevin.tian@intel.com, tony.luck@intel.com,
 dave.jiang@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
 ravi.v.shankar@intel.com, linux-pci@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jgg@mellanox.com, bhelgaas@google.com, tglx@linutronix.de,
 dan.j.williams@intel.com, dwmw@amazon.co.uk
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

Hi Marc,

On 3/25/2021 10:53 AM, Marc Zyngier wrote:
> On Fri, 26 Feb 2021 20:11:17 +0000,
> Megha Dey <megha.dey@intel.com> wrote:
>> From: Dave Jiang <dave.jiang@intel.com>
>>
>> Add new helpers to get the Linux IRQ number and device specific index
>> for given device-relative vector so that the drivers don't need to
>> allocate their own arrays to keep track of the vectors and hwirq for
>> the multi vector device MSI case.
>>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> Signed-off-by: Megha Dey <megha.dey@intel.com>
>> ---
>>   include/linux/msi.h |  2 ++
>>   kernel/irq/msi.c    | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 46 insertions(+)
>>
>> diff --git a/include/linux/msi.h b/include/linux/msi.h
>> index 24abec0..d60a6ba 100644
>> --- a/include/linux/msi.h
>> +++ b/include/linux/msi.h
>> @@ -451,6 +451,8 @@ struct irq_domain *platform_msi_create_irq_domain(struct fwnode_handle *fwnode,
>>   int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
>>   				   irq_write_msi_msg_t write_msi_msg);
>>   void platform_msi_domain_free_irqs(struct device *dev);
>> +int msi_irq_vector(struct device *dev, unsigned int nr);
>> +int dev_msi_hwirq(struct device *dev, unsigned int nr);
>>   
>>   /* When an MSI domain is used as an intermediate domain */
>>   int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
>> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
>> index 047b59d..f2a8f55 100644
>> --- a/kernel/irq/msi.c
>> +++ b/kernel/irq/msi.c
>> @@ -581,4 +581,48 @@ struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain)
>>   	return (struct msi_domain_info *)domain->host_data;
>>   }
>>   
>> +/**
>> + * msi_irq_vector - Get the Linux IRQ number of a device vector
>> + * @dev: device to operate on
>> + * @nr: device-relative interrupt vector index (0-based).
>> + *
>> + * Returns the Linux IRQ number of a device vector.
>> + */
>> +int msi_irq_vector(struct device *dev, unsigned int nr)
>> +{
>> +	struct msi_desc *entry;
>> +	int i = 0;
>> +
>> +	for_each_msi_entry(entry, dev) {
>> +		if (i == nr)
>> +			return entry->irq;
>> +		i++;
> This obviously doesn't work with Multi-MSI, does it?

This API is only for devices that support device MSI interrupts. They 
follow MSI-x format and don't support multi MSI (part of MSI).

Not sure if I am missing something here, can you please let me know?

>
>> +	}
>> +	WARN_ON_ONCE(1);
>> +	return -EINVAL;
>> +}
>> +EXPORT_SYMBOL_GPL(msi_irq_vector);
>> +
>> +/**
>> + * dev_msi_hwirq - Get the device MSI hw IRQ number of a device vector
>> + * @dev: device to operate on
>> + * @nr: device-relative interrupt vector index (0-based).
>> + *
>> + * Return the dev_msi hw IRQ number of a device vector.
>> + */
>> +int dev_msi_hwirq(struct device *dev, unsigned int nr)
>> +{
>> +	struct msi_desc *entry;
>> +	int i = 0;
>> +
>> +	for_each_msi_entry(entry, dev) {
>> +		if (i == nr)
>> +			return entry->device_msi.hwirq;
>> +		i++;
>> +	}
>> +	WARN_ON_ONCE(1);
>> +	return -EINVAL;
>> +}
>> +EXPORT_SYMBOL_GPL(dev_msi_hwirq);
>> +
>>   #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
> And what uses these helpers?]
These helpers are to be used by a driver series(Intel's IDXD driver) 
which is currently stuck due to VFIO refactoring.
>
> Thanks,
>
> 	M.
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
