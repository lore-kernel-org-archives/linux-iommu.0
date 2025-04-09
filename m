Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7539826A0C1
	for <iommu@lists.linux.dev>; Wed,  9 Apr 2025 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744214194; cv=none; b=AAEBZhyWHUg+eJeJhSfdCkX8gGbKv3Uqy3QyGGMYq4wP799T+eg3TjjbuGrG0InKD9jXd5/Qq6gW9/rSwq6p4QMMXiFrtESxK/KR1t7vMT3FATSXbJXvBTomn2xfQ5tQjfz4BSAfxOvckQmOj2rgmEonnY8xDpqpip0+Xem3OkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744214194; c=relaxed/simple;
	bh=hob3GHAx1ipfX0P23W8hQp6pUWXUFZ926AVVxlqLlk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OoguQ7pdbMs0S7nZt/S6rqDZpOSnIkV5k7XIp/f2/R9SLXWXV3EngyNmCrVohPspuX34l1cXeQEROXBXx6T2u74WxWxewW2aBQo+52JypbpQk4ZaOUXkHXT/hg5eLZPpHISGIkrCn9rPN2/ACxOgpumCivySc+UCMZSClrxynq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hTuWFyUV; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hTuWFyUV"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5240764f7c1so2844097e0c.2
        for <iommu@lists.linux.dev>; Wed, 09 Apr 2025 08:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744214190; x=1744818990; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8AOUBaKz4k65EfvFtHnS9r16WBFkIa0uC8s/4pmp31M=;
        b=hTuWFyUVy4WhXo7oja5Qu7XJJNgWoRBRSFxshHEl7rBRx85fYw1YtCpTv4OPUH/cCp
         hD9gpepH30kZmP+px5YfX1gCpXQ/wGrhnF3/K8uVm4puE2SYMSBbcB6ZTf6ORliJs64C
         MIwq8WBh/p8URwifjmM+++O7aA7MR0SIgcxL+3AiE/Ee11Z5Yh8nQmwwbL4gWirBG6w3
         Ke6q1A+o4Tre+GMtvNQmkVDkRbjgONrnmHLESEAxiodxFCDsSkoRHJNhWujId6eRqs0n
         JpCxue+wl1wBkfDxme4xMewd/hP5ZbOcJ985Q8+GXQaFrS3oi2BT5N7dz63ypVgplBRF
         Cmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744214190; x=1744818990;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8AOUBaKz4k65EfvFtHnS9r16WBFkIa0uC8s/4pmp31M=;
        b=Pcm1bFYfUw+c13wOvxUpCdsvq7Piiq45OwxBwwC/AXtE1tEax54CwKvt8lzGu1CoC7
         2mPPxhpvuo6+F65PVhQPZrZDWE4d43h2IrS/U69xxlGNXGMuXlAa1I4szrgdgteZTQu5
         3tygGh6yl90Jh6yH592gyvGjkJven7mSJ2W3X4VI8nx7xGq+qjWvGgM56cGKqOsVgMKr
         8FD53Aq3lvp3bwy50V+pm/eYZkJidCTQze+cV9nP3UHwRwESPXHvXQceHtmWtZHZf0Ln
         cqo/pP2IhVqajtA1spJw21qrp1Y9aagwpwCEiPcUhedTewZKoFvJkPXwgHNGKbZiS4Ht
         SvaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs8joksSSe1zRK2Ohd9v+yAU8wESu/++Ii5eTKbKy6O+qC7l/q+Vaza7Z/WUYzxMFcRsFYMw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrpDpvBWj/3fxfcehRB1Nw9h5cL/ifhR+qVxtQX/ScCSrBiAl3
	1mM8Mv27RdHKXrAulg1gJP8bqd25gnQPNisX0k76AVZgDLLGZNCRFtZtujDBsJA4yCBhjISiHG1
	XX+HLVnWxTRZ0CQtAR8fSSGpLINdWFbXt7jB9Pg==
X-Gm-Gg: ASbGnctK+BScV1stoQV9UlHo1k2OTlu0B4VvKn17FIxNUC/LmkFy/FNHdHrNutfEe4q
	fRIxiw6n2ti6AEHDH+rBjxG6APfQvoYULm41sNNtBTvabj44jQyeodrlghwH8mZ0PSIsMV1rsrh
	f1xkUvYA5YJLM6ERyYT4Kuv9KLUTtbnUN5tJcBqCqwp0AL9pzVxvFkqWOSmvX90nGgmw==
