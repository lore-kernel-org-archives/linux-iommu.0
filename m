Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDF424E4AD;
	Wed, 23 Jul 2025 11:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753271780; cv=none; b=JQv+gjJ/d12upSexgFbntlJcvTjzH6TF5pE/wblbpjreW93NGRtUUKpufKTSCflusDj1Hc9f0DUSxEkq+rceN5I4xv/12m9YwFpyQZWWeViNqJbWPyfccs/qaicHstZNf7VcloVkzLv1x+llETA4I+IrK8uUZD+M1sIs6OMsJpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753271780; c=relaxed/simple;
	bh=y3nr7RZUVahFDTb34es/Jbn0WuEODsBUR4BjEWifwl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBvsIa1P8PJI3a6H2lBMPAQz+SRF27YXDs+Uu5Kbr+m7E2iwUNLOsOS5TbYUho0NVhk79Pntvp8Q+JdxmejdG34n/e6gWtzAPom4CF104u/dbpqOE5Rr7l4sf7Cvisz9oq58I4AhdPnE9VRDbdsuprVCa30/vJ7SdsI0sFI1ZDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLuixiBX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLuixiBX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2166DC4CEE7;
	Wed, 23 Jul 2025 11:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753271779;
	bh=y3nr7RZUVahFDTb34es/Jbn0WuEODsBUR4BjEWifwl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LLuixiBXCstvaIUarWp+mA8Gx7dbTLNmGpXV9ykv0OL95ehm9jEgHSCLCYgypI3+T
	 +6s2DWDP6DHIWmTOFJ2iIA+qNzte0puFfgQUE04SvyZspJY7BhFXwiwcNajjL0ryue
	 yf5/ztlpNlUwyDpfMCEtqPlwtNLhFXRRQsDQD4B5xm9TCHvQrPmQqxPwMu5FN7mR0v
	 jfislG4HdznNi0IhbmtgwPIvnPcm7HyCM4//oUOAbQ2hGK8UjkQtCQCgRZbeZWifEy
	 kg5wR3qPMKnMKhxmNm6LsvEyCXAJpYyn5/WOpZwP9pQXLcTKKVLmmRPy/6VcfCVUut
	 p9sxlNsr5D6fA==
Date: Wed, 23 Jul 2025 12:56:14 +0100
From: Will Deacon <will@kernel.org>
To: Seyediman Seyedarab <imandevel@gmail.com>
Cc: dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
	robin.murphy@arm.com, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: replace snprintf with scnprintf in
 dmar_latency_snapshot()
Message-ID: <aIDN3pvUSG3rN4SW@willie-the-truck>
References: <20250722131117.2739-1-ImanDevel@gmail.com>
 <aH_RWQ_YqlydOkKH@willie-the-truck>
 <fvq3h4mbms64vzyqssy4xli2sudzpyimbacg74lkdgrzi77oqy@4yywt5fav7wi>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fvq3h4mbms64vzyqssy4xli2sudzpyimbacg74lkdgrzi77oqy@4yywt5fav7wi>

On Wed, Jul 23, 2025 at 04:28:54AM -0400, Seyediman Seyedarab wrote:
> On 25/07/22 06:58PM, Will Deacon wrote:
> > On Tue, Jul 22, 2025 at 09:11:17AM -0400, Seyediman Seyedarab wrote:
> > > snprintf returns the number of bytes that would have been written,
> > > not the number actually written to the buffer. When accumulating
> > > the byte count with the return value of snprintf, this can cause
> > > the offset to exceed the actual buffer size if truncation occurs.
> > > 
> > > The byte count is passed to seq_puts() in latency_show_one() with-
> > > out checking for truncation.
> > > 
> > > Replace snprintf with scnprintf, ensuring the buffer offset stays
> > > within bound.
> > > 
> > > Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
> > > ---
> > >  drivers/iommu/intel/perf.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)

[...]

> > Should the check of the return value in latency_show_one() also be
> > adjusted so that 'ret <= 0' is an error? I couldn't convince myself
> > that the string in 'debug_buf' is always null-terminated if ret == 0.
> > 
> IMO, that's not necessary. 'bytes' can't be less than zero that's
> for sure (AFAIK, scnprintf() doesn't have any case where it returns
> a negative number).
> As for being zero, in every scnprintf() call, 'size - bytes' would
> have to be == 0. (or size > INT_MAX, but still you get zero, not a
> negative number as an error)
> 
> In latency_show_one(), the 'size' is DEBUG_BUFFER_SIZE, and
> 'bytes' in the first run is 0. So, 'size - bytes' == DEBUG_BUFFER_SIZE.
> Since 'latency_counter_names' and 'latency_type_names' are arrays of
> string literals, 'bytes' is guaranteed to be increased in the first
> iteration, even if the rest become zero (which won't happen, since
> they are smaller than DEBUG_BUFFER_SIZE).
> 
> So, the case of zero is impossible, unless you want a bulletproof
> check for future implementations where the function might be rewritten.

Thanks, so that sounds like the error check in latency_show_one() is dead
code in which case dmar_latency_snapshot() should just have a return type
of 'void'?

Will
