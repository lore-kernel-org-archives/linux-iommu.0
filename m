Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26DB2F9C2D
	for <iommu@lists.linux.dev>; Fri, 24 Oct 2025 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292584; cv=none; b=G7Q4CIdBlwDnksLf2Z4YrvkMhBnF2GptjLpPRVuIbdZT97AV48GtLBCL6EPS3h74Rrg+TK+jthIeM0xpJAf7swLkVYCwwPb90TkOHaINZlOOuIWvWkoBpchb61HSX1ndo2+I5zTNfVmd3CU9RF/Q31cUQICPgIgBtSarokVdP8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292584; c=relaxed/simple;
	bh=nxy0zWX1h247nPbsMpYtj4rqvQKsZpsdIsqOdaa3i18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwO27n5ZyxEji8ugZUy2t8CcIcSexEN52SPne8Z4mNGP14PKuvjauXrCfT87wQidZX26fNpglGwAb8dHdLqQT/IHcwEkUkoghopJOpjeJStvkN1JAHdM/MWB81h4NghXdpo46cqQ8UNJ6u57n3Vq9BltNV88UZYOuzsRFPDnAAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=kvTncIBX; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="kvTncIBX"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-592f22b1e49so1559699e87.0
        for <iommu@lists.linux.dev>; Fri, 24 Oct 2025 00:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761292579; x=1761897379; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxy0zWX1h247nPbsMpYtj4rqvQKsZpsdIsqOdaa3i18=;
        b=kvTncIBXfvcSoJl2ccrUDu1m5NxbVCDZ/UWVRPxZeNp1vkIt1BWj+Xx6lAiavIfUto
         XpC+J/R6Krg/xKlxWEsyRshIQHWkVTwsIf4bCeIgJWLrpogvQ40Tr1EF95Vg/6tQHKE6
         eKsQ9VCIfnK0/K/G3nlW9o5qTdHzNw4b5LzLFoe98pqo7ELzCXWkR2G7BFmBHGpoIECi
         qlTOk9wWG5PVc3DWelWpVd7KozX1OtvplfQ12bJl+ALAqXhz0PN4qKbj1nFbhKVBf3N3
         1QDba9cf/bbC+96gkKYVXTHf7LvlN/q92rIw+xVzktsdHfj/o7GK4LAhj8prYu9/HokC
         bsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761292579; x=1761897379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxy0zWX1h247nPbsMpYtj4rqvQKsZpsdIsqOdaa3i18=;
        b=ruLLLFT2T4ds0rtFaakbEDgqFoMktWCSY9unpooII2qO1L1QDJ/SHyGKu4L0lgdBcU
         w6T4hJJv9Ps3Nh5YZWheY56uVOEfz21/qbVU/UHnu0mkW12Pr+NwDTSr+9Us8ofx6kvV
         MZQ1yFcGo+ysiigYXbLFH7ucZxgoT17tEvR54EE94x30ZWA+mNxRIG90Gzus/0kZ+thZ
         mdc2/Fl3WMmutlqWXw7GFWJVQhbh8xjvAfeaXV+E1B6eH7JdJDmz/o32QhVit0KCCsvy
         ARLiaX5SD5+DdOlbyAnYduKZbQMkZtm5aONIcEbg3rqBuXzb2ZuUmbn7r7Vrbtg4f+zq
         hbYA==
X-Forwarded-Encrypted: i=1; AJvYcCWi59IFpxIedxdeHKfVTSQpU2qvZWE7erWFxwAxmlnFyeLCysyi+V6e/7hoeOfFGYFil1Bk0w==@lists.linux.dev
X-Gm-Message-State: AOJu0YydSrWhGkjP1XvIqSBgqnmSkikyEgVNY/jpnag6+Twf5aiSNYv/
	TXEb8ltDw/XyaWB/FVb/G81wmoGd6bMeJfXKLEuAGwcgXP46CzugWnRwQM56Zof8LnHobvTyrOy
	KidYcY+ZYzPS4yiu7XSDAfQ5GQb4W3HXiCpUpZCBabA==
X-Gm-Gg: ASbGncsstjvbClH+f1k6FLtuDoXIKkxgNLS1iLBft0Z2yE92uZH9p7JfEhvW47nM5KO
	uCn4f2KO5zPOq3RRdUvNFJH0fKpQNxIJBhNa01QEG0ukAOKnj5dt6OxxXyV6gxi1hdraY1ezvNN
	qT86M6LDnkUeZZMBDxrzGnPRoYhQ+1/KxWbLmCNodqWY9adUYxdh9Bc9AgGrwy9xatCStPg6SxB
	zX/17yqx5bW5hawTyuGkLcwGZB7fMEQenhGNrVJtnTa4HucrnPIQUJYDgcvMHvd35aWM91h9urw
	0pDbHDN2bf2mGAI=
X-Google-Smtp-Source: AGHT+IHSnXZ/gyOux7cXwXN4jLtleYFyXBIE1/V6t/jovl+yJ4b+HMb04wimJ5i7xVzENgmv7b2GUJ2i/5ONH7mEpKM=
X-Received: by 2002:a05:6512:130c:b0:586:83e2:2295 with SMTP id
 2adb3069b0e04-591d85525f5mr9376212e87.45.1761292578695; Fri, 24 Oct 2025
 00:56:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251023143957.2899600-1-robh@kernel.org>
In-Reply-To: <20251023143957.2899600-1-robh@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 24 Oct 2025 09:56:07 +0200
X-Gm-Features: AS18NWBwXS6t25LKJEi_UKqvj6YhljrcGI4AFOhItyKPndeRwhvu3EmnTJe9vDc
Message-ID: <CAMRc=MdE=1cPDPQwPQA6mdBkbXF2pG=oQ_oR_YuasGzaPDsKtg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Remove extra blank lines
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, 
	Guenter Roeck <linux@roeck-us.net>, Andi Shyti <andi.shyti@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Georgi Djakov <djakov@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Joerg Roedel <joro@8bytes.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Lee Jones <lee@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-fpga@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-pwm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 4:40=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
> Generally at most 1 blank line is the standard style for DT schema
> files. Remove the few cases with more than 1 so that the yamllint check
> for this can be enabled.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

For GPIO:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
