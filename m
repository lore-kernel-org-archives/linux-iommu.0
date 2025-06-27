Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628192E7F33
	for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035499; cv=none; b=eUDxItXjbxxGdyOqEKBfcJxL5SQLZKFQoOisX82YhzOMgNcKGBfQ1d8U50pxz2HKxeEwpc7Egr+tn3Ru3NfilgRwvcQSt033r1ihmTGJklpD1dkt8y0vbBpG+nXNOOOg13TxCKXTcJ1Bh5mBbCFaAfeXdG1YP915akABOpIM15Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035499; c=relaxed/simple;
	bh=NTyBybTY3lY2he6PEfFmBwj+NT8vhjacNbp9rj9qt38=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DpQg+Q6X9g7M/3tCWPn5iqiWyGJJGPbhovtkDHNcePOQhUWoDimVrTUc5DE4qN3yKV0qFseZuoBziDhGH/fIihRTJNVP+s+a18sesNrM6yHYJPYCxNZKwxfjX5uOe/zj4rf6uaPBzr+wAls3UV827jCZ/G25S2P4iMIJm57ltc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=Mn5Bi2fi; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Mn5Bi2fi"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae0e0271d82so307670766b.3
        for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 07:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1751035496; x=1751640296; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlrE0erJ+soHw5jj+VujnDEwpvOXS6zY03LMDq5ZPE4=;
        b=Mn5Bi2fiIEsaNIPV1MWSijwXtDztnhxIQnd4XHh6asxUS7P5XvYJY5VuJ1oSW4X8aT
         F2pnQYBSi2mnjVm8RyBu+r8F9C13zfjMCWQba3lCeoXT0U+4EjJqcNIakmNTPDnQ3eDH
         A7+yDgiAIsplzkv6IMaOWmQ4Tdp/OxGuHpRVt7Ij+YYcbl+8RMtQBsRPLjYEYSWJmo39
         cjik2to0wmQDs+FPlG7PK3kfzpXi/EZ9+cYMe/mS2REgO7/e1e0p4QkVCEChSLqoyzIW
         NR4HXgvSA1BFE3p6nhy6/pL/MBrll8v2oX8R3pKa+7Zt9qqoA9XNu86fGfhe5WUflPtR
         xgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751035496; x=1751640296;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dlrE0erJ+soHw5jj+VujnDEwpvOXS6zY03LMDq5ZPE4=;
        b=uW5foB7NVQP5OoqhD1DTtigesICHh/+wTvkVfeByV8E5D00zeOMxmVKTInXpQb3BJ9
         48UiSI9LRFlSRcUuqeEBb4tP0LgCYuIkLMnyf9AFjymDPWTsQ3JZmFE6Seq6J7CzC2pZ
         1mRtjTJx0bi3WSD4eA/KbyM0Zn+URomrR6w+t1cblVOJ5XQvcBLQM+TssovjIhwpWfxn
         SxpG3sMTgcXEw1z8OTpocKYghCZ+TTq9mvl8woQ77F8kCqIDgLh7+Ury1yZITrKxIfxf
         TF+WLyeIvmW6OQq6UmH5RJ5DsjXYovuzUfPwRqWwpDBQQAS1/mSGkSbDUXRdoOBdyLj3
         sSuA==
X-Forwarded-Encrypted: i=1; AJvYcCV6ZvMtyQtYsRuMX2RftVjvvgsfsYpSAEKyySazRVr5LhP5hFj55Udcu0BggTgpPXVWmyrndA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxpHX+3MjTj1HSYqvqP3WNWkqBs15V7P6bb5FdYQ4BbGEJuzYdr
	HFjw5Ua80t0YULew6m9NECt7G2ApITrTAFZv5b5CNlTuutWAbDx8oos4KfCoeX+DMOA=
X-Gm-Gg: ASbGnctr4CicqUGPOPgHGr1IbQdN6KDBPswRVJiYLGhNWLGa4HNWI0CC7/FRLCp/s/m
	I56R1RXGyGFN6glezaoiz0KO9QPWPsCDRaz3SGCk4Y/GgQIHJycrHamTxMu2to5UgDSb7yvJQBo
	RxUqqskGEXy45ZrvHtXAXoxLrM9MSPjEBXbd5Fs5EwGLTbqL46xwF9rHRsF6p6tX+kiNDqnB1Dr
	4++WrzEDn/UPioyihZ7ib6WxgloeEUjLAm+NcLPokjtv14B6Utvsf9ltS//dz0BqKCs8JgrtjUY
	NvtO2Y5lsjZ3j8k3KwA3doZfKyFczP40nug1MNuN98qtZ1yyQhznI7T6/FlmClS2ClEZLFEpYHL
	tz7trX2DRAAHvZC7N4W6nyfzs7eyU4xE=
X-Google-Smtp-Source: AGHT+IGA2mn71bXWbYFILa0TCGmj9njdVsOBKtFNFMdVa00gcI2whAz4/eBu0LzWjRNNEejwRdZugA==
X-Received: by 2002:a17:907:8691:b0:ad8:9b5d:2c1c with SMTP id a640c23a62f3a-ae34fd8cb6cmr354056566b.19.1751035495488;
        Fri, 27 Jun 2025 07:44:55 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363b35dsm137152566b.13.2025.06.27.07.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 07:44:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Jun 2025 16:44:54 +0200
