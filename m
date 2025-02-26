Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAFA2745E
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 21:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605447; cv=none; b=BzFnZ5YeCIn4QqnBck0n2VD9ILQpWzyEk/tbo/l3aixBr5valkYCHeQdGEI/CVTBH+bhefUNMLrUCVZQzVl/8eobuS1Z6Fhds78k4MMVycX1vc057OXfKN0/WBrFgWlqOvRNOuBlhdv5fBicjqOiVsyAipBdSh1/VtXsZ6E3oV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605447; c=relaxed/simple;
	bh=SUGyhrxSVMFnfbeL2igPaj/oiGAxEeL7XtDqz9AUnnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQ5dc2jgkwL2rOdVnpILzZLy/6CoaOqMuN0X/Q+oYQcnf35C4muyzAQ2BqVTMgkxwFHXHoPSAkgVreXVLyU0vSmAM9xqBnu4Ma0mci3vCmLyyiTfF6gHuHMXsjFFYBPFn0zi20z4JrqcZthap6Oer8DdvP5WNGFJehhgp2CnOog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k8kXFczN; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k8kXFczN"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-548878c6a5aso215725e87.3
        for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 13:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740605443; x=1741210243; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUGyhrxSVMFnfbeL2igPaj/oiGAxEeL7XtDqz9AUnnk=;
        b=k8kXFczNluNaJkRFLwxCaCQub6+N3mJctmT23/leA4XUWEWHBqf7Jtu8JP4BHuTPt+
         yYCo4A6u6LYeXuYviqpqyyn1ziMKhRNSfgWtrkDDOHE5/WzMetC4fckih47Q+IOV54ra
         D0cDDu3CLt403ff/svSOltBvW3O7UTdGKAcltxZnoxyMGO0qRBdxB+GbWU6W3mmtxg6n
         nEoD+ryNRpFG2Udp8du2RXekSlqiY9J0V0QLMDEmcEUxVEv2MfVA8IunFhChs5i0YM+f
         +LeD5ix8Y28uRQuBOcAGpeDLl9rYij0DsU8kVAl4ubLxxrC3i916O0JsLyDZF0zAqg1G
         I12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740605443; x=1741210243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUGyhrxSVMFnfbeL2igPaj/oiGAxEeL7XtDqz9AUnnk=;
        b=GG1/JDCtI3aOl0ru8mqTPUKAGtgo0MITnsELe8jxOlH/lp6QaOuAsRhs0g2NuTNydL
         Fpt2Nem7MNZ/fsvzNWsWeaHeodjSZePYyFWaOkIQc/riDFl7lPtixXZ11MVuIbz4FLMa
         y0uiDGOwfCRv/6cfBtKUB0951BNHWK0EAus4fuQ9e5pcLE4ISNVr1Tad9AMD+cA+J1hh
         /54nKp1d6COIHsodUNCdWW3rsqNwkHtkGntupkBJF2hsrLfqiEvtVLwv/wmHw33MP8UG
         DZEIR4OHtUmWAybeIg+GL+HBh4bCG3vkGQlC6Dn7ZbfKXeb5ywyYsy01B2HEdPhAWq68
         LRuQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1B9/cctj1lfmeJUoO8dWzk0XJ22H7v0MZtF8wtSxxHuoQzH26eQnEMJRLqKVLNPcQI2r5BA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIH5cc4Xijvt6IdjeI+Nhcf6mt5bqzB8ZY8Wsf/UXU+BM3RdZP
	0cKAzlV/JcP+PXzKaz6UAHAu172vfctu0QGXdp/N0LqSk/lvZslyxzmK47f6Tc+a2rETKsMglsb
	ODTs4x1fcy6Tm5QckZ3p/Z0c93mzjoV+2l3XKrQ==
X-Gm-Gg: ASbGncvMu0KhcdqtWSZp5+dQYuSaDLM501EEQ4Ih1q0ZfnIu9uyp20PDxOFhCOp5rgG
	fkteZH9pyoDcH+KSsoIkrBBXTBF2XOXTRxGSd5Xfj8+8xEIYFUl4XoWFptu/prfzhHjtHdxRwsl
	sbr7ywBlk=
X-Google-Smtp-Source: AGHT+IE8+uZvHOPVlO4cJtPSuzroRvBR0aRjVwpJAshWI+BRIHeRYPen8jIF3ZZZVKAcoSrk/otZQzN4xJtaQL33NME=
X-Received: by 2002:a05:6512:2347:b0:545:27f0:7b6f with SMTP id
 2adb3069b0e04-5483912fc82mr10885628e87.11.1740605442695; Wed, 26 Feb 2025
 13:30:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250211-msm8937-v1-0-7d27ed67f708@mainlining.org> <20250211-msm8937-v1-4-7d27ed67f708@mainlining.org>
In-Reply-To: <20250211-msm8937-v1-4-7d27ed67f708@mainlining.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 26 Feb 2025 22:30:31 +0100
X-Gm-Features: AQ5f1JpA8TYnCxYWLh_Nsj3CaoL2jBGTRtip6jpMFprAlot5Cs6Ct5PvAxVIfSk
Message-ID: <CACRpkdaokrm1wLHGpP6aCTA9uQYAptVqt8J6+BQu1MmJsk9=Cw@mail.gmail.com>
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

This patch 4/10 applied to the pinctrl tree.

Yours,
Linus Walleij
