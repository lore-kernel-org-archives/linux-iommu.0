Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3416A344DA8;
	Tue, 24 Mar 2026 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774361050; cv=none; b=b8LucxaB8CpjYTU+6OA8EbcrMv64mJtc57gVv2BGbV28kjUco/LG7RbB92DQ//Tla/prWf2h/5wVXwJwPnfQmHhiyBpzl4y4uifphu5QZI4HqMOhfNZUakTXIGfaicFJmVKmczQwZUAdOopxKKjMkSrcqInqO/BxWlQTRFrusos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774361050; c=relaxed/simple;
	bh=89bzxAh1/2+814fvMl+BUIb2U5xxsZkW9mR2TP8okBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVNQkswSJrmjMcZMrwhyX2VmNsytoThVe3efVRvKJnKF2mxOzloRNtzWHayjsRg1wbrqbp+3gehCb103g7QWJFw3TwoaaAMGjRou9+xYe+6Tz75mPMUKRfsEeIf2pHzmoz04TyW6KVqFK+dWPYh+BZ/5hccfjuVQAeB6zFGn52E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWccyQc7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWccyQc7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7881C19424;
	Tue, 24 Mar 2026 14:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774361049;
	bh=89bzxAh1/2+814fvMl+BUIb2U5xxsZkW9mR2TP8okBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jWccyQc7+Y2hNwb6SUv36aq9LdfRpsfqiVgZ9UqB5570HMO+wxAWxoiDesVzRgpY7
	 CsqA8NvUO4QSwA9brOW6is+EL3diAL13jH51mGl4OdvGH35/ofYYmGtm0Umg/s60I6
	 IpOFCo6V3GJqHK0cZ0xIzgmUpkrBX+AcuBAoEJ+OPLMc6dmQMUDjoBG800pQEeXJf1
	 SNSfXYN6T2Q84QH/eZP9+bY4eHU4Tv+SWYg6j/GsG/zBYre941WtFB3glKzQYBvAFC
	 /lKcpQ0nOXsVcuSDlyENJoE//PL2DHG01/MgW9F9Z3YYY8BZeuRKqwvQ1V6vM4wcrm
	 IPTfsb+1ql5Pw==
Date: Tue, 24 Mar 2026 14:04:03 +0000
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>, robin.murphy@arm.com,
	joro@8bytes.org, praan@google.com, mmarrid@nvidia.com,
	kees@kernel.org, Alexander.Grest@microsoft.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, bbiber@nvidia.com,
	skaestle@nvidia.com
Subject: Re: [PATCH rc] iommu/arm-smmu-v3: Drain in-flight fault handlers
Message-ID: <acKZ0wtfi5R_dHm0@willie-the-truck>
References: <20260307001723.964956-1-nicolinc@nvidia.com>
 <abLE3rdM9YAu81tq@willie-the-truck>
 <20260312142509.GA1586734@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312142509.GA1586734@nvidia.com>

On Thu, Mar 12, 2026 at 11:25:09AM -0300, Jason Gunthorpe wrote:
> On Thu, Mar 12, 2026 at 01:51:26PM +0000, Will Deacon wrote:
> > On Fri, Mar 06, 2026 at 04:17:23PM -0800, Nicolin Chen wrote:
> > > From: Malak Marrid <mmarrid@nvidia.com>
> > > 
> > > When a device is switching away from a domain, either through a detach or a
> > > replace operation, it must drain its IOPF queue that only contains the page
> > > requests for the old domain.
> > > 
> > > Currently, the IOPF infrastructure is used by master->stall_enabled. So the
> > > stalled transaction for the old domain should be resumed/terminated. Fix it
> > > properly.
> > > 
> > > Fixes: cfea71aea921 ("iommu/arm-smmu-v3: Put iopf enablement in the domain attach path")
> > > Cc: stable@vger.kernel.org
> > > Co-developed-by: Barak Biber <bbiber@nvidia.com>
> > > Signed-off-by: Barak Biber <bbiber@nvidia.com>
> > > Co-developed-by: Stefan Kaestle <skaestle@nvidia.com>
> > > Signed-off-by: Stefan Kaestle <skaestle@nvidia.com>
> > > Signed-off-by: Malak Marrid <mmarrid@nvidia.com>
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > ---
> > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > index 4d00d796f0783..2176ee8bec767 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > @@ -2843,6 +2843,12 @@ static int arm_smmu_enable_iopf(struct arm_smmu_master *master,
> > >  	if (master->iopf_refcount) {
> > >  		master->iopf_refcount++;
> > >  		master_domain->using_iopf = true;
> > > +		/*
> > > +		 * If the device is already on the IOPF queue (domain replace),
> > > +		 * drain in-flight fault handlers so nothing will hold the old
> > > +		 * domain when the core switches the attach handle.
> > > +		 */
> > > +		iopf_queue_flush_dev(master->dev);
> > 
> > So this drains the iopf workqueue, but don't you still have a race with
> > the hardware generating a fault on the old domain and then that only
> > showing up once you've switched to the new one? What is the actual
> > problem you're trying to solve with this patch?
> 
> HW doesn't generate faults on domains, it calls
> iommu_report_device_fault() which calls find_fault_handler() that
> uses iommu_attach_handle_get() to find the domain. It then shoves the
> domain pointer onto a WQ.

Sorry, that was sloppy terminology on my part. I'm trying to reason about
faults that are generated by accesses that were translated with the
page-tables of the old domain being reported once we think we are using
the new domain.

> The ordering is supposed to be
>  1) IOMMU HW starts using the new domain
>  2) iommu_attach_handle_get() returns the new domain
>  3) IOMMU driver flushes its own IRQs/queues that may be concurrently
>     calling iommu_attach_handle_get()

Does that mean we should kick the evtq thread? I'm not sure what this
means for the priq.

>  4) iopf_queue_flush_dev() to clear the iopf work queue
>  5) domain is freed, no pointers in WQs or other threads
> 
> So the naked iopf_queue_flush_dev() doesn't seem right, I'd expect a
> synchronize_irq() (is that right for threaded IRQs?) too as the
> threaded IRQ is concurrently calling iommu_attach_handle_get().

I don't think we can rely on the IRQ being taken, though, so presumably
we have to kick the irq thread manually and see what's actually sitting
in the event queue after the CMD_SYNC?

Will
