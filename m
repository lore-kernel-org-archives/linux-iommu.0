Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A123333A6E0
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781517103; cv=pass; b=AKmqYW0Zo/YsPiYkgqlpAnmpw+2x4CtyiTrqZdAlx+F7kVoR9k90AgtDSC+aLeTMhW5/dl0HqQytzczJJS2Z6fl4Mp2okq2DD5/gFUXMQtCajwxf8CVi1VWGUaLOVNdu13MPOxEpMXQgyubvFRIZC5WPUxSYJONqernYw3XrzAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781517103; c=relaxed/simple;
	bh=UA7T2VHNwKA5QLV+Q66VmDrOicG/9ucAXSdJXHCm4nM=;
	h=From:In-Reply-To:Mime-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ueG4Wi0ai8DMcFbQ/aWL4B3hxcWGEIbgkD8qC+0h0+4ErrhBWvUY00m5uaPlT3RSMFhBSv7zMiBN+pFQddLiijbrU/hM1sD4ijZ9n24YVQFxdTT6zd3GsTjHiGbUEWpo01sVYlhHZBvpyeck+vsipfK6AuTleVuHbIZ7qTjvGTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jPa3dwAx; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jPa3dwAx"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aa68cf9123so3091294e87.0
        for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 02:51:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781517100; cv=none;
        d=google.com; s=arc-20240605;
        b=EiQ1vzbrDVYhdbvl9YdKiyQ9gplSWuJvI3J/YbPYnvswKjlKPbl69g/QDhsgtXlQvb
         xJLX2T8i7ZcOjNqjWSc+H2jVpOSLFQKJJJu+yY8vkZzX/pMM0OpNLBonnjJnYwaBF/GH
         7hSrH/2PRwurJmel0YHAySPdaliYQTl61cUG5OTPnykE+JQPyWhHlKGRnM3/OdkWik7t
         V0AnRBaFeDOnDbdT4QC+FzWl3pamioSGO6oj+rjCwo+cCFAp40Zq1bSocu1auoHMyDRp
         qzj56fv5T0MvjbtD1pQlduTDetK0qV9B7SehW33rIvk+keI0SwWud5LPDxkPgG1uTPui
         iomQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:dkim-signature;
        bh=UA7T2VHNwKA5QLV+Q66VmDrOicG/9ucAXSdJXHCm4nM=;
        fh=C8J+4fyhClNXebtzS4Efc7+72djo2FqgfSHOOCjFDsk=;
        b=Lerkz9dU/LzHV1uV/O/DK0FAJELb0r386eG1sgYqyc0gKpmIfHjqkQ/il+diCfy/ng
         3tkeFPun/KLiAz/jQJFa3Eux+0FEggbwJlNDerMTRIUJsRQaI0Plp3bZ87tNcvgYH9oy
         +lqYRwv/yiO2ebPa/Xuxe1pA7/HvUhX+SNAbsX5C7rlIcDKECTiYtkoweG4Hrf379y/u
         RbXr0TQnEkc67qJl2V1YcAZKj+PaVN4NngUThqpDTgE15y4oYw0v4l/ktex4LlP2RBWp
         orzT40a3ZfCazTAedYmxmTQKBBlqHALHffrbLwLEfcl9MnAnjrSGo8GLMzjP6Ei2XGj6
         F7fQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1781517100; x=1782121900; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UA7T2VHNwKA5QLV+Q66VmDrOicG/9ucAXSdJXHCm4nM=;
        b=jPa3dwAxoeh/Ufi8wv/IVuCj5o1LZ61GhhxGj4DXzFhl/QWu0R3zf3/ow1HbaEV1C7
         oclkk6165ahxcB3bpNoihLJZUqZ0EeyPVOLNqzRogfEBrRIfvrHjtwRhaKIYh3V6dIfx
         WD6h4rUf2JgSg98/a2MG1vvQYMjrQ+a0CzaGXD69f2YfpnMoCvbyqLn9D7CvqNl45KFb
         a5f7XR1uRQ2H37K95Xn2lUJMAdOolTo4PdNUqbNuiJM40FgdAdTgudewjmnLTUf+qZ30
         FqG+5jx+HJzcsmTfCmqAYTIeMYGe2QNFh5e7R8RRbR/WX3dWMsITrOiK5zWEdiFUoWeo
         r1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781517100; x=1782121900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UA7T2VHNwKA5QLV+Q66VmDrOicG/9ucAXSdJXHCm4nM=;
        b=oc4Rz/5wLMM3sABhy8kWb5/0iY6M9Cvae3SPd3W8nMnkNN1FnZlX4IpSxPJfvW9Pxo
         UrsyecXX23GYk+r6n91Xavd2OeSR8CoCrb1TarSjkjF3Wx6/DECUIdGHyW6fh3h9aeH2
         2crqxKAuEBZ7+rgmFKAeXSXEZkH8r3dNCIdSDI87+kSJL3kz3EYyfjkbMwzg9RkWDGQp
         svn89XdriIQBX5tZON+SAkgaaBAsF0IykLvwXCyrVlTygPBv8IAuWFjl4G4/yES9KQHT
         Sc8JEdXQCc6YY7Pi9G24cYGNqvhVfWr/ufiO3qmVZjr7emBmO8wmoTceL7rj/vyGIvKJ
         Spgw==
