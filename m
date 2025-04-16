Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D184874BED
	for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744807377; cv=none; b=M/mcOOmAlUVaVqV9VqePdnA0fdEfqgrwy/zYeVAsAQWHx3/36gpVW3dN+AORxd8YEBgG75RESR6FerZJ6lYNy84hzFJSVPNR/GtpT83FVTKMX2yZB8hOFn1Ij5EnrozFw/hEgmHrScNK1orEpWWa6OtoiLc9HJv43kHotP4t0ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744807377; c=relaxed/simple;
	bh=pTa6w8Fw0RdB7iZlD/RyQVHfoY3S6Q3XeUjf2EDDOZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/Ny+h3/3H1WevAgn1YqZc6H5Rs9Z2Lkh101+8+Maj3IseIeDU8EqQCiVUM6ZopK6cYEHvkpGbBbjk2/8E1fAcxFm1QdD5Nb2elWCYhYgarAHS2CXien098UeVwKOE/kg0P48BL3oQ7v1hWuLhB1JEJZwUrja/d79Nkeb8aamP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=K185ZmtF; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K185ZmtF"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6ecfc7ed0c1so54569106d6.3
        for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 05:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1744807373; x=1745412173; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NdwtFhRqVVsszyH9J1Sr7lGcUVJU4n8m7sRH1IYw5QI=;
        b=K185ZmtFpC5AnGYIWCAMnukWgZbDbtXCEtzOC0nbqfOGUTDBPuVPDKuQ2rl7+pAr70
         f99jYsj6qm1dJlC5mmNTnfoxXwyIJkJMLyGO6xgVBRYGdsp/9iVYhSQ0KLoGxaQShrht
         ETrPugfhusTwIdyFWgOvCz0sUyqRdFZaeF4Q3vykYBthzUx/mYoUIdB+Pmxt7vZckbpA
         pedvd5sr1pAkkTIRmPxi+kMwPMVVsrxkuD0jMxOpoBV1+VUl5YKoDR773mTFFXGKKMs9
         aByuZgdAx7Z+io5RvvWcXYU/o1H5HfhLpITRpLviqD+ZkkdburDUFRI2dOIpY1CWYXK2
         nClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744807373; x=1745412173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdwtFhRqVVsszyH9J1Sr7lGcUVJU4n8m7sRH1IYw5QI=;
        b=V5eHwrS1Gvf729+es8aqPx0IIhMBAGWrnLIVntPntmaEEywqqfiHU7I3Gn55idZT/Y
         Xw/KfysY5WSRF5jy9jW/rmw+bUr3taM2pIRgfKH4PqzP+rcqnrFvk19iHnMmRAtXodGu
         zLuzZwK1OeBXRqJ5UMCC0XD4w7JhEmpJygw/MSaMpxyHqM09/SXEfrT0ygkuHDjaWsuQ
         0RDgf4Zz48vmvDPEeBS5QMV7vkQvCMClY/B7STdGXYEaOJGGo6UvJJiIavMF+MiqzJUM
         uGIyAP3jK6NUsFuimOVn3UZBdYuhsUhs8Smv3S0Ff3dxo1gdwAysqmDCyR5SQ1l+ZQF+
         6y4g==
X-Forwarded-Encrypted: i=1; AJvYcCUtXeK24BfHs8u2E6KIMj5PBfHFiGBLeE5jTH19Or7ZO8xLThnKdAHosxPB/q9jDjYqFwUC+g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyEh6hCi9FclDRqvWj84qTzTdDmnYqQOeHp/7RNu64HovxvVOst
	5CaPchMjmIOBIIQzAI1A33D1IZ7I2KVX8lovRZojxDTn1PqjjcvEuDPQFXrZjfc=
X-Gm-Gg: ASbGnctuqBbtLTAp4PqDBCOrAV/ZV8RdX8SY0vms84tw4E0Gk4pc79kJisbfh/DZ0XT
	OGJSszWVjyuFyxb+h0eateZtGfszgFIcOAK3rZWNwkwicy0swX1r3gOOwdOGFJeQHxmLxJzzONc
	3FTm+hcGPXszKhhJ+F2M6H4p3AxgatNnUtxPR1/+RICDFhM5PJK+TmdeHE8sR6XVOG5prL/6ItC
	/RqdzYFwbIJbFnfVqLs7Pb+R0Ldda/fGZaoAnZYYBiFGRM1J+WL1YJ7DWB1FvImFTlsnWZowNlY
	1Mo119RZrU0JSALC6aG1+XZYdSGh2L7SXJI2PXJwiNSbUxkWYPMMP1yGY7QsOkcF2P/rIENMhMG
	+p/XoxgLAZEs6O9IqAfE=
X-Google-Smtp-Source: AGHT+IG5JPwR+yB4/rKxwbAltK4xQrPiHcOlIvXqVp6hEGsRLI84RMOfSQ/4N29zt3xZ5RTeemaJYQ==
X-Received: by 2002:a05:6214:2349:b0:6ed:1545:65c3 with SMTP id 6a1803df08f44-6f2b2f2415dmr19375726d6.2.1744807373591;
        Wed, 16 Apr 2025 05:42:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2b0a73e7esm8989786d6.119.2025.04.16.05.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 05:42:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u526O-00000004KSP-1JbT;
	Wed, 16 Apr 2025 09:42:52 -0300
Date: Wed, 16 Apr 2025 09:42:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 3/5] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
Message-ID: <20250416124252.GD493866@ziepe.ca>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-4-praan@google.com>
 <Z/1MjDaAM4Em53gE@Asurada-Nvidia>
 <Z/19e4eyj1k/pqsh@Asurada-Nvidia>
 <Z_7Fx-Q8baoyzJe2@google.com>
 <Z/7dqjiVdjnoZ+2w@Asurada-Nvidia>
 <Z_-FdLizyrz2_ovi@google.com>
 <20250416120251.GC493866@ziepe.ca>
 <Z_-ikT2whG6ekqrN@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_-ikT2whG6ekqrN@google.com>

On Wed, Apr 16, 2025 at 12:29:05PM +0000, Pranjal Shrivastava wrote:
> On Wed, Apr 16, 2025 at 09:02:51AM -0300, Jason Gunthorpe wrote:
> > On Wed, Apr 16, 2025 at 10:24:52AM +0000, Pranjal Shrivastava wrote:
> > 
> > > Also, this would mean that we'll have to take care if the Guest Kernel
> > > ends up touching the mmio region while the SMMU is suspended?
> > 
> > I think this is approaching it backwards.
> > 
> > If power management is supported then the power should be on unless
> > the VM has activated its own virtual power management. VM virtual
> > power mangement would flush the cmdq from the VM side then signal the
> > host that it is OK to power down the SMMU, which the host may or may
> > not do
> > 
> > It doesn't make alot of sense to power down the SMMU while a VM is
> > running...
> > 
> 
> Exactly, that's what I meant to convey..
> So.. can't we simply take a ref as soon as a VM is created (IOMMU is
> assigned to it), maybe from somewhere like vfio_change_dma_owner and
> keep things powered on? That way we keep the IOMMU powered ON if it's
> controlled by the userspace.
> 
> This would also allow us to only care about the host-managed queues
> while suspening because we'll be sure that if we are suspending the
> IOMMU, no VM is active.

I thought we agreed VFIO already would need to do something to keep
the power on as it can do DMA at any time?

Jason
