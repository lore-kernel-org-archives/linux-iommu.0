Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D7624293C
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780909892; cv=pass; b=J4VSAqYidZsUX6McvJw4zuYbyIBPeXNBGDDwQ+rmZIS391PaMprIbvaOtVhHWcZLq7KulZIX7GvH0lwjztibPSHXisHlbzBF1g+gOvHDVrrE0AmK7naDjeGubgV78tTofowNLRUHsUeMUAxQ3P9MlN/NzFvM4ZKUeyebsJVKDFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780909892; c=relaxed/simple;
	bh=z8TRp/eansM7NQFOUeoehuya+exenRZRyWpFPzqPkDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmfYsyOpUevUrHSYsgIrppB+QZtShwBUo3ocKW8REnFPxXk516CnChju4Hc5tAyjNyAJKcrtOpjwZKW7IxzXsBxOpqbxX+McpJJK7hzmyk3u8yz72HwTZ7peaQ19JZYO+SLc++Pcr+hGzVBwag+oskBTF0HwRwC5FB2jkiLo5wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaW+3l0j; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaW+3l0j"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-befd83e0521so916559866b.1
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 02:11:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780909889; cv=none;
        d=google.com; s=arc-20240605;
        b=YJN37Lr500O9InT3JvxtH1nAuEG7QcXj/aZJc/W2pOBmuIq4nkYTl4KaIxbvRm8BnE
         vc4QuqUCrxPGxA4wi0fS4inC7r9ci4c6tGgBC2jxJ3BykDnEkoR+bYVBlzuxvLYJ2Hdm
         dcKQUwMayW1dNkgHDNvEdtysjPCpru+HG7bXQwUA4OMFJkwDkdkDs/3Q9H66OQgVV2Mt
         bsC6NzAKb/5YY++4QNnpVNavire+0tk8k+Tq6kIqfv/Kj1NHfoQw2OARb3w7ykSk9iDs
         bQRMcErnq6sRlK9kUvYSK+/2B7ar3CVzI3elwnJ0d93cs1XC2bwn5S5Flhvw4U0oTq2v
         eiJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WelUToYaunngdS4iiekhxlbrmFbbBfrAT5j9UWPzR4A=;
        fh=Xk2yrOtBQbHmB4ghmkH/Jc5CGpZOJaWaqlvs+TqOgWY=;
        b=E1Etckeuzz/RiAN1ZWT49cD9ns5vV9HeLYnzyfi9XBGXj/gMqK2DBSy0KyftCxgyue
         oRBokm5AALfSFmB13RWmtTjnIq+wLYtb9N6S61Z8pVo5cUQeYwiA1IfETQuXyy40yYyi
         jg+/KylfY9Z5OLk96LSO0nwRao00q0H2zGg1xHomxpQJmPVu/8emilcQRJV/YEJmXlQ1
         fsnkTQlyjB4xkyMPinYYXTkIl6WCGTA8jtHMNYYoMqgZeheey1jfzRr5ENFnp6j2AETU
         tPN7E/dAcHZpH1MejlYfexfvrn7dhym3l/dWyhFJBiup5e1+WulVnjV6CL5+DNie1GS/
         sOoQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780909889; x=1781514689; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WelUToYaunngdS4iiekhxlbrmFbbBfrAT5j9UWPzR4A=;
        b=HaW+3l0j+TckUTHcl+8cHn3lWNJ9B69ANMrjT6/3E9u+Wlxzp4Ufi9dtvzEAgHLhRA
         T1RdinNNHQW7HiWJ2G56v7dRgID7vLTsBwJMIsDirfI/3AlyycuVIEI5GM3kmTtw/CUs
         1pdnqiBP4KKRNcmlv8fH5dFSjUbITeW1MPhf7wNpEtq49PukBKlPvKSHorDLfhMC3KeR
         dkURME6WlryMT3ga5bNb4Z0oFoqfHhMwfDXTnGnrTlOVV6Cv5Nzkm76rkUY0J3y+EI1v
         ocJ98WiYogfuTs18BYbMqOXWJ4rwijxc6Xsz+MdVcJ9xm6TsY+WSKf2GikaCM1mY0wIL
         BBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780909889; x=1781514689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WelUToYaunngdS4iiekhxlbrmFbbBfrAT5j9UWPzR4A=;
        b=qAdjSH9yh8oWJ7cw7exqjaL6JXiwfr8e1nRgALyOgc8EBi7pMkwUKyZXBGzEElIOTC
         rpLcCF74Nsebk/jiFdn3O46ud8fLUA9nWqM3lr1ycSqWkGWtEj/yAhx0R2DXvt3UH/HG
         klruECc2zwIMRduPpZXnP9gbiHW0569LZjio3alD4f+D6dIkncmLghTB+cnyRuz7cRpT
         ZSBqXorNlHM8Zea1XmXBYkPOCkDN8bi2TuZKVQWWA5dG/Vq4yDaFmiEv2APJ42TpTLEC
         qKCmnf5yl2EufbkmldY5hHFVpf105jTubWipgohZZd2VCPA3lxZ3qzAdEJHhGOE6bOVn
         6qfQ==
