Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7691C3E16A6
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 08:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779179480; cv=none; b=NhVIkadQfbE+VT/S2aJBkJHdQVKN22HPw5urONJWdQMVj2wuK/ncioRNTJIHiLzWH7wAVsicBV8SYUDkLvRIa4RLH7dR4oMuBuUFZMhmcu9JAANcLg7jmK/RYoIiorHQ7j/OtcSk+KYKwlCvjsKdavWU68MZl6m7oiIjqRdm4C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779179480; c=relaxed/simple;
	bh=gYstxcuWc96pDbCmO9hN3d3Df6cw8nt86KfRpF2dMc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYm/E7M6I8E2cpdKlbSwkheOlqN5BRaLBoPGXip0ZFS+t/wH3+Qq/ooDGhwgqT+eWaCHDYjvChiVscUxuftDa9dZe+v13ErUwsCwWTfaYCOjJ9YCMW7eFBqhmA1TGby/AkuIfnxpd3r7mX8Js5yajTknDfLx5jT3rjBASXzGtTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcQmoS6G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcQmoS6G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CB3C4AF09
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 08:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779179480;
	bh=gYstxcuWc96pDbCmO9hN3d3Df6cw8nt86KfRpF2dMc0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dcQmoS6GLFi2R0yaK0C+WYP8gkJewzayiAjBXzXfT2KcyF9dSeBYIddmtSFZtBWHU
	 O3DHth1w+2iP4VE1/+TCuDrZtuO/MvbRD+/IeJ7MCnPFz3/JCBhBrKwCjySS/kzVC6
	 k0UtWCTfrG54Q87sNtpV2drr5qvL+Vh/SJi6BxmRE1hO/6PS9li7m+OvpeFZkNLibk
	 oiEGK6BoYE7HYf8Q/6oXBtDdmTCTriNYHqCotL0fi4SZ09Wt21k4uNzeoakik30+lm
	 xp/PeYQgwws2zh+kiQPKBaIpfFuiTkK9T+lvBcznaEzGQRP2vxEJqNZtuvC0yZzG9D
	 /wIRXTeiCkuNA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a74ac8b40aso3737876e87.1
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 01:31:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/vg/NwR981ywliN877vT3YiSmATZUDYQWvEOMuSsaPRdLnqU2z4wsdEEKbvr+9TAJhWSFPXg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFYo8bDu8o2bF8Fg4+3qFXa0tJjdkWtTgQ4Xvf2Em7bM4IdjXR
	ZoaeTuYMFwRUp0IanQECNjELLU8wWkV7Mqe6pZ+38jF9OdTHNAMFohUOkP/aSlFdSMBcmKyWg+R
	UnSVA7GeKmwZQKXnq5ATtsgvDmUTKvgg=
X-Received: by 2002:a05:6512:1286:b0:5a8:65c8:dd90 with SMTP id
 2adb3069b0e04-5aa0e73f4d5mr5272064e87.4.1779179478814; Tue, 19 May 2026
 01:31:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260519-mainline-send-v1-sending-v3-0-3dd7aa125353@alex-min.fr> <20260519-mainline-send-v1-sending-v3-3-3dd7aa125353@alex-min.fr>
In-Reply-To: <20260519-mainline-send-v1-sending-v3-3-3dd7aa125353@alex-min.fr>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 19 May 2026 10:31:06 +0200
X-Gmail-Original-Message-ID: <CAD++jLm=BxHsPJ4rgqwY8SvaefZUO+Pfv8E8xizqPsdJZw5weA@mail.gmail.com>
X-Gm-Features: AVHnY4IFkYYcJkwE7oBtW7Rq4mnePDIoacVSym4JzKnPjR_3OiAFXxYaV2dbJIA
Message-ID: <CAD++jLm=BxHsPJ4rgqwY8SvaefZUO+Pfv8E8xizqPsdJZw5weA@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] pinctrl: qcom: Register functions before enabling pinctrl
To: contact@alex-min.fr
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Guru Das Srinagesh <linux@gurudas.dev>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, iommu@lists.linux.dev, 
	phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

thanks for your patch!

On Tue, May 19, 2026 at 9:16=E2=80=AFAM Alexandre MINETTE via B4 Relay
<devnull+contact.alex-min.fr@kernel.org> wrote:

> From: Alexandre MINETTE <contact@alex-min.fr>
>
> pinctrl consumers can request states while the pinctrl core enables the
> controller. On Qualcomm pinctrl drivers this can happen before the SoC
> function list has been registered, which leaves the function table
> incomplete during state lookup.
>
> On APQ8064 this can fail while claiming pinctrl hogs:
>
>    apq8064-pinctrl 800000.pinctrl: invalid function ps_hold in map table
>    apq8064-pinctrl 800000.pinctrl: error claiming hogs: -22
>    apq8064-pinctrl 800000.pinctrl: could not claim hogs: -22
>
> Register Qualcomm pinctrl with devm_pinctrl_register_and_init(), add the
> SoC pin functions, and only then enable the pinctrl device.
>
> Signed-off-by: Alexandre MINETTE <contact@alex-min.fr>

I think I've seen this one before, if Bj=C3=B6rn or someone else from Qualc=
omm
can review this and test on some other hardware it would be great.

But if there is no reaction I might just merge it so something happens.

Yours,
Linus Walleij
