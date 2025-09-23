Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80AD30F959
	for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758621345; cv=none; b=TqP2et3lBQ0gR20dh7xmUy2MV2e3h3CFFpZeBPpBSB6LGACtXIxOcOm2D2zeXB5bsCR/i34u6UscdjTMa0QXkaKOUBqG//9crJ9921m8tzZZsroIuntc4C4ayzPqPV6kMB/uXNBv1gn9Lfu+alMGHHBx0rkA9uwV6fu2lr991lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758621345; c=relaxed/simple;
	bh=e5NOGt0T1QOZxsKIPNmxZjkQ42IMvdnLCXJEh6LT0RM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=JyLXFzqOJsPbL+eINubGFDVj4nBeKwtgyAvBaBc5lX0VxEXa4SpCoFo6d/jwz2EZiEK6jv0Gr17AjRWkSuo/8nUbeRoYTcZKV67sBSUuiprKd37Yf9hQQR5Wbz1BGeHbt0JDPSRNjDrM+JORD8qWCNdTIetIPfh7jz21lkXHc+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=YpNfUW8+; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="YpNfUW8+"
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-61cc281171cso8624978a12.0
        for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 02:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1758621342; x=1759226142; darn=lists.linux.dev;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJ4iR0ikwChD7GAZnfT4r7240QnDqgcDQ/DHGsIuO5k=;
        b=YpNfUW8+fkTmcw3ZPJGlUko5d5nvCpxdwPawSSz8mDVtSmi+T5Ax2Y6PZU72j70W/L
         a1TmyQSaDgdtRsCRLt2ogks1gLI5VpZn7oEtmBJLmkHRJuD7/sm343BV+O/PYljjdL96
         sjimrXoRR/dTKp4O7zKaeGESfplOGH1DROmJUF1g7fDoozogwgPppNBIcK3gu6OKE4sV
         pMgOJjvS9kfim5BBoTMeRNsCpaeSUL5VB65r45PsuO1DzOGWnCyBbjdjeTcX6344bOOW
         PnQqBCf3jRgt2glumQ0qp+m+bOnuKKKYu82a3immmfDRbpXTW1ToVVfEHXhrTc3IjiHw
         LAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758621342; x=1759226142;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rJ4iR0ikwChD7GAZnfT4r7240QnDqgcDQ/DHGsIuO5k=;
        b=oN8u0eSAPufkvFRJHqL9VyoanPjwbHXuUAjZIGJmRkuquuX4TTybdzr+EW+e5MoUW7
         knpKHThQTHKhaqTOQYHfKAv9YS1Xyh2u/G6rDQ47u5kIBWJcUakKALkey4CnItf5+VxM
         dmrjnKmaQEm3fUYR3v+lURn4ISi7inAe8/JpQAKmcUWfV9/srX+gdkZbUQThK3M977zL
         +1YpE4WMuX30LBU3E4qfBCzJqjWt3VfdaJ1dsmhULVKyt/TvKuNlZAoLXU4+5F86uChB
         oBaux8gDrAA/wMIfzJeuS5cxI1BX2HRuYQ6PHjHW6omgfUYfmaRSB0rAYd+GElGuCrE0
         60rA==
X-Forwarded-Encrypted: i=1; AJvYcCWu9KWtgnGGcquBWYNNMCdB9kMxrZODr52mjLomn61C+y1Mld1n/U9WnbHNww/X0WcsPMjLSw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHZ7fnKHZEM7EpHx8s5Gc1RnGdIidHMwW2JUZylxBuweImL3xu
	GRIkTDtOx6e8rAIdvdZ1R2Zxj97tpkaF13ElzFjhFVhHV2zLt5XGUCQJsUkkWODgjAs=
X-Gm-Gg: ASbGncunfBu1hzxTS3AW9Gd3CqPIdJuteNAwPL2RuFTKLeJbF+0iN7XhwAZSBQeGG1O
	UA68UvTIw4uT0H6q+k9gKvQGbBVFaR6w6Y46cztfnp/2XGgOhHXz2CbUCPucshHRfiCdJ04Tc22
	EkOHjBXabO3cshyxT/84fsftU/uETvWWxL/bXVI9Dv4oTMi3QFn5wZwBiDNZYM/fNdINq7z51G6
	5vhAUybwoQjKiueMm4JTQS2G4lJU3bKILp2AiLjrEh7WNiqlEGvbDgVurjXbABTKkL5rRman0TM
	zk1xNIY00lOMmmpzMrNZRx1pI+zFugNzDGUl2nR2eA/oPK3V1oetWTgrJiLZfN+SUmpl2tS1G8N
	FayLsPRiS7w8IvGCFXQ8/b5r7Y6dBFFE0WITc2LTUxKSxwz2nwJOmsPJbE6ZGYc+vsxJz
