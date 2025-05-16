Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB4623504B
	for <iommu@lists.linux.dev>; Fri, 16 May 2025 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747399940; cv=none; b=hkfaWBPDIrGroFZFrzH+5TmsjnP90dPboQRiMp+ObPS6O6qcyYmoxywhjdFoHiABJTDZWhRakGJ8HQC6HEtc9rzxZxB09B661HUpyKqGJjswFSpV2ErRVpuxkHrdCuAUjy+Lcazw4it1aUGsC8pUiNFdALcdJFHbnTTBc3csHGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747399940; c=relaxed/simple;
	bh=JT/U2mvs/rvWFsaTfgjNmUfh5vwv0mZM5GDvnrJEgFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZHBUAatJN6qILYpasORw2L630ZVsoEZjRttVsUqa9uKyjgZr3cfo7E+/ONZMzBZWWltkn4856vkCOSyKRncb/nZNQ80oP28+nR1pcXg+D/RZ9/PEYtfnJIYttm+nVNaIfogwySgwiJgN5sBEFA5UmiWn9PzpDzf60Wxraa2KiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=5x6IgziN; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="5x6IgziN"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id EFFDB4B65F;
	Fri, 16 May 2025 14:52:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1747399930;
	bh=JT/U2mvs/rvWFsaTfgjNmUfh5vwv0mZM5GDvnrJEgFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=5x6IgziN+FFyCIh7qw9MzLngDXJBqQ7xToh7qiGb5wVY5sVeOtL2nmaVWEHO7v0M0
	 PPEho4Bqil8oWnuSeuvsQodZV8sMP2KdSo2p9Pju6nwzi0Ia4OGcf8HBhYnmW/vfnW
	 qKC7pCun5BU/kC/f09XKw3atlIeEJQJO/w1LtUxLXPjMxDUXDL06hiI5NzKjbvHDRV
	 CowA4RG9agPxeyNae6JOgSk5n172vs5ZfnerHUYlNLou/bmzyKYvXRpcJCCmN9EIpl
	 KT3C+lXkFO9C99DCIRDTMQu/Doq0M2gZCDilvygfwFVm9xvwMnp6Hz/dWCV2Fm3mfx
	 +MH1Zaq4kswvA==
Date: Fri, 16 May 2025 14:52:08 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Rolf Eike Beer <eb@emlix.com>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 6/6] iommu: make inclusion of iommufd directory
 conditional
Message-ID: <aCc0-ClDbiUpNUgh@8bytes.org>
References: <1926170.CQOukoFCf9@devpool92.emlix.com>
 <5568089.Sb9uPGUboI@devpool92.emlix.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5568089.Sb9uPGUboI@devpool92.emlix.com>

On Mon, May 12, 2025 at 03:15:52PM +0200, Rolf Eike Beer wrote:
> Nothing in there is active if CONFIG_IOMMUFD is not enabled, so the whole
> directory can depend on that switch as well.
> 
> Fixes: 2ff4bed7fee7 ("iommufd: File descriptor, context, kconfig and makefiles")
> Signed-off-by: Rolf Eike Beer <eb@emlix.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Had to remove this patch from the branch as it caused compile breakage
with allmodconfig builds.
