Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9686AB7
	for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 07:21:21 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-31c8321c48fso1889209f8f.1
        for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 00:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694762480; x=1695367280; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B3QV/Vyen7SEvE+//J651UR0v2eTH0jtZ18uF80YocM=;
        b=Ke9ikyoT3iY7v3MltLHZQUBjREnnPePlFdSDzEGAgXY9Msn4FkZp8DjnUzHYd2xDUj
         jzPQ2E7iei1zE9K6wahrI6tpfyChXMFwZM1xMcpbOT12MDKrwyRAofvG7GtnZSQ+T6vh
         NMpbQFbw5v4xGWVgUJ6DffAMTzVc4VyzZ2KVeXyxb1G4GaxjTvcJjYYvJdBdU8bLFZbE
         dVA2KQ24cMkZhS8dgBgoT4Ysk7DP4Fy+NtVh6XWyTYcArOAr2251gdb8HhhD+h7TbbRr
         tKwHbC4O2vdY6pkgJ41J57NqNwwGOzosuhtPDVNRPyhl2ZuPH0iHQrFf82ea7TVC8Exc
         XtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694762480; x=1695367280;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B3QV/Vyen7SEvE+//J651UR0v2eTH0jtZ18uF80YocM=;
        b=NJWJ93tZsuyqs93yoDamRx7NPAiQTRIQlo9MiwXsqf2ItJzRpkqNQwge+MHg/XXWaf
         mimahfk4pzvzY7oUb9a8QuKpZ+1ns97KaWUQ/00uqgSypB4V+stQZJGlKeOhEZdhMQWL
         usn5usbLJFIOHHGGCN675qKqkDKejsci8TJ2bQdMwKSz+4fBXnP3lxxEhZ2OngCMszhw
         MagnVUCHGmoR4XJJI2Kwwcj93A/4rXUwTzwH0SS8juRHWutNPPWgB7ChTcszHONv8u7m
         UQnZsiOk3ie6QmqaCiutGB8DKrBuT2LldRQI+U13K+cay79MqNPUDS5nyuV6SCvw93D8
         Ax+A==
X-Gm-Message-State: AOJu0Yzs3SdBmJx3eeaAZF/95s5iZzs3m6J0b3JooQLt06l2Ls6LKAkG
	4LLrdLmHWB0zuOYx5DQs1A/vJQ==
X-Google-Smtp-Source: AGHT+IGwsfAoWHYZgMObPQe5FAVomWG3Jgt+kImTmSbJN5ZZlvJUpMzf6w/uRD/CjOgHJcf56mYb4Q==
X-Received: by 2002:a5d:5591:0:b0:314:1096:6437 with SMTP id i17-20020a5d5591000000b0031410966437mr602765wrv.19.1694762480099;
        Fri, 15 Sep 2023 00:21:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id k8-20020a5d4288000000b0031431fb40fasm3671314wrq.89.2023.09.15.00.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 00:21:19 -0700 (PDT)
Message-ID: <8f2c9664-a2c8-50dc-8a1c-e50a071ebeb2@linaro.org>
Date: Fri, 15 Sep 2023 09:21:16 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 8/8] arm64: defconfig: enable interconnect and pinctrl
 for SM4450
Content-Language: en-US
To: Tengfei Fan <quic_tengfan@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, catalin.marinas@arm.com
Cc: geert+renesas@glider.be, arnd@arndb.de, neil.armstrong@linaro.org,
 nfraprado@collabora.com, rafal@milecki.pl, peng.fan@nxp.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, quic_tsoni@quicinc.com,
 quic_shashim@quicinc.com, quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
 quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com, kernel@quicinc.com
References: <20230915021509.25773-1-quic_tengfan@quicinc.com>
 <20230915021509.25773-10-quic_tengfan@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915021509.25773-10-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/09/2023 04:15, Tengfei Fan wrote:
> Add the SM4450 interconnect and pinctrl drivers as built-in for
> support the Qualcomm SM4450 platform to boot to uart shell.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index ec59174b14db..e91993de865e 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -598,6 +598,7 @@ CONFIG_PINCTRL_SC8280XP=y
>  CONFIG_PINCTRL_SDM660=y
>  CONFIG_PINCTRL_SDM670=y
>  CONFIG_PINCTRL_SDM845=y
> +CONFIG_PINCTRL_SM4450=y
>  CONFIG_PINCTRL_SM6115=y
>  CONFIG_PINCTRL_SM6125=y
>  CONFIG_PINCTRL_SM6350=y
> @@ -1500,6 +1501,7 @@ CONFIG_INTERCONNECT_QCOM_SC7280=y
>  CONFIG_INTERCONNECT_QCOM_SC8180X=y
>  CONFIG_INTERCONNECT_QCOM_SC8280XP=y
>  CONFIG_INTERCONNECT_QCOM_SDM845=y
> +CONFIG_INTERCONNECT_QCOM_SM4450=y

Why it cannot be =m?

Best regards,
Krzysztof

