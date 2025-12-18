Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D032330B31
	for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 08:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766046595; cv=none; b=sxvckaSzW/3Sg8d7bhVLQf/lUywXaUdZll2154sqgDdOkddmomkaXtqHBL1gH8iKfIKlnOC26mC6f/hY6t1IXGLVG2pr9HcKaPE6ReSXgovs1UUz+21sVRpm3JUx2hsjDIX+uCDuwvVL/0QnEbO4NuITqWbPs07WdNTOm2LcBQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766046595; c=relaxed/simple;
	bh=Oa6DGRshrb/XIPC9bSafQMNKZb6vW9Oot4w65mnSUCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHpRqVRd9ATbjjA6Ls9gY3dTBI+5rkB5QpWgUkQhu2BLIGHIu4CASwsrpbtL5jBI+eV0Bp1G9igcNTQq64FDgfjAQSK47/49Rf4LVJXtLT7Elmm1CeACdJmB9XiqS1JQ2urCHIiwn2mx5AAruqkIBc20H6Elj6Id1nVqHwN51eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aA5poXNN; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aA5poXNN"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-42f9ece6387so92671f8f.0
        for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 00:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766046588; x=1766651388; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lavxgZWz4TkywEj6PAUErgsCvywzNZdy0QPzZNc0VIE=;
        b=aA5poXNNcDM6mCieaLti06umCZDccQgbiP/EApXhg6LMn1s7gvjLqL9ShpwMQXXTj4
         gZD71AEv72XEeJgIu0o/S6fVcvMDiN8rTXY0wScUrgGcUn5QB/9v0kEHApwCfCqO6r+F
         kJ02eMPFqeG9Aql7nFLb1IG9ztiW+KMgXDGc0+HeQqK9moDmbVbSBmnPGeMgJN0WJzA5
         TI1Urb9jYqDGYJPAe8alCxxxOO28RwpN2G0T9I371cGs4zBLisJeRzjTUqxXhZTQbYk8
         ViixdfKdB97gjvuz/wfj6Q2bLuHyWsNxyOBgS3s/IxfNPR9kc3Sqf9omyuXlz6ODSr2n
         ZqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766046588; x=1766651388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lavxgZWz4TkywEj6PAUErgsCvywzNZdy0QPzZNc0VIE=;
        b=O2p8uFj7V7dVbykL8hbTR+8T5vI4RPJD9WAYHenrom4r+9x/5/LDto0qkR6u/gWDYR
         axqP3wxuMGbDix0FxITKrcqQXtJ8z5Zn1zHJqoEpDxvjavhYXh+I+BNI1DHEVTW0svKw
         R6F1QmLOxvBCCO/UrukA22YrAIQGpHjJj4FUpkDJCHnPkYXYO4DsmN7+BGA4GzjBAKNQ
         RHu6A/P3VUkdXvwD61O0OOdIl9PxVQsGLG8/TQzF7h+mRFoeA886NqJ2UQHceXyjmy9P
         1ODbBw4meGpx6NKG5CInvFu6ZGct1Drxz+d2zWsgM2wD8RJY7PRHy+LKs5aBZd9cQki6
         EUlA==
X-Forwarded-Encrypted: i=1; AJvYcCXLYHENaOelNziD6yH1n7k6Tlr/E+kz3o7cJv7SWPR8l3CMzHLZdWu4I8lUEOWrfLrcis2x2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YznIOWHF7NWzpCKYWhQ8aw5JFqQbZp1d5wgPqSA0Wlz/05jb8cI
	wMYIXDf/MlJlRujyoxGMbiVT+hkEqoM7G34D/PjIsUZRkTad3bi0GEesSKbc04gsUwU=
