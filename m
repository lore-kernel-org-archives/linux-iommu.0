Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7227D061
	for <iommu@lists.linux.dev>; Tue, 12 Mar 2024 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710259945; cv=none; b=iTWXtWCrwxi8r0GT893hUUULiSgUIPGGwcxkbUrmr4dle0z5YByAOTQ8u1T7IAgxihwUmDqzwV+p0aB/0TJX02l1+ePni7y/ZLVNdSYQiVsXrdu6PxTDgh9uGjYjJvKtKGGD/hvTtw6y4zMkVqaHi0dg4EcAWfizGflmxFxoeDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710259945; c=relaxed/simple;
	bh=rXaL0LJcdegT3oLCAhYYQ90a8sQqF6H95AJnSTlrKSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPCaFunRrnum9P2EKSMRvqwVQnZ9RuPoXD9GvwII4wapNY/RPC8X/sfCxKG9vbcbo1yHc+ziRvDxtNEhgDsNO0YzkRt9WhNSyHl5lUhqK9ogwnUKchArzmeshHZaAhljVXc400WxHHyOVzO+RVy9VJve/2RW1hPBUMnsK73mXPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CZ377AYg; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CZ377AYg"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513b1e1724bso136656e87.1
        for <iommu@lists.linux.dev>; Tue, 12 Mar 2024 09:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710259942; x=1710864742; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zLG0VkRk9T+MqlwYSwMr85lswH7UeBe9EKEDGZIjNWM=;
        b=CZ377AYgBiCivi2bxQ2WTEcvWWVUEn89hlqno6u7+nXcTfU/06EkdKkKAt4pYtaOXD
         KIsvk8PBskNLo/GGrW5ulVPgpFCRb8noabg0S1/BcVm6NrHqlsP+aej168tMXUzXHe62
         gY+i6vtx4S2EWCUKhYkjWyNf9NmOlxIvqj5mOZ/VLMly8jaSnqHr41BUzileqHWhSLYr
         vMlmVY60UvfF3mGIoOEOHBhtL9slqnCL8nkWih4uDZYydBXzvU0dbZBypRD4HfnHoXIW
         RC/s8KcZ4TQIcjbM3UiRQ1wW+67MeBstgD5vKnyNb2Etnu6aIJcjZjPTVDzsf4urJb9X
         DXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710259942; x=1710864742;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zLG0VkRk9T+MqlwYSwMr85lswH7UeBe9EKEDGZIjNWM=;
        b=Oapy5H6MF6E9/YJnVcW3bPc/VhR9w9nhlbHNyy7NwhZ5U/IsrtwcbLOJVZbmRP3hk6
         NoxsTYr9MksGTrfkWPGQfuXioSHug9BisC84trldJFo4Wqqn8+k0O4og6494XJEBcEA+
         dEJYRl2G/+YK8HtK1beU83ISbvY5QlaIfGJNH9T/B9euXFTtQYOULGK/vNcinONO1XEm
         fO/cbDwqk4UcJJ1jVWEnY5vh3E+1cvOze1rN+1l/DvE6obkOiPmMne9weUi8rubDQOa5
         KePHl6//hg/5JnM96em0ihIDJj1LuIxoaAXq0PqXtu3n3ReDbSJWPUUbCxy+79Umsdox
         IZaw==
X-Forwarded-Encrypted: i=1; AJvYcCW8GP4N+64t+f3xU/cMeDvOHEP7iKVsq3TIWPED5c6dnyAfM/RFIACMTKCtcXMk6rki4QdihgFXalx4D8lfNVYuRlykanU=
X-Gm-Message-State: AOJu0Yxz0PcV6dEFVAltft/IZ6vBuyAmY5padv/dx7+mDHxrG0HLNRF8
	pa44kKeUtXLkvQtYAetX9NNVKkvowqFWWC/amTz9il5Rn6EaglMUgAKQJYnxWuI=
X-Google-Smtp-Source: AGHT+IHFOEHl33gs0on8qTVXiyJ+aHRxksDiQ505Q8fof/YGiXciDjx8sbsbVrPzSuDgBdzksPF1+g==
X-Received: by 2002:ac2:4d0f:0:b0:513:488a:95af with SMTP id r15-20020ac24d0f000000b00513488a95afmr1774lfi.15.1710259942295;
        Tue, 12 Mar 2024 09:12:22 -0700 (PDT)
Received: from [87.246.221.205] (netpanel-87-246-221-205.pol.akademiki.lublin.pl. [87.246.221.205])
        by smtp.gmail.com with ESMTPSA id o5-20020ac24945000000b0051321db6a0dsm1634984lfi.139.2024.03.12.09.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 09:12:21 -0700 (PDT)
Message-ID: <83734790-85c5-446f-b353-f3765cb10d41@linaro.org>
Date: Tue, 12 Mar 2024 17:12:19 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] clk: qcom: clk-alpha-pll: Add HUAYRA_2290 support
Content-Language: en-US
To: Trilok Soni <quic_tsoni@quicinc.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20240219-topic-rb1_gpu-v2-0-2d3d6a0db040@linaro.org>
 <20240219-topic-rb1_gpu-v2-2-2d3d6a0db040@linaro.org>
 <605d9e50-d61b-b0ce-1664-00554ba70b41@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <605d9e50-d61b-b0ce-1664-00554ba70b41@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/23/24 23:48, Trilok Soni wrote:
> On 2/23/2024 1:21 PM, Konrad Dybcio wrote:
>> +	/* Wait 50us for PLL_LOCK_DET bit to go high */
>> +	usleep_range(50, 55);
>> +
>> +	/* Enable PLL output */
>> +	regmap_update_bits(regmap, PLL_MODE(pll), PLL_OUTCTRL, PLL_OUTCTRL);
>> +}
>> +EXPORT_SYMBOL(clk_huayra_2290_pll_configure);
> 
> Please use EXPORT_SYMBOL_GPL.

Sure, I glanced over this!

I've also noticed that it's a very common oversight.. would you be
interested in extending scripts/checkpatch.pl to suggest the _GPL
variant?

Konrad
