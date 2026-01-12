Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA1C363C42;
	Mon, 12 Jan 2026 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768233221; cv=none; b=F8Zmmd5ELqKUSrMggssc465EnRHs7450iJDdJ5R+usMGqRYul9eJkW5uUtgzwsRp13oibiqhrNgIBBNTpn0bFxWGBL0N1zSxhcTn20tsWqeHB7w6JYJRQY9wGYTBd9TmQJFtkZp7NdUzBxXJEYSrNAwjKqgxNgtbRfjo4UIbrSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768233221; c=relaxed/simple;
	bh=Iwz2FZB7Ir4MOz88EBGnyMaOkJY3tnWlW7Bxq070cus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRWdK7hgR5HQARmeIGkfw6oN6rlcVEBeJ7grmtpl96JzTsQErdrRZOcsOgfjOsU1jujBv14XQY3MAytw9UR6FO8zpBfGAhqC8GxPjof7FsbQYVxOPIVpSeJDSWlklVbVAVBIGgBmNVvfv5O/6yFTDweFJF6iyeP9mInakIB0E80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxixVHp6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxixVHp6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7459EC16AAE;
	Mon, 12 Jan 2026 15:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768233220;
	bh=Iwz2FZB7Ir4MOz88EBGnyMaOkJY3tnWlW7Bxq070cus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JxixVHp6QGt172wu0poHq5+oMZ2CU8nIbuhotT0mjSZb5/+6YJLBIk4TFWsb3ePV0
	 5XjNL4IkcVx+tTURrRqMxqNJ19Sl1sjJGjk6ixKSDtR3nj0T3uPLSXGB+xwD/142C4
	 nPMkQeQHmt+0dCAbBHuKnlQqiM661a1YmpoW1whGkqxGIAzhfTJ5r529xGeQJJ3k+Y
	 SG5iCe6tsz1q2UB3Nm9X5i72LF6+R6e/NwKDCZAEQ0nK6FraXkn2KkZuM1QZSkq3h5
	 XlpFtV2LXj2J5AH+QqlkxoWCbd4sOlpF1kdq1W/7ANqjOqWuIhvZTaBnm67ai+BLnx
	 34gcMQZnsHKgw==
Date: Mon, 12 Jan 2026 15:53:29 +0000
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, robin.murphy@arm.com,
	joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	skolothumtho@nvidia.com, praan@google.com,
	xueshuai@linux.alibaba.com, smostafa@google.com
Subject: Re: [PATCH rc v5 1/4] iommu/arm-smmu-v3: Add update_safe bits to fix
 STE update sequence
Message-ID: <aWUY-f3kvM94z4qh@willie-the-truck>
References: <cover.1766093909.git.nicolinc@nvidia.com>
 <58f5af553fa7c3b5fd16f1eb13a81ae428f85678.1766093909.git.nicolinc@nvidia.com>
 <aV7OBrH-TDiGRblt@willie-the-truck>
 <20260108003646.GA537728@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108003646.GA537728@nvidia.com>

On Wed, Jan 07, 2026 at 08:36:46PM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 07, 2026 at 09:20:06PM +0000, Will Deacon wrote:
> > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 ++
> > >  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 18 ++++++++++---
> > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 27 ++++++++++++++-----
> > >  3 files changed, 37 insertions(+), 10 deletions(-)
> > 
> > Hmm. So this appears to ignore the safe bits entirely, whereas the
> > rationale for the change is that going from {MEV,EATS} disabled to
> > enabled is safe (which I agree with). 
> 
> The argument was it doesn't matter for either direction be it disabled
> to enabled or vice versa, see my reply to Mustfa in the v4 posting:
> 
> https://lore.kernel.org/all/20251218180129.GA254720@nvidia.com/

It would be good to include some of that rationale in the comment and
commit message for patch 3, as at the moment it only talks about the
change in one direction.

I'm also still not convinced that this is generally safe, even if it
works within what Linux currently does. For example, if somebody tries
to disable S2S and enable ATS at the same time, couldn't you transiently
get an illegal STE?

Will
