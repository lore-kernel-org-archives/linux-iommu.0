Return-Path: <SRS0=GTcZ=FL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBA1C4361B
	for <iommu@archiver.kernel.org>; Mon,  7 Dec 2020 12:15:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC032339D
	for <iommu@archiver.kernel.org>; Mon,  7 Dec 2020 12:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC032339D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B9C2C87254;
	Mon,  7 Dec 2020 12:15:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qx5Xv6bDcqdT; Mon,  7 Dec 2020 12:15:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4061B8710D;
	Mon,  7 Dec 2020 12:15:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33F10C0FA7;
	Mon,  7 Dec 2020 12:15:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84426C013B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 12:15:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7118A87254
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 12:15:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rpUzEy33Mh2I for <iommu@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 12:15:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A23DB8710D
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 12:15:35 +0000 (UTC)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CqMh45cdtzhntL;
 Mon,  7 Dec 2020 20:15:00 +0800 (CST)
Received: from [10.174.187.37] (10.174.187.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Dec 2020 20:15:22 +0800
Subject: Re: [PATCH] iommu: Up front sanity check in the arm_lpae_map
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20201205082957.12544-1-zhukeqian1@huawei.com>
 <b85e98c8-0117-49c5-97ad-896ff88f7b88@arm.com>
 <20201207120527.GA4474@willie-the-truck>
From: zhukeqian <zhukeqian1@huawei.com>
Message-ID: <2b0ec25b-0fa4-65ca-7c1b-109ce766197f@huawei.com>
Date: Mon, 7 Dec 2020 20:15:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20201207120527.GA4474@willie-the-truck>
X-Originating-IP: [10.174.187.37]
X-CFilter-Loop: Reflected
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Marc Zyngier <maz@kernel.org>,
 jiangkunkun@huawei.com, linux-kernel@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Alexios Zavras <alexios.zavras@intel.com>, iommu@lists.linux-foundation.org,
 Mark Brown <broonie@kernel.org>, James
 Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, wanghaibin.wang@huawei.com, Thomas
 Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

On 2020/12/7 20:05, Will Deacon wrote:
> On Mon, Dec 07, 2020 at 12:01:09PM +0000, Robin Murphy wrote:
>> On 2020-12-05 08:29, Keqian Zhu wrote:
>>> ... then we have more chance to detect wrong code logic.
>>
>> I don't follow that justification - it's still the same check with the same
>> outcome, so how does moving it have any effect on the chance to detect
>> errors?

>>
>> AFAICS the only difference it would make is to make some errors *less*
>> obvious - if a sufficiently broken caller passes an empty prot value
>> alongside an invalid size or already-mapped address, this will now quietly
>> hide the warnings from the more serious condition(s).
>>
>> Yes, it will bail out a bit faster in the specific case where the prot value
>> is the only thing wrong, but since when do we optimise for fundamentally
>> incorrect API usage?
> 
> I thought it was the other way round -- doesn't this patch move the "empty
> prot" check later, so we have a chance to check the size and addresses
> first?

Yes, this is my original idea.
For that we treat iommu_prot with no permission as success at early start, defer
this early return can expose hidden errors.

Thanks,
Keqian
> 
> Will
> 
>>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>>> ---
>>>   drivers/iommu/io-pgtable-arm.c | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
>>> index a7a9bc08dcd1..8ade72adab31 100644
>>> --- a/drivers/iommu/io-pgtable-arm.c
>>> +++ b/drivers/iommu/io-pgtable-arm.c
>>> @@ -444,10 +444,6 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
>>>   	arm_lpae_iopte prot;
>>>   	long iaext = (s64)iova >> cfg->ias;
>>> -	/* If no access, then nothing to do */
>>> -	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
>>> -		return 0;
>>> -
>>>   	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
>>>   		return -EINVAL;
>>> @@ -456,6 +452,10 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
>>>   	if (WARN_ON(iaext || paddr >> cfg->oas))
>>>   		return -ERANGE;
>>> +	/* If no access, then nothing to do */
>>> +	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
>>> +		return 0;
>>> +
>>>   	prot = arm_lpae_prot_to_pte(data, iommu_prot);
>>>   	ret = __arm_lpae_map(data, iova, paddr, size, prot, lvl, ptep, gfp);
>>>   	/*
>>>
> .
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
