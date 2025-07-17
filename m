Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E20528030E
	for <iommu@lists.linux.dev>; Thu, 17 Jul 2025 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752741933; cv=none; b=QNojf9qygnzSamOIYSaSQN++heCQfJFY/uj48dwGGfF1W5Kfx0Je9xib/m03pUyFFJQUMdm4SycjEzZLI/J4PNnj/Qdh/WPCKyapNP6P2AHxVU6w8V2IeF8LZY7sscTarW5mRCd94P89AvjksJt3vmuL+1IJfg/XuBN7v1wKDfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752741933; c=relaxed/simple;
	bh=KeBoICQi5vCriX+lE0bMVyU8SmgjFFfJAbuXSXLwOvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DzPujdRussuNIEc7M/2lzITQTvotGQ6CsvxFnYjJaRWvL5H+bOd+7cx0U/eXUKde1WhT4THOqR/QjG2ag9w3RvSkGyBY3foqOp05En2dJXJTtXFbPIOyB8QXggnHe9qRv10s7Ekss9lXfwJPM6kMVkrhEv/KU4m0gc8ptVfuei4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PAUSURpz; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PAUSURpz"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso310614f8f.0
        for <iommu@lists.linux.dev>; Thu, 17 Jul 2025 01:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752741930; x=1753346730; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lI0pEfmVhQWkOv8EPGMn/xg7zISwfZGg3TSb4XZEXe4=;
        b=PAUSURpz/qfy4TP645Q51u6d7IdbhN/+2+5iLzAfuVNgMEAmciMCkVxQbQdOJx1LAj
         MXXS3SqxiZ/4W8m+7d/ccZLARespfJNScF6DDDc32xqw6OkmEWXvhtLqYtkH1My8M+gv
         ocwI/vwkHSCkX2jDDw52DKgf2YbxpZkYIMgqyQawld9GyS/T5Aksrp4x1UCIODjC1ouG
         XQ03juSRZs53CqNpFHLUtjWsCTROPZs53ITMG/4FlY6oYcxjeapT5EYLGE0YiAT1dut+
         Fd7uenycNtG1vNXAPmcpbdWhnCeF+qSmJZlYJBsK2nAyhC0T+0aau9NUs2FxKxT4oNXD
         ljdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752741930; x=1753346730;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lI0pEfmVhQWkOv8EPGMn/xg7zISwfZGg3TSb4XZEXe4=;
        b=O7zFoa5NzwQGQHDArveyrucmE94lvpsoPAAS/DAAJbBH+xl904RtL6fa5jT8G2Xe70
         tQznPrACaZ7HZSZbS1wW2QrtKfqLxuUx3S/Occ1Zcsg8lLLWOk7XJrWpLeyOILmXQjvy
         inD0pBcechYlhLqZtwhfJTCZlI75625VfUyY/rOTWPSKmCwWA/MjUQKwgqrpPBtJzU6S
         7dW2zSoX8OiPGR/uW1j4N/euXxVqr+xrBIZysU/9FeoSHk7Bs7V/lpO51udpZ1yZzwQe
         7zHdlSt03jBhrujhfAF2//9boA1FmEmBPWIgICqCMdxvQaO3QxDGvjDgUlulcmoYLyo+
         Yhgg==
X-Forwarded-Encrypted: i=1; AJvYcCVl91BDip7+yiZbvQ2fUrSoqoEtAgZvmtyFaEu36prUIlmJEmqcNscxNo1vwQ1RYuqZaE9x8g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCR5jkmLp8LJ8yzl8ot8ngRV9DDGLrsE2JXavj3YynWba20+bW
	zLgjQPtN8pP09WHYFv3KaVQTspfBSNkUvSnmCvTBBCJ7rsEsJ1mtfTMi1Ba4T6jjMow=
X-Gm-Gg: ASbGnctdTRWpMYPs66lvo84iMTKD6bKNQEeDZy9PDD9h6qgunSDUF1ZJJzARvYxp/gd
	s7kYgPtK0zXANkGcl2eJcWdiGxnRpLG/s59eUw45fW4AW551y5UZC2SkZ2OvrlDEBlWH5xbdH09
	UX3hwq5JoF2sasyjSx5kDyGMhg6SvlYaoCn0qCJ8YE3LXcF8+IvVsQaZ/cKVBIsQrXrVs3lMs8V
	zybECdPDHkpku8odz9WPkjJYNiTdO7wHkZ9FbwnmIelqwKaqAuNCNXLdS1D4ieFIz2rjkVqBFp1
	zmyTacIDH7L+CICEEj1UB5Q5U+DpPbApCmISTeokiJ0wJ/hPhFpRO6n6kFoYrp23zphI181/5+K
	ZhxTivVH4Kg1uhkRLyIMLHv85LGlbAl5IU2rfA4KrQcYUUzXlbL2GuEaIfuTLHu/5+tuA4E+8q5
	NQ
X-Google-Smtp-Source: AGHT+IHynfEiO6GXy/zERfnUna5/ILOl/Jpu2n8FLydUo9tQGpFN5rGKrkj6TlP/t2+2sNcZBF+q3Q==
X-Received: by 2002:a05:6000:250d:b0:3a5:58a5:6a83 with SMTP id ffacd0b85a97d-3b613e66eaemr1561801f8f.13.1752741929767;
        Thu, 17 Jul 2025 01:45:29 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:37e:ce58:94c8:a752:de4:96bb? ([2a0d:e487:37e:ce58:94c8:a752:de4:96bb])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45634f5cad3sm15783305e9.9.2025.07.17.01.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 01:45:29 -0700 (PDT)
Message-ID: <d1e84ad9-eeea-4d0b-9f29-1dd4be49225c@linaro.org>
Date: Thu, 17 Jul 2025 10:45:24 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/15] dt-bindings: thermal: qcom-tsens: document the
 Milos Temperature Sensor
To: Luca Weiss <luca.weiss@fairphone.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>,
 Das Srinagesh <quic_gurus@quicinc.com>, Thomas Gleixner
 <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-8-e8f9a789505b@fairphone.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250713-sm7635-fp6-initial-v2-8-e8f9a789505b@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/13/25 10:05, Luca Weiss wrote:
> Document the Temperature Sensor (TSENS) on the Milos SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index 0e653bbe9884953b58c4d8569b8d096db47fd54f..94311ebd7652d42eb6f3ae0dba792872c90b623f 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -49,6 +49,7 @@ properties:
>         - description: v2 of TSENS
>           items:
>             - enum:
> +              - qcom,milos-tsens
>                 - qcom,msm8953-tsens
>                 - qcom,msm8996-tsens
>                 - qcom,msm8998-tsens
> 

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
