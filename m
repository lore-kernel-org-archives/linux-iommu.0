Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65976245AFB
	for <iommu@lists.linux.dev>; Fri, 14 Feb 2025 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739528447; cv=none; b=XC3Jd1cZ+mHfE9ql18QCw/MJgOKrs4XugvvcU+tdTIZuicEHzJWw3cjEnb+1bivg1KEXk1cUs3r4LM+9uOeJPY9nt4YE5hSbB8vZmcUEorzgfXcWK/v0crGUMmdtKQw1iGp5xJ+sE/gLCdXbAp7IwDRXkCh69cBUdeJ5X11dwjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739528447; c=relaxed/simple;
	bh=CTVSHuL61/AhoBRJTC+WTqwIf//cehy9pgtd28J8H5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LsmAaPN1uq9D+NzfyHcaOGVMfnGINu6wm/eLoi5qqfiDIXbHlJnK3YeujImgwAkYQ09LAipR9Xmcy+DxaNqGO2PPW8Q7rwbIsN+OwkJLXPgeJTOZXaCHbiqR3zkWiE7aD0+WAivlFPGbKxZqtA5keS/z2JGepbLt+SyHs6XOjLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TLjlc+zX; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TLjlc+zX"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3072f8dc069so19828851fa.3
        for <iommu@lists.linux.dev>; Fri, 14 Feb 2025 02:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739528443; x=1740133243; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTVSHuL61/AhoBRJTC+WTqwIf//cehy9pgtd28J8H5w=;
        b=TLjlc+zXaL96xva/SoVKauXjsKJBvFcLh7H68qoLikD0+/Bs4a7oQ/cNaSpRMx2i3v
         XKPhT9UX1DjSamsWEyV+VWleJy5m9kE4d0HdTK+E3iRZoC8h6yDk5kS+ih1vhvSxw+Rv
         nZkJrg4GsVy9FP50ZLInru37m1x4EPHVOoMSI8DkpEHe+cidCO02NxOBDESNzImOcuvd
         mJ9K9z08qU+YCMj5dXMtQzlrAqYkSub/lZKjge5tyRi3QP+WW4s92ftMc/LqzjEWmp4u
         FdHP5c+AG12ox+NAv2KyPqsaaAqBUOLp4Ovzhtp6vkfxlFiPoXzN7+Px7FgwXar9VjQ0
         lu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739528443; x=1740133243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTVSHuL61/AhoBRJTC+WTqwIf//cehy9pgtd28J8H5w=;
        b=kErDVwgkE0U70nV6ekkHJSPpy4En2vRwZoHft+FVSCqdS75R8gaPZuLxIrbgXRhxKo
         m7HLMMH6GoRyx9e6/pNZ+JDuVVHjk0uCkUn68M/jcfalAkghL9x2qsnMPkAiN7FOHIaI
         /otV/ZXKCtBPVgpoj9S9i40VEklg4huUxZHzy33DoVa307zvv0JOxEu+ofcvuhFq9dIE
         YwjVjXSngjPRQ/qDa/DGlpuTXjBj5aYxBY1/Xzl58VMXVDvO2lpOHRam0yhyv8uXs00x
         eRyEmxU8pcO5irju5eyW3ZjdxU57fzDmsHeYtVPo2YOzHv4sUFz9tKMDceFDInmpSCM/
         N1Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWb9N9HVRcPooF/RDtddubosWogM0YfIAxu3/qzOmHZDazlCWCwUUQuCDLMFpPAI9+6S2ZORw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhfYEC2LPE0RTP5AOK6BXYB47ISGU862viCKgIhWLRlVWBzFEZ
	n3sKlc7pJ/ttBS+pwOtg3Gcn5gyAAYET35c5KvrJtIPWzFAxIzcjbx1R9ctxDw7A1fH1D+tIemM
	KqyAKcRFW6A7McyfHkcazuhZGeCow4fs4tc34qQ==
X-Gm-Gg: ASbGncvi8mzPTOF3g9j2JTF5rQBerpQHng/vf3xGNjJpDmSuKbR2Ezail6CNmNgHKa1
	QDNeJYjCdtKHvsHIj0lpyUDK/pCpFI5bGuMbqPLsbdvvJwM1MO7TU8pGsODQ7IYFssuEGrJK2
X-Google-Smtp-Source: AGHT+IGxEKSdYAC3wifyGNgk5Eh89epo8lJDj6yQU/T/HzKQmZRPC1uyCtKYApqXa99y+vDHCBVSpmZfESb33W2+lF8=
X-Received: by 2002:a2e:a7ca:0:b0:308:f860:7e8 with SMTP id
 38308e7fff4ca-30903669b5bmr38024031fa.20.1739528443454; Fri, 14 Feb 2025
 02:20:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250211-msm8937-v1-0-7d27ed67f708@mainlining.org> <20250211-msm8937-v1-4-7d27ed67f708@mainlining.org>
In-Reply-To: <20250211-msm8937-v1-4-7d27ed67f708@mainlining.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Feb 2025 11:20:31 +0100
X-Gm-Features: AWEUYZlN87XktebbarRKF7Naij4xj70q78-i9U_Bkah2OKeETlLFl7lqa7kEoVU
Message-ID: <CACRpkdbG-cS59TbB36=OrZ0MfXPdDPSpPEA8U_L_iMOgNZK70w@mail.gmail.com>
Subject: Re: [PATCH 04/10] pinctrl: qcom: msm8917: Add MSM8937 wsa_reset pin
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephan Gerhold <stephan@gerhold.net>, =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>, 
	Lee Jones <lee@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	iommu@lists.linux.dev, Dang Huynh <danct12@riseup.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 11:38=E2=80=AFPM Barnab=C3=A1s Cz=C3=A9m=C3=A1n
<barnabas.czeman@mainlining.org> wrote:

> From: Dang Huynh <danct12@riseup.net>
>
> It looks like both 8917 and 8937 are the same except for one pin
> "wsa_reset".
>
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
.org>

Is this something I can just apply to the pinctrl tree?

Yours,
Linus Walleij
