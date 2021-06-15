Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FED6C48BDF
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 11:22:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D3A561455
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 11:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D3A561455
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47001607B5;
	Tue, 15 Jun 2021 11:22:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZGiKVAwGJ581; Tue, 15 Jun 2021 11:22:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 234BB606E9;
	Tue, 15 Jun 2021 11:22:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2AD4C000E;
	Tue, 15 Jun 2021 11:22:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73E85C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 11:22:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6F9766073B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 11:22:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a8BGzO1PBPgI for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 11:22:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B9745606E9
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 11:22:16 +0000 (UTC)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G45Ph1HSczXg8K;
 Tue, 15 Jun 2021 19:17:12 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 19:22:12 +0800
Received: from [127.0.0.1] (10.174.179.0) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 15 Jun
 2021 19:22:11 +0800
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: remove unnecessary oom message
To: Will Deacon <will@kernel.org>
References: <20210609125438.14369-1-thunder.leizhen@huawei.com>
 <20210611103220.GB15274@willie-the-truck>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <2a0b7f37-156a-775f-ade4-015cade472c6@huawei.com>
Date: Tue, 15 Jun 2021 19:22:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210611103220.GB15274@willie-the-truck>
Content-Language: en-US
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Cc: Robin Murphy <robin.murphy@arm.com>,
 iommu <iommu@lists.linux-foundation.org>,
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



On 2021/6/11 18:32, Will Deacon wrote:
> On Wed, Jun 09, 2021 at 08:54:38PM +0800, Zhen Lei wrote:
>> Fixes scripts/checkpatch.pl warning:
>> WARNING: Possible unnecessary 'out of memory' message
>>
>> Remove it can help us save a bit of memory.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 ++------
>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 2ddc3cd5a7d1..fd7c55b44881 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -2787,10 +2787,8 @@ static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
>>  	void *strtab = smmu->strtab_cfg.strtab;
>>  
>>  	cfg->l1_desc = devm_kzalloc(smmu->dev, size, GFP_KERNEL);
>> -	if (!cfg->l1_desc) {
>> -		dev_err(smmu->dev, "failed to allocate l1 stream table desc\n");
>> +	if (!cfg->l1_desc)
> 
> What error do you get if devm_kzalloc() fails? I'd like to make sure it's
> easy to track down _which_ allocation failed in that case -- does it give
> you a line number, for example?

When devm_kzalloc() fails, the OOM information is printed. No line number information, but the
size(order) and call stack is printed. It doesn't matter which allocation failed, the failure
is caused by insufficient system memory rather than the fault of the SMMU driver. Therefore,
the current printing is not helpful for locating the problem of insufficient memory. After all,
when memory allocation fails, the SMMU driver cannot work at a lower specification.

[   44.126661] swapper/0 invoked oom-killer: gfp_mask=0x40cc0(GFP_KERNEL|__GFP_COMP), order=1, oom_score_adj=0
[   44.136381] CPU: 26 PID: 1 Comm: swapper/0 Not tainted 5.13.0-rc6-00001-g0d973bf828c8 #1
[   44.144436] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 2280-V2 CS V3.B220.02 03/27/2020
[   44.153266] Call trace:
[   44.155703]  dump_backtrace+0x0/0x1c0
[   44.159355]  show_stack+0x18/0x68
[   44.162658]  dump_stack+0xd8/0x134
[   44.166047]  dump_header+0x44/0x208
[   44.169524]  out_of_memory+0x530/0x580
[   44.173256]  __alloc_pages_slowpath.constprop.120+0x85c/0xac0
[   44.178976]  __alloc_pages+0x238/0x300
[   44.182709]  allocate_slab+0x3bc/0x3d8
[   44.186440]  ___slab_alloc+0x508/0x6b0
[   44.190172]  __slab_alloc.isra.100+0x2c/0x58
[   44.194422]  __kmalloc_node_track_caller+0x138/0x2e8
[   44.199365]  devm_kmalloc+0x58/0x100
[   44.202926]  arm_smmu_device_probe+0x858/0x1150
[   44.207437]  platform_probe+0x68/0xe0

> 
> Will
> 
> .
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
