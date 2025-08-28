Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EDB22A7F9;
	Thu, 28 Aug 2025 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756401546; cv=none; b=Q1JfraElwpsi9x/duU64kU+sYHXO8BSyvMCIhIuOkDBAILRAWAmF8UddA2zCWDjnno/2KAQdPjqofDAid4msBEDy4wNN9q1YyaqIs8na7S5il2LOeh+2hBPMuS/t1/ijjSRX+2P7W6hB7pWVPLYWfkek7dzxMNUL5ONy3T0PGmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756401546; c=relaxed/simple;
	bh=SS4pv8uyaXLZEUMjbC2GJgsLUt5PP91S4SC3iNr8JIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iiddvf3EIHd5vF6ZfJeFTsCwNiDJOVgTZukqGoieHxzZR8QWk7KMf4WMw41M8f+4Tj03nRAyFhMZhYYrGNd+VmRiHmoUTUuZKYVeqzX865b7ZKoEcRdDmZRwzQ7ICka4bxi/mFkoX/QohAE7G6HtESs+dcXT+IO8IBZCxy7ZIKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrfoDINR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrfoDINR"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-248ff5cabe0so1866195ad.0;
        Thu, 28 Aug 2025 10:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756401544; x=1757006344; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SS4pv8uyaXLZEUMjbC2GJgsLUt5PP91S4SC3iNr8JIE=;
        b=BrfoDINRwpsl18PQ7xXjC5Cc1YmnSmalFXEWkIMk8MQ8BKi2dh1oO3oue29tv+RSwk
         dGunsmSVD/KV9+W4YTmUzfPDWiX2CXbnIgGW79NGgps+Q/0znBVTdHHsPnidWLG4ejia
         BJC7LBibNwbRBsrFCQiVCoQgaYVe5ZvtGtdFvLxIRexKpeA3o2jmQHwEDt1HGJbFDvaI
         2sf19CGx1Fm+dVafKFIIoRoPPibwjqhXcycNtprTzGPqEWs7ZVGJcSVOCwgJRa06huOg
         fowhdlw9zkm5tYxNcbhDW3raQFsNEIHdj8jph1cf3Ytx+PBLxpmjKlX7h1FP94mVXyTr
         wYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756401544; x=1757006344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SS4pv8uyaXLZEUMjbC2GJgsLUt5PP91S4SC3iNr8JIE=;
        b=P8gGRJjw6U0lJ6r45Pw/6aliAE1vARhm4/9My6ntIZnQbRY1igSWdCk8C/y4+yZ9QJ
         f+bIjys+P6fJwT6NBwKQuyTP9tDnQgYQyiHd6sMtXL1c7Zjkjma7Vou692Fe37hCFWkI
         pChnJQGBqj4Pa3XC7my9MZTumoAORUVcofaopVvj5qgk0+GFxKtX2F5i+w7MS+kyXXWv
         lVFTqUW9OJsL0EPsH/2MfIbVaRrAxxXURSriI4fHB5x/RQLRMVMGQKfgR8ydG6DPhYDE
         ZjtPgz7IBZR8QzCTNXRFbDF6T5Ao5NYuxVCvfDTcenwNjI4sn9Qtb89IeGh4EUJEOSE6
         txSw==
X-Forwarded-Encrypted: i=1; AJvYcCVLX7kDT2mBm5MmQXe4oT6Dg/f62+nFHT3TV5AtdKRhFdJtoSmRR1FP/m5f2pQ846T6Rnh85jg=@lists.linux.dev, AJvYcCVYWzwCaMLPzGgZp4pjNArkvjh8wbGD2+eNPIK2h5TvsVE1LINuTWMc2TFmKWOs96I7pOuVqg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yykeg4LrOdMibo4TiuRjVNMILdQbErPmrTiH0CMXkfcTAukOYKt
	SWcdwnGtB0F6ra5aIUoOQHP6DhOLgrz3/YCB6VKhdRfzNbXVFEYgbP4+
