Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF638F59
	for <iommu@lists.linux.dev>; Tue, 22 Aug 2023 09:40:35 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AECE211FB;
	Tue, 22 Aug 2023 02:41:15 -0700 (PDT)
Received: from [10.57.5.95] (unknown [10.57.5.95])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84D073F64C;
	Tue, 22 Aug 2023 02:40:33 -0700 (PDT)
Message-ID: <7e97b5a5-6be0-87a8-aaf7-89980b0a35d1@arm.com>
Date: Tue, 22 Aug 2023 10:40:18 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/3] iommu/arm-smmu-v3: Add an arm_smmu_tlb_inv_domain
 helper
Content-Language: en-GB
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, jgg@nvidia.com
Cc: joro@8bytes.org, jean-philippe@linaro.org, apopple@nvidia.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <cover.1692693557.git.nicolinc@nvidia.com>
 <854e2b3f2d4f1b76f916fcfc288b34526d4d4162.1692693557.git.nicolinc@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <854e2b3f2d4f1b76f916fcfc288b34526d4d4162.1692693557.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-08-22 09:45, Nicolin Chen wrote:
> Move the part of per-asid or per-vmid invalidation command issuing into a
> new helper function, which will be used in the following change.

Why? This achieves nothing except make the code harder to follow and 
disconnect the rather important comment even further from the code it is 
significant to. It's not like we need a specific prototype to take a 
function pointer from, it's just another internal call - see 
arm_smmu_flush_iotlb_all() for instance. We know the cookie is an 
arm_smmu_domain pointer because we put it there, and converting it back 
from a void pointer is exactly the same *at* the function call boundary 
as immediately afterwards.

Thanks,
Robin.

> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 24 +++++++++++++--------
>   1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 9b0dc3505601..d6c647e1eb01 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1854,12 +1854,24 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
>   	return arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
>   }
>   
> +static void arm_smmu_tlb_inv_domain(struct arm_smmu_domain *smmu_domain)
> +{
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	struct arm_smmu_cmdq_ent cmd;
> +
> +	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> +		arm_smmu_tlb_inv_asid(smmu, smmu_domain->s1_cfg.cd.asid);
> +	} else {
> +		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
> +		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
> +		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
> +	}
> +}
> +
>   /* IO_PGTABLE API */
>   static void arm_smmu_tlb_inv_context(void *cookie)
>   {
>   	struct arm_smmu_domain *smmu_domain = cookie;
> -	struct arm_smmu_device *smmu = smmu_domain->smmu;
> -	struct arm_smmu_cmdq_ent cmd;
>   
>   	/*
>   	 * NOTE: when io-pgtable is in non-strict mode, we may get here with
> @@ -1868,13 +1880,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>   	 * insertion to guarantee those are observed before the TLBI. Do be
>   	 * careful, 007.
>   	 */
> -	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> -		arm_smmu_tlb_inv_asid(smmu, smmu_domain->s1_cfg.cd.asid);
> -	} else {
> -		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
> -		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
> -		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
> -	}
> +	arm_smmu_tlb_inv_domain(smmu_domain);
>   	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
>   }
>   
