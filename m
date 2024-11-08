Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9739B1E0B82
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056596; cv=none; b=MDhlMoOXehjPQyXQS7n3unPZTv7QNi4OP6xrumWnke/VAe8plKtj41TMvBp8rzpuFnAUgiivn8asVtAZGGq77YDOp9/1A1Iwl4IHKamb5sFyiXgsxlIkjFNSxJV9zpp0YLXPzRWKo/XAldBvFCezR3zHh7dOL/zBe2CQ1gufVpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056596; c=relaxed/simple;
	bh=mM1q+PpNsdlYYSy0+MS7uMGw3FOxO3A/2cgbrpd+lLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIcuXRziNP2u0d0RW+Z7TLDoEQIXBikRb3yij3DAh3zztruAYM+/IaGGrFHycE/+6zMg4NE1aEnVkap0AZkklyaAtQr7QF4td0y8Sutxu+SFeIYvWHdFkLk68/aszfkgAsTXkWVhd1C4cYbLYiWhDVABOaqP4WmF0905wbwaMSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o4rIq3pa; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o4rIq3pa"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb3da341c9so18563841fa.2
        for <iommu@lists.linux.dev>; Fri, 08 Nov 2024 01:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731056592; x=1731661392; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mM1q+PpNsdlYYSy0+MS7uMGw3FOxO3A/2cgbrpd+lLQ=;
        b=o4rIq3pahrpiEeUUjdWvqJxw2pnJLRY8ih04LJQ7hqR0eC2m6VJK0APib9lxnnpMkZ
         nRz6XYQC1Qjtsm1MhsnGQoexC0uHGGdXs7DADC4DsIAweSEXuNtoG/Tx3lzRaUt/i9kI
         2uXrGS83wRHSvdsF8MzwETBCbdKSIRlOpK178VcNN5bN5rBUjhe0IHO50D6sSB+C55w0
         ViBJUY2fRE10dhu6uFIYt0TqdM4fKTL3qfVjrnDp2H+F+gjk8B2jX1SDYEXtXOjc6azY
         W5ccYCxWtEIK4MZHdBSJZRt15IknInSLczecU7P8UjqYpocUBAV68cDF//ySItx/2LpK
         Mr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731056592; x=1731661392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mM1q+PpNsdlYYSy0+MS7uMGw3FOxO3A/2cgbrpd+lLQ=;
        b=mtJgmgzQpuLwSGbniHAzpRgS8KT3WXRWRwvkRGhf1P69E9hVwUaCDoSwa1dKM1VCi1
         xkvNsWHdbN3hEGa5gFElu6Em9domorNl0p1P6jp5KuvM9ZPnFZ8Eyc5ohxtcqBhDZxds
         IPe9QIiKuEGSWjcpUmHLxFYiDgN1M7ALu0WXF4iUBvOMu7ssCmRemykrhLHpseFC8zPF
         UT15XlLgFMQ2S7RPTZnwHLFhcReXJnN+hU5NGCWXsZibe1soXWtbr62W9DrGYPh8vdVC
         vVq7tC1Yio95j6Eh4J0Bw80qxahaJv05ZuU/OnrykBNZas88kelBQVh5+KRiZrTloint
         0Mlw==
X-Forwarded-Encrypted: i=1; AJvYcCVxRp38h1H7ZnzHcKhKUpkYQHD8y6UYhTmkXm8ssMBMTqz0ybb8VCuOCklaTjxklL64BJqNQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzT9jKHDXW43hhnTnwRffTWf3MIfDBN9SuTXGxCZKitllxKl/2o
	ON7AqgfdwoXN+f70ER9x2M67pL54OiGkXtw7xzgMN8Vkl2nS5UkuzFQcXbv4rISEW6jrSQCm57H
	HpTGWHmacIU1BbhuEhWB02dWyMjzgXgnABG/RIA==
X-Google-Smtp-Source: AGHT+IE8znKU2mORtpqCkmsGs3P+cyt3qFPqf5rFKSs3v09PAE6qN06MrjzRnmT+Va62FCJoM1OHaIoEnk1727lsx7Y=
X-Received: by 2002:a05:651c:554:b0:2fb:4ca9:8f4 with SMTP id
 38308e7fff4ca-2ff20209f08mr9538661fa.23.1731056591608; Fri, 08 Nov 2024
 01:03:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241107-msm8917-v3-0-6ddc5acd978b@mainlining.org>
In-Reply-To: <20241107-msm8917-v3-0-6ddc5acd978b@mainlining.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Nov 2024 10:03:00 +0100
Message-ID: <CACRpkdamugexe6y24Tk2fDYPP_t7QLynibdGQrUMFMwF4y90cw@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] Add MSM8917/PM8937/Redmi 5A
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
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Dang Huynh <danct12@riseup.net>, 
	=?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 6:02=E2=80=AFPM Barnab=C3=A1s Cz=C3=A9m=C3=A1n
<barnabas.czeman@mainlining.org> wrote:

> This patch series add support for MSM8917 soc with PM8937 and
> Xiaomi Redmi 5A (riva).
>
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
.org>

I merged patch 1-4 from the v2 series, don't think the have any differences
in v3.

Yours,
Linus Walleij
