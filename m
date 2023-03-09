Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8E02F28
	for <iommu@lists.linux.dev>; Thu,  9 Mar 2023 13:13:18 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9148C14;
	Thu,  9 Mar 2023 05:14:01 -0800 (PST)
Received: from [10.57.91.145] (unknown [10.57.91.145])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C52B3F67D;
	Thu,  9 Mar 2023 05:13:16 -0800 (PST)
Message-ID: <4e426dc4-6852-336f-7321-5b4df69fd430@arm.com>
Date: Thu, 9 Mar 2023 13:13:11 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 06/14] iommu/arm-smmu-v3: Unset corresponding STE
 fields when s2_cfg is NULL
Content-Language: en-GB
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, will@kernel.org
Cc: eric.auger@redhat.com, kevin.tian@intel.com, baolu.lu@linux.intel.com,
 joro@8bytes.org, shameerali.kolothum.thodi@huawei.com,
 jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <995e48fe6eb9e31c71dbe8bb80d445aa34a51819.1678348754.git.nicolinc@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <995e48fe6eb9e31c71dbe8bb80d445aa34a51819.1678348754.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-03-09 10:53, Nicolin Chen wrote:
> From: Eric Auger <eric.auger@redhat.com>
> 
> Despite the spec does not seem to mention this, on some implementations,
> when the STE configuration switches from an S1+S2 cfg to an S1 only one,
> a C_BAD_STE error would happen if dst[3] (S2TTB) is not reset.

Can you provide more details, since it's not clear whether this is a 
hardware erratum workaround or a bodge around the driver itself doing 
something wrong like not doing a proper break-before-make transition of 
the STE. The architecture explicitly states that all the STE.S2* fields 
except S2VMID and potentially S2S are ignored when Stage 2 is bypassed.

Thanks,
Robin.

> Explicitly reset those two higher 64b fields, to prevent that.
> 
> Note that this is not a bug at this moment, since a 2-stage translation
> setup is not yet enabled, until the following patches add its support.
> 
> Reported-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index c5616145e2a3..29e36448d23b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1361,6 +1361,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>   		dst[3] = cpu_to_le64(s2_cfg->vttbr & STRTAB_STE_3_S2TTB_MASK);
>   
>   		val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S2_TRANS);
> +	}  else {
> +		dst[2] = 0;
> +		dst[3] = 0;
>   	}
>   
>   	if (master->ats_enabled)
