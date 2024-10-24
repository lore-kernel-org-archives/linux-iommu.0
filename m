Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821A3218325
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 22:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729808673; cv=none; b=lS5ahGbCVc9BlXTvxtp2NJC8Jkz3++P0+sBqbNLtgfwXL6LGaY2mswOfVaM0q7hOdX26FtEOmxolNdl6eGXtOxISisp74g3KKgGYE/7BwSdqUMk7wMFC1oITl9c2tdv829hflNoMhMkE23C1ty3x/dN7T2ZlmcixZi1BfDQRLTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729808673; c=relaxed/simple;
	bh=b3Oqdz9XIKXZD2gr94AL8g1IimMVqiVBRgfe0bV1erk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ag8gXfVXcGungy6iM5vKBw149CxD8tAaDVR1QB9yNm097IlwP6ZHcDhaeGKO2cgvmR9toPgW2QFbpjNyI+/JwvZXYgpwmrUe8W85n8swdjn7vJQG4toJQhLuYEvH5dqZtZCcMTis59RpBF0ICH8uX1VPpgmivLYhDibtG4BVl8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LHnrQqPL; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LHnrQqPL"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb5740a03bso15764161fa.1
        for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 15:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729808668; x=1730413468; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oNMGjw++sMHfaJpTwkpeeb5+CZwbF2kDV2e17WrmTm0=;
        b=LHnrQqPLKAS5iGJTj5rSkCDtxG0J/gAWCsqvFsRl3ZfqRl/d1zym2dofKiDXYRT8U9
         AQEAdBAS0rxxYBPjFDH/QTy1RG2Zbc+kAlwuRvAoiXc4YKGpL2wBYOYrOIKYeMI9jPMk
         liwshNCgakbKzeKe1Gp7ScazBwqBaAfLIkAeDN+3iwMh/BLItc2rzDFgKo0lFB7G9yPv
         dmXVl431Tw2xTUMg1ENmgVOrxlh7p/G4qYiSm4ndZJW7Aw3kJs0CVKbjc9SFXkeScN3l
         ffV8dBcgEHR69sTcZTXdIssgZz6vOVYbNPBmKLl/uphtjzSEN4M+OmKf02LozHtR/Tsj
         2OOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729808668; x=1730413468;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oNMGjw++sMHfaJpTwkpeeb5+CZwbF2kDV2e17WrmTm0=;
        b=JYiPH1TVv1UmBNo9q5z8QY/Cnm/QFxVzkiVyjsufanWIshaffML4q5YCISY6HQDiwV
         ifcQZ5Goy5KdLYhwy17pprD41ZjgJd+PczjbICqJVG4nC52UYLp/SX2gMZQTYrLDGmZr
         ExbK7XnhxU/XkKRru0Lmaxup2c7s+pBBzqUZ/8ulD6jYUaL+Oj0qhay7SGG2Da+EfSa4
         BgoFDR7UlkYPFPFg1WU5A8cqjaC+oRoNFwQq2m1nN+zXovOAZ+sRuy2GAwZq5GTgG5v7
         ud1vjKEWHUJ6oyggpFv/7R7ScYq0eFunCoD+17k+fmFWL1TuSNfuLs5ehEAAEDzDMDUM
         e7iw==
X-Forwarded-Encrypted: i=1; AJvYcCWjF+KRnqXLim+az92wK4wIwIkKqYQK4y+Q4b1FLhsT3h9kFItCKT+mqm3K8hX2rXFNlJzM1w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyr/2Hv3kQ77w0OTo5ku2Z348yEAr534N+lxXWXnVKzx2FO826U
	Hf3coKzUia8Q6PcOQKgcg61DhyfG1NcyNMU31yvs8LBpGq690Nr57BBeDn2MJlc=
X-Google-Smtp-Source: AGHT+IGMGFhwLsswBUxiX+Gh6Mwmw4Gpv/RT0zNWikzUs+v1WjRd6mzd0pMZGj9Em8bkTL+w/Phbng==
X-Received: by 2002:a05:6512:6511:b0:539:faef:35ec with SMTP id 2adb3069b0e04-53b1a375c09mr3432667e87.49.1729808668438;
        Thu, 24 Oct 2024 15:24:28 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223e5ab6sm1481972e87.13.2024.10.24.15.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 15:24:27 -0700 (PDT)
