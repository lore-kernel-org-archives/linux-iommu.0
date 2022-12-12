Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEBE28EC
	for <iommu@lists.linux.dev>; Mon, 12 Dec 2022 14:36:34 +0000 (UTC)
Received: from SoMainline.org (D57D4C6E.static.ziggozakelijk.nl [213.125.76.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id DF92F200E6;
	Mon, 12 Dec 2022 15:01:10 +0100 (CET)
Date: Mon, 12 Dec 2022 15:01:09 +0100
From: Marijn Suijten <marijn.suijten@somainline.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, andersson@kernel.org, agross@kernel.org,
	krzysztof.kozlowski@linaro.org, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Emma Anholt <emma@anholt.net>, Rob Clark <robdclark@chromium.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/arm-smmu-qcom: Add SM8150 DPU compatible
Message-ID: <20221212140109.vlc6daw4rfgodnks@SoMainline.org>
References: <20221212121054.193059-1-konrad.dybcio@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212121054.193059-1-konrad.dybcio@linaro.org>

On 2022-12-12 13:10:53, Konrad Dybcio wrote:
> From: Marijn Suijten <marijn.suijten@somainline.org>
> 
> Add the SM8150 DPU compatible to clients compatible list, as it also
> needs the workarounds.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Changes since v1:
> - rebase on clean -next
> 
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 91d404deb115..ed884c85e262 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -250,6 +250,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>  	{ .compatible = "qcom,sc7280-mdss" },
>  	{ .compatible = "qcom,sc7280-mss-pil" },
>  	{ .compatible = "qcom,sc8180x-mdss" },
> +	{ .compatible = "qcom,sm8150-mdss" },
>  	{ .compatible = "qcom,sm8250-mdss" },
>  	{ .compatible = "qcom,sdm845-mdss" },
>  	{ .compatible = "qcom,sdm845-mss-pil" },

Yikes, this is neither chronological /nor/ alphabetical; that's on the
one adding sm8250 though.  Perhaps because of where sc8180x and friends
are?

> -- 
> 2.38.1
> 
