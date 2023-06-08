Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEFD31EEE
	for <iommu@lists.linux.dev>; Thu,  8 Jun 2023 21:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19047C433D2;
	Thu,  8 Jun 2023 21:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686258168;
	bh=BXCYc0LX+cWXyo3YnVYrHoy26ym6pRqn7Ay5/hOAeY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XgkbRpwpmwndNWkxQ6Vsj+abzRMoJLGC0rQeAyw4frHOgpdjQEcV8WW0f0SZIvtsr
	 SinNKEwADMHYCALWpLa08pQMbgm0NQuPQ2qJsj8zZGAqvn3F2Og4F5yxR+Si+8J9Qw
	 pQ+bnXP4SFWmtcSrNz8FGC7LHWMclVrmcvj1d8XG8Tl2Zd+koEGSSKWtc2EiqO2AAV
	 REpY6V85bVLMcf2+tEmfdJzT5GP2Mmi8aeL81oXGL9zHYOtWyU8Qd0Vj3gpFP5VOtC
	 JlvMDV73WFpbRmq37qvN/+Iaxv6TNT8WNvoDP7o4fwIqpTSqOaL83NadzogX8YUhsm
	 zVLqOexqR6hYg==
Date: Thu, 8 Jun 2023 22:02:41 +0100
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
	iommu@lists.linux.dev
Subject: Re: [PATCH v6 11/12] iommu/arm-smmu-qcom: Add SM6375 DPU compatible
Message-ID: <20230608210241.GB2495@willie-the-truck>
References: <20230411-topic-straitlagoon_mdss-v6-0-dee6a882571b@linaro.org>
 <20230411-topic-straitlagoon_mdss-v6-11-dee6a882571b@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411-topic-straitlagoon_mdss-v6-11-dee6a882571b@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jun 06, 2023 at 02:44:02PM +0200, Konrad Dybcio wrote:
> Add the SM6375 DPU compatible to clients compatible list, as it also
> needs the workarounds.
> 
> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 3800ab478216..cc574928c707 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -253,6 +253,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>  	{ .compatible = "qcom,sc8280xp-mdss" },
>  	{ .compatible = "qcom,sdm845-mdss" },
>  	{ .compatible = "qcom,sdm845-mss-pil" },
> +	{ .compatible = "qcom,sm6375-mdss" },
>  	{ .compatible = "qcom,sm8150-mdss" },
>  	{ .compatible = "qcom,sm8250-mdss" },
>  	{ }

Acked-by: Will Deacon <will@kernel.org>

Will
