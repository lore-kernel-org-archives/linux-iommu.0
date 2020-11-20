Return-Path: <SRS0=3eTK=E2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A32C388F9
	for <iommu@archiver.kernel.org>; Fri, 20 Nov 2020 02:19:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7112F2225E
	for <iommu@archiver.kernel.org>; Fri, 20 Nov 2020 02:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7112F2225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E705D8756E;
	Fri, 20 Nov 2020 02:19:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yjp1o27e7acq; Fri, 20 Nov 2020 02:19:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3CD658753E;
	Fri, 20 Nov 2020 02:19:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FD9DC1825;
	Fri, 20 Nov 2020 02:19:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D662DC0891
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 02:19:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C405A87543
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 02:19:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ObT7SD6cvbi9 for <iommu@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 02:19:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1824F8753E
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 02:19:10 +0000 (UTC)
IronPort-SDR: M0cI0hzrpNameAJojCWf0ko4WVzxs44ZO7qLePcbtcelSoZUmXj2Y+m0yUhRcS3dWkKpTORykU
 Lj5XpAAF7FHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="170619555"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; d="scan'208";a="170619555"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2020 18:19:09 -0800
IronPort-SDR: 8TDpV45jlwwNGBaezksk41B84fiV9BfP07uhkBOnMlP/4RxYlydoKOLDwq3lSAF9sAZ6LWbRIY
 bFcLA9N1ud2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; d="scan'208";a="431430135"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
 by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2020 18:19:07 -0800
Subject: Re: [Patch V8 1/3] iommu: Add support to change default domain of an
 iommu group
To: Will Deacon <will@kernel.org>
References: <20200925190620.18732-1-ashok.raj@intel.com>
 <20200925190620.18732-2-ashok.raj@intel.com>
 <20201118135153.GB2177@willie-the-truck>
 <568d4dee-ad10-ca4f-d51a-8909afb6b782@linux.intel.com>
 <20201119085303.GA3599@willie-the-truck>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <ee19b2ff-1cb6-7db1-9fc9-9e7fb8df5de6@linux.intel.com>
Date: Fri, 20 Nov 2020 10:11:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201119085303.GA3599@willie-the-truck>
Content-Language: en-US
Cc: Ashok Raj <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

Hi Will,

On 11/19/20 4:53 PM, Will Deacon wrote:
> On Thu, Nov 19, 2020 at 10:18:05AM +0800, Lu Baolu wrote:
>> The original author of this patch series has left Intel. I am now the
>> backup.
> 
> Ok, thanks for letting me know.
> 
>> On 11/18/20 9:51 PM, Will Deacon wrote:
>>> On Fri, Sep 25, 2020 at 12:06:18PM -0700, Ashok Raj wrote:
>>>> From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> 
> [...]
> 
>>>> +free_new_domain:
>>>> +	iommu_domain_free(group->default_domain);
>>>> +	group->default_domain = prev_dom;
>>>> +	group->domain = prev_dom;i
>>>
>>> Hmm. This seems to rely on all users of group->default_domain holding the
>>> group->mutex. Have you confirmed that this is the case? There's a funny
>>> use of iommu_group_get() in the exynos IOMMU driver at least.
>>
>> Emm. This change happens within the area with group->mutex held. Or I
>> am not getting your point?
> 
> Yeah, sorry, I wasn't very clear. This code holds the group->mutex, and it
> relies on _anybody_ else who wants to inspect group->default_domain also
> holding that mutex, otherwise they could observe a transient domain pointer
> which we free on the failure path here.

Clear to me now. Thanks for explanation. :-)

Changing default domain through sysfs requires the users to ubind any
driver from the devices in the group. There's a check code and return
failure if this requirement doesn't meet.

So we only need to consider the device release path. device_lock(dev) is
used in this patch to guarantee that no device release happens at the
same time.

> 
> My question is whether or not there is code that inspects
> group->default_domain without group->mutex held? The exynos case doesn't
> obviously hold it, and I'd like to make sure that there aren't others that
> we need to worry about.

I searched the code. The exynos is the only case that inspects
group->default_domain without holding the mutex during run time. It's in
the device release path, so I think it's safe.

> 
> Does that make more sense?

Yes. Thanks!

> 
> Thanks,
> 
> Will
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
