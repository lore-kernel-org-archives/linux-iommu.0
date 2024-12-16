Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F712036FD
	for <iommu@lists.linux.dev>; Mon, 16 Dec 2024 10:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734345225; cv=none; b=p8H+z2cTxYsuOKoqEKiU96cnESGXHAm2riKAbZhGoX+obR/VD00ArdyqhTV0kPeK2VXQqDoi8+wW/qhSqY84JcVTddhcKh2hgF82r+zbg8eOdrIkao4NXH/MtLdNzlAn4iifzTBwhZccNRbEuyd/swF3AIDhdkuUFq2Y2akQu4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734345225; c=relaxed/simple;
	bh=PYwh9Ejzktqnk/4b3X6HTET4UjWYpwtQYwse3ElACjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADn9VgnXBnKS8rGheJlp5lqpkrAVc9d9qM2V+RO3QjNUPnThzHXiir0/BRJQXgxh0XJ0bhYLFkDB0Vrwh1Cw8IRc6MN8s7BaMXJrhOPRz8kfJ8+9WGDbOS+5PuLrEzdnMpgmpamOPFJ5fL/1JG0LccPyR5NXhidnzsmP3rErcqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hd15CHfd; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hd15CHfd"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3002c324e7eso45081571fa.3
        for <iommu@lists.linux.dev>; Mon, 16 Dec 2024 02:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734345221; x=1734950021; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81rR1eTM9HElymQ2hIkXvkfh84mtbQHR8oN+z/vprns=;
        b=hd15CHfd+lW00u3mtgU4wNjWygXsoRs30zaQnNrtgaHUSN7FOD1lBzW8ZEEYt+I1Of
         WB7GzwV7B4+29rkEo8vsj96F+ofsuU5xhCJl4cRUnu5V7gQ3FbaZSz3IztMDmNfGRur/
         7OtduUNjG+WfXzN/gQLsirc9GYnmO6ZbAHN5nJSTY9G+QioMr/zkywZKL/hK1hr9ZHSi
         kJUxy3WB+2zPFZDetpPiKomUywQGQu4cOu65uB4uuHBOjS/xJszeUo0IZiaTYv8kxJW+
         9NGd+GGrjGIb9owtw+BdC9Pe8BKdt2vuwdvQhx1svNOUcHahgMZI+S0nVifuyRI3kIOw
         kp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734345221; x=1734950021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81rR1eTM9HElymQ2hIkXvkfh84mtbQHR8oN+z/vprns=;
        b=a2JBIaz1HPOuVlB/TCpwyvCOVxSE9W7xQMyCSypNpK6Vq7MpxrI5BeJid0kVHWArH1
         EjpFjduW6juz/ZQth1HG7EQBvD20DISNk8B9QwzI86Gjh6u7RYQhsUMFiEF+jjaaHsXs
         EAxP9XPXKmFzESnRGQf6ypasZ+oEqNYOWmy5GUOJ/CBlc96M7ntFfUGNX8ek4RT/VgHV
         fYTwGPWFK6Q1+HgS90/rPtkzRoEsaV1IqwIUzNGqFE5HUrSihj9yq43uUGGFdmGAKMAs
         0sznDIDOWJTceJK/GKWBU975GWYnsnbq4IVrLodpxBwTE8G08dFIp/3BcysJIJJn2yju
         73yA==
X-Forwarded-Encrypted: i=1; AJvYcCW8V/Xy/Rja6aIt8okmiQ21LMDLkgHd95a+zOFYr1ZQ4dzldXEGns33PEYheOkyc9BsDaX6rg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFqZU7Uc/0xGjSQB6hcPQ1DGqThalJiJyu1Kh67g6TBH4W5Xrh
	k4BQmqcjfErwIlfp+TKqRTYwB/hdzp6EclrYNBDwPZpiaCjoWnVr3ek+s7psrWFWR4efNsCJPWq
	LFCpY3fK51X377RBfx7L54ImSdSXFk3A6k/La/w==
X-Gm-Gg: ASbGncvxViNLmwJUJ9iaIf0lzwTfmNGBB/lr2r6QujDCcVXCiwHrBcMkUt4ZU3ru1DC
	wYztiISsIyqC4AAS2uZpEpao3AjT12Fd50nHm
X-Google-Smtp-Source: AGHT+IEUf3iLQlaHwj+huKVEu7Rf6ZfMRHEmd0RkbAiajFtXRNVDdgnZzJS2Enw8KLsa6+/B9ivQKuoEjmBWCEUg1Qo=
X-Received: by 2002:a05:6512:230b:b0:540:3561:969d with SMTP id
 2adb3069b0e04-54099b7188fmr3706580e87.49.1734345221514; Mon, 16 Dec 2024
 02:33:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241215-msm8917-v9-0-bacaa26f3eef@mainlining.org>
In-Reply-To: <20241215-msm8917-v9-0-bacaa26f3eef@mainlining.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 16 Dec 2024 11:33:30 +0100
Message-ID: <CACRpkdZ-ZEiGMUPObHU=kw=OUADrRGtxgMc-QC3EaBevp-Shng@mail.gmail.com>
Subject: Re: [PATCH v9 0/8] Add MSM8917/PM8937/Redmi 5A
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	Dang Huynh <danct12@riseup.net>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 12:15=E2=80=AFPM Barnab=C3=A1s Cz=C3=A9m=C3=A1n
<barnabas.czeman@mainlining.org> wrote:

> This patch series add support for MSM8917 soc with PM8937 and
> Xiaomi Redmi 5A (riva).
>
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
.org>
(...)
>       dt-bindings: pinctrl: qcom: Add MSM8917 pinctrl
(...)
>       pinctrl: qcom: Add MSM8917 tlmm pinctrl driver

Is it possible for me to apply these two patches in isolation?

I want to make sure the patches get moving.

Yours,
Linus Walleij