X-Gm-Gg: AY/fxX65H/akWdS04ynCyJvttF53ZRhIC5Vw3nqbCj/l5mjfGHztNjFtmGPw8FTAnCP
	58es8UL00G7vLyEKws+l9KYZ81JLg1h3LqBtUJtGKCgxjf9i8gI8uz3wUqEacI93Ou6wnuOt4uo
	zkajLHNJFe3EO/qBBOh1GvfWcCafGBuRM77X/Gc3nGhR4sNgRffflZ9pe8e2KxIxfH4fP1rbBuW
	5l3mfz3JG2T+dFDwO1gEX1COdWL+vC6DRyMEHZgYwylDhYJhKss7ivU448nwOUyZf3/ff2/6FIM
	kk5ckpOfFhTLDPtGDoawg+rUocCovx+ZWDIEf3q/TkV9f5EbaGplqynXAlYyNRjvqkBLTTusVQn
	1TdDEm0AsP6ryZOVAWM/DGNfufF1DBnuCohogn+G+630JTpq5ltNsX4P0/NohZWnI4py4HhgUGO
	sLa3hupxxg5B2wfaCEo1ydTXp6MkuDDC9DttRaezBJGa7zMV2fyztfAcydaXa79Z9rl36s3HxZc
	qg=
X-Google-Smtp-Source: AGHT+IEEcQh3Evp//JkH7DxD5zJabcbcUcYeT6Ax8AuhpdxKs84vU8Xxreh7Zr/WWxIdOg9pxtp9pA==
X-Received: by 2002:a05:6000:18a6:b0:430:fd84:3179 with SMTP id ffacd0b85a97d-430fd8434b3mr12605656f8f.33.1766046587263;
        Thu, 18 Dec 2025 00:29:47 -0800 (PST)
Received: from localhost (p200300f65f006608d060da4a6607fcf5.dip0.t-ipconnect.de. [2003:f6:5f00:6608:d060:da4a:6607:fcf5])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4324498f965sm3734840f8f.20.2025.12.18.00.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 00:29:46 -0800 (PST)
Date: Thu, 18 Dec 2025 09:29:45 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>, 
	William Zhang <william.zhang@broadcom.com>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>, 1116251@bugs.debian.org, 
	regressions@lists.linux.dev, Sasha Levin <sashal@kernel.org>, iommu@lists.linux.dev, 
	Benjamin Drung <bdrung@debian.org>
Subject: Re: Bug#1116251: linux-image-6.12.48+deb13-rpi: Raspberry Pi Zero W
 does not boot
Message-ID: <hnwgn7glub4klmkzabzcm76eldaa3xm5ua72eldwzesblveo2a@4xq2bxhmbsyq>
References: <c35629054179865b770bc3bf0ed0cfe4c01f77f7.camel@debian.org>
 <772b4ba943acec4ec24009af7db0f7ea249adc98.camel@debian.org>
 <aSaxsQB3w61sEV90@eldamar.lan>
 <c35629054179865b770bc3bf0ed0cfe4c01f77f7.camel@debian.org>
 <931652ee31f88beadd45aefd972d8ea221d1e79c.camel@debian.org>
 <c35629054179865b770bc3bf0ed0cfe4c01f77f7.camel@debian.org>
 <aSop6N7jUJ__lhy-@eldamar.lan>
 <aSwN5F9UlwHUnxDt@eldamar.lan>
 <6cd9babe311f6d5e2db0b51d04a4248377defcd3.camel@debian.org>
 <39590b9d90825cbc83072027b742410c3576fafa.camel@debian.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4r6fm7btsjt4rvhs"
Content-Disposition: inline
In-Reply-To: <39590b9d90825cbc83072027b742410c3576fafa.camel@debian.org>


--4r6fm7btsjt4rvhs
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Bug#1116251: linux-image-6.12.48+deb13-rpi: Raspberry Pi Zero W
 does not boot
MIME-Version: 1.0

Control: forwarded -1 https://lore.kernel.org/linux-iommu/hnwgn7glub4klmkza=
bzcm76eldaa3xm5ua72eldwzesblveo2a@4xq2bxhmbsyq
Hello,

I extended the audience to people involved in the creation of
2c223f7239f376a90d71903ec474ba887cf21d94.

