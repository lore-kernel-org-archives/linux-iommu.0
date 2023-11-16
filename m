Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B1A79C4
	for <iommu@lists.linux.dev>; Thu, 16 Nov 2023 03:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0KbtNE2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700105292; x=1731641292;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DhK1ix88G1Yi7MN02s45jcyCSJlvBkl/JOoMUxCCVrc=;
  b=d0KbtNE2RIkc943+ZJA/xDacKkLQ9AlIbpkxtZxjXouhZ2OGjo1xlxKE
   a5kZPKH/OCtMXegHjM/mClOyXKcHeplNNw9dNjcRsCl2GfShdXSYZoA7f
   cFrTyLDeYIjpeiOVcay1rmNoj+RztGPPxvvm1hcSwaKcxNKa+Fmwpgg0N
   rkUpCJ+XnlPwqoRKfECgDv71ls+qx+ciJ0nc+/pgNlu2nV207F5DGSpoW
   Rhon4tkcDzYUrdJHyrVzcSlRSn2fneA6Mwy3NfxKl/QqpJJzopmR/b7Jv
   40LOCKpWpc1HwuBRzWO7QHzEPIfW+fH5SUJk382txbILYJ5TjXcImAPyd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="4132672"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="4132672"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 19:28:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="765180519"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="765180519"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga002.jf.intel.com with ESMTP; 15 Nov 2023 19:28:08 -0800
Message-ID: <053e89dd-8de9-43f3-8530-1f65181efd46@linux.intel.com>
Date: Thu, 16 Nov 2023 11:23:56 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] iommu/vt-d: Introduce dev_to_iommu()
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20231116015048.29675-1-baolu.lu@linux.intel.com>
 <20231116015048.29675-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276CF0833BF362C1BE5F2268CB0A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276CF0833BF362C1BE5F2268CB0A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/16/23 11:19 AM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, November 16, 2023 9:51 AM
>>
>> +static inline struct intel_iommu *dev_to_iommu(struct device *dev)
>> +{
>> +	/*
>> +	 * Assume that valid per-device iommu structure must be installed
>> +	 * if iommu_probe_device() has succeeded. This helper could only
>> +	 * be used after device is probed.
>> +	 */
>> +	return ((struct device_domain_info *)dev_iommu_priv_get(dev))-
>>> iommu;
>> +}
> 
> Not sure whether this helper is useful. This is only used by 2 out of 5
> post-probe users. Probably just open-coding in all 5 places is clearer.

I thought it should get more users in the future development.

Best regards,
baolu

