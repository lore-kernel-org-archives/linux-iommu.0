Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088DA883C
	for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711012801; cv=none; b=PeV9rxb0yoGScYIhoZ+2Bc8f29DXavMupT9jQSxeqNd27aEhOMCtJ+57cLyVG7+kATsq7gWf0i8DV+fja3hjnRAKB/hUKa+CgM7hYtCv+kcLYvVOMZ8MWsbt+BO3Q3wBZ6RWu2W4M1pg7erH9cgx0UIJ6Bcm6n7UFY4ANZGnDCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711012801; c=relaxed/simple;
	bh=OpPTfb6qaEpkPkfkuKGzKaqr8JmtOCHMyQRPHWlpa9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g3sVpUPUtbBiotmYqcdjQv/RCYRmrpV5OtIVBUb/CQZXlOEp8LYRpnYboqDymxm1V829X8H/xNQVMTv8E5IDcJZy9IO/FNYA75vz7uZNoW4hDWbvAmC8qewEM5HHCNxSg99s1AiVHRLasBgpMo2QrjNQXRtkAf0rs70zXLN7ukc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oOgAwamJ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oOgAwamJ"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a46f60cc80aso96027866b.0
        for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 02:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711012798; x=1711617598; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y9o6XSHuV6Rg9KXXUPNQI/05zH9LN9kPlAx4Zl2+03o=;
        b=oOgAwamJFRnoyoK804u6o6AgeZc5n49JjGO+XEXE8aXKJcpXLvSMc2GF/j8gypa9bG
         MVWwRTeELFdVKEh+c3I44GIjzgL6T3BXwhmLSUkC2vGoCF1+mA2uCua9BI3AMNfYUoir
         2pTPPOpIzuau1nvPpZ7N0YgA8m4fNtmMGaUTTzjug7ngCsMvzalUD+ijjwomUFHTcqn2
         cY92gJfn9LNifJuJvtRKq2YwJwmfiDKSXMaoh9zCyiYBhO04jIKZuvkt0spBZ68GRUzi
         2+b8N65Jfc9mGXRsbkAH3TbtiNCc3sFxf+S0KaPq1xllT8yp+zzznXtsYtqXAlTXgmrQ
         ciJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711012798; x=1711617598;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9o6XSHuV6Rg9KXXUPNQI/05zH9LN9kPlAx4Zl2+03o=;
        b=jubcDBB3gB2p7l9+t9F+fMDo/MrLvhNGp4M59ZUmXu/4U/tb8HhVxYkc9KpLbYHv7F
         5YXxy0z/roJ/freRsC4OCV2EloxNmMKKnIg+j/fSrL+pmsrNLIDEcBgE6sQ9xWK9587f
         kR7qQHu+vN9anlGob5SjxY0SEfyclOfQu5AehvLorWvufN5npjVoFj2/JoVBZmCqGr9B
         zGgCSfSgMMJbkFsWIk8s/Fty6JoHjfriVAL4IgN5Y94vQGhO6nWDvdM8Wxj/obGWkXtV
         5D9lGloa/CCmy9LkgTUy8y/pXJqumArP2hqQQpMFGCukVO1mOxKgICgLXccc7kUyQo+B
         kuzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuAfQwINFuctAwE37y+MrTgsUjo7yC/nsKmwEeX+ERT4enRaEPEblorwBGTgjWSNHHPDY+4Q7gNlqFRoriHJI7JwKqFe8=
X-Gm-Message-State: AOJu0YwLeYhawCu5ig+B1B5TsutuISbJ5lBdna8ySsYWdkqw9K1+3GF3
	X0x7xN3J40I2w4gge5eMcJlyc9lk/iyAqa8qFEs9/IExZp+GYQ3aKlkvm3kzRO8=
X-Google-Smtp-Source: AGHT+IF9916kM88PSoRglR66YCcVmLN+62YSmph8pj40Ei4HCql0ciJAUzxwTQXAbPksJsFHjE255A==
X-Received: by 2002:a17:906:190a:b0:a46:8c10:c75a with SMTP id a10-20020a170906190a00b00a468c10c75amr3106595eje.38.1711012798372;
        Thu, 21 Mar 2024 02:19:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id gf9-20020a170906e20900b00a46a27794f6sm6172838ejb.123.2024.03.21.02.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 02:19:57 -0700 (PDT)
Message-ID: <70439a01-7949-46bf-a701-c82ba961171a@linaro.org>
Date: Thu, 21 Mar 2024 10:19:54 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_2/4=5D_media=3A_dt-binding=3A_media=3A_Doc?=
 =?UTF-8?Q?ument_rk3588=E2=80=99s_vepu121?=
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>, linux-kernel@vger.kernel.org
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
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
 <4c05d3c0-aa79-4ce0-918c-7d0967ace520@linaro.org>
 <855507987.0ifERbkFSE@diego>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <855507987.0ifERbkFSE@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/03/2024 09:47, Heiko Stübner wrote:
>>>      enum:
>>>        - rockchip,rk3568-vepu
>>> +      - rockchip,rk3588-vepu121
>>
>> What is 121?
> 
> That is the strange naming of the ip block inside the soc.
> 
> I.e. the rk3588 TRM lists a number of different video encoders and decoders:
> - VDPU121 is decoding h.263 and mpeg1,2,4
> - VDPU381 is decoding h.265, h.264 and some more
> - VDPU720 is decoding jpeg
> - VDPU981 decodes AV1
> - VEPU121 is the jpeg encoder above
> - VEPU580 encodes h.264 and h.265
> 
> Each of those are separate IP blocks with their own io-memory, their own
> interrupts and their own iommus, etc.

Thanks for explanation. Short introduction in commit msg would be nice
(e.g. VEPU121, one of two VEPU encoders). OTOH, why not documenting all
of them? Bindings are supposed to be as complete as possible.

Best regards,
Krzysztof