X-Google-Smtp-Source: AGHT+IHAYOkRnjj4GyTCCh1iY/ZOItnunEtUpgqT8hpMTBxn0on/ShchAm+CXwhiK3vw5FX6fk0YxzKhFmWiXa4EPd0=
X-Received: by 2002:a05:6122:3291:b0:520:3e1c:500f with SMTP id
 71dfb90a1353d-527a923823fmr2577969e0c.8.1744214190187; Wed, 09 Apr 2025
 08:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+G9fYt0F_vR-zOV4P8m4HTv6AecT-eEnrL+t5wgAaKPodi0mQ@mail.gmail.com>
 <6e0ef5cc-b692-4d39-bec4-a75c1af3f0aa@arm.com>
In-Reply-To: <6e0ef5cc-b692-4d39-bec4-a75c1af3f0aa@arm.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 9 Apr 2025 21:26:18 +0530
X-Gm-Features: ATxdqUGUsxvoW2AC8LyCA3f5WgQxLUMC2Q7RV8pjSCJR4XLdNVjwMGpmUyBY9Fo
Message-ID: <CA+G9fYs_nUN2x8fFJ0cfudHWbCOLSJK=OhEK0Efd1ifcjq_LRg@mail.gmail.com>
Subject: Re: arm64: juno-r2: SSD detect failed on mainline and next
To: Robin Murphy <robin.murphy@arm.com>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, iommu@lists.linux.dev, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Apr 2025 at 21:04, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 31/03/2025 5:03 am, Naresh Kamboju wrote:
> > Regressions on arm64 Juno-r2 devices detect SSD tests failed on the
> > Linux next and Linux mainline.
> >
> > First seen on the v6.14-7245-g5c2a430e8599
> >   Good: v6.14
> >   Bad: v6.14-7422-gacb4f33713b9
>
> Sorry, I can't seem to reproduce this on my end, both today's mainline
> and acb4f33713b9 with my config, and even acb4f33713b9 with the linked
> LKFT config, all work OK on my Juno r2 (using a SATA SSD and PCIe
> networking). The only thing which stands out in your log is that PCI
> seems to give up probing and assigning resources beyond the switch
> downstream ports (so SATA and ethernet are never discovered), whereas on
> mine it does[2]. However that all happens before the first IOMMU
> instance probes (which conveniently is the PCIe one), so it's hard to
> imagine how that could have an effect anyway...
>
> The only obvious difference is that I'm using EDK2 rather than U-Boot,
> so that's done all the PCIe configuration once already, but it doesn't
> seem like that's significant - looking back at a random older log[1],
> the on-board endpoints were still being picked up right after
> reconfiguring the switch, well before the IOMMU comes into the picture.
>

Since it is a still issue on mainline and next,

Bisected and reverted patch ^ causing kernel warnings at boot time
but finding the SSD drive,

  [bcb81ac6ae3c2ef95b44e7b54c3c9522364a245c]
  iommu: Get DT/ACPI parsing into the proper probe path

pcieport 0000:00:00.0: late IOMMU probe at driver bind, something fishy here!
WARNING: at drivers/iommu/iommu.c:559 __iommu_probe_device

I see boot warnings [1]
I am happy to test debug patches if you have any.

[1] https://lkft.validation.linaro.org/scheduler/job/8212667#L1291

- Naresh

