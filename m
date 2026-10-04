Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613022EB0F
	for <iommu@lists.linux.dev>; Sun,  4 Oct 2026 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791129633; cv=none; b=hfCR3Yxnoy/4ECRvMwbVgcfMCxmkBfgW47EHz+OiEevLKgZHWsfw2sbR+NWFYmuFLNpRKvDlljCfyY+JMlrKZhn82B044eWOpPdmQQgxpfAR099ZfH3OXg7KP0OufQJL3F1bHR13f1mavSawL+MyMScLxrbwif3fzX16o8Lh9xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791129633; c=relaxed/simple;
	bh=1qxqRGuZsd6Q/A7zzHqTQFSsS7CyBp6sDda4381gZvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tck8/yn5eFRSu4M4dVX4isSYc29tFhx4pabHkUQlo1MfWdbV0Eha7tGWX/KUtP2mrrHfITr4xrqh6wa/FsE/Z+WW7lyCI133YiK5WoMmA6pZxCyxmv5Tt4a4IWVjKx1wxUIH+mzzYmUZHXb4i7KC1uijdwgCYG/J/NmTkMA0aP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkIZm9uy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkIZm9uy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE1A1F000FF;
	Sun,  4 Oct 2026 16:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791129632;
	bh=VCb84ciBziBuFEgWkk3pxEsWtbEPurNZKh4TU/I4vME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PkIZm9uyDFjfaKJ4T2So3TB3aZGs0sm2hatA8KPJOd5vDT/SC60Adwf6FO8v2QHpU
	 xDUk8Rpf7pypJp4CxKRkiPHajGlDzB65Z9rXiJC09wKdWPv1NHRHtKpL0sB3cKkd22
	 PgB4xVM0ovv483WE+LWNFHfoHHgjcLBUQlzT+oPIIFP25nTzVT6DcDv/+xq9b9yInn
	 O3nYHGrMGciD9QZ0SDAo6t7v4WWKO11pq8zrlyA8UQUQPsFUKwf72DiR1wKSUHK8fD
	 FmGb+yiIBZOOUvuIgrmLEfA1kya7Qdcr0+3DQr4O84vglu+GkxMzZoETMe1IYU8ICb
	 vNI/ba6YFHerA==
Date: Sun, 4 Oct 2026 17:00:27 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Align memory attributes for
 SMMU-originated accesses
Message-ID: <asJ4GwOnS_toKuaq@willie-the-truck>
References: <20260929032229.3532247-1-danielmentz@google.com>
 <ar2VWVTSo2NtJdHr@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar2VWVTSo2NtJdHr@nvidia.com>

On Wed, Sep 30, 2026 at 04:03:53PM -0700, Nicolin Chen wrote:
> On Tue, Sep 29, 2026 at 03:22:29AM +0000, Daniel Mentz wrote:
> > @@ -4858,12 +4867,20 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
> >  		return ret;
> >  
> >  	/* CR1 (table and queue memory attributes) */
> > -	reg = FIELD_PREP(CR1_TABLE_SH, ARM_SMMU_SH_ISH) |
> > -	      FIELD_PREP(CR1_TABLE_OC, CR1_CACHE_WB) |
> > -	      FIELD_PREP(CR1_TABLE_IC, CR1_CACHE_WB) |
> > -	      FIELD_PREP(CR1_QUEUE_SH, ARM_SMMU_SH_ISH) |
> > -	      FIELD_PREP(CR1_QUEUE_OC, CR1_CACHE_WB) |
> > -	      FIELD_PREP(CR1_QUEUE_IC, CR1_CACHE_WB);
> > +	if (smmu->features & ARM_SMMU_FEAT_COHERENCY) {
> > +		cache = CR1_CACHE_WB;
> > +		sh = ARM_SMMU_SH_ISH;
> > +	} else {
> > +		cache = CR1_CACHE_NC;
> > +		sh = ARM_SMMU_SH_OSH;
> > +	}
> > +
> > +	reg = FIELD_PREP(CR1_TABLE_SH, sh) |
> > +	      FIELD_PREP(CR1_TABLE_OC, cache) |
> > +	      FIELD_PREP(CR1_TABLE_IC, cache) |
> > +	      FIELD_PREP(CR1_QUEUE_SH, sh) |
> > +	      FIELD_PREP(CR1_QUEUE_OC, cache) |
> > +	      FIELD_PREP(CR1_QUEUE_IC, cache);
> >  	writel_relaxed(reg, smmu->base + ARM_SMMU_CR1);
> 
> Nit: this is a big function. Perhaps, cr1_sh and cr1_cache?

Yes, I'd much prefer that naming.

Daniel -- please can you send a v2 with that change and also cc lkml
so that Sashiko can have a look as well?

Cheers,

Will
