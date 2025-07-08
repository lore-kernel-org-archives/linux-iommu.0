Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4AB221F26
	for <iommu@lists.linux.dev>; Tue,  8 Jul 2025 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751964843; cv=none; b=VnSJNZIo4rE7QhMrcM3QGoXTbakDkQc/Jc97BSgOB/WzwNgqFShpP9MliWzrb760oX/NioOtWJ8JelEuR2XOw55vtdjTIy4QIOBNgZA8cmpSM80BFh9xsTwk+7y2l6KKLA/6xzHpS4vdHYDFLx9ySyPtrpCi0tCXmeyzthU69lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751964843; c=relaxed/simple;
	bh=31Lvx9M9j2Auiw/nFmkxArXsvuv+eb01+ksHvsbjmvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsUJ6U2pOXU/lYw3iDSdAf3gTbNH6lfjrPFqPgthKsTqkUSGO9zQrIXG6DgyxcwtXciCcFwoF1YgNei25FIYcWY86TTevrGTHkTqIaMaz5L2SLMrr/zZXR+SYexkB7hCt5JMrZPjQLB2rEzRSH/OGZ2mZITaYypZNnmPn1u37gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AosVdAOP; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AosVdAOP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751964842; x=1783500842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=31Lvx9M9j2Auiw/nFmkxArXsvuv+eb01+ksHvsbjmvY=;
  b=AosVdAOPIJtmXZy8eSg+e7EyiWndxBZF7zeugKk5pcjcJMDdwxDe3vT7
   XGpYOKA0SJHXseb2Th8vKx9CXqClB3IXTpjqNtS3iK2RJY1LxFLB9WXx0
   DCB01XMDVv7ZM1oru3N4PyMFQuubD2iPZaz3vNNkpobF6xb8VUOIRNQOb
   Cil2+T3m+dMk8GSJ/N8MgnqOATKYKUfto2bUS9ARALGP4WX+hmBxbC9kw
   xDvVFW0k4Z8fExzOBieJHffmsnuBjaIDiR5gjr4zL+qzZ5MNF18ZMK8hU
   LfIEKWPGQOSGjlgfsLrL37AO+BcoYdggG3FulzQLJ8cOthb90XKMyxWC3
   Q==;
X-CSE-ConnectionGUID: cEW2ywEARWG6AL3TJ7a6Ww==
X-CSE-MsgGUID: EFVjkpUhS861+QEp8newcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="76744468"
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="76744468"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 01:54:01 -0700
X-CSE-ConnectionGUID: uJ35AiNaRfqZ6XKihSRZhA==
X-CSE-MsgGUID: e3baX2QWTdeGTg5pEYgKWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="160997170"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa004.fm.intel.com with ESMTP; 08 Jul 2025 01:53:58 -0700
Date: Tue, 8 Jul 2025 16:45:44 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, jgg@ziepe.ca, kevin.tian@intel.com, will@kernel.org,
	aneesh.kumar@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	shuah@kernel.org, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v3 1/5] iommufd: Add iommufd_object_tombstone_user()
 helper
Message-ID: <aGzauAtJrUXS1Q/a@yilunxu-OptiPlex-7050>
References: <20250627033809.1730752-1-yilun.xu@linux.intel.com>
 <20250627033809.1730752-2-yilun.xu@linux.intel.com>
 <aGLqoSTOfppG1MbB@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGLqoSTOfppG1MbB@Asurada-Nvidia>

On Mon, Jun 30, 2025 at 12:50:57PM -0700, Nicolin Chen wrote:
> On Fri, Jun 27, 2025 at 11:38:05AM +0800, Xu Yilun wrote:
> > Add the iommufd_object_tombstone_user() helper, which allows the caller
> > to destroy an iommufd object created by userspace.
> 
> Should we describe it "partially destroy"?

I don't prefer "partially destroy", it gives the impression the object
is still in memory, in fact with the helper it is totally destroyed and
freed. Only the ID is reserved, but the ID actually has nothing to do
with the object anymore.

> 
> > This is useful on some destroy paths when the kernel caller finds the
> > object should have been removed by userspace but is still alive. With
> > this helper, the caller destroys the object but leave the object ID
> > reserved (so called tombstone). The tombstone prevents repurposing the
> > object ID without awareness of the original user.
> > 
> > Since this happens for abnomal userspace behavior, for simplicity, the
> 
> s/abnomal/abnormal

Applied, thanks for catching.

> 
> Nicolin