> Thanks,
> Robin.
>
>
> [1] https://lkft.validation.linaro.org/scheduler/job/8143082#L1283
> [2]:
>
> [    1.741362] pci-host-generic 40000000.pcie: host bridge
> /pcie@40000000 ranges:
> [    1.748682] pci-host-generic 40000000.pcie:       IO
> 0x005f800000..0x005fffffff -> 0x0000000000
> [    1.757465] pci-host-generic 40000000.pcie:      MEM
> 0x0050000000..0x0057ffffff -> 0x0050000000
> [    1.766224] pci-host-generic 40000000.pcie:      MEM
> 0x4000000000..0x40ffffffff -> 0x4000000000
> [    1.775019] pci-host-generic 40000000.pcie:   IB MEM
> 0x0080000000..0x00ffffffff -> 0x0080000000
> [    1.783781] pci-host-generic 40000000.pcie:   IB MEM
> 0x0800000000..0x09ffffffff -> 0x0800000000
> [    1.792615] pci-host-generic 40000000.pcie: ECAM at [mem
> 0x40000000-0x4fffffff] for [bus 00-ff]
> [    1.801559] pci-host-generic 40000000.pcie: PCI host bridge to bus
> 0000:00
> [    1.808485] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    1.814022] pci_bus 0000:00: root bus resource [io  0x0000-0x7fffff]
> [    1.820408] pci_bus 0000:00: root bus resource [mem
> 0x50000000-0x57ffffff]
> [    1.827314] pci_bus 0000:00: root bus resource [mem
> 0x4000000000-0x40ffffffff pref]
> [    1.835050] pci 0000:00:00.0: [1556:1100] type 01 class 0x060400 PCIe
> Root Port
> [    1.842444] pci 0000:00:00.0: BAR 0 [mem 0x4000000000-0x4000003fff
> 64bit pref]
> [    1.849717] pci 0000:00:00.0: PCI bridge to [bus 01-08]
> [    1.854990] pci 0000:00:00.0:   bridge window [io  0x0000-0x1fff]
> [    1.861125] pci 0000:00:00.0:   bridge window [mem 0x50000000-0x501fffff]
> [    1.868099] pci 0000:00:00.0: supports D1 D2
> [    1.872393] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    1.881014] pci 0000:01:00.0: [111d:8090] type 01 class 0x060400 PCIe
> Switch Upstream Port
> [    1.889407] pci 0000:01:00.0: PCI bridge to [bus 02-08]
> [    1.894675] pci 0000:01:00.0:   bridge window [io  0x0000-0x1fff]
> [    1.900812] pci 0000:01:00.0:   bridge window [mem 0x50000000-0x501fffff]
> [    1.907690] pci 0000:01:00.0: enabling Extended Tags
> [    1.912876] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
> [    1.924459] pci 0000:02:01.0: [111d:8090] type 01 class 0x060400 PCIe
> Switch Downstream Port
> [    1.933037] pci 0000:02:01.0: PCI bridge to [bus 03]
> [    1.938045] pci 0000:02:01.0:   bridge window [io  0x1000-0x1fff]
> [    1.944179] pci 0000:02:01.0:   bridge window [mem 0x50100000-0x501fffff]
> [    1.951060] pci 0000:02:01.0: enabling Extended Tags
> [    1.956298] pci 0000:02:01.0: PME# supported from D0 D3hot D3cold
> [    1.963053] pci 0000:02:02.0: [111d:8090] type 01 class 0x060400 PCIe
> Switch Downstream Port
> [    1.971621] pci 0000:02:02.0: PCI bridge to [bus 04]
> [    1.976698] pci 0000:02:02.0: enabling Extended Tags
> [    1.981924] pci 0000:02:02.0: PME# supported from D0 D3hot D3cold
> [    1.988682] pci 0000:02:03.0: [111d:8090] type 01 class 0x060400 PCIe
> Switch Downstream Port
> [    1.997272] pci 0000:02:03.0: PCI bridge to [bus 05]
> [    2.002352] pci 0000:02:03.0: enabling Extended Tags
> [    2.007578] pci 0000:02:03.0: PME# supported from D0 D3hot D3cold
> [    2.014713] pci 0000:02:0c.0: [111d:8090] type 01 class 0x060400 PCIe
> Switch Downstream Port
> [    2.023303] pci 0000:02:0c.0: PCI bridge to [bus 06]
> [    2.028396] pci 0000:02:0c.0: enabling Extended Tags
> [    2.033643] pci 0000:02:0c.0: PME# supported from D0 D3hot D3cold
> [    2.040569] pci 0000:02:10.0: [111d:8090] type 01 class 0x060400 PCIe
> Switch Downstream Port
> [    2.049131] pci 0000:02:10.0: PCI bridge to [bus 07]
> [    2.054220] pci 0000:02:10.0: enabling Extended Tags
> [    2.059439] pci 0000:02:10.0: PME# supported from D0 D3hot D3cold
> [    2.066798] pci 0000:02:1f.0: [111d:8090] type 01 class 0x060400 PCIe
> Switch Downstream Port
> [    2.075368] pci 0000:02:1f.0: PCI bridge to [bus 08]
> [    2.080377] pci 0000:02:1f.0:   bridge window [io  0x0000-0x0fff]
> [    2.086507] pci 0000:02:1f.0:   bridge window [mem 0x50000000-0x500fffff]
> [    2.093397] pci 0000:02:1f.0: enabling Extended Tags
> [    2.098625] pci 0000:02:1f.0: PME# supported from D0 D3hot D3cold
> [    2.105519] pci 0000:03:00.0: [1095:3132] type 00 class 0x018000 PCIe
> Legacy Endpoint
> [    2.113532] pci 0000:03:00.0: BAR 0 [mem 0x50104000-0x5010407f 64bit]
> [    2.120020] pci 0000:03:00.0: BAR 2 [mem 0x50100000-0x50103fff 64bit]
> [    2.126520] pci 0000:03:00.0: BAR 4 [io  0x1000-0x107f]
> [    2.131794] pci 0000:03:00.0: ROM [mem 0xfff80000-0xffffffff pref]
> [    2.138189] pci 0000:03:00.0: supports D1 D2
> [    2.142965] pci 0000:03:00.0: disabling ASPM on pre-1.1 PCIe device.
> You can enable it with 'pcie_aspm=force'
> [    2.154011] pci 0000:08:00.0: [11ab:4380] type 00 class 0x020000 PCIe
> Legacy Endpoint
> [    2.162015] pci 0000:08:00.0: BAR 0 [mem 0x50000000-0x50003fff 64bit]
> [    2.168492] pci 0000:08:00.0: BAR 2 [io  0x0000-0x00ff]
> [    2.173941] pci 0000:08:00.0: supports D1 D2
> [    2.178260] pci 0000:08:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    2.185740] pci 0000:00:00.0: bridge window [mem
> 0x50000000-0x501fffff]: assigned
> [    2.193266] pci 0000:00:00.0: BAR 0 [mem 0x4000000000-0x4000003fff
> 64bit pref]: assigned
> [    2.201411] pci 0000:00:00.0: bridge window [io  0x1000-0x2fff]: assigned
> [    2.208235] pci 0000:01:00.0: bridge window [mem
> 0x50000000-0x501fffff]: assigned
> [    2.215754] pci 0000:01:00.0: bridge window [io  0x1000-0x2fff]: assigned
> [    2.222580] pci 0000:02:01.0: bridge window [mem
> 0x50000000-0x500fffff]: assigned
> [    2.230120] pci 0000:02:1f.0: bridge window [mem
> 0x50100000-0x501fffff]: assigned
> [    2.237648] pci 0000:02:01.0: bridge window [io  0x1000-0x1fff]: assigned
> [    2.244470] pci 0000:02:1f.0: bridge window [io  0x2000-0x2fff]: assigned
> [    2.251313] pci 0000:03:00.0: ROM [mem 0x50000000-0x5007ffff pref]:
> assigned
> [    2.258399] pci 0000:03:00.0: BAR 2 [mem 0x50080000-0x50083fff
> 64bit]: assigned
> [    2.265769] pci 0000:03:00.0: BAR 0 [mem 0x50084000-0x5008407f
> 64bit]: assigned
> [    2.273141] pci 0000:03:00.0: BAR 4 [io  0x1000-0x107f]: assigned
> [    2.279286] pci 0000:02:01.0: PCI bridge to [bus 03]
> [    2.284289] pci 0000:02:01.0:   bridge window [io  0x1000-0x1fff]
> [    2.290425] pci 0000:02:01.0:   bridge window [mem 0x50000000-0x500fffff]
> [    2.297275] pci 0000:02:02.0: PCI bridge to [bus 04]
> [    2.302302] pci 0000:02:03.0: PCI bridge to [bus 05]
> [    2.307327] pci 0000:02:0c.0: PCI bridge to [bus 06]
> [    2.312353] pci 0000:02:10.0: PCI bridge to [bus 07]
> [    2.317382] pci 0000:08:00.0: BAR 0 [mem 0x50100000-0x50103fff
> 64bit]: assigned
> [    2.324751] pci 0000:08:00.0: BAR 2 [io  0x2000-0x20ff]: assigned
> [    2.330881] pci 0000:02:1f.0: PCI bridge to [bus 08]
> [    2.335895] pci 0000:02:1f.0:   bridge window [io  0x2000-0x2fff]
> [    2.342030] pci 0000:02:1f.0:   bridge window [mem 0x50100000-0x501fffff]
> [    2.348874] pci 0000:01:00.0: PCI bridge to [bus 02-08]
> [    2.354129] pci 0000:01:00.0:   bridge window [io  0x1000-0x2fff]
> [    2.360270] pci 0000:01:00.0:   bridge window [mem 0x50000000-0x501fffff]
> [    2.367113] pci 0000:00:00.0: PCI bridge to [bus 01-08]
> [    2.372366] pci 0000:00:00.0:   bridge window [io  0x1000-0x2fff]
> [    2.378494] pci 0000:00:00.0:   bridge window [mem 0x50000000-0x501fffff]
> [    2.385325] pci_bus 0000:00: resource 4 [io  0x0000-0x7fffff]
> [    2.391101] pci_bus 0000:00: resource 5 [mem 0x50000000-0x57ffffff]
> [    2.397398] pci_bus 0000:00: resource 6 [mem
> 0x4000000000-0x40ffffffff pref]
> [    2.404478] pci_bus 0000:01: resource 0 [io  0x1000-0x2fff]
> [    2.410078] pci_bus 0000:01: resource 1 [mem 0x50000000-0x501fffff]
> [    2.416374] pci_bus 0000:02: resource 0 [io  0x1000-0x2fff]
> [    2.421980] pci_bus 0000:02: resource 1 [mem 0x50000000-0x501fffff]
> [    2.428277] pci_bus 0000:03: resource 0 [io  0x1000-0x1fff]
> [    2.433877] pci_bus 0000:03: resource 1 [mem 0x50000000-0x500fffff]
> [    2.440195] pci_bus 0000:08: resource 0 [io  0x2000-0x2fff]
> [    2.445799] pci_bus 0000:08: resource 1 [mem 0x50100000-0x501fffff]
> [    2.519972] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    2.532646] msm_serial: driver initialized
> [    2.537422] SuperH (H)SCI(F) driver initialized
> [    2.542220] STM32 USART driver initialized
> [    2.551250] arm-smmu 2b500000.iommu: probing hardware configuration...
> [    2.557832] arm-smmu 2b500000.iommu: SMMUv1 with:
> [    2.562564] arm-smmu 2b500000.iommu:         stage 2 translation
> [    2.568006] arm-smmu 2b500000.iommu:         coherent table walk
> [    2.573449] arm-smmu 2b500000.iommu:         stream matching with 32
> register groups
> [    2.580643] arm-smmu 2b500000.iommu:         4 context banks (4 stage-2 only)
> [    2.587205] arm-smmu 2b500000.iommu:         Supported page sizes: 0x60211000
> [    2.593778] arm-smmu 2b500000.iommu:         Stage-2: 40-bit IPA -> 40-bit PA
> [    2.600471] arm-smmu 2b500000.iommu:         preserved 0 boot mappings
> [    2.607710] pci 0000:00:00.0: Adding to iommu group 0
> [    2.613204] pci 0000:01:00.0: Adding to iommu group 0
> [    2.618588] pci 0000:02:01.0: Adding to iommu group 0
> [    2.623975] pci 0000:02:02.0: Adding to iommu group 0
> [    2.629373] pci 0000:02:03.0: Adding to iommu group 0
> [    2.634742] pci 0000:02:0c.0: Adding to iommu group 0
> [    2.640127] pci 0000:02:10.0: Adding to iommu group 0
> [    2.645531] pci 0000:02:1f.0: Adding to iommu group 0
> [    2.650952] pci 0000:03:00.0: Adding to iommu group 0
> [    2.656349] pci 0000:08:00.0: Adding to iommu group 0
>
>
> >
> > * Juno-r2,
> >   - detect-ssd
> >   - mkfs.ext4-ssd
> >
> > Regression Analysis:
> >   - New regression? yes
> >   - Reproducibility? Yes
> >
> > Test regression: arm64 Juno-r2 SSD detect failed
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Anders bisected this to,
> > # first bad commit:
> >    [bcb81ac6ae3c2ef95b44e7b54c3c9522364a245c]
> >    iommu: Get DT/ACPI parsing into the proper probe path
> >
> > ## Test log
> >    mkfs.ext4 /dev/disk/by-id/ata-SanDisk_SSD_PLUS_240GB_223004A01292
> >    mke2fs 1.47.2 (1-Jan-2025)
> >    The file /dev/disk/by-id/ata-SanDisk_SSD_PLUS_240GB_223004A01292
> > does not exist and no size was specified.
> >
> > ## Source
> > * Kernel version: 6.14.0
> > * Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > * Git sha: acb4f33713b9f6cadb6143f211714c343465411c
> > * Git describe: v6.14-7422-gacb4f33713b9
> > * Project details:
> > https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.14-7422-gacb4f33713b9/
> >
> > ## Test
> > * Test log: https://lkft.validation.linaro.org/scheduler/job/8188382#L1538
> > * Test history:
> > https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.14/testrun/27742015/suite/ltp-cve/test/cve-2017-2671/history/
> > * Test details:
> > https://lkft.validation.linaro.org/scheduler/job/8188382/definition
> > * Test link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2uwduIsT14Pz3XEoUQQIS6ndlQK/
> > * Kernel config:
> > https://storage.tuxsuite.com/public/linaro/lkft/builds/2uwduIsT14Pz3XEoUQQIS6ndlQK/config
> >
> >
> > --
> > Linaro LKFT
> > https://lkft.linaro.org
