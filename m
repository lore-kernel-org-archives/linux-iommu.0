Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D52421C9E3
	for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 15:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679635; cv=none; b=G7s8MbJbK6k/l1l0wfv9erHAr3pVyWvtP1o+Ciz9nYai49dCpxyEvO4Gr8cIw+FH0wgwG14vg3x6GEu7hPcADfwVgh3jb3NAkS5tgAr9+qLSxRhae/Q5g4BCGzeghFSm7QSvSleeNipD31c3ScPEsg9rU4FfsXLS/0vcw8nHc2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679635; c=relaxed/simple;
	bh=c9K3Jeyllh9acXj8/pMhkma1YgpPHnE/1br2gKtyXNY=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=V8Z8oebEzmJYO1fb4g1qW3lCqZayyagj86t5yshLOh/z5Ed3dQiu/G1nCXYB6dWiOyZfVB+1DJcS+9IFD9f9T4NCqG/c6QGSvPEz6LvAsq7GzrFl6JQ5eZXO0xF7n6i6Ka+q7S/NJM1IURYxe7klIAxCZ/KwHcQe6lKinJ1Ui+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=llWrEqcd; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="llWrEqcd"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-74b52bf417cso70014b3a.0
        for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 08:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1752679632; x=1753284432; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DLHXWx3e4qVyWFktNcTinbMTNqw3Gsd0ZZ2hzOlFYG4=;
        b=llWrEqcd+mRW8PZUuqjEInuoqvbHz243OxkBYYxixzc5T2LTxQS6k6vHHjG6X7R7rs
         NSUKoubmSudkvkvLlwFihGVWf2CZcYUax64a91GvGAOVSmsSxLWIMw4w8r1wnFeJxWkY
         +i0HaQyGoltBiWtAN3g7oP2GguzqPKDbaL/Zz/0+B6feXQ019BDBixEnkmLATok3Ig+A
         /excMNKmavzcYDqP5tCCxn/q56LY8IDtEyHHitlQXZji3ot+hkwTXBsbDPlqrEdcA8Gi
         0TvkJn+BU63pATzYs0j1O0tvc0hvZrNPmGU0eMK11PEJW7p6/F0S4XIDbQN0prQOY6B4
         rTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679632; x=1753284432;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLHXWx3e4qVyWFktNcTinbMTNqw3Gsd0ZZ2hzOlFYG4=;
        b=Gv8lDTsvSFyKcFPsvHh7OPkTshd7foGWYDSvdf689iJvN6veeimyFfE8guvJ0a/tVv
         +cSteB5OWeEF0Y7kzuysi9uYooHLqwi21QgjM3q+v4p844c3bBySTvebMBT4ngcn/JzN
         Z0hr7gx+NKyefkNamNM22D0kNHEXR0RYMw0al3ZndQUFa3kCTfD6jl6OfdtTBYOsI/2/
         MChd7MKL6u9jfhXLXAEpBJQJn1gZFvIYEbyjptcF7ekpFrCFFCBdcPPW2HLrI9QZA/O7
         Wx1AveAttzAJQeVcWUY4ugWhU4suoMBlOG2JXiKklt2ev/hncnWnz5zA4LudO01Rz59n
         wU8A==
X-Forwarded-Encrypted: i=1; AJvYcCW3z484iDd8yiGVt+ZM6fYtNR7nah+Ht1jPewQNNP/JyAGwR1+GdapcjUD68N1dGn4gOLXwLQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJmBg7EGb4m2iNk26X82stV22bsC3IGCwUl7eRe1tMmlYslh74
	i85O8zI/JtLkLz8osNubrirdIhhIx546CfxIByjIlC/OBKsSojSd5mQG7fE9JKn2pRA=
X-Gm-Gg: ASbGnctILzZefDuRbLw32tOUxUvw1ewx/fZq1k+6MqqjC/fczSNDTw1xsLesbqir1W+
	az7Wwd7hUXKVBDmX1CdCpYTymJ2b8tA0Z9r0baJF75/tS7OeD/Q4jeJ2+gitBv7FmIloHm6a6Bk
	wCbliu1wv8iPa09EXEUZMOD8VxJLDX6By6geeMH5hqVM3Z/VCE3n0YYyqUoZa9Hooiy/IlnMEC6
	LloClb3KiqciBsGcTZVqRJUZL6lSxx11dq/SCkxJm0LjkpM6tp6kwWr8rH0VxqAuNy+cGVRivBe
	zEZtlVoICQGPKfMAjZA05ZlpYu1LQqlnokK3ZdAgvZL4jkx1zfkx/xcbG3OfX9I3OrYKVUf6Lmc
	1QmfghxyuyWi7Fhfd2lXN
