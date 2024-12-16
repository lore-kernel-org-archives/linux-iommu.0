Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C065206287
	for <iommu@lists.linux.dev>; Mon, 16 Dec 2024 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358535; cv=none; b=MWoBis64jDZaMfXh5lp8iZIacMcJKqSm1OmsWrVt+kPiGPgyuBFsBW71Q/l7IecZ9wfrXDno/0Sp6stby/T9FoN9BxD6UcbJ/fdeH5wq3EO3uanNpy7huJCYsXDdBc3Uww6WO4WVugZ4ndC/+gwSgkY26QOK0WD0mAnQ8r8sTGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358535; c=relaxed/simple;
	bh=sTO6XsUM1EpoRAEqG+118QEinm0VU7febgtSY5QZvgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=feS/DyyNCDWeQXUU/X83wubSjvViPRSUVxynIz9QEcCTvLf2Y5VI2WBNklKSfeaMO5C5bQNf8UjmrexkV3oYBwV38bh5TT5L0kmNZRj4RaWBZgFdk6V4RHMasSdHhxByzWZSsRU+C791ktgdOZ0Lcu3QCo4QVU1hrwsDjqYU+x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l68//sTc; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l68//sTc"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54024aa9febso4152226e87.1
        for <iommu@lists.linux.dev>; Mon, 16 Dec 2024 06:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734358530; x=1734963330; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTO6XsUM1EpoRAEqG+118QEinm0VU7febgtSY5QZvgg=;
        b=l68//sTcQpG12YIQjM2JyAdqAMdZCXB0ThRHupJuNjWXWEOuc0HSEpb1xTyKolK62F
         DNJ5LXmLnjG4dUZU5LOaIedCUrm1QuyGAPAfAokY7RkGfzmitln0SeOAq3Mow87Nn4yt
         C6Gk4l6fqq5GxiBrHoYj6WTBDcX7YV7dKFehZphC7FJqUiEhUIcUhc0Z7dG+jMek16vL
         t6FeTc1STpQWZ7Ncxbfem2LzLzXTfidvWs0f9Bjke3PIKvLk9PgLYNRkfgRB5rDiCqeu
         a7wZHiaY36/ZvfkruAaQY1Oqr1IlGx/ebrn3F7hFCmiVQQLXXbyTP8+vk+hYhohuYPMF
         GVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734358530; x=1734963330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTO6XsUM1EpoRAEqG+118QEinm0VU7febgtSY5QZvgg=;
        b=Ap1IxGx559P0Q/O6BA+as+8VfrZ82Wdse6io4DTo/iykNfO+a+mpRgGBR/PkCUocQ6
         dHKjqrYNN8JJNg1WUk+d3MGg+MtbPph2k6hPIg8H3f3+uk0SKEXHe+aWOiBswFsff/Pe
         ITmEy8NVP7tQ9qXponysw8WbS2qsAnqJrlkGxUynFJ1Ey+aeyR9fIou5ydcbIK6f8P3d
         XX+MRutuCoXq88bCym/AEamb3EDlW8s8uMCfwSgs8pFnckYeo0Bnpfv87TYDNm5u1b9L
         M42v5H1AUyGoO82TRmGFABLks9aeOjx7qMMFz8d7ccZBNHzAPY1TJL8CNfBZuy/SfY8A
         u4hw==
X-Forwarded-Encrypted: i=1; AJvYcCXL/ZWzUjXCmcrWVbW+6vErz/bbPoZnq9OUSygRiCoavF0WVQnqg/bu1G4avrOsxLPyhOuY5A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyjHzkHdD4UhQT/oEny7M6HEKZJllEaUj5Zks6ZcLM98X22C89l
	6u/3i0lqRlPFW+TO0SyT3Olqj/eXpzJm/3zxMhQ62JBt86qJKjzor0jUxEjErz9hCZcoaeOegYa
	RkBdsVIx0ucljIVRebqMCYDpLWSzhmb2f3yoT4A==
X-Gm-Gg: ASbGncsBRoBuQ/5LdzBHSS404Kn90pUYqFxCmtuqfv0wRytju0g+grvK88jdlB4fGJW
	ULcyEYPiC0WHJTzAoVobDsidBiNc3Zntw8jaO
X-Google-Smtp-Source: AGHT+IFSDin9hEAGn8eapDBqSokmqU+717wu2Ivl65JkmX77qI/TxAECHXYsu5Why+LBdm1Fd6dvz/dzpSuP0U1zgxo=
X-Received: by 2002:a05:6512:39d4:b0:540:2549:b6ca with SMTP id
 2adb3069b0e04-54099b71afamr3494300e87.55.1734358530311; Mon, 16 Dec 2024
 06:15:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241215-msm8917-v9-0-bacaa26f3eef@mainlining.org> <20241215-msm8917-v9-2-bacaa26f3eef@mainlining.org>
In-Reply-To: <20241215-msm8917-v9-2-bacaa26f3eef@mainlining.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 16 Dec 2024 15:15:19 +0100
Message-ID: <CACRpkdbNKqOmsO=Bownp9HNs=tZfiR5rO95G50oJTo_jnusoAQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/8] dt-bindings: pinctrl: qcom: Add MSM8917 pinctrl
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
	Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 12:15=E2=80=AFPM Barnab=C3=A1s Cz=C3=A9m=C3=A1n
<barnabas.czeman@mainlining.org> wrote:

> Add device tree bindings documentation for Qualcomm MSM8917
> pinctrl driver.
>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
.org>

Patch applied to the pinctrl tree.

Yours,
Linus Walleij
