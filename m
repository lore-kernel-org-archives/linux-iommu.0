Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5547C4338F
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 11:24:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A1D76112D
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 11:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4A1D76112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18D048350A;
	Thu,  5 Aug 2021 11:24:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Iycn3iGZ3vrb; Thu,  5 Aug 2021 11:24:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2CE4382B81;
	Thu,  5 Aug 2021 11:24:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EC32C001A;
	Thu,  5 Aug 2021 11:24:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E076C000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 11:24:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 267A34028F
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 11:24:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NVKxArySKa-X for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 11:24:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id D160040138
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 11:24:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C67151FB;
 Thu,  5 Aug 2021 04:24:39 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A99A63F719;
 Thu,  5 Aug 2021 04:24:38 -0700 (PDT)
Subject: Re: [PATCH] iommu/arm-smmu-v3: Remove some unneeded init in
 arm_smmu_cmdq_issue_cmdlist()
To: John Garry <john.garry@huawei.com>, will@kernel.org
References: <1624293394-202509-1-git-send-email-john.garry@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <ee1f3ab5-3acc-f442-f2d2-898cf88bc447@arm.com>
Date: Thu, 5 Aug 2021 12:24:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1624293394-202509-1-git-send-email-john.garry@huawei.com>
Content-Language: en-GB
Cc: linuxarm@huawei.com, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On 2021-06-21 17:36, John Garry wrote:
> Members of struct "llq" will be zero-inited, apart from member max_n_shift.
> But we write llq.val straight after the init, so it was pointless to zero
> init those other members. As such, separately init member max_n_shift
> only.
> 
> In addition, struct "head" is initialised to "llq" only so that member
> max_n_shift is set. But that member is never referenced for "head", so
> remove any init there.
> 
> Removing these initializations is seen as a small performance optimisation,
> as this code is (very) hot path.

I looked at this and immediately thought "surely the compiler can see 
that all the prod/cons/val fields are written anyway and elide the 
initialisation?", so I dumped the before and after disassembly, and... oh.

You should probably clarify that it's zero-initialising all the 
cacheline padding which is both pointless and painful. With that,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

However, having looked this closely I'm now tangentially wondering why 
max_n_shift isn't inside the padded union? It's read at the same time as 
both prod and cons by queue_has_space(), and never updated, so there 
doesn't appear to be any benefit to it being in a separate cacheline all 
by itself, and llq is already twice as big as it needs to be. Sorting 
that would also be a good opportunity to store the value of interest in 
its appropriate form so we're not needlessly recalculating 1 << shift 
every flippin' time...

Robin.

> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 54b2f27b81d4..8a8ad49bb7fd 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -727,11 +727,11 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>   	unsigned long flags;
>   	bool owner;
>   	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
> -	struct arm_smmu_ll_queue llq = {
> -		.max_n_shift = cmdq->q.llq.max_n_shift,
> -	}, head = llq;
> +	struct arm_smmu_ll_queue llq, head;
>   	int ret = 0;
>   
> +	llq.max_n_shift = cmdq->q.llq.max_n_shift;
> +
>   	/* 1. Allocate some space in the queue */
>   	local_irq_save(flags);
>   	llq.val = READ_ONCE(cmdq->q.llq.val);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
