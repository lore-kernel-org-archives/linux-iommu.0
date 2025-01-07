Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BA81DFD99;
	Tue,  7 Jan 2025 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736249493; cv=none; b=JcgNvI+cFoOSOK2PhdTb/uZJIO3KChYvwTn7FhHrS/Z2F6hayrvDeJXfGH9dL7ZB5IVw/OaZeEpMHx2VRl4f5b2b+4G27IarJeww4kHkc9/XdSbP3Q4jWHK7gESGcOD9nkE4i6BtbYodMJCuqFgPHSpMdVjzw54Z8eFgPc4SoH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736249493; c=relaxed/simple;
	bh=KNzDqrEbqWICp1lvbAqO+hk7hK6hGl0NkHJTW00ThIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Da2Z6cfbEx4YCPzWNM4ibDZdg8KjzRDeCNsLFIA9fH6V+f2H1SOAKDAFEJUvX4hsELxm0tywBezjXKG4x3ZAc0CVvqCJ/aJ7+yQCHFlkAy+ad7rx9/bSTolCAgvYCZQPerXYgbh7AsGSCbUbFdprto/+//aYYbAchUXFFtDpkWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrKA+S2e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrKA+S2e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B81C4CED6;
	Tue,  7 Jan 2025 11:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736249492;
	bh=KNzDqrEbqWICp1lvbAqO+hk7hK6hGl0NkHJTW00ThIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CrKA+S2eFKwZbN7zX45J95bcQ25x8Hva1wEdKTVX4rZ6w7/9x1U5zk5UQxoD/8FRs
	 Uq+Bv3brg7+j/oV72O36imbcXG9pI70M0+pJqYs+jd/ShtHWuMkr0KWkL9SftL2PEW
	 69ZCm4x6n2CVE+9aANwfoOMiD1h3QZL+arYHP6lSKSe8Dudwbn3QqwPD9t7ghncVgY
	 kQmVGbW0vay8oPc9sS11I9CnCq+dPn7ARp2sNLfCRoJddYqTgg5/Xu4KyjXhrukap7
	 rvrVfGkRwD/jhs1bmE+wm/3uJajecnke6JzqXHDrPPr4/wqhird7NKaLegQG84Z/rR
	 gU7ofMppydHNw==
Date: Tue, 7 Jan 2025 11:31:27 +0000
From: Will Deacon <will@kernel.org>
To: Charan Teja Kalla <quic_charante@quicinc.com>
Cc: joro@8bytes.org, robin.murphy@arm.com, jgg@ziepe.ca,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] iommu: fix wrong DMA ops for iommu device
Message-ID: <20250107113126.GA6932@willie-the-truck>
References: <20241213150415.653821-1-quic_charante@quicinc.com>
 <91d15d11-ec53-4ca2-a385-9fa69d861f2c@quicinc.com>
 <20250103153434.GC3816@willie-the-truck>
 <e8fa02bb-96b7-4010-92c9-7e1eb485a551@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8fa02bb-96b7-4010-92c9-7e1eb485a551@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jan 06, 2025 at 06:46:08PM +0530, Charan Teja Kalla wrote:
