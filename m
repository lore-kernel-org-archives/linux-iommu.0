Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCDE20F09B
	for <iommu@lists.linux.dev>; Wed,  5 Feb 2025 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738742518; cv=none; b=acQmZQSp9hbGWjoA+JXIkAHRYt9TztTEGzO1Izvvq+8KvBQA4Xnph+rw/EFSS5TlajxRuX5z4+8GZu9fLk+APAh5XWK6j9ERclOB7+DpWpx3F5S0nl9HmeluzsOwiOESIAzkTYyF+3y0bkGGnFtpju/cPXj2aWJrwhkzef5xwYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738742518; c=relaxed/simple;
	bh=VBluYxTvUntHJ3RXOgHBoml70dm3Qp8DZGEmWaTqk8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2DHPZpo4uV/5R0mm0cuw/BFAfbcU//ptG1D/ShwQBsEbQUU+50LYN+NswqDJ10MSr3BHFoO1eIYSuZ2apivSxiFhbrnsli0lv5sJmne0iUxX2K0Xe+PVh8z+aIAvyv9M85kaYMZujDYGjT5iS3AjU9nHOrabvSZTL8Z14RCnI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+2LNgZh; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+2LNgZh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738742516; x=1770278516;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VBluYxTvUntHJ3RXOgHBoml70dm3Qp8DZGEmWaTqk8M=;
  b=m+2LNgZhcM08oukBgNOADcsCwFC5Tkk/SHYKnM9167jVT5MZEvAo4i2o
   i+8TCpb0wcIiWjW1f+UU6aIZM1HULbt3BczxMtHnpSwK0tyMvbRVmLnuS
   Oj/30+JcOCcmUIbFMrSxTVfMqCBPEIk5IWYP2bbxxKdpoe+Z6Vc3nSyYq
   i6CRE1BoZQmwoVkc5hwZA1jFyad7tK3E1mWN72rSaPMQppSwqI4S6ujXN
   nlQlvqDwHL+GEkPYU5MPVyPw9XEgY42z5tWV6drAi8ta/9nvGrPIC8HaW
   17vYt/mikA283sUpv5FgWJ3m2jSx9/CCyslw4T5gPuihoogmX1XnsVGl7
   w==;
X-CSE-ConnectionGUID: Y3w+HSk8SmWAyY94CDU5dw==
X-CSE-MsgGUID: LlI6RusqSRm5DBZ6hYXhxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="38528928"
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="38528928"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 00:01:56 -0800
X-CSE-ConnectionGUID: Nosr9nPrSyyGKBeyrjdQOQ==
X-CSE-MsgGUID: aJkEa+JRQteUXnUwfEPZPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110680426"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 00:01:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tfaM0-00000008Q4Y-0ehG;
	Wed, 05 Feb 2025 10:01:48 +0200
Date: Wed, 5 Feb 2025 10:01:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jianxiong Gao <jxgao@google.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Robin Murphy <robin.murphy@arm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Erdem Aktas <erdemaktas@google.com>,
	Vishal Annapurve <vannapurve@google.com>,
	Ryan Afranji <afranji@google.com>, linux-nvme@lists.infradead.org,
	iommu@lists.linux.dev
Subject: Re: [RFC PATCH 1/3] add full_buffer_write flag to struct
 device_dma_parameters
Message-ID: <Z6Ma625UFfFw_uY1@smile.fi.intel.com>
References: <20250204233630.3407878-1-jxgao@google.com>
 <20250204233630.3407878-2-jxgao@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204233630.3407878-2-jxgao@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 04, 2025 at 11:36:28PM +0000, Jianxiong Gao wrote:
> When devices write to a buffer, some devices are guaranteed to
> overwrite the entire buffer. These devices may benefit from such
> behaviors by reducing the need to pre-condition the original
> buffer. For example when bouncing data through swiotlb, the buffer
> is forced to be synced before the device writes to it. For devices
> that we know for sure overwrites the entire buffer, this flag can
> be utilized to eliminate the extra copy on every IO bounced
> through the swiotlb.

...

> struct device_dma_parameters {

>  	 * a low level driver may set these to teach IOMMU code about
>  	 * sg limitations.
>  	 */
> +	bool full_buffer_write;
>  	unsigned int max_segment_size;
>  	unsigned int min_align_mask;
>  	unsigned long segment_boundary_mask;

Have you run `pahole`? Please, share the results.

-- 
With Best Regards,
Andy Shevchenko


