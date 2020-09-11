Return-Path: <SRS0=FRM4=CU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F2FC43461
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 16:03:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52B8A21D47
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 16:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B8A21D47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DAE3E86BF8;
	Fri, 11 Sep 2020 16:03:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uVAnLtgcIZWg; Fri, 11 Sep 2020 16:03:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B7E4E86B52;
	Fri, 11 Sep 2020 16:03:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AACFEC0859;
	Fri, 11 Sep 2020 16:03:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7515FC0051
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 16:03:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6437186BF1
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 16:03:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OjedOLE-0inu for <iommu@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 16:03:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 535A286B52
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 16:03:21 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E33F106F;
 Fri, 11 Sep 2020 09:03:15 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A88D43F73C;
 Fri, 11 Sep 2020 09:03:11 -0700 (PDT)
Subject: Re: [PATCHv4 6/6] iommu: arm-smmu-impl: Remove unwanted extra blank
 lines
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, Rob Clark <robdclark@gmail.com>
References: <cover.1599832685.git.saiprakash.ranjan@codeaurora.org>
 <010101747d912d9f-c8050b8d-1e81-4be0-ac35-b221f657b490-000000@us-west-2.amazonses.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <c26b5317-f12d-8be9-be45-3307ce5efbfc@arm.com>
Date: Fri, 11 Sep 2020 17:03:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <010101747d912d9f-c8050b8d-1e81-4be0-ac35-b221f657b490-000000@us-west-2.amazonses.com>
Content-Language: en-GB
Cc: linux-arm-msm@vger.kernel.org, Akhil P Oommen <akhilpo@codeaurora.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org,
 "Kristian H . Kristensen" <hoegsberg@google.com>,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
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

On 2020-09-11 15:28, Sai Prakash Ranjan wrote:
> There are few places in arm-smmu-impl where there are
> extra blank lines, remove them

FWIW those were deliberate - sometimes I like a bit of subtle space to 
visually delineate distinct groups of definitions. I suppose it won't be 
to everyone's taste :/

> and while at it fix the
> checkpatch warning for space required before the open
> parenthesis.

That one, however, was not ;)

BTW am I supposed to have received 3 copies of everything? Because I did...

Robin.

> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> index ce78295cfa78..f5b5218cbe5b 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> @@ -19,7 +19,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>   
>   static int arm_smmu_gr0_ns(int offset)
>   {
> -	switch(offset) {
> +	switch (offset) {
>   	case ARM_SMMU_GR0_sCR0:
>   	case ARM_SMMU_GR0_sACR:
>   	case ARM_SMMU_GR0_sGFSR:
> @@ -54,7 +54,6 @@ static const struct arm_smmu_impl calxeda_impl = {
>   	.write_reg = arm_smmu_write_ns,
>   };
>   
> -
>   struct cavium_smmu {
>   	struct arm_smmu_device smmu;
>   	u32 id_base;
> @@ -110,7 +109,6 @@ static struct arm_smmu_device *cavium_smmu_impl_init(struct arm_smmu_device *smm
>   	return &cs->smmu;
>   }
>   
> -
>   #define ARM_MMU500_ACTLR_CPRE		(1 << 1)
>   
>   #define ARM_MMU500_ACR_CACHE_LOCK	(1 << 26)
> @@ -197,7 +195,6 @@ static const struct arm_smmu_impl mrvl_mmu500_impl = {
>   	.reset = arm_mmu500_reset,
>   };
>   
> -
>   struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>   {
>   	const struct device_node *np = smmu->dev->of_node;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
