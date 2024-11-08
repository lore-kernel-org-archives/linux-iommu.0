Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A802B1CFEB0
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731053218; cv=none; b=RLzNCn5yR1DtIXWMeCTHszbVZX/Z3Q+phYlUHe9KtlA7QlSkp+2PUkVlU3pUWzx/GMy+vuikoqEyBzPaSOYbE1i4q8KqZdScey/CwwltxIJ5DR3aOU1SBzWdOxl3Y+/HHufLvhKjbwpX3D2ANbRiYX0kQbYjoDJkfraByduzQw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731053218; c=relaxed/simple;
	bh=FcZP0o3PSmNumtKGO1ItgMWJ55M55pvygKyoPpk9axQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z61QUxCTMWekBsj0WqX505DMRuaJ7Kl2RTXazxhBNNyisEJtB4a3+JepK/1h5bKYkPz6IaIt/RRMX3s1k+aTUiTGgcxGJv0sJFjl/qoaZXLv0dcj4DG4XnC5OhkOCW+p4ANAuPzSRkaDpEHeggJGgDAXG9RU/yBNw5TyzxUoUdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jGnhfVNi; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jGnhfVNi"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb587d0436so19764841fa.2
        for <iommu@lists.linux.dev>; Fri, 08 Nov 2024 00:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731053214; x=1731658014; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcZP0o3PSmNumtKGO1ItgMWJ55M55pvygKyoPpk9axQ=;
        b=jGnhfVNiu9ZDFS2NPhlcm3Lu6d31TkGVXtYY8R3CV66dnuO7PmPBDFWRLCc3DQ7TGt
         5pj4clmppJZxDh91L9kmMlKvJF4BbrxCO8x7dHUkYjZqdGy14hjAezRPks+Jjmy3oJQz
         6DcXpaEflpHwy4jItu/h/J21/vJ1+cqF6EthvpiA+4zkADMBDFXvQzUy2bKZ/TnYXOxk
         y1XsvJdnB40v0o97aXJ9H7Q2FAOatu8Pm8oPhX5FDdgcMlt2dmeLYSPqpO6NLTOE3LMG
         x8nShDscaPDjM44YyEvwJaPksrNUsO0PBzViHQ15WsaN7Mkj4ULJBPzPcQSMa0qV2RCP
         AcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731053214; x=1731658014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FcZP0o3PSmNumtKGO1ItgMWJ55M55pvygKyoPpk9axQ=;
        b=QEFPDXYOsFK9MHTvkRGGAqN9oz9FLJFlFZ/ptMBwJDVkgfN9pmpaamVxsDm3r4Ila1
         XmPluZU01rEZxswFYl+CrXYqVg2q1Zf+hCVQ+r0UIWh5ZDDZNsoJOOIGRhkEVekvPJer
         Ufi+IhNJvDxEUMzDoEb8xJLsN19TuJqsqOdk96abJcjD/r/EVV2nLngJSuR/zsvQ//2T
         eL/M/Zsiw6gQfq8vH9Me7KrkX+Yr1juGJK5+ovz+i5OFPBHYxYZcG2baeXybP5aDuhmI
         AbWON8wOhoqvNr9+oSRuX++kNT2MGOGR+Ll3BuVY44mtKmu7YcUnGDq12/JC0YaHTWZA
         VasA==
X-Forwarded-Encrypted: i=1; AJvYcCW4AkfzqX+wpxkNIC/r8VmNrjbFkV38aeH75MznzBlhiWxCvyIijlslqNhJQM9ADTiwtZvF4g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxq6kkX8Cca4SOWbva136UyaOomKgp32M90zLK8OWU05ABaqfok
	mFhZgqJHjlD5J5m7NrUoN6Ns4h9zGWLFYUcfZpGO/tV9V9adl3EWW1BXPJdKp+rSHZNeyGLYHqe
	H4KQHAkktc3K8Ls8SdZ3LzeXr6nroYaLA/12gAw==
X-Google-Smtp-Source: AGHT+IHwi4PwmyQyG/lANiqFNPWg55NWKh714pI2y79atgBsJL4Lz22ORZxxpFfE7bWCRIAG4Z7yTBnCOgDUxjCiJmo=
X-Received: by 2002:a05:651c:991:b0:2fa:c4d4:ec44 with SMTP id
 38308e7fff4ca-2ff202230e0mr9679541fa.28.1731053213879; Fri, 08 Nov 2024
 00:06:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241031-msm8917-v2-0-8a075faa89b1@mainlining.org> <20241031-msm8917-v2-1-8a075faa89b1@mainlining.org>
In-Reply-To: <20241031-msm8917-v2-1-8a075faa89b1@mainlining.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Nov 2024 09:06:42 +0100
Message-ID: <CACRpkdbtNomOHe=Jd+0Xfm1sr9=DzvGSy6uS7jxZm4Mri8Bb3A@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] dt-bindings: pinctrl: qcom,pmic-gpio: add PM8937
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 2:19=E2=80=AFAM Barnab=C3=A1s Cz=C3=A9m=C3=A1n
<barnabas.czeman@mainlining.org> wrote:

> Document the 8 GPIOs found on PM8937. It has holes on
> 3,4 and 6 pins.
>
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
.org>

Patch applied for v6.13.

(So we cut the patch pile and you will not have to reiterate this once you
rebase your work on v6.13-rc1...)

Yours,
Linus Walleij
