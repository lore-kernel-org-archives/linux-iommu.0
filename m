Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C09D1CB33E;
	Thu, 24 Oct 2024 13:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775361; cv=none; b=byYvuPq2mmCrD9gGzIHQtl4sF7jcqxkCmlCwcsDivOBH6W1JheaPmyoRX3gnxBQ/g5h3+N8fmUDAIZnzIxOThjttqw274GylErp5iuxETOZtYdTUH1VhooV3kd08vjgCNfwKI3+OqfxqsBz77fy4uiDUzRaopOhR8Dxud2Q30EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775361; c=relaxed/simple;
	bh=nb17tpFBEr4PRv+4HRivZY+/kDVAsGeu50KxgyQfFtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJTV6BkSLhlyhfTHLcXy7K1uCib+LZfItuYKXpDu9eznmaynFxhhunB/e3Balpt3Z/lGOhxjRQRwaQCFcBBG+QSmV43QPHsBoQhRY5BetsaK+Nbysu+arGIq3jyOjFUzX0aC9hEIZO47FhcJfUgZeDHt0jTYX4H/8QfrAgLYl5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+DhenBA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+DhenBA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EEBC4CEE6;
	Thu, 24 Oct 2024 13:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729775361;
	bh=nb17tpFBEr4PRv+4HRivZY+/kDVAsGeu50KxgyQfFtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+DhenBAKevA2lfvMQCT080RR15CYZlFd2OBex6DKPZSr3GlSJCnwVUvC/6MZpWav
	 atJeLaRqsLRsSbOgLmN9Dwjf2ik8vwDpRp/O2qkRL1ypA9TJFHhSJ6h8jjxZDcFSNG
	 kosMIC5Nt2BjAK39z4huh/7xjQKN1UF+X9TaSIx2RzTMCcK4amX66HejnuWydxomkS
	 tbcx3hdsDo7hWfeHHv4iP83Eroipu8AnnLKrEHA8HBRWMKBa0D7ZgyVHMJXogENKhG
	 bOMXwfdLhlWJfJnsnCEUJI8F29OJIMRSnnTlT+rmub7IRRCGCPO8hD4eNxXQAYyk1W
	 Y69zdtfXGdQ9Q==
Date: Thu, 24 Oct 2024 14:09:15 +0100
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
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Subject: Re: [PATCH v10 0/7] Linux RISC-V IOMMU Support
Message-ID: <20241024130914.GF30704@willie-the-truck>
References: <cover.1729059707.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1729059707.git.tjeznach@rivosinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Oct 15, 2024 at 11:52:12PM -0700, Tomasz Jeznach wrote:
> This patch series introduces support for RISC-V IOMMU architected
> hardware into the Linux kernel.
> 
> The RISC-V IOMMU specification, which this series is based on, is
> ratified and available at GitHub/riscv-non-isa [1].
> 
> At a high level, the RISC-V IOMMU specification defines:
> 
> 1) Data structures:
>   - Device-context: Associates devices with address spaces and holds
>     per-device parameters for address translations.
>   - Process-contexts: Associates different virtual address spaces based
>     on device-provided process identification numbers.
>   - MSI page table configuration used to direct an MSI to a guest
>     interrupt file in an IMSIC.
> 2) In-memory queue interface:
>   - Command-queue for issuing commands to the IOMMU.
>   - Fault/event queue for reporting faults and events.
>   - Page-request queue for reporting "Page Request" messages received
>     from PCIe devices.
>   - Message-signaled and wire-signaled interrupt mechanisms.
> 3) Memory-mapped programming interface:
>   - Mandatory and optional register layout and description.
>   - Software guidelines for device initialization and capabilities discovery.
> 
> 
> This series introduces RISC-V IOMMU hardware initialization and complete
> single-stage translation with paging domain support.
> 
> The patches are organized as follows:
> 
> Patch 1: Introduces minimal required device tree bindings for the driver.
> Patch 2: Defines RISC-V IOMMU data structures, hardware programming interface
>          registers layout, and minimal initialization code for enabling global
>          pass-through for all connected masters.
> Patch 3: Implements the device driver for PCIe implementation of RISC-V IOMMU
>          architected hardware.
> Patch 4: Introduces IOMMU interfaces to the kernel subsystem.
> Patch 5: Implements device directory management with discovery sequences for
>          I/O mapped or in-memory device directory table location, hardware
>          capabilities discovery, and device to domain attach implementation.
> Patch 6: Implements command and fault queue, and introduces directory cache
>          invalidation sequences.
> Patch 7: Implements paging domain, using highest page-table mode advertised
>          by the hardware. This series enables only 4K mappings; complete support
>          for large page mappings will be introduced in follow-up patch series.
> 
> Follow-up patch series providing MSI interrupt remapping, complete ATS/PRI/SVA
> and VFIO/IOMMUFD support are available at the GitHub [2], and has been tested
> with published QEMU RISC-V IOMMU device model [3].
> 
> Changes from v9:
> - rebase on v6.12-rc3
> - #6 Memory ordering fix and updated commentary, based on Will’s suggestions.
> - #7 Remove riscv_iommu_device_domain_type() and use head-less kfree_rcu in
>      riscv_iommu_release_device(), based on Jason's suggestions.

Thanks, looks ok to me now.

Will
