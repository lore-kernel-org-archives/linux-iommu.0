Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA5F29B205
	for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 11:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751024042; cv=none; b=QVDVSX+eqvmrNRq5IpbfpvlT/CJImjyeqTrdMsubzL2lvQdBd31nYa9JTDpJiPUY9AyO42C5sRPPsoAoGMjfjqn/PFI2RZ/LYkA7Z94YmKhciYhntpmJXt95x1+9P/pMHFVzS/ZhdJDzczJ/o4VLcE+sh9xlQXCG0SL48R4oTlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751024042; c=relaxed/simple;
	bh=nrg/5Cr/Ct/L2mrn4jAnolMDR4V2365AXYCSvZSKjPs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Szgy0LbpiSNwj2/givm2KRodXKpf3AoziSDMV3E9IEhJSYPBVkg+fAQa0rTAcWcO6AFofk2zpMOC+kVQB75wVgCQlr5F81GwH/NfAj6foQ2sqi3mTDmMzPqj0isOcR8FseKejT/jbpddMl20Co60B3bZftfkg61V3swZ06D6IzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=4ej9JeZH; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="4ej9JeZH"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6070293103cso3296241a12.0
        for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 04:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1751024038; x=1751628838; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TQIk1vNThf+KbhPSV308tydy65v8ZFP99g2fX+hJzE=;
        b=4ej9JeZHyP0uXb7VveFyM3hUKJUYW6+O4hrCKudcVXE1l5XptBzdBnQfVA69yR4Maj
         9fXTk/avqoQTlPrIA2daoaytma3Sr4N+WNypFsvDCTur9k3ACGrwEiTQXqD7flAKE057
         Q3aDVpnvdu96Yi8NbwmMJSrDIoYGdYeqDt8N/AeQ2BMhiLKdvS4bs3Nl8FOG2iGOW/xa
         +y/kc7KgT305sJOcQoKX0KmgQU7wdjmpPoiLI3qfa0E2TqAdvf1kElJPWv/jcd7EdjLa
         NgGxp7HKXiWeKD9wbocOk4suRW0nfTCfzMKF6XWKgb1qqsENDCnHqP0M3NKWmiX6RD6X
         w4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751024038; x=1751628838;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8TQIk1vNThf+KbhPSV308tydy65v8ZFP99g2fX+hJzE=;
        b=ntd8zpSiYAqWqDpsnWN02M7pqGlb6BXU423ThwGEnOSmk9fbe0vOfXbcLhRVjepto8
         pRLXe48uSH0qcbR0sKexvLS7zuiNs3gLe29G5AVWNj6pF7ZAgi5NAsczovE5FTQ6xOmV
         em5GBU6dwPBXKmfnYvqWCpA/yhkkoxnt83YCAHFq2H57dU1YnpMmZiEplyADcbsjDaiG
         +Qbcv9BHpcS9nCpaQjQQRJ47IsmZ+u/roEcuplPniMyYzujm7q02bDq7/bWT6g+Vw1zR
         elI+o1Iaz92Q3cdLCqYpCsdzH0OgLqZqUkO3hT+dJ21t0W96F3oInYPLznncxt5rYizW
         mkjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtgDadcsWayBlQuVV4Fb+5UHrBwvTGyawG0q8kN7FIZQLfZ4vOQlQ0WCZQ2Ev6krXVG0AWQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIdOTnhRGZpoMf7xw0cTFjbY4lBTOiAmZHP3snyyLfVetuXi3H
	5yfRDvuqIFJNT8xsI0p8ANbSCyoC2BOFAaH5KKLG96dWW98xlbNq3TgmFWnjm7d1t7U=
X-Gm-Gg: ASbGncvBwyV8p/H5bma+y/jQry0JvJo+MPnu+c58iePoTzV0sHjgNCUSC/2UrUJxgad
	WpC3dRHSwFj6Fi99XHmejNOW7eD8dPGgs5T9aYn87arpvEX3w+kLxi8hqIP4MWP5z5r3bj31k6Q
	k3ef7+k3rokZiNnqerUNIWzwDMyHQDbjdQKZ0x1pdT+a+c6Gx2Sj+o7msDru/y+/PkvhGyU/PtN
	oAULtA75I/i8tlEoohIqZUXjM8o86QRQcWdAP7Hlw0ghRzZQx7fqLf7S27mwuLhzLF6Cfo/MKAV
	nyxsgD0/ZhGns4PJkmbiyFiO2U6VyDIP2IfJXLYym05NPx+BU9g7pQ39DbnqL/1vgkt0kIl9oA0
	1u7zQ5EPriio5jCr9x9xgxxmkvAVLrF8=
X-Google-Smtp-Source: AGHT+IFTB4ZISQsWRjBnTltqxZ+EzRDnHXDtrROSz2QQZgqYVC+7zZ8R4yhdcBmhaWSRI1bSl9PUhg==
X-Received: by 2002:a17:906:7951:b0:ad8:a935:b905 with SMTP id a640c23a62f3a-ae34fddeae3mr245758066b.22.1751024037927;
        Fri, 27 Jun 2025 04:33:57 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c6bdafsm108070066b.143.2025.06.27.04.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 04:33:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Jun 2025 13:33:56 +0200
