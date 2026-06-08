Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A07B395AF2
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905768; cv=pass; b=hbIn1i7LE3bg51wZ/T3QRQlWAawORX4jRRgfPipCWvHtHhkk06MpyDSG3WvyaWwMB72011cB3xgPdPM1xzRbj2PoSPuwcFVh4gOJCErFRe3R022UesTGwMmU4/LTD6J8ZQNTDfiwmFFCDWuAkWPuz5z+FCN+WMZ35w/K9TTVjMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905768; c=relaxed/simple;
	bh=L+PASBKZU5VOSi5OLxHETsujAKlLOtM0nYg9yVoQr/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nas0tYUNijdScw2Dso7jr5SyjdV9Tfakr6RGZemq4tUaPTJGsCeSbeCf7BRX7BEIo0JSjnlVEmX9Lp6oBjG3fPZma6DAFuptMq1njQQSQsXOxNAbsm9CD9pY9Q2bUWQal3WRlDpegaUOnTGOl1GGqx6fzyiyd4Ad5hLjKVUtryQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfDLcahD; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfDLcahD"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68bac6e24fdso5351911a12.1
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 01:02:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780905765; cv=none;
        d=google.com; s=arc-20240605;
        b=DDq6HLy+x1bsZ0MKwNoYqkoah6ydc4o3M7yxRzuulS/W5EsD5SLkigyWoB3Z8NyFGK
         dY3QqGbIzKnNbnZPDNCT8lDXI7i5rgdeIGjBdxYXruzuTmUIP/kcRP0v2ugW7o+u/kwh
         3BboOJPdKhzKIOO+Akg1Cyk5MGnSLNYjcHgq2wyAYUCWaZnVKVC04MXneRITjmY51zTW
         LSUDmSzUoDlBZ7Iub8vJY3YG0s0WhcA96kqvpr1nRTmsBT2YYvfpgLYwXEBgipPt2y+w
         m4Ak8gujYMHpZ5SyK4+rexf0ngpSABv1Z3RUG6qZIEHb3YYGvHSWa/3q0vCkUXTgdbf0
         prsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bLq1D7uP5MxHvai6FqrEhNmJ5qKAoR2b/ce+Jxe1kds=;
        fh=c9hid4QU8N+JKCXIFK2rI9Wz8kpZU7bm7jUFAsK7B9A=;
        b=IYvJqPCNfLhuvRZZ9BDZ7ycewZwY8E+k7HMW506U8GKuYmyEVrPulW+BUzmzyuYVQk
         vytaHDKy98VEkjwUTHWVeY3resCBxJkecp9Fgvkc/XdajHUl0G5pmDDrIY4rSvemDBbC
         SDO55uHAPEGqrG4o6BNvtHoPoN6gfsOlyxisPHzAVPMAIBpMokDjm8WFIgLuLKh2V047
         a1BjC6CH8R31TRDN3GzKHPuncj33n5SElhj5BVsUFp5/YbD/vt21dgmJ7dVuFKy6J/1+
         S85NX8/1K1T37jCLfF71uuYnuKHz/cqr49bjL0mzWgTwuz7nM4tWLv0+u89V5Erq5ysQ
         pX5Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780905765; x=1781510565; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLq1D7uP5MxHvai6FqrEhNmJ5qKAoR2b/ce+Jxe1kds=;
        b=gfDLcahDaGHkmP7327+QGs5KRmmPu/NSdLVAuuumLUwHAhrgfH4JY9W7sFXzcqgUwy
         rfhr47xIy+eOLh5npWfHAyaFEiFUQTBr7gC7r4sOaJK3sjhaMT6rvKPG8Vo8pB1zAHVz
         DqshFGf6AggbpdJ1vOsqBMNM/ekyfGQNhh+yOhl3mcBnn0m58gtVbn7E8dvE2OcnsS7u
         qLTeg1t0Pns4VvFTpFt6hpttKghs9D0o2lRmWVU+fXUZBOu2Qb2bgF6OxHTOonM9tuNe
         htfDdmsJ/JjP6Z6s2P19ouki/LTjEebTkAo5owith9PFqhlTuHT0MryGVabihoKZYLZd
         9qqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780905765; x=1781510565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bLq1D7uP5MxHvai6FqrEhNmJ5qKAoR2b/ce+Jxe1kds=;
        b=Ch9+4Ki5zMOM54EHp/8eY9wqrEHJY8FL8nOXnRtrNYG4mS07vMou2deiVPQom+P0gu
         ZviX5uPQfD77zVR9ZnOa4mSu+hkhG9KCyTKrUrAsanShhX/y3wrDSENh/D7skLOdj/3C
         jM/y1OjvzcoxXmllBAhGKYOfJ4lxTQmesQ2TiV+7UBLneOj4h8ThahIb10sxp3+oq5MX
         L4S27sOb10xehJCa6lM+ZjyKENlMtLFWsi5y91sQfiakdZkNBt6Po1ahJZD09c2LWtZW
         3eAru4rddDo4Pkua4f7Q+naP/cp+UPJd4OaWJf8KsTYJk2wtdmFXbz6GgnsSLUhhClxR
         rm7w==
