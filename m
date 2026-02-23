Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF62F305968
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861900; cv=pass; b=oD8Px8hjhVuDe9tR1/DjFhFcl2yWUauVmXvp/MGtmMZlqWo2AveMGc1s4INh4XXho+eT1LMauoLY6TYF6efup+oNCVD2asEvhUSrfNpIy9EykdmeQlGTmsKBcOoZc+bGDFuvNXxny8z0DWckFKeUDHUUkCiREJTCy292bG7uRUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861900; c=relaxed/simple;
	bh=d5zCa3ysNLijKNaGOI7tuajauNFQ8GHfuuwERS7PUF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcyuoRyRmyvAiGpjUqg/PGylJeL40Ern/CKGuOgZFC9HvNm1c4guq4yk5Ym3aL9UwSod2lJpkkgx9UFSXptmUUMX0um/5RshN4HzPEXL7ck8ojRHpQAM2x83zkwdutITV/w49J31w1OBiA2rre4xKdj5a1+KRzuxWcBjGbdZgG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJ65wYz6; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJ65wYz6"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8f96f6956aso617291866b.3
        for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 07:51:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771861896; cv=none;
        d=google.com; s=arc-20240605;
        b=KMtLmo4/2NlYm3jl5SZjWGJWTBRNdrCHfPUgsudO+kpEnJOdGKlXcoqCJhhb+6TNhX
         VFANl6sdnq4HdoyAOMuqJaBxe5zL4KM3lYi3nvBnzM1UYrYxzVFnY1iSUu9XInmQo/E9
         56FjZ4LEQc0JLKAxjlcz2V5WuZIUaXB8cN2bO6rFcTMMQKvW18FivJ63JaNNnW+F0ILi
         DXR1FW8DjL7KH1swnfvNYGMdce+op4/BqpNAOVz4tNjTgiVwOkk93DfcnE1Lb2n0URmG
         gwhKIf2Yw/uDOa1RmthIdPemtdAjwK+QzrT6BbVXob64iEGpQy5Fr/FYKBvxho8NSnQ8
         VI3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=npGY86N71VPo4TOfv73Omx9yZ3z0Eb9N82/SaZDWxbc=;
        fh=a92pUDpMn9O5lZUi6LwwNV6l0JziqlnrKuUVl4FGswg=;
        b=Uqc+k+bxqKrYUQpICw0k6nGaoNGN0yeWQfUWVw3bbigubGs0i6gaZCQEfwySEFNXK5
         5go/VOtQoE449cUIQ5jRxUw5Udxj7EoTFhi8GRlHUAW4OzRMwEEixuFoVGl4yqcPaJmn
         Q5eNUQ5Ciqg8lJnEGTVDq/5q2cf//8IRrjjnmn4MTVm1m36yLVfxCMDyoWdxL1kQr/YK
         uGRZuUTECK3Y0TUVyKRI2jyag6ycRjiYfADFjiNRzFbOoPieZl48ILvI+ZkUnpRhu7xC
         zgq9HTZ4E6gb0el15Iyx3pxUlJVhHJPFvi/8KrQwzVygHc9Q1Q5MsSqzeAy/vTBprRzV
         C/Yg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771861896; x=1772466696; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npGY86N71VPo4TOfv73Omx9yZ3z0Eb9N82/SaZDWxbc=;
        b=LJ65wYz6V0Ewp3RFifSsXbANZB6t5ldCsTpObnFVX9ryd/UDihw4YBq1qkNGcvrwd6
         a5R5+pRGtUsILKPOOMphucyF3jOg/t4o2GjX53JnAlfO8CaQVKRPlpUZ5S0pROZx8cg/
         tcVfYbTI7wKv6fC5I1uTAcy5E3N6DgsKAWb6fzdVVlbD7dCnojp0cqKRXLbXPd6KMbXP
         9I86jbUptgUjI8TVLtnbgrVPr1nH1M8heprYlJlAVrsDenazawy3guUIU+dreayGzNRM
         QZZnkc4eyTRbeEcdNHk1CCrVtg2/1xi7R4bu+um2owWw/RATUTnlFeKp0HuaknVRjEF4
         RZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771861896; x=1772466696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=npGY86N71VPo4TOfv73Omx9yZ3z0Eb9N82/SaZDWxbc=;
        b=AWpuQnWmhqf6Ir0fwV6kzoTyvqWeXafbPlV8KrWerLWOGACVTijygUMkCGRJ3OkbTH
         JkhsRmDiDg/jlMayM8mvx0b3sQGs7LvfwZqhas4T9lFpkUENtU/KuRnjjMlvzmZc6YlP
         gAR3V3IqQKmjEQOTH0olCD1yp3iC2UIxK1yrs9zJ5AT4RpOsWdydDH62MobFxbNB5LI9
         TrO52W8OqKffARqWUrf65JYj5Nkjo4eoDzMhbdgjNeMB3iFK+QqX2sT00OkvSrhMSHN3
         7C798HtskNQrnkix7jL185CaHSD3bLy87snIYlRVA+c1IAXVLUpfGOS8EeoOePc3QZKJ
         qc6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxlvNNwwn/z7USwIlMUberj8NCpDBSQFvbrRJSZugF6W03J8iltrMqKVYWRlL21aFWkxWoWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxyM7y2tXFFaMmpTmlvz875Wc37idPHEy6VDKnoFzYZe93S3kvE
	cbmupPXANmEcP5Mg9VWKjSwOYg6QSqwuvLdrYVj0CJ5Fyv7nig7FWruHHpzQfAnVFn7UblqWsul
	uxkk5uQdeELIDhbjOZNVcW9NJnYuqnpk=
