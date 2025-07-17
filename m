Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E1B26D4C1
	for <iommu@lists.linux.dev>; Thu, 17 Jul 2025 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745580; cv=none; b=WqhBjICkkjt81VVj52DwXRr5VIuN74vRTD6HTHtD/ircTYg3KyWnILdgx6FlfWVeWX6uEQfOHanG7yz8j7EOD9D+0DIrOXvxOVV7kRIjCgn3mM6VQCShCzMqMeXlbl01rVTlkTX3b/LWTgjGrGC6iYeAW7a0TNVUmpLx5xqB5Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745580; c=relaxed/simple;
	bh=SNKCNuS07yOhNClyun4AtdBr5+gzFNw6Inn1wst24b0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=jyxJD58qyJuRw+BL+UaOAhBnWksH91xCRTapcCwBHjU9o1wuduyBAGOwYqMgWF96uTv/spEyRsID85SlTKROzaaaXEfw5ZGey8k5kBHvvD8IgEV+brePtXrtkGZtnAEmdN8zDXMI4ANXSadiErj1O+ALuX1wNu4iigWcGolf2xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=gD5Lvru/; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="gD5Lvru/"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae0df6f5758so130184166b.0
        for <iommu@lists.linux.dev>; Thu, 17 Jul 2025 02:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752745576; x=1753350376; darn=lists.linux.dev;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ru/mu5vOTULTD4H+wkh3KmAvhPvotp/lHqkpBJrbBE=;
        b=gD5Lvru/lAiEj5P4s+xpnHXyLXZhUdyLpddWplCVhIi4QDqMW6ThqQAdPNHlIlXl0k
         1fIlsC8Yln/Xz+tRmXFFS7zb8n0ADZ/G0jD9kvRx2+GtCvvcqgfUGzTZNwqaHtN3eFRw
         mE3RhO3W8dkcaSXE5BgWweVeci+kno1BCr6QutydZ1OTHqJ3CdhIiWpMTVlf9WH2UhTC
         dnZzcGpaRDFJUrMaBo/7QKoGwsPmA7tBoOOSFF0a04dL05AU+eRLuaASrnv8CPEPWfRg
         oDMfxehkQSpquVl8WUIVdereym3CCcanEfHrlRKOS+ZptIWybml+/ZJTUm+DWtmxHiZi
         +Ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752745576; x=1753350376;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Ru/mu5vOTULTD4H+wkh3KmAvhPvotp/lHqkpBJrbBE=;
        b=unMxXzQT55CM9q39QgXepmFjXi3dHt/wuE9nWxfNz7OVVaKyQw4N69FJGZEe39mw+n
         T+eCta7qY0BdBNkM+Nhr5QBYG3QsB4eBFeKjiNam1qbdQsSklkd1gz1jcXV05Eo5Zc0f
         bCzctF/oxUQfFimQyDQJUuyooX/mUuWuuZZCW8H1gElOunq7b4b+fOliZkUE7k7ophPD
         ixFuCaHA6wgYgC1IYyzoGeDngFKyl0zaeyNhl6bJfEwxCHkKahj/3t2i8F0IoooGmM9F
         bjduZCtH9XXm84K8M2LuTUdTwUrbwqDS7sN0NofOvyKzuwS1nfxYfBq/fhX9lU8oHWLn
         sYlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaKdFeq7WDV9esQ5ZL7uBJSxGMq4XvOK+XJQmrCK5osCa1pM174zGPyASIloQvV0lVnkcViQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyuoUNqzfriK3L9AJP87xHMJqwUNmGp5H3cLEYMrRACH5gczT4G
	2t7PPJqDlQDraC8T60CI0XyCS2nMrdUqWx9AjffVU142E2R8SkoigrWEySHC8PCfep8=
