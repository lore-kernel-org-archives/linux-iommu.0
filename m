Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1690189910
	for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 08:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731485712; cv=none; b=BWahhXvrXdwE6owN7NFhDX5sGsbmA5Kb4nam3yilYjpoBgqUvvu8mAk8K/4FBVN8ZqQ6RBZwenh4CtPg0SrGq6nWajqKgEiLL32xnszP9HyRYrlglCfP1VrnP5GdWtKTPAW/6hyYcABtEYPwmgsJpX8QE0R3oXVklcXTaRDjkWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731485712; c=relaxed/simple;
	bh=8Y0UPyHRHBU3AJ5BIj2LNvoRsdFm7+hymI+IvfPQzM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHol58A8obELDZTEwla3ns2M+oXC8uEIVCrvJSKuj4tho3cR/G6Mr4wrEfSL1Ds3FUTvG7XNU3MpeesAjUAXPcViLTXCDRmtSRUtlkSsFZEyHNW4KxWJG8Agap4QRDmdSvi+zO6lDP0Wvd7bclevJuSLpSQ6erL1QbSdAi/rxn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sOC0mN/6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sOC0mN/6"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso82645515e9.0
        for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 00:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731485709; x=1732090509; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fQbo2SNWl0pl3CFAm+W16lnOLJFykustp1lz60+nR4M=;
        b=sOC0mN/6ONwcNsNgNzBdYfx9dP8d9cua0EQqznRvVrnV4hGxPwGJTI8tLe8kMEvYDq
         j+skwCciHKJys5yMZVxofoaK5d129ZcwRcfEJ6kuOzYGWyNtKvv+8pptV6xSfO5p2ohL
         g8qXUntlorsoBa0K34WGyDHao+h91TTWCKnjsv6GBktEKLqeeHj7F4NElFAHTvqQfnO8
         dEazYB9DOd+fV8fC0SKzmyBgNFIt6HQUWZDmKOJvVMEIdPZrpUfgJnGUJrk3ALMHABI3
         GGgfHEaY8n8YjzPB9HyIqob5hSS+LTT734BzMz/5KCbKAfEgAZXKEM70AAC1PlFQ949S
         uAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731485709; x=1732090509;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQbo2SNWl0pl3CFAm+W16lnOLJFykustp1lz60+nR4M=;
        b=YkXKdBBuINqe3WtRwpegBAITY9G2d3yy4Epf/A2ulI+4FyHiKRP06B9cdMM4LAH7pI
         dZjSfOWhgCWoc6uSdB1VPTFR4JtUQybAs2Ah5DPmbagRM448ez0zf08S41U4VyhJdp0x
         /gdYd3KCxwqQJWxgeeusNIqtkbDLWi7H+QHG+kQTd9JPDquQNB2NxW1Re01XHeuIBl/w
         NEJcc7LeAr2uXMmuiqjPx8CF4HUvw8wvjlBvZNB1t5rvafOQ098ev/SMg+obQEs9+qzS
         QoeK741xzqNqGB7WbSbaLaRMEj+6qb3IPLpWLcb3vU/v4njXEyhBBBIOT02yCGXPW6Y3
         k3Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXhMe+jVngIRuF0M32rwEpJgFQdo3prdo6t22jHKxR52eQEJjsdafGiCIDUCqhF88pFkeif2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWh2bNYelpVpwpjgvp0bNStD/owmKQSfnb3iFQOQPGKEco8GJl
	FI2wjZyfm86fHyo8+cfrCnyXJwxjIg1Y8NdwsQ7ecZzZezzEflOcULWuWZJpWfI=
X-Google-Smtp-Source: AGHT+IFFYloC/8jCwGxKk66s8CV5KsxYaWdZM5UqRntsEzLJT6asKbsQu3Xzl7h4UFRchhvMK6KVFg==
X-Received: by 2002:a05:6000:178c:b0:382:10dc:594b with SMTP id ffacd0b85a97d-38210dc5c10mr383607f8f.34.1731485708986;
        Wed, 13 Nov 2024 00:15:08 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef80:fca:835c:70ab:eebc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea4f6sm17576494f8f.64.2024.11.13.00.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 00:15:08 -0800 (PST)
Date: Wed, 13 Nov 2024 09:15:03 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: barnabas.czeman@mainlining.org
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org, iommu@lists.linux.dev,
	Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>
Subject: Re: [PATCH v5 08/10] arm64: dts: qcom: Add initial support for
 MSM8917
Message-ID: <ZzRgB_U3qYtV7O0h@linaro.org>
References: <20241112-msm8917-v5-0-3ca34d33191b@mainlining.org>
 <20241112-msm8917-v5-8-3ca34d33191b@mainlining.org>
 <ZzOQEgLLhkH-IymV@linaro.org>
 <4c34cb8eec5eab92501011e446b5362d@mainlining.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c34cb8eec5eab92501011e446b5362d@mainlining.org>

