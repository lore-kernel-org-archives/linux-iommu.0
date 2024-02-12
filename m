Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766F73D96D
	for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744973; cv=none; b=TdP5ul9pDHk1DDGu7G+95SRdbgvfwoc7XQwockSE8sU7T0uwnRG91WPTm884JieXpPj3gbfjByDsYXW10tSHnJTQ8BCM2q1gAF1C5RCWCf2BZYNgdc8bwlokrfwJmeDf5VgEPhX+HNPAVpr3nSYK1yTLCg1H/W5laV3vangdIVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744973; c=relaxed/simple;
	bh=FtXOp79ypwbFscUML393ETpD+v2GjZxqWE9vdktaxqg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=X3GnaRAqiSYdyqHUynEYhCxNe0AaVpTajhCuZM8j6G5KH9CSYNiKJS/kito/oOjWwkBiNodlB7f0FNvi21bJvl5HpHQun+sb2u4Qy44OwaNI7rRR+O+qVZLPuvQvtg2CnucX22W1LOvT/OCP6D3yBwG/29Y1wcPbzrkyBCVf2LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iH5v8NMK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iH5v8NMK"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-410ca9e851bso7004825e9.3
        for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 05:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707744970; x=1708349770; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=74ExFZRZ6onRvv/q7DNU+xV1ydzYGkcZ6r0iw+QAiOw=;
        b=iH5v8NMK/V/Gm610kZ2LUCu9AsrFr0UyL/7p2z4Pcmtqob7ecIb+nmfySBIXxWR5pP
         afB/CX5JTS++UWc8qa884lRzQpwGMe/4ffgo8fg4xtcZIIKgr0KV6JA+DK+ls/kEeJrf
         v+Pq4PkVpLnd8+UJG00a1e6MN84G4jRO6GjBT0RE6Y1mviGvn9zNEKr/vxTwCJlqf+WR
         /vYDAJPJIP1DIKcYIz4IhsQIQ1dblpk1FlvKQKxMc4h2dtnZ+DyhrPurVk6aQvaT3z0p
         zyIh/5xPh97FSOVeXjIkfnr0aC7k8unsjt1z11VUPNFm2P6XlDm109ATlpSLKiTUFY2m
         6QYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707744970; x=1708349770;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=74ExFZRZ6onRvv/q7DNU+xV1ydzYGkcZ6r0iw+QAiOw=;
        b=sfPy8Xud6bA/Oy8kqhFU1nlLW1UFzo6fcQpu/2NO88oZxTRXYdHiWBVWSOEZ1mqKg+
         1vOeZvcJXZuL247tTOz1wts+gA0KhBiJ64ismwEP3lx+aSfxGwLVQ7NNPX6XGsN9GsBh
         Ey9m+rlCz/2UIq7WBak5u0s/iWCRmfjgDLAYeByTQvEhA8JQCoTvACdGT48Hf3ggaVWa
         uUfkZWURSOXHo8pV7IYZKg4IpcUpo2rG/yOS0j+2t6JJm1lylr/2LlGri7e8JDjDv/Xj
         Vr1WOkc4mOY72YSwK4/OXbZpwURWq84JkUIqgu7YAYaY+PcfrK6BKGff3GRfc0G4StfG
         l1DA==
X-Forwarded-Encrypted: i=1; AJvYcCVg8dLzp1CbSRP5BQz/c+1lRHUOfy4Yanwr55bocPStD94h2cobe/w+VXoBueyQvjcpPP1YcPNeKFw6dsbODN2liYBzcGo=
X-Gm-Message-State: AOJu0Yw1w5Bg20faN67UleM+A0HdHXQReW3PMmlwcZVCST84++BaYfae
	9jbl8HkXPp4mXbT+AAx3xGCCBloslZc0kXb+nZVXez/TcrXZMnkY1euN1QznTBI=
