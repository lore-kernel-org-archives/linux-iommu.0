Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17353CCFC0
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775830439; cv=none; b=uIN22I6+HP8Hyzurlyt4z+kdStGBLeuc4F1qPG9awIXcLDHftZ+LK/0DSFEpmajaSuszD5ZJgPaZlotXgU6MgeDKR6Y1FPzv1nNG/vCnjYs+YvjYyt1YIUMtgBIl0mNzMQUkp9jGx1aTq9U1UY+OtGC7FNWBGXfUOPOYp6vahhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775830439; c=relaxed/simple;
	bh=iPhEiy24SS6DLk7/lMwIEBiaN0YnL4HabWYQJpkGR90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7bbPXkcbExpiG79koVN6H4k/4RrBjAXe3ObnkPqWI78Hc9R7SZSQo6rsJJMLD5ym6ix8R9srcRif8gCEsJehd4035vsFGmY1KXtTEkvKQlqjfs9rWx8GpxKkfRxfwvwG4JkX1DYXpA/+8ugg8yQ4eJMbhLXOull9STbCUPrrCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fd6jMo+a; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fd6jMo+a"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-606045ef716so1203766137.0
        for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 07:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775830437; x=1776435237; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GPq9o9pk0JN/SIH/9GYQOf/hDgTAKyNjdrn/YjKiJAs=;
        b=fd6jMo+ad+5zgMgk7ZioT7BlK9y/PGLeEWei9xrpy6AGgVHSXxG49C3emjLwYIBXi9
         9C8kPLW9RxVFt4b1Def3M/i0bcBWVrXSlBd1qYF/2Hk5n20jhlJkA/+UvJu/x7WUlkfz
         tV76cE2+BcGa85Pnje/7aLFwi2i6Js2M1AFndkwjsT68oVK3bCZQqSdX8xycpb7Jyiuw
         hroUdpaMK+GIv/tiy+dcXmEGhWhqgnstHE9YsgCG8T+SG3odRReRK9ALhjND8nujOiTQ
         JLvaGbDws5pc2GLa6jwkxgeuLKAoa+nwR2J4VUzq1loLriQz8eW6qbhjaRGMcFDXoKnP
         m4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775830437; x=1776435237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPq9o9pk0JN/SIH/9GYQOf/hDgTAKyNjdrn/YjKiJAs=;
        b=aZe9OW52fjIzf2F9qBSa1SYjzK3P9+hrkoHPoqngT+V9Ag2+OID4y3BndyWpSd4LMW
         Ro+6v+Dnor4kfYRgfby5TqMe7YdEmi1JyCPfJShrs8tq6vSniMrjAUvsoQeeNNPhczG3
         YPb6bQnTalcZTyPk1odvROqm7d8dKrUJVAvMcX9wkWzjyI7RuBSBg0FvfIQ3xuwpp+7z
         /U1Xix1I4aJkeMeJ/Q0Ce0rfE2PyYj+EdqWWtSuP08/KmxGPEVkEtdNdVdtL3EbHpM5n
         9riy6Pvb0eM4L7dH6WKluF4uuRjmxCULiVIiPIYzxjc1EegdSNDQdiYPEDuOb0kJWna+
         c5gg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ0FZF5Q7DmV4ixZZn9YtYZ8i7J0j6ALWOrhRI8LzEx2RYemAeWosZN9yCSWc3xTl0YPV4OA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZz16c+MExIV0WAqapO3xmeAA94fwpo/87BJrdBAU2ogGjytU4
	z4D5MjfYKcXT5eCSkJbaz99xYWyua2ymgOueU8P2lxRNyr1C0yY39H5XAR/uxirxXqs=
X-Gm-Gg: AeBDieu2WTXvukQXmzz5OJjl9rM6dPDhRs1Yziylytsl4cYjFE7kt5iN/tZDr7cIt+G
	LrcqksIkZNLv4se1bGv2H0MqaR3H/++N07ykakm9zX/rrL3WTM3pbQhTG2HL1gsnfxpEFVIeMm6
	1hMSteJQU6X33cK6ZXKfPsDSrGqD8H/12HKfdNgN0YT3tjkxclCrKhxrfZwzVIGauUQ81ZHKEcV
	QdsmHlNxFUCzMKT4+eakPX8wSVrNNfGQTrPg7z5q1tfn4tZd+83KrtVlJ5NpdAe2x3QUewAM+hU
	c+rGfbvbzOWu7nkXA+FpPbuJKsELZ4eu3+lXzqS55ZhecY/SeWBapMZCEPBW81NqPN7vKo6C6u+
	9ke0fWTHt/8cvOSCHLVoOHUhzLKRg3AsTuKUQK2mkISiVgILFCJeDNd1MTabVp0JOOhcqtL40mq
	XOeAr3IshHFxsbeB+6jcIYbgoHNuLboGdjbQ4a60dhBPASlZ/8cL+DpuFL74azBFhTvbZvzw==
X-Received: by 2002:a05:6102:458a:b0:5ff:cb2c:a04c with SMTP id ada2fe7eead31-609fe8a59b3mr1426468137.1.1775830436845;
        Fri, 10 Apr 2026 07:13:56 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84c464a4sm24186486d6.28.2026.04.10.07.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 07:13:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wBCcN-0000000EKCb-2LBT;
	Fri, 10 Apr 2026 11:13:55 -0300
Date: Fri, 10 Apr 2026 11:13:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pranjal Shrivastava <praan@google.com>, Ankit Soni <Ankit.Soni@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 04/14] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
Message-ID: <20260410141355.GU2551565@ziepe.ca>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-5-skhawaja@google.com>
 <d3wmnc43r3mir2emoitj432j3bfdw362dqmkvywa2qvu5tskb4@oqjkseil5i54>
 <af4h6wh75qdvgu27td43ndlxdyb5drq2pf7tssdsln3q5gce6f@6su7ylrgomhz>
 <ab2Dkn605sRbpK5S@google.com>
 <ab2KDEatYbSZJVfC@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab2KDEatYbSZJVfC@google.com>

On Fri, Mar 20, 2026 at 06:12:28PM +0000, Samiullah Khawaja wrote:
> > > > > +void iommu_restore_page(u64 phys)
> > > > > +{
> > > > > +	struct ioptdesc *iopt;
> > > > > +	struct folio *folio;
> > > > > +	unsigned long pgcnt;
> > > > > +	unsigned int order;
> > > > > +
> > > > > +	folio = kho_restore_folio(phys);
> > > > > +	BUG_ON(!folio);
> > > > > +
> > > > > +	iopt = folio_ioptdesc(folio);
> > > >
> > > > iopt->incoherent = false; should be here?
> > > >
> > > 
> > > Yes this should be set here. I will update this.
> > 
> > I'm wondering if we are silently losing state here. What if the
> > preserved page was actually incoherent in the previous kernel?
> > I understand we likely need to initialize it to false here because we
> > don't have a dev pointer for DMA sync operations at this low level (though
> > x86 uses clflush).
> > 
> > But when is it set back to "incoherent" again? I don't see that
> > happening during the driver re-attach phase?
> 
> This can be done during restore_domain as the domain has a reference to
> the dev when it is recreated. I will updated the walker and add this in
> the next revision.

The only reason for this tracking is for DMA API debugging. It might
be better to just remove the DMA API from this path and use a direct
cache flush. Then you don't really need to care, the successor kernel
never writes to this memory so it can just free it in a normal way.

Otherwise you have to remap it on restore so you can unmap it on free.

Jason
