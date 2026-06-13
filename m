Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF27E35DA5B
	for <iommu@lists.linux.dev>; Sat, 13 Jun 2026 07:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781336460; cv=none; b=PlvL++dQP3SoorjzwH0hjDYCjnSJhLCUqQgU79cNWtnPAbjNRzrXpMlX5O4s810S1ZMSBm2OvvXER4zGN8a2lIMKHcDweGw031KbWfQ3mX5olMgwe1nqlTlWVoiIwE+SgcOzTFnyn7DNQzZYyYZTLpkbgXCyF3to8b/kPZLx3KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781336460; c=relaxed/simple;
	bh=vKxsuOnHElxYLABaCL+A4fJkjVhRZLYiku7c7WLPJOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h4cl7Qf1T5LwFmAbmx7k5s/E/pdTRjFRWvov4RJQ7yvbMwBEMrY/oD+H+ORyX9r4wdBnDYlTGY+bQEEJa0eCH1LpXQhxV2kQjU2IAWJoa2I7rLzAA/yL4NYbVOh8YOWKS5C2/LCPdRR4KrLkV5Y8B+z1i3u7k7d2ecs7WrQBB0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=j96W15M5; arc=none smtp.client-ip=121.127.44.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="j96W15M5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1781336458;
 bh=qHK4xcuZuyY3VWkKdAkc6bfYV2q4RPDKWtvw4p7wT+w=;
 b=j96W15M5CI6OuzDSXfCWwYrh721XiWVI5wc8/V2W9UreeBNlYYNCqZ7ptRddTOQuCU2BqG6c9
 PiV/GTZH9Kl18sl+5GyqQkrnT1ZJhTQ5JPO6J4oFA/SjSa9qjGMDN3q1BBbe2iYy6Koh5f3kiVE
 fhNcDl+S+vobCmQjS1g9giM+8blgKd5pzU9VvKrmoNTfITkoMGoVwWWhEZ5xTEGVxTBFEcnBr6X
 Oy8wlPe1d1My/oq5o0efqMn0C7KDsEpm9WGRIjE43g8DbEohL4kAeuGBzsR1ct50lfgiO1pAZyH
 S29BZa9LYyzrZAWk1swpmmcLd7dZs+ziHb3mBsj+3Dmg==
X-Forward-Email-ID: 6a2d09837f2a6d9c19af5dbd
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.8.26
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <e0f044df-9d34-4e6e-aa48-9e4227b4bdf7@kwiboo.se>
Date: Sat, 13 Jun 2026 09:40:46 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 8/9] arm64: dts: rockchip: rk3568-rock-3b: Enable
 the NPU
To: MidG971 <midgy971@gmail.com>
Cc: "tomeu@tomeuvizoso.net" <tomeu@tomeuvizoso.net>,
 "ogabbay@kernel.org" <ogabbay@kernel.org>, "heiko@sntech.de"
 <heiko@sntech.de>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "xxm@rock-chips.com" <xxm@rock-chips.com>,
 "chaoyi.chen@rock-chips.com" <chaoyi.chen@rock-chips.com>,
 "finley.xiao@rock-chips.com" <finley.xiao@rock-chips.com>,
 "diederik@cknow-tech.com" <diederik@cknow-tech.com>
References: <20260613070116.438906-1-midgy971@gmail.com>
 <20260613070116.438906-9-midgy971@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260613070116.438906-9-midgy971@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Midgy,

On 6/13/2026 9:01 AM, MidG971 wrote:
> From: Midgy BALON <midgy971@gmail.com>
> 
> Enable the NPU and its IOMMU on ROCK 3B and wire vdd_npu as the NPU
> power domain's domain-supply, so genpd brings the rail up and down with
> the domain (the domain is marked need_regulator). The PVTPLL compute
> clock is brought up later by the driver.
> 
> The rail is no longer kept always-on, so pin it to 1000 mV (the NPU's
> 1 GHz operating voltage; the driver runs a fixed compute rate with no
> devfreq voltage scaling) and mark it boot-on, so it is up before the
> power domain de-idles the NPU NoC at power-on.
> 
> Signed-off-by: Midgy BALON <midgy971@gmail.com>
> ---
>  .../arm64/boot/dts/rockchip/rk3568-rock-3b.dts | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> index 69001e453732e..d3f9776c2bdc3 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> @@ -330,9 +330,10 @@ regulator-state-mem {
>  
>  			vdd_npu: DCDC_REG4 {
>  				regulator-name = "vdd_npu";
> +				regulator-boot-on;

There is no need for the NPU in the bootloader, do not use DT as a
workaround for software issues.

This series mention the PVTPLL NPU clk and seem to contains some
workarounds related to how the PVTPLL clock is handled in TF-A.

The PVTPLL block typically require the pclk and power domain enabled to
function, and this series seem to add workarounds to try and ensure this,
e.g. with noc_init to activate PVTPLL usage.

I would suggest that you do not involve the PVTPLL clock in this initial
NPU support for RK3568, set CLK_NPU to 400 MHz and use it instead of the
SCMI clock, or keep SCMI clk rate less than or equal to 400 MHz to
disable PVTPLL_NEED mode in TF-A.

In a future series you can extend Linux with a proper PVTPLL clk driver
and OPP support for the rocket driver to correctly ensure pclk and pd is
enabled when a PVTPLL clock is managed.

>  				regulator-initial-mode = <0x2>;
> -				regulator-min-microvolt = <500000>;
> -				regulator-max-microvolt = <1350000>;
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1000000>;

Please describe the HW, do not add workarounds for software issues or
shortcomings.

Regards,
Jonas

>  				regulator-ramp-delay = <6001>;
>  
>  				regulator-state-mem {
> @@ -787,3 +788,16 @@ vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
>  		remote-endpoint = <&hdmi_in_vp0>;
>  	};
>  };
> +
> +&pd_npu {
> +	domain-supply = <&vdd_npu>;
> +};
> +
> +&rknn_core_0 {
> +	npu-supply = <&vdd_npu>;
> +	status = "okay";
> +};
> +
> +&rknn_mmu_0 {
> +	status = "okay";
> +};

