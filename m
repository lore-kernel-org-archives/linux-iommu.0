Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEC93FB07E
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781098540; cv=pass; b=VtOafvbKAyA2UvMnnVWyD4yMRjuDkFVgyWaIi4uEMckSXVI1r5FtOHmwP6tvBoqkRgpntARsI9uqHYBNBGEpbOKuanCfEBDYlC37cB1niwebORbyaRhoXVyEHqWWywBrKRM9XqGKMeEXOcY1+lighwQrsvI9sn1UUsj9Oxk4g1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781098540; c=relaxed/simple;
	bh=IjellU6GdCTPU+dpw2ZpLQIFTTy78pz+4EJk9IWCewE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Udu6v7PS9kwVK5SIxhVvqWJhqqoQNh6uvMj/2XrBNhO6g187OYCNCG5ingHALyk6H0/vcIhzOGGPLXre6qyIXIrjR6MftVVBK9tf73Jc9mhb62aR4fPKNV+Z+v0Wag7m2UFQFgirBMYr5OAV8eCveOKAeF4QOUJzXP9zUGdi0nE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEcotziT; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEcotziT"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-687ed9aabb3so13366734a12.1
        for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 06:35:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781098532; cv=none;
        d=google.com; s=arc-20240605;
        b=hrdwmQ4Int9X1db9Y0OjM12Jy+ITZWf/82F6ClF6/tA4zbszOI+bRhk5ZOeto7DY7N
         Dto5hkEK6Col48frmS/6BUIfUWwCZ4YJMKYttV9yO0Nt1QIDssg9To4gODuqGq2++GR+
         QYiNYIhfWpXIHW0xOqEcz2wvzDLqm0QIetcvAZehf9mrXmIDKIEZ3q3V8yj/PE4i2Nej
         wG7xu8T/WKX4m/2OhQNOmJpc15GzxH1M3wbfXMvb7MEyoeJiT/bQbq4vhcxwn+KJVD9l
         +3fpf3QrE1cQ75w+oiUiVn5dXhFXFtZLPp5+vgfRRs0xRb6kWDSrwHJi7Evts6gf0Afo
         JSzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WboogWqcoT+OL/ZD2SYskMF+y3oh6ksVJtvN7OeY8rI=;
        fh=Zq184m+7zw/+/lKA/GYwU2EwoMQCP1bXg6LepR2CCeo=;
        b=OGlKffQb3lC1U87L5we32Ns0X70OXniaBvoaSp+wS84wxVfMX3l7TkxhDJsOJSdRpS
         ji1NV4kanxRWlKHGVCVTGLzN3iFu7Z0WyTLt3A1iElBE/0cA6Wi9CFx64+BgOgW9KFzV
         /1taO7yKJd+n3u5cVU4TiYFuLED6QctU9h+9O56BqPE6fKBYuXp1qV7tIp7b8OWWo9YP
         rp+suGb0gOwOvO7w94g7LHzq2V1zKJCr8QE9uw5Eml5tsjQRFmMXhoXdnMhGUqkew7dE
         3kc2f1SubaBd69U9HQ8LImURZFPztalSGCG3FOisDLih9xrjnE8S59x2Hgl9VbaO99FS
         PAIw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781098532; x=1781703332; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WboogWqcoT+OL/ZD2SYskMF+y3oh6ksVJtvN7OeY8rI=;
        b=AEcotziTQdASqc84Mn97VXAGcah9GTXIeVVsb/2h/d9iahFvuIfgW9FuTbuEGGWUoU
         Vzy2vVo8TdQHi00Xg1GC3nMTh1U71TecH9C2qDHxWFUS/ZfHe262PBDYw4BcPGIrg+YB
         Vz31GuQkPF2DgI0kZ2uaqIqN70MGYTvceJFiJdghxPA4oAs4yBvlVXJ+I3/wZz/RupZ/
         iyt4twbR7yc8p13ByOiH9s/hpzKHxrtoFEb/zzj53CVRSGgVIbChwVqLDNErwvrQpqkG
         FbKNtLczRnMJtGxJCGnQ5Z04vw57TJmgea/3jp3NpRTp5bnjG6pD6Pdbm/vCEm0JJpyR
         eqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781098532; x=1781703332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WboogWqcoT+OL/ZD2SYskMF+y3oh6ksVJtvN7OeY8rI=;
        b=qwY4AO7PYs0ox64HJtAFxZCcXuad7Z8HiMIvE4nNmDAQwUmhW1L1XVuVnBZKyLTuMb
         yShQyqDA4S+Nx4VfHZ1LSf2r8ZkfQeSWbnU8vNAHuLsQY3evu3E0rcKzDIlYRoZlIaPw
         Y4fPlMKxUMe6OrtZqi3Yn9e/IV5p5GZv8QVDt6TluaDxQTKf6BmIB+0M1bhK3e3sa5KD
         +PVa4PORjIwb0OYE9Mry2u68rrULT78JfP2ybSEua0aou0j69K2OOUQ+y/L3Qh+wnIgJ
         s81NxWgvq9cJwNYzgOwjPPnMIZEdp+oVXJYyY+UEdvhLn1GvXEl/e46F7iMPUlZGMNBY
         8QGg==