X-Forwarded-Encrypted: i=1; AFNElJ9LvDwjMyiMC+PCL1xAwEOz0S9l+dsWXJLPBiOx8NOITM9jbTbsj5OhWr5u4CLDbqwOPOnpkw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyja2PAWQHOyXs4F2OIEhl+12EdFozJbmpckr8i8BCoy6i0+o6C
	CYbn0hxbCcZ4i0U9VLdN+r/kzu7nNXFrZ/9/+NUMVRZwDRULcvSStpI4h1LXu6hD5JOYe9CzcwM
	txL0WHbIwEUeTi3UvHH4piNAFdEa5LoM=
X-Gm-Gg: Acq92OEpx2QOYYS1V2EkgVOB9xvzo1i7tlpi8cX6HbS2NIDrk1uyt7lOf33tEWOwe7c
	uVsmn05yLCOwBxuLHR+kmjSDd5JG7eB6Rg/Gy11eyH2grfvvA5OAudQD7usJdvbexKNuV7vEHFl
	BrkG45F2cHcpWBjqIph3NJ6jRSD5L8b2WwR3QPmHXzt1QxNRrISrCy4xiWviSXYtWendvGdOQkB
	GTLgy6vqcGOz6wxmE/u9P7rIUdSDUN5J3gzSYnaTQJZj5lxvjLl7PxHqDZMlfGp0jN570wR0oiy
	WshAXsyvT+s9fxy98g==
X-Received: by 2002:a17:907:2d12:b0:beb:2980:e2d2 with SMTP id
 a640c23a62f3a-bf3a6b13b16mr580109766b.8.1780909888634; Mon, 08 Jun 2026
 02:11:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260604135255.62682-1-midgy971@gmail.com> <3d99569e-9c3a-49d1-93fb-1335382523e9@rock-chips.com>
 <CA+GS1Y1s78PwN63X2YJoS8VEGp7CpTERo_K65yKs00U4VRAw4Q@mail.gmail.com>
 <e5058919-9485-4de5-8eea-331ebfc2987c@rock-chips.com> <CA+GS1Y3ysdWZ3qCq3ip_Pbw+v4LxHZd95aBo=jwB+orYaMBBNw@mail.gmail.com>
In-Reply-To: <CA+GS1Y3ysdWZ3qCq3ip_Pbw+v4LxHZd95aBo=jwB+orYaMBBNw@mail.gmail.com>
From: Midgy Balon <midgy971@gmail.com>
Date: Mon, 8 Jun 2026 11:14:17 +0200
X-Gm-Features: AVVi8CefQKT7ky3Sqeq6MkiJ04hcvCvZiupw30w_yNvYYxCVtDBxVUNhbRaFSOk
Message-ID: <CA+GS1Y0kAM_XGLQuKPTphif2HcQg18ZXhd8RHHr2xPOEMCDvXA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/9] accel: rocket: Add RK3568 NPU support
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: tomeu@tomeuvizoso.net, ogabbay@kernel.org, heiko@sntech.de, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, dri-devel@lists.freedesktop.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Simon Xue <xxm@rock-chips.com>, 
	Finley Xiao <finley.xiao@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Chaoyi,

