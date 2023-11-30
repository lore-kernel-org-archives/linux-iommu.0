Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09953984D
	for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 09:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dUuZwFnj"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2c9bd3ec4f6so9145231fa.2
        for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 01:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701338031; x=1701942831; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c1E5/Z/+vvmVPYmXoHySxDBsGGOXtnkM6Blx9MbustI=;
        b=dUuZwFnj520ru7PqiN6A8ALkOycWMz7NbQrSDqwCXTPN3oZEztU+bSHchLj0DnKQeu
         ptKPrNSoh0bhSQyOXaHfDywMpSifnAUa1ZHlfvEAa1al1aCY75B2qokh9IYLYpGw9O8M
         uVfIQPWaeBmj3NqhmYwQd9pOJuTNtloqVAPPAnCiUAqS3a4nbIFVr4vzXUfKsf71TdYp
         KNDeEdOm81b5mTuMSWQLKqVZLf9z8/Ki0SN6BsDRbEYdQpOreKjC9jBlRKCe4vM4uJbw
         3ei9PaiuknQ9sHWxkvt3rNwjpmCC6YYFjzTCXyzGy6Erzqj9yAuS9tiBsgqNBTuuG4fy
         DpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701338031; x=1701942831;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c1E5/Z/+vvmVPYmXoHySxDBsGGOXtnkM6Blx9MbustI=;
        b=ZnguMQ3RpfLybLCaDaY2JZ5D7JDsghKg6/s0rxxoVDYY2n7KaHBCWxCYdI6ev12qh4
         H6082cAuycP/op/IVl5XFdkymHJLjLAOW4I4PCzvLGijiyRuFul8iM3GqTnP2m+F2X0R
         zVk+WOvYnD4DA/xlulqLs7xruNewpmwu6Qf7J3ToQEhurvn72zd4ryFWAn7wjmTdWUqX
         AQQ30IETK3Cc4k875Ij/ZjV3y9+2vz1utsX2lrnjNfc5R7lUC4hnSAV3ZyzzE9L2EiQI
         yip41uezr5c2moxhV95ROAm5jIKuTG+x35qgS9iiH05CNYT2hsJx+g2PFjua3LoIcqhQ
         xe8g==
X-Gm-Message-State: AOJu0YwISe6hXLBaddsBJ8Hs7kcsaL8rqnjIVsLHbWaayQqWTsEl8KHG
	p9SiptQAijW2MiBswEVCeaqGNw==
X-Google-Smtp-Source: AGHT+IH+lFVvaBYKHmVV+aX0k3VepvzuZh+20oxY9X56mIr3K/UQPC74+u9c62xmmvrU3PdqJYPMqQ==
X-Received: by 2002:a2e:3c0a:0:b0:2c9:b8fe:aece with SMTP id j10-20020a2e3c0a000000b002c9b8feaecemr5027085lja.51.1701338030780;
        Thu, 30 Nov 2023 01:53:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:41c9:3acd:a6e2:5242? ([2a01:e0a:982:cbb0:41c9:3acd:a6e2:5242])
        by smtp.gmail.com with ESMTPSA id p36-20020a05600c1da400b0040b478da760sm1358964wms.48.2023.11.30.01.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 01:53:50 -0800 (PST)
Message-ID: <446792f4-4990-461c-9cc4-58943ca63af5@linaro.org>
Date: Thu, 30 Nov 2023 10:53:49 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 4/6] arm64: dts: qcom: sm8550-qrd: Enable the A740 GPU
Content-Language: en-US, fr
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20231127-topic-a7xx_dt-v1-0-a228b8122ebf@linaro.org>
 <20231127-topic-a7xx_dt-v1-4-a228b8122ebf@linaro.org>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <20231127-topic-a7xx_dt-v1-4-a228b8122ebf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/11/2023 17:20, Konrad Dybcio wrote:
> Enable the GPU and provide a path for the ZAP blob.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> index eef811def39b..9fe51d308675 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> @@ -596,6 +596,14 @@ &gcc {
>   		 <&usb_dp_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
>   };
>   
> +&gpu {
> +	status = "okay";
> +
> +	zap-shader {
> +		firmware-name = "qcom/sm8550/a740_zap.mbn";
> +	};
> +};
> +
>   &lpass_tlmm {
>   	spkr_1_sd_n_active: spkr-1-sd-n-active-state {
>   		pins = "gpio17";
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
