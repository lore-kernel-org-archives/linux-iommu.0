Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2625D25F97E
	for <iommu@lists.linux.dev>; Tue, 29 Jul 2025 06:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753771797; cv=none; b=QcVXZx1VU/pzT04ke/vcrD2SoW7+1cYnEMbD6F0Hzzm5vPdIuAvgqUEu2EWBOjcPqu6UBhORha9bYOoACERj1DCON4jUOvldQq21z0uxZXBVeXpSXEMBa+hqfHncyWOGA7v9u2rGllTzZ4g66nmgI2ZcUJg9TfDbrtfhBRZ1nT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753771797; c=relaxed/simple;
	bh=EOhJI4XE7EmddrlB9TelXwBH+e7RrRI3HJn7pIRR/rk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XEy6zIEYTGPDFjTSkhQIG6u2yG/0cpGAEwKKPu6YzQZXCCQJBrimItcJ0DDSlOvUj2njsk6BRAHhOCDfXJ/wv6W0WujyOaPVxXC1Nb6BYBgtxUrmY6LchoGMLCpMEZ/hk0ohdwELcqDtMzgFzxiVWICzXFOmxUnR02cJaZB0u5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=ehibNYNj; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="ehibNYNj"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61553a028dfso1826135a12.0
        for <iommu@lists.linux.dev>; Mon, 28 Jul 2025 23:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1753771792; x=1754376592; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tvO0qmfUNC2jqa8M7kzzmnccGVoia4ygdONyDNCxVc=;
        b=ehibNYNjSPCakBXdWTzIiEaoL5OMbnOPtc2tFXrTvjVqqPy34K+t08wdcb7vY/ufIM
         kFqZq2puvUSnPP/GXkKnlX5rb5m09WYf2eHShkhuK/ZZ/5K98vYpkKu2CZUH9kjQwjQn
         NUc+4fA3/tsaTOd7HdSlmMOYVyL6nTSxeTK/diSkFlE8OndjPe5M/ciPQi681R89/TuD
         okDuS7ATMUHk/yay8tooL6hLuGZWmatm0DKt+hfTeIlLGAqIWgfXZTJq0Q1NXf71gioq
         AYdXbfkRLTltO5NPr+XHe+FAWqShbn7p2hhFgwlxy7gQmO6B5L+HCOykcka10cLAVkAV
         i95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753771792; x=1754376592;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0tvO0qmfUNC2jqa8M7kzzmnccGVoia4ygdONyDNCxVc=;
        b=u3CuSXQtEzpxHQ/OCfOBqXGjEe75KXe1gi/swS+ft+pMyJtSyxZwxH3URD4BR2NMPP
         yg+cXc6hPPZ5En8+7D0/33Sw8fsvFYL5E3u1yeneevom02HUOiBw9Wb83QRGp/yadjG+
         1F1W1Vu+z57tpsDMFFKf4Gg/G30maK8tidqigOfUzww49KAS5Xfhe0QJWtjvGPOvURqW
         x2a3wAfVMnGyDErlkO5bKMxMF+fLDETRjEgloUT64kvLshVkaz8d+NXK7wJQw/rVFNQR
         3VD1P8Swvf3HITpMRuWtdmifXlyZE+sahcUPbHSqzScKZtpF7JO1rvsQODIzHBzEUwGP
         VyDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9LIo0j79O9no/qTkEbrmQ8Lr0xSDyNCbRi823iNCQMGxmvRKYiDUBmBsDRsaazJwqRYjWEg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVAGBuYzgD3kQq4AeXLXTyVII0FIpPJ1a2xuObf0Qf22a5sQLQ
	fB0GRnBISb9cs+JSx+ufVJMWS0YCxw/BEaxrq+JH37bDHHmBOk4QSIc+G/LAoKCGnRw=
X-Gm-Gg: ASbGncu4KfmYnshL/xC1DhLBTANAI8CaBCY74ikTO1p8zdM0483J0KD23MRpVus6TVr
	Eu0qIlwiYeAscxc14/ngAYNQhMOSo7nTG+a9bQZ8ePMIWSAp9xsUBPra0LfneTmL1d7jO6p05d7
	kHRuBHyoDyHdmUtxAZ43OuooS34gg9ygqRm+S0kRRvoA8L9s737wd2rCXUvVoAHuEpZEHVtPSZW
	4/u7mYmCh7TKVPeLldY1XyRFKiEXf+shGZ//55ZQsRLp2grGyVavM9plxl0LoHzOPLgWTm8Bsj1
	eNCxZccGW//ha+9DZYDyog+ZHGVuTrE96E71OAoBUi8r55gysKeWYgsc8AaJMk1Xzhd+XsNVGir
	SK2qZaCg/Q2lJnORmudG5lDdKe8s7GHDWHMtaevRwaYSyfBDRNu+nH92tx2lU2KykLCg=
