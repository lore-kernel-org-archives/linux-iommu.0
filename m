Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C34433A014;
	Tue, 28 Apr 2026 06:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777359367; cv=none; b=c0sICjvcK8YOg48POwUSv+xhPk7Ss+ZfQGZKA2DkbY9fSS6KBK7jV2T9vRaArnTP0aHAXcgfh2eO0GE0s5juJGmQn0uh0K1x4Xq6ShXTTziNvM/zg6Dh7XC+id2VeciiKkmFQnb1QZj9ntWs62zLDtyxWv4biic/cjxUqMzJj38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777359367; c=relaxed/simple;
	bh=QeaEkgB9qXRMZH4lw8BH9d5lPmwzC3VKrYrbh7I6zPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BortLfNtc62GG1Xz1db78gncc5+NZGhm8kYFFYsSGNlXsGnlEfDcGwzzMQ3GW7iJDOVbM4uAnGTsltkUNwrx9T1S5dKREiWJMelYxZK1e6hhU5cTAvYNLADOJMBpAYguEKH1PAl2WqB/lC5hh+ncGajVCs5bPqtMjLENwfAiIA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qO7UJDjq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qO7UJDjq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDF2C2BCAF;
	Tue, 28 Apr 2026 06:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777359366;
	bh=QeaEkgB9qXRMZH4lw8BH9d5lPmwzC3VKrYrbh7I6zPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qO7UJDjq2gTtXyPBMPfAManjJj37VoTuam+lGTAPs6zG26slluqYJIM7cj7H5/RfA
	 p/jUXJD+izV0k/s4wPDAuOD1YSRHhH+f3Xxac9QAmPvg7QTWZwgWlbBB3qCQzkUI00
	 KqggtJ9J2JW6ck325ynAZhNZV9vQDY73ajvLUMvt7nLK+CFOsMlc4knY022AUeUt2N
	 pQD1FSh9wV39isM935ZcmMnLDlVGXS21RlG8ciQOebvFJrs5JmVj3F6njsFtNEdcWi
	 osHM5MxXGiY7WhJ3qQJq/ajhoDwMSDDt6/l87Fn5LB+HSTor2TnL+hGY7jJcK7gp0c
	 HVtmn1oIswKdg==
Date: Tue, 28 Apr 2026 08:56:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexandre MINETTE <contact@alex-min.fr>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Guru Das Srinagesh <linux@gurudas.dev>, Linus Walleij <linusw@kernel.org>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, iommu@lists.linux.dev, 
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] ARM: dts: qcom: pm8921: Add USB ID extcon
Message-ID: <20260428-jumping-discerning-oarfish-d2caf1@quoll>
References: <20260427-mainline-send-v1-sending-v2-0-dcaa9178007b@alex-min.fr>
 <20260427-mainline-send-v1-sending-v2-7-dcaa9178007b@alex-min.fr>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260427-mainline-send-v1-sending-v2-7-dcaa9178007b@alex-min.fr>

On Mon, Apr 27, 2026 at 09:34:53PM +0200, Alexandre MINETTE wrote:
> Add the PM8921 USB ID interrupt as a disabled extcon provider. Boards
> can enable it when their USB controller consumes the PMIC USB ID state
> for OTG role detection.
> 
> The interrupt corresponds to PM8921 USB_ID_IN, block 6 bit 1.
> 
> Signed-off-by: Alexandre MINETTE <contact@alex-min.fr>
> ---
>  arch/arm/boot/dts/qcom/pm8921.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom/pm8921.dtsi b/arch/arm/boot/dts/qcom/pm8921.dtsi
> index 535cb6a2543f..30366536f580 100644
> --- a/arch/arm/boot/dts/qcom/pm8921.dtsi
> +++ b/arch/arm/boot/dts/qcom/pm8921.dtsi
> @@ -121,6 +121,13 @@ ref_muxoff: adc-channel@f {
>  				reg = <0x00 0x0f>;
>  			};
>  		};
> +
> +		usb_id: usb-detect {

You should not mix non-addressable children with addressable. If you
really do not have address, but other children have, then probably this
is part of the main device, so should be folded into the parent node.

Best regards,
Krzysztof

