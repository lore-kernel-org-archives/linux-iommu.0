Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2CE2EA731
	for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752246697; cv=none; b=s+l2ItDKhkmQRokLCEl1NS2hP5hYfMYTDspbK+qdyw0AK122iLZSwur9TEJmTBMzw1LlResfzkdeB8GVeVsbvZLAznLbEpcH+X3ng/oL9AE7NRS4679KK532lXwOFYN+dwFx+AsTUwBpShWN/Coow+lTdX6Toi9yr1KuIlkYsgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752246697; c=relaxed/simple;
	bh=uQrGjRMlhMxcgB9dQv7WduiFsxHLtMRGKmlLQORixu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8mAACl7s/T0psFsDYhhcW6U4WZiofsPUoTF5+t6I29U4btulttei13tDjP6CrkoNuj+bNg3o6hHGpRXzv1U4CJVHYQDewAftrdwIeTiPQvMDmQCzY+ctfa7cRKlSD0f4zsdUZ+oQ9HA2NBF5YoCf/x9GqnbmRnH3oQBWAUjAKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPL32Ded; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPL32Ded"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752246696; x=1783782696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uQrGjRMlhMxcgB9dQv7WduiFsxHLtMRGKmlLQORixu0=;
  b=lPL32DedVQ8V6RjTtrm90zBL60E5T7OP8DhrZLjWse83CCXtVan8sHQk
   G2XQzu+Aiakn3bBSkqt7X3l4lEr3Lha2JwA2mpxKD8Gu76rewp1HMJkat
   Poc44JVZLBacew+/vnoFFUoybWezj9+8fTdaBrmsD4xHoXpXcl7m1Pz9I
   Yjf78eruQt9OYkpl6eK+1DueWD50NKVBycOZTweacVzlZRP1nIXukY/9s
   KYo637qMUk88aobIUlkH/BpS0g/yzHPozb2JcBFYJlNfsimhv94gobs0u
   3mpyqYT1yvbXpC9cmAg6Vdi6OIYGP5vLVeFAI6BNyRGAZqDzFn7HLZa+l
   w==;
X-CSE-ConnectionGUID: QV5vjuMCQ8+Trot9WT+ZJg==
X-CSE-MsgGUID: fYH9aP2/RuC7wv6BZQB4cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54518243"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="54518243"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:11:23 -0700
X-CSE-ConnectionGUID: +5mUBT1+QwqgwIDWRWzX+w==
X-CSE-MsgGUID: xrHxlGKNT66/LnqTa2fHkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="157109379"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 11 Jul 2025 08:11:16 -0700
Date: Fri, 11 Jul 2025 23:02:53 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, jgg@ziepe.ca, kevin.tian@intel.com, will@kernel.org,
	aneesh.kumar@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	shuah@kernel.org, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v4 2/7] iommufd: Add iommufd_object_tombstone_user()
 helper
Message-ID: <aHEnnesvLL5te5rf@yilunxu-OptiPlex-7050>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-3-yilun.xu@linux.intel.com>
 <aHAPqdZKfdeEMDs2@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHAPqdZKfdeEMDs2@Asurada-Nvidia>

> With one nit:
> 
> > -	while (!xa_empty(&ictx->objects)) {
> > +	for (;;) {
> >  		unsigned int destroyed = 0;
> >  		unsigned long index;
> > +		bool empty = true;
> >  
> > +		/*
> > +		 * xa_for_each() will not return tomestones (zeroed entries),
> > +		 * which prevent the xarray being empty. So use an empty flags
> 
> Since the first "empty" and the second "empty" are different things,
> 
> > +		 * instead of xa_empty() to indicate all entries are either
> > +		 * NULLed or tomestoned.
> > +		 */
> 
> let's write something like this (correcting typos too):
> 
> 		/*
> 		 * We can't use xa_empty(), as a tombstone (NULLed entry) would
                                                            ^
> 		 * prevent it returning true, unlike xa_for_each() ignoring the
> 		 * NULLed entries. So use an empty flag instead of xa_empty() to
                   ^
s/NULLed/zeroed, are they?

Thanks,
Yilun

> 		 * indicate all entries are either NULLed or tombstoned.
> 		 */
