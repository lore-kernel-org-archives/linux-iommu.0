Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B252AD04
	for <iommu@lists.linux.dev>; Mon, 28 Apr 2025 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745839231; cv=none; b=oCA+pO6fyX8KqjquGC0Wk8yIUr3/bsHa1L3nXN63ZJ+5/bbkTJHDA+ZtpHXFk5yc6IXiHzMNWkTaGG8Le5aTdz1MkfVbcO1d5xQZRgb1jU5EqxQneqJqbMYt6Ss5u1HR49xU0RI3KnSXZwpL2Rh2HiHZru04oGtUsScBXvn2zHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745839231; c=relaxed/simple;
	bh=HVqnScGTXGgERyMunahXa/BwgWxQI2co+xWQMd1xiME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ysnc7WlN+rXmuhufwWu76uPU8tJj5gOSWJsSWmkhCpTZJ3V2+UPZv//EAuLCGX7oJu2sV4IEdjulwqOHHggKsQ26u2vBQc/3PUPJ9mmGeukCQBR4YeTuHmQSkvccJdf6C1cPg2FiErgWoC+J/q37yXpJWbfSQqGmwtaTda48QQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=IZFzGS/d; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="IZFzGS/d"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id DCA8149621;
	Mon, 28 Apr 2025 13:20:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1745839228;
	bh=HVqnScGTXGgERyMunahXa/BwgWxQI2co+xWQMd1xiME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IZFzGS/d7QuFeo7nFTZ6kE2Fx3acNo1TRL4gG1x05K5/kEXI9wNVf8Jfeqdze+ddb
	 oPY+FrIMgxwVwoBM9AUzyenxbvQLx93o0kS3F+gCbGhIJi6VEim3RjEsvzs5DdD42a
	 I/9GKgYDYySWZ9+eCOkCF2tFs2HjCCjWx+zENL0opNLe3d+2Oqwn6v5pJEoEjKLa55
	 /akAzSLdggejTH7QGQepKBBa8lkzduFt46SPHYRC95sIrGWTEYoEg3FMNF+mb1FUNW
	 aNHRqiRd+mpHUKIfw7J2Lbk47NDyv2ffV7v+Xk8vx9hAbAITG2X+K9LLc/aiq0BVo0
	 NZI8OSMOoQ3uA==
Date: Mon, 28 Apr 2025 13:20:26 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Will Deacon <will@kernel.org>, Magnus Damm <damm+renesas@opensource.se>,
	Arnd Bergmann <arnd@arndb.de>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: ipmmu-vmsa: avoid Wformat-security warning
Message-ID: <aA9keotHp257k1cS@8bytes.org>
References: <20250423164006.2661372-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423164006.2661372-1-arnd@kernel.org>

On Wed, Apr 23, 2025 at 06:40:02PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> iommu_device_sysfs_add() requires a constant format string, otherwise
> a W=1 build produces a warning:
> 
> drivers/iommu/ipmmu-vmsa.c:1093:62: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
>  1093 |         ret = iommu_device_sysfs_add(&mmu->iommu, &pdev->dev, NULL, dev_name(&pdev->dev));
>       |                                                                     ^~~~~~~~~~~~~~~~~~~~
> drivers/iommu/ipmmu-vmsa.c:1093:62: note: treat the string as an argument to avoid this
>  1093 |         ret = iommu_device_sysfs_add(&mmu->iommu, &pdev->dev, NULL, dev_name(&pdev->dev));
>       |                                                                     ^
>       |                                                                     "%s",
> 
> This was an old bug but I saw it now because the code was changed as part
> of commit d9d3cede4167 ("iommu/ipmmu-vmsa: Register in a sensible order").
> 
> Fixes: 7af9a5fdb9e0 ("iommu/ipmmu-vmsa: Use iommu_device_sysfs_add()/remove()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.