Message-Id: <DAXEA131KUXZ.WTO7PST1F3X6@fairphone.com>
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
 <DAXA7TKVM4GI.J6C7M3D1J1XF@fairphone.com>
 <6d4e77b3-0f92-44dd-b9b0-3129a5f3785b@oss.qualcomm.com>
In-Reply-To: <6d4e77b3-0f92-44dd-b9b0-3129a5f3785b@oss.qualcomm.com>

On Fri Jun 27, 2025 at 4:34 PM CEST, Konrad Dybcio wrote:
> On 6/27/25 1:33 PM, Luca Weiss wrote:
>> On Wed Jun 25, 2025 at 4:38 PM CEST, Konrad Dybcio wrote:
>>> On 6/25/25 11:23 AM, Luca Weiss wrote:
>>>> Add a devicetree for The Fairphone (Gen. 6) smartphone, which is based
>>>> on the SM7635 SoC.
>>>
>>> [...]
>>>
>>>> +	/* Dummy panel for simple-framebuffer dimension info */
>>>> +	panel: panel {
>>>> +		compatible =3D "boe,bj631jhm-t71-d900";
>>>> +		width-mm =3D <65>;
>>>> +		height-mm =3D <146>;
>>>> +	};
>>>
>>> I haven't ran through all the prerequisite-xx-id, but have
>>> you submitted a binding for this?
>>=20
>> Actually not, kind of forgot about this. I believe I can create a
>> (mostly?) complete binding for the panel, but this simple description
>> for only width-mm & height-mm will differ from the final one, which will
>> have the DSI port, pinctrl, reset-gpios and various supplies.
>>=20
>> I think I'll just drop it from v2 and keep it locally only, to get the
>> simpledrm scaling right.
>
> Yeah I think that'd be best in general

Ack

>
>>=20
>>>
>>> [...]
>>>
>>>> +	reserved-memory {
>>>> +		/*
>>>> +		 * ABL is powering down display and controller if this node is
>>>> +		 * not named exactly "splash_region".
>>>> +		 */
>>>> +		splash_region@e3940000 {
>>>> +			reg =3D <0x0 0xe3940000 0x0 0x2b00000>;
>>>> +			no-map;
>>>> +		};
>>>> +	};
>>>
>>> :/ maybe we can convince ABL not to do it..
>>=20
>> Yes, we talked about that. I will look into getting "splash-region" and
>> "splash" also into the ABL (edk2) build for the phone. Still won't
>> resolve that for any other brand of devices.
>
> Gotta start small! Maybe framebuffer@ would be more """idiomatic"""
> but potayto/potahto

I'll try and work on the edk2 patch early next week, so if you tell me
soon, I can add some other name. I don't want to include 500 different
names though. :)

>
>>=20
>>>
>>> [...]
>>>
>>>> +		vreg_l12b: ldo12 {
>>>> +			regulator-name =3D "vreg_l12b";
>>>> +			/*
>>>> +			 * Skip voltage voting for UFS VCC.
>>>> +			 */
>>>
>>> Why so?
>>=20
>> From downstream:
>>=20
>> 		/*
>> 		 * This is for UFS Peripheral,which supports 2 variants
>> 		 * UFS 3.1 ,and UFS 2.2 both require different voltages.
>> 		 * Hence preventing voltage voting as per previous targets.
>> 		 */
>>=20
>> I haven't (successfully) brought up UFS yet, so I haven't looked more
>> into that.
>>=20
>> The storage on FP6 is UFS 3.1 though fwiw.
>
> Hm.. can you check what debugfs says about the voltage at runtime
> (on downstream)? I'd assume you won't be shipping two kinds anyway

This is very likely just from Qualcomm's baseline.

>
> [...]
>
>>>> +&pm8550vs_d {
>>>> +	status =3D "disabled";
>>>> +};
>>>> +
>>>> +&pm8550vs_e {
>>>> +	status =3D "disabled";
>>>> +};
>>>> +
>>>> +&pm8550vs_g {
>>>> +	status =3D "disabled";
>>>> +};
>>>
>>> Hm... perhaps we should disable these by deafult
>>=20
>> Do you want me to do this in this patchset, or we clean this up later at
>> some point? I'd prefer not adding even more dependencies to my patch
>> collection right now.
>
> I can totally hear that..
>
> Let's include it in this patchset, right before SoC addition
> I don't think there's any pm8550vs users trying to get merged in
> parallel so it should be OK

Okay, can do. Disable all of them (_c, _d, _e, _g), and re-enable them
in current users? I assume there might also be boards that only have
e.g. _d and no _c.

>
> [...]
>
>>>> +&usb_1 {
>>>> +	dr_mode =3D "otg";
>>>> +
>>>> +	/* USB 2.0 only */
>>>
>>> Because there's no usb3phy description yet, or due to hw design?
>>=20
>> HW design. Funnily enough with clk_ignore_unused this property is not
>> needed, and USB(2.0) works fine then. Just when (I assume) the USB3
>> clock is turned off which the bootloader has enabled, USB stops working.
>
> The USB controller has two possible clock sources: the PIPE_CLK that
> the QMPPHY outputs, or the UTMI clock (qcom,select-utmi-as-pipe-clk).

So okay like this for you, for a USB2.0-only HW?

>
> Because you said there's no USB3, I'm assuming DP-over-Type-C won't
> be a thing either? :(

Yep. I'd have preferred USB3+DP as well since it's actually quite cool
to have with proper Linux. On Android, at least on older versions it's
barely usable imo. Can't even properly watch videos on the big screen
with that SW stack.

Regards
Luca

>
> Konrad

