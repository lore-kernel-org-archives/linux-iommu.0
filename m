Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6002EBA27
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 02:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741142938; cv=none; b=ZZAOMJdfKEA0OsBM82e6UqPSEszNRbCitt/NF7DdWD22oT9/Qyc7efgtjqhywf0WSWQG/XvZh84vMo/hKbUPZbQc0B7nuGGzvxTNJ9aiQ6ybVZgI8UdHyHe+Sxqc3+fMPa3iMf6sAi6BB02YVHXlqTB7RnFgLL2vTb+eb8CG7ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741142938; c=relaxed/simple;
	bh=Rhfw+zMUwPbKNYntmdz+Zp1ahtmwSQnnQmPtYKbi0ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rK2G13auj6Xuu/5d74OXCSAUCjFGiwin4l0bbmPY3xkLiuU+CodLnYI9jyAHjYHDrnp8V/ntlt0hxE8iHZjnGtpPVgfd+wKjjC9laCFqEwxPDZWtK1s0aIHPToPVZlfxMpftDTghCDoNnbfFDLpDeesdtJpTxzxyDLbK2VLZeNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VWqli7Lf; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VWqli7Lf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741142936; x=1772678936;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Rhfw+zMUwPbKNYntmdz+Zp1ahtmwSQnnQmPtYKbi0ek=;
  b=VWqli7Lf25GVZwHYdfRrm7TXDOPlAnGa6hng6yp4bkRd137JWysm4fS2
   UMMssJJBwW5xpYnoi2iIW7gr/OB0sO4W9DghuiSSZUb66HhSuuHJ3bOPS
   n3bnguI4J0Q771kYQR3c9smvmtjJ1Wm17jaw3T0NBpvQFgSBr2QJabUJU
   J++++6vou0pglRpCckKNHDEd6lF+IImQE57YNLgidKhXKJafn4IteVN0v
   dca87N4+1Z/yj7HYIJf3CEWN7miW27NeP4ra4WOar1jhPYJeo7avV+GiV
   2BtJzRoZGNiWMxfbuXnsEz0nANg7ja4ofiTZg3fuwST/5F5iLkN5lAFMm
   Q==;
X-CSE-ConnectionGUID: WfUM5AADTzuw2k3pBRJXnw==
X-CSE-MsgGUID: alFmsFOcSr6s73enqTQ7Sg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42222304"
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="42222304"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 18:48:55 -0800
X-CSE-ConnectionGUID: H5c/qQmkQrmyr+BgHqzFzA==
X-CSE-MsgGUID: 7dgGShhlQ5e8WgmdVu8cyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="118556678"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 18:48:53 -0800
Message-ID: <380c762c-57f4-4779-b97c-2e1b0259502b@linux.intel.com>
Date: Wed, 5 Mar 2025 10:45:27 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Yi Liu <yi.l.liu@intel.com>, Vasant Hegde <vasant.hegde@amd.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
References: <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
 <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <942a1a66-5c18-43e2-886e-df38cb3e7258@intel.com>
 <54db17d7-b150-4579-a33d-f1b5cc8943bc@amd.com>
 <6eb0ec90-5859-4605-8a2e-657f6f711d61@intel.com>
 <825ddadd-6770-46b5-936e-f17988534984@amd.com>
 <13e1e1d8-5870-44ea-a800-e5b25bafd344@intel.com>
 <20250303183801.GW5011@ziepe.ca>
 <24d8234b-ad59-4b7f-b210-b97d7b5dd998@linux.intel.com>
 <20250304141812.GZ5011@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250304141812.GZ5011@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/25 22:18, Jason Gunthorpe wrote:
> On Tue, Mar 04, 2025 at 10:16:45AM +0800, Baolu Lu wrote:
>> For ATS enablement, I believe we have already reached some agreement
>> that ATS enablement is in an on-demand manner. ATS is enabled when the
>> first domain that requires ATS is attached and disabled when the last
>> domain is detached. That matches what we are doing for PRI.
> It is not quite so simple, we need ATS in some virtualization cases
> for VFIO even though it is not "using" ATS for PRI.

In such cases, perhaps we could allocate a domain-allocation flag for
this purpose. Userspace would opt-in to this flag when allocating the
iommufd hwpt.

> 
> Today the iommu drivers always enable ATS for paging domains if ATS is
> supported. This is what I'm wondering if it should be made optional

The domain-allocation flag also applies here. The iommu core manages the
policy and determines whether to pass the ATS-required flag to the
domain allocation callback of the iommu drivers. The iommu core's sysfs
interface will include a node to modify the allocation policy.

Thanks,
baolu