X-Gm-Gg: ASbGncsc94wkdfZI60OO8TO0KJvmRTP2hTApkHWKsfiXwQicdhKuzPWua1GlLILwMRM
	xoP7HXUsZfUHVsl0rKAa35Uxyp6gMu2G4UQEUsfnrWQ2duT9m+efOg2PCF/dt0kHeisF22PmZTf
	fpsqpWiA0VfsWt34IIzidplhfCwlaYaOjQaGktw31hBAnlSFC6+2Bi668FGXNLrwD+Zhqh5fc+L
	AYxvtEntWfSj/aqWKmlFmFAbqRdBV+yKYNU4AJXO4fn8LPrtK8jkLDjXCd0hWtxIhixBlBrfMYZ
	OjqGrEZKY3OYwl+1+fY+8rWY5QEWHDtOWyAf6cho2tiszktB3mnoJckT0sawgxKlxkxJDxvXOlC
	Hds8DCNA/21Tn1QkKhA7kdKPbgRHS6G3dsls9uRkHhBPv5+OeTOBE/Q==
X-Google-Smtp-Source: AGHT+IFPj3GBG1tXe0w52JDhOrrrStWKIT6zs8hpAEsM8UEVZqo8QCtKE2lg8olsPKFlf0oBzRgObQ==
X-Received: by 2002:a17:903:2391:b0:249:308:353 with SMTP id d9443c01a7336-2490308048fmr5489935ad.41.1756401543466;
        Thu, 28 Aug 2025 10:19:03 -0700 (PDT)
Received: from [192.168.1.111] ([59.188.211.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da2f20sm739185ad.82.2025.08.28.10.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 10:19:02 -0700 (PDT)
Message-ID: <86ab9bd4-9a4f-4ae9-930f-5fb9ef69c963@gmail.com>
Date: Fri, 29 Aug 2025 01:18:47 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/37] arm64: Add initial device trees for Apple M2
 Pro/Max/Ultra devices
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
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
 Takashi Iwai <tiwai@suse.com>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 iommu@lists.linux.dev, linux-gpio@vger.kernel.org,
 linux-i2c@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-clk@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net>
 <932e0085-c901-40f8-b0d5-67f8f0b934e6@gmail.com>
 <20250828165012.GC204299@robin.jannau.net>
Content-Language: en-US
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20250828165012.GC204299@robin.jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Janne Grunau 於 2025/8/29 凌晨12:50 寫道:
> On Fri, Aug 29, 2025 at 12:11:40AM +0800, Nick Chan wrote:
>> Janne Grunau 於 2025/8/28 晚上10:01 寫道:
>>> This series adds device trees for Apple's M2 Pro, Max and Ultra based
>>> devices. The M2 Pro (t6020), M2 Max (t6021) and M2 Ultra (t6022) SoCs
>>> follow design of the t600x family so copy the structure of SoC *.dtsi
>>> files.
>> [...]
>>> After discussion with the devicetree maintainers we agreed to not extend
>>> lists with the generic compatibles anymore [1]. Instead either the first
>>> compatible SoC or t8103 is used as fallback compatible supported by the
>>> drivers. t8103 is used as default since most drivers and bindings were
>>> initially written for M1 based devices.
>>>
>>> The series adds those fallback compatibles to drivers where necessary,
>>> annotates the SoC lists for generic compatibles as "do not extend" and
>>> adds t6020 per-SoC compatibles.
>> The series is inconsistent about the use of generic fallback compatibles.
>>
>> "apple,aic2", "apple,s5l-fpwm", "apple,asc-mailbox-v4" is still used.
> Those are less generic than say "apple,spi". For "apple,aic2" especially
> it's clear which SoCs use it and the set is closed (ignoring iphone SoCs
> which very likely will never run linux). For the interrupt controller
> the fallout of not using the "apple,aic2" is larger since even m1n1
> expect that. irq driver is special in so far as it requires more than
> adding a compatible.
> I think "apple,s5l-fpwm" and "apple,asc-mailbox-v4" are specific enough
> and describe simple hardware so the will not cause issues unlike the
> complex firmware based "apple,nvme-ans2".

All of these compatibles has around the same specificity as "apple,nvme-ans2" which is
a mistake of using A11's version (ans2) to describe the M1 nvme (ans3). Though I do agree
"apple,asc-mailbox-v4", "apple,s5l-fpwm" and "apple,aic2" should be fine compatibility-wise.

Although AIC2 compatible should be fine that may not hold for later versions since Linux's
AIC driver is actually AIC + core complex FIQ stuff, so when you do add newer AICs it is
probably better to use SoC-specific compatible there.

>
> Janne
>
Best regards,
Nick Chan
