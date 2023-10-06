Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ABF241F4
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71D9BC15;
	Fri,  6 Oct 2023 08:12:06 -0700 (PDT)
Received: from [10.1.33.17] (e122027.cambridge.arm.com [10.1.33.17])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2E5E3F5A1;
	Fri,  6 Oct 2023 08:11:24 -0700 (PDT)
Message-ID: <61ef049f-8c40-47ec-b3fd-d17cbe41b96b@arm.com>
Date: Fri, 6 Oct 2023 16:11:22 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] iommu/arm-smmu: Pass arm_smmu_domain to
 arm_smmu_init_domain_context()
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Heiko Stuebner <heiko@sntech.de>,
 Joerg Roedel <jroedel@suse.de>, Jerry Snitselaar <jsnitsel@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Niklas Schnelle <schnelle@linux.ibm.com>
References: <4-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
Content-Language: en-GB
From: Steven Price <steven.price@arm.com>
In-Reply-To: <4-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/10/2023 19:28, Jason Gunthorpe wrote:
> Instead of putting container_of() casts in the internals, use the proper
> type in this call chain. This makes it easier to check that the two global
> static domains are not leaking into call chains they should not.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 28 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 0fc4f2e8bf3ed5..bf5f541be2399f 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -393,7 +393,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>  	u32 fsr, fsynr, cbfrsynra;
>  	unsigned long iova;
>  	struct iommu_domain *domain = dev;
> -	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +	struct arm_smmu_domain *smmu_domain = dev;

Leaving aside Robin's objections - this change is clearly bogus. 'dev'
is now being case to both struct iommu_domain and struct
arm_smmu_domain. And AFAICT that won't even "happen to work" because the
struct iommu_domain isn't the first element of struct arm_smmu_domain.

Steve