On Tue, Nov 12, 2024 at 06:38:04PM +0100, barnabas.czeman@mainlining.org wrote:
> On 2024-11-12 18:27, Stephan Gerhold wrote:
> > On Tue, Nov 12, 2024 at 04:49:38PM +0100, Barnabás Czémán wrote:
> > > From: Otto Pflüger <otto.pflueger@abscue.de>
> > > 
> > > Add initial support for MSM8917 SoC.
> > > 
> > > Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> > > [reword commit, rebase, fix schema errors]
> > > Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/msm8917.dtsi | 1974
> > > +++++++++++++++++++++++++++++++++
> > >  1 file changed, 1974 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/msm8917.dtsi
> > > b/arch/arm64/boot/dts/qcom/msm8917.dtsi
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..cf0a0eec1141e11faca0ee9705d6348ab32a0f50
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/qcom/msm8917.dtsi
> > > @@ -0,0 +1,1974 @@
> [...]
> > > +			sdc1_clk_on: sdc1-clk-on-state {
> > > +				pins = "sdc1_clk";
> > > +				bias-disable;
> > > +				drive-strength = <16>;
> > > +			};
> > > +
> > > +			sdc1_clk_off: sdc1-clk-off-state {
> > > +				pins = "sdc1_clk";
> > > +				bias-disable;
> > > +				drive-strength = <2>;
> > > +			};
> > > +
> > > +			sdc1_cmd_on: sdc1-cmd-on-state {
> > > +				pins = "sdc1_cmd";
> > > +				bias-disable;
> > > +				drive-strength = <10>;
> > > +			};
> > > +
> > > +			sdc1_cmd_off: sdc1-cmd-off-state {
> > > +				pins = "sdc1_cmd";
> > > +				bias-disable;
> > > +				drive-strength = <2>;
> > > +			};
> > > +
> > > +			sdc1_data_on: sdc1-data-on-state {
> > > +				pins = "sdc1_data";
> > > +				bias-pull-up;
> > > +				drive-strength = <10>;
> > > +			};
> > > +
> > > +			sdc1_data_off: sdc1-data-off-state {
> > > +				pins = "sdc1_data";
> > > +				bias-pull-up;
> > > +				drive-strength = <2>;
> > > +			};
> > > +
> > > +			sdc1_rclk_on: sdc1-rclk-on-state {
> > > +				pins = "sdc1_rclk";
> > > +				bias-pull-down;
> > > +			};
> > > +
> > > +			sdc1_rclk_off: sdc1-rclk-off-state {
> > > +				pins = "sdc1_rclk";
> > > +				bias-pull-down;
> > > +			};
> > > +
> > > +			sdc2_clk_on: sdc2-clk-on-state {
> > > +				pins = "sdc2_clk";
> > > +				drive-strength = <16>;
> > > +				bias-disable;
> > > +			};
> > > +
> > > +			sdc2_clk_off: sdc2-clk-off-state {
> > > +				pins = "sdc2_clk";
> > > +				bias-disable;
> > > +				drive-strength = <2>;
> > > +			};
> > > +
> > > +			sdc2_cmd_on: sdc2-cmd-on-state {
> > > +				pins = "sdc2_cmd";
> > > +				bias-pull-up;
> > > +				drive-strength = <10>;
> > > +			};
> > > +
> > > +			sdc2_cmd_off: sdc2-cmd-off-state {
> > > +				pins = "sdc2_cmd";
> > > +				bias-pull-up;
> > > +				drive-strength = <2>;
> > > +			};
> > 
> > These are not referenced anywhere? Not here in the sdhc_X nodes, and
> > also not in your msm8917-xiaomi-riva.dts. Would also recommend
> > consolidating these to a single node like in msm8916.dtsi, see commit
> > c943e4c58b2f ("arm64: dts: qcom: msm8916/39: Consolidate SDC pinctrl").
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c943e4c58b2ffb0dcd497f8b12f284f5e8fc477e
> > 
> > > +
> > > +			sdc2_cd_on: cd-on-state {
> > > +				pins = "gpio67";
> > > +				function = "gpio";
> > > +				drive-strength = <2>;
> > > +				bias-pull-up;
> > > +			};
> > > +
> > > +			sdc2_cd_off: cd-off-state {
> > > +				pins = "gpio67";
> > > +				function = "gpio";
> > > +				drive-strength = <2>;
> > > +				bias-disable;
> > > +			};
> > 
> > It does not make sense to have different on/off states for the card
> > detect (CD) pin of the SD card. It needs to work even when the SD card
> > is suspended so we can detect insertions/removals. Also should be placed
> > in the board-specific DT part.
> I have made these based on this https://git.codelinaro.org/clo/la/kernel/msm-4.9/-/blob/LA.UM.9.6.2.r1-04800-89xx.0/arch/arm64/boot/dts/qcom/msm8917-pinctrl.dtsi

Yes, msm8916-pinctrl.dtsi also has this in the downstream sources, but
as I explain in the commit linked below I don't think this is right. You
can probably just change it to bias-disable like I did for most of the
boards. There is usually external pull up that keeps it working even in
the "cd-off-state".

> > 
> > See commit dfbda20dabaa ("arm64: dts: qcom: msm8916/39: Fix SD card
> > detect pinctrl").
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dfbda20dabaa1f284abd550035db5887384c8e4c
> > 

Thanks,
Stephan
