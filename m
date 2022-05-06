Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CF7C4332F
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 16:44:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C7173410A0;
	Fri,  6 May 2022 16:44:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mW39YSp7B5pa; Fri,  6 May 2022 16:44:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3E095410B4;
	Fri,  6 May 2022 16:44:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06F32C0032;
	Fri,  6 May 2022 16:44:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 108F9C002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 16:44:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EB744410B4
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 16:44:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6tYWX1ckrUVN for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 16:44:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 66AC1410A0
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 16:44:18 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C08AD113E;
 Fri,  6 May 2022 09:44:17 -0700 (PDT)
Received: from [10.57.80.111] (unknown [10.57.80.111])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D0E53F85F;
 Fri,  6 May 2022 09:44:16 -0700 (PDT)
Message-ID: <9b19440a-9cee-2f3b-8ab4-1316dffa33fb@arm.com>
Date: Fri, 6 May 2022 17:44:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] iommu: Reorganize __iommu_attach_group()
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
References: <0-v1-9bdc3d71e81c+494-iommu_attach_group_jgg@nvidia.com>
 <94ced5af-820d-8fe7-4bb1-3d552a45b80c@arm.com>
 <20220506132113.GB522325@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220506132113.GB522325@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>
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

On 2022-05-06 14:21, Jason Gunthorpe wrote:
> On Fri, May 06, 2022 at 10:12:29AM +0100, Robin Murphy wrote:
>> On 2022-05-05 17:15, Jason Gunthorpe via iommu wrote:
>>> Call iommu_group_do_attach_device() only from
>>> __iommu_group_attach_domain() which should be used to attach any domain to
>>> the group.
>>>
>>> The only unique thing __iommu_attach_group() does is to check if the group
>>> is already attached to some caller specified group. Put this test into
>>> __iommu_group_is_core_domain(), matching the
>>> __iommu_group_attach_core_domain() nomenclature.
>>>
>>> Change the two callers to directly call __iommu_group_attach_domain() and
>>> test __iommu_group_is_core_domain().
>>>
>>> iommu_attach_device() should trigger a WARN_ON if the group is attached as
>>> the caller is using the function wrong.
>>
>> Nit: if that's true then it's equally true for iommu_attach_group() as well.
> 
> Is it? I didn't check this as closely..

Well, there certainly seems no obvious reason for one to WARN where the 
other fails quietly. Either it's an egregious loss of internal 
consistency to not know whether your thing is already attached or it 
isn't, but I don't see why the exact flavour of attach API called should 
matter.

>>> @@ -2110,6 +2100,12 @@ static int __iommu_group_attach_domain(struct iommu_group *group,
>>>    	return 0;
>>>    }
>>> +static bool __iommu_group_is_core_domain(struct iommu_group *group)
>>
>> I can see the thought process behind it, but once we've had some time away
>> from actively working on this area, this is clearly going to be a terrible
>> name.
> 
> We don't have a name for the set of domains owned by the core code vs a
> domain set externally.
> 
> If you don't like core how about internal/external?

Oh no, I rather like the "core domain" nomenclature, it's the 
"iommu_group_is_..." part that then fails to parse sensibly.

> __iommu_group_set_internal_domain()
> __iommu_group_internal_domain_attached() / __iommu_group_external_domain_attached() ?
> 
> I wanted to use the word 'user' here (ie kernel user of the iommu
> kAPI) for external domain but that felt confusing as well given we are
> talking about introducing userspace domains for nesting.
> 
>> Even getting past that, does it make sense to say NULL
>> is a core domain? I'm not convinced.
> 
> NULL is not an externally imposed domain so it is definately a
> core/internal domain in this logic.

So if it *is* a domain then I can call NULL->attach_dev() and...? ;)

It's true that it's not a non-core domain, but IMO the two negatives 
don't simply cancel out. Hence why I think it's easier to try framing it 
in terms of what the *result* implies, rather than wrestle with trying 
to concisely capture that the check itself is approximately
iommu_group_is_not_already_attached_to_user_allocated_domain().

>> For the sake of future readability, I'd
>> prefer to call this something more purpose-related like
>> __iommu_group_can_attach()
> 
> That is not the case - we can always attach any domain.

No, in the context of the iommu_attach_{device,group}() APIs where this 
helper is relevant, after a successful attach, it has long been required 
to detach before another attach can be performed. That's literally the 
code you're moving around in this patch.

(Prior to default domains that wasn't actually enforced, but I doubt all 
the drivers would have handled it correctly.)

This is precisely why I'm starting to think it would be beneficial to 
differentiate the internal interface now that it's firmly moving away 
from the attach/detach paradigm still exposed externally.

> This is only used as a santity check to see if an externally imposed
> domain is currently attached or not.
> 
> We could also just delete the check..
> 
>> (and also just define it earlier to avoid the forward-declaration).
> 
> I put it here deliberately because the function directly below is
> __iommu_group_attach_core_domain() - which causes
> __iommu_group_is_core_domain() to become true. The symmetry helps
> explain how the two functions relate.
> 
> This whole file is out of order, it seems to be a style or something?

FWIW I think the declarations we do have there are all things that got 
refactored out of existing code. I don't see any having been added with 
entirely new functions where easily avoidable.

>> In fact at that point I'd also be tempted to rename
>> __iommu_group_attach_domain() to __iommu_group_set_domain(), to further
>> clarify that attach/detach still reflects the external API, but the internal
>> mechanism is really a bit different since default/core domains came in.
> 
> It make sense - weird that set_domain is the only way to call
> attach_dev, but OK :) I'll do that in the prior patch

Heh, if we can ever get to the point where we don't have differing old 
and new semantics side-by-side at almost every level, maybe then we can 
find the right name for *everything*. Besides, it's arguably even 
weirder for attach_domain to be the only way to call detach_dev, so 
there's that.

> Please give me your thought on external/internal as naming instead I
> can adjust the prior patch as well.

I certainly don't mind internal/external either, but as I say I'm also 
equally happy with core/user, noting that the latter win on typing 
effort too (and I'll continue to argue that there's not much appreciable 
difference between kernel users and userspace users, since half the time 
it's just going to be semantics of whether userspace has control of 
mappings via IOMMUFD vs. some private driver interface).

Thanks,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
