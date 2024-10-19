Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8380A6EB7D
	for <iommu@lists.linux.dev>; Sat, 19 Oct 2024 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729348712; cv=none; b=GpTRS+isPBlF98ATi2t34TWWkeQvbRGVf5ntqT1iPzXNe/8vs40mp1gG8JROIL0tsq5QpJE9KS+e5eYhCjNApnXxucf5KATCkE2t/D2J07hetxkaaNyekvY8isoKOUJOzQJF1B3UpykIL3+nASTFSosSM/yE4HCFNBRhHzYc9yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729348712; c=relaxed/simple;
	bh=uSr8iW8u072v5rIzh2Xvj2FyMIHzFYehI3ht9DlONgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SejqcRE5wTbJYVMLLKy8eF5F7aIKoIZP32aXpYoygD048zCYO5/gCfyK7FoD2lC4fk9vDEiv3+uNQy0TiQZ9sNEhSnz/N5ew8mePvqtEkmu1/v8JXIC+Wi1aagsbyrkWiGN2D/8z1tzeM+tGvgroIzevgxp7HvHsY16ZUo3M0nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RIOIdFie; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RIOIdFie"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539f2b95775so3765455e87.1
        for <iommu@lists.linux.dev>; Sat, 19 Oct 2024 07:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729348708; x=1729953508; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mZ3yQ1UiurVnRgduM5emLowFyOjkjJUfniSP6diFGgE=;
        b=RIOIdFieXEDypY7hw57tI7iM/q7j/tdzESSK9jkEkEWeJwjnKhaDPMQXRAzIr9/InE
         A13LcbAY964gtDQD26XvAowrDROaUVKtzyCQXZ8qmWPq6Am0fp3BUyObPZ6OMTM/sV+k
         vq1j2XqbpJnPTYcerdxQZ2ekHbcogn2HUFH7cgFxgXzbrO3xKagyHcVd67F8i4/o5p0T
         4BL6y+WiFf+Df936zuPbt0XDoINIhGJ2jTMi8p43GD8PIFk6LyMctxsaykjEWx/Jo+mG
         B+MuQM9c0sD34NbJElD7dxsYkdNBlrxNyYk0ZrIa3mVO2ur2xErIjrNPLgHuBHQGXnkH
         oFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729348708; x=1729953508;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZ3yQ1UiurVnRgduM5emLowFyOjkjJUfniSP6diFGgE=;
        b=eo5XQ7mIXwJ7ZYA26xnLff+Q08MWY9iC/85ArLHhCdYG11JC+8FN4aW1VVKUvQOxx3
         kDdRHuLycM78Rvs1nzmmvmkGyH+nnKm1Zg2MvIiVF0wTXUm95apC0seXnwrMTM53UTxe
         bFbsZEv5YOwLp+DGT1EIM5LYPOUsBBjdV6bGWjoszqoF5912ubrFBxLm1YshP6tO1IGl
         p2aKT/BHN4TTXo+UtipUY2zPUa2SA/oQ2htjyQb/KJPu/Cr7F2cuEi9hWRggRUV5n4b8
         UjykkBKTv1hGDgUH0b9Ns2v4RcSOyNtrMghYof9bStrBN2fZBMP3kn6awtjzrX+lbsRb
         tM/g==
X-Forwarded-Encrypted: i=1; AJvYcCVpKyo7hoVpkl9tO7T1nPbAHbIpN9xhZ1Amg4oVggwlQDK0Jn8D9SOZGJWqpKCVaXYtPpo7OQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzuIFcLYFKNrzrfxcx7tIZ5UpyK/4hNri9dcqqjFttEW+vYt4Lt
	mwOzTe2zXNBZQrhU9gqHawMNELzG8dPOD6y3oJPVbiVb1CitsiX/C95ceFSl72k=
