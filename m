Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1A02D8DC2
	for <iommu@lists.linux.dev>; Wed, 20 Aug 2025 08:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755679334; cv=none; b=m6RKKhSepFgHEua+IDe3mxG48SwPL8LrAz/Az4aEf08lu6pS5bNMKt0IyNvy9JzXqL1tqK+3u3Q/hL3FpVp6HMpiIKFanAtCCWx0ws8g5WbXVOE2EhY+CfufsKTp3ajDPo6jmRMT3Psp+Ty4lYT30yPcdRuFu7ZsQoL7gdZRnp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755679334; c=relaxed/simple;
	bh=zMxp/Y9NCrKDYrER4UyjAnXSn/8lzKPXQ7dHBNQTR30=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hKUJ8iI1IkbXJe3HTv8zunNrxyBRMWya7/hImtAGcx+q3WMFf+5PBG+Yi4cC+KMI6c9J57jo/C4GtbPmiCpbGB0k7idTAShKbgVRxgBRPE1E8Icg5M9KqBpbkuXs6vffLqrtMkNFPgciXSAcuO1w9zW+Ui6jiJwi7MHLWB4jBEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=xUxdBFSV; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="xUxdBFSV"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb78ead12so872480666b.1
        for <iommu@lists.linux.dev>; Wed, 20 Aug 2025 01:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1755679331; x=1756284131; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dETmxzysQAIIrfvzFS6NhiwZKV/rguUqMxZ2Lb2+BiA=;
        b=xUxdBFSVHnWjPdfgbAfNTfac+Y4pWqLTqgmUm8LAb5sRew9Lonin+ihsr7HuAXnre+
         0zpiON/xZmw503RpHgvusKKUu219266mLgm52qDGh8id3AkmShskjA1f3VgnLDzpMC89
         yE378X9zSh5LI+leObngndM8rkrBqsxemx/V9NKnMxmhzHfSEuKL/CrJiC8vGmRT2e7h
         5M2hKEzcgPSQOe2UI4Y7AnRM2xcbf8h3E80/LUszBLJH1swljxmuA0w1ZrNPopttnAoT
         FUU1EDTkrUudgp3Jzn2PlIdpOjZ7fA6zKgTs1CqD/rOaEmN6Zq0J7jQxIE58M3FZKrAL
         lEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755679331; x=1756284131;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dETmxzysQAIIrfvzFS6NhiwZKV/rguUqMxZ2Lb2+BiA=;
        b=J9VES/AheQsogAjDJYZ/BsfALY303wBV34EWN5S6JZd3EBuDeDcqnNto70V1ewUUBO
         mxxdORPp5cp/j2KlcLUyMuc4+SMZrsKi4bYli9eTANVhU8GvgkuJ4zfUebCtm5j3/KwB
         IeIBYeP3+gCF6F5HtAJby2CpjJKIU4qSWwZu8H4o4g5VYiPPJTitDn7Jya6oQcG8sMjh
         RiaAAnRwE8YDcyfv2ugsOhPZlxATnCNeVuEmdoMmGCVcVSKCbWELe5x9nQZs6Z19A9b2
         RsZsTSGjgG3a/BL6C0zfhsrRR6iLZfcxm8kNXvzBtI8lCc8MUBsqL1IV0+++39mxtvcv
         6JxA==
X-Forwarded-Encrypted: i=1; AJvYcCVjlueIhJbqAMS97rP/Hj9Jw/aqUrqWhMe3YQTrsIh7cmCJ7hzYekmEQh395oOlSZJ5QTs2hA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRK1YkwjuPuQgn14MYSDeSpbIGhYLX2Nchmrk6SxEle8cIpkni
	qrh8F6yqoydNHAdg5amnkEFW7aVHfMU0Bm3IQtPlZ4IsjNHrGE36GwMpgM9EFu0HqW0=
X-Gm-Gg: ASbGncv6Hl83m57InqWxvWwXppvr5o9/93LCc/kEyNrrTfCK47UJjiIhB7W3QixNgWq
	EvKGSJs8T6dSjxwNVuJaLMoYXQB3GyuDyVCnMbvhp9vvCfSe/UvALhXHCHrJPD9sp4GHUi5ka7S
	y1rYt38TbY/zmjY8giGHeu3jgbQDM7wiXiYoARWLe0a3xMKh+HRidZg1x0M6yiUSMsWdarybZMv
	pblwDwBC1pPv5sRPFnpc1lZXNUEsVokFj+9T8365rFcw7K6bFTWVtEEPY15vnfGDzFPvum4R6U7
	0ioAgMauWga0WfYKveIca1yc1ammKII0BL/mNwEWRgurU9xrPtL2CHTaIxE2ffLiCDtEwxR/h/z
	uGKwfSDrz97a8rELRVoa8HgrRYmR2ZU1JXMlxjES29EdVBq7HUnwQ9TjMD1JbtKOSzu0=
X-Google-Smtp-Source: AGHT+IEac2OEaqE2OoGnweWa6iOptxoUoAiXM3h5Vw1WEpE7VDgBBgHTZqHGUTgnoBZuEdKM1TFNmg==
X-Received: by 2002:a17:907:9715:b0:ae3:6f35:36fe with SMTP id a640c23a62f3a-afdf01e915cmr146724366b.47.1755679330638;
        Wed, 20 Aug 2025 01:42:10 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded478bf3sm138377366b.53.2025.08.20.01.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 01:42:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Aug 2025 10:42:09 +0200
