Return-Path: <SRS0=smho=GI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E89C433DB
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 01:59:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 011F122286
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 01:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011F122286
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9F8FF8602E;
	Tue,  5 Jan 2021 01:59:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iu0e1deEUU3W; Tue,  5 Jan 2021 01:59:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 93AC985F9B;
	Tue,  5 Jan 2021 01:59:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D2D4C088B;
	Tue,  5 Jan 2021 01:59:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DE43C013A
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 01:59:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7BA988700F
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 01:59:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QVwM-72kF5OZ for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 01:59:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5F0BD87004
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 01:59:31 +0000 (UTC)
IronPort-SDR: xze7eZV54KRCLJGAxFVIzc47aiv6lcIPp0xoRwdUZ/cl5lvlpnyQYKVVHM65GwwW1g9PrwYw/c
 6T/oNzeiD8ow==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="177190607"
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; d="scan'208";a="177190607"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jan 2021 17:59:30 -0800
IronPort-SDR: Op2msTBlwNLPz07pYNPWll39t/VmwFkbbW+1+wSBDD7gaLf08oZ5Lk3wdkaNVHfXtXi5KZ0rDa
 vijOeRe91zSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; d="scan'208";a="462143879"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
 by fmsmga001.fm.intel.com with ESMTP; 04 Jan 2021 17:59:27 -0800
Subject: Re: [PATCH] iommu/intel: Fix memleak in intel_irq_remapping_alloc
To: dinghao.liu@zju.edu.cn
References: <20210102095029.29053-1-dinghao.liu@zju.edu.cn>
 <18add30d-a830-c531-6fd2-58a1898b157f@linux.intel.com>
 <50870a42.15f1a.176c66eaf92.Coremail.dinghao.liu@zju.edu.cn>
 <6e1ce9ac-ac17-2b16-84d3-a18c011768f2@linux.intel.com>
 <3b0b2129.17762.176c6e9114d.Coremail.dinghao.liu@zju.edu.cn>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <dda6e03a-147a-a482-4f31-f3dcb8aa47bd@linux.intel.com>
Date: Tue, 5 Jan 2021 09:51:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3b0b2129.17762.176c6e9114d.Coremail.dinghao.liu@zju.edu.cn>
Content-Language: en-US
Cc: Will Deacon <will@kernel.org>, kjlu@umn.edu, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>,
 David Woodhouse <dwmw2@infradead.org>, Jiang Liu <jiang.liu@linux.intel.com>
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

On 1/3/21 2:22 PM, dinghao.liu@zju.edu.cn wrote:
>> On 2021/1/3 12:08, dinghao.liu@zju.edu.cn wrote:
>>>> Hi,
>>>>
>>>> On 2021/1/2 17:50, Dinghao Liu wrote:
>>>>> When irq_domain_get_irq_data() or irqd_cfg() fails
>>>>> meanwhile i == 0, data allocated by kzalloc() has not
>>>>> been freed before returning, which leads to memleak.
>>>>>
>>>>> Fixes: b106ee63abccb ("irq_remapping/vt-d: Enhance Intel IR driver to support hierarchical irqdomains")
>>>>> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
>>>>> ---
>>>>>     drivers/iommu/intel/irq_remapping.c | 2 ++
>>>>>     1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
>>>>> index aeffda92b10b..cdaeed36750f 100644
>>>>> --- a/drivers/iommu/intel/irq_remapping.c
>>>>> +++ b/drivers/iommu/intel/irq_remapping.c
>>>>> @@ -1354,6 +1354,8 @@ static int intel_irq_remapping_alloc(struct irq_domain *domain,
>>>>>     		irq_cfg = irqd_cfg(irq_data);
>>>>>     		if (!irq_data || !irq_cfg) {
>>>>>     			ret = -EINVAL;
>>>>> +			kfree(data);
>>>>> +			data = NULL;
>>>>
>>>> Do you need to check (i == 0) here? @data will not be used anymore as it
>>>> goes to out branch, why setting it to NULL here?
>>>>
>>>
>>> data will be passed to ire_data->chip_data when i == 0 and
>>> intel_free_irq_resources() will free it on failure. Thus I
>>
>> Isn't it going to "goto out_free_data"? If "i == 0", the allocated @data
>> won't be freed by intel_free_irq_resources(), hence memory leaking. Does
>> this patch aim to fix this?
>>
>> Best regards,
>> baolu
>>
> 
> Correct, this is what I mean. When i > 0, data has been passed to
> irq_data->chip_data, which will be freed in intel_free_irq_resources()
> on failure. So there is no memleak in this case. The memleak only occurs
> on failure when i == 0 (data has not been passed to irq_data->chip_data).

So how about

diff --git a/drivers/iommu/intel/irq_remapping.c 
b/drivers/iommu/intel/irq_remapping.c
index aeffda92b10b..685200a5cff0 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1353,6 +1353,8 @@ static int intel_irq_remapping_alloc(struct 
irq_domain *domain,
                 irq_data = irq_domain_get_irq_data(domain, virq + i);
                 irq_cfg = irqd_cfg(irq_data);
                 if (!irq_data || !irq_cfg) {
+                       if (!i)
+                               kfree(data);
                         ret = -EINVAL;
                         goto out_free_data;
                 }

> I set data to NULL after kfree() in this patch to prevent double-free
> when the failure occurs at i > 0.

if i>0, @data has been passed and will be freed by
intel_free_irq_resources() on the failure path. No need to free or
clear, right?

Best regards,
baolu

> 
> Regards,
> Dinghao
> 
>>> set it to NULL to prevent double-free. However, if we add
>>> a check (i == 0) here, we will not need to set it to NULL.
>>> If this is better, I will resend a new patch soon.
>>>
>>> Regards,
>>> Dinghao
>>>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
