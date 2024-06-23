Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C950C46B5
	for <iommu@lists.linux.dev>; Sun, 23 Jun 2024 03:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719113046; cv=none; b=Sd9u3G9polvCccIfLYciJcVt7qVGry6DyCGNXTzQsObmCj74bQG0FgpIh9Aqp9ymVFDFmUoaHpfMjWYJ53PawtDzq3SXQoF1dd7ZuN6lvNR9ewiOn42D5zdSh5e1BSuytDYtbkNZlWD29pEgFSZh8od6QFrtGqfeStZL6c21upg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719113046; c=relaxed/simple;
	bh=ZQAdAA6fO1mYmX4GbtwmVh2Kj57oeksFj2+YVnS3DHk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m4m4Drn9iWP3MrbA9RjbuppWUpvow/45FqwUYk1lWL/rmNU6zx4a7NI4K1rMO/fU0EaQ10Bww3VZmpHoDERA7/mnnDHztWpUWxOojQGGM+m9lR4g9LXngIiMWbyqyOJ84pfB/TbRZhub8OlzIk7uVzOO2ZqUAIizVh2JeNmCzrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SHETXdkS; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SHETXdkS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719113044; x=1750649044;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZQAdAA6fO1mYmX4GbtwmVh2Kj57oeksFj2+YVnS3DHk=;
  b=SHETXdkS/1XenL4mVXyy4dVlmOr4EjV2rTNs56fx/fxH6Wx05GdWd69K
   SO4sDPDfM4gHrgdLhDwxVTZ++7cQJNM4bGVxeEYvjNKIyVzYmD4kAn27a
   uTKeLPCyp7z15o1250JIW95zbh0lyiS67pX2JhhTa6YPuPkbZ5+8ynl2/
   0GyMIeGINVCEOiewXoi6K3+bzZJKCY9DY4NH+rRimvFIe575hXSdu6xio
   qb9uEpQ4EcvnvsRhZSPnDFClxT8kIg26X+hP+XYkY+ey1yyH/jgbP+unF
   Fk06DuhlLPsCMIuwiZ8maqRv5wvkLhIiYTw06vdvl775JCKUraoSo7BIx
   w==;
X-CSE-ConnectionGUID: eRpoEktVRWi6e4Wn5iu7tw==
X-CSE-MsgGUID: rYyulWj8Q76KAFSXVC+6SA==
X-IronPort-AV: E=McAfee;i="6700,10204,11111"; a="16249327"
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="16249327"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2024 20:24:04 -0700
X-CSE-ConnectionGUID: mGbhDtelQlS7Rw2zRNd/mQ==
X-CSE-MsgGUID: ACHECqE7SMuKm7SiobHzuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="43643808"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 22 Jun 2024 20:24:01 -0700
Message-ID: <4ba90f86-fd14-4d2a-b7a0-c3eaab243565@linux.intel.com>
Date: Sun, 23 Jun 2024 11:21:29 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, xen-devel@lists.xenproject.org,
 iommu@lists.linux.dev, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: [RFC PATCH] iommu/xen: Add Xen PV-IOMMU driver
To: Teddy Astie <teddy.astie@vates.tech>, Jason Gunthorpe <jgg@ziepe.ca>
References: <fe36b8d36ed3bc01c78901bdf7b87a71cb1adaad.1718286176.git.teddy.astie@vates.tech>
 <20240619163000.GK791043@ziepe.ca>
 <750967b7-252f-4523-872f-64b79358c97c@vates.tech>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <750967b7-252f-4523-872f-64b79358c97c@vates.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/21/24 11:09 PM, Teddy Astie wrote:
> Le 19/06/2024 à 18:30, Jason Gunthorpe a écrit :
>> On Thu, Jun 13, 2024 at 01:50:22PM +0000, Teddy Astie wrote:
>>
>>> +struct iommu_domain *xen_iommu_domain_alloc(unsigned type)
>>> +{
>>> +	struct xen_iommu_domain *domain;
>>> +	u16 ctx_no;
>>> +	int ret;
>>> +
>>> +	if (type & IOMMU_DOMAIN_IDENTITY) {
>>> +		/* use default domain */
>>> +		ctx_no = 0;
>> Please use the new ops, domain_alloc_paging and the static identity domain.
> Yes, in the v2, I will use this newer interface.
> 
> I have a question on this new interface : is it valid to not have a
> identity domain (and "default domain" being blocking); well in the
> current implementation it doesn't really matter, but at some point, we
> may want to allow not having it (thus making this driver mandatory).

It's valid to not have an identity domain if "default domain being
blocking" means a paging domain with no mappings.

In the iommu driver's iommu_ops::def_domain_type callback, just always
return IOMMU_DOMAIN_DMA, which indicates that the iommu driver doesn't
support identity translation.

Best regards,
baolu
