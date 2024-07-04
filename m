Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEE01ABC25;
	Thu,  4 Jul 2024 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101190; cv=none; b=oshiUTn80JOp55N2HbGB97i3Zr6c+bZlNB8EAWyvPkwBpLoAGGBwKwyxDf04LnmjonHNfw8pH8GD+ypKZVPdoTCoh8vJDgbK3tP1mSsCSQ2QGA8ZGPnq+0TeAd9a0/snL0vpFwPYlYuyEEjyiottxyv26Qco65R700TOC9yeh/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101190; c=relaxed/simple;
	bh=eQz2IBKd/Q7hCL1YjwIbirGf/hcd4Pso5HkourWlFN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0+jmAM/FwxC7frzaqNg/WKQtftg1x0rq2uCcNRKSGNyc3NRG4fbOIUFYJGTPKsA0J6kr1pYWIxLGUWanfVKXTXzbLJkL/krTtQDNIeWpee++4vbh2U3ol/hXm0kLLWtFejsdGZIp4rk7b4GyaqgBtfz3jbL0ZexYRp//KGEK8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxI1lfv8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxI1lfv8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF1AC3277B;
	Thu,  4 Jul 2024 13:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720101189;
	bh=eQz2IBKd/Q7hCL1YjwIbirGf/hcd4Pso5HkourWlFN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XxI1lfv80rJr1/7yGA95ZgA6CrbvweUqIvqiuT+zxsy9TX1ELTFYRkh+Om5FfvySF
	 5tnVPH8EUJhdjVlF72YJiBiCmvE4rjE+vYF+VyoZoWWr10m/Z54aZX3SmdRHUqFlqe
	 Q3VX52GRIRKUrAc+18kBK18UjNQfqAQdvSiWavQjFgz95e7tLq7Sl06OTz6YxpthPK
	 aqYUSEWs4dOfQPE5wpWbqxuhBB0RW8TrF5/TyXZKbd00ypWocDnYibNw+WGF7sj+Il
	 WO49vWsPz9I4WJIa6FgAqLc9l9+XQLye7cjdkS23vbjuczwn7WJj5DZEh2hbyD15c3
	 gSFfx8okA3upA==
Date: Thu, 4 Jul 2024 14:53:01 +0100
From: Will Deacon <will@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k@lists.infradead.org, ath11k@lists.infradead.org,
	iommu@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/21] vhost-vdpa: Use iommu_paging_domain_alloc()
Message-ID: <20240704135300.GA7854@willie-the-truck>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-5-baolu.lu@linux.intel.com>
 <20240703123146-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703123146-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jul 03, 2024 at 12:32:06PM -0400, Michael S. Tsirkin wrote:
> On Mon, Jun 10, 2024 at 04:55:38PM +0800, Lu Baolu wrote:
> > Replace iommu_domain_alloc() with iommu_paging_domain_alloc().
> > 
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> 
> I assume it's merged with the rest of the stuff, right?

Sure, I can grab this one in the iommu tree. It has to go along with
the patch adding iommu_paging_domain_alloc() anyway.

Will
