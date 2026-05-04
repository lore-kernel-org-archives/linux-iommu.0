Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60672DEA9B
	for <iommu@lists.linux.dev>; Mon,  4 May 2026 08:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883064; cv=none; b=L3vGYrKcpq6UnbCdWKFrJsOlTukBPb6HzJasCInCKWNiExgIMmWIJKvP41wXuVxTdPWGPbnAc/fg9Hr4eMuCfzX66YHg4R2FUlrhcQgInQyc80IuRzQ8+YiHziklcegPk33AYW++CyY+NbbpNsCZ8ynMf5NYZKomvsPlCjy3FNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883064; c=relaxed/simple;
	bh=1/x1xg/non2py27rzK6b+gVZw2iF2synx6ct0jKU1Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpYS4la98KTD8trghUcHGSInFXgLScytU54Kl7hNhLlymbPHWiqsqWzFQI5GCPypkdsv/2y4VVqLbORry27UybSe/8TNB7fO9sjMVPHKjaqi1WNssgMZBDDgxm9CBaU9i1UhfrEVuD/CMPqiBoe+F4rPxvcQGD2MkFFcpG+FKY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=YWOWzRT3; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="YWOWzRT3"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D50071C2E5E;
	Mon,  4 May 2026 10:24:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1777883054;
	bh=1/x1xg/non2py27rzK6b+gVZw2iF2synx6ct0jKU1Xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YWOWzRT39wtgCdKQ+csv2gf3OMeu9qEymtWiUzz2jJwd3ZwTdTU9G56IrT7vDPiEr
	 F1jFLWgfmbs7mAFG3W/+ZxQWCF4hhszsOJ37P8hDuxmWQKhNgHLA+M15mSV4A45sI/
	 tpmLA/lqFl0K9RSS3kAxQYN19x3e9QXgkuRoc3qxV9D4FtnQhYLS5VcvdkrVRCWT0c
	 fHBg8aFG8/M864rZlh07hbRLcZYmtcZevJz33QMD7qGu+ETVPZknnsNZmItZe9Et49
	 ZvLllHzkR/wKp5pA5eEBz9HEdkob5NJfR0FqIRGdTPVbxbc7zhI3/zQAb7w3VPOd/k
	 ZFBG6/3QAl1Fg==
Date: Mon, 4 May 2026 10:24:13 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Sean Christopherson <seanjc@google.com>, 
	Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Explicitly bail from enable_iommus_vapic()
 when in legacy mode
Message-ID: <ozdrdhmeltkc7ctg756agk4xcvjm43hf3lfl4slrbcxidjlaom@ta6g6fkzvr4q>
References: <20250315030928.2373250-1-seanjc@google.com>
 <adQ8JeCu4c1dzpL8@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adQ8JeCu4c1dzpL8@google.com>

Vasant, could you please have a look? I'd prefer a review from you or Suravee
before applying.

Thanks,

	Joerg

On Mon, Apr 06, 2026 at 04:05:09PM -0700, Sean Christopherson wrote:
> On Fri, Mar 14, 2025, Sean Christopherson wrote:
> > Bail early from enable_iommus_vapic() if IOMMUs are configured for either
> > of the legacy modes, as it's absurdly difficult to see that
> > iommu_ga_log_enable() is guaranteed to fail because iommu_init_ga_log()
> > skips allocating the ga_log.
> > 
> > Opportunistically have iommu_ga_log_enable() WARN if it's called without
> > IOMMUs being configured to support AVIC/vAPIC.
> > 
> > Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  drivers/iommu/amd/init.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> > index cb536d372b12..05c568da589a 100644
> > --- a/drivers/iommu/amd/init.c
> > +++ b/drivers/iommu/amd/init.c
> > @@ -931,8 +931,8 @@ static int iommu_ga_log_enable(struct amd_iommu *iommu)
> >  
> >  static int iommu_init_ga_log(struct amd_iommu *iommu)
> >  {
> > -	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
> > -		return 0;
> > +	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
> > +		return -EINVAL;
> >  
> >  	iommu->ga_log = iommu_alloc_pages(GFP_KERNEL, get_order(GA_LOG_SIZE));
> >  	if (!iommu->ga_log)
> > @@ -2863,8 +2863,10 @@ static void enable_iommus_vapic(void)
> >  			return;
> >  	}
> >  
> > -	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
> > -	    !check_feature(FEATURE_GAM_VAPIC)) {
> > +	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
> > +		return;
> > +
> > +	if (!check_feature(FEATURE_GAM_VAPIC)) {
> >  		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
> >  		return;
> >  	}
> > 
> > base-commit: ea9bd29a9c0d757b3384ae3e633e6bbaddf00725
> > -- 
> 
> Another ping.  This too still applies.
