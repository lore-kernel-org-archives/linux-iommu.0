Return-Path: <SRS0=SLGw=NE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A814C4338F
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 16:01:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB65260EE0
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 16:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BB65260EE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7950440594;
	Fri, 13 Aug 2021 16:01:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KsYjiF6tfr6l; Fri, 13 Aug 2021 16:01:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4BBB04060B;
	Fri, 13 Aug 2021 16:01:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E659C0010;
	Fri, 13 Aug 2021 16:01:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8220C000E
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 16:01:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 928C740225
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 16:01:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QI5PKw_a0cUE for <iommu@lists.linux-foundation.org>;
 Fri, 13 Aug 2021 16:01:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 76F1B40025
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 16:01:45 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A84FB1FB;
 Fri, 13 Aug 2021 09:01:44 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B50B33F718;
 Fri, 13 Aug 2021 09:01:43 -0700 (PDT)
Subject: Re: [PATCH 1/4] iommu/arm-smmu-v3: Use command queue batching helpers
 to improve performance
To: Zhen Lei <thunder.leizhen@huawei.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 iommu <iommu@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
References: <20210811114852.2429-1-thunder.leizhen@huawei.com>
 <20210811114852.2429-2-thunder.leizhen@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <81258eb7-eb73-8a32-0983-3487daba1167@arm.com>
Date: Fri, 13 Aug 2021 17:01:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210811114852.2429-2-thunder.leizhen@huawei.com>
Content-Language: en-GB
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

On 2021-08-11 12:48, Zhen Lei wrote:
> The obvious key to the performance optimization of commit 587e6c10a7ce
> ("iommu/arm-smmu-v3: Reduce contention during command-queue insertion") is
> to allow multiple cores to insert commands in parallel after a brief mutex
> contention.
> 
> Obviously, inserting as many commands at a time as possible can reduce the
> number of times the mutex contention participates, thereby improving the
> overall performance. At least it reduces the number of calls to function
> arm_smmu_cmdq_issue_cmdlist().
> 
> Therefore, use command queue batching helpers to insert multiple commands
> at a time.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 235f9bdaeaf223b..c81cd929047f573 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1747,15 +1747,16 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
>   {
>   	int i;
>   	struct arm_smmu_cmdq_ent cmd;
> +	struct arm_smmu_cmdq_batch cmds = {};

BTW, it looks like this has crossed over with John's patch removing these.

Robin.

>   
>   	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
>   
>   	for (i = 0; i < master->num_streams; i++) {
>   		cmd.atc.sid = master->streams[i].id;
> -		arm_smmu_cmdq_issue_cmd(master->smmu, &cmd);
> +		arm_smmu_cmdq_batch_add(master->smmu, &cmds, &cmd);
>   	}
>   
> -	return arm_smmu_cmdq_issue_sync(master->smmu);
> +	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
>   }
>   
>   int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
