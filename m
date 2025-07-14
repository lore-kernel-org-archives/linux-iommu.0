Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA4224888C
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752496345; cv=none; b=O29XfbB2PTEniWQsg55D62JsxnBC2djakbGQeRjvTylAcDbtrU3we2mn0d48beUEDH3rqljmFZcF5/hpHsaFLCSoI1kqYEryysETjVYy2mEgoCIu2SnxoWu5Ye4wkKgaagzwRDS3dmxcLZdocUe1GfxxAgzoDr0H6hg9PXDLp74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752496345; c=relaxed/simple;
	bh=qYiuoKRE2NxLGDxKz6WhuSPkGY9D7Tn+i7spILVLy8k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=ru1K16ZMYxUbzFOGDNKn4IM3J1Gjq/KGAo4C/ZRHWl8mBKwq46WX2XUmmQ/1RPdfeRSrMQxuMSJQsQziC7jqR8ANQSF3ycrRbN1E6niJ9BXOOVRIuRV/7P0LzLLj/uw+gEHgX7FLPRUeJnb3vSiqW+88+zKTWFVhWLs5JI0+SbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=CFcI7wCV; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="CFcI7wCV"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae3b336e936so852640566b.3
        for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 05:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752496342; x=1753101142; darn=lists.linux.dev;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GT+QfWaXLUz2plhdm6tzk3KnJrg30pcNVb5s5dMBoo=;
        b=CFcI7wCV8rt3hZOSIA6jc6pbgIb0X3Yplk2sfDrWQ1YqwzyHPpw6bpMPkwYi0tGqjg
         MDBcLF2GHNHs3aaXTiOPf+u/REi+zQk1QflSDOuVG9oSH9rEByXbp8zy2loj585xDm9d
         X5jwihgXZ5ajeOxsOFrq847iUWb+h/5XRCLU2G2K6XajXXM22Ci/EXAtUL0PCtChKXTf
         GD+/fTBQLwq4J71gHfmYU+udA+AgQEZdRNiljPRxyrvDwYs8qG3xYu1FUQkGAzbr4tdT
         nHQkZENmWTbQOC4gyM73YU3yGEY4IH1M+o7Os4JbAWXIsWfZGb+u2I+Va69lHcvcLpCx
         N1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752496342; x=1753101142;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6GT+QfWaXLUz2plhdm6tzk3KnJrg30pcNVb5s5dMBoo=;
        b=ul0fzHntvDv140n7iTiEQ/+XcqIVcuLQ+J6uQtkwr4kDJq1ruYpiV1ZCA/PR3MHPaH
         2o+7PEvJncKFElSuEVHWNSYpap02367G+ErFF+aTlImIBDpqafP0o+cXO6UcZrfJ4utj
         lKtA6MWu+TfMuYlHC2C9Gn5RmZ/CssyE4KZaA68ERWDyhF4ZnbMH6Lv+dFoVEpONoykn
         G6MyuGI4PFwQRDjh70WYq6G1+blSdPQXkX4WqRvWH3qHRyK057LMC7kJsDJiyREiq7iJ
         MpY8EsFRXultd8Qaa99Z7F1wroAHHHKvroq3iGfzPQpzTFkdW6Vm9hc/Un6L2UISz1q9
         G94w==
X-Forwarded-Encrypted: i=1; AJvYcCUM7H7YPemNA17LOTno65vMHclRbr5HFuwaKoVT/4Gxo0HwQ4GFWmP68XE/ABeYBajh2erZhg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPqIEDSvurkZ3RUqtqiw0pC3JwEMqPdVWFkPtsZUWUfgRQCBeh
	vZLrhB5Bw7GuQS6XE4z0BYo7gq2NN3yzwEW++tCaRh2ODRK2TD2KCFhLmi+TRrdv4is=
