Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9603F31EEE
	for <iommu@lists.linux.dev>; Thu,  8 Jun 2023 21:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A092C433EF;
	Thu,  8 Jun 2023 21:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686258193;
	bh=5Rqs+TI7+U0eTYgJLifNYXyYtZalpZhl4Y2ONh4Xl2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hogd7k5+0BE0wjtaKU01zNYc29U/k3Goxl5anOqgH2sxWYb36LRyzdhofvkKfKPTk
	 EvEKecJMezYocqqYuYnqKj5n8pN/YlWVfHntaMcUg4Kl0yl7Yc9jkwaq1sHF1ZsT3a
	 I81NXvP99k/zb55mtp1Tll6GwLHa4ifIFKeolUipmNyltca25i/J+4VKmiuB9D0jF3
	 FbtWAwx05Rw74Mk6Wns7azZ8s22ggK35SG3WRJPWI2wg2O7nWuAU4w8fbaVwQkRdRB
	 55850+WI+9zxjkHPkObSO8BqWWzcfBVEywLJiFZr6m746r7M/M7CQWnRptssSGfUWL
	 /yqV3xTyWOdmg==
Date: Thu, 8 Jun 2023 22:03:05 +0100
From: Will Deacon <will@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Krishna Manikandan <quic_mkrishn@quicinc.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH v6 12/12] iommu/arm-smmu-qcom: Add SM6350 DPU compatible
Message-ID: <20230608210304.GC2495@willie-the-truck>
References: <20230411-topic-straitlagoon_mdss-v6-0-dee6a882571b@linaro.org>
 <20230411-topic-straitlagoon_mdss-v6-12-dee6a882571b@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411-topic-straitlagoon_mdss-v6-12-dee6a882571b@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jun 06, 2023 at 02:44:03PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@somainline.org>
> 
> Add the SM6350 DPU compatible to clients compatible list, as it also
> needs the workarounds.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index cc574928c707..bdeb587552c0 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -253,6 +253,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>  	{ .compatible = "qcom,sc8280xp-mdss" },
>  	{ .compatible = "qcom,sdm845-mdss" },
>  	{ .compatible = "qcom,sdm845-mss-pil" },
> +	{ .compatible = "qcom,sm6350-mdss" },
>  	{ .compatible = "qcom,sm6375-mdss" },
>  	{ .compatible = "qcom,sm8150-mdss" },
>  	{ .compatible = "qcom,sm8250-mdss" },

Acked-by: Will Deacon <will@kernel.org>

Will