X-Google-Smtp-Source: AGHT+IHxiOespFpZaN9WenVMCi5tYoRC71Rge5Y/lysp6dckeGcJpXUwPmAH8chS3wwMFs1t7xyxGw==
X-Received: by 2002:a05:600c:1d07:b0:410:cf4f:68e1 with SMTP id l7-20020a05600c1d0700b00410cf4f68e1mr2395117wms.2.1707744969631;
        Mon, 12 Feb 2024 05:36:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWCgnvirB9i9+S1u6JvMGnDSR/MdRPev3xT/whgmQ3kVizbkAlZA6Q0amVId/eUHGe8k/yZRvTSqCMNwDOl0JzBXkyvE8QSjDdkA1qxcheaCT8SpThUMPtSdxo5dn/ahCA4JJmVi0Pl0uanONdqVVO16y2xNLpHg1oMPpxRnNjT82gYNeIXw7esqqfNFyvimfbE9Z+jn/a6Wan6hy6ocxx86SKVOl0JvefGcsL56lxsjK1K8SmA+cZqKG2fiJPH56R2dnM7iUUcKWqm6wa919z2W5filsIGkf33d5Q/vsWIpVXXGXLowBc2VwRgba5WNkwfO9Aea5XLVez+xsSubmQ7Fqmn2/Onqii8wOquLC4QjpDm8YI5LN6sO7k/AD43OnB9kl8jJxByl5AlSww/6EryO0twX0dZAD086dWX7hvHaWoavbmtRYd/RiUpT+UOEZWtxGTIPsOpVpXYNwTH4e5sNnVLb+qlo/0C5Ecr/rAry7HhSmbSEMGMM+yZUbH+eSVewZiu6gCj6nDOWKLEVzXgEBqV2DAX48zO+ROPK0DdWAVN+Lslkz/Y32lqTbgsueS4mL5fFcLnP3rlZwGojJf2AjWEQ982/6BTK1r6068bXcSvVtSAK1rgvAWdhILammp+266OHfTfL3XKy242uF1sg3nCLAtJzuNFFXXnuHrubbuelj27cXprV1z7Wx2SlQskdg1lQpqIvDH8z+sDlWcdPI+Yvkn9DnkSCyEsv0ef3kreyYHbMwI+NTNOBjVxuatQeNx36fCRFmqCtaQ13gbMtHuM5yvj0hKMTz7ca4rPsPf35v+xbfl9DEDh5EFpvJZyNw==
Received: from ?IPV6:2a01:e0a:982:cbb0:fcee:f026:296d:135f? ([2a01:e0a:982:cbb0:fcee:f026:296d:135f])
        by smtp.gmail.com with ESMTPSA id t20-20020a7bc3d4000000b0040fff3382casm8592379wmj.46.2024.02.12.05.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 05:36:09 -0800 (PST)
Message-ID: <fff6f6e1-ca2d-4f15-b891-d9b52de8a72f@linaro.org>
Date: Mon, 12 Feb 2024 14:36:08 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sm8650-qrd: enable GPU
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
References: <20240212-topic-sm8650-gpu-v1-0-708a40b747b5@linaro.org>
 <20240212-topic-sm8650-gpu-v1-5-708a40b747b5@linaro.org>
 <CAA8EJpryCXUxs69ockt0TN4LOuBB-4dZkLYHUZyN1Uq0isMjYg@mail.gmail.com>
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
In-Reply-To: <CAA8EJpryCXUxs69ockt0TN4LOuBB-4dZkLYHUZyN1Uq0isMjYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 12/02/2024 14:32, Dmitry Baryshkov wrote:
> On Mon, 12 Feb 2024 at 12:37, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> Add path of the GPU firmware for the SM8650-QRD board
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
>> index 8515498553bf..7151f3dc67c4 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
>> @@ -525,6 +525,14 @@ &ipa {
>>          status = "okay";
>>   };
>>
>> +&gpu {
>> +       status = "okay";
>> +
>> +       zap-shader {
>> +               firmware-name = "qcom/sm8650/gen70900_zap.mbn";
> 
> But why? For sm8450 / sm8550 we had "a730_zap.mbn" and "a740_zap.mbn"

No idea why, this is the vendor's fw name, it uses the chipid (2 for sm8550, 9 for sm8650) instead of the commercial name like the seq file (gen70900_sqe.fw).

Neil

> 
>> +       };
>> +};
>> +
>>   &mdss {
>>          status = "okay";
>>   };
>>
>> --
>> 2.34.1
>>
> 
> 

