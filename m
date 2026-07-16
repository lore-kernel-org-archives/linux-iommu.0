Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22A542BEBC
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212062; cv=none; b=dHFtBBbJpqHYvL5yS5aYwcAIYR91KU7/qFAUXCR7B8avBT2ZhjC6R+vw/+swANNp23LpB5qc05hz1UgTQxYNeRl3GmmS/Vx3WD1J2mmR1HUlsSPz9AV998Mb2Pi63GRnHKevZlvzStEhC28wFSZ7bHDCEDDXfPK45nLLddUk4sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212062; c=relaxed/simple;
	bh=ZbUusZWAWiub6I5lspLkxQnCXKKW3t5+PS6RPFzQstU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsUnid+8pg5JBQpkjaVw+ijRsKKZM6rm7T2cOQMPopthUTEgJQk+QqzzMmeVwYECydgrqTfUVJcQIzBx21smzTowqEmuVgnYC0Y12EJMWEGz2MrXQaLP+1Gla1x2drZEv6IfjA5lzcR+b8fwfn8ylcoGML+bXiNFDxGr6XhLk6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kW2+bHva; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kW2+bHva"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c2808dbc3so40775151cf.1
        for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 07:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784212059; x=1784816859; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zpbV942NiMem3Siz+yBEQUzBLYNQDtxtcBJx2zb2Omk=;
        b=kW2+bHvaXLF2/38CQaANtPiT9FuR3MST/IcSocZf+GjM2ovzWO1Hk0CukOy+FEp8gC
         GuWdfgrFNhZ8wFtdU0GgH+6s1yS2waNHiXmAeuE9zQ/TB7BTp126/3cO3QcPRpDspoZJ
         ndUw/ZqPgm2swkKUgfGXiSAv0BBaKfY2e7Ww2FsF2pcCCTxKV8+A+wvANOdm40DXcAHl
         VCXJF85ELamxXeqzIO6lfQSi0dOCJUE89x++rCoYdxMEPUG35ATenpG/FUao6QL+gOdd
         cdDednRm7sodt8u0/o8Fs5/WZUaxr5b58mAq5mgzYeVBJlTwRiqRmlyJbzuwnushbaDy
         2xrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784212059; x=1784816859;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zpbV942NiMem3Siz+yBEQUzBLYNQDtxtcBJx2zb2Omk=;
        b=YjTaK+yiNRg4yW5ecBfCGk5iiYIm5wcp11hvcaNPY3OLcgBtI1MOxVyelDQLhuEZDI
         DYnWO+H6Wy48VSkZg7VtZMdBnSwMoLb4VsTb6fTD/2fvfeq56ksoAP0kiOoP3hYLQ8Tr
         M14Zg5KOdX6AxzIpgBiDV94TEWphkMaiq2U159+HGi4tJvPWMLFuKXyu+igmdocKPGEj
         ZwgDBYSr1/+JYugYqae7VlCPZUuwYRMUqPsuRipzhliqqYun2K/HvUEkfA0hTWVxfJuD
         62rbT9RjIYR/r3QPVS/mIg2JUpqaoq2Acz6fV07Un46F5/1SW6WBenh1xY65mO+LJp+5
         7+Gg==
X-Forwarded-Encrypted: i=1; AHgh+RqxBjxGOlCtsTVfM/qJTZnXf7IpgWEAq9Z5kk6pb74fTK2r+wyfFahItVLd+xuztqn+Abvytw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxi1St+4hnXYeiSZ+cq5rwmkvpVU2DX05vo7xS6a1LWRNqnqFP5
	duAJDhwczeWkIWG4CRQJm/PF2rWFujat7dK1E88GmEcZhyADomUEoDAAsuOMqa+G/lQ=
X-Gm-Gg: AfdE7cnhW35u2rmC3rJDp27REnf4gJS4H5nGOFewZXUgy/YFpN1ojAlLPe9+bdlIPmg
	h4Vj/Ntb6T7psJ03wnYatFxEPR1nG3ykHooyhnH3AbLRr3TI8fOe3zQcdS3RnNUasIN2HOjmLGA
	XM+jcrMsK7oKNITP857iByDp7x+T1xOZbP/7ouc7LDbrcR7ipLwTj1y/QaFEion9FMS0sD/IdEd
	EB8O15l8leNKCqA6HobYlZsrWHnlDgHxYTrg/pj/s/ahTO8OPK4OYqt9bFX2LsbiZ3hRsqogIlP
	7MzQIZm7OLmB0peaMVluW+pPEXyq0v2gLZqdLQQ/E0NY01ZqFRF+1bW2poMABwh8f/vQlM7Q3nK
	J/OW2r+O/n+9cvBHO6Z9kEY1g3uzzg/mbNQ+MloJQV6c0tbqT/A==
X-Received: by 2002:a05:622a:2c4:b0:51c:22c5:daf8 with SMTP id d75a77b69052e-51e42494334mr105321611cf.59.1784212058599;
        Thu, 16 Jul 2026 07:27:38 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51fca094208sm11946681cf.10.2026.07.16.07.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 07:27:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wkN3p-00000002WW2-0fBf;
	Thu, 16 Jul 2026 11:27:37 -0300
Date: Thu, 16 Jul 2026 11:27:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Disallow SVA if page walk is not coherent
Message-ID: <20260716142737.GC210048@ziepe.ca>
References: <20260716053554.1642374-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716053554.1642374-1-baolu.lu@linux.intel.com>

On Thu, Jul 16, 2026 at 01:35:53PM +0800, Lu Baolu wrote:
> Hardware implementations report Scalable-Mode Page-walk Coherency Support
> via the SMPWCS field in the extended capability register. If the hardware
> does not support page-walk coherency, a clflush is required every time
> the page table entries (which are walked by the IOMMU hardware) are
> updated.
> 
> In the SVA case, page tables are managed by the CPU mm core, not by the
> IOMMU driver. Because the IOMMU driver has no way of knowing whether the
> CPU page table management code has ensured coherency via clflush, the
> driver must deny SVA if the hardware does not support coherent paging.
> 
> Fixes: ff3dc6521f78 ("iommu/vt-d: Fix CPU and IOMMU SVM feature matching checks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/svm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
