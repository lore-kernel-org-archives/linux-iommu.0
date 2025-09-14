Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3048E2DD5E2;
	Sun, 14 Sep 2025 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757866989; cv=none; b=o+eNf22i1nPPWOFCpYll5xZQ0ZhAlc1bFXjFCJkR8J5EJTKQoa0SgHaAcLeZk4sda7mQEYb8lSnk1Z2PJnleEgxRdyKUyEuSLIQjZ6hWodRuKuFhmb9zD36Zha6RYrVXYqVI5S58vo4rwVb/iAE2FypmSnF111zyGtJ5OyAn/mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757866989; c=relaxed/simple;
	bh=dQxeITb5hY6qfYJHe0khMY48r+n3JwUcweNzQW8TgQM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qEZlh+wZKtTUNaLcQQ9tovODHOIJNU2TAnHm9Pq82Kzzl3+WXXbo0UtglGKXunf8fxpV+x/x7QkJuLntsj9IFHTkEDgQTI7QoSBn4jM28rAl1SC+G1A64fDD0O+1q9iksn4JUqDefTbaBCgg62uGkQCV7/MHsJoVTfsbqnPs3Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=W6XcFwIX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nM6bqhzC; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="W6XcFwIX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nM6bqhzC"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id 32A321380306;
	Sun, 14 Sep 2025 12:23:05 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-01.internal (MEProxy); Sun, 14 Sep 2025 12:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757866985;
	 x=1757874185; bh=GczAxd/yOSl3eyN3svqHIDHZRTOmApw3DytFsK5tSX8=; b=
	W6XcFwIXgzpDaSAqZKokVSa67KQ+sFY7Pu8grs8rRoQs20bJprES12ZYeDwvjV7i
	cXP1MDRkrOfpoeV9zsVCFU/cXIP7XXBtuAyV235w2lFX5xl4jcUvGlYrMHy5cgRb
	t+5gUiAObnx3rc+ZTkRKbq1l2VxwOwE9lF0oBwUd9qXcO5+Uog99iq/4kvqseqgK
	xR7Ke4gcd4Z222FVedLz2omnFPHtPgdPDF8V76Tbow6WnHobA1/NjrbPqzUAjcbd
	xVa+l8xl0GpAK6mYMF2WWbIgqO2FmcZG9QVO4BBcUNophOp2ATt0zHCq+f+3UDKL
	xdQZHKnbFUm/qy/3UjvFxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757866985; x=
	1757874185; bh=GczAxd/yOSl3eyN3svqHIDHZRTOmApw3DytFsK5tSX8=; b=n
	M6bqhzCkxh0Ikr92GVRoanj38iNM7PDbawI6zlj+r0YIRmNWw7IlahIX+FzT8r6L
	4ehDw4W6aq4FFqMVnesNjKMvmZZm0FmA9COI+ug0KKsE6Hx7sBDEHAq3EE3huEga
	yRFS2/WMgMdqvUxtZmkvglHc+Y9pMj39K2vILvmxXR8bVlnrSW4ld5kBf6oAbWeH
	jyE02ep/4otNruFJE1FODwtVpFrDXlnRanryaHRkI+9ef1vLuhfmEQOVA44ZpFGF
	t/VrxYLO4aL5Ow/zh8V9GrSitf85NME5qjrTVISJ4hDLk9fM50EUG9j6hkNByTyj
	TDPxh0EGEkPi1xLLx79nA==
