Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51C220B1E0;
	Tue,  8 Oct 2024 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728409326; cv=none; b=HqxzbUVsGIqvPq+BKmTZRirUNog3UNKREIWkeAVI6QDe4EaMQiSVSALxBkjDg5FrfAYIL44opNhCmKyXIS+YtF+nJ7sOqC6IqRH2zwlgs5ZPF2EKaOTTEWzgXktQeIrpufNbMfWkcqBkMtI1L+bT95DYZgh3FqxW7OBKavdTY+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728409326; c=relaxed/simple;
	bh=eNUS50KcHF91ZvltzMFX+z0qLcRzb93tuIxwqHyfZpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=damn1i46QETqC2w3a+jf0/Y6Eg109EtQ4nTQs+atYxW42CXqYiUEsm/+MmqPwAXcyM1OThTYO2EjZ2Yaq6YVLEx/SdrnT00vDyVzJ99Ye6k6hxy6AJblTKyvko2rcTzGGPNPBkcc1zDRXxO9dyoPKeRYYLbqloAH8NZci31MId0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgMhxGZq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgMhxGZq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DA0C4CECE;
	Tue,  8 Oct 2024 17:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728409326;
	bh=eNUS50KcHF91ZvltzMFX+z0qLcRzb93tuIxwqHyfZpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RgMhxGZqsRMqT4paQFe4UnOpNo4+bdRdiHLVDYBcHzRLR/O2gLnNDAJYM21iT1Pqd
	 XIL2Ab3hIPmZon4pTVVs5CemIRJUd9Rx06YvJmFJMb6Zx9PP0oVZmCw/gQfXqzDt2A
	 Zg+6T4DjbXXILdcZsIx+fbG2hB5uPDtCRzFEULjRuwwzsRcR5xVSJBCh7hJQe/OtMs
	 k9Nft7nq4p8xA+nSeUIb+wpVTzCmgxQuh+gxZhA0kyVzEoIFy1Uf1IZbGkyLSkm7x4
	 AwjfOuhpmGVZD4Fg03JxeJe3nGPOG7vuhaRH/4Dx6wXXaRM0IqkPyLmuUNWP3+4/hr
	 f1dDdFYwxBtzQ==
Date: Tue, 8 Oct 2024 18:42:01 +0100
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Yang Shi <yang@os.amperecomputing.com>, nicolinc@nvidia.com,
	james.morse@arm.com, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
Message-ID: <20241008174201.GB11091@willie-the-truck>
References: <20241004180405.555194-1-yang@os.amperecomputing.com>
 <20241008133458.GA10474@willie-the-truck>
 <20241008151506.GC762027@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008151506.GC762027@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Oct 08, 2024 at 12:15:06PM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 08, 2024 at 02:34:58PM +0100, Will Deacon wrote:
> 
> > This all looks a bit messy to me. The architecture guarantees that
> > 2-level stream tables are supported once we hit 7-bit SIDs and, although
> > the driver relaxes this to > 8-bit SIDs, we'll never run into overflow
> > problems in the linear table code above.
> 
> My original point was about the confidential compute position (sigh)
> that the untrusted hypverisor should not corrupt the driver.
> 
> So your statement is architecturally true, but we never check that
> IDR0_ST_LVL_2LVL is set if IDR1_SIDSIZE > 2**7, and so we can get into
> this situation where the hypervisor could trigger some kind of bad
> behavior.
> 
> > So I'm inclined to take Daniel's one-liner [1] which just chucks the
> > 'ULL' suffix into the 2-level case. Otherwise, we're in a weird
> 
> I think you should take it and let better be for the CC crowd.

Heh. I wish them luck! :p

Will
