Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D527403E8E
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566152; cv=none; b=DujAWcipwUdPHbNITNz2cb3ldeW4ESNoSfYLl38KLimFZmAuJPW9pHKdoZbb3/9WO72/MWTs2dxy4z3kES9VK555wk3jNM75QxdJVGubXNCpe07W5QMFyMYf+id4lmj9fJclm3wFY3DFQPWFvPlMCzzwRkm/WsjwPAbKtvOvBgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566152; c=relaxed/simple;
	bh=jZ3eIBAHAm6NC6JweAvN1qywHq5vfH1TyeQwkHsYg8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXN8SDalMhbQGrou20IHjgxsUZs5rlD7DvVvcyzSWuZM7kv9mcdkZkvs3RlLmeqO92C+ZUcHuE3TvvOWdr0OB/YEzzmfUD9G1JgLPrEGYXLlzMhXjthnEcAxwcfMi5nxbewnZw9qNDzYL+HYdeXtttU+svSX4cYVRsEt9sRm1vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tV04EhfX; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tV04EhfX"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d3b440b97aso133745ad.1
        for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 03:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787566150; x=1788170950; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+gfNd3h+FFiDmANrEuut7wHc99xGFyUDuhgOjn5RQ48=;
        b=tV04EhfX9I9wWohNgVfK5ukRF8Q/gl2C7yOlRSPRSYvW6vT/DE2lbMIeX5iE5Fsz3H
         FGDFi9OW1Wdie+tDIwRWNDyodiX75AsMD4eF1IfwDVZ1g4aMVzqJ/puykJLK79Hu8pAG
         Or297g0UYRUPpk6NGlCt2M5XFiQZ7HSjVfXjEBRXN+VNr20wAFEelOfbMz011F3QSLD7
         ahc9VL0Wt5Q2AB6JT1DuXvhaMqfYJWur81GXVmQMWJU2gC5P97t0G4AESTa/hoCnxLb2
         RjV9RxAq7gMGWcEzKZlHIyuwVAY9sqkBO9G8EBNrof+8QogbSwvhu0dqqwiHDHbXg/8P
         bocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787566150; x=1788170950;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+gfNd3h+FFiDmANrEuut7wHc99xGFyUDuhgOjn5RQ48=;
        b=T/c15iEXjMF31ZNPWHdW9ksmH6OqIsn0DL9QrVMSkct4pVXXSrv2dFq5e6oJkHiMTw
         gx0OfuItW9aoFn2kaIJeXg9IxbkY95lIGZeo16aEBCySOiE8tcOkWixwMJD3kBlcu0cF
         Tbkh/Ilj04dxQ3YvuR94did2L2/w0W8XEnTT2J2v9Ai/J5X8JnxotUzkacq/lKqVm/aW
         iI4Wmnxm7XfCOF6K0HunfiwXqZ1a1cQk4yErtb+HqLnVmorR2v1m7mAJkZaCn8iaY4On
         KSFDh1mz3zuBNKCIBYBw/FEGebOeLA2hW6cav3I0NfrFpslWl4c+IOrVLiTSuQ5heGSJ
         42Kw==
X-Gm-Message-State: AFuF++k46GyhqcAWinhMYFciw2jkpoESzPzEtoIzVu5MIaQTl6TARIeM
	C3yRw4pyBNWiFKJ4s+AFwB94FYQ9r9nyt7ZO3kzlfb09zGMHXRDgiaNf7LceIy2Jtw==
X-Gm-Gg: AR+sD13ymgF/C9w+eNWByLZ83UF9rin0bCyZ8A2eErdQRXnDktFU8CLcLN2qqvVhnIl
	uiHHr91Zrvb6f7JDSetu0ib1bVJtIpywCAMPIve3d3fsQifdVqU9bZOWdaqDDnVF8eyOlceK1Hn
	8b8Z8zKKJLyVSgwox0slciQQDQoUaAN9RzQFc4AsfmVIjfsZ7YUDn58VxUh6vjmKXfOSaWx/nG4
	zOZbjePSxlrcikIQF/PehhxwzudTea4oNXXW0mLY8i7qFjIO/5leAUw8KsVw0YTAnwp7s0N3Iph
	/9fbN3w2XHRxSIRWYwPxnNpxOskTaFNaYq/ZkOaebq6OO8yYWN7FNh6v+pY/Ld+D66MK2ObJ3yQ
	UuKbbyi5WtszYnU7gQ3JbvPdeHi2xx12t3xhwy3gCIqMu+PGZFxU3z5SNEZlytKQB4W6sjQSQzr
	49HiIeHULKwBG6RWWazi5a7I5qGVUptlWKiMGBMouliLMq1DtRHYJ+kxup/jDXqU4HP9om0eYmJ
	tY9QbqUwxkyot+zBT0XVx3qCuse8SBMDsPL
X-Received: by 2002:a17:903:2acd:b0:2d5:db38:8013 with SMTP id d9443c01a7336-2d66fffe95fmr8900965ad.18.1787566149624;
        Mon, 24 Aug 2026 03:09:09 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b240e7sm9398937a91.13.2026.08.24.03.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 03:09:09 -0700 (PDT)
Date: Mon, 24 Aug 2026 10:09:03 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] iommu/amd: Fix DTE clearing and rename
 iommu_ignore_device()
Message-ID: <aowYPxhzGKMLIU10@google.com>
References: <20260814015647.3370124-1-praan@google.com>
 <20260814015647.3370124-3-praan@google.com>
 <3032d568-f23c-4e52-9303-5816bb2e2372@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3032d568-f23c-4e52-9303-5816bb2e2372@amd.com>

On Sat, Aug 22, 2026 at 07:28:20PM +0530, Vasant Hegde wrote:
> 
>

[...]

> >  
> > -static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
> > -{
> > -	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
> > -	struct dev_table_entry *dev_table = get_dev_table(iommu);
> > -	int devid, sbdf;
> > -
> > -	sbdf = get_device_sbdf_id(dev);
> > -	if (sbdf < 0)
> > -		return;
> > -
> > -	devid = PCI_SBDF_TO_DEVID(sbdf);
> > -	pci_seg->rlookup_table[devid] = NULL;
> > -	memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
> > -
> > -	setup_aliases(iommu, dev);
> > -}
> >  
> >  
> >  /****************************************************************************
> > @@ -2233,6 +2217,41 @@ static void dev_update_dte(struct iommu_dev_data *dev_data, bool set)
> >  		clear_dte_entry(iommu, dev_data);
> >  }
> >  
> > +/*
> > + * Invalidate a DTE by clearing the Valid bit first.
> > + * Note: Not to be used on a fully probed device with
> > + * live dev_data.
> > + */
> > +static void amd_iommu_disable_dte(struct dev_table_entry *ptr)
> > +{
> > +	struct dev_table_entry new = {};
> > +
> > +	write_dte_lower128(ptr, &new);
> > +	write_dte_upper128(ptr, &new);
> > +}
> > +
> > +static void iommu_disable_device_dma(struct amd_iommu *iommu, struct device *dev)
> 
> This will disable interrupt remapping support as well. May be we should rename
> this function.
> 

Ack, Sure. How about iommu_disable_device() ? 

> Otherwise patch looks good.
> 

Thanks,
Praan
