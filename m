Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D74E1991D9
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 06:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729061942; cv=none; b=OJ/tzwSfQD9nT1lrKs886U3D0bHmxvkB2K7Kvo/kKBada8LGyLx1P1GLVIsldRq3jge7Q5Fim6aLlfVZz/HSng84fgjJ+kyC8pAeDhMe6zxUR1IESoc3doqceu//XB8Y+Ucq2pNkCFh+MaI2vQlEPyvqEsT/OMYyvtO55IClIKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729061942; c=relaxed/simple;
	bh=GgqhkQIww3EnUduiJMY68fYIYly68qVF8vVZyUZJznY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MDamaR89F0NWuNivOk7ug5Db2yMQHOpJdZdlamxC+HGlfbP5nsn2BC8N4oxx7UB6zskm3BvgE/EJ0rbUCq/WOFZtdZzaN/eopCZOvJl9Ps5Rco/TDj2Y3Qs9pVvuasMFMb9nCmxTbt0mKdHYVlVIUgF/Av3htp1lyuefoAMdtsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dEw3Onfk; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dEw3Onfk"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a3b4663e40so28475875ab.2
        for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 23:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729061940; x=1729666740; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgqhkQIww3EnUduiJMY68fYIYly68qVF8vVZyUZJznY=;
        b=dEw3Onfkl9pg68jLU0XTz/7UvhmU+NvoFOBO+RSYNhQBsxLVyUcg/DWlAPCfp8txgX
         eXJQGMPvW2+HUPH737oPQ1605eSUzIJ8l3jpfbVmwYVEtePaZvaXRrAsslfLdmllUnHR
         LfDNmFm91K7ZmzVc/7CcVMYL66bFPC/zB75Hp8eadQ5Bl2G9FnMxKNdTaLg/OwwBWU8Q
         Dggw3J6CX+93L4+dKPIqfxF82NqJlJSzT/N6G57TfY7ZRb6dw0SB2WWW38tBvJS+PtPM
         tCdzQ1H2cNs0lUz7n27p+RwoTuocB5lkP/Y3Cp6uB+r56VhDYeGKgr2ErBnrr1GnSSh2
         Effg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729061940; x=1729666740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgqhkQIww3EnUduiJMY68fYIYly68qVF8vVZyUZJznY=;
        b=rqKSGzbN0WQxy/950huBemm+fcdFGmV3waatSd+M4wQmH2oo/AXoPNtoqFsRl5ktFS
         7ovuabD/GwrUPMy0yLELyxiRtWkHuiUqRgldKpVr5JZuAq9JitKLeGIeEOfdPetNjUV9
         aLcPcpOE2tn+CZ4ao9lbAk9lD27ph0tcgu51uKj4AWLJa/niRr6UPwiVDKEvfnTeeho7
         0OLSWZOOH9Lu0m9VfPVuh7s6dAXLb1dkQyrhBeNHDW6BcoItrohGcUhz1y5sXc3XSdxL
         kHhVfowtqxn/Ne1FSgJDjkeef1Iqbx8XChcFNFDgZsHsGp1Rp4SXmaas/ZP99rk5TW55
         O4Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVa+xuzjYMlBfykzJBMfG1an1tfzduZR203tNTJzh20XceOlbqwATy/1hraHcKJaZhLNUFnuQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGxM4tc3MuK5Mg/CpuUMZOf1e14ZkpV7D8tqlajgKhsF37L6sD
	q7jtSadOvviUZM4k1zvMD40zZOQ3PV0kgXnXbQn6nHQAVcZEjw1/88S+N90xocEsqyrkZ8yCTDo
	TZQdDy3L5T3uJIbXPJ5ridUk/K/IVgyoAZ1mJMA==
X-Google-Smtp-Source: AGHT+IErhSKXVFLT/FTSTbt5YKWJYoMqeAPP9Z85ar2ZS+Bbj8qfmYFetiQos0G6hD7PlYuMWAq/MbtzSisSbfzWG1w=
X-Received: by 2002:a05:6e02:1385:b0:3a2:7651:9864 with SMTP id
 e9e14a558f8ab-3a3bcdc6befmr119191555ab.12.1729061940262; Tue, 15 Oct 2024
 23:59:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1728579958.git.tjeznach@rivosinc.com> <Zw4s3BHQZ6x4d79-@8bytes.org>
 <20241015085945.GC19110@willie-the-truck>
In-Reply-To: <20241015085945.GC19110@willie-the-truck>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Tue, 15 Oct 2024 23:58:48 -0700
Message-ID: <CAH2o1u5UMQHvaNNUgKQk1e97c03ntuJALUTaW7gYaCuyfY471g@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] Linux RISC-V IOMMU Support
To: Will Deacon <will@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, Nick Kossifidis <mick@ics.forth.gr>, 
	Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 1:59=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Tue, Oct 15, 2024 at 10:50:36AM +0200, Joerg Roedel wrote:
> > On Thu, Oct 10, 2024 at 12:48:03PM -0700, Tomasz Jeznach wrote:
> > > This patch series introduces support for RISC-V IOMMU architected
> > > hardware into the Linux kernel.
> >
> > Thanks Tomasz. I plan to merge this driver into the IOMMU tree if no
> > further objections are raised in this thread by Friday.

Thanks Joerg. I'll try to address any remaining issues asap.

>
> Sorry, bad timing on my part -- I just left a couple of questions/comment=
s
> after Drew poked me at LPC to look at this.
>
> Hopefully we'll get those resolved asap.
>

Will, thank you for your valuable feedback.
Hopefully v10 addressed those comments.

Best Regards,
- Tomasz

> Will