X-Gm-Gg: ASbGncv/UdLbACSY4+2eGSsN4DYbbq7C2GwDyiDouuINk/chHVwm175lbd9vTzWg9ut
	z9ffwmFVUnSKXgm7E/+6PUK8z1k7XSBDrSzD8QjrNDCRt9zrdYkjgn7DqfiFplvN7ZTFB3IcNmV
	ZfbaXz1H0CP27Sd8EFkOdNYYhVGKYXjbU5OxZVF6BzD+kOh1av8URfww01zTtax08a8qPkp9T86
	qhibbHvgNSN7fK+XqYMsy4NaUHLzmE35pygdR4QWjaniPcEXzq5AanJKieZuXrWwIVEyATmvCaR
	Lj4wuDw98dPBcawK58yTxQUk4inJlSoO1aA2+xh7vQXJdSL3ev59W5SLCidukcEWMeT55rDZBek
	PdZ97YTcT4yi2X7ysr++ySSGOcvyHm20zgJIeRvWX6T/doIH0L7ejbQ6/blfmPIi5H0IwzzFp/g
	UprBC3TIQ9ehDJ2jrI7ZeArfsN6WPm7FpUDw==
X-Google-Smtp-Source: AGHT+IEdIUlKAIUoH3odRS/w1x3zJL/78SxmRMa+QOLnmU3zwNSH9f5FMxlA1f2U3nn/eb6t4vkm0Q==
X-Received: by 2002:a17:906:7956:b0:ae3:cd73:e95a with SMTP id a640c23a62f3a-ae6fcbc356cmr1271518666b.36.1752496341821;
        Mon, 14 Jul 2025 05:32:21 -0700 (PDT)
Received: from localhost (2a02-8388-6584-6400-d322-7350-96d2-429d.cable.dynamic.v6.surfer.at. [2a02:8388:6584:6400:d322:7350:96d2:429d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82962acsm818540766b.139.2025.07.14.05.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 05:32:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 14:32:19 +0200
Message-Id: <DBBS3S38CWTN.32RLYB9VEZAB@fairphone.com>
Subject: Re: [PATCH v2 15/15] arm64: dts: qcom: Add The Fairphone (Gen. 6)
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Will Deacon"
 <will@kernel.org>, "Robin Murphy" <robin.murphy@arm.com>, "Joerg Roedel"
 <joro@8bytes.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Manivannan Sadhasivam" <mani@kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 "Vinod Koul" <vkoul@kernel.org>, "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>, "Robert Marko"
 <robimarko@gmail.com>, "Das Srinagesh" <quic_gurus@quicinc.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, "Jassi Brar" <jassisinghbrar@gmail.com>,
 "Amit Kucheria" <amitk@kernel.org>, "Thara Gopinath"
 <thara.gopinath@gmail.com>, "Daniel Lezcano" <daniel.lezcano@linaro.org>,
 "Zhang Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>,
 "Ulf Hansson" <ulf.hansson@linaro.org>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-15-e8f9a789505b@fairphone.com>
 <6f8b86c7-96a5-4c7c-b54e-25b173084d95@oss.qualcomm.com>
In-Reply-To: <6f8b86c7-96a5-4c7c-b54e-25b173084d95@oss.qualcomm.com>

On Mon Jul 14, 2025 at 2:19 PM CEST, Konrad Dybcio wrote:
> On 7/13/25 10:05 AM, Luca Weiss wrote:
>> Add a devicetree for The Fairphone (Gen. 6) smartphone, which is based
>> on the Milos/SM7635 SoC.
>>=20
>> Supported functionality as of this initial submission:
>> * Debug UART
>> * Regulators (PM7550, PM8550VS, PMR735B, PM8008)
>> * Remoteprocs (ADSP, CDSP, MPSS, WPSS)
>> * Power Button, Volume Keys, Switch
>> * Display (using simple-framebuffer)
>> * PMIC-GLINK (Charger, Fuel gauge, USB-C mode switching)
>> * Camera flash/torch LED
>> * SD card
>> * USB
>>=20
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>
> [...]
>
>> +	reserved-memory {
>> +		/*
>> +		 * ABL is powering down display and controller if this node is
>> +		 * not named exactly "splash_region".
>> +		 */
>> +		splash_region@e3940000 {
>
> Was it not possible to arrange for a fw update after all?

I've made a patch to support both 'splash' and 'splash-region' but not
sure when it's going to be included, I've sent the patch to the correct
people internally last week. Since Android build cycles are always super
slow, it'll take a the very least a month I guess.

>
> fwiw the rest looks good

Thanks!

Regards
Luca

>
> Konrad

