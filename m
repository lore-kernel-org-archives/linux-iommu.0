Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC792139C9
	for <iommu@lists.linux.dev>; Wed,  5 Feb 2025 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738742069; cv=none; b=Ud9amqzR1cBdEKZYvQ8Os1zHAGCJFZO4AJcXglCnrI2H3Sy3+IPMQPkXzq2VH36JAblqajmSR9+EDgnb243W7aF5qXta2VktoQFIlzfoxlSJTdrm6xiwsm96OxzRApqq7VUhkaxHXDFTFUTVZ7mh4CVVb8KqWI+AdTBIXAeXgTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738742069; c=relaxed/simple;
	bh=X2hlbfos53+4cHlM6vapV+xkKrspJUB9EmieEGYsqk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1d3tkPZChGfFbXyqaPtSthLvElEMOVsXQrEcvi9tNqJ3GUPsktpkHkx5lEkL/nbrXd7eez/X9h1+5o0K7MLId2Ne/5wfk1jqnrB+1U47/dBMB5oIkiMuFtoZddl5jfeldU97Gs5ii06OByBnKixRV9vOMBHidQqTWhXOtZ5x5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G+E7WXDi; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G+E7WXDi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738742068; x=1770278068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X2hlbfos53+4cHlM6vapV+xkKrspJUB9EmieEGYsqk8=;
  b=G+E7WXDiKv3izSnnJYty2KAMJsew3l1BTPmW2BgVjtyp17yAHfdrFzoK
   Gy7NlEswd65ntZXDuzDPsG27r+5pp46uKOPaNZw4w6DgKm54OajetbLMh
   fA6TzDfnsfL2lZuVQr+M6ddUM5gtB1Hekin4uNaRy1yxeuItk4DsBmdzg
   j84kvIquFPqOhwWbLN05VR80BIUXQvsHsHUkA3/4GQjZtymEP7sl7G8lF
   Ti5/qjN9zNTgxIfBdUbg/JJSTcVkwCBAGGMrTfpMFy5LqMcwkJYxaUcQZ
   zuCEne3PIVzLnV0b0ak/bXLk/wMOABXUF9I76ulaxP8RoKPcJdSxri6p5
   A==;
X-CSE-ConnectionGUID: IyQdAniORgCSM5UL3m1WGg==
X-CSE-MsgGUID: o9+BHv7nRXqtdZ4FOZUcgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="38996515"
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="38996515"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 23:54:28 -0800
X-CSE-ConnectionGUID: 8Ypj8xm/TimAxOF5tP8ypQ==
X-CSE-MsgGUID: chAO3RCvQpKvyidZSr6Ztg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114892203"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 23:54:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tfaEn-00000008PxK-1ras;
	Wed, 05 Feb 2025 09:54:21 +0200
Date: Wed, 5 Feb 2025 09:54:21 +0200
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
Subject: Re: [RFC PATCH 0/3] Add an option for devices to skip SWIOTLB
 pre-copy on read.
Message-ID: <Z6MZLWRv1hC8uLo1@smile.fi.intel.com>
References: <20250204233630.3407878-1-jxgao@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204233630.3407878-1-jxgao@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 04, 2025 at 11:36:27PM +0000, Jianxiong Gao wrote:
> Removes an extra memory copy that occurs during IO read
> operations through the SWIOTLB. During high throughput
> read workloads, this extra copy is causing a lot of stress
> on the SWIOTLB.
> 
> With high performance devices, for example NVMe devices,
> the device will be overwriting the entire buffer.

Is this really guaranteed? I can imagine surprise power cut or
hotplug event, for example, just in the middle of the transfer.

> In such cases the entire pre-copy is redundent, only to slow down
> the overall bounce buffering.
> 
> We propose to add a full_buffer_write flag to the
> device_dma_parameters flag. When the flag is set the pre-copy
> can be omitted to boost performance.

-- 
With Best Regards,
Andy Shevchenko


