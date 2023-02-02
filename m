Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C74963B7
	for <iommu@lists.linux.dev>; Thu,  2 Feb 2023 13:22:20 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E1CFC14;
	Thu,  2 Feb 2023 05:22:56 -0800 (PST)
Received: from [10.57.88.229] (unknown [10.57.88.229])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F58A3F64C;
	Thu,  2 Feb 2023 05:22:12 -0800 (PST)
Message-ID: <0833e426-d03d-b856-3cb3-8fe97adbb8c1@arm.com>
Date: Thu, 2 Feb 2023 13:22:07 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] iommu/arm-smmu-v3: Enable PCI ATS in passthrough mode as
 well
Content-Language: en-GB
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, will@kernel.org, joro@8bytes.org
Cc: jean-philippe@linaro.org, darren@os.amperecomputing.com,
 scott@os.amperecomputing.com
References: <20230202124053.848792-1-gankulkarni@os.amperecomputing.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230202124053.848792-1-gankulkarni@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-02-02 12:40, Ganapatrao Kulkarni wrote:
> The current smmu-v3 driver does not enable PCI ATS for physical functions
> of ATS capable End Points when booted in smmu bypass mode
> (iommu.passthrough=1). This will not allow virtual functions to enable
> ATS(even though EP supports it) while they are attached to a VM using
> VFIO driver.
> 
> This patch adds changes to enable ATS support for physical functions
> in passthrough/bypass mode as well.
> 
> Also, adding check to avoid disabling of ATS if it is not enabled,
> to avoid unnecessary call-traces.
> 
> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 6d5df91c5c46..5a605cb5ccef 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2313,11 +2313,16 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
>   static void arm_smmu_disable_ats(struct arm_smmu_master *master)
>   {
>   	struct arm_smmu_domain *smmu_domain = master->domain;
> +	struct pci_dev *pdev;
>   
>   	if (!master->ats_enabled)
>   		return;
>   
> -	pci_disable_ats(to_pci_dev(master->dev));
> +	pdev = to_pci_dev(master->dev);
> +
> +	if (pdev->ats_enabled)

If the master->ats_enabled check above passes when ATS isn't actually 
enabled, surely that's a bug?

Robin.

> +		pci_disable_ats(pdev);
> +
>   	/*
>   	 * Ensure ATS is disabled at the endpoint before we issue the
>   	 * ATC invalidation via the SMMU.
> @@ -2453,8 +2458,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   
>   	master->domain = smmu_domain;
>   
> -	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
> -		master->ats_enabled = arm_smmu_ats_supported(master);
> +	master->ats_enabled = arm_smmu_ats_supported(master);
>   
>   	arm_smmu_install_ste_for_dev(master);
>   
