Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6DF20DD46
	for <iommu@lists.linux.dev>; Fri, 21 Feb 2025 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143199; cv=none; b=KhB2JtOzLCG4P9NCBxYGFxBE4xCxTgUA7THRAXjW4Wo6/iO+pg/rBtfC9HYBDTzgcBCO/LNx0/KgXo4hYzpZrTAlJhr2cpVvt3jROrX1Okr1OTHyUnty7soM1TEuQIZ4eCZC2j+7eUFBFEq3SIem5ofF627gCVKVOBKhbDHAmxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143199; c=relaxed/simple;
	bh=GY4Bqjj3jHuhIZ/yUC1V1L2T+Ec/puqWZDF72o9O3bU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNfWIUuEdK9Ey051eXLnM1iYHmlZ4wFwKvm5PYkn6IHnneBUyhLEOLZKeSsKzOCh2CPed/6Iu7Wznu4doXVkdjb1gYueCZQ0TUTN0Uxc4MhjG7mLkRXe8vBr5ugy2OxGQlZH9jLplTq9HpG6qlG3Gp1kHsMLroQWTQoClYPInWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qXtHfrs0; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qXtHfrs0"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5452ed5b5b2so2135362e87.0
        for <iommu@lists.linux.dev>; Fri, 21 Feb 2025 05:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740143195; x=1740747995; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GY4Bqjj3jHuhIZ/yUC1V1L2T+Ec/puqWZDF72o9O3bU=;
        b=qXtHfrs05o5QlP0k0i06XHcGy1WCuonslR9GlYDl37iEwhnobTPc6xFZlb+gtK0ueK
         c6Jx2RB4xeG2WP/REFHt+TzfeU+R0Uh3xb2fahSUgfQtpWd4P1gyKNKDvlddOFivG5aw
         dq/X1jxDDUbYiwX3sV4jsejN9yropu/wBo16DEmyaTkU0lWNJM53TGGgQiN6pV/UqnEf
         +eECjaJ2Fg4XAFZrTRagP4N/JArb1C+sNyGGGzsnVGSFZ6Wh/4R+Xt1XcWvUwTJEMppQ
         HUc9GF7zzpnFFeQyba6Gv2/65XOj9Qmsl61E1HlaP3GjIGGMODnk+7EbctKrexkjWRhY
         9zYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740143195; x=1740747995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GY4Bqjj3jHuhIZ/yUC1V1L2T+Ec/puqWZDF72o9O3bU=;
        b=AFws8sm9YzgnDUmYGjA168kPhw3lDHIVStx0hqB0nN1FFarIiq0ChJ2iVviFMl8Jb9
         QD0PoEkBiW7MS0FNY72qt2cmwqn23hpQBDN1xLlZdyS+TUm2CuRV0tb7nWwUGGjn+SKW
         2TNUu7xIRrnwheX1c0a1wKMXLu+LCpN2rjx1KRwTh/OdpE95vsRWFaDvWbMB0/BOxYIf
         lMpexu6tW2tq0w7Z94MwRyXIzQKm97SvS2ZSrvYifgdG8XxyclR9arXYIUYnmY/y5uIx
         H5l8a2r9D9EYngpq8Izdct5ZCBldtFbnZRS1RfcxrQhNb0/Xclfb3+IRVeD422RAlHTa
         8zgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvUR1GMo1CA039++shc775faeFahRfDNo14G5tE0FoY2Ss8wKh+Ca4wINY8VHP414yOBZZoA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtthE/76UEA8+inlTaAoMbFxnD3f++8jqgWxvmM4jOBsJfGviF
	F2KW6L9D4qM4jqdT0bdAbR7baeD0u6VETWbyop/x4SwNyCdFE9RqCTV0JxYOOWTqi4H6c6RKnu0
	DjzWM5EaNnxPX5b0epEAmjiSX73zK3gzN0jobqg==
X-Gm-Gg: ASbGnctcawrCip2gxYiNNusTThaeT6XIsfYX7/WZCYXGx9mLNNvy9h00QBgveNVHNfz
	bSKf+R2GvrWSnqAOeJcFiT6nNpTWHyLHhFzgDUwNJ1KzKLppGFMjMbIXwBPZXKvJEUh2XW13z5E
	5cp61K+E0QHkv4Rkl/97n5QG81A+tLdqj+mj87ZtQ=
X-Google-Smtp-Source: AGHT+IGvF+qVoZb/YNG1V1s6uhLH0tipo14kcVPCZjvopoT6AHOJ53n961FIS1cHHYi7UkY/30eVAcyuJ5RU22yTz1g=
X-Received: by 2002:a05:6512:230a:b0:545:17b:3cf9 with SMTP id
 2adb3069b0e04-54838f5c910mr1152614e87.48.1740143195091; Fri, 21 Feb 2025
 05:06:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250221-rmv_return-v1-0-cc8dff275827@quicinc.com> <20250221-rmv_return-v1-13-cc8dff275827@quicinc.com>
In-Reply-To: <20250221-rmv_return-v1-13-cc8dff275827@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 21 Feb 2025 14:06:23 +0100
X-Gm-Features: AWEUYZkXE5OFXjjPS11KVvHprrUdePtYS343T04IUIfa13H27L0Aw2Tb2OnslNQ
Message-ID: <CAMRc=McG2xLUcE_yHq4MiFnm665riHHuHjk0GJE4cFV_gGU90Q@mail.gmail.com>
Subject: Re: [PATCH *-next 13/18] gpiolib: Remove needless return in two void APIs
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Lee Jones <lee@kernel.org>, Thomas Graf <tgraf@suug.ch>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Zijun Hu <zijun_hu@icloud.com>, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 2:02=E2=80=AFPM Zijun Hu <quic_zijuhu@quicinc.com> =
wrote:
>
> Remove needless 'return' in the following void APIs:
>
> gpio_set_value_cansleep()
> gpio_set_value()
>
> Since both the API and callee involved are void functions.
>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---

That would normally make sense but we're getting that reworked[1] in
this very cycle so please drop this patch from your series.

Bart

[1] https://lore.kernel.org/linux-gpio/20250220-gpio-set-retval-v2-0-bc4cfd=
38dae3@linaro.org/
