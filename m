Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F96186E
	for <iommu@lists.linux.dev>; Sun, 31 Dec 2023 00:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OxukVxqN"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ccc7d7e399so47875791fa.0
        for <iommu@lists.linux.dev>; Sat, 30 Dec 2023 16:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703983693; x=1704588493; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g7LyVOuEsI9PRtyYZaiHMTcUkVHkouuFw6JcSFaYF9Y=;
        b=OxukVxqNYtpbuBJ57fj245f9FPSUmMUq58HsDXH+H7Ty4ZUSDRI2RmlfKo3JsbK+96
         Hh4PL/alntaly7GZF30wxc2VV61b4iIST5tRBTEBttc7ymMN9tqX6RPZ9p7Is/5hcKHZ
         qdwtsDHSiSrJ8qYVPwuEPsGUclrV3//FX5+a4mLoOeurJO5XqWa5aF1dnBBDd8Y2bliD
         mGBxuPi49ocdh18Ve2KNP5mK2n+mBq9duKSRx/SVqbmQX7Cs78t54OOSyzZins+8lcee
         KvqRHRVeCCyRQb5PZdujAouvXsAz8iFWpHVwzRybmIO3Aj+lO+Lz1I7dMcMV3Evj51cd
         b6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703983693; x=1704588493;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g7LyVOuEsI9PRtyYZaiHMTcUkVHkouuFw6JcSFaYF9Y=;
        b=W0Q3iqkAXaC2mJQJRnRBdmbIzC0Zy3xrcDACIlChW8/Tay7qZbscUofn9qniVczRBz
         4yIS59jo7F5bjvS1I14ammZgc7XpSSMj3dLwmgR8a8XAsHH/AjGO9Py/BfLDdMZ1gxMd
         sk8ene/E5Ft5RMqQh1g9Twa4T0ueVbZzz/qlH3hMt1rNHXHK37GnQclHFAp78aAl07SM
         +Zalptu8drCWWEBe+PLp9NLCybhyMDm7P3r5TvvX1IViD1VdC2DOb0837Dhwwgh89e3U
         NDpnd5EGFtQnApw/kqUBvNjd3e40RKt66a6fpb3L7XJkbqIP8wYYpNke+u7Q2H1LxaG4
         uabQ==
X-Gm-Message-State: AOJu0YwkkDuyZdEcCWkT7KS6FIi8I254K4LuzkwUNtXTnP3N1qUikFRG
	FXJ26WaPQHmGnUGmE/D3wmazLdbS2lbPWQ==
X-Google-Smtp-Source: AGHT+IFmpEejX/rrWOhfbfbbPGmg2BZWWE014xgmA5s5zEjRh9/e6LaV9fp1/CE3wIgp0lirhDeR0w==
X-Received: by 2002:a2e:9b11:0:b0:2cc:eaf4:5c67 with SMTP id u17-20020a2e9b11000000b002cceaf45c67mr1952274lji.99.1703983693359;
        Sat, 30 Dec 2023 16:48:13 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::227? (dzdqv0yyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::227])
        by smtp.gmail.com with ESMTPSA id cy22-20020a2e9a16000000b002cce9e771b2sm1182475ljb.71.2023.12.30.16.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Dec 2023 16:48:12 -0800 (PST)
Message-ID: <cb1129ca-6ee9-46cf-8ea7-77707f9d4edc@linaro.org>
Date: Sun, 31 Dec 2023 02:48:12 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] iommu/msm-iommu: don't limit the driver too much
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux.dev, Russell King <linux@armlinux.org.uk>,
 Joerg Roedel <jroedel@suse.de>
References: <20231216162700.863456-1-dmitry.baryshkov@linaro.org>
 <20231216162700.863456-2-dmitry.baryshkov@linaro.org>
Content-Language: en-GB
In-Reply-To: <20231216162700.863456-2-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/12/2023 18:26, Dmitry Baryshkov wrote:
> In preparation of dropping most of ARCH_QCOM subtypes, stop limiting the
> driver just to those machines. Allow it to be built for any 32-bit
> Qualcomm platform (ARCH_QCOM).
> 
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> Acked-by: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Robin, Joerg, Will, is there any chance this can be picked up into 6.8? 
We will proceed with merging the rest through qocm tree into 6.9.

> ---
>   drivers/iommu/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 9a29d742617e..0d6095290b6a 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -179,7 +179,7 @@ config FSL_PAMU
>   config MSM_IOMMU
>   	bool "MSM IOMMU Support"
>   	depends on ARM
> -	depends on ARCH_MSM8X60 || ARCH_MSM8960 || COMPILE_TEST
> +	depends on ARCH_QCOM || COMPILE_TEST
>   	select IOMMU_API
>   	select IOMMU_IO_PGTABLE_ARMV7S
>   	help

-- 
With best wishes
Dmitry

