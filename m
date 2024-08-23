Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3427A1898E6;
	Fri, 23 Aug 2024 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427503; cv=none; b=C6veEBxYuisg2eqQClj6xz6ZlHImA0iH+dssb0Yx0MrW3avjXHedwjBu0LrYMlYGYp6T+X6WvP5TvOcqWBFJ4enOe4Y7GqMQboRHFStjDQZjy45P2BxdXWAtc+/CT3jD7UO1tF+jjYGBcj/DCNJ0qGaR/PqPB206vgLDZfgLAcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427503; c=relaxed/simple;
	bh=TUhLtJM5z1zGvHrEysAkReld+ihxjVhW/piAzl9hP7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UT3+h6sN1FCcq6uuW6KShBhGVZkgA5hMJksOa5WLqO7X9MGKLS/cFcuaS8M6CEjsuQ2VrWXuaEEuT9QZx066x0oZAYod4KxsXlOEGOe1eg1IHjT7mIepHBfCfxV+/x0p6qdDf+VilsW1F2z3umvtcG2X5i/xVLquj08QZwLjIhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SC+4p7ON; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SC+4p7ON"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB05C32786;
	Fri, 23 Aug 2024 15:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724427502;
	bh=TUhLtJM5z1zGvHrEysAkReld+ihxjVhW/piAzl9hP7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SC+4p7ONKFvnTuz12BMk94KSdU7cYNnfoqaCeyWHLZY/jHZOpjGk3QGzVeQRnWpco
	 9Reii7bU69+NfLqcChbcl/I+eIwP/rLGAmZ9X3yyxhxsYrHD9aAqzyCyZPk6+OfXHP
	 eevtpkJI+36DcOrI+tL8Rrq5csc0J6eAW3mOiuWw/WrZSplCsV3e2aut78jDNVxljX
	 gPLphAnlKV3bauia7WyTILHCkyz5JzJXGtYp2ZN4jwwYEzt7HO2g4EsNiEzJQNkEfA
	 wrZHk82+C3pOg4jMPei5fim0Q7HkRu6PruXeRl8vgYe6Q3fqZoOqklAE7oHze3rpzr
	 Vh4JP603X/IRw==
Date: Fri, 23 Aug 2024 16:38:17 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v11 8/9] iommu/arm-smmu-v3: Add in-kernel support for
 NVIDIA Tegra241 (Grace) CMDQV
Message-ID: <20240823153817.GA525@willie-the-truck>
References: <cover.1722993435.git.nicolinc@nvidia.com>
 <849c17b97ae0a38db1cee949db2488e4045666df.1722993435.git.nicolinc@nvidia.com>
 <20240816141926.GA24676@willie-the-truck>
 <Zr+PMiRKCYPgkB+1@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr+PMiRKCYPgkB+1@Asurada-Nvidia>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Aug 16, 2024 at 10:41:06AM -0700, Nicolin Chen wrote:
> On Fri, Aug 16, 2024 at 03:19:26PM +0100, Will Deacon wrote:
> 
> > [...]
> > 
> > > +struct arm_smmu_device *
> > > +tegra241_cmdqv_acpi_dsdt_probe(struct arm_smmu_device *smmu,
> > > +                            struct acpi_iort_node *node)
> > > +{
> > > +     struct resource *res;
> > > +     int irq;
> > > +
> > > +     /* Keep the pointer smmu intact if !res */
> > > +     res = tegra241_cmdqv_find_acpi_resource(smmu, node, &irq);
> > > +     if (!res)
> > > +             return smmu;
> > 
> > Given that this probing code will end up running on non-tegra hardware
> > when CONFIG_TEGRA241_CMDQV is enabled, please can you move the common
> > part into the main driver?
> 
> You mean moving the tegra241_cmdqv_acpi_dsdt_probe() into the main
> driver? I think this v11 puts a function call int he header already.

Right. I basically want it so that !tegra folks don't have to open
the tegra-specific file to look at the code running on their SoC.

We should also running that code at all on implementations which _do_
advertise a distinct model number in IORT.

Will
