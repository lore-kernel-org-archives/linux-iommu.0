Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C33D7BAE3;
	Mon,  8 Jul 2024 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720439012; cv=none; b=c/4QRHGjPUX50nFfOvQMFvE5EjRnHrCJwoXPsezYcOwhZRjk/PjpvVSYTisq57kyZqx2CNS3p8sQU0nDnHGB6048ICHkdewa4h2Jo1mmayVJONSDcBWK3njaexrj14vPE3DB9/xLh+0X1piXL4ZIWnWSonaK4w5ldEGKQIF8gxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720439012; c=relaxed/simple;
	bh=2HJqA3UYL1Y6HCS7ga10SfSmRMoaswl1N5DsLcp+awg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDX9LvK+W8Tt0fmoeDhXyuyAc6ONUFe3oMwTQ6VCBwOUpwYhik2a3v077HriRlmWueFU7GeaVHFY50WihR19RSOdA2rQZEFUP0Sr+z8GMRA1+2NFMW1WfHXzac4lJn8CVjqitASZM+e7AZcYQXlCl9tpgYJGOUsU7sWhWoyhsoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLILdPZZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLILdPZZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A21C116B1;
	Mon,  8 Jul 2024 11:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720439011;
	bh=2HJqA3UYL1Y6HCS7ga10SfSmRMoaswl1N5DsLcp+awg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uLILdPZZOLFeAvb3zjcq4ZCNtiL5hYMwZevVlpPdqQdZ180LyImyrUUEvInyRHLhi
	 xjUyiTYDq6FJr3WgD4r/E0BjaBQJzib0qxQUieTaDRNNPCZOrH5jba1Dp8nuQTlkh8
	 vgOTI0NBWMASGF71p9X3tzEujI3KEmiFb34y19UO57NtHcSqTRrSlmt8RKPuhGXoEx
	 sF0EC7fybGftpoO4isux/zjh2woHTnJePC+vXhe7dtSL54p4pXwc6ngDDHy+zffWIB
	 LEQtpu2mP9S4ZLmRtHaW0Cj5xZ77EcfH35we+t7X+l4OAn3kV9aBmleGTonYuhW+hl
	 iRMBJaC8mVVdg==
Date: Mon, 8 Jul 2024 12:43:26 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v9 4/6] iommu/arm-smmu-v3: Add CS_NONE quirk for
 CONFIG_TEGRA241_CMDQV
Message-ID: <20240708114326.GE11567@willie-the-truck>
References: <cover.1718228494.git.nicolinc@nvidia.com>
 <d20dc9939523fac490bc02e57d7836f680916a36.1718228494.git.nicolinc@nvidia.com>
 <20240702174307.GB4740@willie-the-truck>
 <ZoREzIAqzyamQBWL@Asurada-Nvidia>
 <20240702184942.GD5167@willie-the-truck>
 <ZoRZP4k1A3G7nH9q@Asurada-Nvidia>
 <ZoReq/kNi368x79q@Asurada-Nvidia>
 <20240705152721.GA9485@willie-the-truck>
 <Zog3IgdmYRU7VbJB@Asurada-Nvidia>
 <20240708112928.GB11567@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708112928.GB11567@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jul 08, 2024 at 12:29:28PM +0100, Will Deacon wrote:
> On Fri, Jul 05, 2024 at 11:10:42AM -0700, Nicolin Chen wrote:
> > But if you insist on having an smmu option, we still have to take in the
> > PATCH-3 in this series, enforcing an arm_smmu_cmdq_build_sync_cmd() call
> > in the IRQ handler too.  So, it would eventually look like [attachment].
> 
> With my hacks, I think you can just call arm_smmu_cmdq_build_sync_cmd()
> from the irqhandler and it will work.

Hmm, actually, that will mean we end up using MSIs for the error case on
hardware which supports it, which is a strange change in behaviour.

What does your hardware do if it sees SIG_SEV in a CMD_SYNC? Is it just
a case of failing to generate the event on completion, or does it treat
it as an invalid opcode?

Will
