Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0B778298
	for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711008897; cv=none; b=CY9vVjsdt5g9zIspNiM4vEVoKm96T2bHoj7pz4CT8PbJQGarFhtSy81+R7Ae+6hzn+bvOFrO5f+ynffk7RuS+vQg3cchAxdMZlIfjuS4rNmXW5esJOl3pWaZ+5r2e5exRlRxnjain/H2qwiMkiN9JPM808aXo/8zHCP/iIF+yMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711008897; c=relaxed/simple;
	bh=QyEyGaUWJamL4qBLiU3qsxQbgR8JFUEDJ/D7kEW4/ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3R3oR8BrH9NzpNR1tB4WrUkyi4g6cI+d9xwk4bWQQ98jUrZ22yTy/ao2+Rv9008xGkopyy6dSoZ0TOSwMNc7jFUFe0A/KS1Ka1tid9cnmzK3mVsRCS6XeNipTfZkK76CQqH+mU1uHARt8CqTGn8BOmHUizxVelfBlUVUHZROo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w5o0kQMr; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w5o0kQMr"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso65573366b.2
        for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 01:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711008894; x=1711613694; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bumbK4Iq37XZI7PAaRcKjKb4r9QAOyHdGVrz+smI1ho=;
        b=w5o0kQMrzGooMWqjqdYWs0QWHhEyyEyQAXc2fVIa624UC/lAVjvXit3uCAq6acaohQ
         41sYXp44NVRsNKc0hgRLMqQOvpNnw1CmWXUn4gjfYE2m2e6RugwXwDuHSxfifCW4zZjt
         6l4FG1rgauHRQZExmS9CrzAFu9a2vwMwJIin28TsV/XMlnzohvxbnw4WG/2/4iGf6iWt
         uVWQ10t6wS2xJMBjEUCZ9LLLlBRooscZ9iAynqo013ikYU9Cjm1LnerPzy7/mpO7XpSj
         mYeHkMKLWmQbQm/Z9oVD9Eov+ivkwoLpFmV+JhDQvSukouuYQa/CFuhwt88Y//j4GnCm
         eI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711008894; x=1711613694;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bumbK4Iq37XZI7PAaRcKjKb4r9QAOyHdGVrz+smI1ho=;
        b=ghZjXY9nt6RNlxQ3PH9jPeh42YwqzjvWk1MeQu52jTfXiyndkKaIhFvAwFNtDQym47
         UFnsufr4vIUPseY/L7A89cXwmdM9hY5U3xg9vn7UUG8jWDzP2GTdeWwyIYuqj8oEEMSS
         LJwhJd+9dwKm1GwA20ZblLjLhQA2i8oPVive6320fj7K+wHpnJfwFg7X6akdvuS16n7b
         KGOkRqYD5CurPg+slJUPMJD3E7I1ims05jCtpe9kx9UIiNtpUJfBXspXhk6VE4E7rc2d
         KjDZsFjwKilPm37OLIYYD+eRkJeyzFq6h4A5q0lsva17zKbtkLgCWFIQhyuIYNektRG/
         RcYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUtJGGgWISK/rJ5u3AvyndbiuOxlvGFU7+GN5AlRqI+a9GQcem7o23yMZegsBG8vZ17agDJiz0J/7iYTAOJCcA6rqByCQ=
X-Gm-Message-State: AOJu0YwszwZ9sp+VwaX+EGcrdVEMLAMjF9XZ66YgspjnbBmvsZT7zCCB
	uWtv15Naf1f5mdOPMmY46zNsbJw3LQ2k019UxX7gYg4RUYWbREUcIlBm/uSnJM0=
X-Google-Smtp-Source: AGHT+IHnQrPGnZT2/iidhGyn8HX5rcqqkqaLrfSr6V+AeAqqQrXxfQKRJGbNVs83QEsinhw56m91Kw==
X-Received: by 2002:a17:906:2cc7:b0:a46:2e1b:a11f with SMTP id r7-20020a1709062cc700b00a462e1ba11fmr718296ejr.31.1711008894227;
        Thu, 21 Mar 2024 01:14:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id en6-20020a17090728c600b00a465a012cf1sm8283979ejc.18.2024.03.21.01.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 01:14:53 -0700 (PDT)
Message-ID: <4c05d3c0-aa79-4ce0-918c-7d0967ace520@linaro.org>
Date: Thu, 21 Mar 2024 09:14:51 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_2/4=5D_media=3A_dt-binding=3A_media=3A_Doc?=
 =?UTF-8?Q?ument_rk3588=E2=80=99s_vepu121?=
To: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>, linux-kernel@vger.kernel.org
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Shreeya Patel <shreeya.patel@collabora.com>,
 Chris Morgan <macromorgan@hotmail.com>, Andy Yan <andy.yan@rock-chips.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20240320173736.2720778-1-linkmauve@linkmauve.fr>
 <20240320173736.2720778-3-linkmauve@linkmauve.fr>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240320173736.2720778-3-linkmauve@linkmauve.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/03/2024 18:37, Emmanuel Gil Peyrot wrote:
> This encoder-only device is present four times on this SoC, and should
> support everything the rk3568 vepu supports (so JPEG, H.264 and VP8
> encoding).
> 
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> ---
>  .../devicetree/bindings/media/rockchip,rk3568-vepu.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml b/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
> index 9d90d8d0565a..947ad699cc5e 100644
> --- a/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
> +++ b/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
> @@ -17,6 +17,7 @@ properties:
>    compatible:
>      enum:
>        - rockchip,rk3568-vepu
> +      - rockchip,rk3588-vepu121

What is 121?

Best regards,
Krzysztof

