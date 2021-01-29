Return-Path: <SRS0=1cKf=HA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B420EC433DB
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 00:04:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2475064DFD
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 00:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2475064DFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BC1008696B;
	Fri, 29 Jan 2021 00:04:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lp4IxQ5P76KX; Fri, 29 Jan 2021 00:04:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E914086439;
	Fri, 29 Jan 2021 00:04:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC73EC0FA7;
	Fri, 29 Jan 2021 00:04:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3020C013A
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 00:04:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AE876866F2
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 00:04:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cwso7Pk5YJJn for <iommu@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 00:04:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 19CCD86132
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 00:04:02 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26F6413D5;
 Thu, 28 Jan 2021 16:04:02 -0800 (PST)
Received: from [10.57.35.163] (unknown [10.57.35.163])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 686373F66E;
 Thu, 28 Jan 2021 16:03:59 -0800 (PST)
Subject: Re: [PATCH v6 07/33] iommu: Avoid reallocate default domain for a
 group
To: Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
 <20210111111914.22211-8-yong.wu@mediatek.com>
 <20210126222305.GB30460@willie-the-truck>
 <1611740356.5302.14.camel@mhfsdcap03>
 <20210128211020.GA3531@willie-the-truck>
 <20210128211442.GB3531@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <654abe35-bc60-741b-1238-d9c585a45c06@arm.com>
Date: Fri, 29 Jan 2021 00:03:57 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210128211442.GB3531@willie-the-truck>
Content-Language: en-GB
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, anan.sun@mediatek.com,
 linux-arm-kernel@lists.infradead.org
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

On 2021-01-28 21:14, Will Deacon wrote:
> On Thu, Jan 28, 2021 at 09:10:20PM +0000, Will Deacon wrote:
>> On Wed, Jan 27, 2021 at 05:39:16PM +0800, Yong Wu wrote:
>>> On Tue, 2021-01-26 at 22:23 +0000, Will Deacon wrote:
>>>> On Mon, Jan 11, 2021 at 07:18:48PM +0800, Yong Wu wrote:
>>>>> If group->default_domain exists, avoid reallocate it.
>>>>>
>>>>> In some iommu drivers, there may be several devices share a group. Avoid
>>>>> realloc the default domain for this case.
>>>>>
>>>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>>>> ---
>>>>>   drivers/iommu/iommu.c | 3 ++-
>>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>>> index 3d099a31ddca..f4b87e6abe80 100644
>>>>> --- a/drivers/iommu/iommu.c
>>>>> +++ b/drivers/iommu/iommu.c
>>>>> @@ -266,7 +266,8 @@ int iommu_probe_device(struct device *dev)
>>>>>   	 * support default domains, so the return value is not yet
>>>>>   	 * checked.
>>>>>   	 */
>>>>> -	iommu_alloc_default_domain(group, dev);
>>>>> +	if (!group->default_domain)
>>>>> +		iommu_alloc_default_domain(group, dev);
>>>>
>>>> I don't really get what this achieves, since iommu_alloc_default_domain()
>>>> looks like this:
>>>>
>>>> static int iommu_alloc_default_domain(struct iommu_group *group,
>>>> 				      struct device *dev)
>>>> {
>>>> 	unsigned int type;
>>>>
>>>> 	if (group->default_domain)
>>>> 		return 0;
>>>>
>>>> 	...
>>>>
>>>> in which case, it should be fine?
>>>
>>> oh. sorry, I overlooked this. the current code is enough.
>>> I will remove this patch. and send the next version in this week.
>>> Thanks very much.
>>
>> Actually, looking at this again, if we're dropping this patch and patch 6
>> just needs the kfree() moving about, then there's no need to repost. The
>> issue that Robin and Paul are discussing can be handled separately.

FWIW patch #6 gets dropped as well now, since Rob has applied the 
standalone fix (89c7cb1608ac).

Robin.

> Argh, except that this version of the patches doesn't apply :)
> 
> So after all that, please go ahead and post a v7 ASAP based on this branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/mtk
> 
> Will
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