> On 1/3/2025 9:04 PM, Will Deacon wrote:
> > On Thu, Jan 02, 2025 at 04:09:46PM +0530, Charan Teja Kalla wrote:
> >> On 12/13/2024 8:34 PM, Charan Teja Kalla wrote:
> >>> Race between smmu device probe and iommu device probe is resulting into
> >>> wrong DMA ops used for the device.
> >>>
> >>> bus_iommu_probe(P1)                  of_iommu_configure(P2)
> >>> (from iommu_device_register)        (from insmod of a driver)
> >>> --------------------------         --------------------------
> >>> 1) probe_iommu_group()
> >>> (Fills just dev->iommu_group
> >>> under iommu_probe_device_lock)
> >>> 				2) iommu_probe_device():
> >>> 				  (acquires the iommu_probe_device_lock,
> >>> 				   but since dev->iommu_group is already
> >>> 				   set, it just returns without
> >>> 				   allocating the domain.)
> >>>
> >>> 				3) of_dma_configure_id()->
> >>> 				   arch_setup_dma_ops() gets called for
> >>> 				   this device, but returns with the
> >>> 				   error message:
> >>> 				   "Failed to set up IOMMU for device;
> >>> 				    retaining platform DMA ops"
> >>>
> >>> 				4) device probe is succeeded where it
> >>> 				   can now setup iommu mappings using
> >>> 				   wrong ->dma_ops
> >>>
> >>> 5) domain will be allocated later
> >>> and fills iommu_group->domain.
> >>>
> >>> Step 3) and 4) denies iommu device from using 'iommu_dma_ops'.
> >>>
> >>> This issue does exists on 6.6 because of commit f188056352bc ("iommu:
> >>> Avoid locking/unlocking for iommu_probe_device()") without which 2)
> >>> returns only after filling the domain under group->mutex, thus no issue.
> >>>
> >>> With commit b5c58b2fdc42("dma-mapping: direct calls for dma-iommu"),
> >>> ->iommu_dma_ops is removed altogether and iommu api are directly being
> >>> called under "use_dma_iommu(): return dev->dma_iommu". Again,
> >>> ->dma_iommu flag is set only after domain allocation. So, If
> >>> there is a sufficient delay between steps 4) and 5), issue is still
> >>> exists but that seems very narrow to me.
> >>>
> >>> I am thinking, setup of the domain before returning from step2) is the
> >>> way to fix this issue. Can you please help if you have any suggestions?
> >>>
> >>> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
> >>> ---
> >>>  drivers/iommu/iommu.c | 26 +++++++++++++++++++++++++-
> >>>  1 file changed, 25 insertions(+), 1 deletion(-)
> >>
> >> Just a quick ask if you have any comments for the below. BTW, in
> >> internal tests, when we revert the commit f188056352bc ("iommu: Avoid
> >> locking/unlocking for iommu_probe_device()", it is helping.
> >>
> >> I can share more details If the below is not sufficient.
> >>
> >> Thanks in advance...
> > 
> > Can you reproduce the issue on 6.13-rc5? We bodged some of the probe
> > code recently:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=229e6ee43d2a160a1592b83aad620d6027084aad
> > 
> > and a better set of fixes are queued in -next.
> 
> Yes, we did try a better patch from Robin[1] and the issue is still
> reproducible.

Did you try the -EPROBE_DEFER hack that got merged?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=229e6ee43d2a160a1592b83aad620d6027084aad

Otherwise, you can try the stack queued for 6.14 in iommu/linux.git:

46b3df8eb9bd iommu: Manage driver probe deferral better
fcbd62156742 iommu/arm-smmu-v3: Clean up more on probe failure
97cb1fa02726 iommu/arm-smmu: Retire probe deferral workaround
7d835134d4e1 iommu/arm-smmu: Make instance lookup robust

> IIUC, these patches are trying to get valid smmu device, during the
> probe of an smmu client device, by traversing proper 'klist_devices'
> happening from iommu_init_device(). Please CMIW.

Well, they're fixing a race between the IOMMU probing and its client
devices attaching.

> But this bug makes iommu_init_device() to completely gets skipped.
> 
> static int __iommu_probe_device(struct device *dev, ...)
> {
> 	/* Device is probed already if in a group */
>         if (dev->iommu_group)
>                 return 0;  --> driver call returns from here.
> 
>         ret = iommu_init_device(dev, ops);
>         if (ret)
>                 return ret;
> 
> 
> }
> 
> Regarding the testing, we work on Android that is on LTS kernels, so, it
> may not be possible for us to try the thing on 6.13 and this seems a bug
> on LTS 6.6 kernel.

We need to fix 6.13 before we fix 6.6 unless you can show that 6.13 is
unaffected (in which case, we can backport the fix(es)).

Will
