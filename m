Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA21241673
	for <iommu@lists.linux.dev>; Thu, 19 Jun 2025 05:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750311356; cv=none; b=nJRfqGjYl1V6i7xK5dvLF+i9SiucP85EAsbqz7AjVu+SsgWNAnV5qPb467aEyTwfy3vHNU8p764nfyNCspdJPmGDL7U9fxvej7RKUDXONg4ESM9+a/o3joVcNUPMzWmQ4UjOGu/uG7jMXCRjQzQvDBUQcck35YnZjOWTwsUtcQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750311356; c=relaxed/simple;
	bh=3T6kJuyoKBc2nft91aab5hLZW+0/3OZRvkSZlEz+xsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpXBnKS9Gh++RrhX+4xAuUNcPDhfVB/cdepqJPD9+B2GUvsEugECb8o1z1xmCum0zQ+VcfD2pZYjgN5w9PRt6f3VpMuHK/w6GDfsJCazaBO71CVqTy1XYnI6QaYpEqt9+U9dCF5nYwiA/USpFJDhBzMcxV6tAH5Z6nWQVxaDkNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mP4D0dyi; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mP4D0dyi"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2349f096605so6641125ad.3
        for <iommu@lists.linux.dev>; Wed, 18 Jun 2025 22:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750311353; x=1750916153; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MbKgKaSzJXcq3MoycGVCSzlp40V4lZ1OfWmFaWrV5lE=;
        b=mP4D0dyiagouOfPU2UG+CNq9axlLn8PBYRtL86+PDIOwa4vn8VUnM1kcfarOtw4hvO
         cAlN0lRrt7XmAK36PL0OlygQWqdsge/0n8r7wWewAYaaggknGep1l5DElUPMmF7dsC6b
         rPPWGESG8X0shCtxqU6dH7zbER7zkPYLus8h3UfKvHG5Cpr4SNs7Ij5Bq0ziFOKIVM2n
         VqTI/9xkG65oAsoGoATOU6DP/AAnlQ5dTbj9WcaO6Q29Bh75Opm1g019lkotLw6w+v0x
         hXI4AoDmVqAHprPI20LAhakcb348mCC3eeakJuuMCjOiAiYQPAoIyHZiqodznHq/Q+ds
         Oy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750311353; x=1750916153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbKgKaSzJXcq3MoycGVCSzlp40V4lZ1OfWmFaWrV5lE=;
        b=Un4WbanoOcmH/c4tkEFpfX3rOtcy9nPOzqYgQ8/D3wr+0Hizxcwhqayd1LaHO/gGfZ
         +ds1HkkYL30szuJ/qKfpF/lU9EQCnvNsR6S3I5lU/vU7DnqqKt7CvuJSUneI1CydNdhO
         H9rQ2YyjTu/04+QEgMxjSVmyqpLRSM4dpkZFKAy31SI/0VyPk8KHF0UJUK1L6pBAUtdK
         HJvmUhR1+zUbqEsWrS67tzeLNkS9Fx5LPWoqmn1wDoma5BbSjr1d8RNgmkH+YOzzXZSL
         7y3CDOZkA/Og/p35TI9mVxfpgb3nVG+lsM1GHjtHoWpMS0sIFilhBV9OjQ7IKD4IK/av
         TOfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKizavv226sCYI4Zwyf6sC+Mt53dGVl5MzDqhzVpIirXLoz7VIuS1yc39ZEPtp0ZHu8rOlmw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+a/uuaPkUwQejK6WjF485gXgF1Y1unZFGAte/Wyx2dbaf9r2f
	bZZyIki0/Z5vPM/FGnFtQPvT2M2tc4A7PnQMsDs76IBC2tLcOsflFIzaef+7t7BS9WU=
X-Gm-Gg: ASbGncvm1NClZzhIaqPw/Fatb0MhIISIF2YXsc7+enc3TxIBUBzmy7VC44ZUtq2iTGb
	weKF1NxuIHdb1/S3U2TfM7jmnsp6PrpoP442sSJtrClYAw275mtY5qvrEoKTZguzx6qT5U5tFE0
	3w5NlfVt77UkGIartbiRF94squ8/JewcLzUYwV863beNgZ0WfcGDdNfTFlqMjFum8aoheBZLRGe
	oCZrOVKPHqOuS/T7bzmT2NU7ykJsneRAQ/3V4H0Kr/iiQja4O1fdn+YUSAegaz6vFXzGboAIZpF
	OXXmEzbNp/DTDZx/yt0DVIa08Ias3K6aR6f6kz8fmv1q4H+NhdldAL7L5YHP3yX/gYgvEx6wsQ=
	=
X-Google-Smtp-Source: AGHT+IF1Brl2Ml/RhPp1ZISh/ybbgy1I/Aosv1oeoYbA3EE1IVQw9sjB8PhoTnTOzWYQtjW2ZHuZqQ==
X-Received: by 2002:a17:903:32c9:b0:235:a9b:21e7 with SMTP id d9443c01a7336-2366b3df793mr286985355ad.48.1750311353385;
        Wed, 18 Jun 2025 22:35:53 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88c0c9sm112008655ad.20.2025.06.18.22.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 22:35:52 -0700 (PDT)
Date: Thu, 19 Jun 2025 11:05:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sven Peter <sven@kernel.org>
Cc: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Ulf Hansson <ulf.hansson@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
	iommu@lists.linux.dev, linux-input@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 06/11] cpufreq: apple: drop default ARCH_APPLE in Kconfig
Message-ID: <20250619053550.hogoo7ic5igvex3c@vireshk-i7>
References: <20250612-apple-kconfig-defconfig-v1-0-0e6f9cb512c1@kernel.org>
 <20250612-apple-kconfig-defconfig-v1-6-0e6f9cb512c1@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612-apple-kconfig-defconfig-v1-6-0e6f9cb512c1@kernel.org>

On 12-06-25, 21:11, Sven Peter wrote:
> When the first driver for Apple Silicon was upstreamed we accidentally
> included `default ARCH_APPLE` in its Kconfig which then spread to almost
> every subsequent driver. As soon as ARCH_APPLE is set to y this will
> pull in many drivers as built-ins which is not what we want.
> Thus, drop `default ARCH_APPLE` from Kconfig.
> 
> Signed-off-by: Sven Peter <sven@kernel.org>
> ---
>  drivers/cpufreq/Kconfig.arm | 1 -
>  1 file changed, 1 deletion(-)

Applied. Thanks.

-- 
viresh
