Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D27F192B84;
	Fri,  3 Jan 2025 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735918480; cv=none; b=tKbhbeVHjsPr2BSYqd5l5gu9irhYKC0TGb+l34itHmoB/SFYqMM8DYP+5Wc06H+yLQxH/tgXf7JpABSSOzoRKMiO0I8KhxS4GaTMP8nTDwWZ8QUYDZtaATTyM7mSm7Pa5h4lGmKM0WxGi37bZZHX4IzqWTorQsN/uZkDZ0ZWe3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735918480; c=relaxed/simple;
	bh=oGKckwtIYDG/dajdRaOy7mnGhcX91bcMCmVoCqjNfyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xq7yxutWQMtk6tKNRrnyHwtYkpem7hOppNh92HY8U/uc2OM6KWAJgK1znAgGGdprDBTFRedSC/yPnSaRUdJLSPKfJrX8PTKkEoYZIUyr1nUhUGLIaRvIhC8gA/FSHgk41EyVWj6sU0JBm37FQ0susIIMPRe+eqBji6Wr6VdxuZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqQsfkhR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqQsfkhR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7836C4CECE;
	Fri,  3 Jan 2025 15:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735918479;
	bh=oGKckwtIYDG/dajdRaOy7mnGhcX91bcMCmVoCqjNfyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hqQsfkhRD7PLWHRJQHXYj9EmUBzK7k1QpBkinOphaD62wy/XV7Sds4Q0mTNz4BBJc
	 M2PzQb6ys8K5sUHpd81OpxyOpXNhU0jBqkf6g7ApO5rhvJ5BX1i3x3G86Mb1hR65RY
	 1ANbqqn47PiaNI5wUGwq/GChm8wnavSKkaQfC8vPtQPpI3rg4wjo5JKcWtjkwnYRf5
	 2N/6/3uWh2Se81r6k7xYRcAttkVqW0pbKN3UshCE3t5mLcgC57xcdIBBMx0XopHXMG
	 ciJoX6MEyF1IzE+xawcJXr4v+ZHJ3c26h4d4JvQoMQ+JK5/co66MUcScK2cy+qCHPN
	 lueryNh/+GsgQ==
Date: Fri, 3 Jan 2025 15:34:35 +0000
From: Will Deacon <will@kernel.org>
To: Charan Teja Kalla <quic_charante@quicinc.com>
Cc: joro@8bytes.org, robin.murphy@arm.com, jgg@ziepe.ca,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] iommu: fix wrong DMA ops for iommu device
Message-ID: <20250103153434.GC3816@willie-the-truck>
References: <20241213150415.653821-1-quic_charante@quicinc.com>
 <91d15d11-ec53-4ca2-a385-9fa69d861f2c@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91d15d11-ec53-4ca2-a385-9fa69d861f2c@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

(Please try not to top-post as it makes the thread hard to follow)

On Thu, Jan 02, 2025 at 04:09:46PM +0530, Charan Teja Kalla wrote:
> On 12/13/2024 8:34 PM, Charan Teja Kalla wrote:
> > Race between smmu device probe and iommu device probe is resulting into
> > wrong DMA ops used for the device.
> > 
> > bus_iommu_probe(P1)                  of_iommu_configure(P2)
> > (from iommu_device_register)        (from insmod of a driver)
> > --------------------------         --------------------------
> > 1) probe_iommu_group()
> > (Fills just dev->iommu_group
> > under iommu_probe_device_lock)
> > 				2) iommu_probe_device():
> > 				  (acquires the iommu_probe_device_lock,
> > 				   but since dev->iommu_group is already
> > 				   set, it just returns without
> > 				   allocating the domain.)
> > 
> > 				3) of_dma_configure_id()->
> > 				   arch_setup_dma_ops() gets called for
> > 				   this device, but returns with the
> > 				   error message:
> > 				   "Failed to set up IOMMU for device;
> > 				    retaining platform DMA ops"
> > 
> > 				4) device probe is succeeded where it
> > 				   can now setup iommu mappings using
> > 				   wrong ->dma_ops
> > 
> > 5) domain will be allocated later
> > and fills iommu_group->domain.
> > 
> > Step 3) and 4) denies iommu device from using 'iommu_dma_ops'.
> > 
> > This issue does exists on 6.6 because of commit f188056352bc ("iommu:
> > Avoid locking/unlocking for iommu_probe_device()") without which 2)
> > returns only after filling the domain under group->mutex, thus no issue.
> > 
> > With commit b5c58b2fdc42("dma-mapping: direct calls for dma-iommu"),
> > ->iommu_dma_ops is removed altogether and iommu api are directly being
> > called under "use_dma_iommu(): return dev->dma_iommu". Again,
> > ->dma_iommu flag is set only after domain allocation. So, If
> > there is a sufficient delay between steps 4) and 5), issue is still
> > exists but that seems very narrow to me.
> > 
> > I am thinking, setup of the domain before returning from step2) is the
> > way to fix this issue. Can you please help if you have any suggestions?
> > 
> > Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
> > ---
> >  drivers/iommu/iommu.c | 26 +++++++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
>
> Just a quick ask if you have any comments for the below. BTW, in
> internal tests, when we revert the commit f188056352bc ("iommu: Avoid
> locking/unlocking for iommu_probe_device()", it is helping.
> 
> I can share more details If the below is not sufficient.
> 
> Thanks in advance...

Can you reproduce the issue on 6.13-rc5? We bodged some of the probe
code recently:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=229e6ee43d2a160a1592b83aad620d6027084aad

and a better set of fixes are queued in -next.

Will
