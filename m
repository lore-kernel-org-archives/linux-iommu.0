Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9A13D64
	for <iommu@lists.linux.dev>; Mon,  9 Jan 2023 18:04:11 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id bt23so14208140lfb.5
        for <iommu@lists.linux.dev>; Mon, 09 Jan 2023 10:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NaY/2DqaoSidppPHSkUy2BcLqUqFjFP11ep0OZTy/9g=;
        b=Fg//XqJM9WKhPv5WbbeOGHnwk+Rth3gxnPKIESr5UrbVYIpyUKikYqDCZKX0JJ3sWc
         tXAA/ICSy07weUIwdyfiXhf7h+5A402Ds4SvfkvOF6A0+MoURv3XH4ba7MQTvWnGrKEa
         3nbcXDYGDMu2PXuegkdNtRmSUvftWBLEcRq4C8Hwek/yUFLGBKDFqNF16lfsf8kTYnCI
         MrNa0KL0VAk8heoX7uxajUsjsmdzkZ5p/QcHcpAMdSY6e4TyDXQuj6SaO0ZB5D7c8zwp
         6Q+DLO7U8AsRZKpwRnSvx9TzzDVwaVcncIHBLVOakqDT0+/w9jrH5h9qeZg+G2uiIT53
         Rk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NaY/2DqaoSidppPHSkUy2BcLqUqFjFP11ep0OZTy/9g=;
        b=Y/tLyCfv2/p8pQE3E8Q58ENildkfvP1vRnv9gtT1KYoD8OdOGcL2J76w8Ah6vJpeJc
         s2Ndlo/9sOAtZG3yV3XeMmbSWsG3TcSP+KxoB4IXPiGXiWpPpZCqpse9mWRYnmcn2V+d
         ZA3SgBaRLpqRfatHnF6Nm13JUPDytmTZoF252NIBEoh/Dc3XA7Nyku1fpyyyOKwkNQxq
         UzfgSJSWfmSh4iNCKNjjoUvKlOew6uQfKRWH3sJnmRuG+Gna8VH6CpMKrIB8EzVPqeS+
         jKhjga4M/zYPRoO8EHagGaNlEZSV9QBhLdLXOwAywLLULtiBJpkbt9oYf5HQugLfA0Fb
         ORvA==
X-Gm-Message-State: AFqh2ko5LcxkGDbJlrwcTEGaQqWGrXOzXczvK9icqAPkrGsTHkUgrQWX
	R9SLVTYEFiV+W3qK89W/52JoEg==
X-Google-Smtp-Source: AMrXdXsZTo7DsBtHT1Kmx9G45xUp19RzsFbkBS642qI0FX5WuYrR8ikmr2qzmwx3vmMgXWDt/ssYUA==
X-Received: by 2002:a05:6512:3d10:b0:4cc:7b66:6d64 with SMTP id d16-20020a0565123d1000b004cc7b666d64mr2410770lfv.39.1673287449389;
        Mon, 09 Jan 2023 10:04:09 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id u6-20020a05651220c600b004cc865fdfdfsm325270lfr.89.2023.01.09.10.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 10:04:08 -0800 (PST)
Message-ID: <f62fb561-5ddd-203e-1204-f1bbafcc7ea8@linaro.org>
Date: Mon, 9 Jan 2023 19:04:05 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 08/18] arm64: defconfig: enable the interconnect driver
 for Qualcomm SA8775P
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Georgi Djakov <djakov@kernel.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230109174511.1740856-1-brgl@bgdev.pl>
 <20230109174511.1740856-9-brgl@bgdev.pl>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230109174511.1740856-9-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9.01.2023 18:45, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Enable the Qualcomm SA8775P interconnect driver for arm64 builds. It's
> required to be built-in for QUPv3 to work early which in turn is needed
> for the console.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 1cb586125c46..d5c938adbd2d 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1332,6 +1332,7 @@ CONFIG_INTERCONNECT_QCOM_MSM8916=m
>  CONFIG_INTERCONNECT_QCOM_MSM8996=m
>  CONFIG_INTERCONNECT_QCOM_OSM_L3=m
>  CONFIG_INTERCONNECT_QCOM_QCS404=m
> +CONFIG_INTERCONNECT_QCOM_SA8775P=y
>  CONFIG_INTERCONNECT_QCOM_SC7180=y
>  CONFIG_INTERCONNECT_QCOM_SC7280=y
>  CONFIG_INTERCONNECT_QCOM_SC8180X=y
