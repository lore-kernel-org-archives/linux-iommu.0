Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176B83D0D9
	for <iommu@lists.linux.dev>; Thu,  7 Dec 2023 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2D0011FB;
	Thu,  7 Dec 2023 05:07:01 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 051FD3F6C4;
	Thu,  7 Dec 2023 05:06:13 -0800 (PST)
Message-ID: <6397268c-7990-42f6-9453-44fdc638d5c9@arm.com>
Date: Thu, 7 Dec 2023 13:06:09 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iommu/msm-iommu: don't limit the driver too much
Content-Language: en-GB
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Clark <robdclark@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>,
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 freedreno@lists.freedesktop.org
References: <20231207125500.3322229-1-dmitry.baryshkov@linaro.org>
 <20231207125500.3322229-2-dmitry.baryshkov@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231207125500.3322229-2-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/12/2023 12:54 pm, Dmitry Baryshkov wrote:
> In preparation of dropping most of ARCH_QCOM subtypes, stop limiting the
> driver just to those machines. Allow it to be built for any 32-bit
> Qualcomm platform (ARCH_QCOM).

Acked-by: Robin Murphy <robin.murphy@arm.com>

Unless Joerg disagrees, I think it should be fine if you want to take 
this via the SoC tree.

Thanks,
Robin.


> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/iommu/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 7673bb82945b..fd67f586f010 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -178,7 +178,7 @@ config FSL_PAMU
>   config MSM_IOMMU
>   	bool "MSM IOMMU Support"
>   	depends on ARM
> -	depends on ARCH_MSM8X60 || ARCH_MSM8960 || COMPILE_TEST
> +	depends on ARCH_QCOM || COMPILE_TEST
>   	select IOMMU_API
>   	select IOMMU_IO_PGTABLE_ARMV7S
>   	help
