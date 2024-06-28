Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFA1AD55
	for <iommu@lists.linux.dev>; Sat, 29 Jun 2024 01:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719623511; cv=none; b=OHYqU2a/Lrcyp9dIPGPqBcKbGJq/9ECSYnzd/r4rQGqV7z8K9qkVOlp7KYVi/m4ldISK0+g3dYf6aYdnQhbsTvIngtvR+hESy4enFA0ZXGWTDYrInwdfr9n+5M+CKKG7Y0p+5Sqv6Pf+B+SlehIok0QAuO38uiJzbv9FFFSLL1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719623511; c=relaxed/simple;
	bh=7nlIwZaLCYxUa9fHgv2z1TOWXwJyMJVnO79vebcTU3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WF0oS6KROos9ba6noxzTBXIYrCQDglW5+5voYfjq9dQtQzyRstniwVcv5FyCzJVMfhHxyJu2tPx9DlYDtqShYHUWva9jjivD1DyIEvHrOjspabjGAGAtfHrui2LjnB7aigNUBANbYenN0T7msUI4zlmGV888GrOkrfl7oPrcIVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=f5HFVCQv; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="f5HFVCQv"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3cabac56b38so682390b6e.3
        for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 18:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719623509; x=1720228309; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3DKTq9ZB/l+FyCxq74u0wbRTGw61SKT8yAOsLzmyXh8=;
        b=f5HFVCQvB3YPpPVVOyy6PJzGzIUuClgir+Wlj68xOuQ/nhu4ovVM7Ydcv8RWt7Rhvv
         Q967ZGbKpVV4ceYaVH1SNGLJD5cafNlZgy1s98n/g4S2BKQkxTP/2MnU09O9Qe2V6V/0
         u64vtZcW7Q8PBSwYRNP2L6++p/UmPxF6WAhxVd0LTDpRWV0z1WmxmpuLV1gBaKr0HX4F
         sXD5BtVDn/gvVhdfyaIdaxO7XbbHxMpj65dSFV9EAx+yvTh+zYWKZoy3GN6kE7fDyepb
         wV+q400hAG1GIV5ITtV6MgPMLTQFWOPgdU8+Wi0c9HzOgJuQJ/M7HiVBuRpmmG+8M4XH
         Su3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719623509; x=1720228309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DKTq9ZB/l+FyCxq74u0wbRTGw61SKT8yAOsLzmyXh8=;
        b=fz5l+BCGxOBNkh/I1WnmplNxrOcigllTWnz0HdTIOl3xpsrcLjIcBfpCLOoLCm9ejY
         CVxzBmvFu4vpKNWIaOyU1uHijmPsXy+TdsxYxpUytOFNSoLtTYKnsMHgm4lXzcVjHWTC
         zDW+lnw32xxPdzIcFsqM4JwZ7znvhrRMgQSv/agScNObsIjZlcmSZAxj1J7hHyfVoEFc
         2ziha0gBtzhidsHPr+Q6qte7ly/89BfL8Y5yRhdrlU4q5ZwTLQMEnpJ+xsTWEX33UDdJ
         N/BPTy1Tea4Be2JtHP3g3N6K9l380tdoG7kjGkXdsu0HqvbqSR71VHSP3IA6m8xODB/L
         p+HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdulSfAERDQbf+T1ol65Hb/7eTTgBmClqwVXLkUXzocOQlWOysWk8AhYIXEOXKUKj8qVWztD1Asf2Cm0JL6fIEvIWa/8Y=
X-Gm-Message-State: AOJu0Yylom5QPADI2jrCfS4XICoYTqSWjaQhzM9VJweI/LMyu/HNitu5
	f+YBmWhKie3SmWX09k7QolkJ/VCUmZoaTGGUzmLaUqdO+SF0JHYZKXcYcRSMcpg=
X-Google-Smtp-Source: AGHT+IFOlesedZdEydbWFXLPLqGu9bC4AvxCTT6KmpZB2VDdZZsxo1EB4l2tZfq1zV6VCZyZuBGDNg==
X-Received: by 2002:a05:6808:21a9:b0:3d6:34d5:22c with SMTP id 5614622812f47-3d634d50632mr2347556b6e.39.1719623509555;
        Fri, 28 Jun 2024 18:11:49 -0700 (PDT)
Received: from ziepe.ca ([24.114.37.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53be5sm1784142a12.16.2024.06.28.18.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 18:11:48 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sNIUX-00049z-LI;
	Fri, 28 Jun 2024 17:46:45 -0300
Date: Fri, 28 Jun 2024 17:46:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/10] iommu: Introduce domain attachment handle
Message-ID: <Zn8hNQDOvAJsQ5Fg@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616061155.169343-2-baolu.lu@linux.intel.com>

On Sun, Jun 16, 2024 at 02:11:46PM +0800, Lu Baolu wrote:
> Currently, when attaching a domain to a device or its PASID, domain is
> stored within the iommu group. It could be retrieved for use during the
> window between attachment and detachment.
> 
> With new features introduced, there's a need to store more information
> than just a domain pointer. This information essentially represents the
> association between a domain and a device. For example, the SVA code
> already has a custom struct iommu_sva which represents a bond between
> sva domain and a PASID of a device. Looking forward, the IOMMUFD needs
> a place to store the iommufd_device pointer in the core, so that the
> device object ID could be quickly retrieved in the critical fault handling
> path.
> 
> Introduce domain attachment handle that explicitly represents the
> attachment relationship between a domain and a device or its PASID.
> 
> Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h     | 18 +++++++++++++++---
>  drivers/dma/idxd/init.c   |  2 +-
>  drivers/iommu/iommu-sva.c | 13 ++++++++-----
>  drivers/iommu/iommu.c     | 26 ++++++++++++++++----------
>  4 files changed, 40 insertions(+), 19 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
