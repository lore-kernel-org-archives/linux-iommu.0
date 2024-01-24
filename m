Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACF577647;
	Wed, 24 Jan 2024 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706101462; cv=none; b=r2vwuhj6Oqh/EVvOxRsFgRw+iXQdlO4Xu8UjZfDjWQDOlydoLAFX7fUCqL37jiy8tQQDonWSqM7M/QllrW+ZzHzfelLoT4/FpMiL/S50wwM85fIQZg07Z3UxVRn6w3BF2zx050VtPzaFBoNcrw8WLJ7hJ4m7KGvdTQViR5WsCII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706101462; c=relaxed/simple;
	bh=GZkJ+QeMKJNqZBgYX+y1qwEAQJjghDN2AgFfR74bdH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHJPLDgiSRdAHOYfsgEhZn2/eSutrgQYUbwoJTuQUpnFfese0/+q6YshqHZCSLc9PmzUt8fItgBT6edefs8ubNCHiYnDIGkrE1NFfmtV2YJq/1j7Xu5hDXhf5hJw/oEzuQGTCWN3FQU0PlscmkXTQdNYbw3/AHytznXu6kMXA/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=BUH732Ef; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="BUH732Ef"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id B20B060022F7;
	Wed, 24 Jan 2024 12:56:55 +0000 (WET)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id ajMDtZ95vwAa; Wed, 24 Jan 2024 12:56:53 +0000 (WET)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [IPv6:2001:690:2100:1::b3dd:b9ac])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id 646A660022F2;
	Wed, 24 Jan 2024 12:56:53 +0000 (WET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail; t=1706101013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9eOQRiZQC0U4e8V4bKlkhm5RMXXl+uFAIdIpnZe1j2E=;
	b=BUH732EfZ07SrO0LtlTr+fTBGTq+bE88F8Oz0riOwX/xxJNWOHQs9pqnWHcTMAZQHxkljc
	aZC94hmRzp6+s2Lb2h6ItxQdvgaTXm3Gu5BozKdJ6pcDU48XfdO+zFVc5CYY1vMzECHLGh
	IDwSVUvQdj4/V3PgivHmc6EscQAOPkU=
Received: from diogo-gram (unknown [IPv6:2001:8a0:7ae3:e700:a921:1147:531c:b1e7])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id 1EABE36008F;
	Wed, 24 Jan 2024 12:56:52 +0000 (WET)
Date: Wed, 24 Jan 2024 12:56:48 +0000
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, thierry.reding@gmail.com, 
	vdumpa@nvidia.com, joro@8bytes.org, will@kernel.org, jonathanh@nvidia.com, 
	baolu.lu@linux.intel.com, jsnitsel@redhat.com, jroedel@suse.de, 
	linux-tegra@vger.kernel.org, iommu@lists.linux.dev, regressions@lists.linux.dev, 
	diogo.ivo@tecnico.ulisboa.pt
Subject: Re: Re: [REGRESSION] Failed buffer allocation in Tegra fbdev
Message-ID: <r46zhd52g3w3kpu4jjca3vihmv5ahp3jcwge3rvg42dupxf2g4@p2u5mbdyypw3>
References: <bbmhcoghrprmbdibnjum6lefix2eoquxrde7wyqeulm4xabmlm@b6jy32saugqh>
 <20240123151508.GR50608@ziepe.ca>
 <pgund4coabp5pdlmwze5o2d7ogrdncktqz267yzukjcvmikudc@7svrwdci7ujl>
 <55cab5e0-0abf-47d0-becc-05cdf1d22fac@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55cab5e0-0abf-47d0-becc-05cdf1d22fac@arm.com>

On Wed, Jan 24, 2024 at 11:46:59AM +0000, Robin Murphy wrote:
> On 2024-01-24 9:13 am, Diogo Ivo wrote:
> > On Tue, Jan 23, 2024 at 11:15:08AM -0400, Jason Gunthorpe wrote:
> > > On Tue, Jan 23, 2024 at 02:33:15PM +0000, diogo.ivo@tecnico.ulisboa.pt wrote:
> > > > Commit c8cc2655cc6c in the recent IOMMU changes breaks Tegra fbdev
> > > > at least on the Pixel C with the following error message reporting
> > > > a failed buffer allocation:
> > > > 
> > > > [    1.857660] drm drm: failed to allocate buffer of size 18432000
> > > > 
> > > > This error message is printed from tegra_bo_alloc() which is called by
> > > > tegra_bo_create() in tegra_fbdev_probe(), which may indicate that other
> > > > allocations would fail as well, not just the framebuffer.
> > > 
> > > Presumably this is because iommu_map_sgtable() under
> > > tegra_bo_iommu_map() fails?
> > > 
> > > Which I suspect is because of the logic in
> > > host1x_client_iommu_attach().
> > > 
> > > After c8cc2655cc6c iommu_get_domain_for_dev() will never return NULL.
> > > 
> > > So this:
> > > 
> > > 	if (domain && domain != tegra->domain)
> > > 		return 0;
> > > 
> > > Will happen and the domain will be left at IDENTITY, while I suppose
> > > the tegra_bo_iommu_map() assumes the domain was switched to tegra->domain.
> > > 
> > > Does this solve your issue?
> > > 
> > > diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
> > > index ff36171c8fb700..15c7910b2e1c76 100644
> > > --- a/drivers/gpu/drm/tegra/drm.c
> > > +++ b/drivers/gpu/drm/tegra/drm.c
> > > @@ -960,7 +960,7 @@ int host1x_client_iommu_attach(struct host1x_client *client)
> > >           * not the shared IOMMU domain, don't try to attach it to a different
> > >           * domain. This allows using the IOMMU-backed DMA API.
> > >           */
> > > -       if (domain && domain != tegra->domain)
> > > +       if (domain && domain->type != IOMMU_DOMAIN_IDENTITY && domain != tegra->domain)
> > >                  return 0;
> > >          if (tegra->domain) {
> > > 
> > > > This may be connected with an error in of_iommu_configure() that
> > > > became visible after commit 6ff6e184f1f4d:
> > > > 
> > > > [    1.200004] host1x drm: iommu configuration for device failed with -ENOENT
> > > 
> > > Hmmm
> > > 
> > > This is a new logging, so it doesn't necessarily mean something has
> > > changed in the code flow.
> > > 
> > > It seems the issue is something in there is returning ENOENT when it
> > > probably should be ENODEV, but I haven't been able to guess where it
> > > comes from.
> > > 
> > > Can you do some tracing and figure out where under
> > > of_iommu_configure() this ENOENT return code is from?
> > > 
> > > Jason
> > 
> > I did the tracing and found that the ENOENT is coming from
> > sysfs_do_create_link_sd() in the following function call chain:
> > 
> > of_iommu_configure() -> iommu_probe_device() -> __iommu_probe_device() ->
> 
> What's the call path leading up to that? If it's the one from
> host1x_device_add() then it's expected and benign - for fiddly reasons,
> iommu_probe_device() ends up being called too early, but will soon be run
> again in the correct circumstances once we proceed into
> host1x_subdev_register()->device_add(). That will have been happening for
> years, we just never reported errors in that spot before (and frankly I'm
> not convinced it's valuable to have added it now).
> 
> Thanks,
> Robin.

Yes, it is the one called from host1x_device_add(), so this
is solved and only the patch sent above needs to be merged.

Thanks,
Diogo
