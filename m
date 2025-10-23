Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A884133C53F
	for <iommu@lists.linux.dev>; Thu, 23 Oct 2025 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761234150; cv=none; b=LynJt5tKoq0LOYqiPCVQ43V4r8tUru/jqguByOiiuy5Z8/yZ+lMk2dyOuZC8fuyuJd2PmBPoIx8oLpTJhBLvvlXuFFm9nV+G3L6rgmzQRrJfI5t+DvWmArtX8hFZTRhLGOS7lzmsjcI/PERU31eUHC06GX+KdfkxatcllpHMlgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761234150; c=relaxed/simple;
	bh=CdcIJyHX4clb96PckgG+JIrIZVu7Cky4+dgR8wQZ0AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhzcJAU9EwO3mmgK0Q1FYYGDK1GTzLp23MAOFljoExIo5xbA0Udmum1rBba+Xd6UYJE+kzGAuzN6yCcHj+HeyNBx3+54R+n6viyjhjMo63bL5tK5J3pYqYs2/HkD7vRIxhTvtEUhYKzGWL1tV0cGczLJ8p6r3st4eHDNvnRy/a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYoPTPIV; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYoPTPIV"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-78af743c232so987070b3a.1
        for <iommu@lists.linux.dev>; Thu, 23 Oct 2025 08:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761234146; x=1761838946; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FiXLImZ7fPO15Ek72Gzubnx0U1bgG0nde4mxLe+ZreM=;
        b=BYoPTPIVYWo/prR8q7wuJ0hb/y99dB4Tssnj2BM53SbPAG5ej6zdD+I0lQHMASRfzr
         84iK7fDx8AomPlOl21I0bw0VIfLcdSjZ33/XeMEBbD+9AnUONwwKWZHrrWzIuy/MJ/dL
         /w9UZZOo5vlr34nvQ9XP9Igm/4AsnNdPN0KAZS2bBowXkLJVvoK+JZ9m44kvRwS2Pp5g
         Zt8BOnzUiNE1JuBiq4RpxL2p301/aPSO68SsV5M/yMVOjLL3sVpipQDp8ctFwZ5VQsnY
         pns+Gw42pP3+5ezVmeOuO32vsbA25soVmIKffk4a6TYvkxiMmJwLBT+E/UnWsqaAFuJ7
         Be+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761234146; x=1761838946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FiXLImZ7fPO15Ek72Gzubnx0U1bgG0nde4mxLe+ZreM=;
        b=FfToEf0PkGBUmAM7nZ2iKBpjJm39zv9EvrTt2epHyLdyntEVILc3ag3X46E53iQQx0
         co5d1WFZLC1MdOAdDkY02qmINqF59Wdjh08O11HMJ2WILnE/BfoLDa0ArwmN5N28JRuJ
         fLY7kgODR/nViGO++slzqKmKWc2YZIpQiCCAety3e34QZ10tal/tJ1NvsnyNUdCytmRc
         V/gJ0YaZifAdF+IAYWJmYSBjHfO4DMNsxFxgxTv+LThqDLWyuVyWJwkpngVfkIguRfGG
         +wLHstFJ+NTyHIM8RFWhlwsImsr5TXaKJWJQpsIGPdN6JgmwzjWTN0hcCL4sznah0vvs
         KTgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn262Z/snyYU42MmGfs9vMGgnq0INgWGDPbBZjR0jHxL7vM/JiSc7Ou7yTZgfWwjnowKPoMA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhWZ6phvKGv0iFKIS1cDOHQzEDnpq3Oler2OohEvfSH6dzXpJZ
	/OFw8dXCFJZDgZ/l1EnpVQNzkNk/CO7+9IcAjM1iHM9qZqq027EUax+r
X-Gm-Gg: ASbGncsCH+oTWO3uvleXl2k1MuRxIbrP45o4Fx0d3unChGYNSlFV+dfeHzNu2xg+fV3
	AsL13JiewOG8eKev0b7iz4SnL3YSF4Im9581SO1jOR0KOTtTJXAOCvWKF91c8f3yjjACHaPo2PL
	jNeZ6ISp6n68L4f/KQRPD5NdgDnE8UusNYBBPZimHHR/1hjRT0WYSCdEqQmesQukvNRWsIivQZq
	g5cc5jpK/386HQvUxkzkfXnI7fTfMISt90XrJLLkWGr42G6mXeDYwJIAyUUizgGJyhEkhHlX8eC
	Pdq/OXewXLwiAxGTDj/i+cA/yta14WNb4lnqFR7gFW+lKJvOdYpC2mHek6x2ClxYlIK3jhl+55z
	K7t4+7dYcr1InMXgqQ9EfAxYekuOJve+LWT8+b1p9cF/PpmWBup2ZChunQTLvlUCSd3vgNy3Mv/
	39+Y9/b7FPpzkH
X-Google-Smtp-Source: AGHT+IFivLiKbkP0y2KMH2ZNEJ7GlEhOb9t2a5oI0W2mRRwwxItjHXvAd1GZTuvYOgULd0RdTXOLyw==
X-Received: by 2002:a17:903:1746:b0:290:9ebf:211b with SMTP id d9443c01a7336-290cb07d223mr295078455ad.40.1761234145718;
        Thu, 23 Oct 2025 08:42:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda72ddsm27825615ad.6.2025.10.23.08.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 08:42:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 23 Oct 2025 08:42:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
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
	Mathieu Poirier <mathieu.poirier@linaro.org>,
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
Message-ID: <0d01d218-15df-4553-8e84-fef84fde211e@roeck-us.net>
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

On Thu, Oct 23, 2025 at 09:37:56AM -0500, Rob Herring (Arm) wrote:
> Generally at most 1 blank line is the standard style for DT schema
> files. Remove the few cases with more than 1 so that the yamllint check
> for this can be enabled.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>
