Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905B31DA61E
	for <iommu@lists.linux.dev>; Tue, 17 Dec 2024 08:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734423116; cv=none; b=grY3QFN2UybglCgydhJfHN0SEk27U3qNssEk1/B/IaDtETlOt7/lmzz2ZLkOq7ritX09WMmgirhEItDWGhX+dThKnD1nTPpnngZ3qM0fE7v2ivTyMckBwGtl/h09Dda8eKIYsnj0iDtB7qZFCVdUxTjVjjRx3wt4OcCo0xq5hgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734423116; c=relaxed/simple;
	bh=AERxveNaD/e1FdBKgOrry3YDia9uVcY/sn/NeRqtnS4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tsghGC4EF4rW1Mgyj2a0KEvpTbCb6e2QqgkwjfEEfwNwngB5z8Cia1xxM+p08BTMuqlo5YBjrXdPttQ5qovbrfan3aOzn4m8InGIjGSiLi9VxZ5DdICVZYv7XuOO32pdqWg22cMf7e2znk+luWkMxaxXe/IVj5xPAlB1txqHekU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cfaxVZuo; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cfaxVZuo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734423115; x=1765959115;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AERxveNaD/e1FdBKgOrry3YDia9uVcY/sn/NeRqtnS4=;
  b=cfaxVZuow4Z0pXMA1HAzZfYtESw9qpK+MfvZjmmqoVC+A7eyJT7vPITJ
   rrF5AYSy45n97KXLfhmPWCQXVCxXskwTPICUZD6CA5cpag0LfpT2UeDd3
   K33bqU/yt/mBfzg/akVoYZI/4NB0kRggOpGDrnMRbwkz1rbvBSF9jkXIp
   P3UgCZV6EPaRh5VBAy41ZLxGvcfvtu0KT793gWExAwFOB5vsXWH8F4pxj
   9nPGtnz436+eseA2/k+Dbn19X5Neq+mU/QvGLUJj+jtCuSO9UWS1iDtzf
   XlbLW8Jdh0eCedMva0JcLf+dwXu4XgmkCR/FlbuJVOqBPQ081SPqvQtzK
   A==;
X-CSE-ConnectionGUID: XLNFROyVSwG+c5YmqKQoMA==
X-CSE-MsgGUID: fLIxSMHeRQyw/OTEAR5G8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34714766"
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; 
   d="scan'208";a="34714766"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 00:11:55 -0800
X-CSE-ConnectionGUID: CB/AFxD9TDmvgcENTL9KtQ==
X-CSE-MsgGUID: olMcKVAyQ3mQL4+nA6zAzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128442656"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.241.34]) ([10.124.241.34])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 00:11:52 -0800
Message-ID: <4807944c-2855-46da-9ba9-9f425ad30411@linux.intel.com>
Date: Tue, 17 Dec 2024 16:11:49 +0800
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
Subject: Re: [PATCH 1/1] iommu/vt-d: Draining PRQ in sva unbind path when FPD
 bit set
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>
References: <20241217024240.139615-1-baolu.lu@linux.intel.com>
 <BL1PR11MB52712961A13B55ED1DDCCFE28C042@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BL1PR11MB52712961A13B55ED1DDCCFE28C042@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/12/17 15:39, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Tuesday, December 17, 2024 10:43 AM
>>
>> When a device uses a PASID for SVA (Shared Virtual Address), it's possible
>> that the PASID entry is marked as non-present and FPD bit set before the
>> device flushes all ongoing DMA requests and removes the SVA domain. This
>> can occur when an exception happens and the process terminates before the
>> device driver stops DMA and calls the iommu driver to unbind the PASID.
>>
>> There's no need to drain the PRQ in the mm release path. Instead, the PRQ
>> will be drained in the SVA unbind path. But in such case,
>> intel_pasid_tear_down_entry() only checks the presence of the pasid entry
>> and returns directly.
>>
>> Add the code to clear the FPD bit and drain the PRQ.
>>
>> Suggested-by: Kevin Tian<kevin.tian@intel.com>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> Need a fix tag given the old code doesn't work correctly?

Yes.

Fixes: c43e1ccdebf2 ("iommu/vt-d: Drain PRQs when domain removed from RID")