X-Forwarded-Encrypted: i=1; AFNElJ+7lgvkdN5/S58RJEjfJgQeM7BKvhUmlkeBaZ0xUv675hAFM/IRYc2029R5vRISS7DZzHp0/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXtKql7gXdIRktUF6Uh47VOZBR8p/8SgK6PF64mnmB6a7u1Lus
	hi07p4lL4hP9AZtFMrjCd/tFnDnzt6TqARyjGa/TbHl5LHy1aj9WWrhts3zvf0RW2euXnqW0ZpR
	jBoGNsyMLicnahF9fDe37BB7gt5nupajXtnAD+tF4dw==
X-Gm-Gg: Acq92OGx4JjzG4iJZ+ZIYn7Nug8dzgplrcvd3dCdjQAf5yd8c+M84c2w5qxzOZ+4qct
	K1FJ9AMNRMwct5oMPBRJk/MfIDno/gpi2CMcokH+67M3mGAye+AVhJPh4/9d14TTfuKrVZKNMq4
	6KNx/QONh826m6QffCTGLLibkWi1uixaXx3iOphMRwwI61eVqSdh5mA0LF+rqKszmfB2392jJvy
	x/1/Tcm1BuDM4dj8L/SF0YVOAaBhChOQNXD+hY5G/gzFeMA/OOmCw1I8J31NKrqGwA3+LMWb5ai
	mBJwOhw=
X-Received: by 2002:ac2:504d:0:b0:5aa:6d0f:d74e with SMTP id
 2adb3069b0e04-5ad2db2c5c3mr2901982e87.3.1781517099521; Mon, 15 Jun 2026
 02:51:39 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 15 Jun 2026 02:51:38 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 15 Jun 2026 02:51:38 -0700
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
In-Reply-To: <mvmik7kz01z.fsf@suse.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com> <mvmik7kz01z.fsf@suse.de>
Date: Mon, 15 Jun 2026 02:51:38 -0700
X-Gm-Features: AVVi8CcbFKf2lv0-eBabLq4F7xR6J4TrpNcoqeWD2I2x6dzbxo4YYF_SeWHFlP0
Message-ID: <CACnXVnfr9DzKaXkRAP4zkKP61KG7=+iJ6+TZhBJ_vECrTZJpkA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v1] iommu/riscv: Support 32-bit register accesses
To: Andreas Schwab <schwab@suse.de>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Xu Lu <luxu.kernel@bytedance.com>, 
	cuiyunhui@bytedance.com, yuanzhu@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

For a generic kernel, the expected setting is to leave
RISCV_IOMMU_32BIT_ACCESS disabled.

If supporting such platforms from a single generic kernel is preferred, I c=
an
look into replacing this build-time option with a runtime indication.

Regards,
Zhanpeng

> From: "Andreas Schwab"<schwab@suse.de>
> Date:=C2=A0 Mon, Jun 15, 2026, 16:22
> Subject:=C2=A0 [External] Re: [PATCH v1] iommu/riscv: Support 32-bit regi=
ster accesses
> To: "Zhanpeng Zhang"<zhangzhanpeng.jasper@bytedance.com>
> Cc: "Tomasz Jeznach"<tjeznach@rivosinc.com>, "Joerg Roedel"<joro@8bytes.o=
rg>, "Will Deacon"<will@kernel.org>, "Robin Murphy"<robin.murphy@arm.com>, =
"Paul Walmsley"<pjw@kernel.org>, "Palmer Dabbelt"<palmer@dabbelt.com>, "Alb=
ert Ou"<aou@eecs.berkeley.edu>, "Alexandre Ghiti"<alex@ghiti.fr>, <iommu@li=
sts.linux.dev>, <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kerne=
l.org>, "Xu Lu"<luxu.kernel@bytedance.com>, <cuiyunhui@bytedance.com>, <yua=
nzhu@bytedance.com>
> On Jun 15 2026, Zhanpeng Zhang wrote:
>
> > +config RISCV_IOMMU_32BIT_ACCESS
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0bool "Use 32-bit accesses for RISC-V IOMMU=
 registers"
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on RISCV_IOMMU
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0help
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Say Y when the RISC-V IOMMU MMIO wi=
ndow cannot be accessed
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0using naturally aligned 64-bit load=
s and stores.
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0When enabled, 64-bit IOMMU register=
s are accessed as paired
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A032-bit MMIO operations. This option=
 does not describe an RV32
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel or a 32-bit IOMMU architectu=
re.
>
> What is the expected setting in a generic kernel?
>
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint =3D 0196 BAD8 1CE9 1970 F4BE =C2=A01748 E4D4 88E3 0EE=
A B9D7
> "And now for something completely different."
>
