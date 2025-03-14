Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB3215573F
	for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 07:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936945; cv=none; b=ecdT6MXTDX4uoIz+OpHFM2sl4mbHmTAqF5CZEaAUiebZScpNoz3gHArMjvINTdqkGTKjDQxzprxHf4W2pTRe2kQIu7LlWgqJDIWd8sL3R9y8aY6+cehTCGZlR9+Wj5RD/IGJ7vmrLduN43kU09XdCqr6UJeTFsHfOQTK2kiMoys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936945; c=relaxed/simple;
	bh=b1J5tmKFP2elSXFUa6Q8dnEcz99VVBKKN0SRPPG50W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uG0CQNk0TCelgycTRRagYPK07uDmkwmyhXnXi51HTgA/t6Lu2ez9/IPYveSPP1ER98L4yQ/nbcaVZ9M5/PhH6L5QC3/rG2ghVvgEUeoY73HyL9pScOmL3mmWi7Ip29Ax+iDg5vMv/vw89cQdJnM4syZyn79rI4g0I6D+aX0WVc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xJXnyQoM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xJXnyQoM"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3912ebb8e88so152105f8f.0
        for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 00:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741936941; x=1742541741; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7HUWZLB6XvkRSYV5keU5hc5SgzMl7bKgaxvzLFxeeb0=;
        b=xJXnyQoM3ErGDktSHorOZ0o3Eyq95XjuIQezD+8ELBmQKnfhVnRuihWB5IPMIcHWTt
         k7jp3SB+QORL2Gra/Cqu9arWw+rtVAmLiSjiIVwyoSqVFogvSSK74eVqPoHOf+wHr3VB
         iqpUNmTwzet9yVpxllMHD+UdSToh0oeFSI4Zbb5dqerCpBCGfl8FhiIvGrrC8dEPbjdX
         1zLxALA6aw3A9pGmlI0onRUs4cZjBpgS+gBBYQo1nk6cKWr99r00HHJFkCBjMRt/iD/j
         Oitvg0BlT/HvWQ1IJvLngX6B6/3DoyWNW5iYAgRsCfsCcuPcpIZiOn4Z+KBLGipPr5YR
         RVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741936941; x=1742541741;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7HUWZLB6XvkRSYV5keU5hc5SgzMl7bKgaxvzLFxeeb0=;
        b=ByTvH34PJ3uHDO2bBJOQUEkH5eM0lJ37exE53waUvzCMzJ+IKnul1HoXQYKfTI4NZq
         mN7p8ztFsVmIst2b9ajeXlSUWadAFIKlIT2+DD9+vEN5StzSI1M9FEFMZv6IfEu/qyY/
         uwiGzmpd7JSIz0z+fRCivKT6mUXAlvtRbIqczMPfOo5DOiCHemSOaRNKsSN2nG5d1I/v
         k8F8QV8z6gGEn0g2u1tVZEz2pqXMvpT5rZyLplJbJ7fK7I/+09ZimK7RJX92787rCeHP
         iUJd11zleuj8r1lXFFS4rwmxeWNwR+3eSi9odRb/rFW1VvicohojWQeN2APRv/zIcGOn
         Xp0g==
X-Forwarded-Encrypted: i=1; AJvYcCWW9sum1TLoPjKItt4mpqpfOph1NHNkJgIqcNisfSD4M0AyUB8PNkWU6ofSTbvi6Pn1LNE54A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmZv3uX6rZ24OuI63Wxx0BsUB6+MxgrKpW9G//wNVE0fPw3Nk3
	tD3iKG4hIVHvCMsRIcr0SkEn6DjDR+WeUd/c98a/QhU6c+hZ9lNNhMbH5FwbOBM=
X-Gm-Gg: ASbGncudWcL1S1MTVBycuA2MxfCmeeuRy0Waza6BCXY5ga2k04ym2dI/3fVSy9kcTxb
	4j3PeCKTiLwUm0S29MmmwRFSwxBdfGyNof+7PRFwjKIBNhL4OwRcaaX6HPmeKv3be1Lz/CyAo1J
	WXO1QenZ3k8zZs+e5oRQnh9qlVl6ew4L6b1TvOdk2RmEELE9dYWfJxb8Dw2KGJJFcw7bXlrdbbn
	K1FdHwJ7JckxgYGIbAyq1s3qjo18qdUXzFJ61w4pTo+0FePmftIbvZ7fzqU3EeMvzkCBXErZXDg
	LtXPh69P0f7HCUkYgzYCAUI8CR+aLNw7OVLuP4FC99auyY6VsMQi+D5Xmt37AcGieBI2kHwJKQ=
	=
X-Google-Smtp-Source: AGHT+IFqpUaO5BAfoMAWgpp/S+O2lpqO7jCO2UugS/12kRgniuV1f4bQhR/s6iZFyVH1bsT9wmCuew==
X-Received: by 2002:a05:6000:186f:b0:391:2b54:5fb5 with SMTP id ffacd0b85a97d-3971f40fecemr667494f8f.10.1741936941192;
        Fri, 14 Mar 2025 00:22:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975febsm4713500f8f.59.2025.03.14.00.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 00:22:20 -0700 (PDT)
