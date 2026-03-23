Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BAA2139C9
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 02:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774234570; cv=none; b=Gf3081QF3y3Yi0MkGEGhVKCGqtOR5LTOvpHx1AttHzs+Ve6QNO+VMyn02oACs3wxiGe3h9N9j9AYy2RoM2ekB7VDHXCCCmPnzPGh83kfVvvJYIoNPQcKsTimS+xKA4rvZtnAJpVJlgOZgC1MlZ1ULdLeLQxQWAxOQWcCIMFKZME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774234570; c=relaxed/simple;
	bh=JIt99p+izEaW6V07z4nB4vcCdQxfOJe7vVbQm/2tr1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S2gdwDOUUYJ5ZxpAjSOptMAGuM5KaV2OUIATTI5MCr/DZ3WRDjLgcQoodwCWHgY1u5ybCq63lKhGMiQ24SXcpRsoyGbwRVHCT1dKHZo49uRWeXzujiB6lIf3A8ai3vqZjGfjRfqudkNHMfEKsF8FcM1jUgz+pyHKkKSMvFIQxQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G7Eb67jR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G7Eb67jR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774234569; x=1805770569;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JIt99p+izEaW6V07z4nB4vcCdQxfOJe7vVbQm/2tr1M=;
  b=G7Eb67jR44/cY6LWjKkC7el0GzTDmq62mJa4z2RScVi3fj+P95a3jvbx
   h7YvOZDp5CovP3jwR9ECYFuH4H28OPR+jAZXClzn7VMj37nLtCHWHQV6N
   ivx2pax0HNvF+EUClLTXhLZzbGGvreioAF9CO1afFJM5oZh8F6Wq+UbY/
   n2nQ0xAqrkH1yfBeaOQWkhI1BwtJk6OpxMOQHQXibAMxy/J4xfjKqGCXu
   H51EgAE3Z9JqHN4A8xKmTNH9oxgjmb95x4mHqvsWBktHaaboDklK+p8Wz
   M7Z6SSJe1vtne004dPmiMcXqLe1QL9ONbnml+C0vJLZ6gAhD1KYh3kt0Y
   g==;
X-CSE-ConnectionGUID: tCVJINStQDiguAPGeZZFcQ==
X-CSE-MsgGUID: cfMgyRozRkiKvwXC96f9PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="75136083"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="75136083"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 19:56:08 -0700
X-CSE-ConnectionGUID: P0epKf4XQtW73Kejrl1QVA==
X-CSE-MsgGUID: FYsUI1fpRcOt86Rqo8bqqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="254362383"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 19:56:06 -0700
Message-ID: <9df42fd2-8a27-42be-b827-59d7308dc910@linux.intel.com>
Date: Mon, 23 Mar 2026 10:54:55 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] iommupt/vtd: Support dirty tracking on PASID
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, "dwmw2@infradead.org"
 <dwmw2@infradead.org>, "joro@8bytes.org" <joro@8bytes.org>,
 "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "Tian, Kevin" <kevin.tian@intel.com>
References: <20260205023405.41583-1-zhenzhong.duan@intel.com>
 <20260206004325.GB943673@ziepe.ca>
 <IA3PR11MB91365DCBEAF527F9D5D1EF22924BA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <IA3PR11MB91365DCBEAF527F9D5D1EF22924BA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/23/26 09:51, Duan, Zhenzhong wrote:
> Hi,
> 
> Kindly ping, any comments?

This series looks fine to me. I will queue it (with the typo in the
subject fixed) for iommu/next if no further concerns. Thanks!

> Thanks
> Zhenzhong
> 
> On Wed, Feb 04, 2026 at 09:34:01PM -0500, Zhenzhong Duan wrote:
>> Hi,
>>
>> When we add pasid support in QEMU for passthrough device, we found
>> PASID attachment to a nested parent domain with dirty tracking failed.
>>
>> It's because PASID-level dirty tracking is not there yet, by adding it,
>> we can enable PASID attachment to such domain.
>>
>> Thanks
>> Zhenzhong
>>
>>
>> Zhenzhong Duan (3):
>>    iommupt/vtd: Pass dmar_domain pointer to device_set_dirty_tracking()
>>    iommupt/vtd: Support dirty tracking on PASID
>>    iommufd/selftest: Test dirty tracking on PASID
> 

