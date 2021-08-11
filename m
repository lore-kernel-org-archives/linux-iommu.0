Return-Path: <SRS0=mUms=NC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B62C4338F
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 10:31:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B715660FC3
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 10:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B715660FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7BDAF40393;
	Wed, 11 Aug 2021 10:31:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T-lp2exf7Fnw; Wed, 11 Aug 2021 10:31:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0C96740111;
	Wed, 11 Aug 2021 10:31:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1CD5C001A;
	Wed, 11 Aug 2021 10:31:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12C56C000E
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 10:31:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0FC2083216
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 10:31:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JdX-JR0j3O4i for <iommu@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 10:31:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 172F2831CA
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 10:31:48 +0000 (UTC)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gl5hK69ZTz6BDkl;
 Wed, 11 Aug 2021 18:31:13 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 11 Aug 2021 12:31:46 +0200
Received: from [10.47.80.4] (10.47.80.4) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 11 Aug
 2021 11:31:45 +0100
Subject: Re: [PATCH RFC 2/8] iommu/arm-smmu-v3: Add and use static helper
 function arm_smmu_cmdq_issue_cmd_with_sync()
To: Will Deacon <will@kernel.org>, "Leizhen (ThunderTown)"
 <thunder.leizhen@huawei.com>
References: <20210626110130.2416-1-thunder.leizhen@huawei.com>
 <20210626110130.2416-3-thunder.leizhen@huawei.com>
 <20210810182454.GB3296@willie-the-truck>
 <b9fa05b5-d3ee-5c79-c8b8-b908e533646a@huawei.com>
 <20210811100905.GB4426@willie-the-truck>
From: John Garry <john.garry@huawei.com>
Message-ID: <d551f31d-4edc-db28-fb08-41a130a5d97f@huawei.com>
Date: Wed, 11 Aug 2021 11:31:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210811100905.GB4426@willie-the-truck>
Content-Language: en-US
X-Originating-IP: [10.47.80.4]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: iommu <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

>>>> Obviously, inserting as many commands at a time as possible can reduce the
>>>> number of times the mutex contention participates, thereby improving the
>>>> overall performance. At least it reduces the number of calls to function
>>>> arm_smmu_cmdq_issue_cmdlist().
>>>>
>>>> Therefore, function arm_smmu_cmdq_issue_cmd_with_sync() is added to insert
>>>> the 'cmd+sync' commands at a time.
>>>>
>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>> ---
>>>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 33 +++++++++++++--------
>>>>   1 file changed, 21 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>> index 2433d3c29b49ff2..a5361153ca1d6a4 100644
>>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>> @@ -858,11 +858,25 @@ static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
>>>>   	return arm_smmu_cmdq_issue_cmdlist(smmu, cmd, 1, false);
>>>>   }
>>>>   
>>>> -static int arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
>>>> +static int __maybe_unused arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
>>>>   {
>>>>   	return arm_smmu_cmdq_issue_cmdlist(smmu, NULL, 0, true);
>>>>   }
>>>>   
>>>> +static int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
>>>> +					     struct arm_smmu_cmdq_ent *ent)
>>>> +{
>>>> +	u64 cmd[CMDQ_ENT_DWORDS];
>>>> +
>>>> +	if (arm_smmu_cmdq_build_cmd(cmd, ent)) {
>>>> +		dev_warn(smmu->dev, "ignoring unknown CMDQ opcode 0x%x\n",
>>>> +			 ent->opcode);
>>>> +		return -EINVAL;

Are any of the errors returned from the "issue command" functions 
actually consumed? I couldn't see it on mainline code from a brief browse.

>>>> +	}
>>>> +
>>>> +	return arm_smmu_cmdq_issue_cmdlist(smmu, cmd, 1, true);

Thanks,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
