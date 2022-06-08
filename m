Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0234C43334
	for <iommu@archiver.kernel.org>; Wed,  8 Jun 2022 10:27:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4CAD060FFF;
	Wed,  8 Jun 2022 10:27:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0NU9Z1SKTCA6; Wed,  8 Jun 2022 10:27:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4DAC26103D;
	Wed,  8 Jun 2022 10:27:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 282E2C0039;
	Wed,  8 Jun 2022 10:27:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E1C7C002D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 10:27:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2D07C424E1
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 10:27:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ECYScYm6tMwP for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 10:27:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DDA88424B5
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 10:27:35 +0000 (UTC)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 2C259660181B;
 Wed,  8 Jun 2022 11:27:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1654684053;
 bh=Kq9FiJlI6hhYA2IYA9Osr8xu/rdeYfLtmdfJ9Zo21bQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FQi1/TEz3EasDsgmDWKT21PyoHVa0B1l+hnaC+he5pFJCyG0OBxNaBihX1tZuKQD+
 mHKU1KaOba8jFYXdNqbdrrXqN8lO8lO7Culr0dnlbmYCPH6JEm9O2Sak9yiNqs8O5i
 FFl6wdxReAhG7BA2vfcP69C8vrQns3Cs9NtrCqVfV4s2uIQmpNazeEGoMOAd61WZTp
 s8dFGBeK31HkaAPVpksS12zrex99GIZuBoQHFs4/60HgPC0MlWj453xyuiiW3H6j/i
 1tlfMROMlR6dBcYBB7STPOJ7YR7lJUo0AFJNk0XjhDhIIdDzh8dKdNPEDhMTdpKc9V
 W1qk3cDcXPd5Q==
Message-ID: <1930a7b3-3637-9e3b-3dac-7baf034c7b7a@collabora.com>
Date: Wed, 8 Jun 2022 12:27:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/6] iommu/qcom: Write TCR before TTBRs to fix ASID access
 behavior
Content-Language: en-US
To: Marijn Suijten <marijn.suijten@somainline.org>,
 Will Deacon <will@kernel.org>
References: <20220527212901.29268-1-konrad.dybcio@somainline.org>
 <20220527212901.29268-3-konrad.dybcio@somainline.org>
 <20220531155559.GB25502@willie-the-truck>
 <20220605220618.n6rkb6cfdzzgst3j@SoMainline.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220605220618.n6rkb6cfdzzgst3j@SoMainline.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@somainline.org>, jamipkettunen@somainline.org,
 iommu@lists.linux-foundation.org, martin.botka@somainline.org,
 ~postmarketos/upstreaming@lists.sr.ht,
 angelogioacchino.delregno@somainline.org, Robin Murphy <robin.murphy@arm.com>,
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

Il 06/06/22 00:06, Marijn Suijten ha scritto:
> On 2022-05-31 16:55:59, Will Deacon wrote:
>> On Fri, May 27, 2022 at 11:28:57PM +0200, Konrad Dybcio wrote:
>>> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>>>
>>> As also stated in the arm-smmu driver, we must write the TCR before
>>> writing the TTBRs, since the TCR determines the access behavior of
>>> some fields.
>>
>> Where is this stated in the arm-smmu driver?
>>
>>>
>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>> ---
>>>   drivers/iommu/arm/arm-smmu/qcom_iommu.c | 12 ++++++------
>>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>>> index 1728d4d7fe25..75f353866c40 100644
>>> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>>> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>>> @@ -273,18 +273,18 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
>>>   			ctx->secure_init = true;
>>>   		}
>>>   
>>> -		/* TTBRs */
>>> -		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
>>> -				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
>>> -				FIELD_PREP(ARM_SMMU_TTBRn_ASID, ctx->asid));
>>> -		iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
>>> -
>>>   		/* TCR */
>>>   		iommu_writel(ctx, ARM_SMMU_CB_TCR2,
>>>   				arm_smmu_lpae_tcr2(&pgtbl_cfg));
>>>   		iommu_writel(ctx, ARM_SMMU_CB_TCR,
>>>   			     arm_smmu_lpae_tcr(&pgtbl_cfg) | ARM_SMMU_TCR_EAE);
>>>   
>>> +		/* TTBRs */
>>> +		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
>>> +				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
>>> +				FIELD_PREP(ARM_SMMU_TTBRn_ASID, ctx->asid));
>>> +		iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
>>
>> I'd have thought that SCTLR.M would be clear here, so it shouldn't matter
>> what order we write these in.
> 
> Having tested the series without this particular patch on 8976 (Sony
> Loire Suzu), it doesn't seem to matter indeed.  I'll ask around if this
> "access behaviour" was observed on a different board/platform.
> 
> - Marijn

On some platforms, the bootloader (and/or the hypervisor) is performing some
initialization of the IOMMU which, depending on the actual firmware version
that ran before booting Linux, may or may not leave SCTLR.M cleared.

Cheers,
Angelo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
