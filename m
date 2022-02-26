Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F96C433EF
	for <iommu@archiver.kernel.org>; Sat, 26 Feb 2022 06:42:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC7F983EF8;
	Sat, 26 Feb 2022 06:42:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NpO6hroTb2wS; Sat, 26 Feb 2022 06:42:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7A4B883EF1;
	Sat, 26 Feb 2022 06:42:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B71BC0070;
	Sat, 26 Feb 2022 06:42:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65FFEC001A
 for <iommu@lists.linux-foundation.org>; Sat, 26 Feb 2022 06:42:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4CB01402B1
 for <iommu@lists.linux-foundation.org>; Sat, 26 Feb 2022 06:42:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SN-5ycxXNqa7 for <iommu@lists.linux-foundation.org>;
 Sat, 26 Feb 2022 06:42:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E02E9400FF
 for <iommu@lists.linux-foundation.org>; Sat, 26 Feb 2022 06:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645857743; x=1677393743;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=RsNdK8sgWWEesCkV2+XUeuGZXYHubEdfQev8t+XfkrU=;
 b=an6A+IwRugZxRKQsUPeR2FBuzDSzpyraEZb9EQNyhUKv0r39FzirA3pO
 PfA+F28X0fuQ9JMa45w71gaECSuSPnKd4rNxnDD6O4ABr5VJy7IgR241e
 0U/yyHarM+v8V8wXlJ9p3Hkp9zdqIKBhi5L26LMd6so02k6hzblbflpdB
 pDCi3liOpGACyME+Ug5KKuCEIr7hPUC72fCmK2ZyU0iNhx4G/Qzh4ujf3
 dFWbS+47LL3fx0Fxx78UxdugK89Z3f3IFoOFgW5iUA7w+xzz5EkGr5PcB
 DvFJAuxsuSvZ/mX+NHTEkeCiJE43X66wTXyQ0Ae3pCG72vdNGlo/0Ouxb w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="313355694"
X-IronPort-AV: E=Sophos;i="5.90,138,1643702400"; d="scan'208";a="313355694"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2022 22:42:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,138,1643702400"; d="scan'208";a="533838874"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 25 Feb 2022 22:42:16 -0800
Message-ID: <30755cb5-d366-6c24-3025-ce1d94e82a8d@linux.intel.com>
Date: Sat, 26 Feb 2022 14:40:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] iommu/vt-d: Add RPLS to quirk list to skip TE disabling
Content-Language: en-US
To: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
 "Surendrakumar Upadhyay, TejaskumarX"
 <tejaskumarx.surendrakumar.upadhyay@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <20220223062957.31797-1-tejaskumarx.surendrakumar.upadhyay@intel.com>
 <8dcb852f-ef40-5b93-3713-a2d701d90320@linux.intel.com>
 <2eb4e522d6294a6ade91b89ea1c5cc7c8dac1e51.camel@intel.com>
 <9a3d9767-e63b-0bcc-99a9-5e1cf9c31493@linux.intel.com>
 <f398077ff925fd8ed5697c777fa674157977dce6.camel@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <f398077ff925fd8ed5697c777fa674157977dce6.camel@intel.com>
Cc: "Talla, RavitejaX Goud" <ravitejax.goud.talla@intel.com>
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

On 2/25/22 10:12 PM, Vivi, Rodrigo wrote:
> On Fri, 2022-02-25 at 10:20 +0800, Lu Baolu wrote:
>> On 2/24/22 9:39 PM, Vivi, Rodrigo wrote:
>>> On Thu, 2022-02-24 at 13:42 +0800, Lu Baolu wrote:
>>>> On 2/23/22 2:29 PM, Tejas Upadhyay wrote:
>>>>> The VT-d spec requires (10.4.4 Global Command Register, TE
>>>>> field) that:
>>>>>
>>>>> Hardware implementations supporting DMA draining must drain
>>>>> any in-flight DMA read/write requests queued within the
>>>>> Root-Complex before completing the translation enable
>>>>> command and reflecting the status of the command through
>>>>> the TES field in the Global Status register.
>>>>>
>>>>> Unfortunately, some integrated graphic devices fail to do
>>>>> so after some kind of power state transition. As the
>>>>> result, the system might stuck in iommu_disable_translati
>>>>> on(), waiting for the completion of TE transition.
>>>>>
>>>>> This adds RPLS to a quirk list for those devices and skips
>>>>> TE disabling if the qurik hits.
>>>>>
>>>>> Fixes:https://gitlab.freedesktop.org/drm/intel/-/issues/4898
>>>>> Fixes: LCK-10789
>>>> Remove this please.
>>> good catch. Wrong use of Fixes tag.
>>> "Fixes:" should only be used for patches fixing other patches and
>>> mentioning the commit id.
>> This is still a fix patch, right? If so,
>>
>> Fixes: b1012ca8dc4f9 "iommu/vt-d: Skip TE disabling on quirky gfx
>> dedicated iommu"
>> Cc:stable@vger.kernel.org
> hm... you have a point, but I'm not comfortable with this because
> for me it is like an addition of a pci id of a new platform.
> Older kernels won't have the support for that anyway.
> and if for every new platform we add here we need to blame this
> b1012ca8dc4f9 (which did the right time when it was created)
> it doesn't look fair to me.

I have no idea about the graphic roadmap. So I'd like you to decide it.

> 
>>> Baolu,
>>> could you mind if we use
>>>
>>> Closes:https://gitlab.freedesktop.org/drm/intel/-/issues/4898
>>>
>>> or maybe
>>>
>>> References:https://gitlab.freedesktop.org/drm/intel/-/issues/4898
>>>
>>> This last one seems to be the one use in drivers/iommu
>>> and the Closes is what we use in drm-intel, hence the one used
>>> with gitlab.freedesktop links in general.
>> How about "Link:"?
>>
>> As Documentation/process/submitting-patches.rst states:
>>
>> If related discussions or any other background information behind the
>> change
>> can be found on the web, add 'Link:' tags pointing to it. In case
>> your patch
>> fixes a bug, for example, add a tag with a URL referencing the report
>> in the
>> mailing list archives or a bug tracker; if the patch is a result of
>> some
>> earlier mailing list discussion or something documented on the web,
>> point to
>> it.
> yeap, "Link:" works well too.
> 
> With these changes could we get your ack to merge to drm-intel?

This change in VT-d driver looks good to me.

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
