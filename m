Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C835A20B808
	for <iommu@lists.linux.dev>; Mon,  3 Feb 2025 17:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738604616; cv=none; b=FQjHe1u3JbEDdo+LELmz74QOYMFUIBTccCgiW4MlPsk6vH+VyQ/R2v0AM0vpFv7rYTAQTYk+hvMRRp9qYInE5Y9CzfrjBDl71SqVk3J4y9GsHnS94y2S/VT+9ZNR4MgW041jyxDJpj1tIjSIMpeXeXu1uNpuESlVUFwHemp+yRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738604616; c=relaxed/simple;
	bh=HHQvq1hJ98PippRm2rDdDIdnVNDSMuo8a6rmO/CZD40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiztODWPNgz0KXxd5P4y58KaqABX81wUPV6Wjfd40cUI+OH85N9v0yaQoiDf4GrRe/kFP2Ul7808SkXJ+ExqIqjSO2Y4Hz/gL7HKjSH1giwBBp+Q1j+pbfD8LbXC+HxKHoDG8CeOsDKU+XaEOsTLngvf2LZam5q58Wa9zGRy4lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hY2VtmJh; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hY2VtmJh"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6dd16e1cfa1so33754556d6.1
        for <iommu@lists.linux.dev>; Mon, 03 Feb 2025 09:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1738604613; x=1739209413; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5W3K6ML6p4e0xZMOmmJdUcdAoVitAI41yHN9TtTI54=;
        b=hY2VtmJhWKSG6EoX2sJKYr8fAUQr9R1JauNN9Zv5Ef8mmVUMt8gmyxIV2ptleg3CEv
         tEYQpmmmEuTR6gWxG9DOUVZD7v7Ie9IbjmoTJ/A57q3Ttcq7leQbzhm80JfW+I/am+qS
         H9D2C6V+TaQJNXh6Hg8Cm7Y+Dig7NSm/E3kq87TL+ZUZYoKCSvqAkovIWvKHf/7Mdeqm
         udHEneBe6S2WPpdK+O52XlvhcCR6hswVZguLI8FsKNEgDlAc0dd9r9gsBS01o2gAAyFY
         x664ODXswMH+0jUweVcFYzDI539w+2ZGKHDUc0x8lgy8RXkb91TAebGCLb3GT6nxnNMz
         y+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738604613; x=1739209413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5W3K6ML6p4e0xZMOmmJdUcdAoVitAI41yHN9TtTI54=;
        b=Iq7IIzeawyF8pU3Usagw3uQYHP8qRnT49HUViK7muOe8fjJoUVSAsW/bX9VIDp0YLH
         9PdlP34U0lRHKre5wBMazmw5VEt2WeqaZaaZzbYNfPCvbcQDcRg271/Dc4f7Epy/wn0s
         78vcJrsSX3EWuNcP6Zv/aZAdmOl+J5xZFgpWysWbsj6Qmjdntzr03z1csksh9YTTrTdd
         Unr848eHPb2Xh3rlvUkvSIQp1sULneIBfcSJqixTrlVHENritPU0wp5L1dYdtdjgrby3
         DCBAvi05mxQyix03NeWRzZqn5sHR10aPzKRBpWW3fJ92q8jw1QzrmyJr3jxPJVmgk4kf
         Zsyg==
X-Forwarded-Encrypted: i=1; AJvYcCViWFXyUjYD1468ZJZrHHrgIxz/+jeH444/Tats8Xrdryua2NK0zr0flMORFOA0/VjTEn05Yw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVwFXb72v+EXZP+aKTBIB8evrMdMKW+pFX79ebOglBONh8Z9jN
	RcIA9oWxzS/DUlLu5IaqtJaU6tbWXVfHAAwaOBURVQTEUEfOnI4QCEdC1w/BCCU=
