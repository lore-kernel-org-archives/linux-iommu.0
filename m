Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1954A54916
	for <iommu@lists.linux.dev>; Sat, 13 Apr 2024 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713043378; cv=none; b=DJ8GNAwMAdyGpAFHQgd/WjBF19D4wwlYNAAsrQoEHiqFZS5ajGkhXf4EegC117hnzNokFuuPyPfr2mMeQoEVtwL/PMPpQP0hAE6E5LCV/Te403OmMvLG5mfB8X/ohA+byhoHAzyHLzaPwo3OjGk93lURbnp9sJCJwYKRumdXTy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713043378; c=relaxed/simple;
	bh=CLOsJ9JefwFWpu6Gyok6bIDnzK0kyZVNcacBldUWqCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UGbborBF8ffx+2VKncYleM7Tyvaa2D4lJlnVcOosS/sAiBLPZ4j7ZUc/ob5lzP2ktRN0cRke9dJxD1KwNPHDhSUMspjb9Gzgvs6xzei6gpsvR2VWiN9iEt55k2meDGsNp0TnUYl02JFgcikp7gAbLmc2UcYt7cgreMwDL+vgmr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hUozCihY; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hUozCihY"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-518c59b41ccso234564e87.3
        for <iommu@lists.linux.dev>; Sat, 13 Apr 2024 14:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713043374; x=1713648174; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fQGJpaWsjUM7AHqikTaGEm8A9+HIjPT53LC7Bj6lY+U=;
        b=hUozCihYQcWDSkkP3d+PM4QdmxGomAXNKSjcwEMAJA5UEJ/zj8/pBeRbbhkTZEOAmX
         88BOZkwysjRazmdAwPxtqcpGtdccqm1NK3rS/Q5O5RAREdK8KaUdxsI7BqD4DipUYi7G
         5pONduvLKXJF0PvLo7Ryo/Nj6mo5iYmMkqaVzpBK72CCUUQ9uA9749MdgK2R2kLR0QT/
         ii/S7YKlKTmkxuA99vaSuS8qBbgUVGqMWeAvDdTzuIWBQA+aJjS0M5xn2A0qUXbyQ7IS
         iOefTr33YnOt7TFIaVhTLosuT/r2lb0IF98kfYSzXyz+HvDjPC7WbZ0TwsMw2c3SEpDP
         jM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713043374; x=1713648174;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQGJpaWsjUM7AHqikTaGEm8A9+HIjPT53LC7Bj6lY+U=;
        b=nEXI2duggHiqpdOTie1daM92159omOMSDzPFFmHP5eWxQe80+Txdgm4GZlbZ7hEKa+
         12+htUnt6Q7bU5G4/6BSqrugqhGjbmhC7dJ9ZKIbGc+u5Faou70r7rZlWI4Z1KkLLcmw
         2kvCYKrDbopsiw2Kbk1UN7tgY/PP/0tUAaMVK7aFZBQs4L1R3jAceMoctWmK+ZycIuJb
         Z8ydXAtzr5V1FQQ/djWb8MYmQk1mjD5qFY0FNZbh4joBU5EywaBF4vxnbkejbT1uiuoH
         qxEVi0ZGSjpGTS2j+UiERBGWsw4YsXUGVneB3kWnLUgok6wOr0e1uWUR/ds1HvQUF+a7
         K0qA==
X-Forwarded-Encrypted: i=1; AJvYcCXwsq/1aforloMQ+/crm0+GBp0MTh9Zc8NAhJGCRX9ZJjWobhOlDpx3zb+lbKa3N+FN7gwcpcnXhQoiKyNWhn9XBeXKGOk=
X-Gm-Message-State: AOJu0YxqoCitqPSQ0kXJMnQJI2hxEj11Jaqk7X5l2ejgQV6gC4zlS043
	TLcT/Q/8mIn/V2M5lhRW304qtbYlyQBKWWeTWvf39J784GxhSQSi7mLTocd4Whw=
X-Google-Smtp-Source: AGHT+IEpkgGV4cfM8OxwVMC43mCKJlrDMrXOzRC0ZAFr0X9Vk8KLbuzMNlMAoySsyCTi3Vc2bDE5xg==
X-Received: by 2002:a05:6512:3d19:b0:518:6ee7:b988 with SMTP id d25-20020a0565123d1900b005186ee7b988mr3837518lfv.55.1713043374088;
        Sat, 13 Apr 2024 14:22:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id bq3-20020a170906d0c300b00a522f867697sm2533293ejb.132.2024.04.13.14.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 14:22:53 -0700 (PDT)
Message-ID: <d0839eec-7a92-4834-b47a-be0ba1908c1a@linaro.org>
Date: Sat, 13 Apr 2024 23:22:51 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v3_1/2=5D_media=3A_dt-binding=3A_media=3A_?=
 =?UTF-8?Q?Document_rk3588=E2=80=99s_VEPU121?=
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
References: <20240412151515.837824-1-linkmauve@linkmauve.fr>
 <20240412151515.837824-2-linkmauve@linkmauve.fr>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240412151515.837824-2-linkmauve@linkmauve.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/04/2024 17:15, Emmanuel Gil Peyrot wrote:
> This encoder-only device is present four times on this SoC, and should
> support everything the rk3568 vepu supports (so JPEG, H.264 and VP8
> encoding).
> 
> According to the TRM[1], there is also the VEPU580 encoder which
> supports H.264 and H.265, and various VDPU* decoders, of which only the
> VDPU981 is currently supported.  This patch describes only the VEPU121.
> 
> [1] https://github.com/FanX-Tek/rk3588-TRM-and-Datasheet
> 
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>

So you ignored all the tags? No one will pick up your patch if you are
going to keep ignoring them...

Subject: drop the second, redundant "media".

Best regards,
Krzysztof