Message-ID: <6957575c-9957-48b8-b828-0a6b48d4a743@linaro.org>
Date: Fri, 14 Mar 2025 08:22:17 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] dt-bindings: power: qcom,kpss-acc-v2: Add MSM8916
 compatible
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Robert Foss <rfoss@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Wesley Cheng <quic_wcheng@quicinc.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Rohit Agarwal <quic_rohiagar@quicinc.com>,
 Kyle Deng <quic_chunkaid@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-usb@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250306-topic-dt_bindings_fixups-v1-0-0c84aceb0ef9@oss.qualcomm.com>
 <20250306-topic-dt_bindings_fixups-v1-3-0c84aceb0ef9@oss.qualcomm.com>
 <a7d76aff-0dc2-4b0e-9ee8-f433d8e745f6@linaro.org>
 <wccjda6emgvsgn3t5qj7kfsih2stcelnvwu45qok4bbln5kk74@drqp7wrrges4>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+FiEE
 m9B+DgxR+NWWd7dUG5NDfTtBYpsFAmI+BxMCGwMFCRRfreEFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQG5NDfTtBYptgbhAAjAGunRoOTduBeC7V6GGOQMYIT5n3OuDSzG1oZyM4kyvO
 XeodvvYv49/ng473E8ZFhXfrre+c1olbr1A8pnz9vKVQs9JGVa6wwr/6ddH7/yvcaCQnHRPK
 mnXyP2BViBlyDWQ71UC3N12YCoHE2cVmfrn4JeyK/gHCvcW3hUW4i5rMd5M5WZAeiJj3rvYh
 v8WMKDJOtZFXxwaYGbvFJNDdvdTHc2x2fGaWwmXMJn2xs1ZyFAeHQvrp49mS6PBQZzcx0XL5
 cU9ZjhzOZDn6Apv45/C/lUJvPc3lo/pr5cmlOvPq1AsP6/xRXsEFX/SdvdxJ8w9KtGaxdJuf
 rpzLQ8Ht+H0lY2On1duYhmro8WglOypHy+TusYrDEry2qDNlc/bApQKtd9uqyDZ+rx8bGxyY
 qBP6bvsQx5YACI4p8R0J43tSqWwJTP/R5oPRQW2O1Ye1DEcdeyzZfifrQz58aoZrVQq+innR
 aDwu8qDB5UgmMQ7cjDSeAQABdghq7pqrA4P8lkA7qTG+aw8Z21OoAyZdUNm8NWJoQy8m4nUP
 gmeeQPRc0vjp5JkYPgTqwf08cluqO6vQuYL2YmwVBIbO7cE7LNGkPDA3RYMu+zPY9UUi/ln5
 dcKuEStFZ5eqVyqVoZ9eu3RTCGIXAHe1NcfcMT9HT0DPp3+ieTxFx6RjY3kYTGLOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCYDzvagUJFF+UtgAKCRAbk0N9O0Fim9JzD/0auoGtUu4mgnna
 oEEpQEOjgT7l9TVuO3Qa/SeH+E0m55y5Fjpp6ZToc481za3xAcxK/BtIX5Wn1mQ6+szfrJQ6
 59y2io437BeuWIRjQniSxHz1kgtFECiV30yHRgOoQlzUea7FgsnuWdstgfWi6LxstswEzxLZ
 Sj1EqpXYZE4uLjh6dW292sO+j4LEqPYr53hyV4I2LPmptPE9Rb9yCTAbSUlzgjiyyjuXhcwM
 qf3lzsm02y7Ooq+ERVKiJzlvLd9tSe4jRx6Z6LMXhB21fa5DGs/tHAcUF35hSJrvMJzPT/+u
 /oVmYDFZkbLlqs2XpWaVCo2jv8+iHxZZ9FL7F6AHFzqEFdqGnJQqmEApiRqH6b4jRBOgJ+cY
 qc+rJggwMQcJL9F+oDm3wX47nr6jIsEB5ZftdybIzpMZ5V9v45lUwmdnMrSzZVgC4jRGXzsU
 EViBQt2CopXtHtYfPAO5nAkIvKSNp3jmGxZw4aTc5xoAZBLo0OV+Ezo71pg3AYvq0a3/oGRG
 KQ06ztUMRrj8eVtpImjsWCd0bDWRaaR4vqhCHvAG9iWXZu4qh3ipie2Y0oSJygcZT7H3UZxq
 fyYKiqEmRuqsvv6dcbblD8ZLkz1EVZL6djImH5zc5x8qpVxlA0A0i23v5QvN00m6G9NFF0Le
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <wccjda6emgvsgn3t5qj7kfsih2stcelnvwu45qok4bbln5kk74@drqp7wrrges4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/03/2025 23:53, Bjorn Andersson wrote:
>>
> 
> Where are you carrying these? Are there any other patches on your list
> that have fallen through the cracks?


Since 4-5 years I have a branch on top of next for pending patches for
Samsung (initially) and Qualcomm (since ~3 years) bindings, where I
collect all my and other people's work related to 0-dbts-check
wanrnings. The point is to avoid duplicated work. Around 2022-2023 the
branch grew to and kept size of around 100-120 patches. I was rebasing
it daily.

I don't maintain that branch anymore, so for dtbs-check it has probably
just 10 patches in total (remaining ~30-40 patches now is some other my
work). I also rebase it once per month or two months.

That Rayyan's patch is there since ~July/August last year, just like few
things for IPQ, qcom,pm8941-pon, DWC3.
https://github.com/krzk/linux/commits/pending/dt-bindings-qcom-new-and-fixes-for-warnings-linux-next/

https://github.com/krzk/linux/commit/f6761796e02330b92653b35ba4b1c20ff304dded
https://github.com/krzk/linux/commit/fdd475359f378760085d3680423b291eca4bf808
https://github.com/krzk/linux/commit/855535ad2c4346b49f48c3fea6adbeea2262ffd8
https://github.com/krzk/linux/commit/f648bb95180f131241a5c7a7808c9f0865379c75

> 
>> https://lore.kernel.org/all/20240710155226.130086-1-rayyan.ansari@linaro.org/
>>
> 
> I'm picking Ryan's patch through the Qualcomm tree...
Thanks! That was my intention. Whenever subsystem maintainer skips such
simple driver binding, please don't hesitate to pick it up.

Best regards,
Krzysztof
