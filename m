Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F113211477
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315843; cv=none; b=qu0jxHoV0bIJmHdegZO2ap5meaKugwqATRU7f5Ddpj9Qorq/2LKLvQV1fhhUpObJXfY5JCqO8aNJQ59kryRGPfJRZW4aARz4A9UzMmDqnQNfhCGZNLrsVmiRYSH4GeRpOZ5rq5hcZkMxlg6VBvqPTbevXw/VvIDr3aT45Vm8bMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315843; c=relaxed/simple;
	bh=pPyUzTUQGRfTQOHKidMaOzFFq6KMWWpkAT+NqF0KJBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQBePGqgMqHY/2iw6mE+sI5fnqekgmv4qPw3V4YtCGqxEpXOeLwuE6v9YIoS2YP9E+cOGbwlAIvl3Yfb3pUyRvgM9HutaqBDco13Ju1eitFZPpAEHPLUS80lrGkcii4RYePMg1XWEd5cBwuzE4JjXIgV568buMoMd3y6IwK9lNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-523dc190f95so2841113e0c.1
        for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 09:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742315839; x=1742920639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwRBrAn95ue33W6DszvlK1HReXU3uB5HdQrOlS7LOnE=;
        b=Dsd3RU1AfrxQMnv0XZ7qKZ/8hLeCGbA/P4w4YXngYZpoN/jB3LY2YoPMXHtcQ/1T51
         2AKFWTBL4iSazsS25Stl7B4xVE83F+ru/OMPs0F7BSvkKgf2bVc0wLM3Rc+MhEqfy7pD
         3/K6uLRUm0xdH4iVGjvsqzol9VS09Tjso/ItHwJFzlujysVkO8L5Cxhd3biDpzGdEY+2
         VrcE4TevSd9aUGcIIlF7Ke6KsF50L+7Z5I8NrGg53hBMALOox820zPZWdZKz06DxfqCo
         MaFDUgsprJ+yJErOx7UhyKIq7Q5YAXcLULIpuDQliI5yFIA6XRDnC9LmDdf15PkFxp4w
         Ef8g==
X-Forwarded-Encrypted: i=1; AJvYcCW/lZ2DSXboNcFSgGAS07bwHBaVGH0tr2Y7umkjdZBwnt1rFnme9SUU8E7AYtTwaDHafUjqbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwiRVHEPz1TIL89ixCq21C4LrYGugzwoVM7K7dctoCZUfznDTUy
	w/AMSXDd4CptqDXiKJ8Ygreq9uHeAdS4yPMUhvnfC66liTvSJ/n48Owk6lYX
X-Gm-Gg: ASbGncv65MsFtOzp7pCxEWfzCYw2zgROW+cg8LfuD30UT94yikN5Ze8o6M+8sO9UXzw
	OH9jlJ+z0jbzMa6zsz+I3oIOc2T1PXijoFrmc5QHfLA3IgueF9nnl5ISgbNv7fOZFIV6AtBprqo
	tioQd2EemggjrbfGTbLRjWuVa+C0gp4gbXGA3e0PFeQIlicM63BSxcMQVeX5QD8c+rXu2jitiAC
	gWf+ww181FYi7iHUHfXbLLiOWsob6MGt2JsLq/OoOwcldvo6ijMj1NdKlg1J47oqHRABELsu+tx
	pGFeUtKcVZGUiN0PldI+BJzHej3WKK+uAVo30dIBfaNi7/z/g5tpeM6q2VCYQrLLFGeaVzUOuwA
	VmzVDi7KSYnQ=
X-Google-Smtp-Source: AGHT+IFbuCSgt52ZvlJNcYTXeNNTPxQCTsp+C8Xx7ocHvmodET1kBvfeu+UCGU68wh2jGSbwaETYUQ==
X-Received: by 2002:a05:6102:800b:b0:4c1:801e:deb2 with SMTP id ada2fe7eead31-4c4d902fe4bmr4660809137.7.1742315839298;
        Tue, 18 Mar 2025 09:37:19 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c374edd6d5sm1989734137.4.2025.03.18.09.37.18
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 09:37:18 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-523b7013dc8so2457196e0c.0
        for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 09:37:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUN3k7cGHw6aJhKTlUg9PoQAeckBq8yIfgJdZhGf028vtLeHHL2T5BG7VDIk4OlLnm1fU5NVA==@lists.linux.dev
