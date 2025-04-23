Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6391A262D
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 13:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745415796; cv=none; b=bM6IYO09nnVzBCWXv5UYEIC8DzcMnAsLTK8tCHqcTroWKhj+ONFTu+9TszONvEiSTlF2jllZyUM73s3WdCsQbLTOMembhI2Olst2/CG6ZiGwaolnYYRvk+xi+NWUbfeSKL+aevVJPr7/B/zQ9SE4MNR8CjTIvK4iK7mpfvIzce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745415796; c=relaxed/simple;
	bh=2oNxgFh7wQy3eSTXUuVVZ5YrZWKlKCIvbcZjJzlgFfk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=b2zWwGpaRNq9kZx3TPCw4yxMW6Nsp8RhmWiaRbQdpVG2A2e5fqlbfR+JnRlU/yV2Xmx2DD96VyJgmkOc+YeWR+vKEDiDGmbVuitnfiHGemTp/RKI1M2E8LsM/zJ1ih+tbhvyq/99x1KKyaHpwdsUfS1mC5k9G8xaWca14KzZUVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=or15lYK8; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="or15lYK8"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-440685d6afcso60758055e9.0
        for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 06:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745415792; x=1746020592; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FfrnhMcNKf5rCGWHGoNIZp7mNgbnWoHESdB7RpEhfqo=;
        b=or15lYK83xDnOlDhEaTroDg4SKfpuP97nwjFnNJeTnbmnizCcRawOUNcZqDKBdA9aB
         IY4gWqYuELw27smrXcaQPNkLsl/NWizNJVYSf7GqdCGVI8DmebWa1GUgYVh19k8bjdY0
         Nbc8Oa/6dC4UekZD2mo+Exa9X0L23kLAgXjMOQgOk51I5vq9tmSi/DHkhZUVGmsMG/vT
         C7MFTfoARZylmun6/2oFryfIuGrGDqbJzw+LNxHA09OAXP1PDEyEid840qyiQPYG8g0g
         NPyFnf4yfyslTbFRcpls6UFdzl/mLsRLF4n9GYGoprTLqWRKCMZ+rmjZ0Xpg1eJAYJ5z
         G2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745415792; x=1746020592;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FfrnhMcNKf5rCGWHGoNIZp7mNgbnWoHESdB7RpEhfqo=;
        b=ll/vm029u3GCbe8xac1HLsuzyNXLc97EFcLjAUu6JhYqNW7dtnioHnx9uoXLo4FTXW
         o1NiL1Hyx3O+RUTxQ1BXiR3pdJ99+N4jtVB1WkK5LCI+rzJ7JhKCFB564gNNaL9kZPWI
         pK1hkA1G9S6jL92hFBSnLQTX3pcv6bE0VW3KOXcOL7Xz3D7tiX1ZJSqTnC0twIfC5yWl
         RJX0JYaY0zp2vAG5m7FEg3XT4/YlWY9Lm9F0iQRoO2tkOkx34BieZiXM/otUUh55pLyn
         f/HckNOVCqYuZsmDJPPt3piPfgrv7MuFj5nvNEWQZ9wWfuvFkuybR9yeepEyXgs8ao2U
         7YfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFRrE2KGS4gPNuX4GKJ42Cih1UKTWi69PkoIDyIAlIxPVL6k1AvzIpG3V+kfyRklsRdHCtgg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNxkRINT7tXctZQqyVK3q2MQKwU+b4lOCoao01jPAS1IcIXERz
	leJpq1ig4LiQ2GI3p0L5OSGIiPe6R2gKZ40dbw/Cqiza21mZSujzhSh7O64bAp8=
X-Gm-Gg: ASbGncuxVFvCuUjNqkvd1hOSOfXhy8Wrm32Q4wE7pb3a0PjkFGzgVhzxQb8H3zeV8nF
	e2Dv0tmKp2agHrXJB13dziiggMOa5idEgaT7RclUSpsTGLcAfPqEcTFXy+kh/FEHkbLDz+SFWPd
	E0lxG5owj4CXHoaaXeI4f+ruwUxm6MMmMY1bNw26KtK0rTlKw+w+RU/5ZKS1pJwIyuQJwClxTSJ
	L3jv5jhxorNeLJlAuUlWTuGTHE9iesQbssBE0XXFdbLaXFB5Uz8ctB+SdG8GnZ+JSDj1WEJ1h9Z
	PPkLMCfgPDVueS1hnCLOQ/M4c8BDJjluaAZ8SjkIJCTZB6s7bt2XNFdUUiujIpcNKi6vGgvFdBS
	ogtzOsNLDPaipZfhGLg==
X-Google-Smtp-Source: AGHT+IHnS/+w8vgB7Qer4VFmmeqW2fg9vqIPQjMtQu2PKuXwZePY3kDPFYEnC2G7XWePQ888jen21Q==
X-Received: by 2002:a05:600c:5027:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-4406abfa6bcmr157183955e9.20.1745415792377;
        Wed, 23 Apr 2025 06:43:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:2835:c2f4:c226:77dd? ([2a01:e0a:3d9:2080:2835:c2f4:c226:77dd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44092db2ba6sm26108245e9.31.2025.04.23.06.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 06:43:11 -0700 (PDT)
Message-ID: <1acbe9dc-02ca-4233-a79a-901e714f5c9c@linaro.org>
Date: Wed, 23 Apr 2025 15:43:08 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 32/33] dt-bindings: display: panel: samsung,ams581vf01:
 Add google,sunfish
To: Danila Tikhonov <danila@jiaxyga.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-mmc@vger.kernel.org,
 netdev@vger.kernel.org, linux-scsi@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-remoteproc@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hardening@vger.kernel.org, linux@mainlining.org,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250422213137.80366-1-danila@jiaxyga.com>
 <20250422213137.80366-16-danila@jiaxyga.com>
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
In-Reply-To: <20250422213137.80366-16-danila@jiaxyga.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/04/2025 23:31, Danila Tikhonov wrote:
> This panel is used in Google Pixel 4a (google,sunfish). Document the
> corresponding string.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>   .../bindings/display/panel/samsung,ams581vf01.yaml        | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,ams581vf01.yaml b/Documentation/devicetree/bindings/display/panel/samsung,ams581vf01.yaml
> index 70dff9c0ef2b..a3a1de32d8be 100644
> --- a/Documentation/devicetree/bindings/display/panel/samsung,ams581vf01.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/samsung,ams581vf01.yaml
> @@ -17,7 +17,13 @@ allOf:
>   
>   properties:
>     compatible:
> -    const: samsung,ams581vf01
> +    oneOf:
> +      - enum:
> +          - samsung,ams581vf01
> +      - items:
> +          - enum:
> +              - google,ams581vf01-sunfish
> +          - const: samsung,ams581vf01


Why do you introduce a new compatible ? using samsung,ams581vf01 is prefectly fine
if it's same panel.

Neil

>   
>     reg:
>       maxItems: 1

