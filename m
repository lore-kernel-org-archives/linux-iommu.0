Return-Path: <SRS0=VUzA=NI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD46C4338F
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 13:24:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8C1160238
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 13:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B8C1160238
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7DC61401D6;
	Tue, 17 Aug 2021 13:24:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nXuJIRMaQVkU; Tue, 17 Aug 2021 13:24:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 546B640525;
	Tue, 17 Aug 2021 13:24:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31582C0010;
	Tue, 17 Aug 2021 13:24:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 678C6C000E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 13:24:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 63C1B4053A
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 13:24:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vfwxhwRWi8Y6 for <iommu@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 13:24:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6679540525
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 13:24:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7862C101E;
 Tue, 17 Aug 2021 06:24:23 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54B0F3F70D;
 Tue, 17 Aug 2021 06:24:22 -0700 (PDT)
Subject: Re: [PATCH] iommu/arm-smmu-v3: Simplify useless instructions in
 arm_smmu_cmdq_build_cmd()
To: Zhen Lei <thunder.leizhen@huawei.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 iommu <iommu@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
References: <20210817113450.2026-1-thunder.leizhen@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <6fea9ce0-7b8d-bd46-6b85-f3f9ba3ddd48@arm.com>
Date: Tue, 17 Aug 2021 14:23:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210817113450.2026-1-thunder.leizhen@huawei.com>
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

On 2021-08-17 12:34, Zhen Lei wrote:
> Although the parameter 'cmd' is always passed by a local array variable,
> and only this function modifies it, the compiler does not know this. The
> compiler almost always reads the value of cmd[i] from memory rather than
> directly using the value cached in the register. This generates many
> useless instruction operations and affects the performance to some extent.

Which compiler? GCC 4.9 does not make the same codegen decisions that 
GCC 10 does; Clang is different again. There are also various config 
options which affect a compiler's inlining/optimisation choices either 
directly or indirectly.

If it's something that newer compilers can get right anyway, then 
micro-optimising just for older ones might warrant a bit more justification.

> To guide the compiler for proper optimization, 'cmd' is defined as a local
> array variable, marked as register, and copied to the output parameter at
> a time when the function is returned.
> 
> The optimization effect can be viewed by running the "size arm-smmu-v3.o"
> command.
> 
> Before:
>     text    data     bss     dec     hex
>    27602    1348      56   29006    714e
> 
> After:
>     text    data     bss     dec     hex
>    27402    1348      56   28806    7086
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index d76bbbde558b776..50a9db5bac466c7 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -233,11 +233,19 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
>   	return 0;
>   }
>   
> +#define arm_smmu_cmdq_copy_cmd(dst, src)	\
> +	do {					\
> +		dst[0] = src[0];		\
> +		dst[1] = src[1];		\
> +	} while (0)
> +
>   /* High-level queue accessors */
> -static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
> +static int arm_smmu_cmdq_build_cmd(u64 *out_cmd, struct arm_smmu_cmdq_ent *ent)
>   {
> -	memset(cmd, 0, 1 << CMDQ_ENT_SZ_SHIFT);
> -	cmd[0] |= FIELD_PREP(CMDQ_0_OP, ent->opcode);
> +	register u64 cmd[CMDQ_ENT_DWORDS];
> +
> +	cmd[0] = FIELD_PREP(CMDQ_0_OP, ent->opcode);
> +	cmd[1] = 0;
>   
>   	switch (ent->opcode) {
>   	case CMDQ_OP_TLBI_EL2_ALL:
> @@ -309,6 +317,7 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>   		case PRI_RESP_SUCC:
>   			break;
>   		default:
> +			arm_smmu_cmdq_copy_cmd(out_cmd, cmd);

Why bother writing back a partial command when we're telling the caller 
it's invalid anyway?

>   			return -EINVAL;
>   		}
>   		cmd[1] |= FIELD_PREP(CMDQ_PRI_1_RESP, ent->pri.resp);
> @@ -329,9 +338,12 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>   		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
>   		break;
>   	default:
> +		arm_smmu_cmdq_copy_cmd(out_cmd, cmd);

Ditto.

>   		return -ENOENT;
>   	}
>   
> +	arm_smmu_cmdq_copy_cmd(out_cmd, cmd);

...and then it would be simpler to open-code the assignment here.

I guess if you're really concerned with avoiding temporary commands 
being written back to the stack and reloaded, it might be worth 
experimenting with wrapping them in a struct which can be passed around 
by value - AAPCS64 allows passing a 16-byte composite type purely in 
registers.

Robin.

> +
>   	return 0;
>   }
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
