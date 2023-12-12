Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E728561690
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSemSIX0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082AAC433C7;
	Tue, 12 Dec 2023 14:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702390228;
	bh=Mgf9tmDd9obDgc8sUwhx24QZ/UIZ542eteF5w4D0TZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KSemSIX0AGgLz4topDgQARmfUIqtZuYAEz3Eq2iqANC7zs9h2PAPkcpjDn1nGAVZe
	 kjAYzJgEx06UAUPRvEnSeme6qHrAHhIpOqpbP4Vn+PsXXQZ2qjTwwJYcJYPZIhR/pZ
	 09UgYVZO4dgvrLnX77uebCzvo1byNKTpSUxlvg9RfQ9Y4h72l7odEHGuzgn9ScOUj7
	 6qK29O1ZRGqaPZJxf22Zb+pJkR2Y249P+nB6h2pwo4GHCmJqhYRIYtFuoUcYN4wpob
	 MJyF/cs9hDOk/5SNeAkwSvR5Yd8ZdwWZM986+RhlRUlx6RkRIiiLpcf1jX4oE6vRSl
	 xBShp6LPMPuag==
Date: Tue, 12 Dec 2023 14:10:23 +0000
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 5/5] iommu/arm-smmu: Convert to domain_alloc_paging()
Message-ID: <20231212141023.GA29699@willie-the-truck>
References: <0-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
 <5-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
 <20231212132651.GA29569@willie-the-truck>
 <20231212140307.GD3014157@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212140307.GD3014157@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Dec 12, 2023 at 10:03:07AM -0400, Jason Gunthorpe wrote:
> On Tue, Dec 12, 2023 at 01:26:51PM +0000, Will Deacon wrote:
> > > @@ -862,6 +859,18 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
> > >  	mutex_init(&smmu_domain->init_mutex);
> > >  	spin_lock_init(&smmu_domain->cb_lock);
> > >  
> > > +	if (dev)
> > > +		cfg = dev_iommu_priv_get(dev);
> > > +	if (cfg) {
> > > +		int ret;
> > > +
> > > +		ret = arm_smmu_init_domain_context(smmu_domain, cfg->smmu, dev);
> > > +		if (ret) {
> > > +			kfree(smmu_domain);
> > > +			return NULL;
> > 
> > If we're just returning NULL, can we drop 'ret'?
> 
> It is waiting to be changed to ERR_PTR. The dependent patches are
> merged to rc5 now, so I can fix it in v3.

Sorry, I missed that. You can leave it as-is, since my SMMU branch is based
on -rc3.

> > > +		}
> > > +	}
> > > +
> > >  	return &smmu_domain->domain;
> > 
> > Why do we need to handle the 'dev && !cfg' case here, instead g
> > returning NULL?
> 
> dev && !cfg is impossible these days, so we can shuffle the if and
> then just crash on that case like the other drivers do.

Thanks, that would simplify it a little.

Will
