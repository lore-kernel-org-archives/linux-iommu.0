Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926F831E0EC
	for <iommu@lists.linux.dev>; Fri, 24 Oct 2025 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761318074; cv=none; b=KlEJ1b6MSWf8f6pxa3eEA3ipoJL9RRqb2wEC5gboEd/S0j0Wv3DAxtjYWX5EwE4DMQQgfY13CnHaM5DvdQAbpgmbhiDK/qExuiyt7+Hb5kQh2CAaU3PL1At2HzWra4trqG2iqa6LrASESuqXaE7K4R0A60+Lvqcua21mGsYhihY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761318074; c=relaxed/simple;
	bh=Ipd+fJKM54dwFhjqVqY2/vt0B0gPimIr32J295wlB+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhabQWLh+W6aUx1B+jCyTlsRh08vA66kT404HPCj/EwIXqECxpW5xQn3ucXcvOIJqQTS2F5/mLI44rkS2x/xjUTfeCa6dIpkGZYkWCUbMMmTffcAOlujLSlmjwvwOP063ukki0FsqVgC+IWE6vtIgCMt+eVaMotaEYEVjLHEN3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pdhpkuUa; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pdhpkuUa"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b6cf07258e3so1708879a12.0
        for <iommu@lists.linux.dev>; Fri, 24 Oct 2025 08:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761318071; x=1761922871; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ipd+fJKM54dwFhjqVqY2/vt0B0gPimIr32J295wlB+M=;
        b=pdhpkuUao3UMW1g9dZtVnec3C+U1IEc7gw6sd2pN/VDKzM2CRqWJy6Mp1VOEDr1BiX
         2G4rg8pwXE4hlwC8bbNNnjZDWPdLeDT96P3HApKcyjmonAH/HEmUys9My4mj8qR+6nnY
         OOkygDv2T5AUBxjxhxcN+8X3i2heH7hF+uAQosliNVaj63R+YLFjYurSNAvD1HyVAAjY
         aPZbOiDHNoM614ZmPlvU8PQL2iqo19mAoBJ3FYjl+yaUzRC/WOT4fms5pYFqQyndPsRt
         9NE+Du2exAkAWrB7DNy7vTSacyr7RHihhZtbJv4sZTrAKP9s6lvXgAfSvO0i+S0DRVYh
         XGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761318071; x=1761922871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ipd+fJKM54dwFhjqVqY2/vt0B0gPimIr32J295wlB+M=;
        b=hLCtfppUYu6/S0y/0YlZIp6oLCpNHA4IJvUdQIlTsfpjUiWean8edDS6mnI4U7Xrpq
         +SL1/w7aZYSzg66n+UsTNNQVePq/j5bbTLh1lb8nKyXpxwpexDv6um//DRkXNO2OoNfw
         aex2mDfo54qXP3SSAmm5Mpc7sdsNd8SSFJRE2xbpgrJ8HcLMrdBpTdlWrrfaV4/Qtly1
         GxoQZE7+NahXvln09rAkwgiat5xrdydxghm4g6bzm9bebPgJN15uEraHt5ymL/jG6NH3
         CMD5J9CZGnCizdxcDuzhdZ4CUiXJIcpExOXJB0WCoitW5reyN2Ku9HMB89t6efceCONb
         qgWA==
X-Forwarded-Encrypted: i=1; AJvYcCXxhhuMhipnKe0GzE5JiEQaFK4p0pdrA0AD6m3a61TLmbn8+GMeIPK2PzXP+n6l1Ww7jWkI7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwyIxXNIaqnUoAFGbMQWk7MCZH0JqnoGkXt+eQKRUiBzRlb1Nmt
	NGZrUNeT/JjZuQAuwJthWrgs1VuM+4IsyHPlpZFG4j4zBkQpZTDVq6j4suuk4RsqEDw=
X-Gm-Gg: ASbGncsWnrmobwoJrwT0elVyA/MH9mzONXn6diKJ5r8Wk8EcHU7RJeG/FfCp5/84BII
	g5kTlKFvpUgMbFI13IwSbcI3PV2X7eqES0yMt0rYINGMl6YUx0mi6MjWq5SW+B9/lLa+rA8sRxb
	dSi8guPZXKMMPj7jmGFKMH1cie+Wbp/QzVbXlLj3wVFPwOoRE3iY4R7ozArKq217YfytRLYsnJV
	C9w2Zz6tz9Ca1SPQD+vs+G6e+nxjIKtxpCpulriMLtJ60Z6mbA1cvN0wAOUFG7MEhDfzA5BIpaD
	cugwHhQyXSUyQCyt9uFQ/hRyTm3jHJH2dXSzkoR6ofdpGcKQQMhNx3N06bINu1hr9yGpluElv1x
	my79ouIchlOGt+t+JeeMdr0abMAmkUAJU2MohrzpIAstYQXOuNVXIoANJEA3kC7B70ixA+ctXN7
	ZjgCk=
X-Google-Smtp-Source: AGHT+IHuDfyfb1rJHT8ZJBZDENWXEuZEgoATFw7kevTr6Wui6O5rdZfaFJ1o7hmkdy/EeXDSX0H8pg==
X-Received: by 2002:a17:903:8c6:b0:28d:18fb:bb93 with SMTP id d9443c01a7336-290c9c8968cmr381787975ad.7.1761318070419;
        Fri, 24 Oct 2025 08:01:10 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:c4aa:f655:2dba:5bb5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e0f3794sm59537715ad.88.2025.10.24.08.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 08:01:09 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:01:05 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Guenter Roeck <linux@roeck-us.net>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Georgi Djakov <djakov@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joerg Roedel <joro@8bytes.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, iommu@lists.linux.dev,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pwm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Remove extra blank lines
Message-ID: <aPuUseub-Z60hrOx@p14s>
References: <20251023143957.2899600-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023143957.2899600-1-robh@kernel.org>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org> # remoteproc