X-Gm-Gg: ASbGncvqCCr+i+ZvOVDFbdCX50Ko7obkUBD4kgu1Dt6ULq06jKRD6Ip8hnAJbYAKqQs
	z1plicAxxK7dTywqWN4Y+j+7/HHk/xhwXWU2FwIGAyCXanTifd9o+LBV0bz+QBw6XE9wCKynuDr
	TjjbEETBFmwHmHGXxQIGrQEIP8GgV936xYooWzapQrD2AfP4W3GXcBx98kKw364x0d4bru5q+8S
	G5L1EZUmGWoZ0lG8FBDc54YLwTmRoi9l4CjI/VdOuP1XrSvSV7nJn3yCD5t3Fz0ShMOxk5UCFUC
	5ohjV7KMEPYLxhur/BKV9XAO6KUNg1tVaOfYC/Y4J3O9uhrMtSI6hZ0Il6QOfIUH1NWps/RZshJ
	/wurEq2LD+upa8zTWwqXBDSNTrvF37LlWTzEl5/VMx6xbkddik5M0L/Yw
X-Google-Smtp-Source: AGHT+IFFJ+Gwq77Z/PIy0XMlE+NNaiR8R9S0OSFVxrU0iuecWvqgNe/XZ2Nw4b7IKr3qQanK/C4caw==
X-Received: by 2002:a17:906:af16:b0:ad8:87ae:3f66 with SMTP id a640c23a62f3a-ae9ce1d8ba4mr400610566b.60.1752745576031;
        Thu, 17 Jul 2025 02:46:16 -0700 (PDT)
Received: from localhost (212095005146.public.telering.at. [212.95.5.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294bb2sm1333325866b.114.2025.07.17.02.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 02:46:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Jul 2025 11:46:12 +0200
Message-Id: <DBE8G88CIQ53.2N51CABIBJOOO@fairphone.com>
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
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v2 14/15] arm64: dts: qcom: Add initial Milos dtsi
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-14-e8f9a789505b@fairphone.com>
 <3e0299ad-766a-4876-912e-438fe2cc856d@oss.qualcomm.com>
 <DBE6TK1KDOTP.IIT72I1LUN5M@fairphone.com>
In-Reply-To: <DBE6TK1KDOTP.IIT72I1LUN5M@fairphone.com>

Hi Konrad,

On Thu Jul 17, 2025 at 10:29 AM CEST, Luca Weiss wrote:
> On Mon Jul 14, 2025 at 1:06 PM CEST, Konrad Dybcio wrote:
>> On 7/13/25 10:05 AM, Luca Weiss wrote:
>>> Add a devicetree description for the Milos SoC, which is for example
>>> Snapdragon 7s Gen 3 (SM7635).
>>>=20
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---
>>
>> [...]
>>> +
>>> +		spmi_bus: spmi@c400000 {
>>> +			compatible =3D "qcom,spmi-pmic-arb";
>>
>> There's two bus instances on this platform, check out the x1e binding
>
> Will do

One problem: If we make the labels spmi_bus0 and spmi_bus1 then we can't
reuse the existing PMIC dtsi files since they all reference &spmi_bus.

On FP6 everything's connected to PMIC_SPMI0_*, and PMIC_SPMI1_* is not
connected to anything so just adding the label spmi_bus on spmi_bus0
would be fine.

Can I add this to the device dts? Not going to be pretty though...

diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm64/=
boot/dts/qcom/milos-fairphone-fp6.dts
index d12eaa585b31..69605c9ed344 100644
--- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
+++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
@@ -11,6 +11,9 @@
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "milos.dtsi"
+
+spmi_bus: &spmi_bus0 {};
+
 #include "pm7550.dtsi"
 #include "pm8550vs.dtsi"
 #include "pmiv0104.dtsi" /* PMIV0108 */

Or I can add a second label for the spmi_bus0 as 'spmi_bus'. Not sure
other designs than SM7635 recommend using spmi_bus1 for some stuff.

But I guess longer term we'd need to figure out a solution to this, how
to place a PMIC on a given SPMI bus, if reference designs start to
recommend putting different PMIC on the separate busses.

Regards
Luca