On Wed, Dec 17, 2025 at 11:07:00PM +0100, Benjamin Drung wrote:
> On Wed, 2025-12-17 at 22:20 +0100, Benjamin Drung wrote:
> > On Sun, 2025-11-30 at 10:27 +0100, Salvatore Bonaccorso wrote:
> > > On Sat, Nov 29, 2025 at 12:02:00AM +0100, Salvatore Bonaccorso wrote:
> > > > On Fri, Nov 28, 2025 at 10:53:17PM +0100, Benjamin Drung wrote:
> > > > > On Wed, 2025-11-26 at 08:52 +0100, Salvatore Bonaccorso wrote:
> > > > > > On Sat, Nov 22, 2025 at 04:27:53PM +0100, Benjamin Drung wrote:
> > > > > > > On Fri, 2025-11-21 at 09:52 +0100, Uwe Kleine-K=F6nig wrote:
> > > > > > > > On Thu, Nov 20, 2025 at 11:11:07AM +0100, Benjamin Drung wr=
ote:
> > > > > > > > > On Thu, 2025-11-20 at 08:58 +0100, Uwe Kleine-K=F6nig wro=
te:
> > > > > > > > > > On Mon, Nov 17, 2025 at 02:05:41AM +0100, Benjamin Drun=
g wrote:
> > > > > > > > > > > On Wed, 2025-11-05 at 20:14 +0100, Uwe Kleine-K=F6nig=
 wrote:
> > > > > > > > > > > > Can you try adding
> > > > > > > > > > > >=20
> > > > > > > > > > > > 	earlyprintk=3Dserial,0x7e215040
> > > > > > > > > > > >=20
> > > > > > > > > > > > to the kernel commandline. Not sure this activates =
the right procedures,
> > > > > > > > > > > > maybe try it with the working kernel first.
> > > > > > > > > > >=20
> > > > > > > > > > > I tried with the working kernel 6.12.43+deb13-rpi but=
 these were the
> > > > > > > > > > > earliest lines:
> > > > > > > > > > >=20
> > > > > > > > > > > [    4.116565] printk: legacy console [ttyS1] enabled
> > > > > > > > > > > [    4.129635] printk: legacy bootconsole [earlycon0]=
 disabled
> > > > > > > > > > > [    4.147050] bcm2835-power bcm2835-power: Broadcom =
BCM2835 power domains driver
> > > > > > > > > > > [    4.160972] mousedev: PS/2 mouse device common for=
 all mice
> > > > > > > > > > > [    4.172622] i2c-bcm2835 20805000.i2c: Could not re=
ad clock-frequency property
> > > > > > > > > > > [    4.186585] bcm2835-wdt bcm2835-wdt: Broadcom BCM2=
835 watchdog timer
> > > > > > > > > > >=20
> > > > > > > > > > > I tried with 6.12.57+deb13-rpi but that failed to boo=
t and the
> > > > > > > > > > > earlyprintk line did not give any additional logs.
> > > > > > > > > >=20
> > > > > > > > > > Can you please provide a full kernel log of the working=
 kernel?