X-Forwarded-Encrypted: i=1; AFNElJ/2xCcHUXqJdTkrdSJzkdV3I3B8Ka5fbWsresvEP0FczJX6pq2Tfck0vxFJxkMKORpSE3ussA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2UwdbUfRbHe2IcKOyHa3Ad90eHQGWZMIRqW93jIkLNllPZf9m
	oKv5WEoeoSLrRKRCeHjj6GPXTCl4UVu8iWlGFKQ2RCZbc48EOQWCsPen2Tfz6kqEquCbB4KuGMI
	F+zWgQ66Kyln680pCQEb0F5BhFx6jFmk=
X-Gm-Gg: Acq92OF34ZdsZURuF4a/kkHrrFs+BWu69laca4etG2cvhFFwuvn8TM4h+jr566sbf5Z
	PL2ajfOOQS3WU6KPZHa707IsyuYHMovM+UMXcJoy+Ov1m+5wQ1mHrNYeqU1lj9Gr/XWXLkORVqP
	Xq3e1Tknnl4QXFIbwqgUjVficw9xt+sIuZ03S+oWJZSpJfEQj8EfS4cQC0w2JBobkry7VDuA5hR
	rvUy3DQqO6jAY/+3/YkeyEkAH8e/CEr2kvcDDqI1v0qIEMsf6nElxJ4Q5Kzn+KxDGIopX2xNZSn
	1QfIA6iP/uz6II3ytg==
X-Received: by 2002:a17:907:948e:b0:bec:5ebd:e169 with SMTP id
 a640c23a62f3a-bf37263c586mr1377264466b.22.1781098531867; Wed, 10 Jun 2026
 06:35:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260604135255.62682-1-midgy971@gmail.com> <3d99569e-9c3a-49d1-93fb-1335382523e9@rock-chips.com>
 <CA+GS1Y1s78PwN63X2YJoS8VEGp7CpTERo_K65yKs00U4VRAw4Q@mail.gmail.com>
 <e5058919-9485-4de5-8eea-331ebfc2987c@rock-chips.com> <CA+GS1Y3ysdWZ3qCq3ip_Pbw+v4LxHZd95aBo=jwB+orYaMBBNw@mail.gmail.com>
 <CA+GS1Y0kAM_XGLQuKPTphif2HcQg18ZXhd8RHHr2xPOEMCDvXA@mail.gmail.com>
 <bcedaff0-abf8-4585-a0ea-057062cd0411@rock-chips.com> <CA+GS1Y2-hRqpGgsknh+oOX+-uZ3DZtdekdP9viTP6a40zhhUhg@mail.gmail.com>
 <b05f7154-e85f-4207-80ae-f080282ba780@rock-chips.com> <DJ5A9XL183RZ.20J3ASQ3EWUZ6@cknow-tech.com>
In-Reply-To: <DJ5A9XL183RZ.20J3ASQ3EWUZ6@cknow-tech.com>
From: Midgy Balon <midgy971@gmail.com>
Date: Wed, 10 Jun 2026 15:38:24 +0200
X-Gm-Features: AVVi8Cf8gCpLbNssJy_FW_CB2ltoJNgKiOGOa6bXMaOGRFQOxsnQSP0W6Cmk0Xc
Message-ID: <CA+GS1Y1xAq-9eMyMmoVE6NG9KLG7XRxgPoSr5RkW=6fT5D820g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/9] accel: rocket: Add RK3568 NPU support
To: Diederik de Haas <diederik@cknow-tech.com>
Cc: Chaoyi Chen <chaoyi.chen@rock-chips.com>, tomeu@tomeuvizoso.net, ogabbay@kernel.org, 
	heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Simon Xue <xxm@rock-chips.com>, Finley Xiao <finley.xiao@rock-chips.com>, 
	Jonas Karlman <jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Chaoyi & Diederik,