X-Forwarded-Encrypted: i=1; AFNElJ+MuO9OQkTGhlkT2Mrp4563H4366977zpdB+VWSAfnQ5qVear0p6PfezhFaI+JIJHiq8opzAA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxjw6V470IXplZ/xYiI2DRBmzdZERnLMeoMrdqY9GM/dkYlVcXF
	53GoysxACyGQhLxlr7Ij4ev/pXi+y3dUtM1BbHKs06Y000hP86Msmc3dPIHRkbyB6mj1EhNnqjB
	Fu1+VI/5RH8EM1sWh7AbiTF36zzJB54I=
X-Gm-Gg: Acq92OFjyY7OOe8qtsIPdLdrm9uSQxnp6Z32VGYhMfTNeUlQTOCKyV/djPJ25/j/TUz
	+LSkyt8fLJ6JIZqKJjxtZVuobBq8YRhs7Cqkg2SfJJyG0ih6rEPZKyGwQWfQgbdINcazjZ/EO2o
	1msRYT3odbKvPu4JRfN+TafK5VEDmRf+QKI1+NM9adqD8+PPg34OiXZWwIIB1AUY0k+W4c6iqst
	a49//CsNwEeFLJVAE2u/hsZQdskZRB7d/1HHnY15RVk+ux8ocHmwHuj4LKb9kxdszkNElmtaYxk
	STwGEFLcV4q00/UTfQ==
X-Received: by 2002:a17:906:8a46:b0:bec:4b96:5fb9 with SMTP id
 a640c23a62f3a-bf3701806dcmr422529166b.3.1780905765057; Mon, 08 Jun 2026
 01:02:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260604135255.62682-1-midgy971@gmail.com> <3d99569e-9c3a-49d1-93fb-1335382523e9@rock-chips.com>
 <CA+GS1Y1s78PwN63X2YJoS8VEGp7CpTERo_K65yKs00U4VRAw4Q@mail.gmail.com> <e5058919-9485-4de5-8eea-331ebfc2987c@rock-chips.com>
In-Reply-To: <e5058919-9485-4de5-8eea-331ebfc2987c@rock-chips.com>
From: Midgy Balon <midgy971@gmail.com>
Date: Mon, 8 Jun 2026 10:05:33 +0200
X-Gm-Features: AVVi8Cc-kS2uobepJQqeen5fwApM6uunQz9mBN_BXk5X1LlYp7Vi43yabrw2ZY0
Message-ID: <CA+GS1Y3ysdWZ3qCq3ip_Pbw+v4LxHZd95aBo=jwB+orYaMBBNw@mail.gmail.com>
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

Thanks -- this is exactly what I needed.

