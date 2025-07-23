Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D579E1FAC42
	for <iommu@lists.linux.dev>; Wed, 23 Jul 2025 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284980; cv=none; b=qOk2xujJdNuuyrG+FTvvxOuVeQcX9NRaW8Z5ktaYwCDwhUOuUvNUGyxGpMH+cr6fokG3UiLAtXKHRvy5PNIyzayD9lJwU6CAszw5xn0TocdI/xeaCRmolk6O9x7/hiUCqvYGSYZ2BnQK5u3HAo1wulf6JlGzvbQH6KZipZ8QYCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284980; c=relaxed/simple;
	bh=VA9c0QPMO5+Bov+cQomqLQw1whJoVSRf3QyImu7EoAg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fpcXO5pSo2X+Sp/Rdrmp7hgDyMJ0W/FiDR0eRNblFZZnzy20lfR8o/Hw6JMmD/oVmoQ5bTpGdzKpWJG0vQRdGclvQKN+pa95VaWjCykDoPm7X/KX2XTgm6ISUif0+EqcNglcqyhoUtPmZAjW7olYnvaTLB8SoSy88yKlVYRjdJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ywWiGdZu; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ywWiGdZu"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4563a57f947so5836085e9.1
        for <iommu@lists.linux.dev>; Wed, 23 Jul 2025 08:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753284976; x=1753889776; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yopYTcaLHy/YngxUjGRVUYbmllYbCh12wVB+pNQbzC0=;
        b=ywWiGdZu9n+iiUnMkzB8BxpaG79cgeV5Em7v4+efuuG1+Flp93jefMAWTFkj0hhJvh
         f3X+FJYk+2QmlBkSANZOmPdDkeYrqF+08+J4ThMj9sk41cdJS+6IeK7BSr10CCvY9Czs
         yYhwUlhCU5dpyelnlGMiEdpvvGb61avYOX0HUNs5nb+F0u+qsUF/JTn69R3hfvLY0ETT
         Dx3nLa1Qk09IaQ8RFpUKYl7OS+bBw14titVIlu28TU9Xina8sURwWCdz4cGjUhB2wWx3
         Ppaj2dAGUtPZcYR/5Sitz/x6ojH9MBYqwREhR8ScMS5yvyYIDSWb2411joK6rZkJ6+uH
         SMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753284976; x=1753889776;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yopYTcaLHy/YngxUjGRVUYbmllYbCh12wVB+pNQbzC0=;
        b=MX/BGkzcq1ewYiQXmTRxcXyNvGo+tyhzAD9tnmd4zOVkbshrCmsGaKoWvG6cyuD+Gv
         pWdFYE5kY+WIzzGfghLehP7FQ9uZ2uryZrP5K2uyY7bWD0wCH4oMGdZXKjmGDtR0FibP
         Da7S1GOu4IC7czYkAgFsaXpiVtdSTYd3QxkdSPy8nZQRE/z1fCWzdnrNhj48/YBEFKXv
         Rg5PcE3GeKHZdx5liDmV5nIB7pY0ecY4DeLHxHnWuqinz5+cVRh+uH9adtQxlDupFfRM
         lDeolgRct/d/SaPQE9RQHvqbzw/ZHPj1O0jJyugTHcC8ukw9tv7JKXrJrvjzWtXhQKWZ
         lSbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqbgk6M8pwK7l71K++H2jXd+6JqBYqZqkLJyBAxmsbmNZVHTieGliMJz07Ci+SKLbnaJocHg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwBSNVTMmPBgTJEF70REWUSA83GC5A74Gkl5sAz7+S7M6inrEy1
	gIz80uPF/j2W0mY3mJ/BR4lHFqkwfSm6J8GJIqC5eZduwOuf7hRzehy3h74SIHyeuP8=
X-Gm-Gg: ASbGncv1VgIrzV7a+FORfPOBMIVZADLN+AtUTBW7Gs/FGC8arD1999WyPld/FT1bRLv
	ZIJE/HR9qDKToiRJkJ+HjDTZqlsa85fn1sNs4o0b7jbj7TGq2ZZBePY7XYV7LHYG4foHxPB0GwU
	O+bKp9kld5V2cOMXzs6hNelzEYlE3obXvBJUsaqyOeldH7VllGMYIgh2bMfxYo1SC4JkkVE3A/T
	isEtVa7snNFLrKC5WHNsZNoDSGG0iSQCfdMlF6HLS2plBKzO3ZCemG9T5MvzKQ8sNJCa6UXtdfO
	jUt+C2CZVI0tpDtKGVwO14ApIJNx00ISIua/FSvxvh5WuF0MBVWJxLc7UpufzHZNn/dFrMEOAhh
	TvywhFNnDNGh5o2+cl2x6WEkAKTNhiYNXqI9+Jr3oqR5V/dEdKZxCICjf1N08uaGvnNd75nCJ+Z
	HQy3oShQN5pn2p
X-Google-Smtp-Source: AGHT+IE36FCAwkzfiHLT8YUTKB5dl8mhn5lwwrUiNUjYfXCamvnt7XB94dMS1C8m5vdXXhKPLuuwTA==
X-Received: by 2002:a05:600c:4fc9:b0:456:1157:59ac with SMTP id 5b1f17b1804b1-45868b23d24mr31817135e9.7.1753284975917;
        Wed, 23 Jul 2025 08:36:15 -0700 (PDT)
Received: from ?IPV6:2a01:cb14:150f:cf00:b6af:e6a0:6569:3a1? ([2a01:cb14:150f:cf00:b6af:e6a0:6569:3a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586918094csm26728745e9.2.2025.07.23.08.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 08:36:15 -0700 (PDT)
Message-ID: <268811ba-03c5-4957-b073-1dfbad77747b@linaro.org>
Date: Wed, 23 Jul 2025 17:36:14 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 14/15] arm64: dts: qcom: Add initial Milos dtsi
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>, Will Deacon <will@kernel.org>,
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
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-14-e8f9a789505b@fairphone.com>
 <3e0299ad-766a-4876-912e-438fe2cc856d@oss.qualcomm.com>
Content-Language: en-US, fr
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
Organization: Linaro
In-Reply-To: <3e0299ad-766a-4876-912e-438fe2cc856d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

<snip>
> 
>> +	pmu-a520 {
>> +		compatible = "arm,cortex-a520-pmu";
>> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
>> +	};
>> +
>> +	pmu-a720 {
>> +		compatible = "arm,cortex-a720-pmu";
>> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
>> +	};
> 
> See:
> 
> 9ce52e908bd5 ("arm64: dts: qcom: sm8650: switch to interrupt-cells 4 to add PPI partitions")
> 2c06e0797c32 ("arm64: dts: qcom: sm8650: add PPI interrupt partitions for the ARM PMUs")
> 

Yeah switch to 4 cells now, so you can properly route the PMU PPI interrupt to the right core.

New SoCs DTs should have 4 interrupts-cells from now, I'll migrate sm8550 shortly.

Neil

