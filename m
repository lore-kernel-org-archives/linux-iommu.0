Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B232F3C25
	for <iommu@lists.linux.dev>; Wed,  3 Sep 2025 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756897228; cv=none; b=e77JKTSZRTx5AoySCgJzCyKQ1ghSy2LgA8F4/43suO+MGiE0q1OLGPOW4lt9XqBqcsA7yrCvvMZnmUtSvgxPOVWkJtcNpv1WMOcbhNbWM0zmaj5mVaCHdYoOwuhGKm6KukjFeuDjNXMSMwtpH6As+c7lnIpzUdFuLXLfCWBEVUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756897228; c=relaxed/simple;
	bh=zNqGWM1epEkBKdiCB0GgxYoHjpR2xkf2JKZQG6wXm2Q=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=r5y4oMOsd9eH727vUB3iGJqT8lKz8VfT5SV5YwDGt8WAo8tqahSF1X6Mdt3GOIf901B7/oDyF6OIle2xB5BVImIqRRJxf2Ias/1fF6iitCl4/CskRy5E/7uB+6F/i+9KVeKi2qIIzNRHipem40M7DKP4ww0usbm75TsfM0AJDZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=leJrN4iK; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=8Jg0DZ41; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="leJrN4iK";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="8Jg0DZ41"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1756896472; bh=w5KE+aRxRTKqGhguAvxb/9U
	dpO2fWn4q/HDyXbO050U=; b=leJrN4iKxY1skjcpew5WDFcPURxrUO2iv6irLXq+ZWhsELmyF6
	ea9lN4SatzsE5EtjsQvbArOr5XlmJGClyXXDLauyCflWrvd688xgkmHHBN/f3QCzBnKp/doZlUl
	VPClNOgwa7bw4dZUDejRkDYmg6AneJQbGI5i399W1D96QAI75TPbaa/Q58QBXqU03pByByOB57F
	XdVUeBQ1/gJ7eNjtbWIKtl9F9ZTVJoJaeTi4WZSyeGrjVtSz8Y4onGCUgX67/DgdQ+hu7JRQn+S
	RB+ABIs2qGb5Uzir0TKJuo93Wd+SwGIY1nMV2Z3lyPyRKHdKxJsprqAwXcBRSJAHmRA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1756896472; bh=w5KE+aRxRTKqGhguAvxb/9U
	dpO2fWn4q/HDyXbO050U=; b=8Jg0DZ41+t1Q83eXmdy96hFfUMz2eEqjtljsqYLosRy4ea5SmV
	QgfMK3yeI2tpwozUqLu8JeY7YK99Y/mwTHDg==;
Date: Wed, 03 Sep 2025 12:47:51 +0200
From: =?ISO-8859-1?Q?Barnab=E1s_Cz=E9m=E1n?= <barnabas.czeman@mainlining.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephan Gerhold <stephan@gerhold.net>,
 =?ISO-8859-1?Q?Otto_Pfl=FCger?= <otto.pflueger@abscue.de>,
 Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Konrad Dybcio <konradybcio@kernel.org>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Robert Marko <robimarko@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>,
 Srinivas Kandagatla <srini@kernel.org>
CC: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, iommu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 linux@mainlining.org, Dang Huynh <danct12@riseup.net>
Subject: Re: [PATCH v8 5/7] arm64: dts: qcom: Add initial support for MSM8937
User-Agent: Thunderbird for Android
In-Reply-To: <67aa2a1a-3adf-4c97-a7b8-865b5ca3b17e@oss.qualcomm.com>
References: <20250831-msm8937-v8-0-b7dcd63caaac@mainlining.org> <20250831-msm8937-v8-5-b7dcd63caaac@mainlining.org> <67aa2a1a-3adf-4c97-a7b8-865b5ca3b17e@oss.qualcomm.com>
Message-ID: <EA8D417C-9B17-4AA0-A448-316F8904AF90@mainlining.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 3 September 2025 12:42:38 CEST, Konrad Dybcio <konrad=2Edybcio@oss=2Equ=
alcomm=2Ecom> wrote:
>On 8/31/25 2:29 PM, Barnab=C3=A1s Cz=C3=A9m=C3=A1n wrote:
>> From: Dang Huynh <danct12@riseup=2Enet>
>>=20
>> Add initial support for MSM8937 SoC=2E
>>=20
>> Signed-off-by: Dang Huynh <danct12@riseup=2Enet>
>> Co-developed-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas=2Eczeman@main=
lining=2Eorg>
>> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas=2Eczeman@mainli=
ning=2Eorg>
>> ---
>
>[=2E=2E=2E]
>
>> +		qfprom: qfprom@a4000 {
>> +			compatible =3D "qcom,msm8937-qfprom", "qcom,qfprom";
>> +			reg =3D <0x000a4000 0x1000>;
>
>here you reserve 0x1000 for the qfprom
>
>[=2E=2E=2E]
>
>> +			gpu_speed_bin: gpu-speed-bin@601b {
>> +				reg =3D <0x601b 0x1>;
>
>and here you make way for OOB accesses
Ack
>
>Make qfprom length 0x3000 with the current base and the gpu
>speed bin should be at base+0x201b, I *think* (the docs aren't
>super clear on that)
>
>[=2E=2E=2E]
>
>> +		mdss: display-subsystem@1a00000 {
>> +			compatible =3D "qcom,mdss";
>> +			reg =3D <0x01a00000 0x1000>,
>> +			      <0x01ab0000 0x1040>;
>
>In v5, I pointed out the size of vbif should be 0x3000=2E=2E and the rand=
om
Where 0x3000 is come from downstream is using 0x1040 for vbif=2E
>newline below wcss-wlan2-pins {} is still there too
>
>Konrad
