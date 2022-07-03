Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F841C433EF
	for <iommu@archiver.kernel.org>; Sun,  3 Jul 2022 19:10:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6EB4410C8;
	Sun,  3 Jul 2022 19:10:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A6EB4410C8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=x04iaenc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P4i77s8cvCOu; Sun,  3 Jul 2022 19:10:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1898C410D3;
	Sun,  3 Jul 2022 19:10:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1898C410D3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6421C0032;
	Sun,  3 Jul 2022 19:10:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7FF4AC002D
 for <iommu@lists.linux-foundation.org>; Sun,  3 Jul 2022 19:10:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4D533410D3
 for <iommu@lists.linux-foundation.org>; Sun,  3 Jul 2022 19:10:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4D533410D3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2bGqh2ThXIIT for <iommu@lists.linux-foundation.org>;
 Sun,  3 Jul 2022 19:10:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C52B410C8
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C52B410C8
 for <iommu@lists.linux-foundation.org>; Sun,  3 Jul 2022 19:10:13 +0000 (UTC)
Received: by mail-lf1-x129.google.com with SMTP id a4so12452029lfm.0
 for <iommu@lists.linux-foundation.org>; Sun, 03 Jul 2022 12:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
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
 b=7M9LkVZTeqSkv0bg2IngzRXSSHmeY0zsazN5cluimG0O8VSYSeG+NbXQPHUvs5SInP
 fR8zSTQrN+e6zJeWScBLX3cYi8i8k2a5Vo11BYKCUz2pe/E5x6cSWsIweM2XulQw0cxS
 qbP6SGSc4QvD0sPIARo7SESaTTH1ClWRUj6AUGy24wIX2r9O1oYUkZeIeIwH23qGm6Fg
 eidxIrQxvCMZfVMvmGGeXz0tDeeayCq8Y33P8TyNgjTKY4DEnJ7dt1Jfg+YIOwzhcXIy
 OPP7GHmzKhQZ7ssNqDzZCPaaqDfEC/Jc1qnvc9w+VMhroRrAwGBzI9ZsWPVrEtPxqtaa
 lPMQ==
X-Gm-Message-State: AJIora/oYnhr6/tBqFinEjMJcHAentOVZzZQVRPJyoP0MdoircZ8Gh6K
 L8k0FNCKDDuCDeOd57noElR1sQ==
X-Google-Smtp-Source: AGRyM1vt1+px48qZ8Nvj6T1HQ2dg8DedlqRt7777HjENa2umG2gtSUlaHdtqLM7XMJpVbyyOL4zS5A==
X-Received: by 2002:a05:6512:1385:b0:47f:781d:abc9 with SMTP id
 p5-20020a056512138500b0047f781dabc9mr15505032lfa.687.1656875411319; 
 Sun, 03 Jul 2022 12:10:11 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
 by smtp.gmail.com with ESMTPSA id
 d7-20020a056512368700b00478ee064d9bsm4819210lfs.177.2022.07.03.12.10.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Jul 2022 12:10:10 -0700 (PDT)
Message-ID: <23357d34-4570-1309-6b6e-46055bdb8160@linaro.org>
Date: Sun, 3 Jul 2022 21:10:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/4] iommu/exynos: Check if SysMMU v7 has VM registers
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <20220702213724.3949-1-semen.protsenko@linaro.org>
 <20220702213724.3949-3-semen.protsenko@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220702213724.3949-3-semen.protsenko@linaro.org>
Cc: Janghyuck Kim <janghyuck.kim@samsung.com>,
 linux-samsung-soc@vger.kernel.org, Will Deacon <will@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Cho KyongHo <pullip.cho@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

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
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