- v2/DTE: will do. I'll keep building on Simon's per-device-ops series -- w=
ith
  that in place the NPU MMU can use the 32-bit-DTE ops (the per-ops GFP_DMA=
32
  that's already in mainline) without the global rk_ops conflict. I'll
keep it as
  a stated dependency of the v4 cover letter.

- vdd_npu:  I'll switch the RK3568 NPU
  power domain to need_regulator + domain-supply =3D <&vdd_npu> and drop th=
e
  regulator-always-on workaround. I suspect that's also the right fix for t=
he
  power-off/on de-idle issue I described -- the always-on was really
just papering
  over the domain not being modelled with a regulator. I'll confirm on
the board.

- AUTO_GATING: thanks for the commit references -- I'll keep the bit-31
  read-modify-write form with your Suggested-by and write the comment
from those.
  For the record: on v7.1-rc6 the NPU MMU also completes translations
on the reset
  value (I couldn't reproduce a page-walk stall without the write), so I'll=
 note
  in the commit that it matches the vendor clock-gating handling rather tha=
n
  fixing a failure I can reproduce here -- happy to drop it if the iommu
  maintainers would prefer.

- PVTPLL/NoC: I'll follow up with Finley. First I'll check whether the
  need_regulator change resolves the NoC re-power de-idle on its own;
if it still
  I'll bring him the details (the genpd power-on de-idle ack and the
  BUS_IDLE_ST state).

I'll send a v4 with these. Thanks again for the quick, detailed answers.

Kind regards,
Midgy

Le lun. 8 juin 2026 =C3=A0 03:40, Chaoyi Chen <chaoyi.chen@rock-chips.com> =
a =C3=A9crit :
>
> Hi Midgy,
>
> On 6/8/2026 5:03 AM, Midgy Balon wrote:
> > Hi Chaoyi,
> >
> > Thanks a lot for looking at this -- input from Rockchip is exactly what=
 this
> > series needs.
> >
> >> Hmmm. If I understand correctly, the NPU IOMMU should be v2 rather tha=
n v1,
> >> implying it should support 40-bit PAs. Nevertheless, please note that =
the
> >> upper limit for DTE is 32 bits.
> >
> > Understood, and that 32-bit-DTE note is the crux of the trouble I had, =
so let
> > me lay out what I see and ask how you'd prefer to solve it.
> >
> > The mainline node is already v2 (rockchip,rk3568-iommu in rk356x-base.d=
tsi).
> > The problem on this 8 GiB board: with the v2 ops the page-table allocat=
ions
> > (gfp_flags =3D=3D 0) can land above 4 GiB, so the DTE ends up > 32 bits=
 and the
> > NPU's first translation faults with DMA_READ_ERROR. To work around that=
 I had
> > switched the NPU MMU to the v1 compatible (rockchip,iommu), whose ops s=
et
> > GFP_DMA32 and keep the DTE sub-4 GiB. That works in isolation, but beca=
use the
> > driver keeps a single global rk_ops, a v1 NPU MMU then trips
> > WARN_ON(rk_ops !=3D ops) against the SoC's v2 instances (VOP/VDEC), whi=
ch is why
> > I based the series on Simon's per-device-ops work.
> >
> > So my question: with per-device ops in place, what's the intended way t=
o keep
> > the NPU MMU on v2 *and* cap its DTE at 32 bits on boards with >4 GiB of=
 RAM?
> > A v2 ops variant carrying GFP_DMA32 for this device, or is there a regi=
ster/
> > config bit that constrains the DTE address? I'd rather follow the Rockc=
hip
> > intent here than carry the v1 workaround. (Simon, cc'd -- this is right=
 next to
> > your per-device-ops series.)
> >
>
> If Simon's method works, please use it :)
>
> >> Can these operations not be completed via the pmdomain driver?
> >> If some operations are controlled by TF-A, are you using open source T=
F-A?
> >
> > Most of it is in pmdomain already. Power-on and NoC de-idle are done by=
 the
> > RK3568 NPU power domain (genpd) at power-on -- the driver no longer pok=
es the
> > PMU directly. Two things remain outside it:
> >
> >  - vdd_npu: I mark it regulator-always-on in DT rather than wiring it a=
s the
> >    domain's domain-supply, because as a domain-supply it created a devi=
ce-link
> >    to the I2C PMIC (rk809) and genpd's power-off QoS-save path then hun=
g
> >    reading the NPU QoS registers behind the (gated) NoC. If there's a c=
lean way
> >    to let genpd own vdd_npu without that I2C ordering deadlock I'd much=
 prefer
> >    that -- pointers welcome.
> >
>
> Please refer to the patch below regarding the RK3588 NPU pmdomain.
> In short, you need to set a "need_regulator" for the RK3568 NPU pmdomain.
>
> https://lore.kernel.org/all/20251216055247.13150-1-rmxpzlb@gmail.com/
>
> >  - the NPU compute clock (PVTPLL): set from the driver via SCMI, and on=
ly
> >    needed for actual compute, not for bring-up.
> >
> > One more pmdomain observation from testing, possibly relevant to how th=
e NPU
> > domain should be modelled: the domain's power-off/on cycle doesn't reli=
ably
> > re-de-idle the NoC. If the NPU is probed after genpd has already powere=
d the
> > (unused) domain off, the power-on de-idle fails ("failed to set idle on=
 domain
> > 'npu'") and the NPU IOMMU then takes an external abort on its first MMI=
O access.
> > Probing the NPU before the unused-domain power-off, or marking the doma=
in
> > always-on, both avoid it. Is the NoC de-idle expected to work on a genp=
d
> > re-power here, or should this domain effectively stay on?
> >
>
> Not quite sure what's going on with PVTPLL and NOC.
> Maybe @Finley knows about this?
>
> > On TF-A: yes -- bl31 is built from upstream arm-trusted-firmware
> > (github.com/ARM-software/arm-trusted-firmware, RK3568 platform), provid=
ing PSCI
> > and the SCMI clock service. The only closed blob in the boot chain is R=
ockchip's
> > DDR init (rkbin), which is the standard situation for mainline RK356x.
>
> --
> Best,
> Chaoyi
