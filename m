Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0B8204570
	for <iommu@lists.linux.dev>; Mon, 16 Dec 2024 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348504; cv=none; b=d7qomctyk2X0uy6nkvZq/lx+00YdofpF0BuqskpR2FJtqGlFmCoehp7rtdZkmDRtrCioEA+FmOtsxs/hx+hs69h/jH3sEUwQYaHcgAPjIQImkmPx9UxJWmTVjha8Og5Co/dW2DbBS1+A753DGyeshVwlR7Q1bUMkyT/MAfnBH/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348504; c=relaxed/simple;
	bh=nXUDKm1xa9BISvUfDdmposybSRYZG//aVztUGmzTPWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nk5ZfONP3+aOpo9ctZ0swJAKRd1FhNChSDiXksf21wEhmytqpz/f1WySXr4FRIvPWfjS5yx9snEVAjW1MFi0L5CnEAq8wvosdHGiKMIAtSVynPSUULjbtIRcxNKpCOoC6eA1NU4NAJlDYFOrcyCmqaZBV6tYHQ4HqzVgiCiKzgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FmNwuaCa; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FmNwuaCa"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53e399e3310so4795476e87.1
        for <iommu@lists.linux.dev>; Mon, 16 Dec 2024 03:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734348500; x=1734953300; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sSbdGX91gG90sHx6RuV31TaU8DxtCwQolrhH6++8Lks=;
        b=FmNwuaCagMVmIH3JaBb9xX5BGDbNAfMoJNgowZXUGefqKm/9ZplwqmKCn+L5VK4m70
         EBO3RCbuiB49za55rt1PD1Nhxxgkd13aC1iNPqAyTYB6RApzWJvl5RveePAAcY+PQsE1
         kXYcNB/drxh6D/RdrKjtOWTUoiaKayQD6QufDLJyQlU9K/LKUpe/SmuCH9VeOeR88xIa
         PAIyHn89Y8UeIlYCrb+P71K2IAD4IgAEn4F5aBNE5HiUZ8+pIK9jIgPcVaTSlzin0qD+
         EQqKQjdRsjZdKFmiAjILZhYfcUWjg1DN2WqI4winzzAXmjBYJ3I44g/zMeXhkhkJsKO/
         XzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734348500; x=1734953300;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sSbdGX91gG90sHx6RuV31TaU8DxtCwQolrhH6++8Lks=;
        b=wDyDI7ndEy6wwSUl+TTTNVBwQtpprgdhjeihtna+Rp1BlmynE2TVeLqKfPnExd99f7
         XJOdwyS0KRzR8OGYlhjcWoZGzRGLOlR8x/UJ/+dJd8BsA0DIsRIhSStB4EZy5YVvlbZ1
         qBQfzkWZfxj8+Al5J/P0ENJEUs2L1nJkZYWvQd0MHewtKJ5Q+KweZB1z9dw4jyN6MW8D
         s/ndwBmGSzOJiIo/7GX/hVaUbo6ItaPZW/JjQz4RpyVLfcio+Knu3KMLp/2k6RaXMcVw
         6AUmeOqsHNytuBP/RKjDbTMXqivf7vQZaWH5uphsp35565fuHiSAGxhJWYrqwPnPJfm6
         U84w==
X-Forwarded-Encrypted: i=1; AJvYcCUcJ9MZBoq1NYLe5ZcNohfseFKv5I0VT8YjHgX3kNnmyTXFhe9YHAjhHJjyMRYdzpIKDC7lbg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNLhVgWZZtxYjc4KN895jCN3tqmJ/+QBwe3DeuqTmJgygkaMOz
	OaCJVRqduOE05z09/3krqPq4pjccwSMHcpBiJvavER2RP8xvTch4NGKAoMMeBIU=
X-Gm-Gg: ASbGncsp8DuOr4E4QqDqIlzei7+U7Fw7NJRGB1fzefwixu30Ppaeb1dNgBaqygGS0mk
	7XgRl87dDBee1p2w8MYxQbBmMIqpDRvU2lzw34V8t1Ztca/ziHyPn0T+LevHnRDtMrOQb0sYHVb
	XTGrr0AJM8w34FqjsgxEkA94ls4UIyBwEeUk3Nxjx7LGjv/T+u1yd1haLrJ6TpuH+yTNjutFtGy
	oyH18ER+qR5nUoxofH4dwGmA+pXFa3nXWVpiyF2+bYjDsqfPMiDyRJx3WggT7PhM2LbnUHRSDQN
	vMeWdKrnM0/C95GZCH2GP0MC4BmzYkbYaH3e
X-Google-Smtp-Source: AGHT+IEbEsjwcnz1TK8W1eXH/0K0D9rb1zgZUMvmHY65rVYyO7hxDT25NbhReV0v+nMszyiwBrmq0Q==
X-Received: by 2002:a05:6512:e89:b0:540:5253:9666 with SMTP id 2adb3069b0e04-540905a7063mr3620892e87.46.1734348499739;
        Mon, 16 Dec 2024 03:28:19 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120ba9e02sm812506e87.100.2024.12.16.03.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 03:28:18 -0800 (PST)
Date: Mon, 16 Dec 2024 13:28:16 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	Dang Huynh <danct12@riseup.net>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Otto =?utf-8?Q?Pfl=C3=BCger?= <otto.pflueger@abscue.de>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v9 0/8] Add MSM8917/PM8937/Redmi 5A
Message-ID: <vfwisdkjg3czwesi6yqaznvxcz2z5ksqezhsh6ytrc2g2ypszy@wqkr5cgr26vq>
References: <20241215-msm8917-v9-0-bacaa26f3eef@mainlining.org>
 <CACRpkdZ-ZEiGMUPObHU=kw=OUADrRGtxgMc-QC3EaBevp-Shng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZ-ZEiGMUPObHU=kw=OUADrRGtxgMc-QC3EaBevp-Shng@mail.gmail.com>

On Mon, Dec 16, 2024 at 11:33:30AM +0100, Linus Walleij wrote:
> On Sun, Dec 15, 2024 at 12:15 PM Barnabás Czémán
> <barnabas.czeman@mainlining.org> wrote:
> 
> > This patch series add support for MSM8917 soc with PM8937 and
> > Xiaomi Redmi 5A (riva).
> >
> > Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> (...)
> >       dt-bindings: pinctrl: qcom: Add MSM8917 pinctrl
> (...)
> >       pinctrl: qcom: Add MSM8917 tlmm pinctrl driver
> 
> Is it possible for me to apply these two patches in isolation?

I think so. They have no external dependencies.

> 
> I want to make sure the patches get moving.
> 
> Yours,
> Linus Walleij

-- 
With best wishes
Dmitry
