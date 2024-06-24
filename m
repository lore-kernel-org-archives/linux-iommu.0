Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3461B964
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246778; cv=none; b=iDA3B2nx48OwGWmUH5GLUTOZnKafxGbKf2kTC8o0RAGqQ1puAnfodqV7TE9xzqh/yY0Qx1Xal2H1BbbfWYfrfm9yPLHN0zyb/E8czOwiiVQxg+EurUxuESj1U3y9+G+MJo18PGC1q/A2wzRFemXc38sXw8fy02KHc3ihLsTevZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246778; c=relaxed/simple;
	bh=pEctCYhfX+txPA9RV0NFZWhrwAagSnrKo2rwosjRRcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzaB479wyxOroxUx9gGXJ+82yDy74Zfz1tLO2H3CmYKmFM6fL89107x+c9UUv9z8Q1shxzk3Zup26Tw34c25VJ35v7fw5uyqq/qA0MAMWdmLsWXelF189faY+86SyVWldmBcoZX0Cdrv3AQU+obVQFmNgJ61CdKavvcmYaImwAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=m81+sFWX; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="m81+sFWX"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b50aeb2f31so22423506d6.0
        for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 09:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719246776; x=1719851576; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YpMz2kHegp9vo5OTJS7oY+W3qVaSD/B67evxfsa33FE=;
        b=m81+sFWX8tGwaR2H+P8lbLCot1OoZ/i+fe5sDIB8oPIPOILg7iWJCL0SXg7knguAOV
         Wl/3qBf6Ewg92aW2ysQ2RC7HfXv/XQbAvZCZzyGTWUcxDSMF+wrRkSrgj0rvOx2gCFib
         S2lCjAI7tO2rEG4l3VCTbXuDpp1htqudKAfauT6SnTtIi25X4x971KrPU9UuJxrYSVj3
         nENGLnaR7pECXSFz2ZIZoAB5ufNsLPLfn3+SrbvMTjd0RJFvlPbHn79Pxv9P/0/RGMSW
         KK4oYk8y+cGFTDEpIdVLwXUfuuLKaFO3eFqC90iDl0Zm5EX2e/XlXFLhfnY6t/qiADaA
         q2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719246776; x=1719851576;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpMz2kHegp9vo5OTJS7oY+W3qVaSD/B67evxfsa33FE=;
        b=FM+dXvNszxkYWpqAmREK/96K9/BNBkSe7P82HM5za7WfUzOkA7ouc2Cm6e/beN2v32
         rTdJRtPzOxfA9jV7IxMlles9Iz505m/NEW/aksQq+pNxicSwJl7yVHUrJQTF8oMmMhyA
         8bHv1B1SqPk+AhgJBtBUMCXHATCfjttAXI2WEAYh5AYPqeGXa+a3QSuWVWqcAoFvi2zh
         mfShrJLXuw1aTeAIBOIHHDJGigqjwhRXngxOUkSgbRt4pwi/qEbCgA9FuCcZ01B9CV02
         efng+vurXQt/x7mhjp59P/aFh+PLkyaNBZzqVXXmusuK5JQ56d725+prA3/uOe414fwW
         3zIw==
X-Forwarded-Encrypted: i=1; AJvYcCXePyRAarG7/rWwsn2PHsULOOXunAmuZ0SsgE6cGobqXGsOhly9b3zpPJJBwORfwO8qRvm+yAsT53/6e6WaTLHP9KsgtvY=
X-Gm-Message-State: AOJu0Yxh4+B1vs0ADrFdyVYtL+poxg8sx8x0sHJ7+RZwAtlwxl2mOLJ1
	EBHpXLlDOWg6FD0XZf7+gS+7dF9euhLaXdHciZ4MvQ7RojKuwGRGG3FOFWUNx9g=
X-Google-Smtp-Source: AGHT+IFVDnqWLATdM12qOV0Xx5fReCHDSylxa7RaE0YpsUi44goG84xt3tUjEqTTeXwKdKL1wee4zg==
X-Received: by 2002:a0c:f585:0:b0:6b5:1c0:381d with SMTP id 6a1803df08f44-6b540aa47d4mr55523686d6.43.1719246775914;
        Mon, 24 Jun 2024 09:32:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b534b6fb20sm22033996d6.58.2024.06.24.09.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 09:32:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sLmcg-006IKk-RH;
	Mon, 24 Jun 2024 13:32:54 -0300
Date: Mon, 24 Jun 2024 13:32:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Teddy Astie <teddy.astie@vates.tech>
Cc: Robin Murphy <robin.murphy@arm.com>, xen-devel@lists.xenproject.org,
	iommu@lists.linux.dev, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: [RFC PATCH v2] iommu/xen: Add Xen PV-IOMMU driver
Message-ID: <20240624163254.GT791043@ziepe.ca>
References: <24d7ec005e77e4e0127995ba6f4ad16f33737fa5.1718981216.git.teddy.astie@vates.tech>
 <da3ec316-b001-4711-b323-70af3e6bb014@arm.com>
 <a04e169d-b38a-43dc-b783-a8af1e1b0468@vates.tech>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a04e169d-b38a-43dc-b783-a8af1e1b0468@vates.tech>

On Mon, Jun 24, 2024 at 02:36:45PM +0000, Teddy Astie wrote:
> >> +bool xen_iommu_capable(struct device *dev, enum iommu_cap cap)
> >> +{
> >> +    switch (cap) {
> >> +    case IOMMU_CAP_CACHE_COHERENCY:
> >> +        return true;
> >
> > Will the PV-IOMMU only ever be exposed on hardware where that really is
> > always true?
> >
> 
> On the hypervisor side, the PV-IOMMU interface always implicitely flush
> the IOMMU hardware on map/unmap operation, so at the end of the
> hypercall, the cache should be always coherent IMO.

Cache coherency is a property of the underlying IOMMU HW and reflects
the ability to prevent generating transactions that would bypass the
cache.

On AMD and Intel IOMMU HW this maps to a bit in their PTEs that must
always be set to claim this capability.

No ARM SMMU supports it yet.

If you imagine supporting ARM someday then this can't be a fixed true.

> Unmap failing should be exceptionnal, but is possible e.g with
> transparent superpages (like Xen IOMMU drivers do). Xen drivers folds
> appropriate contiguous mappings into superpages entries to optimize
> memory usage and iotlb. However, if you unmap in the middle of a region
> covered by a superpage entry, this is no longer a valid superpage entry,
> and you need to allocate and fill the lower levels, which is faillible
> if lacking memory.

This doesn't seem necessary. From an IOMMU perspective the contract is
that whatever gets mapped must be wholly unmapped and the unmap cannot
fail.

Failing to unmap causes big problems for iommufd and vfio as it is
about to free to the memory underlying the maps. Nothing good will
happen after this.

An implementation should rely on the core code to provide the
contiguous ranges and not attempt to combine mappings across two
map_pages() calls. If it does this it can refuse to unmap a slice of a
superpage, and thus it never has to allocate memory during unmap.

> While mapping on top of another mapping is ok for us (it's just going to
> override the previous mapping), I definetely agree that having the
> address space messed up is not good.

Technically map_pages should fail if it is already populated, but
nothing should ever do that.

Jason
