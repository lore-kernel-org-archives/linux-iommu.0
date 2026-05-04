Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EB03290BA
	for <iommu@lists.linux.dev>; Mon,  4 May 2026 08:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883087; cv=none; b=AhaGyWH+FMd1YoYlw7Qim1v/u6B+Vc9zIsyumkZRmsG1Q/1srMpHm1AcItzF2LiiBYhpeR7gKNJUQ6ORGGFUtvZSJVOZqlO2PafMGxlC0Hbit1eSRP6OQFeteDRU+tYm1Z6VTjtUy+0PxUSaBj8GyIcHYSGRAgQVsL9NiU0YzGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883087; c=relaxed/simple;
	bh=wNWoDZbqRfywB+tXH4MywVMIE06FpbX05RLZdjBbQyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9YsJ45U6icQ1S4fCvFoZED5fX3+kCsUtTVFGyfqEG9L37ryXH8DVXsrRO0o/Ac0I4HhtGeBlx2Q9lyUEc2JF5NuYcEnl2i4OyDVUPgrJbNqpaVv3H+/txr1FrueeGLkNUMtaLYop1HvyywvJ+e5cdTrpCxOOj6WsUiaClHEcPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=1ZXidYIk; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="1ZXidYIk"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 07FA61C2E5E;
	Mon,  4 May 2026 10:24:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1777883084;
	bh=wNWoDZbqRfywB+tXH4MywVMIE06FpbX05RLZdjBbQyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1ZXidYIkO2dKn6tTMo2zsdJva+wCUHpWstWcx2RofzUoIey+isyMJSWJJmkfwiU2a
	 A5wNJZGnOZ3uJoR2UxB191xE3gbVmx7/IXQpYXSBY2GDQApumUK52MbkyaVvp37z6n
	 OazrsFrE3agny1/xONPhGUy0nEJWurFmgnSPAagMQyngoXyt0a4U8GU6ZJyuCE60K4
	 3zeAesuwdThcF71QZGji9AHrb3qrrseKoJ9qe2wI3Tt0HAs2aCTi1tqCSLozxO0fTJ
	 vu7OC1bqzf9/Sqgd/dUwvF2ct384Vv4eEyjoGP3Q9k/UxT2l8IOX+QtMBgMCAydIdV
	 w0yEpTi42cjfQ==
Date: Mon, 4 May 2026 10:24:42 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Sean Christopherson <seanjc@google.com>, 
	Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Fix a stale comment about which legacy mode
 is user visible
Message-ID: <lxutpsg3h4oakreatknf6zh4p5fb6iy7jzbnhxjzqq2glhxdpk@t3rs3to746b6>
References: <20250315032148.2377902-1-seanjc@google.com>
 <adQ7x0FMmo4FG26t@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adQ7x0FMmo4FG26t@google.com>

Vasant, could you please have a look? I'd prefer a review from you or Suravee
before applying.

Thanks,

	Joerg
On Mon, Apr 06, 2026 at 04:03:35PM -0700, Sean Christopherson wrote:
> On Fri, Mar 14, 2025, Sean Christopherson wrote:
> > Update a stale comment about which of the legacy modes is visible to the
> > user, i.e. can be forced via amd_iommu_intr=legacy.
> > 
> > Fixes: b74aa02d7a30 ("iommu/amd: Fix legacy interrupt remapping for x2APIC-enabled system")
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  drivers/iommu/amd/amd_iommu_types.h | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> > index 23caea22f8dc..f7877abd0091 100644
> > --- a/drivers/iommu/amd/amd_iommu_types.h
> > +++ b/drivers/iommu/amd/amd_iommu_types.h
> > @@ -968,12 +968,13 @@ static inline int get_hpet_devid(int id)
> >  }
> >  
> >  enum amd_iommu_intr_mode_type {
> > +	/*
> > +	 * The legacy format mode is not visible to users to prevent the user
> > +	 * from crashing x2APIC systems, which for all intents and purposes
> > +	 * require 128-bit IRTEs.   The legacy format will be forced as needed
> > +	 * when hardware doesn't support 128-bit IRTEs.
> > +	 */
> >  	AMD_IOMMU_GUEST_IR_LEGACY,
> > -
> > -	/* This mode is not visible to users. It is used when
> > -	 * we cannot fully enable vAPIC and fallback to only support
> > -	 * legacy interrupt remapping via 128-bit IRTE.
> > -	 */
> >  	AMD_IOMMU_GUEST_IR_LEGACY_GA,
> >  	AMD_IOMMU_GUEST_IR_VAPIC,
> >  };
> > 
> > base-commit: ea9bd29a9c0d757b3384ae3e633e6bbaddf00725
> > -- 
> 
> High latency ping!  A year later, and this still applies cleanly :-)
