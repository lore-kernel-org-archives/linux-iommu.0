Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B38E4681
	for <iommu@lists.linux.dev>; Tue, 12 Jul 2022 17:00:19 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F53D165C;
	Tue, 12 Jul 2022 10:00:19 -0700 (PDT)
Received: from [10.57.85.194] (unknown [10.57.85.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63ED83F73D;
	Tue, 12 Jul 2022 10:00:16 -0700 (PDT)
Message-ID: <dcf4da29-9da0-69ea-300e-80d1f5cc10a3@arm.com>
Date: Tue, 12 Jul 2022 18:00:11 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 6/7] iommu/exynos: Add SysMMU v7 register sets
Content-Language: en-GB
To: Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Janghyuck Kim <janghyuck.kim@samsung.com>,
 Cho KyongHo <pullip.cho@samsung.com>, Daniel Mentz <danielmentz@google.com>,
 David Virag <virag.david003@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20220710230603.13526-1-semen.protsenko@linaro.org>
 <20220710230603.13526-7-semen.protsenko@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220710230603.13526-7-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-07-11 00:06, Sam Protsenko wrote:
> SysMMU v7 might have different register layouts (VM capable or non-VM
> capable). Check which layout is implemented in current SysMMU module and
> prepare the corresponding register table for futher usage.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>    - (none) This patch is new and added in v2
> 
>   drivers/iommu/exynos-iommu.c | 26 ++++++++++++++++++++++----
>   1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 48681189ccf8..64bf3331064f 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -166,6 +166,8 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
>   enum {
>   	REG_SET_V1,
>   	REG_SET_V5,
> +	REG_SET_V7_NON_VM,
> +	REG_SET_V7_VM,
>   	MAX_REG_SET
>   };
>   
> @@ -201,6 +203,16 @@ static const unsigned int sysmmu_regs[MAX_REG_SET][MAX_REG_IDX] = {
>   		0x00, 0x04, 0x08, 0x0c, 0x10, 0x14, 0x18, 0x20, 0x24,
>   		0x60, 0x64,
>   	},
> +	/* SysMMU v7: Default register set (non-VM) */
> +	{
> +		0x00, 0x04, 0x08, 0x0c, 0x10, 0x14, 0x18, 0x20, 0x24,
> +		0x60, 0x64,
> +	},
> +	/* SysMMU v7: VM capable register set */
> +	{
> +		0x00, 0x04, 0x08, 0x800c, 0x8010, 0x8014, 0x8018, 0x8020,
> +		0x8024, 0x60, 0x64,

Yuck, see, it's turning into an unreadable mess already.

This is also raising the question of whether it's worth abstracting 
accesses to the common registers if it means having an ever-increasing 
number of copies of those same offsets. Personally I'd leave those using 
regular readl/writel, but even if there's an argument for keeping all 
the callsites consistent (modulo the one that already can't be), there's 
no reason the wrappers couldn't pick up the slack, e.g.:

static void sysmmu_write(struct sysmmu_drvdata *data, size_t idx, u32 val)
{
	unsigned int offset;

	if (idx <= IDX_STATUS) {
		offset = idx * 4;
	} else {
		offset = data->regs[idx - IDX_PT_BASE];
		if (WARN_ON(!offset))
			return;
	}
	writel(val, data->sfrbase + offset);
}

Indeed, not abstracting REG_MMU_CTRL via data->regs would then make it 
trivial to be robust against unimplemented registers without even having 
to remember to initialise their offsets to some magic value, which seems 
rather attractive.

(also, as it only strikes me now, why are we passing enum values around 
as size_t? That's just odd)

Thanks,
Robin.

> +	},
>   };
>   
>   static struct device *dma_dev;
> @@ -440,12 +452,18 @@ static void sysmmu_get_hw_info(struct sysmmu_drvdata *data)
>   	__sysmmu_enable_clocks(data);
>   
>   	__sysmmu_get_version(data);
> -	if (MMU_MAJ_VER(data->version) >= 7 && __sysmmu_has_capa1(data))
> -		__sysmmu_get_vcr(data);
> -	if (MMU_MAJ_VER(data->version) < 5)
> +	if (MMU_MAJ_VER(data->version) < 5) {
>   		data->regs = sysmmu_regs[REG_SET_V1];
> -	else
> +	} else if (MMU_MAJ_VER(data->version) < 7) {
>   		data->regs = sysmmu_regs[REG_SET_V5];
> +	} else {
> +		if (__sysmmu_has_capa1(data))
> +			__sysmmu_get_vcr(data);
> +		if (data->has_vcr)
> +			data->regs = sysmmu_regs[REG_SET_V7_VM];
> +		else
> +			data->regs = sysmmu_regs[REG_SET_V7_NON_VM];
> +	}
>   
>   	__sysmmu_disable_clocks(data);
>   }
