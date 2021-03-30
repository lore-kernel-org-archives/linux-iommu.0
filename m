Return-Path: <SRS0=H7Zn=I4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F0CC433C1
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 01:58:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EE0A6157F
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 01:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE0A6157F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0ECA60818;
	Tue, 30 Mar 2021 01:58:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hwXQgGRXjEaC; Tue, 30 Mar 2021 01:58:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A9F360720;
	Tue, 30 Mar 2021 01:58:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5EC1BC000B;
	Tue, 30 Mar 2021 01:58:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EED3DC000A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 01:58:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF3FD402FA
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 01:58:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9NUYfkI7nCIq for <iommu@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 01:58:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D6352402F8
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 01:58:05 +0000 (UTC)
IronPort-SDR: 2K8APLwwIvvyNqZBiROtEO17S0A3J9JYem49T5+qBkGTe+/NeMzknW+sJp4fGqh5XKdTuTtnnP
 GmnPFdjNBiAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="276831830"
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; d="scan'208";a="276831830"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2021 18:58:03 -0700
IronPort-SDR: 4kBCccE83dlaNL80D5bdqGzxLDPB7kdzuqN0OJRCEslhjw4WhqBUSoiX0wmZgPL78MoAakqoM1
 Cwyk1mFWeGBQ==
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; d="scan'208";a="454801775"
Received: from meghadey-mobl1.amr.corp.intel.com (HELO [10.209.158.242])
 ([10.209.158.242])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2021 18:57:54 -0700
Subject: Re: [Patch V2 13/13] genirq/msi: Provide helpers to return Linux
 IRQ/dev_msi hw IRQ number
To: Marc Zyngier <maz@kernel.org>
References: <1614370277-23235-1-git-send-email-megha.dey@intel.com>
 <1614370277-23235-14-git-send-email-megha.dey@intel.com>
 <87y2ebqfw5.wl-maz@kernel.org>
 <5bed6fea-32e1-d909-0a5c-439d0f0a7dfe@intel.com>
 <87r1k2f4w2.wl-maz@kernel.org>
From: "Dey, Megha" <megha.dey@intel.com>
Message-ID: <64602269-5c82-46ce-b2a0-2586e68e258f@intel.com>
Date: Tue, 30 Mar 2021 07:27:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <87r1k2f4w2.wl-maz@kernel.org>
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

