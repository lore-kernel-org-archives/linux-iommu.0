Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D810314E2C2
	for <iommu@lists.linux.dev>; Fri,  6 Sep 2024 07:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725608343; cv=none; b=lwTsO6vQO8oZJq7czvDpXWcBjw3Fgrv2OVnftntxHkFEJe3smvccHJHMP9/22W97/KDvhAfBQm6Q3mZLejr8cTB1kHA9MHbpHyvMMqXvueZGH5nWRXlPyIPznCDVIutPZQ5TlitA68AJ8UR6ia0tKEmA4NmRMs1lebaBad2pcLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725608343; c=relaxed/simple;
	bh=/VfN5TZBKFESX0ktdJnLpkP+3s1XJrbvW7+e2JjstSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JMghxj7WmLQtA8pb2S+INt3F1Zm52tNx32j1kIropDG1Obe/y9f+CQ3alpnLBOlHtQXgd1ls9Bf0i0PxToiWvytTWY6vFngXyHg5U/WeIgpM1TuSqUmN2Yqqil8o2dsvuhKhaBbCL+/QvmWnYZ4TYtui9zImLt8jm9R+jos7Eio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dza5a7V5; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dza5a7V5"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-374bd059b12so936396f8f.1
        for <iommu@lists.linux.dev>; Fri, 06 Sep 2024 00:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725608339; x=1726213139; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xz9IdLmzy/T20GbDRPSYjXR1GKGx3xeoUvnivTDuQzM=;
        b=Dza5a7V5Vkh9Q2o4sbCcRV5U67fitSyYZHMO30eFfMaHCn0bLqZX4DWEAVR8JNqKrn
         qFmHQLbP9xJAX2miob53Ev49ZK7zOnGKllqSsK/iiQ03wkMtj4XilJHjbSYntM9jMjDv
         T4r2XDVb44xsDRkXo+8Pnb05XAxzc2v9+QdkdUrE1BF8Am1cP23pgEHqE3ovC3cetXQY
         SQPM+lSEulkyMkelpXITIpB7uou1KAnGx3BvFR06WhXaoPG0TEX+59BAAZTFsL0FbzlM
         swE7An4R9dghHj/aWM1AWTzuxJiQyt0VtqAd/ZX5tMx2TW4lq3R5Yw+fQCe5Pni0Hics
         cVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725608339; x=1726213139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xz9IdLmzy/T20GbDRPSYjXR1GKGx3xeoUvnivTDuQzM=;
        b=o0YVQtiVinfhTTfUw8bgN/pCKWM6YQuoz2NcBpJbLL+RlRjx6LCSmx/OpDEkPjVwb4
         YHscNWVGZ6ctjkgdVHBL4RjlKNaK+nRHoinKTrRSsy7IerX/AwCYZd5DEF8gjIVGCe6Y
         shUh8PyRxO9xkYFrUc/WQmAML843oYgCIU7+z9mnl58Vq8/rRYAmp4kCeqNiCwf8enfv
         l0o3P2Nx9XJkJx1j6SIjOCf7ACmhmwVj7ZW6AMzXlidPv+3GuWcFrZyVnEbPKMl5OFS+
         fhIEMmFNeK7V4+lPcue680pLzyhqWWbUQoWiUDTs+8HYaag3zW46K1XQnj5t4Jgp4ZV0
         FoFA==
X-Forwarded-Encrypted: i=1; AJvYcCUi9qOKQmrm64ZK90wCde4o4Dfi1AUIqvZJWRDX2fR4EwHPmE4vW+UwweNbo/7XhmRysA8MSA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxl4RNSYX0bPrdgIc8pkm+FlBlWqjMfH7HUPjHz8zHLi6+yHyGW
	fIt5iAD4uJR1heiySySarvylWzkF8JYiHi5NRosi/UVXAbxbfyJASfjqjLd7VEE=
X-Google-Smtp-Source: AGHT+IGFHwFQ99mHOKHLLsrCtuLnOv+VrrxaTcWgKFCATGwuZhLv7Zk5Z474pGF9RhYDinH0QTPZug==
X-Received: by 2002:a5d:5f4a:0:b0:374:c269:df79 with SMTP id ffacd0b85a97d-374c269e0d7mr16000044f8f.22.1725608338871;
        Fri, 06 Sep 2024 00:38:58 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3749eea60e2sm21002351f8f.62.2024.09.06.00.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 00:38:58 -0700 (PDT)
Message-ID: <64758ccf-7ad4-4490-b938-864ade9ae74c@linaro.org>
Date: Fri, 6 Sep 2024 09:38:56 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/21] dt-bindings: thermal: tsens: document support on
 SA8255p
To: Nikunj Kela <quic_nkela@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
 viresh.kumar@linaro.org, herbert@gondor.apana.org.au, davem@davemloft.net,
 sudeep.holla@arm.com, andi.shyti@kernel.org, tglx@linutronix.de,
 will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 jassisinghbrar@gmail.com, lee@kernel.org, linus.walleij@linaro.org,
 amitk@kernel.org, thara.gopinath@gmail.com, broonie@kernel.org,
 cristian.marussi@arm.com, rui.zhang@intel.com, lukasz.luba@arm.com,
 wim@linux-watchdog.org, linux@roeck-us.net, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-crypto@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org, iommu@lists.linux.dev,
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
 kernel@quicinc.com, quic_psodagud@quicinc.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240828203721.2751904-1-quic_nkela@quicinc.com>
 <20240903220240.2594102-1-quic_nkela@quicinc.com>
 <20240903220240.2594102-13-quic_nkela@quicinc.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240903220240.2594102-13-quic_nkela@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/09/2024 00:02, Nikunj Kela wrote:
> Add compatible for sensors representing support on SA8255p.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
