Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0965F17BB0C
	for <iommu@lists.linux.dev>; Fri, 26 Jul 2024 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999635; cv=none; b=HuV068YmYqJzvMFLkkn1BJSrnqkiFKr1v+058Zpqx/b1ey56X4E+ES2dt54w4HuRlra6R/a8javJYIuK4kwwJCNgPHLaIzr4m++OCazANtlGIaHZFiVrtQ9kjKy2CRi7mkBKkd29/CX9jxlK3O0iwg7W839loE/Zhjq4EOiez4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999635; c=relaxed/simple;
	bh=Cdmr1wNOXg3YuxF+fm5Dem5hL4V7dSar/S6BwJB33LY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=G0oMbyULbHMq+ImBrozp1qLdqTv2rNrmPPv1LwsiEtHG7rTWLHk/VXK8Fef7vByAoeYge1QzIBDrKXdwstea3nlkvrgnzMt3sGis32L10l206WXgY/avQ9zC9M4m/QUZzBT+sdXGmBIU55qQQZ9h78rXCwXoAm3qo96f3tEpfoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b0V+sHjZ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b0V+sHjZ"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ef2c56d9dcso14738121fa.2
        for <iommu@lists.linux.dev>; Fri, 26 Jul 2024 06:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721999629; x=1722604429; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zh3vyC1WH4G3/hH1Lds2F5b/d+/by8NtQNhwTrmTrdY=;
        b=b0V+sHjZQd9UqXL/yyXOMHx6YoqQ+OG6yaepsfuw2/07z6xPYojDIxNXtpoquN/yTx
         8XRLWqxSCpjaOb+8dac80MWCU+0VLlT2t55wDDnZZ14vl8ByTy0eH2Ia1GAsjWSv+kNh
         VXhTsyAqROJJCYDrVQEy19skXdWAIoL6n3VKsBgbuUknYNB1Kmm6zsBW1LBvGDK8ReE4
         zQKVFJxmb6/rVGUaL6D81yB/nvaf6MtB/Z+3FkRCZ8kQCFGrqXk5SlqJeQ9L0j0qYDsa
         gKsIG32Ls26VG7BKky7oFhLgsFCy37gXQf+nZ4/+m7ecmbMOjkhiXv8m765DsaSTYKjm
         QNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721999629; x=1722604429;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zh3vyC1WH4G3/hH1Lds2F5b/d+/by8NtQNhwTrmTrdY=;
        b=IoRMiq6TzNgs04zxw4XKcuVv0pFtkRVu5rUkeTF804epYK+FEigipQVUNn5wla4Zkm
         KREGAvy/ZEpZMQ2IeYj5DQOMrERCNyFM78FeTX2mYUeIVmsNp1XjNbszpRXJQmAtAqlF
         PtqVPtGll/gf+aptTDnr7v8IGZbH2/JGLEauSORAYE2OmCW9qRCOamUdja0Rv9Tbgj+S
         WVqxmLIvKVBPEdUXoi2VH2UQOThVSqYSz+7NLqhbAFSdVep4p3I/yygeqWicx7vNeEiX
         DCAaUqNxLZlKzEiPN1Y1t7r9DgcxAXAIIWWy9KFHLOY7JsE85ow/4Z2NAX3xrfVSpY69
         dlrQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9SrJ62Pzjt9SwjYEhWqIXDXE754icEorSiSvf6Z7ZW5IsDFSh207ddxjb403lPttgom8N5lXyzX43fu5EyF1MEs8E28I=
X-Gm-Message-State: AOJu0YxbDgm0tdMhb7tajH9iibwzMAGfbkBojw/QQ70Ph3xIquqBVnD1
	D31B+GoY1jlh5OshWsGXgg0RbCmxDJhb7QrHBOc/g0ioaqJjajqHFMJKnI9sS/w=
X-Google-Smtp-Source: AGHT+IHnthYvJSLZi9A6Pf8OaQCOFLwe8XfHMSX3Suyha+VZUk+mAsZml7xZkNIcx932RlRPoxus5w==
X-Received: by 2002:a2e:9f57:0:b0:2ef:18ae:5cc2 with SMTP id 38308e7fff4ca-2f03db8e156mr37629931fa.21.1721999628861;
        Fri, 26 Jul 2024 06:13:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:414f:cfed:daba:4cb? ([2a01:e0a:982:cbb0:414f:cfed:daba:4cb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280574a8a2sm80575835e9.23.2024.07.26.06.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 06:13:48 -0700 (PDT)
Message-ID: <d1bee4fe-03c6-427c-ac3d-7a33f1533ecd@linaro.org>
Date: Fri, 26 Jul 2024 15:13:47 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/3] mailmap: Add an entry for Konrad Dybcio
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-pm@vger.kernel.org, iommu@lists.linux.dev, linux-gpio@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>
References: <20240726-topic-konrad_email-v1-0-f94665da2919@kernel.org>
 <20240726-topic-konrad_email-v1-1-f94665da2919@kernel.org>
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
In-Reply-To: <20240726-topic-konrad_email-v1-1-f94665da2919@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/07/2024 13:18, Konrad Dybcio wrote:
> Map my old addresses.
> 
> Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
> ---
>   .mailmap | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/.mailmap b/.mailmap
> index e51d76df75c2..d189c6424697 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -353,6 +353,8 @@ Kenneth Westfield <quic_kwestfie@quicinc.com> <kwestfie@codeaurora.org>
>   Kiran Gunda <quic_kgunda@quicinc.com> <kgunda@codeaurora.org>
>   Kirill Tkhai <tkhai@ya.ru> <ktkhai@virtuozzo.com>
>   Kishon Vijay Abraham I <kishon@kernel.org> <kishon@ti.com>
> +Konrad Dybcio <konradybcio@kernel.org> <konrad.dybcio@linaro.org>
> +Konrad Dybcio <konradybcio@kernel.org> <konrad.dybcio@somainline.org>
>   Konstantin Khlebnikov <koct9i@gmail.com> <khlebnikov@yandex-team.ru>
>   Konstantin Khlebnikov <koct9i@gmail.com> <k.khlebnikov@samsung.com>
>   Koushik <raghavendra.koushik@neterion.com>
> 

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
