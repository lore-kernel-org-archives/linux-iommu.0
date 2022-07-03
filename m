Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1843D99
	for <iommu@lists.linux.dev>; Sun,  3 Jul 2022 19:29:28 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id e12so12420631lfr.6
        for <iommu@lists.linux.dev>; Sun, 03 Jul 2022 12:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=i5wtCXYxEilIDlR1Tb1chxWfsSuVt3D0ru4PVAx89GA=;
        b=V/sJoy3c8XR84kLCl1iuDYDtvBP6FHg1suLB8kp+xk99HP7dBLUDEUkFiwcMKs/bmc
         me0hHW7666Y5eTEO6knbJLQmSH0SNpyaz4deKVYXqniVP0kuIySZfPRUVH7CJUqCdhRB
         EM7Eju8b6nb0ptdbbGK85g2kvp/0AvigbhmhKn6LSrtyeIFUCX5jrjlKHwz3L/TfUVk6
         04QaE24TGPt0X/pZwfMwko5yLfaGJGLQb2t+lj8Wj3w+hOn8SpjWe1wZmghr2IAavNa+
         x2X0dPoIsEyuGlH7Y8mPPEfcuVzL2gJAEPAG9gQFPe5RYCPbg2SifT6jtwtmzMLoxC4s
         RDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i5wtCXYxEilIDlR1Tb1chxWfsSuVt3D0ru4PVAx89GA=;
        b=BJuSluKYuEY6fZQX+/rxnhZB8/hRMF/SDusK5DXtz8Y84N9mHzm3tGptnQ1Em0+c0Q
         a6kBGguU1SE9slH5+DO6G/9WeY49qy0264+zTs4626piaitAwK5FjnAXh/GHEEEgAElh
         V5D9HDg1oHglSK+q0SzK3MQKuUIwkCz61mV6/3ypqO2Di2I3AJdyynkvw5j+kK2g2PfK
         KaamXLLvDqblOKvKVdQVhBqULL/bJTZg+1qFFqfUrWglP4i0gdCxTAhZR5wTmouwzhD3
         1gVLFzCf/msWHu4UCE7m0RWOZWoAGKBj4dfDUEXdSvL0XS1sFDJK++AFvDugpZZ1XPsG
         58Kw==
X-Gm-Message-State: AJIora+pGXPNALqvl0+YnN9H8w56HsojwAzm9aPTV5OC/dqGiM+T3B6h
	S/xTMcKejTFB6DHCsyc17Iw/BA==
X-Google-Smtp-Source: AGRyM1tuebHcxMak/0zoa3ssaNz+q2ks4xgo5STk1RpSrEpIsa81AK1dKOV+2Ce1ivfqZvpMrimgcw==
X-Received: by 2002:a05:6512:3056:b0:481:18a6:d09c with SMTP id b22-20020a056512305600b0048118a6d09cmr17063691lfb.4.1656876567135;
        Sun, 03 Jul 2022 12:29:27 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id r11-20020ac25a4b000000b00479471cda69sm4831005lfn.156.2022.07.03.12.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 12:29:26 -0700 (PDT)
Message-ID: <925751c3-83e8-02b8-6a8b-549290522a9e@linaro.org>
Date: Sun, 3 Jul 2022 21:29:24 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/4] iommu/exynos: Use lookup based approach to access v7
 registers
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Janghyuck Kim <janghyuck.kim@samsung.com>,
 Cho KyongHo <pullip.cho@samsung.com>, Daniel Mentz <danielmentz@google.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux-foundation.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220702213724.3949-1-semen.protsenko@linaro.org>
 <20220702213724.3949-4-semen.protsenko@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220702213724.3949-4-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <20220703192924.R2PV_sq1cVPpCqGBEctuoX4y3q1Bbwvexu1NfjZ6izY@z>

On 02/07/2022 23:37, Sam Protsenko wrote:
> SysMMU v7 might have different register layouts (VM capable or non-VM
> capable). Check which layout is implemented in current SysMMU module and
> prepare the corresponding register table for futher usage. This way is
> faster and more elegant than checking corresponding condition (if it's
> VM or non-VM SysMMU) each time before accessing v7 registers. For now
> the register table contains only most basic registers needed to add the
> SysMMU v7 support.
> 
> This patch is based on downstream work of next authors:
>   - Janghyuck Kim <janghyuck.kim@samsung.com>
>   - Daniel Mentz <danielmentz@google.com>
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/iommu/exynos-iommu.c | 46 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index df6ddbebbe2b..47017e8945c5 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -180,6 +180,47 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
>  
>  #define has_sysmmu(dev)		(dev_iommu_priv_get(dev) != NULL)
>  
> +#define MMU_REG(data, idx)		\
> +	((data)->sfrbase + (data)->regs[idx].off)

I would expect to see users of this - convert all existing regs.

> +#define MMU_VM_REG(data, idx, vmid)	\
> +	(MMU_REG(data, idx) + (vmid) * (data)->regs[idx].mult)
> +
> +enum {
> +	REG_SET_NON_VM,
> +	REG_SET_VM,
> +	MAX_REG_SET
> +};
> +
> +enum {
> +	IDX_CTRL_VM,
> +	IDX_CFG_VM,
> +	IDX_FLPT_BASE,

Isn't this called REG_MMU_FLUSH? If yes, it's a bit confusing to see
different name used.

> +	IDX_ALL_INV,

Isn't this called REG_MMU_FLUSH_ENTRY?

> +	MAX_REG_IDX
> +};
> +
> +struct sysmmu_vm_reg {
> +	unsigned int off;	/* register offset */
> +	unsigned int mult;	/* VM index offset multiplier */
> +};
> +
> +static const struct sysmmu_vm_reg sysmmu_regs[MAX_REG_SET][MAX_REG_IDX] = {
> +	/* Default register set (non-VM) */
> +	{
> +		/*
> +		 * SysMMUs without VM support do not have CTRL_VM and CFG_VM
> +		 * registers. Setting the offsets to 1 will trigger an unaligned
> +		 * access exception.

So why are you setting offset 1? To trigger unaligned access?

> +		 */
> +		{0x1}, {0x1}, {0x000c}, {0x0010},
> +	},
> +	/* VM capable register set */
> +	{
> +		{0x8000, 0x1000}, {0x8004, 0x1000}, {0x800c, 0x1000},
> +		{0x8010, 0x1000},
> +	},
You add here quite a bit of dead code and some hard-coded numbers.

> +};
> +
>  static struct device *dma_dev;
>  static struct kmem_cache *lv2table_kmem_cache;
>  static sysmmu_pte_t *zero_lv2_table;
> @@ -284,6 +325,7 @@ struct sysmmu_drvdata {
>  
>  	/* v7 fields */
>  	bool has_vcr;			/* virtual machine control register */
> +	const struct sysmmu_vm_reg *regs; /* register set */
>  };
>  
>  static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
> @@ -407,6 +449,10 @@ static void sysmmu_get_hw_info(struct sysmmu_drvdata *data)
>  	__sysmmu_get_version(data);
>  	if (MMU_MAJ_VER(data->version) >= 7 && __sysmmu_has_capa1(data))
>  		__sysmmu_get_vcr(data);
> +	if (data->has_vcr)
> +		data->regs = sysmmu_regs[REG_SET_VM];
> +	else
> +		data->regs = sysmmu_regs[REG_SET_NON_VM];

This is set and not read.

>  
>  	__sysmmu_disable_clocks(data);
>  }


Best regards,
Krzysztof
