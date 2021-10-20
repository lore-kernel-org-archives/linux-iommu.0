Return-Path: <SRS0=Y7tz=PI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAF7C433F5
	for <iommu@archiver.kernel.org>; Wed, 20 Oct 2021 07:30:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 925586113D
	for <iommu@archiver.kernel.org>; Wed, 20 Oct 2021 07:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 925586113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6100183372;
	Wed, 20 Oct 2021 07:30:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xqupmriUQwlX; Wed, 20 Oct 2021 07:30:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0F45883403;
	Wed, 20 Oct 2021 07:30:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB30FC000F;
	Wed, 20 Oct 2021 07:30:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BC42C000D
 for <iommu@lists.linux-foundation.org>; Wed, 20 Oct 2021 07:30:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 44CEB40291
 for <iommu@lists.linux-foundation.org>; Wed, 20 Oct 2021 07:30:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6RR0mdikfECC for <iommu@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 07:30:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A8D5640136
 for <iommu@lists.linux-foundation.org>; Wed, 20 Oct 2021 07:30:00 +0000 (UTC)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HZ2Fb3VL3zbnKC;
 Wed, 20 Oct 2021 15:25:23 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 20 Oct 2021 15:29:56 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 20 Oct 2021 15:29:56 +0800
Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3: Simplify useless instructions
 in arm_smmu_cmdq_build_cmd()
To: Will Deacon <will@kernel.org>
References: <20210818080452.2079-1-thunder.leizhen@huawei.com>
 <20210818080452.2079-3-thunder.leizhen@huawei.com>
 <20211004120714.GD27373@willie-the-truck>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <68742c41-8610-9b3f-49b7-7ae04dc87ec2@huawei.com>
Date: Wed, 20 Oct 2021 15:29:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20211004120714.GD27373@willie-the-truck>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Cc: linux-kernel@vger.kernel.org, iommu <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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



On 2021/10/4 20:07, Will Deacon wrote:
> On Wed, Aug 18, 2021 at 04:04:52PM +0800, Zhen Lei wrote:
>> Although the parameter 'cmd' is always passed by a local array variable,
>> and only this function modifies it, the compiler does not know this. The
>> compiler almost always reads the value of cmd[i] from memory rather than
>> directly using the value cached in the register. This generates many
>> useless instruction operations and affects the performance to some extent.
>>
>> To guide the compiler for proper optimization, 'cmd' is defined as a local
>> array variable, marked as register, and copied to the output parameter at
>> a time when the function is returned.
>>
>> The optimization effect can be viewed by running the "size arm-smmu-v3.o"
>> command.
>>
>> Before:
>>    text    data     bss     dec     hex
>>   26954    1348      56   28358    6ec6
>>
>> After:
>>    text    data     bss     dec     hex
>>   26762    1348      56   28166    6e06
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 01e95b56ffa07d1..7cec0c967f71d86 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -234,10 +234,12 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
>>  }
>>  
>>  /* High-level queue accessors */
>> -static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>> +static int arm_smmu_cmdq_build_cmd(u64 *out_cmd, struct arm_smmu_cmdq_ent *ent)
>>  {
>> -	memset(cmd, 0, 1 << CMDQ_ENT_SZ_SHIFT);
>> -	cmd[0] |= FIELD_PREP(CMDQ_0_OP, ent->opcode);
>> +	register u64 cmd[CMDQ_ENT_DWORDS];
> 
> 'register' is pretty badly specified outside of a handful of limited uses in
> conjunction with inline asm, so I really don't think we should be using it
> here.

OK, I think I was overly aggressive in the beginning, and I just tried to
remove the register modifier and get the same optimization.

> 
>> +	cmd[0] = FIELD_PREP(CMDQ_0_OP, ent->opcode);
> 
> This generates a compiler warning about taking the address of a 'register'
> variable.
> 
> Will
> .
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