X-Gm-Gg: AZuq6aITlciT9uy/BozXnOER4Z4/Rgk66auDpSaqq/nIAy3Uu9Z4MzQtEDdIH9ih48B
	jzuQ2Ewr8fqUfEwdxveuaFZBRMk7Qy/6Ccux/PgiG2lzkUtxePJ5oU7V8yBSl1esp62M/H4FmAd
	oe/OWKjo5DhQcAD0LqZUcH3bUnEy4MT3QFX0AwSwPiKp7u3r5TfpfgYoHAXqbUpfuDY/Vp8XSww
	LJJsvfuU81EfwiuJcTvEWVqdhAQ/lSyGKov9J8NKVsSgdCCpyIoU3R1LCL5uahpxFalMDPFoQ3x
	gRpZxl7VCGbMFQlHAvpr7FoaMOlhsmPNWzItNguBzsOHSO7ujdfs878drKDLRW1caFOwQSdDNV1
	FT/4dU7E=
X-Received: by 2002:a17:906:5ad6:b0:b8f:e424:ae56 with SMTP id
 a640c23a62f3a-b9081badd6emr413937066b.44.1771861895691; Mon, 23 Feb 2026
 07:51:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 23 Feb 2026 17:50:59 +0200
X-Gm-Features: AaiRm51McMZohKyigNQFIbQDImiJ8vF_g2F0DjapyVKPe6Rkgx4x17MorqEdw1M
Message-ID: <CAHp75VeWD5A0r7-Uayyte1ZXXxdhLixd+z_y0xNeki0N+Ro=jQ@mail.gmail.com>
Subject: Re: [PATCH 0/37] PCI/MSI: Enforce explicit IRQ vector management by
 removing devres auto-free
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	"Vaibhaav Ram T . L" <vaibhaavram.tl@microchip.com>, 
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>, Even Xu <even.xu@intel.com>, 
	Xinpeng Sun <xinpeng.sun@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Zhou Wang <wangzhou1@hisilicon.com>, 
	Longfang Liu <liulongfang@huawei.com>, Vinod Koul <vkoul@kernel.org>, Lee Jones <lee@kernel.org>, 
	Jijie Shao <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, 
	Sunil Goutham <sgoutham@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Oded Gabbay <ogabbay@kernel.org>, 
	Maciej Falkowski <maciej.falkowski@linux.intel.com>, 
	Karol Wachowski <karol.wachowski@linux.intel.com>, Min Ma <mamin506@gmail.com>, 
	Lizhi Hou <lizhi.hou@amd.com>, Andreas Noever <andreas.noever@gmail.com>, 
	Mika Westerberg <westeri@kernel.org>, Tomasz Jeznach <tjeznach@rivosinc.com>, 
	Will Deacon <will@kernel.org>, Xinliang Liu <xinliang.liu@linaro.org>, 
	Tian Tao <tiantao6@hisilicon.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Srujana Challa <schalla@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Antoine Tenart <atenart@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Raag Jadav <raag.jadav@intel.com>, 
	Hans de Goede <hansg@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Robert Richter <rric@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bingbu Cao <bingbu.cao@intel.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-i3c@lists.infradead.org, dmaengine@vger.kernel.org, 
	Philipp Stanner <phasta@kernel.org>, netdev@vger.kernel.org, nic_swsd@realtek.com, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-usb@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-cxl@vger.kernel.org, linux-crypto@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org, 
	mhi@lists.linux.dev, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Jan Dabros <jsd@semihalf.com>, linux-i2c@vger.kernel.org, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-media@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 5:32=E2=80=AFPM Shawn Lin <shawn.lin@rock-chips.com=