Date: Fri, 25 Oct 2024 01:24:25 +0300
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
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	Otto =?utf-8?Q?Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Subject: Re: [PATCH RFC 12/14] arm64: dts: qcom: Add initial support for
 MSM8917
Message-ID: <h4dy2fesraalsri4gclenp4luwqjoh7iv2xysqnf6uwy3qp5de@x6iqc6pa365i>
References: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
 <20241019-msm8917-v1-12-f1f3ca1d88e5@mainlining.org>
 <2iayllvk5ohrmbhnn7up5gvys2ijzxuyf44c53uwcbsunre6np@ncrimgac2idz>
 <19884457f1133a20a6ad014a75906e55@mainlining.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19884457f1133a20a6ad014a75906e55@mainlining.org>

On Mon, Oct 21, 2024 at 11:14:55PM +0200, barnabas.czeman@mainlining.org wrote:
> On 2024-10-19 15:43, Dmitry Baryshkov wrote:
> > On Sat, Oct 19, 2024 at 01:50:49PM +0200, Barnabás Czémán wrote:
> > > From: Otto Pflüger <otto.pflueger@abscue.de>
> > > 
> > > Add initial support for MSM8917 SoC.
> > > 
> > > Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> > > [reword commit, rebase, fix schema errors]
> > > Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/msm8917-pins.dtsi |  344 ++++++
> > >  arch/arm64/boot/dts/qcom/msm8917.dtsi      | 1557
> > > ++++++++++++++++++++++++++++
> > >  arch/arm64/boot/dts/qcom/pm8916.dtsi       |    9 +-
> > >  3 files changed, 1909 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/msm8917-pins.dtsi
> > > b/arch/arm64/boot/dts/qcom/msm8917-pins.dtsi
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..f283ffd59b8aca8e510ef95d5526af9592a1c036
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/qcom/msm8917-pins.dtsi
> > 
> > Please merge into msm8917.dtsi (for generic parts) and
> > msm8917-boatd.dtsi (for board-specific parts).
> > 
> > > @@ -0,0 +1,344 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > 
> > If possible, GPL-2.0 OR MIT, or GPL-2.0 OR BSD-2/3-Clause
> Unfortunatelly i cannot change the license i do not own the original code.

Ack

> > 
> > > +			tsens_caldata: caldata@d0 {
> > > +				reg = <0x01d8 0x14>;
> > > +			};
> > 
> > No, individual bit definitions for each of tsens fuse values.
> > 
> > > +		};
> > > +
> > > +		rpm_msg_ram: sram@60000 {
> > > +			compatible = "qcom,rpm-msg-ram";
> > > +			reg = <0x00060000 0x8000>;
> > > +		};
> > > +
> > > +		tsens: thermal-sensor@4a9000 {
> > > +			compatible = "qcom,msm8917-tsens", "qcom,tsens-v1";
> > > +			reg = <0x004a9000 0x1000>,
> > > +			      <0x004a8000 0x1000>;
> > > +			nvmem-cells = <&tsens_caldata>;
> > > +			nvmem-cell-names = "calib";
> > 
> > And here too, individual bits instead of a single blob.
> I do not know how to do that i have only find some parts at downstream
> driver to be able to separate
> the cells but i do not have every information for it.

Well, you don't have to describe every information. I'm simply asking
you to replace single tsens_caldata entry with per-sensor and per-point
data, see e.g. msm8976.dtsi and data_8976 / ops_8976.

> > 
> > > +			#qcom,sensors = <10>;
> > > +			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
> > > +			interrupt-names = "uplow";
> > > +			#thermal-sensor-cells = <1>;
> > > +		};
> > > +
> > > +

[...]

> > > +		gpu: gpu@1c00000 {
> > > +			compatible = "qcom,adreno-306.32", "qcom,adreno";
> > 
> > Is it really .32 ?
> Yes it is A306A (Adreno 308)

Ack

-- 
With best wishes
Dmitry
