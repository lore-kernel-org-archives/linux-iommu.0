Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E095223CE
	for <iommu@lists.linux.dev>; Mon, 30 Jun 2025 03:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751255497; cv=none; b=gcyldDcoaX5eBZYOONdfsizjf4Nk3UH4toMVJlTEPH6aaslryf9035xIvwTjY966NzxC0n1K86ZxyI+3pMfBruCAUW0uaA8n4RHRtXgzJiLpqMbhwW0ZaOajXgUK9CJXcZ/B/0UKDS5JXVKE7topimyw2mD2UZIlBDCDMSZd+tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751255497; c=relaxed/simple;
	bh=QTzyOXu5qu2K9jHAadeJSq39OHr964W9UaOXOneTV9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEkrq2aBkYKvIzjkVyA/flkFUZmjBLWPLfjoByXALHfogfl/BUuTYkHXti+6OtJuAb8ORlxcYKjeInyakRfLT8JxVdtaJdiWweMyz7kA0lx0xvo+QZuNIhuI3YO4BdscaTyWoi7/51xomm2qyHP2CAbYZHtHeusNwDGxCj3Tirc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=et83bIzQ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="et83bIzQ"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-747c2cc3419so3877145b3a.2
        for <iommu@lists.linux.dev>; Sun, 29 Jun 2025 20:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751255494; x=1751860294; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UED82EXPvvwcKwvtCpX0i6qazNmJqZIAw5hRVMYvLpc=;
        b=et83bIzQnfnvTILpaMpXC9mIgjfxvHwRKpfe22316BxGEFV3w+xqwEhoHDHy7UBqS3
         Hta6hcuaUSkpNDq5nE25NPDZsf2SJzgP9xGBCd14pB0h40rSVQw0C1U3KrXIubzDKfQu
         Aw1EJru8xo+NB+O90o7+vQkYy9NxnlOxS4b2YoENe3d8uGdljjY++FOwtFacsH6CQTVO
         36OxV9oZXPiPetx3+zuoUq8uo++Lg3fMUTVPoewT5IzfZY3Bh/rtWjqEhTdzqYUhynp+
         wiDyYzi9ifaXVWkfAaFPKWZWwkYsVuCjweDRVbBea2h8neGAWyu1AlUYrfkszbxD87Mq
         yEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751255494; x=1751860294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UED82EXPvvwcKwvtCpX0i6qazNmJqZIAw5hRVMYvLpc=;
        b=D3lt8DNbJYCHO3l5WuMUvDET+7IX3Tn3/uzGut6dRsYSBdjRXUlyCc7yP9r+78P9HK
         1rWj5W+HPQ4YjSnbCXf5EJt8Ziz9nkp5kQMvurdqdPBCcnB1stnzTJY5P44yj/9v4qHj
         InJDJ8t8C7IuwXgskM6HpQ1LazBBNigx9UBnNrfxQ+qktJPRZvcVhxsaRgGXFOpQWKgO
         fhTOGJjbHYFKvg/jQyq7PdRDaBdRzvukEFxAqfiXpuZ2/mHv2UD8VRth3uc+p/5LsLWl
         jVGH7lmfgCJnEY11FdqYaI0kelxsWVhYCzbF/Jvdg1MrLdNmXaQMw3zOkmKaFsVmqdxf
         f3Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVZkBR8Uj2XBedAUrU8YMG0vj45C2yBnVcgCAqNpsJ2Ga1kOI6WvVDxhzuAlWaMuxKEVqwe4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJz2N9w96ZpTQrSuQiYLhN8Giax72Fiu5Nc06kfsni6/Ya5Hdk
	Y+UyaSvCbVz4FF19NR9N5O31GgL3z4W42mOksyPoMpMF/n26bNclNwKdZFmGweoFLjg=
X-Gm-Gg: ASbGnctH7CiX/czuzLbUl0EzM8FucQq01uqXiLTdWSRhMO0sXup7WbBObQ/6v7fgO1M
	6XFOZ0ElYjIKAXDSKNZFAVY4SOsPq9c1ARXY7mW5VZrFrjkpepQloWHgYL17Lg+Hq9849yHtgbm
	IUeUC4UV62JpPnMtPUjcYJoRLr8AUMouLafS1klFt4PSU4qeaiErXWViZlngvcY0fqw4xYOD9N1
	5t8+Jrbe/peiahFqihxwAuV0kqlLaia3jWYm4y40Jln++vgCGeDHay7dyV7+OVbiKJ3YgIh8KhV
	spYw3aUaSZCEN7PgCYOejITPFIp+GkFflq1WbQt4eY7VQzTx4DrCrtCXGIDBCIpM5xiP4g==
X-Google-Smtp-Source: AGHT+IH50RyHuOnxZl2ccwGVqZn5SetEZq+s0+V/7t4N3nC29VesI3/CLLW5Bs7mTAzZWQEnHHyh/A==
X-Received: by 2002:a05:6a00:1704:b0:749:bc7:1577 with SMTP id d2e1a72fcca58-74af6e6618emr15035867b3a.9.1751255494141;
        Sun, 29 Jun 2025 20:51:34 -0700 (PDT)
Received: from sunil-laptop ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af557b5c8sm7808043b3a.83.2025.06.29.20.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 20:51:33 -0700 (PDT)
Date: Mon, 30 Jun 2025 09:21:22 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev, Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v3 0/3] RISC-V: Add ACPI support for IOMMU
Message-ID: <aGIJuiSuZs17DSiM@sunil-laptop>
References: <20250630034803.1611262-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630034803.1611262-1-sunilvl@ventanamicro.com>

Hi Tomasz,

Could you please help reviewing this series?

Thanks!
Sunil
On Mon, Jun 30, 2025 at 09:18:00AM +0530, Sunil V L wrote:
> This series adds support for RISC-V IOMMU on ACPI based platforms.
> RISC-V IO Mapping Table (RIMT) is a new static ACPI table [1] introduced
> to communicate IOMMU information to the OS.
> 
> [1] - https://github.com/riscv-non-isa/riscv-acpi-rimt/releases/download/v1.0/rimt-spec.pdf
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
>  drivers/acpi/riscv/rimt.c            | 523 +++++++++++++++++++++++++++
>  drivers/acpi/scan.c                  |   9 +-
>  drivers/iommu/riscv/iommu-platform.c |  17 +-
>  drivers/iommu/riscv/iommu.c          |  10 +
>  include/linux/acpi_rimt.h            |  26 ++
>  12 files changed, 599 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/acpi/riscv/Kconfig
>  create mode 100644 drivers/acpi/riscv/rimt.c
>  create mode 100644 include/linux/acpi_rimt.h
> 
> -- 
> 2.43.0
> 
