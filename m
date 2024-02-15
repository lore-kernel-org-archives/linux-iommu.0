Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7221756B
	for <iommu@lists.linux.dev>; Thu, 15 Feb 2024 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989402; cv=none; b=k6/D28uiZHVp9U86rZ1y6eBuyS/29o65DDTEDiJ+m7hzZjqcDLJZZ/uBHDd+9GqVovfsuNqCMtAvLbgCXB+g3vWeFq6dEeNdrQBkZTlOPwdDT1qylRAqznPmBlFyUsQ+mhpaHU42P33+UlSJQw2i6uB/vjPMCNqitT3W/GJpSLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989402; c=relaxed/simple;
	bh=sD1bsJwMjAFQ13ViHkkmSIV96Jgd7fYEtMS8umuilg0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dSTX27FWt/4EEW+6xSgSCQ09boLh0iTO/AinauAKYcstv6zlD1ufKmOKgwNJ30FPYgEzcC9/ZxWv3FhtbhRRccDejJQ0wP6mqUxjp1wgbtUcL/2p8TJwQ7bQWUYEIXFoLQPTl+veEfjtgTcfxgS+/u/7Fxfv6lMd7ltcXYYbZOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nJhFp9wW; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nJhFp9wW"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d0f7585d89so7351631fa.3
        for <iommu@lists.linux.dev>; Thu, 15 Feb 2024 01:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707989399; x=1708594199; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VmOpXYe614s1w+uX5FaR6Zt6hCQGhtbYPhMdt0CcCLo=;
        b=nJhFp9wWu7+mAWqq0bV+1HiPYsT8+Cs42XW02LFZpYMkUTh6jtysD2SxJBMwN/bdlO
         bUjamX/IHGqhlEo68lnc7lgUjFGa3DzgzAcFZ/zKTUCeAPz9ka8r/wt9Kd8dNZfIj61E
         Z5MbhNpR4Hiljv2RiJroT7PP1ubMvbSd2cq/PvfxBJYQk2ksTwiy+ET5rbZUYhXzT+hW
         Lcajwg3/5Q0QLS7qLW0P4p6Pkw/x4E2qDn3D+cw2hTTEBGPrRkgAALUj5n4ag5a4Bqvf
         JpC5JDLr/Vv6YylYi7k+a+bXrcsZkYbdq+QUmAC1+xAtbuEzz8sjhTyo6cY5iWp656Ey
         A5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707989399; x=1708594199;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VmOpXYe614s1w+uX5FaR6Zt6hCQGhtbYPhMdt0CcCLo=;
        b=kt1v7jXwoGg1L8op6slCSA5fDvsfLhzfuGux/mZYpKnL92DcdzYv2/I2n0SF5K50eE
         /cACNQxaAZGOcZgt3M+mn0feHXrnsWiIIE11PLQH96i7qhpiFafWoHPhYN3a+ZLE97Z6
         q1lt1iMyJ6SH4rRZC0tQ6U9Bt7FOObBcNMvYHOT/IBMKVJ8b09UImfk3Sp6DV/jGd2+x
         J6YJN30Ot7jDq1LUnATe7gMSKpqxNJ1DZXVk3jV1rBfmFnJu0t8TBdqFgt7XmO7QvJor
         LSiCWsB7OaA7bjR97uIgFvRoyK2J4YZHvbHS71bHtuJZCLqwiSqNqqOr7U2x9GborSIO
         Q64A==
X-Forwarded-Encrypted: i=1; AJvYcCXmg+psxQPtuGLW7iujMV20MW1GGvkpWEk0h1EmE4Z/VSWpRbHyNAI0Rk2LBVxhiO5Fr6QpI9Z6jngRFPDljku2ZUaveJc=
X-Gm-Message-State: AOJu0YxLyMH7336nDzXL4tsDsQWv/ZZOcE1qBC4UYZ27zb6vrcgjARt+
	lHHCN8qQQBgvfeTa3hCmOHoU/XV1uxGQdaQ+pjivxsIzwdY2ikmmF9YumdSjrl4=
X-Google-Smtp-Source: AGHT+IEuFGqFxGBfmmBUmEzoDATve7jHeXbEQRCoqEiqnF8PVK28X2sVOXLp6dDGXz+4L0UUY8TwFA==
X-Received: by 2002:a19:ca01:0:b0:511:79ac:ec0f with SMTP id a1-20020a19ca01000000b0051179acec0fmr963353lfg.26.1707989398807;
        Thu, 15 Feb 2024 01:29:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:4589:7160:c264:fa3b? ([2a01:e0a:982:cbb0:4589:7160:c264:fa3b])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c468c00b004120b4c57c9sm1398694wmo.4.2024.02.15.01.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 01:29:58 -0800 (PST)
Message-ID: <ffb16ef6-fc9a-42b1-b9c3-4e8f6b52d849@linaro.org>
Date: Thu, 15 Feb 2024 10:29:56 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/6] dt-bindings: arm-smmu: Document SM8650 GPU SMMU
Content-Language: en-US, fr
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar
 <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <20240215-topic-sm8650-gpu-v2-0-6be0b4bf2e09@linaro.org>
 <20240215-topic-sm8650-gpu-v2-2-6be0b4bf2e09@linaro.org>
 <CAA8EJprpYEhGi5b+uWGWtOa+qbSwUR8C0j9NLC+ah_-nvy-=Ng@mail.gmail.com>
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
In-Reply-To: <CAA8EJprpYEhGi5b+uWGWtOa+qbSwUR8C0j9NLC+ah_-nvy-=Ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/02/2024 10:25, Dmitry Baryshkov wrote:
> On Thu, 15 Feb 2024 at 11:20, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> Document the GPU SMMU found on the SM8650 platform.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> index a4042ae24770..3ad5c850f3bf 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> @@ -93,6 +93,7 @@ properties:
>>                 - qcom,sm8350-smmu-500
>>                 - qcom,sm8450-smmu-500
>>                 - qcom,sm8550-smmu-500
>> +              - qcom,sm8650-smmu-500
>>             - const: qcom,adreno-smmu
>>             - const: qcom,smmu-500
>>             - const: arm,mmu-500
>> @@ -508,7 +509,10 @@ allOf:
>>     - if:
>>         properties:
>>           compatible:
>> -          const: qcom,sm8550-smmu-500
>> +          contains:
>> +            enum:
>> +              - qcom,sm8550-smmu-500
>> +              - qcom,sm8650-smmu-500
> 
> Doesn't this cause warnings for non-GPU SMMU on this platform?

No because it doesn't add those to required, it simply allows clock the properties.

> 
>>       then:
>>         properties:
>>           clock-names:
>> @@ -544,7 +548,6 @@ allOf:
>>                 - qcom,sdx65-smmu-500
>>                 - qcom,sm6350-smmu-500
>>                 - qcom,sm6375-smmu-500
>> -              - qcom,sm8650-smmu-500
>>                 - qcom,x1e80100-smmu-500
>>       then:
>>         properties:
>>
>> --
>> 2.34.1
>>
> 
> 

