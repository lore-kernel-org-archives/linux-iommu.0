Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940832586C2;
	Thu, 28 Aug 2025 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756397517; cv=none; b=gJwPtxuyVwQNbD/6uIiYx7xmluDTArI/s6QW7ofUV4C1EO3ncrgoORqW9hT2yjnLCkJ1L+VjFYSG+wS8/FHIoW7fTe/vahqys5Wrrbuzek+zdN9dttr4YEJWNCva3q7jw54juqytEyvUzubgTRNvP7Eu+m5y1FIKTU/kIV7YTq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756397517; c=relaxed/simple;
	bh=VCgz87AQbD+NIqYtaGv4MfNGpvxEv3mxEjPpigap2YI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bq5CRNr1krFOAa8cDVhG2GoC4yRxLv31Yjzxu+sFhsvtyMgd09NOUPC2z5Ck60jGJyTHcWoC/T9lXo5qu4l21uxQon4FxEPZ1VkB8ORFOnKTUAR8PNHdIUSdIG8MoJman7pI7ko9InnZ74VqR5g7sIDoo4y08bOfq7MifsMICCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zv5fglCF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zv5fglCF"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2487a60d649so13492035ad.2;
        Thu, 28 Aug 2025 09:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756397516; x=1757002316; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VCgz87AQbD+NIqYtaGv4MfNGpvxEv3mxEjPpigap2YI=;
        b=Zv5fglCF3kXdpcRwv+MrgXVYvpITWuctOPnomp0RLZhafnAX3ErIPZiz0JeCv8sH+B
         1plzAnvjVLpMdSsh4wvXRNK3KiLzZ/6WhfrEPmKIJvU5MuUxBVGlE8x3p5l3tBkh915r
         Qcbe+JT4qBCguUJxKJSjeVGCWnZOmyUNNLrgYHKq4rNWNmBKkzJ7E3hOenngXbIQIVqC
         0jJ27RD6Owo0g4f79UwWpBCGYspXIDPbZjRCewSRi7NdWw/pCHwL6+ej4rIgnMP1PDiF
         CcLJltkg3T8P0cTxQ1RHij99c0sGUACtjlM9cs9yJdl2tJpKYT9AXZO8CoRXz2AmmAEI
         g0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756397516; x=1757002316;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VCgz87AQbD+NIqYtaGv4MfNGpvxEv3mxEjPpigap2YI=;
        b=vdPh9pxkS60oqBKyu8DojJpMQ5fY1DL7PRSKrRIVwa+dbb82C/5P0L788cLwNcu0Ze
         WNjwM0u4duuyTzWVxkTEDleZ4ykJ5bQJxfZMOuwuSvX1nLMyGhlW5UeDfpP5dQedGHZI
         b+g3LNMlTRgKLskojS7NtBCqOpaxUi8hGAvgnM8U4uot6yHVudwladVLM6aZtonNqvST
         3JaKamPW6eGz4V76//XC3rTnIuEVOikKnWRQVn5KK88Cs86S3G5yp7WgaGs1cG0CSaG+
         QdLiUBP6/TX4IpkTnu+yNfl6mJulV45pqEB2YlhySIFlt94rRi2FrwdZA5MQm97TFYrw
         J8ag==
X-Forwarded-Encrypted: i=1; AJvYcCVZ4z8mHxzlNqAh0McQ6pzEQifIwxzPpzlCCai/nz4X6FRkwbqnJ6AaICitHBj7mqWkx7bdnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxb4wo5rSCMuzsfTnWyuKzYwey8zdycddA3TsjnL9/6NYZ6x0BX
	5v2RYGOHqaQ6GqgXLRqEtrYom+gaCJO3nvJo1QXtNGjCnzfOdnaUFpDw
X-Gm-Gg: ASbGncuLrI4HAdo4LCDESMtS/hI6sX4HUzqsYGid+0gEPRwvObEwX7iGcQaliMzpSNd
	nU24yLN8+iNj/1H2DeI/4e8oqSgeirmu7sWyE1QSr6DKPbt3MHJHqopaBatuG0BzR0DMBckWWyh
	RdHH7+CCJxuTKQMEq9u1qQic/YeW8KXm91GI7csdQNKAfkfkzXrTdo2OKFAcu+++OCdNuI8/Vmc
	1bs8MR2GNfwLG9LyzpUIybml5+DcLzFjiVEmJU5wsOm9LGz8Ni7bw4Y1VHUagkhmEww5t+DpNGY
	E1wOxcTRFgYlCDFWjOt2w5cUnRmRO56RE7SNbVomukt/ba20wH3YyW/mbozYfMVx1NF6qGv7db+
	6C/39ya4EArdiL8r7WSJNartS8mrpdsByKb+oRYuZFvD6Os5Fj/a5bVyPV7Ct3BAj
X-Google-Smtp-Source: AGHT+IEelSOuEo8Npbahj3GwLi0XEymTTpHMsSHpMsvQzhvD7rxDhVw5w3VB77ZuaLmwNpmmTqLyYw==
X-Received: by 2002:a17:903:19ec:b0:248:9e56:e806 with SMTP id d9443c01a7336-2489e56ea30mr87843455ad.12.1756397515676;
        Thu, 28 Aug 2025 09:11:55 -0700 (PDT)
Received: from [192.168.1.111] ([59.188.211.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248a63b5916sm45971445ad.52.2025.08.28.09.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 09:11:55 -0700 (PDT)
Message-ID: <932e0085-c901-40f8-b0d5-67f8f0b934e6@gmail.com>
Date: Fri, 29 Aug 2025 00:11:40 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/37] arm64: Add initial device trees for Apple M2
 Pro/Max/Ultra devices
To: Janne Grunau <j@jannau.net>, Sven Peter <sven@kernel.org>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner
 <tglx@linutronix.de>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sasha Finkelstein <fnkl.kernel@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>, van Spriel <arend@broadcom.com>,
 Lee Jones <lee@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Michael Turquette <mturquette@baylibre.com>,
 =?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
 Vinod Koul <vkoul@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, iommu@lists.linux.dev, linux-gpio@vger.kernel.org,
 linux-i2c@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-clk@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net>
Content-Language: en-US
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Janne Grunau 於 2025/8/28 晚上10:01 寫道:
> This series adds device trees for Apple's M2 Pro, Max and Ultra based
> devices. The M2 Pro (t6020), M2 Max (t6021) and M2 Ultra (t6022) SoCs
> follow design of the t600x family so copy the structure of SoC *.dtsi
> files.
[...]
> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatibles anymore [1]. Instead either the first
> compatible SoC or t8103 is used as fallback compatible supported by the
> drivers. t8103 is used as default since most drivers and bindings were
> initially written for M1 based devices.
>
> The series adds those fallback compatibles to drivers where necessary,
> annotates the SoC lists for generic compatibles as "do not extend" and
> adds t6020 per-SoC compatibles.

The series is inconsistent about the use of generic fallback compatibles.

"apple,aic2", "apple,s5l-fpwm", "apple,asc-mailbox-v4" is still used.


[...]

Best regards,
Nick Chan
