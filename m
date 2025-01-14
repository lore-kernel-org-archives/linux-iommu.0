Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AB815E5CA;
	Tue, 14 Jan 2025 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869597; cv=none; b=jYar6unbzLaSwRTaA4UGZH/hPjzGWJJk/H1Imm35JFiTVstwV3qUYcHfb1noreqR5I30S/HUTR9x/cDfLcl3ijih55tzegjjD/e4UKaHF10/ccF0EjyQwqC4kV3B8eH9yqJ6TXw/Tz8OsEsklIW2GHRzwKkENP9byv5B3/v+l9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869597; c=relaxed/simple;
	bh=aa7NdIF/RsOjWlxdLoQ1fr760uFjUhbc7xZg2HditVM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxzSlrwguVjtJ1rULdXedhBjPKABiCRxmr8sbl5nddeR00U3IX+QbiIyIm7z9/Lq0U0Qpyqzeczjwa8+B9k0iHuMeauumoWHygfMuyKkm16Pl8wFqhGY9oddzEj1xnYsgrZwkfWB/STKFn/tvbs7gMCno2r6D3yr7M+FN3XrbZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C884E11FB;
	Tue, 14 Jan 2025 07:47:01 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81B6E3F673;
	Tue, 14 Jan 2025 07:46:28 -0800 (PST)
Date: Tue, 14 Jan 2025 15:46:25 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Parthiban Nallathambi <parthiban@linumiz.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Michael Turquette <mturquette@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Vinod Koul
 <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-phy@lists.infradead.org
Subject: Re: [PATCH 10/22] pinctrl: sunxi: add missed lvds pins for
 a100/a133
Message-ID: <20250114154625.7d82c858@donnerap.manchester.arm.com>
In-Reply-To: <CACRpkdY29s6Cz3zvtksLO8sESwxhkVdmGUipVAqiEtix3E1=Vw@mail.gmail.com>
References: <20241227-a133-display-support-v1-0-13b52f71fb14@linumiz.com>
	<20241227-a133-display-support-v1-10-13b52f71fb14@linumiz.com>
	<CACRpkdY29s6Cz3zvtksLO8sESwxhkVdmGUipVAqiEtix3E1=Vw@mail.gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Jan 2025 15:30:24 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Fri, Dec 27, 2024 at 12:09=E2=80=AFPM Parthiban Nallathambi
> <parthiban@linumiz.com> wrote:
>=20
> > lvds, lcd, dsi all shares the same GPIO D bank and lvds0
> > data 3 lines and lvds1 pins are missed, add them.
> >
> > Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com> =20
>=20
> Nobody seems to have any objections about this patch and it seems
> technically correct so I just applied it to the pin control tree.

I think Parthiban had troubles with his email server, so not the whole
series was sent out:
https://lore.kernel.org/linux-sunxi/314b6bbe-613e-41a6-955e-50db6e11ef8e@li=
numiz.com/T/#u
At least that put me off from reviewing it in anger.

I do have a comment on this, will reply in another mail. So can you hold
this patch back still, for now?

Cheers,
Andre
