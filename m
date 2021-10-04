Return-Path: <SRS0=nHvM=OY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61CFC433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Oct 2021 12:07:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FD436128A
	for <iommu@archiver.kernel.org>; Mon,  4 Oct 2021 12:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6FD436128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 41215427AA;
	Mon,  4 Oct 2021 12:07:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uw6a-NKeDt-m; Mon,  4 Oct 2021 12:07:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C576542747;
	Mon,  4 Oct 2021 12:07:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A79DAC000F;
	Mon,  4 Oct 2021 12:07:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD62AC000D
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 12:07:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F64C6072F
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 12:07:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q8Of18yykhC9 for <iommu@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 12:07:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9CB83606A2
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 12:07:19 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id F24A960F9B;
 Mon,  4 Oct 2021 12:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633349239;
 bh=rCJYdr32dOl1E74PBWpYOr8BwKcZx05HK0ZRUpipNQ4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oKQjBWAnxcd/31GhQ0+bLFhoylKcEBeS3fcT6cHbp4QqE8BZDvJ0vXfy85uElZqHk
 mZqNoC9UaK2GU52qbBumDMWACYDr3P7VBcdV4jpnc7/ant6AZwpEWh1HE/RAmdgKHS
 uYPA8/TvcSFKCImvCsQ61FZC1Qu2U8J3xRM/ZSmIfO+y5q/UBTEM/yD7mJ1lTSQYJb
 FnRcNGQmg48BYP7b+1DMZdrn9Owx+r8iZ8+yaxBNpzbiBjOWrcYgTn6DYsaSX+xt5u
 1f5nA91t8/HLEnztt0UX7X+WzXKlQu6zi5mF8//0PAPlnw3vfWK82zU1cX4EkFxgQk
 Kj1AklzDHqRRA==
Date: Mon, 4 Oct 2021 13:07:15 +0100
From: Will Deacon <will@kernel.org>
To: Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3: Simplify useless instructions
 in arm_smmu_cmdq_build_cmd()
Message-ID: <20211004120714.GD27373@willie-the-truck>
References: <20210818080452.2079-1-thunder.leizhen@huawei.com>
 <20210818080452.2079-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210818080452.2079-3-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

On Wed, Aug 18, 2021 at 04:04:52PM +0800, Zhen Lei wrote:
> Although the parameter 'cmd' is always passed by a local array variable,
> and only this function modifies it, the compiler does not know this. The
> compiler almost always reads the value of cmd[i] from memory rather than
> directly using the value cached in the register. This generates many
> useless instruction operations and affects the performance to some extent.
> 
> To guide the compiler for proper optimization, 'cmd' is defined as a local
> array variable, marked as register, and copied to the output parameter at
> a time when the function is returned.
> 
> The optimization effect can be viewed by running the "size arm-smmu-v3.o"
> command.
> 
> Before:
>    text    data     bss     dec     hex
>   26954    1348      56   28358    6ec6
> 
> After:
>    text    data     bss     dec     hex
>   26762    1348      56   28166    6e06
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 01e95b56ffa07d1..7cec0c967f71d86 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -234,10 +234,12 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
>  }
>  
>  /* High-level queue accessors */
> -static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
> +static int arm_smmu_cmdq_build_cmd(u64 *out_cmd, struct arm_smmu_cmdq_ent *ent)
>  {
> -	memset(cmd, 0, 1 << CMDQ_ENT_SZ_SHIFT);
> -	cmd[0] |= FIELD_PREP(CMDQ_0_OP, ent->opcode);
> +	register u64 cmd[CMDQ_ENT_DWORDS];

'register' is pretty badly specified outside of a handful of limited uses in
conjunction with inline asm, so I really don't think we should be using it
here.

> +	cmd[0] = FIELD_PREP(CMDQ_0_OP, ent->opcode);

This generates a compiler warning about taking the address of a 'register'
variable.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
