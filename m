Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E957A2C
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 08:33:15 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id q16so19110969lfe.10
        for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 01:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680078793;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/mj5Xq6+JfoalzpG1WEfQLWuCEqNy/WskP4LNoja4eI=;
        b=mZu4wAUV9wtAfMe4oDDeNDOHrT8dJJ4XXAMQIKc4TBMCYrBJJnqF+x5EH1iO2TsVfl
         aEvpWhvc+NId0UWzgJvVeZnPy35HPwgKrybTyP8/JMuTKgLnVdMdU6L6FJf+kIKW3Mlr
         sg5w+KDBwE8p+3OWtejmvCjocBLh2P+KpPYxHenen9Hrvn1yNTMC9BSInu5jy3O49Pqz
         V+CaV4YqzWhb5b0avKwGAVVgbm1H4WVWBcTsCVUgNqf0rjfVX0mCfX4UMnDM/lPpB24y
         Q2BgzsrZn7DLQqsTGqrCcsj2/8sXjsIpKCANJH1ihtRrIdEsc2mx1tA8OqGXEysBodkO
         +uFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680078793;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/mj5Xq6+JfoalzpG1WEfQLWuCEqNy/WskP4LNoja4eI=;
        b=5pC3bWFWTwaqL34lKN6H8AoZGins9VoJmCYGUEUgi69np+jkyU/2VXh5ngc9JRJDRp
         WYuTObqKU0tvsw4I5BEsTsGdUnSiYB2s56GzS98XN85DnUXmvwPJoAMAsRqPbIxoqL1R
         uPLTJgHqauBgM5VDbxPUlCGhY+Tgnbxu09w3GOs3kNguzBM8GHRfb4FqGPUbk6lSOIrF
         NP8eCA4M6jXypzceo5Cd4MCJoDq7NpFKMk0ntc/+RCccmaf0ZjyQV3dyqlmDGHW/VENj
         yqzMICZjZ8G8MagWlAx1W9Li0FnjwFmFS3WBHVKsnd5Dw7FMO/OCCbSv0c97+DbKAl1g
         b91w==
X-Gm-Message-State: AAQBX9fCEa0UUcORkYnkmkdwkHUmxgrIA/Kc+UV2EMgaqxuYoyLTKi5e
	RPKBdlBGqqmE3pqbVIUbNvgyLQ==
X-Google-Smtp-Source: AKy350aNzNob6HbJ/RxdWslNWAtB+K0yVD/z7brX3plRakI3Uhf8hEdc3GG+W8V8r8TlCiYY/4Ui8A==
X-Received: by 2002:a19:4f1d:0:b0:4d8:86c1:477e with SMTP id d29-20020a194f1d000000b004d886c1477emr483750lfb.19.1680078793292;
        Wed, 29 Mar 2023 01:33:13 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o1-20020ac24941000000b004ea889258d1sm3974268lfi.72.2023.03.29.01.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 01:33:12 -0700 (PDT)
Message-ID: <4ac63dc9-a420-f9c7-a1c2-1384dbf37fec@linaro.org>
Date: Wed, 29 Mar 2023 10:33:11 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/7] arm64: defconfig: enable the SA8775P GPUCC driver
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>
References: <20230328193632.226095-1-brgl@bgdev.pl>
 <20230328193632.226095-4-brgl@bgdev.pl>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230328193632.226095-4-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/03/2023 21:36, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Enable the GPUCC module for SA8775P platforms in the arm64 defconfig.

...for Qualcomm SA8775P platforms...

(you know, this is defconfig for every ARMv8 SoC)

> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index d206a9120ee4..fa0a145defe2 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1161,6 +1161,7 @@ CONFIG_MSM_MMCC_8998=m
>  CONFIG_MSM_GCC_8998=y
>  CONFIG_QCS_GCC_404=y
>  CONFIG_SA_GCC_8775P=y
> +CONFIG_SA_GPUCC_8775P=y

Are you sure this is correct place? Your Kconfig has it in different
location.

>  CONFIG_SC_DISPCC_8280XP=m
>  CONFIG_SC_GCC_7180=y
>  CONFIG_SC_GCC_7280=y

Best regards,
Krzysztof