X-Google-Smtp-Source: AGHT+IF4qTxhg5Hb9sQ/tJAzBa4Ees7FfG50FOAI9GBuf35fyxLYwKPlFRuv+uHkCbA78L9NSJbk0w==
X-Received: by 2002:a05:6402:4389:b0:634:4e0:8360 with SMTP id 4fb4d7f45d1cf-6346779a012mr1708846a12.2.1758621342052;
        Tue, 23 Sep 2025 02:55:42 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5cfa6f2sm10771105a12.6.2025.09.23.02.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 02:55:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Sep 2025 11:55:41 +0200
Message-Id: <DD038IVOWESM.24X3EZZXH3UE@fairphone.com>
To: "Pavel Machek" <pavel@ucw.cz>, <barnabas.czeman@mainlining.org>
Cc: "Bjorn Andersson" <andersson@kernel.org>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Stephan Gerhold" <stephan@gerhold.net>,
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>, "Linus Walleij"
 <linus.walleij@linaro.org>, "Lee Jones" <lee@kernel.org>, "Joerg Roedel"
 <joro@8bytes.org>, "Will Deacon" <will@kernel.org>, "Robin Murphy"
 <robin.murphy@arm.com>, "Konrad Dybcio" <konradybcio@kernel.org>, "Sean
 Paul" <sean@poorly.run>, "Abhinav Kumar" <quic_abhinavk@quicinc.com>,
 "Marijn Suijten" <marijn.suijten@somainline.org>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Dmitry Baryshkov"
 <lumag@kernel.org>, "Adam Skladowski" <a_skl39@protonmail.com>, "Sireesh
 Kodali" <sireeshkodali@protonmail.com>, "Rob Clark"
 <robin.clark@oss.qualcomm.com>, "Abhinav Kumar" <abhinav.kumar@linux.dev>,
 "Jessica Zhang" <jessica.zhang@oss.qualcomm.com>, "Srinivas Kandagatla"
 <srini@kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <iommu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <freedreno@lists.freedesktop.org>, <phone-devel@vger.kernel.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <linux@mainlining.org>, "Konrad
 Dybcio" <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v7 6/6] arm64: dts: qcom: Add Xiaomi Redmi 3S
From: "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250831-msm8937-v7-0-232a9fb19ab7@mainlining.org>
 <20250831-msm8937-v7-6-232a9fb19ab7@mainlining.org>
 <aNGLPdmOyh/pfroq@duo.ucw.cz>
 <97ee369f6ffbe42c72c57ebd72887b23@mainlining.org>
 <aNJKniJ46YuUsbQ+@duo.ucw.cz>
In-Reply-To: <aNJKniJ46YuUsbQ+@duo.ucw.cz>

Hi Pavel and Barnabas,

On Tue Sep 23, 2025 at 9:22 AM CEST, Pavel Machek wrote:
> Hi!
>> > Hi!
>> >=20
>> > > +	led-controller@45 {
>> > > +		compatible =3D "awinic,aw2013";
>> > > +		reg =3D <0x45>;
>> > > +		#address-cells =3D <1>;
>> > > +		#size-cells =3D <0>;
>> > > +
>> > > +		vcc-supply =3D <&pm8937_l10>;
>> > > +		vio-supply =3D <&pm8937_l5>;
>> > > +
>> > > +		led@0 {
>> > > +			reg =3D <0>;
>> > > +			function =3D LED_FUNCTION_STATUS;
>> > > +			led-max-microamp =3D <5000>;
>> > > +			color =3D <LED_COLOR_ID_RED>;
>> > > +		};
>> > > +
>> > > +		led@1 {
>> > > +			reg =3D <1>;
>> > > +			function =3D LED_FUNCTION_STATUS;
>> > > +			led-max-microamp =3D <5000>;
>> > > +			color =3D <LED_COLOR_ID_GREEN>;
>> > > +		};
>> > > +
>> > > +		led@2 {
>> > > +			reg =3D <2>;
>> > > +			function =3D LED_FUNCTION_STATUS;
>> > > +			led-max-microamp =3D <5000>;
>> > > +			color =3D <LED_COLOR_ID_BLUE>;
>> > > +		};
>> > > +	};
>> > > +};
>> >=20
>> > That's single, 3-color LED, right? Please see LED multicolor support.
>> As far as i know aw2013 driver does not have multicolor support.
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree=
/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
>
> I believe that needs to be fixed before more bugs are added on top to
> work around that problem...
>
> ...and before that bug is cemented in the ABI.

Honestly I don't think it's reasonable to expect people contributing dts
to then first start patching existing LED drivers and adding support for
x y or z to it, and block dts addition on that.

At least in postmarketOS the user space components we have (e.g.
feedbackd) detect the LED things (and most others) automatically since
various devices have various different setups. So once/if aw2013 gets
multicolor support, the dts can be updated without problems.

Sure, maybe today changing something on the N900 which would change
sysfs paths is not the best idea because people will probably have 10+
years of random shell scripts lying around, but nowadays we usually have
better ways of abstraction that can handle that.

Regards
Luca

>
> Best regards,
> 								Pavel