X-Google-Smtp-Source: AGHT+IGnt7E9LzAEkP0FypPLsT5f0JfGLMaOFtDn02NOfEsnFzpNbn/3gWRj0jSNp1qcIMjsdz4/OQ==
X-Received: by 2002:a05:6512:350f:b0:536:55cc:963e with SMTP id 2adb3069b0e04-53a154ca15bmr3965578e87.44.1729348708487;
        Sat, 19 Oct 2024 07:38:28 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151f0b42sm543903e87.168.2024.10.19.07.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 07:38:28 -0700 (PDT)
Date: Sat, 19 Oct 2024 17:38:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: barnabas.czeman@mainlining.org
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH RFC 14/14] arm64: dts: qcom: Add Xiaomi Redmi 5A
Message-ID: <jj4ky6uuidv3rdjl7q4ehe7cdgcjxtnmtcufmy462gznkjiex2@pptv6aufsudj>
References: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
 <20241019-msm8917-v1-14-f1f3ca1d88e5@mainlining.org>
 <pyr3t3kcpjj5zor226fwembjsbpp5zh7mpe2a3bqmwnbqccj7h@a55efscym3s7>
 <46f7b167220a7d54242e9457d00d67e2@mainlining.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46f7b167220a7d54242e9457d00d67e2@mainlining.org>

On Sat, Oct 19, 2024 at 03:57:54PM +0200, barnabas.czeman@mainlining.org wrote:
> On 2024-10-19 15:48, Dmitry Baryshkov wrote:
> > On Sat, Oct 19, 2024 at 01:50:51PM +0200, Barnabás Czémán wrote:
> > > Add initial support for Xiaomi Redmi 5A (riva).
> > > 
> > > Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/Makefile                |   1 +
> > >  arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts | 295
> > > +++++++++++++++++++++++
> > >  2 files changed, 296 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/Makefile
> > > b/arch/arm64/boot/dts/qcom/Makefile
> > > index 065bb19481c16db2affd291826d420c83a89c52a..79add0e07d8a5f3362d70b0aaaaa9b8c48e31239
> > > 100644
> > > --- a/arch/arm64/boot/dts/qcom/Makefile
> > > +++ b/arch/arm64/boot/dts/qcom/Makefile
> > > @@ -59,6 +59,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+=
> > > msm8916-wingtech-wt86518.dtb
> > >  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt86528.dtb
> > >  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
> > >  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-yiming-uz801v3.dtb
> > > +dtb-$(CONFIG_ARCH_QCOM)	+= msm8917-xiaomi-riva.dtb
> > >  dtb-$(CONFIG_ARCH_QCOM)	+= msm8929-wingtech-wt82918hd.dtb
> > >  dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-huawei-kiwi.dtb
> > >  dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-longcheer-l9100.dtb
> > > diff --git a/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts
> > > b/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..7553f73603fc87797b0d424a2af6f2da65c90f5f
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts
> > > @@ -0,0 +1,295 @@
> > > +// SPDX-License-Identifier: BSD-3-Clause
> > > +/*
> > > + * Copyright (c) 2023, Barnabas Czeman
> > > + */
> > > +
> > > +/dts-v1/;
> > > +
> > > +#include <dt-bindings/arm/qcom,ids.h>
> > > +#include <dt-bindings/gpio/gpio.h>
> > > +#include <dt-bindings/input/linux-event-codes.h>
> > > +#include <dt-bindings/leds/common.h>
> > > +#include "msm8917.dtsi"
> > > +#include "pm8937.dtsi"
> > > +
> > > +/ {
> > > +	model = "Xiaomi Redmi 5A (riva)";
> > > +	compatible = "xiaomi,riva", "qcom,msm8917";
> > > +	chassis-type = "handset";
> > > +
> > > +	qcom,msm-id = <QCOM_ID_MSM8917 0>;
> > > +	qcom,board-id = <0x1000b 2>, <0x2000b 2>;
> > 
> > Is this required to boot?
> Yes

Hmm, did you verify the dts against DT bindings? I think you need to fix
them.


-- 
With best wishes
Dmitry
