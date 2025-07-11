Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3BE27C875
	for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227352; cv=none; b=tir9dx6aBb6kc/1jEN0xRQK13XJTZqQyM2gG9Ybb+sV1Qj7CYZariKU6EswHLc/RIbgyBjU9PdNYTDhAXu+q6SdZEtE0KytbzK37Kt2s/vnKGtlTN/0sVbhQLqkLvPslFKB26y3o3mstZMXGPYkcXz+YsBhJ+ZUyRKko+cPPhbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227352; c=relaxed/simple;
	bh=bfDxiBbq/wl0R7HnNhrw3eFrYQQe4oLZ879RziUd09Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lP8lpev2qDrE/n8Qh9chmD8Y19rh7Fq7TH/+5I0iQGlauBBLkudm8aBlNu+h44kG+UTBr2qtVejB1fQYI05dFoqqqxMdgnvL2+mXciM8UCZRljlvnIvHWJ2tgzoF3SrozKRJg9D2+NQFHtnYDIhzjiJd6Io9cTmN6m+n5JHkFbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gd+Egk1u; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gd+Egk1u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752227351; x=1783763351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bfDxiBbq/wl0R7HnNhrw3eFrYQQe4oLZ879RziUd09Q=;
  b=gd+Egk1uMcD46putfF5yvW4P+pA/50MmWDPDQ4LmGpJ5CP7HlO5QnDi+
   /Y9M4pZrCI2dndHjKxNVn+vnhbXH3z0lNg0lQI84Ii6C/oHi6bgobX3ac
   +5r/TfIlbcWt8wwGOjhoxZF0orRhBsvQrHtOwnWiOxRKdExAwHvHLQZHU
   ayKM8qwha/7SxsDl7tQZRppGRx0T5HvjAWLgSw6bZUJKbQ1pRQtMlAfxt
   Hm5B3b/X7b6REkbwYTmsGEBLgyZUTaYfEilnTcfPyxut3YT6W16txvnyo
   T83mqr1sbGVxgj1N7qnjljG0eKibcFaReNUf4vVJJW5TFmHBKb1HC3vAW
   g==;
X-CSE-ConnectionGUID: nEO2fzesQ/CCcucQx80zxg==
X-CSE-MsgGUID: b6ak+qJJTcW/H0Rah6Fbaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54682466"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="54682466"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 02:49:10 -0700
X-CSE-ConnectionGUID: iE2fHVm4SKadmNWmXf13KQ==
X-CSE-MsgGUID: B5xqumkpQgWM9LklW1YRRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="156448419"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa007.jf.intel.com with ESMTP; 11 Jul 2025 02:49:09 -0700
Date: Fri, 11 Jul 2025 17:40:45 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommufd: Do not allow _iommufd_object_alloc_ucmd if
 abort op is set
Message-ID: <aHDcHeZRTwtUNyhY@yilunxu-OptiPlex-7050>
References: <20250710202354.1658511-1-nicolinc@nvidia.com>
 <BN9PR11MB5276E1CE6E46DFC61B982D3F8C4BA@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276E1CE6E46DFC61B982D3F8C4BA@BN9PR11MB5276.namprd11.prod.outlook.com>

On Fri, Jul 11, 2025 at 03:18:53AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, July 11, 2025 4:24 AM
> > 
> > An abort op was introduced to allow its caller to invoke it within a lock
> > in the caller's function. On the other hand, _iommufd_object_alloc_ucmd()
> > would invoke the abort op in iommufd_object_abort_and_destroy() that
> > must
> > be outside the caller's lock. So, these two cannot work together.
> > 
> > Add a validation in the _iommufd_object_alloc_ucmd(). Pick -EOPNOTSUPP
> > to
> > reject the function call, indicating that the object allocator is buggy.
> > 
> > Suggested-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
