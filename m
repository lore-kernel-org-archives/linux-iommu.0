Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE3629ACC2
	for <iommu@lists.linux.dev>; Thu, 28 Aug 2025 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414797; cv=none; b=QCfXhWXxryZLKFQKwkWBBKLR5OuVQfF5AwqnUHC8I+cnMmrghYSO+6wKOlqgbY5/yHk0tzjDWWRRw2k2DmbOF4G/qnFfHnT+GX2sF9aSpTPU7of9WZrJaH0yWrZICN5IzVpyoNeOVBvg9mA//kUal2eAjg9lbUSjN0dgNdMpFPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414797; c=relaxed/simple;
	bh=vcH+lJXlXkzbWh1s+giYmvp9r3m+hUxJ894v+cf3nQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5JNA7FNWVXu/kfPvebAyCGbKXN1kGNKCwDXZqK8oDFszL1Td/+opPPbEjOdvS6RrbeF1YZGIO5WVSIdQ1s1njxlYeNgo7m47FgRXJfDQP9Winn4zbTndk1Ymxgws/o9Hn7xNG+JOUTpCuoF9br7KR5BZv1Uh25nFoRkgjvPAig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=quqsZ0c0; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="quqsZ0c0"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-336b63d2e56so1217461fa.2
        for <iommu@lists.linux.dev>; Thu, 28 Aug 2025 13:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756414792; x=1757019592; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcH+lJXlXkzbWh1s+giYmvp9r3m+hUxJ894v+cf3nQo=;
        b=quqsZ0c0Rsa3/PZHCxjzNCVMA2a3XpPl7xFVelqzreGXJgsrl9nIvKk2q7sVqfkX/n
         dTgWKoEHCrBPs3/eUx9nctyEWv0hRiblMVdtHUuPqD9wgZzhP0rRmDhEt3IImobur46D
         muXu/XGII0IuujmN5D05Rz6aQwOCYnfyacPni9oqhY19QuL4I6edB+nEMdOhljNl8Kzz
         ogAQy2nJZ3MoTf48ih+xCah1K462manf9vhf8wxVtjJo0FHN19raUhwFiroHVD29Qn0y
         7ybDfYh8uIbBvyzWDxJ3pjnKXyPmnBJo3lTHItfjjocTbnWiCfpUl/rXLv7LVaGHJbMW
         Kzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756414792; x=1757019592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcH+lJXlXkzbWh1s+giYmvp9r3m+hUxJ894v+cf3nQo=;
        b=fTp2IwLedoZfH8XT3yqf6z0BFvKC9ZGtT2bv+PyLBKwPT2/SZJvusK/w6DdwN4/2y+
         GS9Jo2jOlOeA4f2pJWtkgzvtSNkpqTa5bgC3AHSKx0vX0hQNV4/spqqGfc1uBrADkkUC
         elvfSWsrqe9yPWiu5SrKmfgNm7DPTu5pSMaBxd4LOg2B9KV52X3SMG9Q93R9aIki9FU2
         GqlcmVDbgGL6YrFgkRnDDCCFeZtrmdutfz9BA2TwKdrtqCHRjILw1k6psYdT9c/aRbkJ
         jaC/4AFe++jfk1NOgNoiQcxmP2GJ7UXWhXwaOGVCAeqfxBGqBJbA90EI2d7uX3i4RnND
         1TQg==
X-Forwarded-Encrypted: i=1; AJvYcCX8i4yqb9DwhvE4lHj9j9jKM3IpjpoA1ojeRrhYZuOK+Nwgg1psVbndBZpitSvVd2cMpz9iZw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCJC6gXkTGmLRxMOQww85r4Xzj8x3D1XDw431yj59rsmgz6sR1
	8fGmdfO8zkY+9nVs4leq0ShwUVUvdAzaJKdjtw+KBTWVtLqJiWzsjs361N78s/EZKxbLKqkk0dR
	amD+EjjCrF0wykjYuo+Z7YWkw+m3XG8mH0mEeDpXz2Q==
X-Gm-Gg: ASbGncu+mz1aVA0Df/eMO1KGJmHoNsDuo+UNa9gU2qqO9KDq0SOgBJTSCeo3T46xdee
	XECmMj6ty79BNzwiqR4zXRDE9G0YAoUUt6LlEaPgz5s26wCOqME2VBaP+9z9PQIsKOU7fN/LcLW
	Xypy6zcPsv1EpUffo7iBeUoM6PkiPItUOed6SflAD+bpFsS8IKyc7cvMv0bAp1ga9RfLU1Ic7oG
	pofOHM=
X-Google-Smtp-Source: AGHT+IEvCK27Dx3T+NwB4QTV9UIlsAab63smCZ6D7uUks2NtQZowbM82iFbh3N6kvr8t1WPK8CdOU0xtB51L+4ds/dQ=
X-Received: by 2002:a05:651c:3256:10b0:332:3fd0:15fb with SMTP id
 38308e7fff4ca-33650ba8612mr48592831fa.0.1756414792241; Thu, 28 Aug 2025
 13:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net> <20250828-dt-apple-t6020-v1-9-507ba4c4b98e@jannau.net>
In-Reply-To: <20250828-dt-apple-t6020-v1-9-507ba4c4b98e@jannau.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Aug 2025 22:59:41 +0200
X-Gm-Features: Ac12FXyoYnYKNXDomZzl4EdS0dXvIhCV2tkZJGb1B6Y1kaQgUA-l_NpqH411N_c
Message-ID: <CACRpkdbg8KYcDpqDKn9fqs+rL9hLK9mGCj0PTXPBGDW7A_AZbw@mail.gmail.com>
Subject: Re: [PATCH 09/37] dt-bindings: pinctrl: apple,pinctrl: Add
 apple,t6020-pinctrl compatible
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hector Martin <marcan@marcan.st>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sasha Finkelstein <fnkl.kernel@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	van Spriel <arend@broadcom.com>, Lee Jones <lee@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Michael Turquette <mturquette@baylibre.com>, 
	=?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
	Vinod Koul <vkoul@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-bluetooth@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 4:02=E2=80=AFPM Janne Grunau <j@jannau.net> wrote:

> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,pinctrl" anymore [1]. Use
> "apple,t8103-pinctrl" as fallback compatible as it is the SoC the driver
> and bindings were written for.
>
> The M2 Pro/Max/Ultra SoCs use the same pinctrl hardware, so just add its
> per-SoC compatible using the new base as fallback.
>
> [1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@k=
ernel.org/
>
> Signed-off-by: Janne Grunau <j@jannau.net>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
