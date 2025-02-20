Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202722AD16
	for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 01:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740013471; cv=none; b=k9R7V1AVpPAEDbcwRcG/PuWpbnsAYOKNBvswITD2Pzt1JFtBvu5Gq+ceiEQIAMF86MGiSuXvRQNvaECN4x20+jWP4qVGzvKGroZ8ja9+AWSSr3p1RkkmpihD/s/LWwq1SZ7munSWrQN+fZ0XrBjF/VTubdLWLJrpx+c27YwySvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740013471; c=relaxed/simple;
	bh=C29IJtFpYGRYKsWTYcgC9qheUzdabqeu5JhpvwBda6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5vkhEGsu+d4V5Pd+k8K88/K9FOyyChfEpymCJDWVin0W/HjBd30VY4AbX5mcU5aVfpZ1XsR6C/EY/9MP1BhVi/lNONdkdfLFnqZP6dHVZRhHAlqPYn7TqfxuXAJyNVTKzDhdYr/dKQChVCUmQrVBP/wKY3IdUBhk7Dcyxxn1ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iKX2ryek; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iKX2ryek"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6dd049b5428so3761906d6.2
        for <iommu@lists.linux.dev>; Wed, 19 Feb 2025 17:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740013469; x=1740618269; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SlBB0aKQKBsztfZQlifhRLpsfESEiLzHxC3ZCafSuu4=;
        b=iKX2ryekHl13zfmJHeXIg2xI+WDssVAdaeVDLVxGYbe28GWEJgXN5SvUaY+ufRGHqA
         3gkTtSwqtO4rrv7Dt/gAnvk4zwXmpSHMKUZDP25wqn380+dy++iYdqowQPqHqCiQJB/H
         C4ytN8U1QEdXwt2G5L7vvivnM+pimMiC6LJnGI7h44MRq0AQFAroDluTpZpJn95C0hfg
         Y6TyOk9MyDe9UOlOJyZreorBU5H7Dl8iet8u/wB2vcnKxkDbVEDoE1CcDxy2kbL/R2sY
         Q75liQlARpHD1mLeuVL5Fz8lvAtaQwHPNXYnIgYEsC4ZITqYpdG5lZt4/3f4XdlYyz4s
         aERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740013469; x=1740618269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlBB0aKQKBsztfZQlifhRLpsfESEiLzHxC3ZCafSuu4=;
        b=KQXq7TEkq6RDc5kUkiowXtS9G6MPe3LaSvlxjvQDX+6Ya+Oc4zKDNLZP7UZn5F8xBd
         wiT+ilxmcfASj0rRF+KOpYm2cY6zpKwIGVpcE9DZ/xy3kSV8PULRYUacbEeaSaedgjYD
         g6Im01x2w7t1riAcpJ4l/WNe+G6fFLFnVzRdekXHtaDnLJD7QO0+cLdJX/Vo3ROioi2a
         sNMo3VFfX6RoGwl+BwxD5JQ2Ig7x4T3jWvVQdnttZHLVnw6JJADc7Hv4n5HvYI883wkZ
         VqQW2MkkER8c1yb4uxPvwtNZit9ixsiLL7DlwXqb2iHwp/qdfIAuBuEqhoaZ0tS412YH
         su/g==
X-Forwarded-Encrypted: i=1; AJvYcCUs6o/LOJ/9LlZ8i6NhRrhK0M/J8afpPmZLT48v78DOcnFabWYOnL8WqxNykJAqAqGDLxFyJg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxowci4poTVW6IJfCPFpplCbbZRhlNu3hL6ZcYWCVV+n5odGZ+P
	MDNsNB8467pM4w/iA8NQri58ADq1JvnJTDShD+mODTasw5F4U7aCXYx8/y/OTqY=
X-Gm-Gg: ASbGncs4bokHfhicLPGvYOrTT6VXJQazJf1TL2Bxjy8XId7uC84SXJMj0fIeb6AzZTC
	pkPNR04cWCst0J1oIAOlQ3HP/8GZsIeQ7xxfhSEKfFWnWKAYfxp2cF+1QtIQ+aun9NN3kPdFjCB
	Wy89I+G7UJF1LXfsmVFDjP0en2DRiqA8p9VYg5yDsGcn9+DtcDw/cb+oIJRt7htGlfCxyKZkyHO
	oh4k2Cmv/qBPL7V/d5JpJ/IU9BVk+/yGByrlFui+nH0PDTL1z7B0gqZo7ZIj40v/zsKuVgeQ2Zz
	k2n3J0dDMCiJCpKOpZBEe69o3CMJxCRnVJF1U0LM6/0XZTtv13kkyHfNMUnnFg61
X-Google-Smtp-Source: AGHT+IHcrI2Sdpanjxyb1AyuOiw6ku+mWhPj/GzEld6OBXyHMhT/tZ6FK6HNNSZLEbKX+mPhf8xznA==
X-Received: by 2002:a05:6214:242f:b0:6e4:4331:aad9 with SMTP id 6a1803df08f44-6e697499339mr90259476d6.2.1740013469121;
        Wed, 19 Feb 2025 17:04:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a3b64sm80749506d6.50.2025.02.19.17.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 17:04:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tkuzM-00000000D8L-0kGU;
	Wed, 19 Feb 2025 21:04:28 -0400
Date: Wed, 19 Feb 2025 21:04:28 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] iommufd: Remove unnecessary IOMMU_DEV_FEAT_IOPF
Message-ID: <20250220010428.GT3696814@ziepe.ca>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <20250214061104.1959525-12-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214061104.1959525-12-baolu.lu@linux.intel.com>

On Fri, Feb 14, 2025 at 02:11:03PM +0800, Lu Baolu wrote:
> The iopf enablement has been moved to the iommu drivers. It is unnecessary
> for iommufd to handle iopf enablement. Remove the iopf enablement logic to
> avoid duplication.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommufd/device.c          |   1 -
>  drivers/iommu/iommufd/fault.c           | 111 ++++++------------------
>  drivers/iommu/iommufd/iommufd_private.h |   3 -
>  3 files changed, 28 insertions(+), 87 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
