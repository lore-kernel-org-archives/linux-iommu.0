Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C094224DC
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 01:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713923390; cv=none; b=HS3S4OpUjeAfO2Ey9YL+YuQeFMCjoVL7Fc1itcd5O8iDDjr239gIcPeRwTmYr/01PTew01hhr+HpKMB0gtd9A7ylH/r8zbIl6CKfZA/VCt2/0uFivhHEoSmGD0oBb8N3yQcBONZiyHivCpX0nCNMMXwfF5FBXtS2DsIGLNqHjI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713923390; c=relaxed/simple;
	bh=IehNd3eMHFd9olgYd7McdkQIzYApTyco7Odwj4K8Z8c=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PkOWfH+0gBLbgldMXiQ0X8G2ukIlCOorVwGbIhBnFO6Rjwgje5Kl5YfYbSEi+PPN5Hffh71R8htK0SHORLxHjAbkUBKaNSjzLrcT41SELc+twR7bsALSW7JuVkOfsE46LKFydvDW5XAhL0+22VcMwU6ZRpkYZtqwRcFGgQGX7YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iOIihpJS; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iOIihpJS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713923389; x=1745459389;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IehNd3eMHFd9olgYd7McdkQIzYApTyco7Odwj4K8Z8c=;
  b=iOIihpJSfAX71/RzZP5RgaYpT6RPGHiHL9XJq+rQrZOtIkEukuh8AwsJ
   StqDLXU1taEGcLtA2ZDWqWCUL+joLrOqNa1MLJDKcWBRDVpuXfsv/XFqB
   gqChe3BAkTuJPAMabfa9aeL//K497+4340TDyPG0gOnNcXwD6nONbUfqq
   0yjMTV0lI0gkWA+ggT83tueknr5SeFQPo0QVxA6k9JmcQQSmRwAzfN+A9
   GV/yoAbriHhTS7G8MwfDJW3ghK/2PBCbK0AwUPTbCmpDfmLiXgK56Uqnz
   EPD9+6gZydAxKY8abOgsdkxwKw4inpthYUcNlREn2mOLQR00uKzWQ9A0d
   Q==;
X-CSE-ConnectionGUID: pUEhOLYaSUmHwOkunmmP1Q==
X-CSE-MsgGUID: BfXUSLQRQjWMFbEhehbujQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9401591"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9401591"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 18:49:49 -0700
X-CSE-ConnectionGUID: bVtHcrAgQsaOIZ6nvH7q0w==
X-CSE-MsgGUID: QqFtSTSBQpq/iyXRriI4Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24554286"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa009.fm.intel.com with ESMTP; 23 Apr 2024 18:49:46 -0700
Message-ID: <a7b6bc87-b396-4e8b-95a5-8fe77ea3ad5f@linux.intel.com>
Date: Wed, 24 Apr 2024 09:48:23 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Zhang, Tina" <tina.zhang@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 01/12] iommu/vt-d: Add cache tag assignment interface
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20240416080656.60968-1-baolu.lu@linux.intel.com>
 <20240416080656.60968-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52764D1943C9A5CD91666E228C112@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52764D1943C9A5CD91666E228C112@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/24 4:17 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, April 16, 2024 4:07 PM
>>
>> In addition to the basic IOTLB and devTLB caching tag types, PARENT_IOTLB
>> and PARENT_DEVTLB tag types are also introduced. These tags are used for
> 
> it's NESTING_IOTLB/DEVTLB now.
> 

Fixed.

Best regards,
baolu
