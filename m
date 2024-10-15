Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B53E1CACC9;
	Tue, 15 Oct 2024 08:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982252; cv=none; b=AOTZkAnSt9kmx3gKThsu0A+Dk1s2lAsPwzkYF+m8+6CQOryBeZVbQCDV6zURQdEZWPU/dr3cgSH/tQZUovva5WsvF1mKyaGVEVGw6/R6b8xMS9Lbq5BYB7AmnKePqkZa4fx/XXKnzcQ4tMMK9sK9eIziAnV8jFTOpCLx9SjAarE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982252; c=relaxed/simple;
	bh=eKCHhGW5lPuKziFFhV0/ls1DKJ+Sz8/SY2/HjTb/qrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpqzRo+bdlwkdW0D8MAd3KCByEgU/7vllGyH4vu28ltPOQ+Tjhto/IwAXipnxKw69RSj2Ifr1SNBlm7HvZkIr7Krcb0mHS9FNwmSNExch4ybFd3NmHCbUBaannluoTtbit7qLmkveMjH78OL8xnB1a75wzYSrGBZ4dEbpDZXxjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smF9Oos3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smF9Oos3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95AC3C4CEC6;
	Tue, 15 Oct 2024 08:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728982252;
	bh=eKCHhGW5lPuKziFFhV0/ls1DKJ+Sz8/SY2/HjTb/qrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=smF9Oos3+kGx+7D6m1ZdXYJXM1lQqJUKRtOl/3m7++sDE0VOmcQSvlRiHyu09fv5j
	 XyXo0GtEqqAHGi3kq9WzKEjMtVenLWj/8bk4r+z84N0MctIgSFUDfjTVyE5jiTgX6W
	 Pu6lfGno6N4MFnM3LhJryA21Ehy+vXiko9qoUyTRYisHwjuc0gf4IgyxrT1w6yjf02
	 HaeQ5VOqZtlLEr12WUtNx12Jjh0vRLI0/ELYhrHY/fAJN4yEeRyh4/SDLjvsDKYSHV
	 4NwFKMJF2Gm4KX2s81hD/imv07yAjwW1Gzl86yeg7VJ0IS1z0CQYDInTq51oSw8MDn
	 iwAmj0YZted9Q==
Date: Tue, 15 Oct 2024 09:50:45 +0100
From: Will Deacon <will@kernel.org>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@rivosinc.com,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v9 2/7] iommu/riscv: Add RISC-V IOMMU platform device
 driver
Message-ID: <20241015085044.GA19110@willie-the-truck>
References: <cover.1728579958.git.tjeznach@rivosinc.com>
 <b8da2b00aec3f7b4b2e3a7cc194f7961bf656f24.1728579958.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8da2b00aec3f7b4b2e3a7cc194f7961bf656f24.1728579958.git.tjeznach@rivosinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Oct 10, 2024 at 12:48:05PM -0700, Tomasz Jeznach wrote:
> Introduce platform device driver for implementation of RISC-V IOMMU
> architected hardware.
> 
> Hardware interface definition located in file iommu-bits.h is based on
> ratified RISC-V IOMMU Architecture Specification version 1.0.0.
> 
> This patch implements platform device initialization, early check and
> configuration of the IOMMU interfaces and enables global pass-through
> address translation mode (iommu_mode == BARE), without registering
> hardware instance in the IOMMU subsystem.
> 
> Link: https://github.com/riscv-non-isa/riscv-iommu
> Co-developed-by: Nick Kossifidis <mick@ics.forth.gr>
> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
> Co-developed-by: Sebastien Boeuf <seb@rivosinc.com>
> Signed-off-by: Sebastien Boeuf <seb@rivosinc.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---

[...]

> diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> new file mode 100644
> index 000000000000..700e33dc2446
> --- /dev/null
> +++ b/drivers/iommu/riscv/iommu.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright © 2022-2024 Rivos Inc.
> + * Copyright © 2023 FORTH-ICS/CARV
> + *
> + * Authors
> + *	Tomasz Jeznach <tjeznach@rivosinc.com>
> + *	Nick Kossifidis <mick@ics.forth.gr>
> + */
> +
> +#ifndef _RISCV_IOMMU_H_
> +#define _RISCV_IOMMU_H_
> +
> +#include <linux/iommu.h>
> +#include <linux/types.h>
> +#include <linux/iopoll.h>
> +
> +#include "iommu-bits.h"
> +
> +struct riscv_iommu_device {
> +	/* iommu core interface */
> +	struct iommu_device iommu;
> +
> +	/* iommu hardware */
> +	struct device *dev;
> +
> +	/* hardware control register space */
> +	void __iomem *reg;
> +
> +	/* supported and enabled hardware capabilities */
> +	u64 caps;
> +	u32 fctl;
> +
> +	/* available interrupt numbers, MSI or WSI */
> +	unsigned int irqs[RISCV_IOMMU_INTR_COUNT];
> +	unsigned int irqs_count;
> +};
> +
> +int riscv_iommu_init(struct riscv_iommu_device *iommu);
> +void riscv_iommu_remove(struct riscv_iommu_device *iommu);
> +
> +#define riscv_iommu_readl(iommu, addr) \
> +	readl_relaxed((iommu)->reg + (addr))
> +
> +#define riscv_iommu_readq(iommu, addr) \
> +	readq_relaxed((iommu)->reg + (addr))
> +
> +#define riscv_iommu_writel(iommu, addr, val) \
> +	writel_relaxed((val), (iommu)->reg + (addr))
> +
> +#define riscv_iommu_writeq(iommu, addr, val) \
> +	writeq_relaxed((val), (iommu)->reg + (addr))
> +
> +#define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, timeout_us) \
> +	readx_poll_timeout(readq_relaxed, (iommu)->reg + (addr), val, cond, \
> +			   delay_us, timeout_us)
> +
> +#define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, timeout_us) \
> +	readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, cond, \
> +			   delay_us, timeout_us)
> +
> +#endif

Curious: why do you need these MMIO wrappers if the driver depends on
64BIT?

Will
