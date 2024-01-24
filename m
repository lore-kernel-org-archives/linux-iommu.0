Received: from smtp2.tecnico.ulisboa.pt (smtp2.tecnico.ulisboa.pt [193.136.128.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E68C17C65;
	Wed, 24 Jan 2024 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706092221; cv=none; b=athCr//Xzh+r1LTcZgDTc6/Oc7Ac5LCvXc/pRE8V02pb79QvwQUogGZLm/MI4Iq1MRuVdDqc1N2ugvRO/xvxFUOS/Hjo5BrH2MJT8nLFGWC/JJtn+OKSckbqhdQMFgcXmIUeuvA5fyaAmCTEnPRBvoEPntmOIY0RcfI3c1y+t9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706092221; c=relaxed/simple;
	bh=5CDUqzJMAZY3PKBL2rXEO+/UNgNnihux3d57o5Ukzbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQr+EE7P+hQFdT62iLjxlqSndlzphoePG100aSrYN8L9vq4Splh8bupIFCGO0CsSeCmPEy9DVIJ0XobAahZLnJ1SOYPhMMOTnL7fo7nlSLUYsWyQV0KoEQrzelQHkzxcdGo6SupWbFl4Y/pPNi5jqcq4wA/zXigDwN5Dzxu99OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=LL40N9/1; arc=none smtp.client-ip=193.136.128.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="LL40N9/1"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp2.tecnico.ulisboa.pt (Postfix) with ESMTP id 4D7E4245475;
	Wed, 24 Jan 2024 10:30:16 +0000 (WET)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp2.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp2.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id IyU5-JFK2aih; Wed, 24 Jan 2024 10:30:14 +0000 (WET)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [193.136.128.10])
	by smtp2.tecnico.ulisboa.pt (Postfix) with ESMTPS id 0AAF424550C;
	Wed, 24 Jan 2024 10:30:14 +0000 (WET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail; t=1706092214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vaM8GoQBuR9IqAMYNSv4ZJfgDsTGjPYtjrOi0zLDe6Y=;
	b=LL40N9/1hlWpnG+4UDHZm+rcnVFIvoNwQCf0VjqfcDz2uWrOTYyoo9KaZvRLgWjqi/grD7
	N+3kR/W9f6ITeGN4Li1drKXga9b35SCI9yXFdJMDFrURyAuj5t1B5vWcFuGl2XfUqevdEn
	QMYeBG3xGrUcX9yTZf21R4bIk/cYXrw=
Received: from diogo-gram (unknown [IPv6:2001:8a0:7ae3:e700:a921:1147:531c:b1e7])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id B878B360097;
	Wed, 24 Jan 2024 10:30:12 +0000 (WET)
Date: Wed, 24 Jan 2024 10:30:09 +0000
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, thierry.reding@gmail.com, 
	vdumpa@nvidia.com, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	baolu.lu@linux.intel.com, jsnitsel@redhat.com, jroedel@suse.de, 
	linux-tegra@vger.kernel.org, iommu@lists.linux.dev, regressions@lists.linux.dev, 
	diogo.ivo@tecnico.ulisboa.pt
Subject: Re: Re: [REGRESSION] Failed buffer allocation in Tegra fbdev
Message-ID: <xwvre6uqvakg7aqrnkxa3xrek4rkjoj36isiip2iphzanmmxch@gzqrwgqeljsi>
References: <bbmhcoghrprmbdibnjum6lefix2eoquxrde7wyqeulm4xabmlm@b6jy32saugqh>
 <20240123151508.GR50608@ziepe.ca>
 <1754c86c-704e-4c80-93c3-1b75a9a247df@tecnico.ulisboa.pt>
 <b0334c5e-3a6c-4b58-b525-e72bed8899b3@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0334c5e-3a6c-4b58-b525-e72bed8899b3@nvidia.com>

On Wed, Jan 24, 2024 at 10:15:34AM +0000, Jon Hunter wrote:
> 
> On 23/01/2024 18:44, Diogo Ivo wrote:
> > 
> > On 1/23/24 15:15, Jason Gunthorpe wrote:
> > > On Tue, Jan 23, 2024 at 02:33:15PM +0000,
> > > diogo.ivo@tecnico.ulisboa.pt wrote:
> > > > Commit c8cc2655cc6c in the recent IOMMU changes breaks Tegra fbdev
> > > > at least on the Pixel C with the following error message reporting
> > > > a failed buffer allocation:
> > > > 
> > > > [    1.857660] drm drm: failed to allocate buffer of size 18432000
> > > > 
> > > > This error message is printed from tegra_bo_alloc() which is called by
> > > > tegra_bo_create() in tegra_fbdev_probe(), which may indicate that other
> > > > allocations would fail as well, not just the framebuffer.
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
> > >     if (domain && domain != tegra->domain)
> > >         return 0;
> > > 
> > > Will happen and the domain will be left at IDENTITY, while I suppose
> > > the tegra_bo_iommu_map() assumes the domain was switched to
> > > tegra->domain.
> > > 
> > > Does this solve your issue?
> > > 
> > > diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
> > > index ff36171c8fb700..15c7910b2e1c76 100644
> > > --- a/drivers/gpu/drm/tegra/drm.c
> > > +++ b/drivers/gpu/drm/tegra/drm.c
> > > @@ -960,7 +960,7 @@ int host1x_client_iommu_attach(struct
> > > host1x_client *client)
> > >           * not the shared IOMMU domain, don't try to attach it to a
> > > different
> > >           * domain. This allows using the IOMMU-backed DMA API.
> > >           */
> > > -       if (domain && domain != tegra->domain)
> > > +       if (domain && domain->type != IOMMU_DOMAIN_IDENTITY &&
> > > domain != tegra->domain)
> > >                  return 0;
> > >          if (tegra->domain) {
> > > 
> > > > This may be connected with an error in of_iommu_configure() that
> > > > became visible after commit 6ff6e184f1f4d:
> > > > 
> > > > [    1.200004] host1x drm: iommu configuration for device failed
> > > > with -ENOENT
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
> > Yes, this does fix the issue!
> 
> 
> I am seeing the same error message on Tegra194 AGX Jetson. However, the
> above does not seem to fix it. In this case it is slightly different as I am
> not seeing the DRM allocation failure. In this case, it appears to be the
> of_dma_configure_id() call from the host1x_memory_context_list_init()
> function that is failing.
> 
> Jon

Just to clarify, when you mention the same error message which one are
you referring to? In my case only the drm allocation is fixed with the
above patch, and I am still getting the ENOENT.

Diogo
