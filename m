Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887DB5FBA4
	for <iommu@lists.linux.dev>; Tue, 23 Jan 2024 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022913; cv=none; b=iKcNFjx+7elme48PmhGoXMoxCIT6dH5co7hmGX6nWVEUKd76fmtXeZAk7DZaNWF67XMMcDjTbaLuQR9zp82cheFbgSDj8cEXKTsDz1gkdY2FLdeV2wIZ37ABChW3BB3GtfNQYQH3tAmRIOfMAGDWwG+eF2fMYA3hlXqhv2wbEfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022913; c=relaxed/simple;
	bh=n4aKyCFKJuExlOWApUvz7Zfciv1d3oX2QNBwJUO9e+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y33TqiSktGaoFCxJ8w8p9Wmv+eq1D3eeCo1zqh3FCE73ahvMqWNBa5I+v8cmbvbvTEFJ1QGLKXMytn/R23soc+DMRDzH/jfoCmXYIIA4oMhz6ENlckFqpiIvPPl0o2tzUHvnHCDJUQM93NPD8EllAU2LPKDHP1+vGrgaKTLLSb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=P0S+H4KU; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="P0S+H4KU"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-595b208a050so2674676eaf.0
        for <iommu@lists.linux.dev>; Tue, 23 Jan 2024 07:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706022910; x=1706627710; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MHNoRtSB2f+BsOY5sugFL7ytw4mgbMzlvlkFVSEzn+8=;
        b=P0S+H4KUTY3OFcq194UMlFRPfAWg+rBqcBXg9vwTk6mhVyjkF4DDI7TF8QwQka8vDY
         RyP79NwzB1RfKX9wr1B5y+aJhuWUm0xbGK0zV1Wrzrap3xWNujZBIz6SCPj6cRTYSBpG
         aW7r0Fem3oWhRdk/fmzQyjVojchT9gkACODq8vai/mCsptvypx94uaO56MMcHGDEY7FM
         GX8OY/Kf77H7yFvkEcP+NLNitCBlv2+BquuSnjjdEUiJ21P3O7p5U7mTqQtS0vQUbGMj
         PkkmGCVNJ8h7WJKv0o/WV3UFxMKhomS5edjgZ0po5CNZ4XfeeVtPkmd+h5kIjnzy/bo0
         4LQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706022910; x=1706627710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHNoRtSB2f+BsOY5sugFL7ytw4mgbMzlvlkFVSEzn+8=;
        b=Xvyms0qGAPEDTSZbuv0zHIuwUjGdieILJ+3xO5jxpHuKUSYDRqrKy+tF7WZBsoiP/F
         EVU1VSroE1lgFxxytL3RAzSJaX2boJFMhG+MRH6DKL8MRUXw4Z+M3ACQmct4Q5g/jgyf
         IE+xMJIygY1Hz9jpd105wKCVSoG73tkr+UW0+Yvg9aOczNMsAsaRYVOmTjuDIW08XSIT
         1mDzH2cFDoaGv4mgTrdHAVVmKCnKK4xQAaFwsRFB24fGsx9vUnsFWXHDBxihmHuiiJu6
         NY2DPBnlFCcrcckYEgks8BG5uqKR2wu7yyKiPD8GPqUSvb5S+PmDEoK+5432JAuZe/DV
         iKsQ==
X-Gm-Message-State: AOJu0YxOBvOiCrG7cBYFZlhnz7B+7+U/Xv6mf/QE3Nd/om9k1ZMSnmRS
	a0sNIeia/qMjjoz55APtWx4REaBZM/JXiYrVa7uddTTBwFdojRmtf/NQzzM5obA=
X-Google-Smtp-Source: AGHT+IFs6VWoElP9yTX8xaCrJxiGrvFQ3gsVb40KP5N9dQYO9uIjpSryFNmks3qJnHBtzHCdqNr6Hg==
X-Received: by 2002:a4a:e652:0:b0:593:f906:614f with SMTP id q18-20020a4ae652000000b00593f906614fmr31438oot.4.1706022910259;
        Tue, 23 Jan 2024 07:15:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id g13-20020a4adc8d000000b0059984e8d5c0sm974274oou.44.2024.01.23.07.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:15:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rSIUW-008JEi-DG;
	Tue, 23 Jan 2024 11:15:08 -0400
Date: Tue, 23 Jan 2024 11:15:08 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: diogo.ivo@tecnico.ulisboa.pt
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, jonathanh@nvidia.com,
	baolu.lu@linux.intel.com, jsnitsel@redhat.com, jroedel@suse.de,
	linux-tegra@vger.kernel.org, iommu@lists.linux.dev,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] Failed buffer allocation in Tegra fbdev
Message-ID: <20240123151508.GR50608@ziepe.ca>
References: <bbmhcoghrprmbdibnjum6lefix2eoquxrde7wyqeulm4xabmlm@b6jy32saugqh>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbmhcoghrprmbdibnjum6lefix2eoquxrde7wyqeulm4xabmlm@b6jy32saugqh>

On Tue, Jan 23, 2024 at 02:33:15PM +0000, diogo.ivo@tecnico.ulisboa.pt wrote:
> Commit c8cc2655cc6c in the recent IOMMU changes breaks Tegra fbdev
> at least on the Pixel C with the following error message reporting
> a failed buffer allocation:
> 
> [    1.857660] drm drm: failed to allocate buffer of size 18432000
> 
> This error message is printed from tegra_bo_alloc() which is called by
> tegra_bo_create() in tegra_fbdev_probe(), which may indicate that other
> allocations would fail as well, not just the framebuffer.

Presumably this is because iommu_map_sgtable() under
tegra_bo_iommu_map() fails?

Which I suspect is because of the logic in
host1x_client_iommu_attach().

After c8cc2655cc6c iommu_get_domain_for_dev() will never return NULL.

So this:

	if (domain && domain != tegra->domain)
		return 0;

Will happen and the domain will be left at IDENTITY, while I suppose
the tegra_bo_iommu_map() assumes the domain was switched to tegra->domain.

Does this solve your issue?

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index ff36171c8fb700..15c7910b2e1c76 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -960,7 +960,7 @@ int host1x_client_iommu_attach(struct host1x_client *client)
         * not the shared IOMMU domain, don't try to attach it to a different
         * domain. This allows using the IOMMU-backed DMA API.
         */
-       if (domain && domain != tegra->domain)
+       if (domain && domain->type != IOMMU_DOMAIN_IDENTITY && domain != tegra->domain)
                return 0;
 
        if (tegra->domain) {

> This may be connected with an error in of_iommu_configure() that
> became visible after commit 6ff6e184f1f4d:
> 
> [    1.200004] host1x drm: iommu configuration for device failed with -ENOENT

Hmmm

This is a new logging, so it doesn't necessarily mean something has
changed in the code flow.

It seems the issue is something in there is returning ENOENT when it
probably should be ENODEV, but I haven't been able to guess where it
comes from.

Can you do some tracing and figure out where under
of_iommu_configure() this ENOENT return code is from?

Jason