X-Gm-Gg: ASbGncsPHvY8ibHloaQe0acZDuA1sruZeumz0HRG7727u/Ry+SU0F/pRmvdb6TX14h5
	w8ylYxgEzGdpp1BMLYHqr3n+/FSS1Q2aacanmmxjxZxq9GHSAkyXJIfcDl4LcpuQmw5we5jBK6h
	ZCWAcb8TgNstLOSCtQ0oTHVZDTaes0tB9RQsVEBZS1KnWqphhs6ahBdJvmdIvj1Wgnn0N6u2N/2
	nC5X2tQzOdDZFfyO/HQjlS1UWQXlisn4gq30qrsOEsR3NpiXv+l7G92kDwNkjZb/Po94iSsSc3v
	cCYSMW1oZHukfrmUoPG+ceyIkFXVxxsXcQoTs+SNV0KPXRaww3UO+YlceR3dOJs6
X-Google-Smtp-Source: AGHT+IHm7uv9N7X8wM4h9+1EaiklQFdNCX+3gAebwLRk5Q4LNZSNvZzf3U5GFdZCMaWbNR1xrzU4/Q==
X-Received: by 2002:ad4:5de3:0:b0:6d8:876e:ef41 with SMTP id 6a1803df08f44-6e243bf3c79mr338472586d6.21.1738604612660;
        Mon, 03 Feb 2025 09:43:32 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e254922543sm52478646d6.74.2025.02.03.09.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 09:43:32 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tf0Tr-0000000BJp1-2FvQ;
	Mon, 03 Feb 2025 13:43:31 -0400
Date: Mon, 3 Feb 2025 13:43:31 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, jonathanh@nvidia.com,
	baolu.lu@linux.intel.com, jsnitsel@redhat.com, jroedel@suse.de,
	regressions@lists.linux.dev, linux-tegra@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [REGRESSION] Invalid gather when using Tegra210 media engines
Message-ID: <20250203174331.GF2296753@ziepe.ca>
References: <c6a6f114-3acd-4d56-a13b-b88978e927dc@tecnico.ulisboa.pt>
 <20250203170617.GE2296753@ziepe.ca>
 <4ea1a48c-9020-4793-ac9b-b51fc289e442@tecnico.ulisboa.pt>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ea1a48c-9020-4793-ac9b-b51fc289e442@tecnico.ulisboa.pt>

> > How about this:
> > 
> > diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
> > index be2ad7203d7b96..090b1fc97a7309 100644
> > --- a/drivers/gpu/host1x/dev.c
> > +++ b/drivers/gpu/host1x/dev.c
> > @@ -361,6 +361,10 @@ static bool host1x_wants_iommu(struct host1x *host1x)
> >   	return true;
> >   }
> > +/*
> > + * Returns ERR_PTR on failure, NULL if the translation is IDENTITY, otherwise a
> > + * valid paging domain.
> > + */
> >   static struct iommu_domain *host1x_iommu_attach(struct host1x *host)
> >   {
> >   	struct iommu_domain *domain = iommu_get_domain_for_dev(host->dev);
> > @@ -385,6 +389,8 @@ static struct iommu_domain *host1x_iommu_attach(struct host1x *host)
> >   	 * Similarly, if host1x is already attached to an IOMMU (via the DMA
> >   	 * API), don't try to attach again.
> >   	 */
> > +	if (domain && domain->type == IOMMU_DOMAIN_IDENTITY)
> > +		domain = NULL;
> >   	if (!host1x_wants_iommu(host) || domain)
> >   		return domain;
> > 
> > (if not can you investigate this function's flow compared to a good
> > kernel?)
> 
> Yes, this worked! Does this mean that with this change we go through the
> path of using the shared Tegra domain (for example in the driver I
> attached client->group == true), and if that is the case would it be
> beneficial for us to try and change tegra_smmu_def_domain_type() from
> returning IOMMU_DOMAIN_IDENTITY into IOMMU_DOMAIN_DMA so that the
> dma_alloc_* functions are called directly?

I do not know the answer those questions.. The whole rational around
this host 1x domain stuff is mysterious to me.

It does sound quite appealing for the implementation to use the dma
api instead of attaching its own special domain.

Jason
