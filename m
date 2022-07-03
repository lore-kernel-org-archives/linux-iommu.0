Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489FA33F8
	for <iommu@lists.linux.dev>; Sun,  3 Jul 2022 19:10:13 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id e12so12368452lfr.6
        for <iommu@lists.linux.dev>; Sun, 03 Jul 2022 12:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=C2tDfgoX+P267gLCuOT8WT5QIWnxnLjBwXsq25f/EmI=;
        b=x04iaenc8p/Yk53m9sEIoVyHfr30CrXFnGUblx6ubDvjy2/VNA6T7If/2Kvfthklt4
         3HH4kLMY5mvEklcgUGk0aeWDc6NriPEyg/0AxC1Y7eUtA4SmjtdDBD8N1//fOqovZ4MI
         kw1bqPUgQqE1+Oh/5OnUoQEcK85zxNzgahq1yDSuwyZzjvhgF8fwF4lkWz2NEjEQsBLm
         GHa4Ti1WgE4X97lQebJu1Ts8wlPlvWH6p22iWOwwRevblG2+jxcuB3HMlng3tVd1H3CQ
         uCsTezmE/h8FZBDl12yl3FbOULsDyTGRTV4a3mhSGuqIlhMy4ODpmTVg8YjskURr9AUc
         iCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C2tDfgoX+P267gLCuOT8WT5QIWnxnLjBwXsq25f/EmI=;
        b=APrIp/S1kBz3w+ipBdmijR1qOdrlR21k7/oIIwz3y4YXXSy8CJ9u767AUcz1r5e5GP
         E2t7cIzS+oj3/b+SUzZbGndGtzzkQuWP3STGHcxjJGE1W9ylhH/kyuz2qY9zCPletRSl
         2jzIw8ZBcECzHaFN9TNawoNdKQBMXPbBzLjn11sPD7ClpLlwyBEBTjmhJ1mmt0PUJgTq
         zlL0X1YZxbRtjQJ7LPVLrfjYzGSZ93wyt4G/tD3YfE96tfA0/DrZRJwiMwDc3hfIcH+q
         tg5KHRXKaPavp4P1X4km99xLE8arux2ySihgwsJOwY801x5Bc44HSe1q4cF5ygQlAtFL
         wzBA==
X-Gm-Message-State: AJIora9D34s17+FAuCaUsjZ2LzAvCW6WiAgj/Vvnz+OdT97/Ffmqajdc
	w22Dsg90lUnX7v0Zm2n4eFvYNg==
X-Google-Smtp-Source: AGRyM1vt1+px48qZ8Nvj6T1HQ2dg8DedlqRt7777HjENa2umG2gtSUlaHdtqLM7XMJpVbyyOL4zS5A==
X-Received: by 2002:a05:6512:1385:b0:47f:781d:abc9 with SMTP id p5-20020a056512138500b0047f781dabc9mr15505032lfa.687.1656875411319;
        Sun, 03 Jul 2022 12:10:11 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id d7-20020a056512368700b00478ee064d9bsm4819210lfs.177.2022.07.03.12.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 12:10:10 -0700 (PDT)
Message-ID: <23357d34-4570-1309-6b6e-46055bdb8160@linaro.org>
Date: Sun, 3 Jul 2022 21:10:09 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/4] iommu/exynos: Check if SysMMU v7 has VM registers
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
 <20220702213724.3949-3-semen.protsenko@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220702213724.3949-3-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <20220703191009.T8hpzOQKJcqITvgqf91cPOexv679jq2k9zw5MK1XIwU@z>

On 02/07/2022 23:37, Sam Protsenko wrote:
> SysMMU v7 can have Virtual Machine registers, which implement multiple
> translation domains. The driver should know if it's true or not, as VM
> registers shouldn't be accessed if not present. Read corresponding
> capabilities register to obtain that info, and store it in driver data.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/iommu/exynos-iommu.c | 42 ++++++++++++++++++++++++++++++------
>  1 file changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 28f8c8d93aa3..df6ddbebbe2b 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -135,6 +135,9 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
>  #define CFG_SYSSEL	(1 << 22) /* System MMU 3.2 only */
>  #define CFG_FLPDCACHE	(1 << 20) /* System MMU 3.2+ only */
>  
> +#define CAPA0_CAPA1_EXIST		BIT(11)
> +#define CAPA1_VCR_ENABLED		BIT(14)
> +
>  /* common registers */
>  #define REG_MMU_CTRL		0x000
>  #define REG_MMU_CFG		0x004
> @@ -171,6 +174,10 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
>  #define REG_V5_FAULT_AR_VA	0x070
>  #define REG_V5_FAULT_AW_VA	0x080
>  
> +/* v7.x registers */
> +#define REG_V7_CAPA0		0x870
> +#define REG_V7_CAPA1		0x874
> +
>  #define has_sysmmu(dev)		(dev_iommu_priv_get(dev) != NULL)
>  
>  static struct device *dma_dev;
> @@ -274,6 +281,9 @@ struct sysmmu_drvdata {
>  	unsigned int version;		/* our version */
>  
>  	struct iommu_device iommu;	/* IOMMU core handle */
> +
> +	/* v7 fields */
> +	bool has_vcr;			/* virtual machine control register */
>  };
>  
>  static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
> @@ -364,11 +374,7 @@ static void __sysmmu_disable_clocks(struct sysmmu_drvdata *data)
>  
>  static void __sysmmu_get_version(struct sysmmu_drvdata *data)
>  {
> -	u32 ver;
> -
> -	__sysmmu_enable_clocks(data);
> -
> -	ver = readl(data->sfrbase + REG_MMU_VERSION);
> +	const u32 ver = readl(data->sfrbase + REG_MMU_VERSION);


No need for const for local, non-pointer variables. There is no benefit
in preventing the modification and it is not a constant.

>  
>  	/* controllers on some SoCs don't report proper version */
>  	if (ver == 0x80000001u)
> @@ -378,6 +384,29 @@ static void __sysmmu_get_version(struct sysmmu_drvdata *data)
>  
>  	dev_dbg(data->sysmmu, "hardware version: %d.%d\n",
>  		MMU_MAJ_VER(data->version), MMU_MIN_VER(data->version));
> +}
> +
> +static bool __sysmmu_has_capa1(struct sysmmu_drvdata *data)
> +{
> +	const u32 capa0 = readl(data->sfrbase + REG_V7_CAPA0);

Same here and further.


Best regards,
Krzysztof
