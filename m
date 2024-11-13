Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2876382
	for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 03:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731466977; cv=none; b=ot7ZNkMLEtrTTDaczwjicFdWSDKvkIrjyRX1tcYVkUg3nGf3L9PeXBbdRvk9I9RLoAYSb6L2Nj6dIB7lFgTfKt/AgQooP9kKNvZANxhL/LE8iyBK3u7G9dP8mP9JNlVAned2tD/uapn8R2c7yUbFoOtjKjWvEOAOM0HHdzXLT74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731466977; c=relaxed/simple;
	bh=W9HUswfZabqVw5NlfsqrtOqWOo/9BnmPMJyuBEewJss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZ+SrqSomf9lBvBxTB2R8jrXVVHRv70fkgZNyGe0kJUmvHEV/5IAD9mtHN3esbbQHz3rrl+z5K4AIIxC7JqgyEWhP+0J26k80DVLCe0CYNjfUy//RnTjlKWwP5qflEvpdqz78yk5lisl5lTIC4m1uza7PZaBYXjHFL3XBrp3TcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cdU90jkL; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cdU90jkL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731466976; x=1763002976;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W9HUswfZabqVw5NlfsqrtOqWOo/9BnmPMJyuBEewJss=;
  b=cdU90jkLzC810weQid8PJbmGI9eDBeqdTve0Frh8/kMiEqu1+nBl7Yai
   oLygGP++PMvnTvqjJfjaHCalU9TbCJ/gRyRjRzPpfCc2MH4IyFFZ0RlDA
   KqAWxVutdzQ/wyVDY/6VZO67K+0wTpEPjjPWLpGwi0nFHMgU0OeEfzcHe
   zy/SDiMadDiG4u8zU3LEBipd+bP9TRO8Fxk1570sskOUnaNDbPSRDAwQA
   laRonN4X4lt4oYhvMsirNaGVPCbl3OV7qv67EgZp55ygOzmgYu4FqPg9B
   svliubZUe/tdSjxE2r84M5DVr+hZ0Ie8ZEE4eg1/XMDjVvR/8G5ahaKsh
   g==;
X-CSE-ConnectionGUID: DOvmxvGHQCSQpDQtlFpPCQ==
X-CSE-MsgGUID: liobm+KUS0GkbpGBL0kjZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="18950035"
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="18950035"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 19:02:55 -0800
X-CSE-ConnectionGUID: K8iSxJ3BSieLcSiRAtQoSw==
X-CSE-MsgGUID: xhnuZOAvTm6Z+Jlu4pdHpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="92183070"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 19:02:53 -0800
Message-ID: <4d0173f0-2739-47aa-a9f0-429bf3173c0c@linux.intel.com>
Date: Wed, 13 Nov 2024 11:01:53 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/12] iommufd support pasid attach/replace
To: Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, alex.williamson@redhat.com,
 eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
 chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
 zhenzhong.duan@intel.com, vasant.hegde@amd.com
References: <20241104132513.15890-1-yi.l.liu@intel.com>
 <20241113013748.GD35230@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241113013748.GD35230@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/24 09:37, Jason Gunthorpe wrote:
> On Mon, Nov 04, 2024 at 05:25:01AM -0800, Yi Liu wrote:
> 
>> This series is based on the preparation series [1] [2], it first adds a
>> missing iommu API to replace the domain for a pasid.
> Let's try hard to get some of these dependencies merged this cycle..

The pasid replace has been merged in the iommu tree.

Yi, did I overlook anything?

--
baolu