Following up on the need_regulator suggestion -- I implemented and
tested it on the
board, and unfortunately it doesn't avoid the deadlock on RK3568; it
moves it from
boot to the NPU job submit.

What I did: gave the RK3568 NPU power domain a regulator (a DOMAIN_M_R
variant with
need_regulator =3D true), wired domain-supply =3D <&vdd_npu>, and dropped t=
he
regulator-always-on workaround.

Boot is now clean and the NPU probes, but there is a warning during boot:

  rockchip-pm-domain ...: Failed to create device link (0x180) with supplie=
r
  0-0020 for .../power-domain@6

(0-0020 is the rk809 PMIC that supplies vdd_npu.) Then on the first NPU job
submit the board hard-hangs with an RCU stall:

  rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
  rcu:     3-...!: (1 GPs behind) ...
  rcu: rcu_preempt kthread starved for 5115 jiffies! ... RCU_GP_WAIT_FQS(5)
  rcu: Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expe=
cted

My reading: vdd_npu is on the rk809 *I2C* PMIC, so when genpd
enables/disables the
regulator during the NPU's runtime-PM power transition, the I2C
transfer runs in a
context that starves RCU and the box freezes. (I suspect
need_regulator is fine on
the RK3588 NPU because its supply isn't behind an I2C PMIC.) The always-on
workaround avoids this precisely because genpd never touches the I2C
regulator in
that path.

So: for an NPU domain whose supply is an I2C PMIC, is there a
supported way to let
genpd own the regulator without performing the I2C op in the
power-transition path
(a deferred/async regulator enable, or a flag), or should RK3568 keep vdd_n=
pu as
regulator-always-on? For v4 I'll keep always-on unless there's a cleaner pa=
th.


Thanks,
Midgy

Le lun. 8 juin 2026 =C3=A0 10:05, Midgy Balon <midgy971@gmail.com> a =C3=A9=
crit :
>
> Hello Chaoyi,
>
> Thanks -- this is exactly what I needed.
>
> - v2/DTE: will do. I'll keep building on Simon's per-device-ops series --=
 with
>   that in place the NPU MMU can use the 32-bit-DTE ops (the per-ops GFP_D=
MA32
>   that's already in mainline) without the global rk_ops conflict. I'll
> keep it as
>   a stated dependency of the v4 cover letter.
>
> - vdd_npu:  I'll switch the RK3568 NPU
>   power domain to need_regulator + domain-supply =3D <&vdd_npu> and drop =
the
>   regulator-always-on workaround. I suspect that's also the right fix for=
 the
>   power-off/on de-idle issue I described -- the always-on was really
> just papering
>   over the domain not being modelled with a regulator. I'll confirm on
> the board.
>
> - AUTO_GATING: thanks for the commit references -- I'll keep the bit-31
>   read-modify-write form with your Suggested-by and write the comment
> from those.
>   For the record: on v7.1-rc6 the NPU MMU also completes translations
> on the reset
>   value (I couldn't reproduce a page-walk stall without the write), so I'=
ll note
>   in the commit that it matches the vendor clock-gating handling rather t=
han
>   fixing a failure I can reproduce here -- happy to drop it if the iommu
>   maintainers would prefer.
>
> - PVTPLL/NoC: I'll follow up with Finley. First I'll check whether the
>   need_regulator change resolves the NoC re-power de-idle on its own;
> if it still
>   I'll bring him the details (the genpd power-on de-idle ack and the
>   BUS_IDLE_ST state).
>
> I'll send a v4 with these. Thanks again for the quick, detailed answers.
>
> Kind regards,
> Midgy
>
> Le lun. 8 juin 2026 =C3=A0 03:40, Chaoyi Chen <chaoyi.chen@rock-chips.com=
> a =C3=A9crit :
> >
> > Hi Midgy,
> >
> > On 6/8/2026 5:03 AM, Midgy Balon wrote:
> > > Hi Chaoyi,
> > >
> > > Thanks a lot for looking at this -- input from Rockchip is exactly wh=
at this
> > > series needs.
> > >
> > >> Hmmm. If I understand correctly, the NPU IOMMU should be v2 rather t=
han v1,
> > >> implying it should support 40-bit PAs. Nevertheless, please note tha=
t the
> > >> upper limit for DTE is 32 bits.
> > >
> > > Understood, and that 32-bit-DTE note is the crux of the trouble I had=
, so let
> > > me lay out what I see and ask how you'd prefer to solve it.
> > >
> > > The mainline node is already v2 (rockchip,rk3568-iommu in rk356x-base=
.dtsi).
> > > The problem on this 8 GiB board: with the v2 ops the page-table alloc=
ations
> > > (gfp_flags =3D=3D 0) can land above 4 GiB, so the DTE ends up > 32 bi=
ts and the
> > > NPU's first translation faults with DMA_READ_ERROR. To work around th=
at I had
> > > switched the NPU MMU to the v1 compatible (rockchip,iommu), whose ops=
 set
> > > GFP_DMA32 and keep the DTE sub-4 GiB. That works in isolation, but be=
cause the
> > > driver keeps a single global rk_ops, a v1 NPU MMU then trips
> > > WARN_ON(rk_ops !=3D ops) against the SoC's v2 instances (VOP/VDEC), w=
hich is why
> > > I based the series on Simon's per-device-ops work.
> > >
> > > So my question: with per-device ops in place, what's the intended way=
 to keep
> > > the NPU MMU on v2 *and* cap its DTE at 32 bits on boards with >4 GiB =
of RAM?
> > > A v2 ops variant carrying GFP_DMA32 for this device, or is there a re=
gister/
> > > config bit that constrains the DTE address? I'd rather follow the Roc=
kchip
> > > intent here than carry the v1 workaround. (Simon, cc'd -- this is rig=
ht next to
> > > your per-device-ops series.)
> > >
> >
> > If Simon's method works, please use it :)
> >
> > >> Can these operations not be completed via the pmdomain driver?
> > >> If some operations are controlled by TF-A, are you using open source=
 TF-A?
> > >
> > > Most of it is in pmdomain already. Power-on and NoC de-idle are done =
by the
> > > RK3568 NPU power domain (genpd) at power-on -- the driver no longer p=
okes the
> > > PMU directly. Two things remain outside it:
> > >
> > >  - vdd_npu: I mark it regulator-always-on in DT rather than wiring it=
 as the
> > >    domain's domain-supply, because as a domain-supply it created a de=
vice-link
> > >    to the I2C PMIC (rk809) and genpd's power-off QoS-save path then h=
ung
> > >    reading the NPU QoS registers behind the (gated) NoC. If there's a=
 clean way
> > >    to let genpd own vdd_npu without that I2C ordering deadlock I'd mu=
ch prefer
> > >    that -- pointers welcome.
> > >
> >
> > Please refer to the patch below regarding the RK3588 NPU pmdomain.
> > In short, you need to set a "need_regulator" for the RK3568 NPU pmdomai=
n.
> >
> > https://lore.kernel.org/all/20251216055247.13150-1-rmxpzlb@gmail.com/
> >
> > >  - the NPU compute clock (PVTPLL): set from the driver via SCMI, and =
only
> > >    needed for actual compute, not for bring-up.
> > >
> > > One more pmdomain observation from testing, possibly relevant to how =
the NPU
> > > domain should be modelled: the domain's power-off/on cycle doesn't re=
liably
> > > re-de-idle the NoC. If the NPU is probed after genpd has already powe=
red the
> > > (unused) domain off, the power-on de-idle fails ("failed to set idle =
on domain
> > > 'npu'") and the NPU IOMMU then takes an external abort on its first M=
MIO access.
> > > Probing the NPU before the unused-domain power-off, or marking the do=
main
> > > always-on, both avoid it. Is the NoC de-idle expected to work on a ge=
npd
> > > re-power here, or should this domain effectively stay on?
> > >
> >
> > Not quite sure what's going on with PVTPLL and NOC.
> > Maybe @Finley knows about this?
> >
> > > On TF-A: yes -- bl31 is built from upstream arm-trusted-firmware
> > > (github.com/ARM-software/arm-trusted-firmware, RK3568 platform), prov=
iding PSCI
> > > and the SCMI clock service. The only closed blob in the boot chain is=
 Rockchip's
> > > DDR init (rkbin), which is the standard situation for mainline RK356x=
.
> >
> > --
> > Best,
> > Chaoyi
