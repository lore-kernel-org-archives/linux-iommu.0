Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D3E2071F4;
	Tue,  8 Oct 2024 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728409285; cv=none; b=IqyDO+d7BKOiZ9biotFdyQuAOrzqwrBNLIj3XfxMrdejnHSLA2FLV59uJOeiTGWxTcBwS+mX/BuOCqMaqEMghyKQ7Iss3hp84dPBVOKsreldQl8bc8n2aZQdpRHuZDlMZHDTUoFHPCyo1vlHw4MC/3t3VCgrBHz9ZysgZwXQWqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728409285; c=relaxed/simple;
	bh=E+a+ZSwtSS1Hg854QqWsKDbxq+HjPFi1yBnJfNkQorc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+KCHt8gMzVT0roAwXBQZUedIm+XMHzsvcKCRJ1dfC/uriFSHOl/1D7XKWyQ7m4JRNJ6pkql/iiZwium2LrI0at6Foi6w20eGGniiKIZRV+QPr3buZsY0vJzhSjqEuGb6cdvC5koJN7lLoim5xmDzSeJvaqBRn3I8z+Kc19H/J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0ExjzHH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0ExjzHH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8672EC4CEC7;
	Tue,  8 Oct 2024 17:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728409285;
	bh=E+a+ZSwtSS1Hg854QqWsKDbxq+HjPFi1yBnJfNkQorc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K0ExjzHHCXF7b5354jIRH4tq4Y3R//fBScSu4gxGYYM8GNx23VzPIOeYQC5uzDS0k
	 q2JVvR+Nc8P9yHRfX0a+1QsNmiNECr89vkOyF6e5c+l7QyNXiKXf3N1hFk/anh7rfT
	 4DY+PwT/ILDHD2YSCpFCHqZrgpd3N5rgPzWs0je4UzAwOjK8WmNzpUYWLFeBhLJhjA
	 h5iCYqDSDcyl3GIB7XdpuRcAJDjFy+4TjaOO2vvolK9U+QiZTCegxwXVHpVEM1M65c
	 SSCFfcVCDv8mMTAAA0zsLDrRH8qLpTZdbkyoYUxoSKE+1l0WOOeAf1FWIL1RvMpDvy
	 V3UuR3jiI0Kag==
Date: Tue, 8 Oct 2024 18:41:20 +0100
From: Will Deacon <will@kernel.org>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, nicolinc@nvidia.com,
	james.morse@arm.com, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
Message-ID: <20241008174119.GA11091@willie-the-truck>
References: <20241004180405.555194-1-yang@os.amperecomputing.com>
 <20241008133458.GA10474@willie-the-truck>
 <20241008151506.GC762027@ziepe.ca>
 <b5725875-d04c-42e3-bcbe-e119019de7e1@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5725875-d04c-42e3-bcbe-e119019de7e1@os.amperecomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Oct 08, 2024 at 10:04:50AM -0700, Yang Shi wrote:
> On 10/8/24 8:15 AM, Jason Gunthorpe wrote:
> > On Tue, Oct 08, 2024 at 02:34:58PM +0100, Will Deacon wrote:
> > 
> > > This all looks a bit messy to me. The architecture guarantees that
> > > 2-level stream tables are supported once we hit 7-bit SIDs and, although
> > > the driver relaxes this to > 8-bit SIDs, we'll never run into overflow
> > > problems in the linear table code above.
> > My original point was about the confidential compute position (sigh)
> > that the untrusted hypverisor should not corrupt the driver.
> > 
> > So your statement is architecturally true, but we never check that
> > IDR0_ST_LVL_2LVL is set if IDR1_SIDSIZE > 2**7, and so we can get into
> > this situation where the hypervisor could trigger some kind of bad
> > behavior.
> 
> Jason's concern seems valid to me IMHO. But if the simpler version is
> preferred, I'd suggest add some comments at least or the check suggested by
> Jason to make the architecture guarantee more clear. Just in case someone
> else won't repeat what we had done just because they see "1ULL" in 2lvl code
> but not in linear code.

In principle, I'm not opposed to hardening the driver against malicious
virtual hardware, but I don't think we need to add comments everywhere
where we're relying on architectural behaviour. The hardening should
also be done separately from fixing a bug affecting users with real
hardware.

Will
