Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F373234CF9;
	Thu, 15 May 2025 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747319767; cv=none; b=Ta19SQri9lWOrmfnP2U8SZxc9VmFPWqN5P8NktKDeKYaDYdDR7kDYPDId9AEmjMBFapqorVRGDmmVC4i3Xwg3Y2Mze6Rpv36uBRJRGhSGcVya7TNeMiw41EQgsBbF9koGFxKzkgFMTUFlrCcUBx4TN6QoGt4jW+GpCA3HAXQFRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747319767; c=relaxed/simple;
	bh=3Cf88rjCTOty5cvepo7/cysSSiqOnFTy6g8DckcCqCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uo85J2Qw00vhDuNWPB6UU8piiJpA/1Fnn+llkzx5b3YBm5S2OTAS0JVlT3g7qngjK2Xf0GmHHpiWi05NOVwbDPf2c/JqjQ2llr5ZCeH3/5Y4k0lzttXP/iM9urh52sdbA63BbSUOZum8fTmkeI4Kh7s/QaNhQ1N17/iQpfaLv7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fw+4GbqY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fw+4GbqY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D214C4CEE7;
	Thu, 15 May 2025 14:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747319766;
	bh=3Cf88rjCTOty5cvepo7/cysSSiqOnFTy6g8DckcCqCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fw+4GbqYJZodcAcgtdrenBcRdqmP/OPhmmvbHPpQF9CVtK4NXmyOYGT8UGkrinMfi
	 EC2vSnQRPJbz6Xv9COkAnLqRc+Bg+HaXGAEy1X1bhWSaqR0reG7U62AAuKjSe30ASc
	 +sNtie9FPvd/ovSuX276CxEscPRTzzlB7GYD6QTPEEneqwy1wyZKWV8gMU0g0AuiG0
	 h79/6A9BZKsVlcu/Aw1RVu1e49NeaC7iBkWMATtzK7dLW3k0lmRb9ryGunHyOs/WYN
	 x9R7AXgbEtnQc1Y86cpBhtsDXPqc/tXV7vH/MOEC/UT914lkaZGbXXI3ZxcdPKUPti
	 C9Wl1Flu+AITw==
Date: Thu, 15 May 2025 15:36:02 +0100
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Mostafa Saleh <smostafa@google.com>,
	Pranjal Shrivastava <praan@google.com>, robin.murphy@arm.com
Subject: Re: [PATCH] iommu/io-pgtable-arm: Support contiguous bit in
 translation tables
Message-ID: <20250515143600.GB12165@willie-the-truck>
References: <20250430231924.1481493-1-danielmentz@google.com>
 <20250506154014.GM2260621@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506154014.GM2260621@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)

[+Robin]

On Tue, May 06, 2025 at 12:40:14PM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 30, 2025 at 11:19:24PM +0000, Daniel Mentz wrote:
> > The contiguous bit in translation table entries can be used as a hint to
> > SMMU that a group of adjacent translation table entries have consistent
> > attributes and point to a contiguous and properly aligned output address
> > range. This enables SMMU to predict the properties of the remaining
> > translation table entries in the same group without accessing them. It
> > also allows an SMMU implementation to make more efficient use of its TLB
> > by using a single TLB entry to cover all translation table entries in
> > the same group.
> > 
> > In the case of 4KB granule size, there are 16 translation table entries
> > in one group.
> > 
> > This change sets the contiguous bit for such groups of entries that are
> > completely covered by a single call to map_pages. As it stands, the code
> > wouldn't set the contiguous bit if a group of adjacent descriptors is
> > completed by separate calls to map_pages.
> 
> Nor should it
> 
> This seems like a pretty hacky implementation, it doesn't set the
> pgsize bitmap to indicate support and it doesn't have a safety check
> on unmap to protect against partial unmap of a huge page.
> 
> Wouldn't it be better to use the pgsize bit map and rely on the core
> code to tell a contig page size is being used and then it can
> trivially set the PTE bit without having to do all this extra work?

That sounds like it would be quite a bit cleaner and I think it aligns
with the "Large page" support in io-pgtable-arm-v7s.c which is doing
something extremely similar.

Will
