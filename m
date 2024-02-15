Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB6C130AEE
	for <iommu@lists.linux.dev>; Thu, 15 Feb 2024 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003992; cv=none; b=mGN70lY4zMNqfVKxuSQK0qlBc2IB2+lUmmU3dAP2Jir0e2zI1e5CQu+6dbHehMAoFrhz1683PJRRpHA+rRYCSQzCPJBAsQPDk9TfgnwFZWJ0MZMI+NeuOKiW+1OKl16soAcztURJV2Iuj0GOS95wVvh3B8iBCvygV+mNJGm2iGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003992; c=relaxed/simple;
	bh=iu7IiIWT/WJciCFSKsL5CnkliaSf2y0e5gCmKjL/tD8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=E05bqaMvENozrp4yBbsPHhe0kHUIhQzn6CrCipdt1BPGSTGnYf3LYaBf6/l71qznpjPHRQLVlyk3a2k0wUOYFdrkMgegm8h3qWNsKdtiOw3p871D/R/zA9OohP35pBWeutx7MtofwP+s9ubdzaGFtpqKe5I8dCD/S5aRFDTsA20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oYl6E/B2; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oYl6E/B2"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3d54555692so87065266b.1
        for <iommu@lists.linux.dev>; Thu, 15 Feb 2024 05:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708003989; x=1708608789; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8FccHgP1nlIIDxh3beS9dJmKPci7aq2sL05JU739TA=;
        b=oYl6E/B2/B1xZhFj4wfOmX5tLNnxcQQLu3wD/xoOzpRuIfUph/AcUOtYZmnmcSh7U3
         YptlZhlLHXvn6RE4bnLurktAyS8slHvwon+cMaIGy+IB3th+iiIAJjHhHlD3bZJqhuaV
         igKJmIoRgcOHqzTDkgr8Pbx1gAxvgU+JaibuGRngUduFOd+JVrFI+djnR79/HmUjzm5s
         iwOZxbXvKNGJjK/NciTSv7twVdEEuOwXA7EgZE/XAZ92nfN8leB4HtCdGWJGj5qQuOCQ
         XgNkl5vhoI9fDTqeJmdwHOUXzi1BUdTvpwHsZl/oNxzX8FKZpHVa2sQvJrjTPs/bd1p3
         Mi8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708003989; x=1708608789;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z8FccHgP1nlIIDxh3beS9dJmKPci7aq2sL05JU739TA=;
        b=w1l9tulOdCjMwpMc5US8eRa+TNyo6q4kYtDx4HUdZNRrZUt5JNqPyxjcJ+fPbWJmqF
         Mw5h7wr2k9FUVz1M0UJh0kowxO36TSR6/XJNSY63aFANMN4lyWvAvR98+K4UYstawfmB
         43Qc2lI3XBRsaNOZMbeObBPjiilSAU7LHXSEK9qFkwFLhZeke4sjvoEpv2y8y8o1iMSi
         PIfRWYO6GK4LIQZPbNPwHtB+WfE0WP+7allfbXt3o4eXTg+slvlHxX2TlYp8bmTZfK3a
         +Y2bNd4E5qPEaFqd4dGhP0zTtlTI1Est79sxQYmYnFqdNQZXNYUrxscvyiP1vGw8c3vK
         Q6fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoru0QkTPMKQZQgglWwFfnTfcAV1PXKTw7bBdl91fk7qb4wIToCzgAXTCMFtaEJBpsvgzeoWyFfbVW5BfRMWNlhJ5l8vA=
X-Gm-Message-State: AOJu0YyeQygdduDoBW/XXcFc6QCd9HbZSuCokahmcTh+e5WBHkOSJEmi
	VIfLaQ7HNFk3jVEWo/6Bnzj7zvCYvDGeigD0sJ/kh25uE+tHh7Cpzz1KRdI30FA=
X-Google-Smtp-Source: AGHT+IGXQY2xgSKFPhczZZiTjQ6N1O0RfsfU58vW/70tHk+S+ZXTkDOKRyUr+Bk5Kzb8qmDDxFFdTA==
X-Received: by 2002:a17:906:1c8d:b0:a3d:16dd:307c with SMTP id g13-20020a1709061c8d00b00a3d16dd307cmr1498463ejh.5.1708003989366;
        Thu, 15 Feb 2024 05:33:09 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:7555:8187:c6f1:9c02? ([2a01:e0a:982:cbb0:7555:8187:c6f1:9c02])
        by smtp.gmail.com with ESMTPSA id oq25-20020a170906cc9900b00a3cd41b3c19sm541532ejb.199.2024.02.15.05.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 05:33:08 -0800 (PST)
Message-ID: <2df69499-4ffa-46a9-8e7f-041e87ad3034@linaro.org>
Date: Thu, 15 Feb 2024 14:33:06 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
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
 <ffb16ef6-fc9a-42b1-b9c3-4e8f6b52d849@linaro.org>
 <CAA8EJpobWYu8LoHZarOw82z78=kLJrKH0P4ncK6sX7zE1nHuqQ@mail.gmail.com>
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
In-Reply-To: <CAA8EJpobWYu8LoHZarOw82z78=kLJrKH0P4ncK6sX7zE1nHuqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/02/2024 10:32, Dmitry Baryshkov wrote:
> On Thu, 15 Feb 2024 at 11:29, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> On 15/02/2024 10:25, Dmitry Baryshkov wrote:
>>> On Thu, 15 Feb 2024 at 11:20, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>>>
>>>> Document the GPU SMMU found on the SM8650 platform.
>>>>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>>    Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 7 +++++--
>>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>> index a4042ae24770..3ad5c850f3bf 100644
>>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>> @@ -93,6 +93,7 @@ properties:
>>>>                  - qcom,sm8350-smmu-500
>>>>                  - qcom,sm8450-smmu-500
>>>>                  - qcom,sm8550-smmu-500
>>>> +              - qcom,sm8650-smmu-500
>>>>              - const: qcom,adreno-smmu
>>>>              - const: qcom,smmu-500
>>>>              - const: arm,mmu-500
>>>> @@ -508,7 +509,10 @@ allOf:
>>>>      - if:
>>>>          properties:
>>>>            compatible:
>>>> -          const: qcom,sm8550-smmu-500
>>>> +          contains:
>>>> +            enum:
>>>> +              - qcom,sm8550-smmu-500
>>>> +              - qcom,sm8650-smmu-500
>>>
>>> Doesn't this cause warnings for non-GPU SMMU on this platform?
>>
>> No because it doesn't add those to required, it simply allows clock the properties.
> 
> Can we further constrain this branch so that it is applicable only to
> the Adreno SMMUs (and enforce requirement)? And maybe constrain the
> second if-branch so that it doesn't apply to the Adreno SMMUs?

Indeed, it's done like that for the a6 gpu, I'll send a fix for that

Neil

> 
>>
>>>
>>>>        then:
>>>>          properties:
>>>>            clock-names:
>>>> @@ -544,7 +548,6 @@ allOf:
>>>>                  - qcom,sdx65-smmu-500
>>>>                  - qcom,sm6350-smmu-500
>>>>                  - qcom,sm6375-smmu-500
>>>> -              - qcom,sm8650-smmu-500
>>>>                  - qcom,x1e80100-smmu-500
>>>>        then:
>>>>          properties:
>>>>
>>>> --
>>>> 2.34.1
>>>>
>>>
>>>
>>
> 
> 

