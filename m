Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31DEC433F5
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 15:56:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4701C61064;
	Tue, 31 May 2022 15:56:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oC1_U-5fFZXm; Tue, 31 May 2022 15:56:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 28FBE61282;
	Tue, 31 May 2022 15:56:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F056FC0032;
	Tue, 31 May 2022 15:56:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30584C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 15:56:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0892161282
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 15:56:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vFKZcYWqpD7v for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 15:56:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6FD0A61064
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 15:56:10 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4387261274;
 Tue, 31 May 2022 15:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E06C385A9;
 Tue, 31 May 2022 15:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654012568;
 bh=7uGXLWpMXH5FP6g6lTa6LFc8636SvC0zhKEGjnRNQQw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nYtB3DJFhm85N5k2gFA65iswAFxUThtvjMc4GPWr3W1OuKdQUsz5cvy4dtpq9hZAI
 pl7Wb2d7vYHwzDdEcZxi6sc8IVkKlbCmxVqR3OkM5AQJP+5JDPcNBNy0dkoB5u3+SK
 9Ls2FeWFT3GMgjXoZbJD1XnlLzNxvSsnUd1YUeL/Kwv+mIBkldV1xHA+5PZwQQhB2w
 b3jWTjlA6iycPQGZmYYZ6SbyaVZ4he4sXOMACC5wHFXof86nHuUSkalvwuzEGDPSji
 ToVddgHJweOKFr4n1epMSbiwTvwaWLuDOZbPV+8kagsaE+jBg360qYmIIF9XJh0f+J
 6gSMUOlnNUEag==
Date: Tue, 31 May 2022 16:55:59 +0100
From: Will Deacon <will@kernel.org>
To: Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 2/6] iommu/qcom: Write TCR before TTBRs to fix ASID
 access behavior
Message-ID: <20220531155559.GB25502@willie-the-truck>
References: <20220527212901.29268-1-konrad.dybcio@somainline.org>
 <20220527212901.29268-3-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220527212901.29268-3-konrad.dybcio@somainline.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 jamipkettunen@somainline.org, iommu@lists.linux-foundation.org,
 martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
 angelogioacchino.delregno@somainline.org, marijn.suijten@somainline.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Fri, May 27, 2022 at 11:28:57PM +0200, Konrad Dybcio wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> As also stated in the arm-smmu driver, we must write the TCR before
> writing the TTBRs, since the TCR determines the access behavior of
> some fields.

Where is this stated in the arm-smmu driver?

> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> index 1728d4d7fe25..75f353866c40 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -273,18 +273,18 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
>  			ctx->secure_init = true;
>  		}
>  
> -		/* TTBRs */
> -		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
> -				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
> -				FIELD_PREP(ARM_SMMU_TTBRn_ASID, ctx->asid));
> -		iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
> -
>  		/* TCR */
>  		iommu_writel(ctx, ARM_SMMU_CB_TCR2,
>  				arm_smmu_lpae_tcr2(&pgtbl_cfg));
>  		iommu_writel(ctx, ARM_SMMU_CB_TCR,
>  			     arm_smmu_lpae_tcr(&pgtbl_cfg) | ARM_SMMU_TCR_EAE);
>  
> +		/* TTBRs */
> +		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
> +				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
> +				FIELD_PREP(ARM_SMMU_TTBRn_ASID, ctx->asid));
> +		iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);

I'd have thought that SCTLR.M would be clear here, so it shouldn't matter
what order we write these in.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
