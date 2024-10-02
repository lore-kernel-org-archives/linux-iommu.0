Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDD4747F
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 16:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727886332; cv=none; b=NiSxUlQuJ8UtZNZWpiOxuogvwk/fK52x3lZzgL9X5OlrFVJIpKX4K6jfvTEYHAEYE4cZ9PMuFhl8iUXcpGBYNnEcYldKBdqSOxswmLm7Jb5vb/crsbE+YCi628T/BNQnm1SQTCvOgozBCqEP1uej7tgmd85VuOUvwsOTAdHnZSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727886332; c=relaxed/simple;
	bh=uorsU/UlR3IXAPCQqpCGZg0O9sgJDtSENIWemOlmxEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=feyXvXtiDYIfOBcVV9fpZLM/8ARzmqUCVj2fEIMMeVj8NVjXrAPPa+WqgmcOq9mFTksMwyykFC+vjA7x31FIMoIzBaVHL9/Xx4IRsDn/VMDHg11E5ffmxJqeSE48/rOoTLlwETDGvOkWSvBE7QWNOwymrho82lhE4lseCVrJLQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UGowUvXv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UGowUvXv"
Received: from DESKTOP-0403QTC. (unknown [20.236.11.185])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7653020CECC7;
	Wed,  2 Oct 2024 09:16:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7653020CECC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1727885761;
	bh=s/REHf/BCenixskOgUSHpPOzFZEDfraHtF8+DyQvrMQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
	b=UGowUvXvJjAW/vcB6oioCgsAraKZYp1JUd/6UXyCkUD6j0Zd+j+K2x3JnZBv3qLIC
	 3aJhrJ41XPr3b0PvrkvbdWKh+G2+GvhUOxiBdm1zD5Z9KjRF1humsCS6oopZI1JYHx
	 gQAA5hz+o8kRrsEuBmzjHwYA+rH1oC2Yzgy4egvA=
Date: Wed, 2 Oct 2024 09:16:00 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
 baolu.lu@linux.intel.com, kevin.tian@intel.com,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 1/8] iommu: Refactor __iommu_domain_alloc()
Message-ID: <20241002091600.2324687b@DESKTOP-0403QTC.>
In-Reply-To: <20241002141951.GF1369530@ziepe.ca>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
	<20240911101911.6269-2-vasant.hegde@amd.com>
	<20240912210207.4ba164c2@DESKTOP-0403QTC.>
	<d092766e-bae2-4dd0-b274-69fbf5c27971@amd.com>
	<66fae60d.170a0220.280357.3d11SMTPIN_ADDED_BROKEN@mx.google.com>
	<20241002141951.GF1369530@ziepe.ca>
Reply-To: jacob.pan@linux.microsoft.com
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jason,

On Wed, 2 Oct 2024 11:19:51 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Mon, Sep 30, 2024 at 10:55:23AM -0700, Jacob Pan wrote:
> > Currently, we have ftrace like this when I do:
> > echo DMA > /sys/bus/pci/devices/0000\:38\:00.0/iommu_group/type
> > 
> >     iommu_setup_default_domain() {
> >       __iommu_domain_alloc() {
> >         intel_iommu_domain_alloc();
> >         iommu_get_dma_cookie();
> >       }
> >       iommu_domain_free() {
> >          iommu_put_dma_cookie();
> >         intel_iommu_domain_free();
> >        }
> > 
> > With this change, it will be:
> >     iommu_setup_default_domain() {
> >         iommu_get_dma_cookie();
> > 	__iommu_domain_alloc() {
> >         intel_iommu_domain_alloc();
> >       }  
> 
> ?
> 
> iommu_get_dma_cookie() accepts a domain pointer, how can it be after
> intel_iommu_domain_alloc() ? That would be a bug, right?
My mistake, iommu_get_dma_cookie() is *after* __iommu_domain_alloc()
with this change. No issues there. Sorry about the confusion. I was
trying to show the asymmetrical part but missed the order.