Message-Id: <DC74DPI8WS81.17VCYVY34C2F9@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v2 14/15] arm64: dts: qcom: Add initial Milos dtsi
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
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-14-e8f9a789505b@fairphone.com>
 <3e0299ad-766a-4876-912e-438fe2cc856d@oss.qualcomm.com>
 <DBE6TK1KDOTP.IIT72I1LUN5M@fairphone.com>
 <DBE8G88CIQ53.2N51CABIBJOOO@fairphone.com>
 <DBOC7QBND54K.1SI5V9C2Z76BY@fairphone.com>
 <55420d89-fcd4-4cb5-a918-d8bbe2a03d19@oss.qualcomm.com>
In-Reply-To: <55420d89-fcd4-4cb5-a918-d8bbe2a03d19@oss.qualcomm.com>

Hi Konrad,

On Sat Aug 2, 2025 at 2:04 PM CEST, Konrad Dybcio wrote:
> On 7/29/25 8:49 AM, Luca Weiss wrote:
>> Hi Konrad,
>>=20
>> On Thu Jul 17, 2025 at 11:46 AM CEST, Luca Weiss wrote:
>>> Hi Konrad,
>>>
>>> On Thu Jul 17, 2025 at 10:29 AM CEST, Luca Weiss wrote:
>>>> On Mon Jul 14, 2025 at 1:06 PM CEST, Konrad Dybcio wrote:
>>>>> On 7/13/25 10:05 AM, Luca Weiss wrote:
>>>>>> Add a devicetree description for the Milos SoC, which is for example
>>>>>> Snapdragon 7s Gen 3 (SM7635).
>>>>>>
>>>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>>>> ---
>>>>>
>>>>> [...]
>>>>>> +
>>>>>> +		spmi_bus: spmi@c400000 {
>>>>>> +			compatible =3D "qcom,spmi-pmic-arb";
>>>>>
>>>>> There's two bus instances on this platform, check out the x1e binding
>>>>
>>>> Will do
>>>
>>> One problem: If we make the labels spmi_bus0 and spmi_bus1 then we can'=
t
>>> reuse the existing PMIC dtsi files since they all reference &spmi_bus.
>>>
>>> On FP6 everything's connected to PMIC_SPMI0_*, and PMIC_SPMI1_* is not
>>> connected to anything so just adding the label spmi_bus on spmi_bus0
>>> would be fine.
>>>
>>> Can I add this to the device dts? Not going to be pretty though...
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/ar=
m64/boot/dts/qcom/milos-fairphone-fp6.dts
>>> index d12eaa585b31..69605c9ed344 100644
>>> --- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>>> +++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>>> @@ -11,6 +11,9 @@
>>>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>>>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>>  #include "milos.dtsi"
>>> +
>>> +spmi_bus: &spmi_bus0 {};
>>> +
>>>  #include "pm7550.dtsi"
>>>  #include "pm8550vs.dtsi"
>>>  #include "pmiv0104.dtsi" /* PMIV0108 */
>>>
>>> Or I can add a second label for the spmi_bus0 as 'spmi_bus'. Not sure
>>> other designs than SM7635 recommend using spmi_bus1 for some stuff.
>>>
>>> But I guess longer term we'd need to figure out a solution to this, how
>>> to place a PMIC on a given SPMI bus, if reference designs start to
>>> recommend putting different PMIC on the separate busses.
>>=20
>> Any feedback on this regarding the spmi_bus label?
>
> I had an offline chat with Bjorn and we only came up with janky
> solutions :)
>
> What you propose works well if the PMICs are all on bus0, which is
> not the case for the newest platforms. If some instances are on bus0
> and others are on bus1, things get ugly really quick and we're going
> to drown in #ifdefs.
>
>
> An alternative that I've seen downstream is to define PMIC nodes in
> the root of a dtsi file (not in the root of DT, i.e. NOT under / { })
> and do the following:
>
> &spmi_busN {
> 	#include "pmABCDX.dtsi"
> };
>
> Which is "okay", but has the visible downside of having to define the
> temp alarm thermal zone in each board's DT separately (and doing
> mid-file includes which is.. fine I guess, but also something we avoided
> upstream for the longest time)
>
>
> Both are less than ideal when it comes to altering the SID under
> "interrupts", fixing that would help immensely. We were hoping to
> leverage something like Johan's work on drivers/mfd/qcom-pm8008.c,
> but that seems like a longer term project.
>
> Please voice your opinions

Since nobody else jumped in, how can we continue?

One janky solution in my mind is somewhat similar to the PMxxxx_SID
defines, doing something like "#define PM7550_SPMI spmi_bus0" and then
using "&PM7550_SPMI {}" in the dtsi. I didn't try it so not sure that
actually works but something like this should I imagine.

But fortunately my Milos device doesn't have the problem that it
actually uses both SPMI busses for different PMICs, so similar to other
SoCs that already have two SPMI busses, I could somewhat ignore the
problem and let someone else figure out how to actually place PMICs on
spmi_bus0 and spmi_bus1 if they have such a hardware.

Regards
Luca

>
> Konrad

