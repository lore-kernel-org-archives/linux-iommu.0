Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FE31D689
	for <iommu@lists.linux.dev>; Wed,  7 Feb 2024 12:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707309373; cv=none; b=E+GCkPkgftVlm1g9WkPcwt4SUeIP6riuh02Jg11AhszNuMs5olHaYooLlhthIpTmTyOYrGyMOAZ6Jqul8xIxws9LnuI9AUS/xvGVhGaYFT/tzPj7hHG9eThVD3+MzDSE2S0wsSIExDVFG5doR+T8GKtyFkC8wuvP0lvZNV6LhYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707309373; c=relaxed/simple;
	bh=/aSQYSLxrLeu9wss3UTRsqDFvugqNLhxf8Z1gNmWPqE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=K3ixSFZtZqkgCe5cY1gNrfTLC9zM0/55jC6bVKwRU1tEecZPloDCL1cP8E6fi9p9qFEEsIbUPxa6bgJvLC9nCStwcJWfSFYbek0BU52tOe31TswWFdZZZ/h0ZIIUc5QC4qfT5j1DtkefUZibljKKc3aTawHp05lilhBYlfK9SFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hRw1YULW; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hRw1YULW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707309371; x=1738845371;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/aSQYSLxrLeu9wss3UTRsqDFvugqNLhxf8Z1gNmWPqE=;
  b=hRw1YULW6ltdx7VzEQ7Ve/a1dG1y/3GXo6sSCbPvcupAWyd4TqBvi+83
   TufyFZNxyZ1GBiMjsNoduA38kC5szgS9S+sdaeokd1yQXv7gpecuA6FVX
   s+E4YDNoEKvsPoMUvBcewgGhxpYGwYtQ3pXQ78S751sUJ9N36SWmm7x69
   5PRDJJ4CjjnrZQn+Ya8Vc85ewQywaCRRXfQxTdocbkAzkybN7Eif5H2s8
   HOIEUlqvWyjcwftZgFNE5PvPbPYnzVCbH2e8NWz3xVux6IOmM0eGfy6XP
   8LFhhmcs4MPSCJdIoa2kupuMybKtmBENOGEBxO1A0eN8by9UTMiuiSMk4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="18491031"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="18491031"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 04:36:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="1354854"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.215.224]) ([10.254.215.224])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 04:36:09 -0800
Message-ID: <04df4081-b99d-4f87-9d20-bf97f7619040@linux.intel.com>
Date: Wed, 7 Feb 2024 20:36:06 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v5 10/14] iommu/amd: Introduce logic to enable/disable
 IOPF
Content-Language: en-US
To: Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20240118073339.6978-1-vasant.hegde@amd.com>
 <20240118073339.6978-11-vasant.hegde@amd.com>
 <20240201214949.GT50608@ziepe.ca>
 <9d3579c7-66c3-3752-bad8-a8a8ebc5c74c@amd.com>
 <20240206163657.GG31743@ziepe.ca>
 <873201d4-57d1-e856-87c8-08e2ca71f0a2@amd.com>
 <20240206175824.GI31743@ziepe.ca>
 <0d626c74-aba5-bbb1-5fb4-b9be5577d71f@amd.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <0d626c74-aba5-bbb1-5fb4-b9be5577d71f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/7 16:58, Vasant Hegde wrote:
>> There is a clear protocol and ordering requirement for the PRI
>> enablement. Lu described it in a comment, make sure you follow it.
> Where? in intel driver? (they seems to be using feature_enable() path)
> 
> I did look into latest "iommu: Prepare to deliver page faults to user space"
> series. I don't see anything specific to PRI enablement flow.

The latest version is here.

https://lore.kernel.org/linux-iommu/20240207013325.95182-14-baolu.lu@linux.intel.com/

Best regards,
baolu
