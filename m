Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5272023ED63
	for <iommu@lists.linux.dev>; Mon, 13 Jan 2025 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736778639; cv=none; b=gN8WL6hWgJFI20bl7X/6RDqNcut6w5PGwn1qCcS+Tb/zTNo3TERJou99zJypMPVtRl0Mes0lr5qv0I3jLjoX2pLH4z/u/KoR4vEQBCj4f9+cpKySUajvV0XpOr4uqGD8M3LYYqI2dA6nNSebhy+KF01BVSnDy8T6v7OnZrE+P9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736778639; c=relaxed/simple;
	bh=yQiQxuwGR8sipxLnE2QpNqD0m337joQm8Mgec26elhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2cQ++gA2do7CsNerW3kC+TY0WCli7mk1+HnL5i1yyDs2Q/31wyD7Mw8YWyWI2I8nzZ+3MxW6o3Kb/OTQRXqtMGn5NaV/VfztbjEQqHrFJordgcOKmZYX5yidUNIBYpS/x/Fgs9xncLsXPm7ebA+GxTx3RznYa2vrbGcmDrV8BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=maL/x2As; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="maL/x2As"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3003c0c43c0so41293561fa.1
        for <iommu@lists.linux.dev>; Mon, 13 Jan 2025 06:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736778635; x=1737383435; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQiQxuwGR8sipxLnE2QpNqD0m337joQm8Mgec26elhM=;
        b=maL/x2AsNteZ4U7y+bpLMqoF1/MtAtb9YZ7k86BLmKntMif8bV1tpg3R/mGy0UNfIF
         TB7xZatpW7u5AWGd2pVcKVQVIEyv6/LHcUI4yP1OtpXxhyd1ADwTjSG0a8yowLPD75Tj
         6UlGRiCiY0xuZ4ZKwlki7RRmJt2p+HbE4i5Urpasxyx2vqJJeHcupGlc7NsIBhFZ3OOX
         p8PmZJ/OveRHcZAgnZc7UL/0kL4PFuAjwpdm3IFtClrFzJbQmH/p+VuUy8LzNd0Zj70b
         uipOGL/VH1WGRMqCVLiAGEJl4kwGARQSurIFpAs2qSOybwmkFcxVkRfdthP94HOap6iT
         8m6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736778635; x=1737383435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQiQxuwGR8sipxLnE2QpNqD0m337joQm8Mgec26elhM=;
        b=S0Ywe3WiiJcYe9i3lJgYcGBoDV/D2q5KhpdzrvOROzZHYc26rJAs2VF733ZiEjPyr2
         teyQnmP5hzElI5N2BYG53NoHUiqblvqCuh24SHh6k2wgtpuDQx6gk0jANg7E8S6Asbpl
         vyAN3xSoeG78XRIqq/Pq/P4oVoRjqCTl+cR9R1Fuo0zXrg5uq94LRTJ+e2KXJ+YazHcD
         tnpTFrliRho6/8ILadwUb0Y4GsFTe87628wLZq+MGzZRHpNhtAVOpX62v3SkL83oSuZm
         9UlqCV3RNAkjrEaWKZcKAMZSB+wtvVVMyiCIZlJ6+/JLPCFvbRANmSO6RYXmH7nBboZP
         ipgA==
X-Forwarded-Encrypted: i=1; AJvYcCVObdo+PoIZVdQfiJL0tN4g03P9hxVABPmAvi5eGhF0iPUd0XduJP8N2dDCJ7FBAOpZx3u0Qg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJyQksiCk0aAfFw63o4WcEy+KyyDH3gx1gF16jYA4yg+0LLl2T
	0C1NePfFIBrohZMNGWztVsuTTaxW8PXpEYd28mvLz4x10lV6N1VeuO41EcfxC1Jbj9PGUQ2Tmvu
	ngBmcszDv186FpNAO71Uz2x8wXVl0A1KMkePQiQ==
X-Gm-Gg: ASbGnct3H8LBYox9xZfmZ+9A+SMcPGFtgloTR0A65b65n4OwOWTGQfydqUTLgWIVi6m
	vVzGWcRAuUFFao41iLGMZEY01iphHH2Fw4Sjp
X-Google-Smtp-Source: AGHT+IGhfOPi0kkaR3fzIiz3zYVKzNITf7WqJXfvCEhBW44RAY34fqtT6fXLyl378DmtnGYFFnV3yeRTPKvHK9wdrxk=
X-Received: by 2002:a05:651c:221f:b0:302:1c90:58e8 with SMTP id
 38308e7fff4ca-3060ce3d06emr30538601fa.33.1736778635404; Mon, 13 Jan 2025
 06:30:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241227-a133-display-support-v1-0-13b52f71fb14@linumiz.com> <20241227-a133-display-support-v1-10-13b52f71fb14@linumiz.com>
In-Reply-To: <20241227-a133-display-support-v1-10-13b52f71fb14@linumiz.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Jan 2025 15:30:24 +0100
X-Gm-Features: AbW1kvZgkONvTczIqxIzrr227mixg_kY6H8hXCa96ZE9JLa4yEIXQA2LwUItM1s
Message-ID: <CACRpkdY29s6Cz3zvtksLO8sESwxhkVdmGUipVAqiEtix3E1=Vw@mail.gmail.com>
Subject: Re: [PATCH 10/22] pinctrl: sunxi: add missed lvds pins for a100/a133
To: Parthiban Nallathambi <parthiban@linumiz.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 27, 2024 at 12:09=E2=80=AFPM Parthiban Nallathambi
<parthiban@linumiz.com> wrote:

> lvds, lcd, dsi all shares the same GPIO D bank and lvds0
> data 3 lines and lvds1 pins are missed, add them.
>
> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>

Nobody seems to have any objections about this patch and it seems
technically correct so I just applied it to the pin control tree.

Yours,
Linus Walleij
