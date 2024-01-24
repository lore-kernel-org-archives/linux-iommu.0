Received: from smtp2.tecnico.ulisboa.pt (smtp2.tecnico.ulisboa.pt [193.136.128.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3529717BB5;
	Wed, 24 Jan 2024 09:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706087613; cv=none; b=WmNiywcUZiRZI0EYK8w2mPr0lvyq6S7ZgPAGbtrZTA4+w0SuNxAeqjz5oiElBy5Bi7PG9Rzf6GRbl593XCm4ndI6+pHk2XRSjFsxxORgg7lFQNH+YCrQBu7T+rm8nKj7ZL7wMw+01jCUSNv0Gs6f3I9BtOvQPj5zesgH4q3vtKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706087613; c=relaxed/simple;
	bh=P77h9pldjT845sPil7ZvolWPejIXNFNVnKEqtNbnaqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYwTLqd+9p940Dcq6eIY67BV/UFBAek5MvsQSXOnSLUnSPyeZhAKxgU84CN/3bjznuVUdtl/AfTjci7dy48aOQO937ov2StWPt1bc+sc+uBU5Qx40QJRXzkT3LiykE76g2x57eYfkLCOGIvq+DBfyf/5KtEkoX/BwiTarlLELZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=U3JrMgjd; arc=none smtp.client-ip=193.136.128.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="U3JrMgjd"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp2.tecnico.ulisboa.pt (Postfix) with ESMTP id CFF9524540F;
	Wed, 24 Jan 2024 09:13:27 +0000 (WET)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp2.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp2.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id A9edH3296scr; Wed, 24 Jan 2024 09:13:25 +0000 (WET)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [193.136.128.10])
	by smtp2.tecnico.ulisboa.pt (Postfix) with ESMTPS id 9CD51245514;
	Wed, 24 Jan 2024 09:13:25 +0000 (WET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail; t=1706087605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6fmjg87vXXM3JvdEYst348LnN+bBgccIyZoK2clMtng=;
	b=U3JrMgjdWAD2JCvmaBZF10KBg3JaBOuveK49OIIBoGtdThQYy/JfMXwxReWMXlDPPXikxP
	PcpbLoKs/NgzGmGS9tvGIpoitugbWyIywnlvcgC32P2O2R82wLEkN+kDJld175q7ee2lL1
	BrGnHtWbnRMo9YtkTX2Er6V15UgxCkA=
Received: from diogo-gram (unknown [IPv6:2001:8a0:7ae3:e700:a921:1147:531c:b1e7])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id AB65A360096;
	Wed, 24 Jan 2024 09:13:24 +0000 (WET)
Date: Wed, 24 Jan 2024 09:13:14 +0000
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, jonathanh@nvidia.com, 
	baolu.lu@linux.intel.com, jsnitsel@redhat.com, jroedel@suse.de, 
	linux-tegra@vger.kernel.org, iommu@lists.linux.dev, regressions@lists.linux.dev, 
	diogo.ivo@tecnico.ulisboa.pt
Subject: Re: Re: [REGRESSION] Failed buffer allocation in Tegra fbdev
Message-ID: <pgund4coabp5pdlmwze5o2d7ogrdncktqz267yzukjcvmikudc@7svrwdci7ujl>
References: <bbmhcoghrprmbdibnjum6lefix2eoquxrde7wyqeulm4xabmlm@b6jy32saugqh>
 <20240123151508.GR50608@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123151508.GR50608@ziepe.ca>

On Tue, Jan 23, 2024 at 11:15:08AM -0400, Jason Gunthorpe wrote:
> On Tue, Jan 23, 2024 at 02:33:15PM +0000, diogo.ivo@tecnico.ulisboa.pt wrote:
> > Commit c8cc2655cc6c in the recent IOMMU changes breaks Tegra fbdev
> > at least on the Pixel C with the following error message reporting
> > a failed buffer allocation:
> > 
> > [    1.857660] drm drm: failed to allocate buffer of size 18432000
> > 
> > This error message is printed from tegra_bo_alloc() which is called by
> > tegra_bo_create() in tegra_fbdev_probe(), which may indicate that other
> > allocations would fail as well, not just the framebuffer.
> 
> Presumably this is because iommu_map_sgtable() under
> tegra_bo_iommu_map() fails?
> 
> Which I suspect is because of the logic in
> host1x_client_iommu_attach().
> 
> After c8cc2655cc6c iommu_get_domain_for_dev() will never return NULL.
> 
> So this:
> 
> 	if (domain && domain != tegra->domain)
> 		return 0;
> 
> Will happen and the domain will be left at IDENTITY, while I suppose
> the tegra_bo_iommu_map() assumes the domain was switched to tegra->domain.
> 
> Does this solve your issue?
> 
> diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
> index ff36171c8fb700..15c7910b2e1c76 100644
> --- a/drivers/gpu/drm/tegra/drm.c
> +++ b/drivers/gpu/drm/tegra/drm.c
> @@ -960,7 +960,7 @@ int host1x_client_iommu_attach(struct host1x_client *client)
>          * not the shared IOMMU domain, don't try to attach it to a different
>          * domain. This allows using the IOMMU-backed DMA API.
>          */
> -       if (domain && domain != tegra->domain)
> +       if (domain && domain->type != IOMMU_DOMAIN_IDENTITY && domain != tegra->domain)
>                 return 0;
>  
>         if (tegra->domain) {
> 
> > This may be connected with an error in of_iommu_configure() that
> > became visible after commit 6ff6e184f1f4d:
> > 
> > [    1.200004] host1x drm: iommu configuration for device failed with -ENOENT
> 
> Hmmm
> 
> This is a new logging, so it doesn't necessarily mean something has
> changed in the code flow.
> 
> It seems the issue is something in there is returning ENOENT when it
> probably should be ENODEV, but I haven't been able to guess where it
> comes from.
> 
> Can you do some tracing and figure out where under
> of_iommu_configure() this ENOENT return code is from?
>
> Jason

I did the tracing and found that the ENOENT is coming from
sysfs_do_create_link_sd() in the following function call chain:

of_iommu_configure() -> iommu_probe_device() -> __iommu_probe_device() ->
iommu_init_device() -> iommu_device_link() -> sysfs_add_link_to_group() ->
sysfs_create_link_sd() -> sysfs_do_create_link_sd()

The particular block that emits the error is

static int sysfs_do_create_link_sd()
{
	...

	if (target_kobj->sd) {
		target = target_kobj->sd;
		kernfs_get(target);
	}

	if (!target)
		return -ENOENT;

	...
}

Best regargs,
Diogo

