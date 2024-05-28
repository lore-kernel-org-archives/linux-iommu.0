Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1F017332F;
	Tue, 28 May 2024 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716916973; cv=none; b=gT5OhRY2uNTvK7XJZob53hw+ZsGlEHS2n71YdP48+ft0kvcsPYkzDBH0fjp1Sm21vxd8pGV08OZbPAVsQXCMUv35xNF8X5KvA7yM3AY232Ouc1kDRvfsbVLtIvQd/CH9ZO18G9JnMDmzt3K4+hSj9N2QQE78I4ZwmHkqv0NiqSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716916973; c=relaxed/simple;
	bh=2HyNbNQGBgxKpo9RslTgNtuxOxyyywDaZX7/wApMydA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4uYMsNRfLJX3txdfRDzFRB1lI93mbSa5YdbLlIen7vL2XZ0wvuMKY/xL1lyYrPNoph2u04Gn8vzQ27MLH0ZulSPks6gzuWJcdWAAlO/9C3E6iavq5WnnF0QwoDF22jyVU3AfVlcv3Noz6apgZK/7KRKcK48oJ74FRtmRYzeC3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xd8mnexG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xd8mnexG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF42C32782;
	Tue, 28 May 2024 17:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716916973;
	bh=2HyNbNQGBgxKpo9RslTgNtuxOxyyywDaZX7/wApMydA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xd8mnexGaqq8cjC6C6eoKdnuJgMldb1K9hFGyBfQZ0FNG6XhcKriRpcV4sHSsT/w8
	 LIBdxsN6HQWgHa91xBrOghQ89+7ppXrAAeVyd2KZImVYWIKFaCob5iijtUzXmh+V7y
	 VyJUadaSZIPffn4r266j1NPu7Qzq/sz/LajlPE4wnqjRpCOnSg2Mkc6CMmDIBh8Vbt
	 iRpdvBXefOmNl6ElfjYnNtfEOemLaM0QLOHyKXp2eJ2BoksNZlz1rmgUA8KMm8a4b5
	 g1o0c9TQFaojnaO9RBBh96q+K92rqPZuoeDqihjr3V1jo6B4mSDXXbo3/YNNF0+2yd
	 VBrs3up5DpfBA==
Date: Tue, 28 May 2024 12:22:50 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sdm450: add Lenovo Smart Tab M10
 DTS
Message-ID: <f6tjklf4heftigijdekk76bhwgneammqluwegpotqjhe7m5kkv@waiaemvi6u4j>
References: <20240523-topic-sdm450-upstream-tbx605f-v1-0-e52b89133226@linaro.org>
 <20240523-topic-sdm450-upstream-tbx605f-v1-3-e52b89133226@linaro.org>
 <r243r56bz7nrp2guaqj2n26exdv6y5jyjtoytmceutd3cqbaao@r5xk3qlspwsi>
 <9d26e798-739c-4128-8d34-79725f1b058d@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d26e798-739c-4128-8d34-79725f1b058d@linaro.org>

On Tue, May 28, 2024 at 02:19:28PM GMT, Konrad Dybcio wrote:
> 
> 
> On 5/27/24 18:33, Bjorn Andersson wrote:
> > On Thu, May 23, 2024 at 09:59:35AM GMT, Neil Armstrong wrote:
> > > diff --git a/arch/arm64/boot/dts/qcom/sdm450-lenovo-tbx605f.dts b/arch/arm64/boot/dts/qcom/sdm450-lenovo-tbx605f.dts
> > [..]
> > > +&rpm_requests {
> > > +	regulators {
> > > +		compatible = "qcom,rpm-pm8953-regulators";
> > [..]
> > > +		pm8953_l8: l8 {
> > > +			regulator-min-microvolt = <2900000>;
> > > +			regulator-max-microvolt = <2900000>;
> > > +		};
> > [..]
> > > +		pm8953_l11: l11 {
> > > +			regulator-min-microvolt = <3300000>;
> > > +			regulator-max-microvolt = <3300000>;
> > > +		};
> > [..]
> > > +	};
> > > +};
> > > +
> > > +&sdhc_1 {
> > > +	vmmc-supply = <&pm8953_l8>;
> > 
> > JFYI. Not ensuring that the vmmc-supply is in HPM mode bitten us
> > multiple times in the past.
> 
> it's not rpmh ;)
> 

Here are a few non-rpmh examples of us being bitten...

e38161bd325e ("arm64: dts: apq8096-db820c: Increase load on l21 for SDCARD")
03864e57770a ("ARM: dts: qcom: msm8974-hammerhead: increase load on l20 for sdhci")
27fe0fc05f35 ("ARM: dts: msm8974-FP2: Increase load on l20 for sdhci")

...taken care of by forcing the relevant regulators into HPM.

Regards,
Bjorn
