Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C8921A45A
	for <iommu@lists.linux.dev>; Fri, 20 Dec 2024 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734715829; cv=none; b=SYz3xsksz4jANuaj1AeDzBk26DR46GMpmTe5sPhGH9ewWjrI+wjH0xT/2/G1C6SaShoZJzePIws1ZD0hEjcbXl5+wokqsX3bDHgkPbY4QqouM05KTH8cljRTBUE6FzzYuEdj4MXH1gjHG6ahrb0LlNXlJZn1jNiUXTxXgz7/XyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734715829; c=relaxed/simple;
	bh=bAysmXT1ApL4MZsbGXlIGLiZFW3xoeOXskBVjon1K5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKW3b8eeGW/TpAAsNlALgtvRV8hfUL71pEyDjghO6oHxC/j7Q/3SpQPU6wOq29AcD3Apn3N34xvF/j8rIRbs+dLiZOeSQHtf17vVIVki8x2Otck0o3JrhO1lLArqPlAZS9n6z+dGstwZfucQ5JthPPUkMfQUjV6I6PxOPB8AXJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xQm50shz; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xQm50shz"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3bdccba49so3619152a12.1
        for <iommu@lists.linux.dev>; Fri, 20 Dec 2024 09:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734715826; x=1735320626; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TJaoXje8uHao+uzoShrvm+9AXWvGP52yQ1oIubMZeDc=;
        b=xQm50shzEJ/S7Q5rJhpvP+Wcj2AD9NC8X/bsWBQISSVWDEsUrSXyExcHRpxsTeqSwF
         CFWMXZ2ZL4TsuIGwHkPkUUL6kWfTKQmAwcflbPTFpzOD/goqSaSvGjmLUCEK5ls570zT
         XpxcgHGBbgRIp80/Nxjpj9RMnsJBY1MjfqmCnjGrnGq62mBQI8zLWS7xmF5kcuG+LzXi
         hDeoxwi1EoPkiURoMw7Xb7eMDLvYxYjz8xxEmGafsmtTL58pgUMdqdWosEorYzXlv/XK
         Q8lsdtiL2/A4hcOo0yluIYVA0F2pEytJBC+PbjTj9qZ72XUISg/SMVppdS4ocU3MIvaz
         Vrsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734715826; x=1735320626;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJaoXje8uHao+uzoShrvm+9AXWvGP52yQ1oIubMZeDc=;
        b=v6nLxGOvC0+Sd6gtO5nQxbROFaMsoUkGd6f8VDfS3nXckki8fiHZ4lT8VAHa88Sdx8
         ArUJEMVDO4VLRfe06Rd4uLoq6WiwMPpMssAWZvjKgHLeAO2TqBi1Csosl5fGrPg95KRr
         WafHLzKwo6njZhmLNASdyEoFeCeS7nw8viwrvl0TFZustjJoC0GSV9Y4NNMLkfV/l+VU
         2MOgcnc8RH7RF/MiLL/LyFcKYcaf5sVoGgbW/2wZQfZZi3tAxiaj9grGWzCwmp3ymkgH
         QiW3OMOr1hWEnGfqurXivaMFRszWUd3kxDqiY9cWt+nKFGMg6OQDQf7/X9ilaPAU9FnM
         YBlw==
X-Forwarded-Encrypted: i=1; AJvYcCVNqx5XCbQQzBskSSHhPQuH9QGn+CpguoJjOgK5UgtA3XTGofPJ5FXroMvF85RRfEkCDJB6iA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwE5VsOo1U1AtFidEePYS+G5Gms6HerLu7kSR8MonlWxp/MvnIt
	lWxJugmv+FobE5t3dOvo1UmjMmQ4OhDWb4Rf2cS3DrGLU0h1PJL3/Tk+VC8NQ7c=
X-Gm-Gg: ASbGncuqfoy/nebSbvDWPVIEjnPOFrve0mnAuivxxzQNyj8v0wEPRsLmBQb6rlkg5bJ
	Xya4rSHynZhyB1C6khgx9g99KOBzsoPGg/4+1YsMR9w69d+xY0Vt9Emkv0X/Z5DcfWTI3m+t3MA
	rJvJzOcvkxRFD5zHNMAY3z4lW2bDt4fcqQfe8XkQJf9qIAIxl7QlFfbFcUyiwc2qj7thW+6bOcy
	YPhz1jdlHB2Xrau+qFjL+c7IKgClpjeEnP+HKdjHQKhuj6djgzdN48NDTLIBklrMycb
X-Google-Smtp-Source: AGHT+IH7+XcVUt5iV5cF3xg1wrooGDBJq1k5sc95u227IWRCzMGea6RcPb0ttVzenGGImX0jMdU8ww==
X-Received: by 2002:a05:6402:35c7:b0:5d4:34a5:e317 with SMTP id 4fb4d7f45d1cf-5d81de1611dmr3897302a12.22.1734715825516;
        Fri, 20 Dec 2024 09:30:25 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef80:6d2c:6f87:64ef:2237])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80675a3d2sm1928475a12.16.2024.12.20.09.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 09:30:25 -0800 (PST)
Date: Fri, 20 Dec 2024 18:30:22 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: =?iso-8859-1?B?QmFybmFi4XMgQ3rpbeFu?= <barnabas.czeman@mainlining.org>
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
	Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v10 3/5] arm64: dts: qcom: Add initial support for MSM8917
Message-ID: <Z2WprlxV4wop0jxB@linaro.org>
References: <20241220-msm8917-v10-0-3d5734e8c3a6@mainlining.org>
 <20241220-msm8917-v10-3-3d5734e8c3a6@mainlining.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241220-msm8917-v10-3-3d5734e8c3a6@mainlining.org>

On Fri, Dec 20, 2024 at 12:26:55PM +0100, Barnabás Czémán wrote:
> From: Otto Pflüger <otto.pflueger@abscue.de>
> 
> Add initial support for MSM8917 SoC.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> [reword commit, rebase, fix schema errors]
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8917.dtsi | 1954 +++++++++++++++++++++++++++++++++
>  1 file changed, 1954 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8917.dtsi b/arch/arm64/boot/dts/qcom/msm8917.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..7bd6925029eeb9d6d49a99f8686181e926258cab
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8917.dtsi
> @@ -0,0 +1,1954 @@
> [...]
> +		a53pll: clock@b016000 {
> +			compatible = "qcom,msm8939-a53pll";
> +			reg = <0x0b016000 0x40>;
> +			clocks = <&xo_board>;
> +			clock-names = "xo";
> +			#clock-cells = <0>;
> +			operating-points-v2 = <&pll_opp_table>;
> +
> +			pll_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-960000000 {
> +					opp-hz = /bits/ 64 <960000000>;
> +				};
> +
> +				opp-1094400000 {
> +					opp-hz = /bits/ 64 <1094400000>;
> +				};
> +
> +				opp-1248000000 {
> +					opp-hz = /bits/ 64 <1248000000>;
> +				};
> +
> +				opp-1401600000 {
> +				      opp-hz = /bits/ 64 <1401600000>;

Nitpick: indentation is off here.

Anyway, this looks really nice overall now. Thanks for doing all the
cleanup! FWIW:

Reviewed-by: Stephan Gerhold <stephan.gerhold@linaro.org>

Thanks,
Stephan
