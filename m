Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D33284B4F;
	Thu,  6 Aug 2026 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020452; cv=none; b=lATfHQ6GTGaU/RjUbKPW401W090Tgw2Byo5JX1RMyZB8C8ptrUB+RUhE1JQR3qGMS9Erpd9IeKfHzUsDhJK57HkKU/nvxibHrX339oho3tDr6AcqzTWSTG7VxMN3S1i+/BOwI5X7yn4RsACmEjbkXR3qHI/iqVnLZ5m0Co6Rebk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020452; c=relaxed/simple;
	bh=I+fdENFWe3sXZFsezoAv+93k3fULySOQz/762exVSBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEnepz9ZH96uAnb2OTok7KjDTFlMQ0CTNEi7tPm+OCdYT1gtC+9CySPpJ6vsIRIuUMrQ2RmJVfGdSnm9aRKo0NoEIogzT8drTW0z3brTj8kWrqINsws28ouKvdcXI0ZenPwEv56NlO5Q4W4g5HCDGU/QmgazB1XsLZyPmd+YkxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgkoqYVo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgkoqYVo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E021F000E9;
	Thu,  6 Aug 2026 12:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786020451;
	bh=gaxlKJGTsZngzdaWcyP0O7FUrV3KkW/yE5t2F7iml8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GgkoqYVo2ffsadHBiZ95EO4eOAW64JMlxzI9/C1I8pgBeuGIOuq6b5+hO3ZtpiK3V
	 Rg9VWVNiu8I5TVq7dlTV/kUE8cwy/C6+b/ohOoQuEDYlc+oHg7Y/WBcSK+vsC+klfp
	 P7WlegvBHxB8v6mgFm5wDVO7O+qFp/ktqh6jblHhuaDkxlUHV2ITJfGuBYNcMLFbxx
	 aeG+Irh0fNIqZvIFDMs30W/FqrK+hz2iD4FMtvcgeiPGlc9hAaOHACjffhyTbyvay1
	 FZNGZOAiIecdnbOBSA5Dhw1t0oW7i07iyYJ8hzahAcNcYD5PLokpHErIfTafXS6C+I
	 aAZKhvGgAQ9MQ==
Date: Thu, 6 Aug 2026 13:47:25 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/tegra241-cmdqv: Reject a VCMDQ base above the
 48-bit hardware limit
Message-ID: <anSCXUjivdb_aOv_@willie-the-truck>
References: <20260729220329.805417-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729220329.805417-1-nicolinc@nvidia.com>

On Wed, Jul 29, 2026 at 03:03:29PM -0700, Nicolin Chen wrote:
> tegra241_vcmdq_alloc_smmu_cmdq() allocates the VCMDQ buffer via the common
> arm_smmu_init_one_queue(), which uses smmu->dev and its coherent DMA mask
> of DMA_BIT_MASK(smmu->oas). An SMMUv3 queue base holds a 52-bit address in
> Q_BASE_ADDR_MASK, but the VCMDQ_BASE register holds only 48 (VCMDQ_ADDR),
> so the masked write "q_base = base_dma & VCMDQ_ADDR" silently drops bits 48
> and up. The HW would then fetch its commands from a wrong memory location,
> which likely raises VCMDQ errors.
> 
> Real hardware always pairs an SMMU OAS with a matching VCMDQ address field,
> so this cannot happen; it takes a VMM that gives a guest a mismatched OAS.
> Nor can the guest rely on the VMM to catch it: an SMMU CMDQ base keeps bits
> 48 and up in Q_BASE_ADDR_MASK, so a trapped CMDQ_BASE write still carries
> them, while a VCMDQ base goes straight to the hardware and loses them.
> 
> Reject a base_dma with bits set outside VCMDQ_ADDR, the way the user-VCMDQ
> path already does for its base_addr_pa, failing the queue init rather than
> silently truncating the base. Use dev_warn_once() rather than WARN_ON(), as
> the OAS is VMM-controlled and a WARN_ON() would let it panic a guest booted
> with panic_on_warn.
> 
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---

This still just sounds like something that a VMM shouldn't do?

Will
