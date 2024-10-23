Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EDA3FD4
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 12:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729686239; cv=none; b=NuhaEtVcUQtxnl87o7USc8NNFqy4VqASEjbV04AkNSatbP+PGsxIYIdRBOmZ6e8Owz/XaBefNqukRYDEP6ZGPTLR8Cp7vgqtsroIMBFtnDxCQ7SR0Z4EKLzH+l08YGoXiK+K5zfQsc0ReYMyqYXOR6LNZKvxy8b1ViEhN1FSH2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729686239; c=relaxed/simple;
	bh=4ke0SQRyVUBeQd8cxdRY5fy5/r+8tW48StkSzs93PCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1HhRNOmxxpJohIoE09i6+8OEdmmDWv/cegJTyyXccZ0FBpT/dOCxIEHeDihusV41XMN5B+DULOXZsn29BeWPYxYglVQsuRmicvtKDLy9rum6Nolj5AvQq7ZftlhgkJdq7mgmJDea06T/xwsU3ZFn3BgFjDKkaKGJeevWOy3K3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XFwH6Fer; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XFwH6Fer"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7ac83a98e5eso72284185a.0
        for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 05:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729686236; x=1730291036; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=heMoeGKJ+sDulnvQgF8lVvzWvIgwe/whx2HJOLQmPc4=;
        b=XFwH6Fer3X4OZ9YcHYO/9P1aT+QdjwFmzf5/ieMGD8nNRAx0MCWucwVwVPI60MdFDB
         FR5KDPSpcBTTjWCBTjg+cJgNZnC9Bd6uLjLPfhu5lwK5p4EQ/cAkKxbMLY1CYHHZeCnu
         maQJ5LqOa02cb9U9MDbcz0uWFvNtDEpcGUvhf6OH7fswziTrEQ+j8M7+gr3lYFTgdEUb
         OYxO3N3IU+am6JY8BWYoU8Yxg47uei6peIE8v//b6qzv9tmGkIqiss/5KvGZs8/AVEaM
         ncg/ezjBZjjPSTaysjP3df9A/zCyAyMBdu016+X041yZixnP0ietxpPm5J2ZbIChig6/
         yM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729686236; x=1730291036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heMoeGKJ+sDulnvQgF8lVvzWvIgwe/whx2HJOLQmPc4=;
        b=Mb4zMb+RWWS5ICkgSOPEcZ6HAFTyK/04kcjuol6zTAvvo1JHSJdBfD3X0eEHV6eF+C
         qOYhFP6mIo3zm+f2ki3WtGde19nD7zcQszBaWHWAIrmYCLbmVcEhoek7avFh/I4R5Az7
         QlerLVi82bKXP+cIqIeIpxPpMZa3vPxg0PlWc6pTMh1PiIqivAbJJfbMK6qUo7Iwb+dR
         a88vwsHckZGOfpqOQgSly84pWJ/Arye+sR0AM/csWVscJ5KKYInQ0CwepJnDxcOyHQXS
         H4Jb/Uqv9ZodRfiUABQrDsGLOp4d3wacRFwQ74KgBUhseWCOtmEyKObAxeh3/UOfgnKp
         Qafw==
X-Gm-Message-State: AOJu0YzGa7nwb+7mMIXwsqQKVCXxleArcjFN2PbmkHFj0j/eMTTAUNCu
	mSNh5Csn3h9yJS5YT6znaRCSBqe5R1Ih4BbgYi5BhDctxmMIqwDdvPHFRfCeJAk=
X-Google-Smtp-Source: AGHT+IGmTELN19I4h+BCJVnhnLNqJLNkvWIQ8rGqgC2Cf4CUVNoOxh4/vOUDrDbDl8SpgchvOJF0DA==
X-Received: by 2002:a05:620a:31a0:b0:7b1:5545:7104 with SMTP id af79cd13be357-7b17556c6damr1195508485a.2.1729686236498;
        Wed, 23 Oct 2024 05:23:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a71754sm380967185a.107.2024.10.23.05.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 05:23:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t3aP4-007ZSO-FU;
	Wed, 23 Oct 2024 09:23:54 -0300
Date: Wed, 23 Oct 2024 09:23:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v4 04/12] iommu/arm-smmu-v3: Enhance domain_alloc_user()
 to allocate PASID capable domain
Message-ID: <20241023122354.GB13306@ziepe.ca>
References: <20241023104207.5894-1-vasant.hegde@amd.com>
 <20241023104207.5894-5-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023104207.5894-5-vasant.hegde@amd.com>

On Wed, Oct 23, 2024 at 10:41:59AM +0000, Vasant Hegde wrote:
> Core layer is modified to call domain_alloc_user() to allocate PASID
> capable domain. Enhance arm_smmu_domain_alloc_user() to allocate
> PASID capable domain based on the 'flags' parameter.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
