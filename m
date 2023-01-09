Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A943D64
	for <iommu@lists.linux.dev>; Mon,  9 Jan 2023 18:08:15 +0000 (UTC)
Received: by mail-lf1-f44.google.com with SMTP id f34so14227699lfv.10
        for <iommu@lists.linux.dev>; Mon, 09 Jan 2023 10:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e1JMPoTV80PEJefONcOYlms/hHbc5vj9vRLyRa7UBTM=;
        b=wL3QGkdKztFOkWWeW09aqswuc2d3KrnalWesJnYDWz07wftez/OhOySylYmGPkbnXh
         v+gY20wHq44rAdZct4rxh439oyw4yJuAueOvueAk6bY8iun/fOAbt/MARe9G5NPzfGgL
         4OlPvd42d8ctkrUqp+QKrMsvRjiZ/SXnheyYzuhxaOhR5CBGqr5151o/HleYba9Exf1c
         gi5uGiRwkOtiXoPM3b0QU4nlerMA8Qt8xcmGMhgwfwdz48FUhujTs86X/ugCe5paRsq0
         j4yH6A6tf0gMlR7Y36vGYWcG70SOQH17nCHhSuvkuwO+pC+FLHKEzMXyM6Vesg7mLQIv
         dUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e1JMPoTV80PEJefONcOYlms/hHbc5vj9vRLyRa7UBTM=;
        b=Qxjr527pj4KZkc1SVf89Z3K6cL6JMstjh9J7+CaOfJOFF2wl36e9mceBsd89y1f6V+
         OCiWx9CQYjQhtZsri0SBkp652OThf5tK39BaHXbywCfTkl5i3y3d4bafsvb6YrxcqIfF
         65pQdDZseOtd2Xh4G/tdfZyvnvDMU1AMxDtv2cXB+1jTuIsOBmN3qdXBxm8XGbegyDZw
         549uGcjwGSeVUK3csTlv50d6O/pqkUrY7bame8sTNiOcDpbv/u0/GNWsoJSO8OINJhTM
         ZEvz99VRBHbjzAR2qrLijDLLAyjsizp8woFIKtSy+L+B31Z4tyzG85gg1MixqLPjjere
         dtNw==
X-Gm-Message-State: AFqh2krHo4J/yW4AOkMFBNr/qUehCptBoc9bY+82QulgBaHfoIrBb9g7
	G8D5j8FoMIfPSk0U+TGFpcAkOQ==
X-Google-Smtp-Source: AMrXdXuHQ4Z4c3jNaPXxZMQVMkuAuL7LiQ/JV1NHaQswZ17QQXQ1WWKUQftP4wAWRoYpEIJgYWZPRA==
X-Received: by 2002:a05:6512:2591:b0:4b5:7dd6:4df0 with SMTP id bf17-20020a056512259100b004b57dd64df0mr18516952lfb.32.1673287693455;
        Mon, 09 Jan 2023 10:08:13 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id g2-20020a056512118200b004a27d2ea029sm1731866lfr.172.2023.01.09.10.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 10:08:12 -0800 (PST)
Message-ID: <7b1d8756-efd2-5dc5-a411-0b13b2de555a@linaro.org>
Date: Mon, 9 Jan 2023 19:08:09 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 11/18] arm64: defconfig: enable the pinctrl driver for
 Qualcomm SA8775P platforms
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
 <20230109174511.1740856-12-brgl@bgdev.pl>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230109174511.1740856-12-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9.01.2023 18:45, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Enable the Qualcomm SA8775P TLMM pinctrl and GPIO driver. It needs to be
> built-in for UART to provide a console.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index d5c938adbd2d..6c752b9a4565 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -555,6 +555,7 @@ CONFIG_PINCTRL_QCM2290=y
>  CONFIG_PINCTRL_QCS404=y
>  CONFIG_PINCTRL_QDF2XXX=y
>  CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
> +CONFIG_PINCTRL_SA8775P=y
>  CONFIG_PINCTRL_SC7180=y
>  CONFIG_PINCTRL_SC7280=y
>  CONFIG_PINCTRL_SC8180X=y
