Return-Path: <SRS0=PRYs=65=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0ACC433E0
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 19:23:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65BCE2070A
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 19:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BCE2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 29A8C87F55;
	Fri, 15 May 2020 19:23:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ax5VzzEZr15m; Fri, 15 May 2020 19:23:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7A3D787F41;
	Fri, 15 May 2020 19:23:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63614C0859;
	Fri, 15 May 2020 19:23:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C899C016F
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 19:23:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 68D5B89B92
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 19:23:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vv8bUAJwZqQa for <iommu@lists.linux-foundation.org>;
 Fri, 15 May 2020 19:23:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 57BF289B91
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 19:23:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADD392F;
 Fri, 15 May 2020 12:23:14 -0700 (PDT)
Received: from [10.57.27.64] (unknown [10.57.27.64])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F16A43F71E;
 Fri, 15 May 2020 12:23:13 -0700 (PDT)
Subject: Re: [PATCH] iommu: Implement deferred domain attachment
To: Joerg Roedel <jroedel@suse.de>
References: <20200515094519.20338-1-joro@8bytes.org>
 <d4e1cd9e-fc83-d41a-49c0-8f14f44b2701@arm.com>
 <20200515161400.GZ18353@8bytes.org>
 <e7bdcbf1-a713-618d-3e02-037f509a17e9@arm.com>
 <20200515182600.GJ8135@suse.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f5c6ec5b-06c6-42e6-b74d-71cf29b44b8d@arm.com>
Date: Fri, 15 May 2020 20:23:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200515182600.GJ8135@suse.de>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Tom Murphy <murphyt7@tcd.ie>
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

On 2020-05-15 19:26, Joerg Roedel wrote:
> On Fri, May 15, 2020 at 05:28:53PM +0100, Robin Murphy wrote:
>> On 2020-05-15 17:14, Joerg Roedel wrote:
>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>> index ba128d1cdaee..403fda04ea98 100644
>>> --- a/drivers/iommu/dma-iommu.c
>>> +++ b/drivers/iommu/dma-iommu.c
>>> @@ -362,8 +362,8 @@ static int iommu_dma_deferred_attach(struct device *dev,
>>>    		return 0;
>>>    	if (unlikely(ops->is_attach_deferred &&
>>> -			ops->is_attach_deferred(domain, dev)))
>>> -		return iommu_attach_device(domain, dev);
>>> +		     ops->is_attach_deferred(domain, dev)))
>>> +		return iommu_attach_device_no_defer(domain, dev);
>>
>> Wouldn't it be simpler to just invoke ops->attach_dev directly and avoid
>> having to formalise a public interface that nobody else should ever use
>> anyway?
> 
> That would omit the ops->attach_dev != NULL check and the trace-point on
> device attach. Besides that, it would be a layering violation. But the
> function is of course entirely internal to the iommu subsytem and is a
> good canditate to be moved to a header file in drivers/iommu.

Sure, checking the pointer before calling was implied, but the 
tracepoint is a good argument, I'd forgotten about that :)

>> @@ -746,8 +747,11 @@ int iommu_group_add_device(struct iommu_group *group,
>> struct device *dev)
>>
>>          mutex_lock(&group->mutex);
>>          list_add_tail(&device->list, &group->devices);
>> -       if (group->domain)
>> -               ret = __iommu_attach_device(group->domain, dev);
>> +       domain = group->domain;
>> +       if (domain && (!domain->ops->is_attach_deferred ||
>> +                      !domain->ops->is_attach_deferred(domain, dev)))
>> +               ret = __iommu_attach_device(domain, dev);
>> +       }
>>          mutex_unlock(&group->mutex);
>>          if (ret)
>>                  goto err_put_group;
> 
> No, doing this in iommu_group_add_device() doesn't solve the problem.
> The attach must not happen before a device driver took control of the
> device and silenced any DMA initiated by the old kernel. At probe time
> this isn't guaranteed.

But that's not what this is; this is (supposed to be) the exact same 
"don't actually perform the attach yet" logic as before, just 
restricting it to default domains in the one place that it actually 
needs to be, so as not to fundamentally bugger up iommu_attach_device() 
in a way that prevents it from working as expected at the correct point 
later.

Thinking a bit more, consider if the driver resets the device then 
attaches it straight to its own unmanaged domain rather than calling any 
DMA ops (e.g. VFIO?) - it looks like that would also be totally broken 
right now, and no amount of bodges in iommu-dma is going to help there.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