Message-Id: <DAXA7TKVM4GI.J6C7M3D1J1XF@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 14/14] arm64: dts: qcom: Add The Fairphone (Gen. 6)
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
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
 <20250625-sm7635-fp6-initial-v1-14-d9cd322eac1b@fairphone.com>
 <4200b3b8-5669-4d5a-a509-d23f921b0449@oss.qualcomm.com>
In-Reply-To: <4200b3b8-5669-4d5a-a509-d23f921b0449@oss.qualcomm.com>

On Wed Jun 25, 2025 at 4:38 PM CEST, Konrad Dybcio wrote:
> On 6/25/25 11:23 AM, Luca Weiss wrote:
>> Add a devicetree for The Fairphone (Gen. 6) smartphone, which is based
>> on the SM7635 SoC.
>
> [...]
>
>> +	/* Dummy panel for simple-framebuffer dimension info */
>> +	panel: panel {
>> +		compatible =3D "boe,bj631jhm-t71-d900";
>> +		width-mm =3D <65>;
>> +		height-mm =3D <146>;
>> +	};
>
> I haven't ran through all the prerequisite-xx-id, but have
> you submitted a binding for this?

Actually not, kind of forgot about this. I believe I can create a
(mostly?) complete binding for the panel, but this simple description
for only width-mm & height-mm will differ from the final one, which will
have the DSI port, pinctrl, reset-gpios and various supplies.

I think I'll just drop it from v2 and keep it locally only, to get the
simpledrm scaling right.

>
> [...]
>
>> +	reserved-memory {
>> +		/*
>> +		 * ABL is powering down display and controller if this node is
>> +		 * not named exactly "splash_region".
>> +		 */
>> +		splash_region@e3940000 {
>> +			reg =3D <0x0 0xe3940000 0x0 0x2b00000>;
>> +			no-map;
>> +		};
>> +	};
>
> :/ maybe we can convince ABL not to do it..

Yes, we talked about that. I will look into getting "splash-region" and
"splash" also into the ABL (edk2) build for the phone. Still won't
resolve that for any other brand of devices.

>
> [...]
>
>> +		vreg_l12b: ldo12 {
>> +			regulator-name =3D "vreg_l12b";
>> +			/*
>> +			 * Skip voltage voting for UFS VCC.
>> +			 */
>
> Why so?

From downstream:

		/*
		 * This is for UFS Peripheral,which supports 2 variants
		 * UFS 3.1 ,and UFS 2.2 both require different voltages.
		 * Hence preventing voltage voting as per previous targets.
		 */

I haven't (successfully) brought up UFS yet, so I haven't looked more
into that.

The storage on FP6 is UFS 3.1 though fwiw.

>
> [...]
>
>> +&gpi_dma0 {
>> +	status =3D "okay";
>> +};
>> +
>> +&gpi_dma1 {
>> +	status =3D "okay";
>> +};
>
> These can be enabled in SoC DTSI.. it's possible that the secure=20
> configuration forbids access to one, but these are generally made
> per-platform

Ack

>
> [...]
>
>> +&pm8550vs_d {
>> +	status =3D "disabled";
>> +};
>> +
>> +&pm8550vs_e {
>> +	status =3D "disabled";
>> +};
>> +
>> +&pm8550vs_g {
>> +	status =3D "disabled";
>> +};
>
> Hm... perhaps we should disable these by deafult

Do you want me to do this in this patchset, or we clean this up later at
some point? I'd prefer not adding even more dependencies to my patch
collection right now.

>
> [...]
>
>> +&pmr735b_gpios {
>> +	pm8008_reset_n_default: pm8008-reset-n-default-state {
>> +		pins =3D "gpio3";
>> +		function =3D PMIC_GPIO_FUNC_NORMAL;
>> +		bias-pull-down;
>> +	};
>> +
>> +	s1j_enable_default: s1j-enable-default-state {
>> +		pins =3D "gpio1";
>> +		function =3D PMIC_GPIO_FUNC_NORMAL;
>> +		power-source =3D <0>;
>> +		bias-disable;
>> +		output-low;
>> +	};
>
> ordering by pin ID makes more sense, here and in tlmm
>
> (and is actually written down)
> https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-o=
f-nodes

Ah, that's news to me. Thanks!

>
> [...]
>
>> +&pon_resin {
>> +	linux,code =3D <KEY_VOLUMEDOWN>;
>> +	status =3D "okay";
>
> \n before status consistently, please

Ack

>
> [...]
>
>> +&tlmm {
>> +	/*
>> +	 * 8-11: Fingerprint SPI
>> +	 * 13: NC
>> +	 * 63-64: WLAN UART
>> +	 */
>> +	gpio-reserved-ranges =3D <8 4>, <13 1>, <63 2>;
>
> Please match the style in x1-crd.dtsi

Ack

>
> [...]
>
>> +&usb_1 {
>> +	dr_mode =3D "otg";
>> +
>> +	/* USB 2.0 only */
>
> Because there's no usb3phy description yet, or due to hw design?

HW design. Funnily enough with clk_ignore_unused this property is not
needed, and USB(2.0) works fine then. Just when (I assume) the USB3
clock is turned off which the bootloader has enabled, USB stops working.

Regards
Luca

>
> Konrad