> wrote:
>
> This patch series addresses a long-standing design issue in the PCI/MSI
> subsystem where the implicit, automatic management of IRQ vectors by
> the devres framework conflicts with explicit driver cleanup, creating
> ambiguity and potential resource management bugs.
>
> =3D=3D=3D=3D The Problem: Implicit vs. Explicit Management =3D=3D=3D=3D
> Historically, `pcim_enable_device()` not only manages standard PCI resour=
ces
> (BARs) via devres but also implicitly triggers automatic IRQ vector manag=
ement
> by setting a flag that registers `pcim_msi_release()` as a cleanup action=
.
>
> This creates an ambiguous ownership model. Many drivers follow a pattern =
of:
> 1. Calling `pci_alloc_irq_vectors()` to allocate interrupts.
> 2. Also calling `pci_free_irq_vectors()` in their error paths or remove r=
outines.
>
> When such a driver also uses `pcim_enable_device()`, the devres framework=
 may
> attempt to free the IRQ vectors a second time upon device release, leadin=
g to
> a double-free. Analysis of the tree shows this hazardous pattern exists w=
idely,
> while 35 other drivers correctly rely solely on the implicit cleanup.

Is this confirmed? What I read from the cover letter, this series was
only compile-tested, so how can you prove the problem exists in the
first place?

> =3D=3D=3D=3D The Solution: Making Management Explicit =3D=3D=3D=3D
> This series enforces a clear, predictable model:
> 1.  New Managed API (Patch 1/37): Introduces pcim_alloc_irq_vectors() and
>     pcim_alloc_irq_vectors_affinity(). Drivers that desire devres-managed=
 IRQ
>     vectors should use these functions, which set the is_msi_managed flag=
 and
>     ensure automatic cleanup.
> 2.  Patches 2 through 36 convert each driver that uses pcim_enable_device=
() alongside
>     pci_alloc_irq_vectors() and relies on devres for IRQ vector cleanup t=
o instead
>     make an explicit call to pcim_alloc_irq_vectors().
> 3.  Core Change (Patch 37/37): With the former cleanup, now modifies pcim=
_setup_msi_release()
>     to check only the is_msi_managed flag. This decouples automatic IRQ c=
leanup from
>     pcim_enable_device(). IRQ vectors allocated via pci_alloc_irq_vectors=
*()
>     are now solely the driver's responsibility to free with pci_free_irq_=
vectors().
>
> With these changes, we clear ownership model: Explicit resource managemen=
t eliminates
> ambiguity and follows the "principle of least surprise." New drivers choo=
se one model and
> be consistent.
> - Use `pci_alloc_irq_vectors()` + `pci_free_irq_vectors()` for explicit c=
ontrol.
> - Use `pcim_alloc_irq_vectors()` for devres-managed, automatic cleanup.

Have you checked previous attempts? Why is your series better than those?

> =3D=3D=3D=3D Testing And Review =3D=3D=3D=3D
> 1. This series is only compiled test with allmodconfig.
> 2. Given the substantial size of this patch series, I have structured the=
 mailing
>    to facilitate efficient review. The cover letter, the first patch and =
the last one will be sent
>    to all relevant mailing lists and key maintainers to ensure broad visi=
bility and
>    initial feedback on the overall approach. The remaining subsystem-spec=
ific patches
>    will be sent only to the respective subsystem maintainers and their as=
sociated
>    mailing lists, reducing noise.

--=20
With Best Regards,
Andy Shevchenko
