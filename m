Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059EF1401B
	for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 07:19:19 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-529fb04a234so8540895a12.3
        for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 00:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694589558; x=1695194358; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A3hr2Dkoscy8OKR4lP2RVrqnAFjnoPD9KTW+WVQxYRY=;
        b=SGbP4l4kE/WgzXmif9jRw8RfqsORZ4KJL5w0PwjqBUnLT88je4q1xQbU3/7tpVukgA
         SBZ4XRwyPTFNGzxzyIWhfWC5moTDIFAPMe/QSfj7AuxMuh/alfp8hriBDKhTQ3UkW94j
         h21vVL3zGtg9+QglLmywrq28y74FaqGlwXlnBUOd/f3qTabeOJW6J3lav/z8O2oGy/jK
         jrDlXhH/lIhz9EcCjB+FlZXA1I0cqpojC5jj7H7H8zd2TxlM/E1sipQ5VhfaKwii9bPg
         3DwoVQ4nW1rtmKh5EtPuO7ye6VWyu/R526Dj+xu9355G7HrarU0PTOzHxVtio5jtq5jt
         LLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694589558; x=1695194358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A3hr2Dkoscy8OKR4lP2RVrqnAFjnoPD9KTW+WVQxYRY=;
        b=XtTCyu2d/wm61llOiQHtZcnBOl//XOZ2/GOWClq9xIHQtbXaSK5+QLlHYMlsAswZL1
         wo2ZUv51erT1+Zqi70MVAHuXT5r+2qkkiEzlDbIka4ZwvIzbmrFgVzu+YvJ1Vaf1D/Cl
         bayDTvxzG3oQjAszmQLhxA1HD+WxXPN10Y2FdWm5Pxri+79giZvfKWlosbKZvSRKc2CU
         qc2nZMvIWcSDL0OXzc4cYPkbSBv3uklOjH8Eo1aNS5N6k6sgaFu/5k2H4dQz1CPkJqm2
         zEyY5XDsKvpmHQUC/MU7w75T7kSRwnQjc0L2iqbIAEMx9VpEcLBRuHAPrcTbSP4OOBRr
         I2Wg==
X-Gm-Message-State: AOJu0Yzs03kDYtNY70QF93oWbYGCm58ES59nYcMRDurGuJXo75mmO7Pk
	wJTAZo83r3j0Gp96M/E/UbF5QA==
X-Google-Smtp-Source: AGHT+IE6YcmXnG2kZ7MVJ5DQQSPqKNTw5IPlBCUXbJfyxM9ZFvK7mh0xGHZANganLb81Af/8FOzTiQ==
X-Received: by 2002:a05:6402:48f:b0:528:90d7:a19 with SMTP id k15-20020a056402048f00b0052890d70a19mr1734134edv.11.1694589558276;
        Wed, 13 Sep 2023 00:19:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id b7-20020aa7c6c7000000b0052328d4268asm6841519eds.81.2023.09.13.00.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 00:19:17 -0700 (PDT)
Message-ID: <43cd38f5-20ce-a97d-0906-55faf228b377@linaro.org>
Date: Wed, 13 Sep 2023 09:19:15 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 14/14] arm64: dts: qcom: sdm630: Fix USB2 clock-names
 order
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Sibi Sankar <quic_sibis@quicinc.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Wesley Cheng <quic_wcheng@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>,
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-usb@vger.kernel.org
References: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
 <20230721-topic-rpm_clk_cleanup-v2-14-1e506593b1bd@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230721-topic-rpm_clk_cleanup-v2-14-1e506593b1bd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/09/2023 15:31, Konrad Dybcio wrote:
> The last 2 clock-names entries for the USB2 controller were swapped,
> resulting in schema warnings:
> 
> ['cfg_noc', 'core', 'mock_utmi', 'sleep'] is too short
>         'iface' was expected
>         'sleep' was expected
>         'mock_utmi' was expected
> 
> Fix it and take the liberty to make the clock-names entries more
> readable.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm630.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index f11d2a07508c..316c8fd224e0 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -1394,8 +1394,10 @@ usb2: usb@c2f8800 {
>  				 <&gcc GCC_USB20_MASTER_CLK>,
>  				 <&gcc GCC_USB20_MOCK_UTMI_CLK>,
>  				 <&gcc GCC_USB20_SLEEP_CLK>;
> -			clock-names = "cfg_noc", "core",
> -				      "mock_utmi", "sleep";
> +			clock-names = "cfg_noc",
> +				      "core",
> +				      "sleep",
> +				      "mock_utmi";

Plus this is just incorrect... :(

Best regards,
Krzysztof