X-Google-Smtp-Source: AGHT+IFY1cXRHhDZKmmaOPFoMzRlis7auiB0SY6wze0NFezD/noiXwvsAjKX3xVSDeubNvW/ghlrqg==
X-Received: by 2002:a17:907:868c:b0:ae0:da16:f550 with SMTP id a640c23a62f3a-af619d062b6mr1776275666b.49.1753771792232;
        Mon, 28 Jul 2025 23:49:52 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af6358600b1sm546209366b.7.2025.07.28.23.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 23:49:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Jul 2025 08:49:50 +0200
Message-Id: <DBOC7QBND54K.1SI5V9C2Z76BY@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v2 14/15] arm64: dts: qcom: Add initial Milos dtsi
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Luca Weiss" <luca.weiss@fairphone.com>, "Konrad Dybcio"
 <konrad.dybcio@oss.qualcomm.com>, "Will Deacon" <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, "Joerg Roedel" <joro@8bytes.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Manivannan
 Sadhasivam" <mani@kernel.org>, "Herbert Xu" <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, "Vinod Koul" <vkoul@kernel.org>,
 "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Robert Marko" <robimarko@gmail.com>, "Das
 Srinagesh" <quic_gurus@quicinc.com>, "Thomas Gleixner"
 <tglx@linutronix.de>, "Jassi Brar" <jassisinghbrar@gmail.com>, "Amit
 Kucheria" <amitk@kernel.org>, "Thara Gopinath" <thara.gopinath@gmail.com>,
 "Daniel Lezcano" <daniel.lezcano@linaro.org>, "Zhang Rui"
 <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>, "Ulf Hansson"
 <ulf.hansson@linaro.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-14-e8f9a789505b@fairphone.com>
 <3e0299ad-766a-4876-912e-438fe2cc856d@oss.qualcomm.com>
 <DBE6TK1KDOTP.IIT72I1LUN5M@fairphone.com>
 <DBE8G88CIQ53.2N51CABIBJOOO@fairphone.com>
In-Reply-To: <DBE8G88CIQ53.2N51CABIBJOOO@fairphone.com>

Hi Konrad,

On Thu Jul 17, 2025 at 11:46 AM CEST, Luca Weiss wrote:
> Hi Konrad,
>
> On Thu Jul 17, 2025 at 10:29 AM CEST, Luca Weiss wrote:
>> On Mon Jul 14, 2025 at 1:06 PM CEST, Konrad Dybcio wrote:
>>> On 7/13/25 10:05 AM, Luca Weiss wrote:
>>>> Add a devicetree description for the Milos SoC, which is for example
>>>> Snapdragon 7s Gen 3 (SM7635).
>>>>=20
>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>> ---
>>>
>>> [...]
>>>> +
>>>> +		spmi_bus: spmi@c400000 {
>>>> +			compatible =3D "qcom,spmi-pmic-arb";
>>>
>>> There's two bus instances on this platform, check out the x1e binding
>>
>> Will do
>
> One problem: If we make the labels spmi_bus0 and spmi_bus1 then we can't
> reuse the existing PMIC dtsi files since they all reference &spmi_bus.
>
> On FP6 everything's connected to PMIC_SPMI0_*, and PMIC_SPMI1_* is not
> connected to anything so just adding the label spmi_bus on spmi_bus0
> would be fine.
>
> Can I add this to the device dts? Not going to be pretty though...
>
> diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm6=
4/boot/dts/qcom/milos-fairphone-fp6.dts
> index d12eaa585b31..69605c9ed344 100644
> --- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
> +++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
> @@ -11,6 +11,9 @@
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include "milos.dtsi"
> +
> +spmi_bus: &spmi_bus0 {};
> +
>  #include "pm7550.dtsi"
>  #include "pm8550vs.dtsi"
>  #include "pmiv0104.dtsi" /* PMIV0108 */
>
> Or I can add a second label for the spmi_bus0 as 'spmi_bus'. Not sure
> other designs than SM7635 recommend using spmi_bus1 for some stuff.
>
> But I guess longer term we'd need to figure out a solution to this, how
> to place a PMIC on a given SPMI bus, if reference designs start to
> recommend putting different PMIC on the separate busses.

Any feedback on this regarding the spmi_bus label?

Regards
Luca

>
> Regards
> Luca

