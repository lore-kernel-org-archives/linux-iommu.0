Return-Path: <SRS0=gZYu=WK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F13EC32750
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 00:41:53 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BE5720644
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 00:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE5720644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0AF30B5F;
	Wed, 14 Aug 2019 00:41:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 993ED255
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 00:41:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E1DB767F
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 00:41:50 +0000 (UTC)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id 509E972F8571B7ADFF66;
	Wed, 14 Aug 2019 08:41:48 +0800 (CST)
Received: from [127.0.0.1] (10.133.215.186) by DGGEMS404-HUB.china.huawei.com
	(10.3.19.204) with Microsoft SMTP Server id 14.3.439.0;
	Wed, 14 Aug 2019 08:41:38 +0800
Subject: Re: [PATCH] iommu/arm-smmu-v3: add nr_ats_masters to avoid
	unnecessary operations
To: Will Deacon <will@kernel.org>, John Garry <john.garry@huawei.com>
References: <20190801122040.26024-1-thunder.leizhen@huawei.com>
	<b5866f7a-013a-5900-6fce-268052f2ba0a@huawei.com>
	<20190813171039.y64wslo4dzgyis3e@willie-the-truck>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <19e427af-7ff3-99a5-cfec-60ebce686cb2@huawei.com>
Date: Wed, 14 Aug 2019 08:41:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190813171039.y64wslo4dzgyis3e@willie-the-truck>
Content-Language: en-US
X-Originating-IP: [10.133.215.186]
X-CFilter-Loop: Reflected
Cc: jean-philippe@linaro.org,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	iommu <iommu@lists.linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org



On 2019/8/14 1:10, Will Deacon wrote:
> On Mon, Aug 12, 2019 at 11:42:17AM +0100, John Garry wrote:
>> On 01/08/2019 13:20, Zhen Lei wrote:
>>> When (smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS) is true, even if a
>>> smmu domain does not contain any ats master, the operations of
>>> arm_smmu_atc_inv_to_cmd() and lock protection in arm_smmu_atc_inv_domain()
>>> are always executed. This will impact performance, especially in
>>> multi-core and stress scenarios. For my FIO test scenario, about 8%
>>> performance reduced.
>>>
>>> In fact, we can use a atomic member to record how many ats masters the
>>> smmu contains. And check that without traverse the list and check all
>>> masters one by one in the lock protection.
>>>
>>
>> Hi Will, Robin, Jean-Philippe,
>>
>> Can you kindly check this issue? We have seen a signifigant performance
>> regression here.
> 
> Sorry, John: Robin and Jean-Philippe are off at the moment and I've been
> swamped dealing with the arm64 queue. I'll try to get to this tomorrow.

Hi, all:
   I found my patch have some mistake, see below. I'm sorry I didn't see this coupling. 
I'm preparing v2. 

> @@ -1915,10 +1921,10 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
>  	list_del(&master->domain_head);
>  	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>  
> -	master->domain = NULL;
>  	arm_smmu_install_ste_for_dev(master);

"master->domain = NULL" is needed in arm_smmu_install_ste_for_dev().

>  
>  	arm_smmu_disable_ats(master);
> +	master->domain = NULL;
>  }

> 
> Will
> 
> .
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
