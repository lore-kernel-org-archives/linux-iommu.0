Return-Path: <SRS0=GTcZ=FL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D12C4361B
	for <iommu@archiver.kernel.org>; Mon,  7 Dec 2020 13:36:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D58233EA
	for <iommu@archiver.kernel.org>; Mon,  7 Dec 2020 13:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D58233EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 327038741B;
	Mon,  7 Dec 2020 13:36:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l6M4QKq4Dm1p; Mon,  7 Dec 2020 13:36:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 17F1387415;
	Mon,  7 Dec 2020 13:36:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F31E9C0893;
	Mon,  7 Dec 2020 13:36:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DB73C013B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 13:36:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 60F1886D22
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 13:36:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9IoAJxnDNW2k for <iommu@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 13:36:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6845986D1D
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 13:36:48 +0000 (UTC)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CqPTp1812z79wc;
 Mon,  7 Dec 2020 21:36:14 +0800 (CST)
Received: from [10.174.187.37] (10.174.187.37) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Dec 2020 21:36:35 +0800
Subject: Re: [PATCH] iommu: Up front sanity check in the arm_lpae_map
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
References: <20201205082957.12544-1-zhukeqian1@huawei.com>
 <b85e98c8-0117-49c5-97ad-896ff88f7b88@arm.com>
 <20201207120527.GA4474@willie-the-truck>
 <2b0ec25b-0fa4-65ca-7c1b-109ce766197f@huawei.com>
 <9a6f31d7-3471-c045-368b-42ece5a2d34d@arm.com>
From: zhukeqian <zhukeqian1@huawei.com>
Message-ID: <2191c045-449e-e7cb-a267-5bd356dab58e@huawei.com>
Date: Mon, 7 Dec 2020 21:36:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <9a6f31d7-3471-c045-368b-42ece5a2d34d@arm.com>
X-Originating-IP: [10.174.187.37]
X-CFilter-Loop: Reflected
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Marc Zyngier <maz@kernel.org>,
 jiangkunkun@huawei.com, linux-kernel@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Alexios Zavras <alexios.zavras@intel.com>, iommu@lists.linux-foundation.org,
 Mark Brown <broonie@kernel.org>, James
 Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, wanghaibin.wang@huawei.com,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Julien Thierry <julien.thierry.kdev@gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Robin,

On 2020/12/7 20:46, Robin Murphy wrote:
> On 2020-12-07 12:15, zhukeqian wrote:
>> Hi,
>>
>> On 2020/12/7 20:05, Will Deacon wrote:
>>> On Mon, Dec 07, 2020 at 12:01:09PM +0000, Robin Murphy wrote:
>>>> On 2020-12-05 08:29, Keqian Zhu wrote:
>>>>> ... then we have more chance to detect wrong code logic.
>>>>
>>>> I don't follow that justification - it's still the same check with the same
>>>> outcome, so how does moving it have any effect on the chance to detect
>>>> errors?
>>
>>>>
>>>> AFAICS the only difference it would make is to make some errors *less*
>>>> obvious - if a sufficiently broken caller passes an empty prot value
>>>> alongside an invalid size or already-mapped address, this will now quietly
>>>> hide the warnings from the more serious condition(s).
>>>>
>>>> Yes, it will bail out a bit faster in the specific case where the prot value
>>>> is the only thing wrong, but since when do we optimise for fundamentally
>>>> incorrect API usage?
>>>
>>> I thought it was the other way round -- doesn't this patch move the "empty
>>> prot" check later, so we have a chance to check the size and addresses
>>> first?
>>
>> Yes, this is my original idea.
>> For that we treat iommu_prot with no permission as success at early start, defer
>> this early return can expose hidden errors.
> 
> ...oh dear, my apologies. I've just had a week off and apparently in that time I lost the ability to read :(
> 
> I was somehow convinced that the existing check happened at the point where we go to install the PTE, and this patch was moving it earlier. Looking at the whole code in context now I see I got it completely backwards. Sorry for being an idiot.
> 
I see :-) I should make a more descriptive commit message.

> I guess that only goes to show that a more descriptive commit message would definitely be a good thing :)
> 
I have adapted Will's suggestion and sent v2, please check whether it is OK to you?

Cheers,
Keqian

[...]
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>
> .
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
