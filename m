Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73AA219EB
	for <iommu@lists.linux.dev>; Fri,  5 Sep 2025 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757077473; cv=none; b=SGn5LBEaQwbkaRKIkS/8exvXhPCZI6qFjR0QIbWe4Djxv1pAZjHjCRH0OROZ7K0/7WAb8XxwZlQLFZyEuxQwOylo7LAk03PsHJApXJBk/37ZnKDsL0BA8xa4XjKcquxYHUaO3kBhiyQi10oPbpFnwXuJNECWSUORO8hD75NR98I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757077473; c=relaxed/simple;
	bh=gf8Wv3CwSREEIQF0pzbMHFP1Ns2rSOX6mMMsVmZtdoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUGeDps0Z3Rv1gsZsDviNNcycnHw6DWXjf16N/v/JTm70/2LhVAZi2TmtLw8liBZ/z7QYfnr5pgCVkq3ZNvujb7jHLuPxPSoDZjba5PRpklvvIA0cs7TrJ2wT/0MSKxwk/k/SZHZJZEAP+Y+i4rh8S5BUFL70+E1kUzI6Q3/DDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=6Q4e3nps; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="6Q4e3nps"
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 806CA54B04;
	Fri,  5 Sep 2025 15:04:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1757077470;
	bh=gf8Wv3CwSREEIQF0pzbMHFP1Ns2rSOX6mMMsVmZtdoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=6Q4e3npsbUWJsGhy5Eagz8qfy9EPNOm2qK6uYFFlv2EmgCkeAFTGwiK+tOIwfKtJQ
	 Hvs4uSy7dpTDftCRHTJLbMYx5qOVQu/GUf0xOf3SWKWpXOh7n4DGFH8vK5ugJ8FJ6Z
	 AN4GLI73puW9nN+53lbgztv60jIWBvLwNU0b2PVPSihK/saRmlMUdtnH7syjm1BmXz
	 BcSFNviYBaZ7vQC+iRaFUXqQ1Rp0hwnAACzA+wxDP1XNstQ5PibGKRZ+TiFtqj39Mf
	 jIYVyx23ddSZzu8RwzSms5PTLetCZXCONKjaKBCEFk2VkSxQ6i/7BdPPGmYnBndq3W
	 41Me7NSvvNxqg==
Date: Fri, 5 Sep 2025 15:04:29 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
	Benjamin Block <bblock@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH] iommu/s390: Make attach succeed when the device was
 surprise removed
Message-ID: <aLrf3QshijTRYYzk@8bytes.org>
References: <20250904-iommu_succeed_attach_removed-v1-1-e7f333d2f80f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904-iommu_succeed_attach_removed-v1-1-e7f333d2f80f@linux.ibm.com>

On Thu, Sep 04, 2025 at 10:59:49AM +0200, Niklas Schnelle wrote:
> When a PCI device is removed with surprise hotplug, there may still be
> attempts to attach the device to the default domain as part of tear down
> via (__iommu_release_dma_ownership()), or because the removal happens
> during probe (__iommu_probe_device()). In both cases zpci_register_ioat()
> fails with a cc value indicating that the device handle is invalid. This
> is because the device is no longer part of the instance as far as the
> hypervisor is concerned.
> 
> Currently this leads to an error return and s390_iommu_attach_device()
> fails. This triggers the WARN_ON() in __iommu_group_set_domain_nofail()
> because attaching to the default domain must never fail.
> 
> With the device fenced by the hypervisor no DMAs to or from memory are
> possible and the IOMMU translations have no effect. Proceed as if the
> registration was successful and let the hotplug event handling clean up
> the device.
> 
> This is similar to how devices in the error state are handled since
> commit 59bbf596791b ("iommu/s390: Make attach succeed even if the device
> is in error state") except that for removal the domain will not be
> registered later. This approach was also previously discussed at the
> link.
> 
> Handle both cases, error state and removal, in a helper which checks if
> the error needs to be propagated or ignored. Avoid magic number
> condition codes by using the pre-existing, but never used, defines for
> PCI load/store condition codes and rename them to reflect that they
> apply to all PCI instructions.
> 
> Cc: stable@vger.kernel.org # v6.2
> Link: https://lore.kernel.org/linux-iommu/20240808194155.GD1985367@ziepe.ca/
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  arch/s390/include/asm/pci_insn.h | 10 +++++-----
>  drivers/iommu/s390-iommu.c       | 26 +++++++++++++++++++-------
>  2 files changed, 24 insertions(+), 12 deletions(-)

Applied for -rc, thanks.
