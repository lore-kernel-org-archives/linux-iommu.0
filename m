Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36B415D5C6
	for <iommu@lists.linux.dev>; Thu,  1 Feb 2024 11:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788182; cv=none; b=OZ93wwPmn+g8BpRmA9sObv8sgqgsF0E3zWwveeMkzgJYKsVzPGWjlRy7x2sUuQSNKlHPAGKDhAv05lJEk+54WS+/1JoOHbhvC8j7t4pa8bt1QYxx+9gpZGhuMFOz8OnaxY13JlU9+gqGKTCzKsOA3NOVZ9ypnb7WLEC/kNtHH9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788182; c=relaxed/simple;
	bh=LW71KuuAIUVJWedR4aaeNff0Yio4Rtb4Pgs9MRUCuiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHaulLR44wHTTMYP69dPncZxSqVW7IviACOzgawIaeWHTuP2lvDdeOqv0753/3Be32ZA4f5sOPQ8+90kMEC8IxGSJjxMA04JpovcrFnFT/jlC0bzsg18RoN2EZDvwhBkLtymM0JYjVCmEjONmYAiVdvK00mN3Ut2uZACi7R1tcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aDnq5z06; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aDnq5z06"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706788181; x=1738324181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LW71KuuAIUVJWedR4aaeNff0Yio4Rtb4Pgs9MRUCuiw=;
  b=aDnq5z065oSCfgp8BoAdye7n7nuDxYdlMLuj02MfVIv1PWdBpCJCclww
   PzuxVU3zJn0YSJNZKvgllQQx1YmAMWwLh7DhYBvg+kUtOtjV/0NCtM6Ph
   8FxrdMUJ6cWC4Wmo+7dGqhF7RbKwvMoBZuZwk0LIRsRvjH0JTG/tcf1Dt
   FmNJctxGXoriHUeWwXuDG1YlrYorkPZ0hY+1D0B1hP8rYIijfMJ6ja1+W
   Q6AMKMHUHd+LYV+IBBg8Td5PAW5hwi0/ApRK4igXDayxnFjo8pDkNIcE5
   tPZ1mAP3m/0VNi55LPxcqe3Az0TLnuRJN602MNubfwjQorD1hVN31bXSE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3709680"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="3709680"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 03:49:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="1119923610"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="1119923610"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 03:49:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rVVVQ-00000000oza-0W5b;
	Thu, 01 Feb 2024 13:45:20 +0200
Date: Thu, 1 Feb 2024 13:45:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Howard Yen <howardyen@google.com>, hch@lst.de, m.szyprowski@samsung.com,
	gregkh@linuxfoundation.org, petr.tesarik.ext@huawei.com,
	rafael@kernel.org, broonie@kernel.org, james@equiv.tech,
	james.clark@arm.com, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH] dma-coherent: add support for multi coherent rmems per
 dev
Message-ID: <ZbuETxd_MfFN45C8@smile.fi.intel.com>
References: <20240201093515.849873-1-howardyen@google.com>
 <f5b626ae-bda1-479f-bc14-b1fd7ba043cf@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5b626ae-bda1-479f-bc14-b1fd7ba043cf@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 01, 2024 at 10:45:30AM +0000, Robin Murphy wrote:
> On 2024-02-01 9:35 am, Howard Yen wrote:

...

> >   	struct dma_coherent_mem	*dma_mem; /* internal for coherent mem
> >   					     override */
> > +	struct list_head	dma_mem_list;
> 
> I'm not necessarily against the idea, but only if it's implemented sensibly.
> If we're going to have a list of these it should *replace* the existing
> pointer, not do this weird thing with both.

+1 on the comment.

-- 
With Best Regards,
Andy Shevchenko


