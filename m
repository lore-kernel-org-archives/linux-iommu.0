Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E383EC433FE
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 16:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 92AFE40B2A;
	Tue, 31 May 2022 16:26:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K8kQDRlYwBZC; Tue, 31 May 2022 16:26:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 60D2240104;
	Tue, 31 May 2022 16:26:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 350EBC0039;
	Tue, 31 May 2022 16:26:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80560C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 16:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5F99941C46
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 16:26:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4es4gA1xH-7Z for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 16:26:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1D83A41C3C
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 16:26:21 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 484C023A;
 Tue, 31 May 2022 09:26:21 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E8023F73D;
 Tue, 31 May 2022 09:26:19 -0700 (PDT)
Message-ID: <edf89f9a-23ce-16ce-33f4-7796ed6bdb4c@arm.com>
Date: Tue, 31 May 2022 17:26:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/6] iommu/qcom: Write TCR before TTBRs to fix ASID access
 behavior
Content-Language: en-GB
To: Will Deacon <will@kernel.org>, Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20220527212901.29268-1-konrad.dybcio@somainline.org>
 <20220527212901.29268-3-konrad.dybcio@somainline.org>
 <20220531155559.GB25502@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220531155559.GB25502@willie-the-truck>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 jamipkettunen@somainline.org, iommu@lists.linux-foundation.org,
 martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
 angelogioacchino.delregno@somainline.org, marijn.suijten@somainline.org,
 linux-arm-kernel@lists.infradead.org
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

On 2022-05-31 16:55, Will Deacon wrote:
> On Fri, May 27, 2022 at 11:28:57PM +0200, Konrad Dybcio wrote:
>> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>>
>> As also stated in the arm-smmu driver, we must write the TCR before
>> writing the TTBRs, since the TCR determines the access behavior of
>> some fields.
> 
> Where is this stated in the arm-smmu driver?

In arm_smmu_write_context_bank() - IIRC it's mostly about the case where 
if you write a 16-bit ASID to TTBR before setting TCR2.AS you might end 
up losing the top 8 bits of it. However, in the context of a pantomime 
where we just have to pretend to program the "hardware" the way the 
firmware has already programmed it (on pain of getting randomly reset if 
we look at it wrong), I can't imagine it really matters.

Robin.

>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>> ---
>>   drivers/iommu/arm/arm-smmu/qcom_iommu.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>> index 1728d4d7fe25..75f353866c40 100644
>> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>> @@ -273,18 +273,18 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
>>   			ctx->secure_init = true;
>>   		}
>>   
>> -		/* TTBRs */
>> -		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
>> -				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
>> -				FIELD_PREP(ARM_SMMU_TTBRn_ASID, ctx->asid));
>> -		iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
>> -
>>   		/* TCR */
>>   		iommu_writel(ctx, ARM_SMMU_CB_TCR2,
>>   				arm_smmu_lpae_tcr2(&pgtbl_cfg));
>>   		iommu_writel(ctx, ARM_SMMU_CB_TCR,
>>   			     arm_smmu_lpae_tcr(&pgtbl_cfg) | ARM_SMMU_TCR_EAE);
>>   
>> +		/* TTBRs */
>> +		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
>> +				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
>> +				FIELD_PREP(ARM_SMMU_TTBRn_ASID, ctx->asid));
>> +		iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
> 
> I'd have thought that SCTLR.M would be clear here, so it shouldn't matter
> what order we write these in.
> 
> Will
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
