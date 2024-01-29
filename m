Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5302E834;
	Mon, 29 Jan 2024 19:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556822; cv=none; b=i9skpk2TFJZi7vwGO8IjgIzTTrGwvKkdov0U/y1XcILJ7TdyziATFKxCigQ/5JvjWZNlK98SDzjonG5WH1XaTw3A+wj2CRPBgYIZZFqKwCdkCcYgNwKwvZw9AzEkFGNSyIExE/CstMECSU/3dxwh2X0KxPoPlNWlCr0U0SgpjJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556822; c=relaxed/simple;
	bh=E3YCH6GYX+uJl1+PT0VCyfk5YO/Fz8wVTyeEoFriD2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dem4PXAEH1uNvJBloiQfPC5OJLbOWA7kbu0MNQ+xIo8BA+nCw0stnRN63gXKPXR1PNG0r5WClfvr+9HJn6QZnTs849AFGgsCZ6e0pYr+Xi9pibR/qqirIKCyHEj3CGnhL6FqAyitwhEqNA5m/RJR0zArgoFtmlYrlBMPOMZ8jPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrV+MjYM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrV+MjYM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49C1C433F1;
	Mon, 29 Jan 2024 19:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706556821;
	bh=E3YCH6GYX+uJl1+PT0VCyfk5YO/Fz8wVTyeEoFriD2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HrV+MjYMgUNseHK2862ddZm2tnf7xedLJgEa2/1Qgmp9ivNwvYOp8WzZ4u0dtXEfP
	 blEouP921It5RpiOHYIAaRS1odcOaKv74a1d7YodSh+tA1ryBRB/DLNIJi5seRTFm7
	 3CZWjtdQ8nzSJg08PPY3yVpz2eJOyTYiyCm6CyE87K2DW6YhU/bb/CckLd5NRGS/OJ
	 Rq8nkU0wADeT9KbVxMuHFyMg0U6hqIo84nciFPvoU/ZrlAwL86h1QhoEssdHYkQv1R
	 n8PhVCquwiv1IWhjwnN4jw93jcjBoU7XH3IR4QovbsgTL+cELuGjsIuJGWYweweb45
	 ufPaK4OZ0kOrw==
Date: Mon, 29 Jan 2024 19:33:36 +0000
From: Will Deacon <will@kernel.org>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH 0/2] Fix double allocation in swiotlb_alloc()
Message-ID: <20240129193335.GC12631@willie-the-truck>
References: <20240126151956.10014-1-will@kernel.org>
 <20240126172059.48ad7b9f@meshulam.tesarici.cz>
 <20240129184255.GA12631@willie-the-truck>
 <20240129202619.69178dea@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129202619.69178dea@meshulam.tesarici.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jan 29, 2024 at 08:26:19PM +0100, Petr Tesařík wrote:
> On Mon, 29 Jan 2024 18:42:55 +0000
> Will Deacon <will@kernel.org> wrote:
> 
> > On Fri, Jan 26, 2024 at 05:20:59PM +0100, Petr Tesařík wrote:
> > > On Fri, 26 Jan 2024 15:19:54 +0000
> > > Will Deacon <will@kernel.org> wrote:
> > >   
> > > > Hi folks,
> > > > 
> > > > These two patches fix a nasty double allocation problem in swiotlb_alloc()
> > > > and add a diagnostic to help catch any similar issues in future. This was
> > > > a royal pain to track down and I've had to make a bit of a leap at the
> > > > correct alignment semantics (i.e. iotlb_align_mask vs alloc_align_mask).  
> > > 
> > > Welcome to the club. I believe you had to re-discover what I described here:
> > > 
> > >   https://lore.kernel.org/linux-iommu/20231108101347.77cab795@meshulam.tesarici.cz/  
> > 
> > Lucky me...
> > 
> > > The relevant part would be this:
> > > 
> > >   To sum it up, there are two types of alignment:
> > > 
> > >   1. specified by a device's min_align_mask; this says how many low
> > >      bits of a buffer's physical address must be preserved,
> > > 
> > >   2. specified by allocation size and/or the alignment parameter;
> > >      this says how many low bits in the first IO TLB slot's physical
> > >      address must be zero.  
> > > 
> > > Fix for that has been sitting on my TODO list for too long. :-(  
> > 
> > FWIW, it did _used_ to work (or appear to work), so it would be good to
> > at least get it back to the old behaviour if nothing else.
> 
> Yes, now that I look at the code, it was probably misunderstanding on
> my side as to how the three different alignment requirements are
> supposed to work together.
> 
> AFAICT your patch addresses everything that has ever worked. The rest
> needs some more thought, and before I touch this loop again, I'll write
> a proper test case.

Thanks, that would be much appreciated!

Will
