Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A3C2DAFB0;
	Tue, 16 Dec 2025 14:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765893860; cv=none; b=bzucwlNCTTBLKFGyBRrB+IxWiXlHANyUs8mWkVGFwP969Zgqhmg7+j0O05m0hImhthwyMZfIsPpa450qBDak7Sqw3HI4cjYmKbX/Omc+HkS6e8yqykUDGj4XVWB5vEH2/MMGXuf2RkoE7nbKJn8TQodDLDd0ewHg3S4MPp/8pHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765893860; c=relaxed/simple;
	bh=58kCUG+qa4JrAMyX3VzLyBbTrzgS194mbP/4vxF34os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TR+btU/Exhq9wIUw2IJavVIjpjHTA8m4z/9i23aTt4CaTC8p5rSB3q9xU+sXlyJm8gGaHh7N36jgICLjJ0JmczyRpLurJUYSAQnwZ6y1vJ9EDxR0geOgmWcMuTMgE6Uk+atZnnehJvldM0Zl0EHUi4LVcl9lCSaFzYgxzyxVnLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E14EAKwp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E14EAKwp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ecQwlIPIEEMHq+TlA0ByuO477sNp6SzZcL6O+91ZGv0=; b=E14EAKwpFV46Ri2BNWch58rp31
	+CkrtrYgr/Oxignf0HxEnkl4iUCkeiaV4cHipWFGGU3Y2VDoh1GvyJ88doAjm0gXGbVybwztUs84X
	oQftqBtzNrUvImpopFHagTLMhbDVn7cD1WpmV2Xw+dUWBsRdIYJIWmkX5d38BeAHPhRJ8z0InsL0u
	jpEHxFK/7QBu8WMkPVrYi+H+dtFand8+uqyrvaIj6t+JrJK92pmSkkWAnnuHJ3rDTiB1bKco2hUH4
	xhhIck1d5HEf+dre2Q9JqAuthY4I0od4/pnP/4raIJfCW0j61G3ME822342HmH6nPMmmMGiU13sQ9
	xXRV/30w==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVVet-00000003Msn-0Fmj;
	Tue, 16 Dec 2025 14:04:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 947A2300339; Tue, 16 Dec 2025 15:04:10 +0100 (CET)
Date: Tue, 16 Dec 2025 15:04:10 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
	balbirs@nvidia.com, miko.lenczewski@arm.com, kevin.tian@intel.com,
	praan@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based
 arm_smmu_domain_inv_range()
Message-ID: <20251216140410.GV3707837@noisy.programming.kicks-ass.net>
References: <cover.1765850465.git.nicolinc@nvidia.com>
 <f4261c5b30ce3c6942470433033d4933ec5eef3e.1765850465.git.nicolinc@nvidia.com>
 <20251216090926.GR3707837@noisy.programming.kicks-ass.net>
 <20251216135613.GB6079@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216135613.GB6079@nvidia.com>

On Tue, Dec 16, 2025 at 09:56:13AM -0400, Jason Gunthorpe wrote:
> On Tue, Dec 16, 2025 at 10:09:26AM +0100, Peter Zijlstra wrote:
> > Anyway, if I understand the above correctly, the smb_mb() is for:
> > 
> >   arm_smmu_domain_inv_range() 		arm_smmu_install_new_domain_invs()
> > 
> >     [W] IOPTE				  [Wrel] smmu_domain->invs
> >     smp_mb()				  smp_mb()
> >     [Lacq] smmu_domain->invs		  [L] IOPTE
> > 
> > Right? But I'm not sure about your 'HW sees the new IOPTEs' claim;
> 
> Yes, the '[L] IOPTE' would be a DMA from HW.
> 
> > that very much depend on what coherency domain the relevant hardware
> > plays in. For smp_mb() to work, the hardware must be in the ISH
> > domain, while typically devices are (if I remember my arrrrgh64
> > correctly) in the OSH.
> 
> The '[W] IOPTE' sequence already includes a cache flush if the
> inner/outer sharable are not coherent. If a cache flush was required
> then the smp_mb() must also order it, otherwise it just has to order
> the store.
> 
> The page table table code has always relied on this kind of ordering
> with respect to DMA working, it would be completely broken if the DMA
> does not order with the barriers.
> 
> For example:
> 
>             CPU0                         CPU1
>    store PMD
>                                         read PMD
>    store PTE 1                          store PTE 2
>    	     				dma memory barrier
>                                         device reads 2
>    dma memory barrier
>    device reads 1

But here you have dma_mb(), which is dmb(osh).

> The 'device reads 2' thread must be guarenteed that the HW DMA
> observes the PMD stored by CPU0. It relies on the same kind of
> explicit cache flushing and barriers as this patch does.

OK, but then please include that in the comment, because using smp_*()
barriers and talking about devices sets of alarm bells.