X-Google-Smtp-Source: AGHT+IH7iBG8I47ZPk3kjc8DlfJqKS+H6u2KneCpl6yYfAutQXIcMVrF/w+WWdKN0EwIATcq6Y7GTg==
X-Received: by 2002:a05:6a00:22d0:b0:748:e0ee:dcff with SMTP id d2e1a72fcca58-75723d7d2c8mr4843826b3a.11.1752679632185;
        Wed, 16 Jul 2025 08:27:12 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::4:b02a])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74eb9f22c01sm14929679b3a.101.2025.07.16.08.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:27:11 -0700 (PDT)
Date: Wed, 16 Jul 2025 08:27:11 -0700 (PDT)
X-Google-Original-Date: Wed, 16 Jul 2025 08:27:09 PDT (-0700)
Subject:     Re: [PATCH v5 0/3] RISC-V: Add ACPI support for IOMMU
In-Reply-To: <20250716104059.3539482-1-sunilvl@ventanamicro.com>
CC: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
  linux-acpi@vger.kernel.org, iommu@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>,
  Alexandre Ghiti <alex@ghiti.fr>, rafael@kernel.org, lenb@kernel.org, tjeznach@rivosinc.com, joro@8bytes.org,
  Will Deacon <will@kernel.org>, robin.murphy@arm.com, Atish Patra <atishp@rivosinc.com>,
  apatel@ventanamicro.com, ajones@ventanamicro.com, Sunil V L <sunilvl@ventanamicro.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Message-ID: <mhng-E714E5B9-0828-46CE-B890-9AE61C2E341D@palmerdabbelt-mac>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 16 Jul 2025 03:40:56 PDT (-0700), Sunil V L wrote:
> This series adds support for RISC-V IOMMU on ACPI based platforms.
> RISC-V IO Mapping Table (RIMT) is a new static ACPI table [1] introduced
> to communicate IOMMU information to the OS.
>
> [1] - https://github.com/riscv-non-isa/riscv-acpi-rimt/releases/download/v1.0/rimt-spec.pdf
>
> Changes since v4:
> 	1) Rebased to 6.16-rc6
> 	2) Addressed Anup's feedback on formatting.
> 	3) Added RB tag from Will and Anup.
>
> Changes since v3:
> 	1) Rebased to 6.16-rc5
> 	2) Addressed Drew's feedback on v3.
> 		a) Reordered calling rimt_iommu_configure_id().
> 		b) Removed unnecessary inline.
> 		c) Added pr_fmt.
> 		d) Removed redundant rimt_iommu_configure_id() stub.
> 	3) Added Drew's RB tag in PATCH 3.
>
> Changes since v2:
> 	1) Rebased to 6.16-rc4
> 	2) Removed Anup's SOB and link tags added by mistake in v2.
>
> Changes since v1:
> 	1) Rebased to v6.16-rc1.
> 	2) Dropped ACPICA patch since it is already available in 6.16-rc1.
> 	3) Added Rafael's ACK.
> 	4) Fixed few issues found by bots.
>
> Sunil V L (3):
>   ACPI: RISC-V: Add support for RIMT
>   ACPI: scan: Add support for RISC-V in acpi_iommu_configure_id()
>   iommu/riscv: Add ACPI support
>
>  MAINTAINERS                          |   1 +
>  arch/riscv/Kconfig                   |   1 +
>  drivers/acpi/Kconfig                 |   4 +
>  drivers/acpi/riscv/Kconfig           |   7 +
>  drivers/acpi/riscv/Makefile          |   1 +
>  drivers/acpi/riscv/init.c            |   2 +
>  drivers/acpi/riscv/init.h            |   1 +
>  drivers/acpi/riscv/rimt.c            | 520 +++++++++++++++++++++++++++
>  drivers/acpi/scan.c                  |   4 +
>  drivers/iommu/riscv/iommu-platform.c |  17 +-
>  drivers/iommu/riscv/iommu.c          |  10 +
>  include/linux/acpi_rimt.h            |  28 ++

Thanks.  Anup came to the patchwork meeting this morning and asked me to 
pick it up.  It only barely touches arch/riscv stuff so I'd figured it 
was going somewhere else, but happy to do so.  I've picked it up into my 
staging tree as

    *   e5efe466d9bd - (HEAD -> for-next, palmer/for-next) Merge patch series "RISC-V: Add ACPI support for IOMMU" (2 minutes ago) <Palmer Dabbelt>
    |\
    | * 368ed89f7ac9 - iommu/riscv: Add ACPI support (2 minutes ago) <Sunil V L>
    | * 0d7c16d0df92 - ACPI: scan: Add support for RISC-V in acpi_iommu_configure_id() (2 minutes ago) <Sunil V L>
    | * ea35561bc965 - ACPI: RISC-V: Add support for RIMT (2 minutes ago) <Sunil V L>

it should show up on for-next assuming it builds and such (it's behind 
some fixes, so might take a bit).  Happy to do a tag if someone wants, 
just let me know...

>  12 files changed, 595 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/acpi/riscv/Kconfig
>  create mode 100644 drivers/acpi/riscv/rimt.c
>  create mode 100644 include/linux/acpi_rimt.h

