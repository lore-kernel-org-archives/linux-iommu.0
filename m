Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7837D163A97
	for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511305; cv=none; b=iMy0edIn+v/UnX5RErqfhOBd0lh6tXyynh7aXsKFZiK3piGpOpp8ei5ECncPPWZoFLhftfNLN02VOmbOC4PF0bcgpoBLnFJ0laAWfxmejmTiQK5mDGmKXbrkt/TQ2QdX80X5ADHruWyy4a8jHXDkADNa42izzLi40OfWTmz/Lmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511305; c=relaxed/simple;
	bh=4LiMDBZ2BaPjcm4lQLrzPw+4IHjcexyzPDS6D111VAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jhb5NGyCFChIqsheC8OahlDYjRb46xPmyFVC2+566PKmmCz3j8CLQbQt1VOtwZ7JDI7LV2fpgYdVzcqhT1RjTBBtNGvH1oo1Xd2zuzMLaaqbg+bVIp93f79fsTQAEKkJa7ZNCoOMce2YoCCnHXcGTadiD4QnC9Y2Hc922GfAVQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V7IibhtD; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V7IibhtD"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-431688d5127so56895525e9.0
        for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 07:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731511302; x=1732116102; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xLqCtJgmoEWkkcExSIoN42a3vq6u8JMDyejdpawvuLI=;
        b=V7IibhtDdjjZctq7bsLVKkSED21L82cEZoePa5bv5DG69xGk9ZFrfWLhkenBkr9tSZ
         y/V77CfKDhNqWJseT811egN1WghHmAb15m6Pq/G2TA04iJWU1dNmH0ps4fQGtr45wr4W
         IqGFv96wq4Gok7ZReT6HqJBxGz3eLuJqU5/8/U4bmUMC86/y6uf+lRDMD/ALkXrM/80v
         OMM8itLj81Yvlk/apqwpb8biO8Ik2inVWJluD65yfS4SJbOwPByF43Yrw65sEryMslix
         5XyUi4PieaBFLjYovEfpAggxprDLJfX1eJ4imiQD6YxX25sHzaYI4XdH+88doC9ANml8
         27ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731511302; x=1732116102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xLqCtJgmoEWkkcExSIoN42a3vq6u8JMDyejdpawvuLI=;
        b=d8AQqfmF7TVaVvCqTbtW0PcV3af+0HJO13Y7dAWifdlBGRpz9Q1nPhRUygnTEclMax
         UZtT/1JcZVGLqJvmhKMN0vAEI+32GhjznPKUA2U0mosXrZG/ohUXckCMW3+M1nb1Kt7K
         FaOYkcW11nwIkzrRxOyrGvFSxDnMrSfqEIUMmLRphVBfuj8dll/ecBiPpHG6YzRBstcl
         bs3kptNf5ViI2sjuzwIMuiwJVvugreRevVgtLJH6sUC6GLpbHdl8jb4XMovRHaj117/l
         YahXDWL3mZcZEbT0zXMJCGbr0xLyK5UcpMt1TzfdWd12q3oyvCQi0yJ5F0T/6oyEa6yY
         t50Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3775l24/+Ts5Mf5e7uSIHTuaL+m3lP5unR1eESMr9YIa2JcZNXVCXIKwRoAOVMKThmEthNw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyM0k1UK8CRAOiyzXPc9rhpT7o+BxHt5VbleA9AOi09vI6zbGAi
	kn49wIW1cta21nVIiWQI7C0Rcw6hctizKFfdkLp8yRP56vFjPAi2jm16NYwD4/8=
X-Google-Smtp-Source: AGHT+IF0lRtjI2o7jj//l+xrcNOBKkeWPvh0yXKVaf2XDugcQj/I02Vc/Dy2jhxuVt1mr7E9yNfsxg==
X-Received: by 2002:a05:600c:4f4e:b0:430:5760:2fe with SMTP id 5b1f17b1804b1-432b75183d1mr175593615e9.22.1731511301811;
        Wed, 13 Nov 2024 07:21:41 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432d48bb442sm21749305e9.1.2024.11.13.07.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 07:21:41 -0800 (PST)
Message-ID: <3193901b-c006-4feb-af72-d8f74f2d6428@linaro.org>
Date: Wed, 13 Nov 2024 16:21:40 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/10] dt-bindings: thermal: tsens: Add MSM8937
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org, iommu@lists.linux.dev,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20241113-msm8917-v6-0-c348fb599fef@mainlining.org>
 <20241113-msm8917-v6-4-c348fb599fef@mainlining.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241113-msm8917-v6-4-c348fb599fef@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/11/2024 16:11, Barnabás Czémán wrote:
> Document the compatible string for tsens v1.4 block found in MSM8937.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---


Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
