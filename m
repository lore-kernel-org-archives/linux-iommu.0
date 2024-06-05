Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C11915099C
	for <iommu@lists.linux.dev>; Wed,  5 Jun 2024 19:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717616527; cv=none; b=gJeZteOMUJimNwS/TandEpj9l4toWvla6dbNU1zWyT0XK+oywI8rcRdIzjW+onEDGkP7vZFiJigfmVspikpmYiAlyBdPDmBxFojMUPwa2flU0aR+YiDBYAIJbpg1F3oMriL0EmI6jltJyJ3NKV1KMkxHnyXAti35wDOCcItJ8WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717616527; c=relaxed/simple;
	bh=BkLjiawwOQEAVWftagmoBVsL5Q/uu5hCoju8LwKBppo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qw6BfD8SZLF3OwqUdgZ2c8KYafwNAKVRTHg458C4ovWm8b0gMFVZfR8TieSyYKiIbMLgkW/dg/3A1l/0Xu8zKhYgDCSalulwJ8Mm+y7D8h5HeO3Jxv7Ftl+ap87O2oS2scS5dPfxf5NKdRwXwEcm36eYIsWM3hltdmetICK4QTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yuc5GrXa; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yuc5GrXa"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c19e6dc3dcso163529a91.3
        for <iommu@lists.linux.dev>; Wed, 05 Jun 2024 12:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717616525; x=1718221325; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Iqln3pU608Iw9vzO5mExR0F6HHdjBJu68DaW17wMtg=;
        b=yuc5GrXadKbeoOOdtKoZTPs4zkgIzWnrcpmGf1ISUy2ZLzroh8ABpnGpHEiIqfYhJz
         qxcK/9QvSLTMH6grMUIA6F66gA8ZNnFq6WQExz5igujKG633bvJVQ0I8wg1zxNMAFlYR
         FYDwRmeulAF2jH7w3PPpMff45JSgVjBe1G+y/hayuLuPhwR6kQi6flXWwEvbcX1IzrVe
         6w/ALEU0bp0Uh0xE7UgBRD7TfEiAAHKfrkUMkUprHiuICm3Nf3gpIPeE8rFCz+SzChKg
         n8IFTjGeKOAm2hLZhA0vhDeU9SlKrAe8pO5YcxEwk2GgchqQHZGpxsd7rJ34RoFNsJpn
         jpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717616525; x=1718221325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Iqln3pU608Iw9vzO5mExR0F6HHdjBJu68DaW17wMtg=;
        b=lcUw6jnPthvgZ4Al8MY/tT05Mfi+kn21aS3KlwwLBuX1yAuMPOv/I/mcBa+9R/Wvva
         qzahR1OdjvjOw2waRDWoXhWVrl6YOy7ic5xyEX8pgSnl21FampdsoIgKcDOWWdSOks8H
         W018v1+f6a3xCOY1GhLiIYrxRtjfs7jlPV8AN6PkSj4FpzcFCM8LZFui8oDrkFqdXw1j
         OkmPIhl4vXNA9GaZziUWnHoU9ABSJ7sW1delARTL5LHxhWKnlgv4afwf9FnGFvhP4UGJ
         RZhhEpSDjfht/9H+ck7d9xtt1i3yV4mCCjjHoTQBoH+naSlwlOFU0M1S5RqAvMyyXfVv
         mQYA==
X-Forwarded-Encrypted: i=1; AJvYcCUlPzH1qPgCm7yGc1y6FanzR4lqvJikPFUNj0QiHSNRZjNOiaJexvqZ5zMkbOQhxjrMl7VQ4WMHR0XAUeQeduV4Z/Z51tw=
X-Gm-Message-State: AOJu0YzGtpJ9OvGDEJOqslJ7BtnBWTC3NPwWWT2FyJ1u1VWLuCuC6t8D
	l0LrDfEmWubnSVeDYJUSr4A96nBvXjn6xqhbI485CsLPkykE6w0nkIQMtIg8aEQ70y0N3IIQTys
	WGfnVWUh9zKlUHaevvAzGhO2nrk+GMSwZCAXk9Q==
X-Google-Smtp-Source: AGHT+IFxkkjp3fqK9lU0wtMgPlDRTY2Cd2wIkY8GxicXToEgBWVNk+WJY3GzgNmNfvvI5PceIdD3ucHY/8b9z28EL74=
X-Received: by 2002:a17:90a:b297:b0:2c1:948b:6f2c with SMTP id
 98e67ed59e1d1-2c27db5ce10mr3938026a91.39.1717616525310; Wed, 05 Jun 2024
 12:42:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1716578450.git.tjeznach@rivosinc.com> <7dcd9a154625704cbf9adc4b4ac07ca0b9753b31.1716578450.git.tjeznach@rivosinc.com>
 <20240603-d622cdac0016f1f854bf2b4c@orel>
In-Reply-To: <20240603-d622cdac0016f1f854bf2b4c@orel>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Wed, 5 Jun 2024 12:41:53 -0700
Message-ID: <CAH2o1u4mU2fs7p+J7pqeBSRRPb1SFZh=8UXzXCsJneTHMxVVgw@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] iommu/riscv: Add RISC-V IOMMU platform device driver
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux@rivosinc.com, 
	Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 5:59=E2=80=AFAM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> On Fri, May 24, 2024 at 12:34:42PM GMT, Tomasz Jeznach wrote:
> ...
> > +static struct platform_driver riscv_iommu_platform_driver =3D {
> > +     .probe =3D riscv_iommu_platform_probe,
> > +     .remove_new =3D riscv_iommu_platform_remove,
>
> Hi Tomasz,
>
> I think we should also support .shutdown (just turn the IOMMU off?),
> otherwise the IOMMU driver reports EBUSY and fails to initialize when
> rebooting.
>
> Same comment for the PCI driver.
>

I've been testing patches with added shutdown handlers, also looking
at reboot notifier hooks. In both cases, devices actively running DMA
traffic at system shutdown (eg. storage) might be affected by
too-early IOMMU disable call. This topic was already brought up in the
discussion [1] about kexec reboot flow.

In this series I'd prefer to keep the IOMMU active during shutdown,
and prepare the RISC-V IOMMU shutdown sequence implementation as a
separate series, as it will involve more risc-v reboot rework to
guarantee ordering of the shutdown callbacks. In a normal reboot
cycle, firmware/hardware reset should bring IOMMU to known
out-of-reset state anyway.

[1] https://lore.kernel.org/linux-iommu/059ae516-aed4-4836-a2ca-aff150ff428=
d@arm.com/

Best,
- Tomasz

> Thanks,
> drew
