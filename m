Return-Path: <SRS0=VUzA=NI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7A7C4338F
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 11:54:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 072A761008
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 11:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 072A761008
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C6260402D2;
	Tue, 17 Aug 2021 11:54:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JTwDP-d4qgKv; Tue, 17 Aug 2021 11:54:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7879340018;
	Tue, 17 Aug 2021 11:54:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 490F1C0010;
	Tue, 17 Aug 2021 11:54:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DE5DC000E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 11:54:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4A8444018A
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 11:54:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pkPsv0W2d5ZF for <iommu@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 11:53:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 524B040018
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 11:53:58 +0000 (UTC)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GpqD04WDBz6BGJN;
 Tue, 17 Aug 2021 19:53:04 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 17 Aug 2021 13:53:53 +0200
Received: from [10.202.227.179] (10.202.227.179) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Tue, 17 Aug 2021 12:53:53 +0100
Subject: Re: [PATCH] iommu/arm-smmu-v3: Stop pre-zeroing batch commands in
 arm_smmu_atc_inv_master()
To: Zhen Lei <thunder.leizhen@huawei.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu
 <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20210817113411.1962-1-thunder.leizhen@huawei.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <23f1cc66-2172-9534-53ef-3d9b2db26bda@huawei.com>
Date: Tue, 17 Aug 2021 12:53:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210817113411.1962-1-thunder.leizhen@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.202.227.179]
X-ClientProxiedBy: lhreml702-chm.china.huawei.com (10.201.108.51) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
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

On 17/08/2021 12:34, Zhen Lei wrote:
> Pre-zeroing the batched commands structure is inefficient, as individual
> commands are zeroed later in arm_smmu_cmdq_build_cmd(). Therefore, only
> the member 'num' needs to be initialized to 0.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Reviewed-by: John Garry <john.garry@huawei.com>

> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 50a9db5bac466c7..e6882ae81fd08f6 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1776,10 +1776,11 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
>   {
>   	int i;
>   	struct arm_smmu_cmdq_ent cmd;
> -	struct arm_smmu_cmdq_batch cmds = {};
> +	struct arm_smmu_cmdq_batch cmds;
>   
>   	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
>   
> +	cmds.num = 0;

We prob should have added a comment why we do this (and at the other 
sites). I think Robin said something similar in another patch.

>   	for (i = 0; i < master->num_streams; i++) {
>   		cmd.atc.sid = master->streams[i].id;
>   		arm_smmu_cmdq_batch_add(master->smmu, &cmds, &cmd);
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
