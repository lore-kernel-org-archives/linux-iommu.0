Received: from mail-m19731119.qiye.163.com (mail-m19731119.qiye.163.com [220.197.31.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7C4311940
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 02:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780884983; cv=none; b=ElbWHb/ppGaht3xklLh7pi3Xte/apDRjzg0fLpLVbgQDLGW0AneN+1iuj1BkJyi4VZGW/oQvJUhR9h3p+KNeF1XmRr2JvOxbNQ/s6xogHs5RaahW9O2hiiyYzGGNRIdb9VyZEn3Zw1okS/QHkQUkL4oCV1oILzVtWqBU0tY1GaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780884983; c=relaxed/simple;
	bh=lWrFFzVFH+uZI4fq9CcaXDY6AJ+jlr3YcKA5DCz9wfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i7InsNXaKoD183+3VUrFEAEpIz+QcLKkqhByPSbAPRb0Dg2fY4cHFUU8/JcuEQs0oHOU1qqnU+Zhu7bS1k4n3n4nFfEOKqT5U9qXc70GzuojDIbksqPT4+ISWQEXwU+iEo5KrDU8g1VrRpZ0vq/20E6Yi8GmKbigb06P0PL/MUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=fd9Fgd70; arc=none smtp.client-ip=220.197.31.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="fd9Fgd70"
Received: from [172.16.12.90] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 416b76aca;
	Mon, 8 Jun 2026 09:40:38 +0800 (GMT+08:00)
Message-ID: <e5058919-9485-4de5-8eea-331ebfc2987c@rock-chips.com>
Date: Mon, 8 Jun 2026 09:40:36 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/9] accel: rocket: Add RK3568 NPU support
To: Midgy Balon <midgy971@gmail.com>
Cc: tomeu@tomeuvizoso.net, ogabbay@kernel.org, heiko@sntech.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Simon Xue <xxm@rock-chips.com>,
 Finley Xiao <finley.xiao@rock-chips.com>
References: <20260604135255.62682-1-midgy971@gmail.com>
 <3d99569e-9c3a-49d1-93fb-1335382523e9@rock-chips.com>
 <CA+GS1Y1s78PwN63X2YJoS8VEGp7CpTERo_K65yKs00U4VRAw4Q@mail.gmail.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <CA+GS1Y1s78PwN63X2YJoS8VEGp7CpTERo_K65yKs00U4VRAw4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9ea4e3928003a7kunm2dc5485516737a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHRhMVk8eQxpNQxkaSkIYTlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
	b=fd9Fgd70jQYunloQSZc2Sw1ViLh44FaOLEhh8/tp6FuCuEqh+zQpvglmCBICWSNY4eMQ2EG3F6nYIRDMlWBfyr07TaYpQAnqsDsnK7+my9QhXHjn1qw65oOnV0stueIXxBjcZ5b29o9ukMPv35PD2ONVCXGOSRJMTHrJjXosvds=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=UrntyxENooj6wbeRVkJOCbYDj96squyuxfsHscwtUdc=;
	h=date:mime-version:subject:message-id:from;

Hi Midgy,

On 6/8/2026 5:03 AM, Midgy Balon wrote:
> Hi Chaoyi,
> 
> Thanks a lot for looking at this -- input from Rockchip is exactly what this
> series needs.
> 
>> Hmmm. If I understand correctly, the NPU IOMMU should be v2 rather than v1,
>> implying it should support 40-bit PAs. Nevertheless, please note that the
>> upper limit for DTE is 32 bits.
> 
> Understood, and that 32-bit-DTE note is the crux of the trouble I had, so let
> me lay out what I see and ask how you'd prefer to solve it.
> 
> The mainline node is already v2 (rockchip,rk3568-iommu in rk356x-base.dtsi).
> The problem on this 8 GiB board: with the v2 ops the page-table allocations
> (gfp_flags == 0) can land above 4 GiB, so the DTE ends up > 32 bits and the
> NPU's first translation faults with DMA_READ_ERROR. To work around that I had
> switched the NPU MMU to the v1 compatible (rockchip,iommu), whose ops set
> GFP_DMA32 and keep the DTE sub-4 GiB. That works in isolation, but because the
> driver keeps a single global rk_ops, a v1 NPU MMU then trips
> WARN_ON(rk_ops != ops) against the SoC's v2 instances (VOP/VDEC), which is why
> I based the series on Simon's per-device-ops work.
> 
> So my question: with per-device ops in place, what's the intended way to keep
> the NPU MMU on v2 *and* cap its DTE at 32 bits on boards with >4 GiB of RAM?
> A v2 ops variant carrying GFP_DMA32 for this device, or is there a register/
> config bit that constrains the DTE address? I'd rather follow the Rockchip
> intent here than carry the v1 workaround. (Simon, cc'd -- this is right next to
> your per-device-ops series.)
>

If Simon's method works, please use it :)

>> Can these operations not be completed via the pmdomain driver?
>> If some operations are controlled by TF-A, are you using open source TF-A?
> 
> Most of it is in pmdomain already. Power-on and NoC de-idle are done by the
> RK3568 NPU power domain (genpd) at power-on -- the driver no longer pokes the
> PMU directly. Two things remain outside it:
> 
>  - vdd_npu: I mark it regulator-always-on in DT rather than wiring it as the
>    domain's domain-supply, because as a domain-supply it created a device-link
>    to the I2C PMIC (rk809) and genpd's power-off QoS-save path then hung
>    reading the NPU QoS registers behind the (gated) NoC. If there's a clean way
>    to let genpd own vdd_npu without that I2C ordering deadlock I'd much prefer
>    that -- pointers welcome.
>

Please refer to the patch below regarding the RK3588 NPU pmdomain.
In short, you need to set a "need_regulator" for the RK3568 NPU pmdomain.

https://lore.kernel.org/all/20251216055247.13150-1-rmxpzlb@gmail.com/

>  - the NPU compute clock (PVTPLL): set from the driver via SCMI, and only
>    needed for actual compute, not for bring-up.
> 
> One more pmdomain observation from testing, possibly relevant to how the NPU
> domain should be modelled: the domain's power-off/on cycle doesn't reliably
> re-de-idle the NoC. If the NPU is probed after genpd has already powered the
> (unused) domain off, the power-on de-idle fails ("failed to set idle on domain
> 'npu'") and the NPU IOMMU then takes an external abort on its first MMIO access.
> Probing the NPU before the unused-domain power-off, or marking the domain
> always-on, both avoid it. Is the NoC de-idle expected to work on a genpd
> re-power here, or should this domain effectively stay on?
>

Not quite sure what's going on with PVTPLL and NOC.
Maybe @Finley knows about this?

> On TF-A: yes -- bl31 is built from upstream arm-trusted-firmware
> (github.com/ARM-software/arm-trusted-firmware, RK3568 platform), providing PSCI
> and the SCMI clock service. The only closed blob in the boot chain is Rockchip's
> DDR init (rkbin), which is the standard situation for mainline RK356x.

-- 
Best, 
Chaoyi