> > > > > > > > >=20
> > > > > > > > > dmesg log is attached.
> > > > > > > > >=20
> > > > > > > > > > Also please provide the output of:
> > > > > > > > > >=20
> > > > > > > > > > 	for f in /proc/tty/driver/*; do echo $f; sed 's/^/  /'=
 < $f; done
> > > > > > > > >=20
> > > > > > > > > /proc/tty/driver/serial
> > > > > > > > >   serinfo:1.0 driver revision:
> > > > > > > > >   0: uart:unknown port:00000000 irq:0
> > > > > > > > >   1: uart:16550 mmio:0x20215040 irq:53 tx:15629 rx:0 RTS|=
CTS|DTR
> > > > > > > > >   2: uart:unknown port:00000000 irq:0
> > > > > > > > >   3: uart:unknown port:00000000 irq:0
> > > > > > > > > /proc/tty/driver/ttyAMA
> > > > > > > > >   serinfo:1.0 driver revision:
> > > > > > > > >   0: uart:PL011 rev2 mmio:0x20201000 irq:81 tx:452 rx:980=
 RTS|CTS|DTR
> > > > > > > >=20
> > > > > > > > OK, is
> > > > > > > >=20
> > > > > > > >  	earlyprintk=3Dserial,0x20215040
> > > > > > > >=20
> > > > > > > > more communicative then?
> > > > > > >=20
> > > > > > > Nope, but I found
> > > > > > > https://www.raspberrypi.com/documentation/computers/configura=
tion.html#enabling-early-console-for-linux
> > > > > > > and setting earlycon=3Duart8250,mmio32,0x20215040 worked. The=
 kernel
> > > > > > > 6.12.43+deb13-rpi booted with printing the early lines as wel=
l (see
> > > > > > > dmesg of previous mail).
> > > > > > >=20
> > > > > > > With all other experiments cleaned, I tried the latest kernel:
> > > > > > >=20
> > > > > > > ```
> > > > > > > $ cat /etc/default/raspi-extra-cmdline
> > > > > > > earlycon=3Duart8250,mmio32,0x20215040
> > > > > > > $ update-initramfs -u
> > > > > > > ```
> > > > > > >=20
> > > > > > > I got following logs before it got stuck:
> > > > > > >=20
> > > > > > > ```
> > > > > > > [    0.000000] Booting Linux on physical CPU 0x0
> > > > > > > [    0.000000] Linux version 6.12.57+deb13-rpi (debian-kernel=
@lists.debian.org) (arm-linux-gnueabi-gcc-14 (Debian 14.2.0-19) 14.2.0, GNU=
 ld (GNU Binutils for Debian) 2.44) #1 Debian 6.12.57-1 (2025-11-05)
> > > > > > > [    0.000000] CPU: ARMv6-compatible processor [410fb767] rev=
ision 7 (ARMv7), cr=3D00c5387d
> > > > > > > [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT =
nonaliasing instruction cache
> > > > > > > [    0.000000] OF: fdt: Machine model: Raspberry Pi Zero W Re=
v 1.1
> > > > > > > [    0.000000] random: crng init done
> > > > > > > [    0.000000] earlycon: uart8250 at MMIO32 0x20215040 (optio=
ns '')
> > > > > > > [    0.000000] printk: legacy bootconsole [uart8250] enabled
> > > > > > > [    0.000000] Memory policy: Data cache writeback
> > > > > > > [    0.000000] Reserved memory: bypass linux,cma node, using =
cmdline CMA params instead
> > > > > > > [    0.000000] OF: reserved mem: node linux,cma compatible ma=
tching fail
> > > > > > > [    0.000000] cma: Reserved 64 MiB at 0x17000000 on node -1
> > > > > > > ```
> > > > > > >=20
> > > > > > > It looks like being cma related and I found a cma boot option=
 in
> > > > > > > /etc/default/raspi-firmware. So I modified /boot/firmware/cmd=
line.txt
> > > > > > > and changed cma=3D64M to cma=3D0. Then the system booted with=
out problems:
> > > > > > >=20
> > > > > > > ```
> > > > > > > [...]
> > > > > > > [    0.000000] Reserved memory: bypass linux,cma node, using =
cmdline CMA params instead
> > > > > > > [    0.000000] OF: reserved mem: node linux,cma compatible ma=
tching fail
> > > > > > > [    0.000000] Zone ranges:
> > > > > > > [    0.000000]   Normal   [mem 0x0000000000000000-0x000000001=
bffffff]
> > > > > > > [    0.000000] Movable zone start for each node
> > > > > > > [    0.000000] Early memory node ranges
> > > > > > > [    0.000000]   node   0: [mem 0x0000000000000000-0x00000000=
1bffffff]
> > > > > > > [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0=
x000000001bffffff]
> > > > > > > [    0.000000] Kernel command line:  dma.dmachans=3D0x7ff5 bc=
m2708.boardrev=3D0x9000c1 bcm2708.serial=3D0x8bb1238 bcm2708.uart_clock=3D4=
8000000 bcm2708.disk_led_gpio=3D47 smsc95xx.macaddr=3DB8:27:EB:BB:12:38 vc_=
mem.mem_base=3D0x1ec00000 vc_mem.mem_size=3D0x20000000  console=3Dtty0 cons=
ole=3DttyS1,115200 root=3D/dev/mmcblk0p2 rw fsck.repair=3Dyes net.ifnames=
=3D0 cma=3D0 rootwait earlycon=3Duart8250,mmio32,0x20215040
> > > > > > > [...]
> > > > > > > ```
> > > > > > >=20
> > > > > > > Then I persisted this change by setting CMA=3D0 in
> > > > > > > /etc/default/raspi-firmware:
> > > > > > >=20
> > > > > > > ```
> > > > > > > $ grep -Ev '^(#|$)' /etc/default/raspi-firmware
> > > > > > > CMA=3D0
> > > > > > > $ update-initramfs -u
> > > > > > > ```
> > > > > > >=20
> > > > > > > This config removes the cma cmdline option completely. The sy=
stem still
> > > > > > > boots:
> > > > > > >=20
> > > > > > > ```
> > > > > > > [...]
> > > > > > > [    0.000000] Memory policy: Data cache writeback
> > > > > > > [    0.000000] Reserved memory: created CMA memory pool at 0x=
17000000, size 64 MiB
> > > > > > > [    0.000000] OF: reserved mem: initialized node linux,cma, =
compatible id shared-dma-pool
> > > > > > > [    0.000000] OF: reserved mem: 0x17000000..0x1affffff (6553=
6 KiB) map reusable linux,cma
> > > > > > > [    0.000000] Zone ranges:
> > > > > > > [    0.000000]   Normal   [mem 0x0000000000000000-0x000000001=
bffffff]
> > > > > > > [    0.000000] Movable zone start for each node
> > > > > > > [    0.000000] Early memory node ranges
> > > > > > > [    0.000000]   node   0: [mem 0x0000000000000000-0x00000000=
1bffffff]
> > > > > > > [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0=
x000000001bffffff]
> > > > > > > [    0.000000] Kernel command line:  dma.dmachans=3D0x7ff5 bc=
m2708.boardrev=3D0x9000c1 bcm2708.serial=3D0x8bb1238 bcm2708.uart_clock=3D4=
8000000 bcm2708.disk_led_gpio=3D47 smsc95xx.macaddr=3DB8:27:EB:BB:12:38 vc_=
mem.mem_base=3D0x1ec00000 vc_mem.mem_size=3D0x20000000  console=3Dtty0 cons=
ole=3DttyS1,115200 root=3D/dev/mmcblk0p2 rw fsck.repair=3Dyes net.ifnames=
=3D0  rootwait earlycon=3Duart8250,mmio32,0x20215040
> > > > > > > [...]
> > > > > > > ```
> > > > > > >=20
> > > > > > > That should hopefully narrow down the issue space.
> > > > > >=20
> > > > > > If I'm not wrong the only cma related change between 6.12.43 and
> > > > > > 6.12.48 was the backport of 2c223f7239f3 ("of: reserved_mem:
> > > > > > Restructure call site for dma_contiguous_early_fixup()"):
> > > > > >=20
> > > > > > 	commit 46efab01648a04082266115a8e917c3b26b97fa8
> > > > > > 	Author: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.co=
m>
> > > > > > 	Date:   Wed Aug 6 10:24:21 2025 -0700
> > > > > >=20
> > > > > > 	    of: reserved_mem: Restructure call site for dma_contiguous=
_early_fixup()
> > > > > >=20
> > > > > > 	    [ Upstream commit 2c223f7239f376a90d71903ec474ba887cf21d94=
 ]
> > > > > >=20
> > > > > > 	    Restructure the call site for dma_contiguous_early_fixup()=
 to
> > > > > > 	    where the reserved_mem nodes are being parsed from the DT =
so that
> > > > > > 	    dma_mmu_remap[] is populated before dma_contiguous_remap()=
 is called.
> > > > > >=20
> > > > > > 	    Fixes: 8a6e02d0c00e ("of: reserved_mem: Restructure how th=
e reserved memory regions are processed")
> > > > > > 	    Signed-off-by: Oreoluwa Babatunde <oreoluwa.babatunde@oss.=
qualcomm.com>
> > > > > > 	    Tested-by: William Zhang <william.zhang@broadcom.com>
> > > > > > 	    Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > > > 	    Link: https://lore.kernel.org/r/20250806172421.2748302-1-o=
reoluwa.babatunde@oss.qualcomm.com
> > > > > > 	    Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > > > >=20
> > > > > > Uwe, would that make sense? Benjamin can you try to make a buil=
d with
> > > > > > that commit reverted, does it fix the problem?
> > > > >=20
> > > > > Building the kernel on the Pi Zero would probably take ages. I ha=
ve a
> > > > > Raspberry Pi 5 running arm64. That should be able to build the ke=
rnel in
> > > > > a armel schroot, shouldn't it? Is there documentation for buildin=
g the
> > > > > kernel?
> > > >=20
> > > > I hope it is fine for Uwe that i respond here, he might have another
> > > > more efficient way to reach our goal.
> > > >=20
> > > > But we have the simple-patching guideline here:
> > > > https://kernel-team.pages.debian.net/kernel-handbook/ch-common-task=
s.html#id-1.6.6.4
> > > >=20
> > > > That should work within an armel schroot work well, e.g. on a
> > > > porterbox amdahl.d.o i would first setup a schroot via:
> > > >=20
> > > > schroot -b -c chroot:trixie_armel-dchroot -n linux
> > > > dd-schroot-cmd -c linux apt-get update
> > > > dd-schroot-cmd -c linux apt-get dist-upgrade
> > > > dd-schroot-cmd -c linux apt-get build-dep linux
> > > > schroot -r -c linux
> > > > (see https://dsa.debian.org/doc/schroot/)
> > > >=20
> > > > Then download the linux/6.12.57-1 source and make the revert patch
> > > > available.
> > > >=20
> > > > apt-get source linux
> > > > cd linux-*
> > > > ./debian/bin/test-patches -f rpi ../0001-Revert-of-reserved_mem-Res=
tructure-call-site-for-dma.patch
> > >=20
> > > In case you can/want trust unsigned packages (but I have put a
> > > sha256sum along signed with my key in the DD keyring), you can test
> > > the patch revert via the packages on:
> > > https://people.debian.org/~carnil/tmp/linux/1116251/
> >=20
> > Thanks for providing the kernel. I downloaded linux-image-
> > 6.12+unreleased-rpi_6.12.57-1a~test_armel.deb and installed it. This
> > kernel hangs on boot (see attached boot.log). It hangs there
> > reproducible.
>=20
> The "Linux version 4.14.98+" in the log puzzled me and
> /etc/kernel/postinst.d/z50-raspi-firmware did not copy kernel
> 6.12.57-1a~test to /boot/firmware.
>=20
> I found the old kernel.img and kernel7.img that I deleted. I copied the
> 6.12.57-1a~test kernel manually:
>=20
> ```
> update-initramfs -u -k 6.12+unreleased-rpi
> cd /boot/firmware/
> cp ../vmlinuz-6.12+unreleased-rpi .
> cp ../initrd.img-6.12+unreleased-rpi .
> vim config.txt
> reboot
> ```
>=20
> Then the Pi booted the correct kernel (6.12+unreleased-rpi) successfully
> with following cmdline configurations:
>=20
> * no cma set
> * cma=3D0
> * cma=3D64M

If I understood right that means that
46efab01648a04082266115a8e917c3b26b97fa8 aka
2c223f7239f376a90d71903ec474ba887cf21d94 broke booting on the Raspberry
Pi Zero W when CMA is used.

#regzbot introduced: 2c223f7239f376a90d71903ec474ba887cf21d94

Does this ring a bell for someone, or do you have some debugging
instructions? Complete context is available at
https://bugs.debian.org/1116251.

Best regards
Uwe

--4r6fm7btsjt4rvhs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlDu3cACgkQj4D7WH0S
/k6DxwgAiTyxQYUiixBLUuQnBhpT/O3dYnmJD+m5dM16FujjNjI8RT5yEGF/Qvcx
VW5R+iLfyE4W2XMndwVXOCkkzj3J7SeHyqQYQWoirN5YbXOyi7PDV7n9wwFwyB2f
AJtRMz0oNPHYx1VGINUMQxSBoS6URiPMiXUGIp52q+HdZdMIp5bNTIvRiGg/Hwtd
v8IR8goaovZCApx7LYrPK58mj00OTSZCZ7iegDoL9zxfLPBwDYvmyFvG8JOctqf2
kV+S7RvrUk0TozFZFycTwBW0ONRXYeWSnXlAOZf3dVxFYRKXw+5TThSSzDr41vGg
msslEvsIKvtqbyNuSnkF/dNPv+o7og==
=elCG
-----END PGP SIGNATURE-----

--4r6fm7btsjt4rvhs--