X-Received: by 2002:a05:6122:3c8c:b0:520:5a87:66ed with SMTP id
 71dfb90a1353d-52480e7f34fmr3607589e0c.5.1742315838042; Tue, 18 Mar 2025
 09:37:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1740753261.git.robin.murphy@arm.com> <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
In-Reply-To: <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Mar 2025 17:37:06 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWPFnHTFeeWL2-BU8tKOL-E5K2ROOz=LLBLTJJLCK9NgA@mail.gmail.com>
X-Gm-Features: AQ5f1JoM657_qcXASxrgwKY3sd-GA64e6coLQEp-A0NEDn3ArAoI-Pzo7CTBLaA
Message-ID: <CAMuHMdWPFnHTFeeWL2-BU8tKOL-E5K2ROOz=LLBLTJJLCK9NgA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe path
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Stuart Yoder <stuyoder@gmail.com>, 
	Laurentiu Tudor <laurentiu.tudor@nxp.com>, Nipun Gupta <nipun.gupta@amd.com>, 
	Nikhil Agarwal <nikhil.agarwal@amd.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
	Charan Teja Kalla <quic_charante@quicinc.com>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Robin,

On Fri, 28 Feb 2025 at 16:51, Robin Murphy <robin.murphy@arm.com> wrote:
> In hindsight, there were some crucial subtleties overlooked when moving
> {of,acpi}_dma_configure() to driver probe time to allow waiting for
> IOMMU drivers with -EPROBE_DEFER, and these have become an
> ever-increasing source of problems. The IOMMU API has some fundamental
> assumptions that iommu_probe_device() is called for every device added
> to the system, in the order in which they are added. Calling it in a
> random order or not at all dependent on driver binding leads to
> malformed groups, a potential lack of isolation for devices with no
> driver, and all manner of unexpected concurrency and race conditions.
> We've attempted to mitigate the latter with point-fix bodges like
> iommu_probe_device_lock, but it's a losing battle and the time has come
> to bite the bullet and address the true source of the problem instead.
>
> The crux of the matter is that the firmware parsing actually serves two
> distinct purposes; one is identifying the IOMMU instance associated with
> a device so we can check its availability, the second is actually
> telling that instance about the relevant firmware-provided data for the
> device. However the latter also depends on the former, and at the time
> there was no good place to defer and retry that separately from the
> availability check we also wanted for client driver probe.
>
> Nowadays, though, we have a proper notion of multiple IOMMU instances in
> the core API itself, and each one gets a chance to probe its own devices
> upon registration, so we can finally make that work as intended for
> DT/IORT/VIOT platforms too. All we need is for iommu_probe_device() to
> be able to run the iommu_fwspec machinery currently buried deep in the
> wrong end of {of,acpi}_dma_configure(). Luckily it turns out to be
> surprisingly straightforward to bootstrap this transformation by pretty
> much just calling the same path twice. At client driver probe time,
> dev->driver is obviously set; conversely at device_add(), or a
> subsequent bus_iommu_probe(), any device waiting for an IOMMU really
> should *not* have a driver already, so we can use that as a condition to
> disambiguate the two cases, and avoid recursing back into the IOMMU core
> at the wrong times.
>
> Obviously this isn't the nicest thing, but for now it gives us a
> functional baseline to then unpick the layers in between without many
> more awkward cross-subsystem patches. There are some minor side-effects
> like dma_range_map potentially being created earlier, and some debug
> prints being repeated, but these aren't significantly detrimental. Let's
> make things work first, then deal with making them nice.
>
> With the basic flow finally in the right order again, the next step is
> probably turning the bus->dma_configure paths inside-out, since all we
> really need from bus code is its notion of which device and input ID(s)
> to parse the common firmware properties with...
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com> # pci-driver.c
> Acked-by: Rob Herring (Arm) <robh@kernel.org> # of/device.c
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Thanks for your patch, which is now commit bcb81ac6ae3c2ef9 ("iommu:
Get DT/ACPI parsing into the proper probe path") in iommu/next.

This patch triggers two issues on R-Car Gen3 platforms:

1. I am seeing a warning on Renesas Salvator-XS with R-Car M3N
(but not on the similar board with R-Car H3), and only for SATA[1].
Unfortunately commit 73d2f10957f517e5 ("iommu: Don't warn prematurely
about dodgy probes") does not help:

    ------------[ cut here ]------------
    sata_rcar ee300000.sata: late IOMMU probe at driver bind,
something fishy here!
    WARNING: CPU: 1 PID: 13 at drivers/iommu/iommu.c:571
__iommu_probe_device+0x208/0x38c
    Modules linked in:
    CPU: 1 UID: 0 PID: 13 Comm: kworker/u8:1 Not tainted
6.14.0-rc3-rcar3-00020-g73d2f10957f5-dirty #315
    Hardware name: Renesas Salvator-X 2nd version board based on r8a77965 (DT)
    Workqueue: events_unbound deferred_probe_work_func
    pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
    pc : __iommu_probe_device+0x208/0x38c
    lr : __iommu_probe_device+0x208/0x38c
    sp : ffffffc086da39a0
    x29: ffffffc086da39b0 x28: 0000000000000000 x27: 0000000000000000
    x26: 0000000000000001 x25: ffffffc080e0e0ae x24: ffffffc080e0e0bb
    x23: 0000000000000000 x22: ffffff800bd3d090 x21: ffffffc080acf680
    x20: ffffff8008e8f780 x19: ffffff800aca8810 x18: 00000000e9f55e4c
    x17: 6874656d6f73202c x16: 646e696220726576 x15: 0720072007200720
    x14: 0720072007200720 x13: 0720072007200720 x12: 0720072007200720
    x11: 00000000000001ac x10: ffffffc086da3700 x9 : ffffffc083edb140
    x8 : ffffffc086da3698 x7 : ffffffc086da36a0 x6 : 00000000fff7ffff
    x5 : c0000000fff7ffff x4 : 0000000000000000 x3 : 0000000000000001
    x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffff80083d5380
    Call trace:
     __iommu_probe_device+0x208/0x38c (P)
     iommu_probe_device+0x34/0x74
     of_iommu_configure+0x128/0x200
     of_dma_configure_id+0xdc/0x1d4
     platform_dma_configure+0x48/0x6c
     really_probe+0xf0/0x260
     __driver_probe_device+0xec/0x104
     driver_probe_device+0x3c/0xc0
     __device_attach_driver+0x58/0xcc
     bus_for_each_drv+0xb8/0xe0
     __device_attach+0xdc/0x138
     device_initial_probe+0x10/0x18
     bus_probe_device+0x38/0xa0
     deferred_probe_work_func+0xb4/0xcc
     process_scheduled_works+0x2e4/0x4a8
     worker_thread+0x144/0x1cc
     kthread+0x188/0x198
     ret_from_fork+0x10/0x20
    irq event stamp: 49052
    hardirqs last  enabled at (49051): [<ffffffc0800fb6a8>]
__up_console_sem+0x50/0x74
    hardirqs last disabled at (49052): [<ffffffc0809eb65c>] el1_dbg+0x20/0x6c
    softirqs last  enabled at (49046): [<ffffffc080096c50>]
handle_softirqs+0x1b0/0x3b4
    softirqs last disabled at (48839): [<ffffffc080010168>]
__do_softirq+0x10/0x18
    ---[ end trace 0000000000000000 ]---

I added debug prints to sata_rcar_probe(), and verified SATA is
probed at about the same time on R-Car H3 and M3N, and the probe is
never deferred.

Do you have a clue?


2. The IOMMU driver's iommu_ops.of_xlate() callback is called about
three times as much as before:

    +platform ec700000.dma-controller: ipmmu_of_xlate
    +platform ec720000.dma-controller: ipmmu_of_xlate
    +platform ec700000.dma-controller: ipmmu_of_xlate
    +platform ec720000.dma-controller: ipmmu_of_xlate
    +platform ec700000.dma-controller: ipmmu_of_xlate
    +platform ec720000.dma-controller: ipmmu_of_xlate
    +platform ec700000.dma-controller: ipmmu_of_xlate
    +platform ec720000.dma-controller: ipmmu_of_xlate
    +platform ec700000.dma-controller: ipmmu_of_xlate
    +platform ec720000.dma-controller: ipmmu_of_xlate
    +platform fea27000.fcp: ipmmu_of_xlate
    +platform fea2f000.fcp: ipmmu_of_xlate
    +platform ec700000.dma-controller: ipmmu_of_xlate
    +platform ec720000.dma-controller: ipmmu_of_xlate
    +platform fe950000.fcp: ipmmu_of_xlate
    +platform fe96f000.fcp: ipmmu_of_xlate
    +platform fea27000.fcp: ipmmu_of_xlate
    +platform fea2f000.fcp: ipmmu_of_xlate
    +platform fe9af000.fcp: ipmmu_of_xlate
     rcar-fcp fe950000.fcp: ipmmu_of_xlate
     rcar-fcp fe96f000.fcp: ipmmu_of_xlate
     rcar-fcp fea27000.fcp: ipmmu_of_xlate
     rcar-fcp fea2f000.fcp: ipmmu_of_xlate
     rcar-fcp fe9af000.fcp: ipmmu_of_xlate
     rcar-dmac ec700000.dma-controller: ipmmu_of_xlate
     rcar-dmac ec720000.dma-controller: ipmmu_of_xlate
    +platform e6700000.dma-controller: ipmmu_of_xlate
    +platform e6800000.ethernet: ipmmu_of_xlate
    +platform e6700000.dma-controller: ipmmu_of_xlate
    +platform e7300000.dma-controller: ipmmu_of_xlate
    +platform e7310000.dma-controller: ipmmu_of_xlate
    +platform e6800000.ethernet: ipmmu_of_xlate
    +platform ee100000.mmc: ipmmu_of_xlate
    +platform ee140000.mmc: ipmmu_of_xlate
    +platform ee160000.mmc: ipmmu_of_xlate
    +platform e6700000.dma-controller: ipmmu_of_xlate
    +platform e7300000.dma-controller: ipmmu_of_xlate
    +platform e7310000.dma-controller: ipmmu_of_xlate
    +platform e6800000.ethernet: ipmmu_of_xlate
    +platform ee100000.mmc: ipmmu_of_xlate
    +platform ee140000.mmc: ipmmu_of_xlate
    +platform ee160000.mmc: ipmmu_of_xlate
    +platform ee300000.sata: ipmmu_of_xlate
     sata_rcar ee300000.sata: ipmmu_of_xlate
     ravb e6800000.ethernet: ipmmu_of_xlate
    -renesas_sdhi_internal_dmac ee100000.mmc: ipmmu_of_xlate
    -renesas_sdhi_internal_dmac ee140000.mmc: ipmmu_of_xlate
    -renesas_sdhi_internal_dmac ee160000.mmc: ipmmu_of_xlate
     rcar-dmac e6700000.dma-controller: ipmmu_of_xlate
     rcar-dmac e7300000.dma-controller: ipmmu_of_xlate
     rcar-dmac e7310000.dma-controller: ipmmu_of_xlate

For some devices, it can be called up to 6 times. All of the duplicates
happen before the device is bound (cfr. "platform" instead of the
actual driver name):

      6 platform ec720000.dma-controller: ipmmu_of_xlate
      6 platform ec700000.dma-controller: ipmmu_of_xlate
      3 platform e6800000.ethernet: ipmmu_of_xlate
      3 platform e6700000.dma-controller: ipmmu_of_xlate
      2 platform fea2f000.fcp: ipmmu_of_xlate
      2 platform fea27000.fcp: ipmmu_of_xlate
      2 platform ee160000.mmc: ipmmu_of_xlate
      2 platform ee140000.mmc: ipmmu_of_xlate
      2 platform ee100000.mmc: ipmmu_of_xlate
      2 platform e7310000.dma-controller: ipmmu_of_xlate
      2 platform e7300000.dma-controller: ipmmu_of_xlate
      1 platform fe9af000.fcp: ipmmu_of_xlate
      1 platform fe96f000.fcp: ipmmu_of_xlate
      1 platform fe950000.fcp: ipmmu_of_xlate
      1 platform ee300000.sata: ipmmu_of_xlate
      1 sata_rcar ee300000.sata: ipmmu_of_xlate
      1 rcar-fcp fea2f000.fcp: ipmmu_of_xlate
      1 rcar-fcp fea27000.fcp: ipmmu_of_xlate
      1 rcar-fcp fe9af000.fcp: ipmmu_of_xlate
      1 rcar-fcp fe96f000.fcp: ipmmu_of_xlate
      1 rcar-fcp fe950000.fcp: ipmmu_of_xlate
      1 rcar-dmac ec720000.dma-controller: ipmmu_of_xlate
      1 rcar-dmac ec700000.dma-controller: ipmmu_of_xlate
      1 rcar-dmac e7310000.dma-controller: ipmmu_of_xlate
      1 rcar-dmac e7300000.dma-controller: ipmmu_of_xlate
      1 rcar-dmac e6700000.dma-controller: ipmmu_of_xlate
      1 ravb e6800000.ethernet: ipmmu_of_xlate

Before, the callback was called just once for each DMA slave device.

Is this intentional?

Thanks!

[1] SATA IOMMU on R-Car Gen3 needs an out-of-tree patch to add it to
    drivers/iommu/ipmmu-vmsa.c:devices_allowlist[].

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
