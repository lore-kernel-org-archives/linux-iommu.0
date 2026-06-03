Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6EB3ACF1C;
	Wed,  3 Jun 2026 11:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780486395; cv=none; b=TAqAXtOMxcHenbmlQEiGajQFjiYGEoFnOLBLh3hDfUoR0qoGbm5It6sTqME2Eis9hfsj3N/FI9zGfBkrYcNmBKiE8ac5gqjcxVybWZZ22q9sEiY7Hoy5LnTO3Pn/6XO72qf9jnQz1BRrbkoOBTIe0n8sZ5U5APb5FtMm7LQ/xxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780486395; c=relaxed/simple;
	bh=u6jUYj7y4NaO1gbsSFiVHqcOdZdTA+D3BPzwX/5Kr+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1CDmBvgYyTYEq02XPUGDUTjv6rmPaUzlfj43MisQuAyKchEEF5qgQ1cuZPY4JDiiV+YG+6El5BAqeYyWRSzsGJ6gayIwAH0rZTskXC/HWfhu2RmgwjVt0Eg+gSb7ETN70o8c6WQJ3S5mzSMTy/UkzJljBCVtDn0kzax0Qq0ZCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYj1Oeat; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYj1Oeat"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9447B1F00893;
	Wed,  3 Jun 2026 11:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780486393;
	bh=wt4VB2QZ6kXZPvpRMEsc2JhePzg9ZBinVTHuJtUj3Fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YYj1OeatXLCV484XdUCXX8zzbFZDAk0AtrrE6hgwJQ8DzJK7D76B0qw7jOrJF12VM
	 leOB2ngCeC3I0clPplWVqhF0YGGOHJz5yfEXUsRB0vVgmdCG5M+5j6jaPVfDQLqYgy
	 ogjDZ0b6o0TDkKu2O3v0trPsRByLa8DIgtPGEYkG7b0BHjGqwsToSfQCcyV0xh3HsY
	 VywuBg0i2QIs+AGpxVq7B6ELKLkapHZFy7OlBd0gaBrr4mL4dU6l0aKga6lGyX2u+a
	 oxP5jlR0G+nbx8GpaOjKGvG0tONdvRortEnDkLPcQhN6WLYcB2J9KdnrRh7oSRecIR
	 HVTCeD50+H2KA==
Date: Wed, 3 Jun 2026 12:33:08 +0100
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Ashish Mhetre <amhetre@nvidia.com>, robin.murphy@arm.com,
	joro@8bytes.org, nicolinc@nvidia.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Issue CFGI/TLBI twice on
 Tegra264
Message-ID: <aiAQ9ApqfTsdweRg@willie-the-truck>
References: <20260601104845.995005-1-amhetre@nvidia.com>
 <20260601104845.995005-4-amhetre@nvidia.com>
 <ah87dzHOOTNGBBmt@willie-the-truck>
 <20260603010114.GO2487554@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603010114.GO2487554@ziepe.ca>

On Tue, Jun 02, 2026 at 10:01:14PM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 02, 2026 at 09:22:15PM +0100, Will Deacon wrote:
> > > +	/*
> > > +	 * On Tegra264 (see ARM_SMMU_OPT_TLBI_TWICE) re-issue the same
> > > +	 * cmdlist with another CMD_SYNC to satisfy the erratum.
> > > +	 * Callers must ensure the batch carries a uniform opcode class
> > > +	 * so that checking the first command is enough; the iommufd
> > > +	 * VSMMU path enforces this with arm_vsmmu_can_batch_cmd().
> > > +	 */
> > > +	if (!ret && sync && arm_smmu_cmd_needs_tlbi_twice(smmu, &cmds[0]))
> > 
> > Can you move the arm_smmu_cmd_... part to the start of the conjunction,
> > please? If you make it a static key as I mentioned previously, then
> > hopefully that should mean everything else is moved out of line.
> > 
> > > +		ret = __arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);
> > 
> > Sashiko is also unhappy here if n == 0 because we probably shouldn't
> > be inspecting the command array in that case.
> 
> That seems like an AI mistake though, we shouldn't actually ever pass
> in 0 sized batches? 'zero streams' should fail probe, not get into
> this code, that might be missing but I wouldn't add checks here..

I was wondering about the case where the first command in a batch is
unsupported. Can we issue a bare sync in that case?

Will