On 3/26/2021 6:28 PM, Marc Zyngier wrote:
> On Fri, 26 Mar 2021 01:02:43 +0000,
> "Dey, Megha" <megha.dey@intel.com> wrote:
>> Hi Marc,
>>
>> On 3/25/2021 10:53 AM, Marc Zyngier wrote:
>>> On Fri, 26 Feb 2021 20:11:17 +0000,
>>> Megha Dey <megha.dey@intel.com> wrote:
>>>> From: Dave Jiang <dave.jiang@intel.com>
>>>>
>>>> Add new helpers to get the Linux IRQ number and device specific index
>>>> for given device-relative vector so that the drivers don't need to
>>>> allocate their own arrays to keep track of the vectors and hwirq for
>>>> the multi vector device MSI case.
>>>>
>>>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>> Signed-off-by: Megha Dey <megha.dey@intel.com>
>>>> ---
>>>>    include/linux/msi.h |  2 ++
>>>>    kernel/irq/msi.c    | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>>>    2 files changed, 46 insertions(+)
>>>>
>>>> diff --git a/include/linux/msi.h b/include/linux/msi.h
>>>> index 24abec0..d60a6ba 100644
>>>> --- a/include/linux/msi.h
>>>> +++ b/include/linux/msi.h
>>>> @@ -451,6 +451,8 @@ struct irq_domain *platform_msi_create_irq_domain(struct fwnode_handle *fwnode,
>>>>    int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
>>>>    				   irq_write_msi_msg_t write_msi_msg);
>>>>    void platform_msi_domain_free_irqs(struct device *dev);
>>>> +int msi_irq_vector(struct device *dev, unsigned int nr);
>>>> +int dev_msi_hwirq(struct device *dev, unsigned int nr);
>>>>      /* When an MSI domain is used as an intermediate domain */
>>>>    int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
>>>> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
>>>> index 047b59d..f2a8f55 100644
>>>> --- a/kernel/irq/msi.c
>>>> +++ b/kernel/irq/msi.c
>>>> @@ -581,4 +581,48 @@ struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain)
>>>>    	return (struct msi_domain_info *)domain->host_data;
>>>>    }
>>>>    +/**
>>>> + * msi_irq_vector - Get the Linux IRQ number of a device vector
>>>> + * @dev: device to operate on
>>>> + * @nr: device-relative interrupt vector index (0-based).
>>>> + *
>>>> + * Returns the Linux IRQ number of a device vector.
>>>> + */
>>>> +int msi_irq_vector(struct device *dev, unsigned int nr)
>>>> +{
>>>> +	struct msi_desc *entry;
>>>> +	int i = 0;
>>>> +
>>>> +	for_each_msi_entry(entry, dev) {
>>>> +		if (i == nr)
>>>> +			return entry->irq;
>>>> +		i++;
>>> This obviously doesn't work with Multi-MSI, does it?
>> This API is only for devices that support device MSI interrupts. They
>> follow MSI-x format and don't support multi MSI (part of MSI).
>>
>> Not sure if I am missing something here, can you please let me know?
> Nothing in the prototype of the function indicates this limitation,
> nor does the documentation. And I'm not sure why you should exclude
> part of the MSI functionality here. It can't be for performance
> reason, so you might as well make sure this works for all the MSI
> variants:
>
> int msi_irq_vector(struct device *dev, unsigned int nr)
> {
> 	struct msi_desc *entry;
> 	int irq, index = 0;
>
> 	for_each_msi_vector(entry, irq, dev) {
> 		if (index == nr}
> 			return irq;
> 		index++;
> 	}
>
> 	return WARN_ON_ONCE(-EINVAL);
> }
Ok, got it!
>>>> +	}
>>>> +	WARN_ON_ONCE(1);
>>>> +	return -EINVAL;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(msi_irq_vector);
>>>> +
>>>> +/**
>>>> + * dev_msi_hwirq - Get the device MSI hw IRQ number of a device vector
>>>> + * @dev: device to operate on
>>>> + * @nr: device-relative interrupt vector index (0-based).
>>>> + *
>>>> + * Return the dev_msi hw IRQ number of a device vector.
>>>> + */
>>>> +int dev_msi_hwirq(struct device *dev, unsigned int nr)
>>>> +{
>>>> +	struct msi_desc *entry;
>>>> +	int i = 0;
>>>> +
>>>> +	for_each_msi_entry(entry, dev) {
>>>> +		if (i == nr)
>>>> +			return entry->device_msi.hwirq;
>>>> +		i++;
>>>> +	}
>>>> +	WARN_ON_ONCE(1);
>>>> +	return -EINVAL;
>>>> +}
> And this helper would be more generally useful if it returned the n-th
> msi_desc entry rather than some obscure field in a substructure.
>
> struct msi_desc *msi_get_nth_desc(struct device *dev, unsigned int nth)
> {
> 	struct msi_desc *entry = NULL;
> 	unsigned int i = 0;
>
> 	for_each_msi_entry(entry, dev) {
> 		if (i == nth)
> 			return entry;
>
> 		i++;
> 	}
>
> 	WARN_ON_ONCE(!entry);
> 	return entry;
> }
>
> You can always wrap it for your particular use case.
Yeah, makes sense.
>
>>>> +EXPORT_SYMBOL_GPL(dev_msi_hwirq);
>>>> +
>>>>    #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
>>> And what uses these helpers?]
>> These helpers are to be used by a driver series(Intel's IDXD driver)
>> which is currently stuck due to VFIO refactoring.
> Then I's suggest you keep the helpers together with the actual user,
> unless this can generally be useful to existing users (exported
> symbols without in-tree users is always a bit odd).
Yeah in the next submission, we will submit this patch series along with 
the user driver patch series.
>
> Thanks,
>
> 	M.
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