X-ME-Sender: <xms:6OvGaMtGJNoFU90oJRDc2LZkQqEHSCV6IpZU5rE1YQSMxDJc-Zechw>
    <xme:6OvGaJeiJg4BQhbYGYhzi22Pc-G3MhN50E8GkYhBMly3mdnKay0gc6SsLw5KB7WXh
    N1ZleIJcyasknW2MbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefhedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdflrghnnhgv
    ucfirhhunhgruhdfuceojhgrnhhnvgesjhgrnhhnrghurdhnvghtqeenucggtffrrghtth
    gvrhhnpefhjeehgfelteeggfehveejffeiffetiefhfedvgedvhfeuhefhfeevvedujeej
    ueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepjhgrnhhnvgesjhgrnhhnrghurdhnvghtpdhn
    sggprhgtphhtthhopeehtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhorh
    hoseeksgihthgvshdrohhrghdprhgtphhtthhopehrohgsihhnrdhmuhhrphhhhiesrghr
    mhdrtghomhdprhgtphhtthhopehmthhurhhquhgvthhtvgessggrhihlihgsrhgvrdgtoh
    hmpdhrtghpthhtoheprghrvghnugessghrohgruggtohhmrdgtohhmpdhrtghpthhtohep
    phhovhhikhdolhhinhestghuthgvsghithdrohhrghdprhgtphhtthhopehsihhmohhnrg
    esfhhffihllhdrtghhpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdp
    rhgtphhtthhopehfnhhklhdrkhgvrhhnvghlsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epjhgrshhsihhsihhnghhhsghrrghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:6OvGaOnzWWVTK6fHrNZnoZrAsZNIYnOs8dYQpfjjbb7GfAHjI0UNiw>
    <xmx:6OvGaPJc7xNH61IJmWT8YOHXCQh-LmyrgzjlwFVLrgG12KTGADf1lw>
    <xmx:6OvGaLZJAYQXqKRAAHuGP_N8BOx7he9-R6wDnmwoJa7sDRvUmAYXPQ>
    <xmx:6OvGaNk2ayK10X4nxODH_Hof8LmRZzENB7AwWON103kD7vzuYyuLsA>
    <xmx:6evGaM9xgikSDaVg4rqD1Ch26sn7Y_SH6mDxFSCjOMlAG1D8cnyO4xpU>
Feedback-ID: i449149f6:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EAFF03020073; Sun, 14 Sep 2025 12:23:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: ATYmlVkkxBG-
Date: Sun, 14 Sep 2025 18:22:36 +0200
From: "Janne Grunau" <janne@jannau.net>
To: "Sven Peter" <sven@kernel.org>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 "Neal Gompa" <neal@gompa.dev>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Hector Martin" <marcan@marcan.st>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Joerg Roedel" <joro@8bytes.org>,
 "Will Deacon" <will@kernel.org>, "Robin Murphy" <robin.murphy@arm.com>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Mark Kettenis" <kettenis@openbsd.org>,
 "Andi Shyti" <andi.shyti@kernel.org>,
 "Jassi Brar" <jassisinghbrar@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Sasha Finkelstein" <fnkl.kernel@gmail.com>,
 "Marcel Holtmann" <marcel@holtmann.org>,
 "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "van Spriel" <arend@broadcom.com>, "Lee Jones" <lee@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 "Stephen Boyd" <sboyd@kernel.org>,
 "Wim Van Sebroeck" <wim@linux-watchdog.org>,
 "Guenter Roeck" <linux@roeck-us.net>,
 "Michael Turquette" <mturquette@baylibre.com>,
 =?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
 "Vinod Koul" <vkoul@kernel.org>, "Liam Girdwood" <lgirdwood@gmail.com>,
 "Mark Brown" <broonie@kernel.org>, "Marc Zyngier" <maz@kernel.org>,
 "Ulf Hansson" <ulf.hansson@linaro.org>,
 "Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>,
 "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 "Janne Grunau" <j@jannau.net>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, iommu@lists.linux.dev, linux-gpio@vger.kernel.org,
 linux-i2c@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-clk@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-nvme@lists.infradead.org
Message-Id: <175786548038.4027671.16854298573806924090.b4-ty@jananu.net>
In-Reply-To: <20250828-dt-apple-t6020-v1-31-bb8e1b87edef@jannau.net>
References: <20250828-dt-apple-t6020-v1-31-bb8e1b87edef@jannau.net>
Subject: Re: (subset) [PATCH 31/37] spi: apple: Add "apple,t8103-spi" compatible
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Thu, 28 Aug 2025 16:52:09 +0200, Janne Grunau wrote:
> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,spi" anymore [1]. Use
> "apple,t8103-spi" as base compatible as it is the SoC the driver and
> bindings were written for.
> 
> [1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/
> 
> [...]

Applied, thanks!

[31/37] spi: apple: Add "apple,t8103-spi" compatible
        commit: 3f2ed0057369d07c20c7ab48c1c46dc77eb436c2
[32/37] spi: dt-bindings: apple,spi: Add t6020-spi compatible
        commit: ffea30e9e6178eeb7d9c165b0b0b2d2e7c5f4fbf

Best regards,
-- 
Janne Grunau <j@jananu.net>
