Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF56C48BE5
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 01:47:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F260561356
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 01:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F260561356
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6E664066F;
	Wed, 16 Jun 2021 01:47:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id caIbuV1X5pY6; Wed, 16 Jun 2021 01:47:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2C78840672;
	Wed, 16 Jun 2021 01:47:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DAD9FC000E;
	Wed, 16 Jun 2021 01:47:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EE5FC000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 01:47:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA64A83B23
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 01:47:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Goo67T4CyYRR for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 01:47:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9250983B0E
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 01:47:24 +0000 (UTC)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G4Sd53PxFz6y5T;
 Wed, 16 Jun 2021 09:43:21 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 09:47:20 +0800
Received: from [127.0.0.1] (10.174.179.0) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 16 Jun
 2021 09:47:19 +0800
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: remove unnecessary oom message
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20210609125438.14369-1-thunder.leizhen@huawei.com>
 <20210611103220.GB15274@willie-the-truck>
 <2a0b7f37-156a-775f-ade4-015cade472c6@huawei.com>
 <20210615113417.GA20598@willie-the-truck>
 <ab17a9d3-fe8b-dcd8-1a69-81f5604cfe81@arm.com>
 <20210615115507.GD20598@willie-the-truck>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <c94b7ba9-b85b-4704-6335-17334bc56f1b@huawei.com>
Date: Wed, 16 Jun 2021 09:47:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210615115507.GD20598@willie-the-truck>
Content-Language: en-US
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Cc: iommu <iommu@lists.linux-foundation.org>,
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



On 2021/6/15 19:55, Will Deacon wrote:
> On Tue, Jun 15, 2021 at 12:51:38PM +0100, Robin Murphy wrote:
>> On 2021-06-15 12:34, Will Deacon wrote:
>>> On Tue, Jun 15, 2021 at 07:22:10PM +0800, Leizhen (ThunderTown) wrote:
>>>>
>>>>
>>>> On 2021/6/11 18:32, Will Deacon wrote:
>>>>> On Wed, Jun 09, 2021 at 08:54:38PM +0800, Zhen Lei wrote:
>>>>>> Fixes scripts/checkpatch.pl warning:
>>>>>> WARNING: Possible unnecessary 'out of memory' message
>>>>>>
>>>>>> Remove it can help us save a bit of memory.
>>>>>>
>>>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>>>> ---
>>>>>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 ++------
>>>>>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>>> index 2ddc3cd5a7d1..fd7c55b44881 100644
>>>>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>>> @@ -2787,10 +2787,8 @@ static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
>>>>>>   	void *strtab = smmu->strtab_cfg.strtab;
>>>>>>   	cfg->l1_desc = devm_kzalloc(smmu->dev, size, GFP_KERNEL);
>>>>>> -	if (!cfg->l1_desc) {
>>>>>> -		dev_err(smmu->dev, "failed to allocate l1 stream table desc\n");
>>>>>> +	if (!cfg->l1_desc)
>>>>>
>>>>> What error do you get if devm_kzalloc() fails? I'd like to make sure it's
>>>>> easy to track down _which_ allocation failed in that case -- does it give
>>>>> you a line number, for example?
>>>>
>>>> When devm_kzalloc() fails, the OOM information is printed. No line number information, but the
>>>> size(order) and call stack is printed. It doesn't matter which allocation failed, the failure
>>>> is caused by insufficient system memory rather than the fault of the SMMU driver. Therefore,
>>>> the current printing is not helpful for locating the problem of insufficient memory. After all,
>>>> when memory allocation fails, the SMMU driver cannot work at a lower specification.
>>>
>>> I don't entirely agree. Another reason for the failure is because the driver
>>> might be asking for a huge (or negative) allocation, in which case it might
>>> be instructive to have a look at the actual caller, particularly if the
>>> size is derived from hardware or firmware properties.
>>
>> Agreed - other than deliberately-contrived situations I don't think I've
>> ever hit a genuine OOM, but I definitely have debugged attempts to allocate
>> -1 of something. If the driver-specific message actually calls out the
>> critical information, e.g. "failed to allocate %d stream table entries", it
>> gives debugging a head start since the miscalculation is obvious, but a
>> static message that only identifies the callsite really only saves a quick
>> trip to scripts/faddr2line, and personally I've never found that
>> particularly valuable.
> 
> So it sounds like this particular patch is fine, but the one for smmuv2
> should leave the IRQ allocation message alone (by virtue of it printing
> something a bit more useful -- the number of irqs).

        num_irqs = 0;
        while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
                num_irqs++;
        }

As the above code, num_irqs is calculated based on the number of dtb or acpi
configuration items, it can't be too large. That is, there is almost zero chance
that devm_kcalloc() will fail because num_irqs is too large.


> 
> Will
> 
> .
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
