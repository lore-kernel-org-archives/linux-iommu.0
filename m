Return-Path: <SRS0=WqUy=VV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1337CC7618B
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 08:21:10 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3CBB21873
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 08:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3CBB21873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 94B86AB5;
	Wed, 24 Jul 2019 08:21:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 78C29AAE
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 08:21:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CE966701
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 08:21:07 +0000 (UTC)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id D886937D4A4679B0B765;
	Wed, 24 Jul 2019 16:21:05 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS401-HUB.china.huawei.com
	(10.3.19.201) with Microsoft SMTP Server id 14.3.439.0;
	Wed, 24 Jul 2019 16:20:56 +0800
From: John Garry <john.garry@huawei.com>
Subject: Re: [RFC PATCH v2 18/19] iommu/arm-smmu-v3: Reduce contention during
	command-queue insertion
To: Will Deacon <will@kernel.org>, <iommu@lists.linux-foundation.org>
References: <20190711171927.28803-1-will@kernel.org>
	<20190711171927.28803-19-will@kernel.org>
Message-ID: <b6302fdf-29ef-0aa2-ae7a-ed21c506c6ec@huawei.com>
Date: Wed, 24 Jul 2019 09:20:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
	Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190711171927.28803-19-will@kernel.org>
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Cc: Vijay Kilary <vkilari@codeaurora.org>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Jon Masters <jcm@redhat.com>, Jan Glauber <jglauber@marvell.com>, Alex
	Williamson <alex.williamson@redhat.com>,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	Robin Murphy <robin.murphy@arm.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 11/07/2019 18:19, Will Deacon wrote:
> +static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> +				       u64 *cmds, int n, bool sync)
> +{
> +	u64 cmd_sync[CMDQ_ENT_DWORDS];
> +	u32 prod;
>  	unsigned long flags;
> -	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
> -	struct arm_smmu_cmdq_ent ent = { .opcode = CMDQ_OP_CMD_SYNC };
> -	int ret;
> +	bool owner;
> +	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
> +	struct arm_smmu_ll_queue llq = {
> +		.max_n_shift = cmdq->q.llq.max_n_shift,
> +	}, head = llq;
> +	int ret = 0;
>
> -	arm_smmu_cmdq_build_cmd(cmd, &ent);
> +	/* 1. Allocate some space in the queue */
> +	local_irq_save(flags);
> +	llq.val = READ_ONCE(cmdq->q.llq.val);
> +	do {
> +		u64 old;
> +
> +		while (!queue_has_space(&llq, n + sync)) {
> +			local_irq_restore(flags);
> +			if (arm_smmu_cmdq_poll_until_not_full(smmu, &llq))
> +				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
> +			local_irq_save(flags);
> +		}
> +
> +		head.cons = llq.cons;
> +		head.prod = queue_inc_prod_n(&llq, n + sync) |
> +					     CMDQ_PROD_OWNED_FLAG;
> +
> +		old = cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.val);

I added some basic debug to the stress test on your branch, and this 
cmpxchg was failing ~10 times on average on my D06.

So we're not using the spinlock now, but this cmpxchg may lack fairness.

Since we're batching commands, I wonder if it's better to restore the 
spinlock and send batched commands + CMD_SYNC under the lock, and then 
wait for the CMD_SYNC completion outside the lock.

I don't know if it improves the queue contetion, but at least the prod 
pointer would be more closely track the issued commands, such that we're 
not waiting to kick off many gathered batches of commands, while the 
SMMU HW may be idle (in terms of command processing).

Cheers,
John

> +		if (old == llq.val)
> +			break;
> +
> +		llq.val = old;
> +	} while (1);
> +	owner = !(llq.prod & CMDQ_PROD_OWNED_F


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
