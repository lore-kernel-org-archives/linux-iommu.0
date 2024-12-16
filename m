Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8A21DFDE
	for <iommu@lists.linux.dev>; Mon, 16 Dec 2024 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358575; cv=none; b=C1uP3SUKFOILQSigOhXN2AVsElEXgHXm4ENrS5EzdT8ZQkfZjpilw+c7dG+HgdqFmap5vxw8Gjf7CdBiZCas5hT8iS5yx8DLGLpDr8mr6zrzeRFbGziT5Gh2F9FtV5w+LtAhKFfogMJZ5HrCoKFLZns9rmalSfLcnigEs+csQ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358575; c=relaxed/simple;
	bh=9F8Sq5ILmO/gzqNtjAPdIn6tThxcdWj/OBrH8RrPyDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OsoFjjEEMKzKhO7HA5BGuSc+bFNvUluusCYDx+D/uGYFCt7o6is67VoU0TC+TB/cRKcilMJD+5US8Noxv3lWOw6veByYN2puCivfKKRqdKrVy/RvEo+mFuckW3ObOdDP3zOJDQvvqSkjL/E6d/dY4xpy6Lk9eqg2cI27oZdWI00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T5gs5hrd; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T5gs5hrd"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53e3c47434eso4244625e87.3
        for <iommu@lists.linux.dev>; Mon, 16 Dec 2024 06:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734358571; x=1734963371; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9F8Sq5ILmO/gzqNtjAPdIn6tThxcdWj/OBrH8RrPyDg=;
        b=T5gs5hrdyzRFWOBxEyUNjPQwpmOOeB0h5U6Hsfz71/IKwP20X2T8iiqypVhTaH5MNX
         Fp64JDnk3j0JYISHByKOsfWdRIqmDOuIodNKeypYrRHobQJDzroo8zFmKQGBqXf+1Tyl
         d1vyPa2hF4PhwCZOeMbiHl47SDnkEjtjgsLoSFxhERuqT6nfKSDTGoySzCkUw16qDouD
         kQtFJBdzF0LlCI9GqDnMGtrDRm0fmlPS03yNPwcAJOPAHkPjDfAFywldQadF2iVVGybx
         im3Pof8WbL+HYy5dnJZJy4rtyeG/liwxvzLVSB+9g7SSZ+RlCz77750D66DeDoFLu7Vh
         6kUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734358571; x=1734963371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9F8Sq5ILmO/gzqNtjAPdIn6tThxcdWj/OBrH8RrPyDg=;
        b=ows2Rm7diSbeSsWNJFNueAgZOQvaQ3Rj/WGZmNMQYoWV/D4UxdgdiAJOWztJ/VaKql
         wKtfMOKfV6yvmpQF8q2NcrNF3ODlWVqxmSChHr0pKh9/P4GgMElrsrOSK8CMJ4JeDHw6
         kVJAEmS9nWVJSwVe80Bfi/G3urUX+9Z71SWUVWYVyZrX1v5e/6sotLodES/eTLM40bVU
         uuPgtgNliFy6nJ9cPDGZd27JOf/xPzjKeyJqUbx3kKHNopAtAmm51Jw7bGYC6Huf9N41
         EkB1SM+J0Yy1X/yPoq4J77lFjMvwIOe3ew0cfHOh8uMJ60rdtjMde/m9lZmGFp7OecYp
         3BRw==
X-Forwarded-Encrypted: i=1; AJvYcCW5GFiUJDFK46HI32lvG0mNPrnXgW94CCeUs9B+QjKf/G9fh2fTun5i+eeoyrOTB0OHkmhS7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7SDpQBfiAEIlegoHSKwsJqicbdNzUrJgawYZiPtaM3/NExa0X
	28ZAHsr3YCbgFB1S632N2JAA7bciuYw4hsUblbXDEMdOzRZ5OE8+JUDS31gEkGygrlNg+jAwaPP
	Ugr8N5xGYcJY+4PiYCRQ5fim9xMVfOeKNP8iMXg==
X-Gm-Gg: ASbGncvrkkxvjmlDkVKlv6o0/azPor1zmdSMW4EX66U4hsrLtWqY14PGIE9h1rzA1Jn
	M1Gn4kODuX4Z81/mAJbGH5SjBhWPU3+/vjBcY
X-Google-Smtp-Source: AGHT+IHrQd48Xs7QoUHIoEZ8phO8rM8S7YX0SBFWBJmTRPojYCc8OVEoWykulhJ01DH0iWUq+AcjAkdRGx/EZIl7tsM=
X-Received: by 2002:a05:6512:318b:b0:53e:3a79:1ad2 with SMTP id
 2adb3069b0e04-540917cb6a0mr4002662e87.40.1734358571463; Mon, 16 Dec 2024
 06:16:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241215-msm8917-v9-0-bacaa26f3eef@mainlining.org> <20241215-msm8917-v9-3-bacaa26f3eef@mainlining.org>
In-Reply-To: <20241215-msm8917-v9-3-bacaa26f3eef@mainlining.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 16 Dec 2024 15:16:00 +0100
Message-ID: <CACRpkdbKrf=AXGT1PmjQ6=HFKZ-8qCy7eG6fQ2NVUUK3gJoVTw@mail.gmail.com>
Subject: Re: [PATCH v9 3/8] pinctrl: qcom: Add MSM8917 tlmm pinctrl driver
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
	=?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 12:15=E2=80=AFPM Barnab=C3=A1s Cz=C3=A9m=C3=A1n
<barnabas.czeman@mainlining.org> wrote:

> From: Otto Pfl=C3=BCger <otto.pflueger@abscue.de>
>
> It is based on MSM8916 driver with the pinctrl definitions from
> Qualcomm's downstream MSM8917 driver.
>
> Signed-off-by: Otto Pfl=C3=BCger <otto.pflueger@abscue.de>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
.org>

Patch applied to the pinctrl tree.

Yours,
Linus Walleij
