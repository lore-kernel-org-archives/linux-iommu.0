Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DFBC433EF
	for <iommu@archiver.kernel.org>; Fri, 14 Jan 2022 03:13:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 39407402C3;
	Fri, 14 Jan 2022 03:13:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YPiX8GhaqLiC; Fri, 14 Jan 2022 03:13:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C4E1940275;
	Fri, 14 Jan 2022 03:13:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99EADC0030;
	Fri, 14 Jan 2022 03:13:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0CA1C001E
 for <iommu@lists.linux-foundation.org>; Fri, 14 Jan 2022 03:13:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BB47A60AA9
 for <iommu@lists.linux-foundation.org>; Fri, 14 Jan 2022 03:13:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TOkldFfwjZmh for <iommu@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 03:13:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2019460A89
 for <iommu@lists.linux-foundation.org>; Fri, 14 Jan 2022 03:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1642130016; x=1673666016;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=Szmsi12k0LI7khEwP6fZbgXfWxt5yjoq0TShGWuPc+o=;
 b=RzGb35yihIrzCKnfbKbShf42UGHyg+2WwuphQ63cx4z2hcNUlivEzCA1
 4OUkc9NhkoYYjIW70Bhak5sjF2bLbSF44dkzA0iohRpiIYBFozJOZbiTA
 EjXQKt7NcQz6E5CeE0172Mp9tUlV2L5O3+cc5i2hIJL4eezNlsVa6uZ3M
 +w5OkUZlEUEtP8k8aJoqRO+33cBYeaFjU1raGL+RyVgwZxWxGEDr2nLk0
 SVKEx8ivM8FyaX1RAhlRkfcDJDwsJMO3HRGAgvvfXhkANhOB5+EXMdcgp
 slArw+Z2LWVghXFNL8UwUB4gMcr20eVToTrCGTZJK+PeaWG+6hbsycopm w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="244128683"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; d="scan'208";a="244128683"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2022 19:13:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; d="scan'208";a="529971183"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 13 Jan 2022 19:13:33 -0800
Subject: Re: [PATCH] iommu/vt-d: Fix PCI bus rescan device hot add
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1642080198-10971-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <b2139255-2463-c62f-4746-8df7f3f49221@linux.intel.com>
 <20220113191122.53bc6ac0@jacob-builder>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <1b8d3145-c404-e952-e61e-5cdc2f6a92a6@linux.intel.com>
Date: Fri, 14 Jan 2022 11:12:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220113191122.53bc6ac0@jacob-builder>
Content-Language: en-US
Cc: Raj Ashok <ashok.raj@intel.com>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Jacob Pan <jacob.jun.pan@intel.com>
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

On 1/14/22 11:11 AM, Jacob Pan wrote:
> On Fri, 14 Jan 2022 08:58:53 +0800, Lu Baolu<baolu.lu@linux.intel.com>
> wrote:
> 
>> Hi Jacob,
>>
>> On 1/13/22 9:23 PM, Jacob Pan wrote:
>>> During PCI bus rescan, adding new devices involve two notifiers.
>>> 1. dmar_pci_bus_notifier()
>>> 2. iommu_bus_notifier()
>>> The current code sets #1 as low priority (INT_MIN) which resulted in #2
>>> being invoked first. The result is that struct device pointer cannot be
>>> found in DRHD search for the new device's DMAR/IOMMU. Subsequently, the
>>> device is put under the "catch-all" IOMMU instead of the correct one.
>>>
>>> This could cause system hang when device TLB invalidation is sent to the
>>> wrong IOMMU. Invalidation timeout error or hard lockup can be observed.
>>>
>>> This patch fixes the issue by setting a higher priority for
>>> dmar_pci_bus_notifier. DRHD search for a new device will find the
>>> correct IOMMU.
>>>
>>> Fixes: 59ce0515cdaf ("iommu/vt-d: Update DRHD/RMRR/ATSR device scope")
>>> Reported-by: Zhang, Bernice<bernice.zhang@intel.com>
>>> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
>>> ---
>>>    drivers/iommu/intel/dmar.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>>> index 915bff76fe96..5d07e5b89c2e 100644
>>> --- a/drivers/iommu/intel/dmar.c
>>> +++ b/drivers/iommu/intel/dmar.c
>>> @@ -385,7 +385,7 @@ static int dmar_pci_bus_notifier(struct
>>> notifier_block *nb,
>>>    static struct notifier_block dmar_pci_bus_nb = {
>>>    	.notifier_call = dmar_pci_bus_notifier,
>>> -	.priority = INT_MIN,
>>> +	.priority = INT_MAX,
>>>    };
>>>    
>>>    static struct dmar_drhd_unit *
>>>    
>> Nice catch! dmar_pci_bus_add_dev() should take place*before*
>> iommu_probe_device(). This change enforces this with a higher notifier
>> priority for dmar callback.
>>
>> Comparably, dmar_pci_bus_del_dev() should take place*after*
>> iommu_release_device(). Perhaps we can use two notifiers, one for
>> ADD_DEVICE (with .priority=INT_MAX) and the other for REMOVE_DEVICE
>> (with .priority=INT_MIN)?
>>
> Since device_to_iommu() lookup in intel_iommu_release_device() only
> checks if device is under "an" IOMMU, not "the" IOMMU. Then the remove path
> order is not needed, right?
> 
> I know this is not robust, but having so many notifiers with implicit
> priority is not clean either.
> 
> Perhaps, we should have explicit priority defined around iommu_bus
> notifier? i.e.
> 
> @@ -1841,6 +1841,7 @@ static int iommu_bus_init(struct bus_type *bus, const
> struct iommu_ops *ops) return -ENOMEM;
>          nb->notifier_call = iommu_bus_notifier;
>                         
> +       nb->priority = IOMMU_BUS_NOTIFY_PRIORITY;
>                         
> 
>   static struct notifier_block dmar_pci_bus_add_nb = {
>          .notifier_call = dmar_pci_bus_notifier,
> -       .priority = INT_MIN,
> +       .priority = IOMMU_BUS_NOTIFY_PRIORITY + 1,
>   };
> 
>   static struct notifier_block dmar_pci_bus_remove_nb = {
>          .notifier_call = dmar_pci_bus_notifier,
> -       .priority = INT_MIN,
> +       .priority = IOMMU_BUS_NOTIFY_PRIORITY - 1,
>   };

IOMMU_BUS_NOTIFY_PRIORITY by default is 0. So you can simply use 1 and
-1? Adding a comment around it will be helpful.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
