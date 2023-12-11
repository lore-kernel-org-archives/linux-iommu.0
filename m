Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA1455C26
	for <iommu@lists.linux.dev>; Mon, 11 Dec 2023 22:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35F631007;
	Mon, 11 Dec 2023 14:59:50 -0800 (PST)
Received: from [10.57.85.194] (unknown [10.57.85.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF0CF3F5A1;
	Mon, 11 Dec 2023 14:59:00 -0800 (PST)
Message-ID: <86d3ee06-7c8d-4f60-bcba-80b772ec0faf@arm.com>
Date: Mon, 11 Dec 2023 22:58:58 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/arm-smmu-qcom: Add missing GMU entry to match
 table
Content-Language: en-GB
To: Rob Clark <robdclark@gmail.com>, iommu@lists.linux-foundation.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Johan Hovold <johan@kernel.org>, Rob Clark <robdclark@chromium.org>,
 stable@vger.kernel.org, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <quic_bjorande@quicinc.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Danila Tikhonov
 <danila@jiaxyga.com>, Elliot Berman <quic_eberman@quicinc.com>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 "open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20231210180655.75542-1-robdclark@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231210180655.75542-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-12-10 6:06 pm, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> In some cases the firmware expects cbndx 1 to be assigned to the GMU,
> so we also want the default domain for the GMU to be an identy domain.
> This way it does not get a context bank assigned.  Without this, both
> of_dma_configure() and drm/msm's iommu_domain_attach() will trigger
> allocating and configuring a context bank.  So GMU ends up attached to
> both cbndx 1 and later cbndx 2.  This arrangement seemingly confounds
> and surprises the firmware if the GPU later triggers a translation
> fault, resulting (on sc8280xp / lenovo x13s, at least) in the SMMU
> getting wedged and the GPU stuck without memory access.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Cc: stable@vger.kernel.org
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> 
> I didn't add a fixes tag because really this issue has been there
> all along, but either didn't matter with other firmware or we didn't
> notice the problem.
> 
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 549ae4dba3a6..d326fa230b96 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -243,6 +243,7 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>   
>   static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>   	{ .compatible = "qcom,adreno" },
> +	{ .compatible = "qcom,adreno-gmu" },
>   	{ .compatible = "qcom,mdp4" },
>   	{ .compatible = "qcom,mdss" },
>   	{ .compatible = "qcom,sc7180-mdss" },
