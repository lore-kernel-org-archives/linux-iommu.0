Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336695221
	for <iommu@lists.linux.dev>; Fri, 27 Jan 2023 22:00:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78E222F4;
	Fri, 27 Jan 2023 14:00:47 -0800 (PST)
Received: from [10.57.88.221] (unknown [10.57.88.221])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1C5A3F5A1;
	Fri, 27 Jan 2023 14:00:01 -0800 (PST)
Message-ID: <89da64c8-fef4-2cea-f15c-86264073500c@arm.com>
Date: Fri, 27 Jan 2023 21:59:50 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/4] iommu/dma: Do not init domain if
 broken_unmanaged_domain
Content-Language: en-GB
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 joro@8bytes.org, will@kernel.org, agross@kernel.org, andersson@kernel.org,
 konrad.dybcio@linaro.org, yong.wu@mediatek.com, matthias.bgg@gmail.com,
 thierry.reding@gmail.com, alex.williamson@redhat.com, cohuck@redhat.com
Cc: vdumpa@nvidia.com, jonathanh@nvidia.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-tegra@vger.kernel.org, kvm@vger.kernel.org
References: <cover.1674849118.git.nicolinc@nvidia.com>
 <451e7beb57ec6de66ee0da5b38886105436f53d7.1674849118.git.nicolinc@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <451e7beb57ec6de66ee0da5b38886105436f53d7.1674849118.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-01-27 20:04, Nicolin Chen wrote:
> Add a sanity of the broken_unmanaged_domain flag to reject the use of
> dma-iommu in the early stage, if the flag is set by the iommu driver.

Realistically, iommu-dma will never be enabled on PPC32, let alone used. 
It will not be enabled on ARM until I've fixed any drivers which need 
fixing to work with it. We don't need to add dead code here.

Thanks,
Robin.

> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/dma-iommu.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index f798c44e0903..f1e8d952b17d 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -545,6 +545,9 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>   	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
>   		return -EINVAL;
>   
> +	if (WARN_ON(!device_iommu_unmanaged_supported(dev)))
> +		return -EINVAL;
> +
>   	iovad = &cookie->iovad;
>   
>   	/* Use the smallest supported page size for IOVA granularity */