I compared the RK3568 and RK3588 NPU power-domain + DTS as you
suggested, and it lines up
exactly with what you described.

The difference is the `need_regulator` capability. RK3588's NPU domain is
`DOMAIN_RK3588("npu", =E2=80=A6, false, true)` =E2=80=94 the trailing `true=
` is
`regulator`/`need_regulator`.
The mainline RK3568 macro `DOMAIN_RK3568(name, pwr, req, wakeup)` has
no regulator parameter at
all, so `RK3568_PD_NPU` can't be marked need_regulator. My v4 adds
that: a regulator-capable
RK3568 NPU domain (need_regulator =3D true) plus `domain-supply =3D
<&vdd_npu>` on the NPU node =E2=80=94
i.e. the same shape as RK3588.

And the fix you referenced (Frank Zhang's "pmdomain: rockchip: Fix init gen=
pd as
GENPD_STATE_ON before regulator ready", plus "quiet regulator error on
-EPROBE_DEFER") is
already in my base (v7.1-rc6), so the `if (need_regulator)
rockchip_pd_power(pd, false)`
default-off path is in effect. That's what resolves the actual problem
for me: with rocket
built as a module (the normal config), need_regulator on the NPU
domain, and those pmdomain
patches in place, the board boots cleanly and NPU jobs run with no RCU
stall / no deadlock. My
earlier hang was an artifact of a self-contained rocket=3Dy image
probing in the initcalls before
the I2C regulator core was up =E2=80=94 as a module it loads ~6.8 s in, wel=
l
after, so it's gone.

I also went back and checked the `fw_devlink=3Dpermissive` question
myself =E2=80=94 and good news, it
turns out it is NOT needed. I rebooted the exact same kernel with
permissive removed from the
cmdline (strict fw_devlink, the default), and the board boots cleanly,
the NPU probes
(`rocket fde40000.npu: Rockchip NPU core 0 version: 0`), and NPU jobs
submit and run five times
in a row with no deadlock and no RCU stall. So strict fw_devlink
resolves the NPU/PMIC ordering
fine via deferred probe.

The one remaining thing is cosmetic: at power-domain-controller probe
(~2.94 s) I still get,
in BOTH modes (with or without permissive):

  rockchip-pm-domain =E2=80=A6: Failed to create device link (0x180) with
supplier 0-0020 =E2=80=A6power-domain@6

i.e. genpd can't form the link to the rk809 (the I2C PMIC supplying
vdd_npu) because the PMIC
isn't registered yet at that point. It's non-fatal =E2=80=94 the domain
defaults off (Frank's patch),
the rail comes up via the regulator core, the NPU probes a few seconds
later, and all jobs run.

One question: on RK3588 with need_regulator, do you also see that
"Failed to create device
link =E2=80=A6 supplier <pmic>" line at pmdomain probe, or does it order
cleanly? If RK3588 is clean,
is there a DTS detail (e.g. the regulator's bus/probe order) I should
mirror on RK3568 to make
the link form in time =E2=80=94 or is this line just expected/harmless and
best left as-is?

@Diederik =E2=80=94 thanks; the DCDC_REG2 change and Jonas's USB-suspend
series look like generally
useful RK356x robustness fixes, though for this specific NPU
device-link the need_regulator +
Frank's pmdomain patches seem to be the relevant piece. I'll keep them
in mind for suspend.

The convolution-output / compute-completion issue is still separate
and open (@Finley =E2=80=94 that's
the PVTPLL/NoC one); the power-domain side is in good shape for v4.

Thanks y'all for your help :)

Kind regards,
Midgy

Le mer. 10 juin 2026 =C3=A0 12:05, Diederik de Haas
<diederik@cknow-tech.com> a =C3=A9crit :
>
> Hi,
>
> On Wed Jun 10, 2026 at 3:14 AM CEST, Chaoyi Chen wrote:
> > Hi Midgy,
> >
> > On 6/9/2026 7:11 PM, Midgy Balon wrote:
> >> Hello Chaoyi,
> >>
> >> You were right - building rocket as a module fixes it. Thanks for the =
pointer.
> >>
> >> I rebuilt with CONFIG_DRM_ACCEL_ROCKET=3Dm (everything else the same:
> >> need_regulator on
> >> the RK3568 NPU power domain via a DOMAIN_M_R variant, domain-supply =
=3D
> >> <&vdd_npu>, and the
> >> regulator-always-on workaround dropped). The board now boots cleanly
> >> and, more importantly,
> >> an NPU job submit no longer hangs: I ran the test workload five times
> >> with no RCU stall and
> >> no freeze.
> >>
> >> So with rocket=3Dm the need_regulator approach works on RK3568, and I'=
ll
> >> keep it for v4
> >> (domain-supply + need_regulator, instead of marking vdd_npu
> >> always-on). rocket=3Dm is the
> >> normal configuration anyway; my earlier hang came from building it =3D=
y
> >> in a self-contained
> >> image, so it probed in the initcalls (around 2 s) and the genpd ->
> >> I2C-PMIC regulator
> >> transition ran before the system was ready. As a module it loads from
> >> udev much later
> >> (~6.8 s here), after the I2C controller and regulator core are fully u=
p.
> >>
> >> On your question of when the device-link error is printed - it is at
> >> power-domain
> >> controller probe, not at the rocket probe:
> >>
> >>   [    2.700618] vdd_npu: Bringing 500000uV into 825000-825000uV
> >>   [    2.749637] rockchip-pm-domain fdd90000.power-management:power-co=
ntroller:
> >>                  Failed to create device link (0x180) with supplier 0-=
0020 for
> >>                  /power-management@fdd90000/power-controller/power-dom=
ain@6
> >>   [    2.945955] platform fde40000.npu: Adding to iommu group 3
> >>   ...
> >>   [    6.840374] rocket: loading out-of-tree module taints kernel.
> >>   [    6.877647] [drm] Initialized rocket 0.0.0 for rknn on minor 0
> >>   [    6.879950] rocket fde40000.npu: Rockchip NPU core 0 version: 0
> >>
> >> So the device-link to the rk809 PMIC (0-0020) fails to form at ~2.75
> >> s, well before rocket
> >> loads at ~6.8 s. It is non-fatal here - the vdd_npu rail is brought up
> >> by the regulator core
> >> and all jobs run - and there is no "failed to get ack on domain npu"
> >> NoC warning this boot
> >> (the always-on kernel had one). The complete boot log is attached.
> >>
> >> Two notes / one question:
> >> - This boot used fw_devlink=3Dpermissive on the command line. Is the
> >> "Failed to create device
> >>   link ... supplier 0-0020" at pmdomain probe expected/benign, or is
> >> there a clean way to make
> >>   it order correctly (so it also works without permissive, and a =3Dy
> >> build wouldn't deadlock in
> >>   the initcalls)?
> >
> > We encountered the same issue on the RK3588 NPU before. And it was
> > resolved with the following patch at that time.
> >
> > https://lore.kernel.org/all/20251216055247.13150-1-rmxpzlb@gmail.com/
> >
> > Please compare the differences in NPU pmdomain and DTS configuration
> > between the RK3568 and RK3588.
>
> About a month ago on #linux-rockchip we were discussing PM 'stuff':
> https://libera.catirclogs.org/linux-rockchip/2026-05-15#39939137;
> which references this paste
> https://paste.sr.ht/~diederik/89d9f84e22474e837b55286d213b67f03859ce2e
> I've since removed the DCDC_REG2 for PineTab2 and the 'fix' should likely
> be extended to cover all RK3566/RK3568 devices though.
>
> It's what I made at the time hoping to fix a suspend/resume issue when
> trying upstream TF-A. It didn't fix the issue at the time, but may still
> be useful/needed and I think it's what Chaoyi hinted at.
>
> Just yesterday, Jonas posted this patch which may be useful/needed too:
> https://lore.kernel.org/linux-rockchip/20260609154124.445182-1-jonas@kwib=
oo.se/
>
> HTH,
>   Diederik
>
> >> - (The convolution output is still uniform zero-point / the job times
> >> out - that is the
> >>   separate NPU compute-completion issue, unrelated to the power-domain
> >> work. Finley, that is
> >>   the one I flagged earlier re PVTPLL/NoC.)
> >>
> >> Kind regards,
> >> Midgy
> >>
>
