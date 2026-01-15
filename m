Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F374122B594
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 06:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768457734; cv=none; b=UDY9+SeJfu4Tq1mQaZAgn6Gcwd7mS8H4n+ctZjrDZssQFdcx3WTviO3xX6s6UnGwiBEKP6BuMFQgDiDjnIU13rcFwofFxq8byVpzrkn89aZxa2U4N3rxfmJrN2bLvJAo2XcPrCX1PpB9nx87d02RznPLSSdZK+3FUaS725YTUNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768457734; c=relaxed/simple;
	bh=3J7tIy8k8Bcf/iUPBVTRCC72t2DHrr8dVnhgEH9Q9ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dg4etf6C6ool1OY+zans4nAFovJBHxvR1wF21PBkg5+Z+6EftzQGqkDE6t9qNs4rqRw4txm5CEuB1mUncnSpxyiHlBRzes1WJmD/qXtwZODTR4WPd2Ti7ouB3PZBPAJnf0q35e6viGCkdClLGavgPLOn8Hw/wSk8V3wtuOXAF84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1W8bEql; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1W8bEql"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768457733; x=1799993733;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3J7tIy8k8Bcf/iUPBVTRCC72t2DHrr8dVnhgEH9Q9ug=;
  b=W1W8bEql1RsFhagCeHJPZeBGiD69KF7oHoQmX1mNy2dJ/xzkeSj95Mza
   I6IkX8m7uurU01biSaNM26SYd3NvRGMW9NmKvwuPTyUswkaPk6zNL5/ry
   KGDRUCZs9+uuv34JblqJRxrH0+zhpD6YOMzxLx6ovmUWfUvfhxJYkcoYm
   WpJgAjynalJsoZ5+ALQUJ7t16Vpea9YQCBCUZFeRKzT1fltBE1wsvwNbc
   4Pd2dQ2Bw67sNltzT/OXnOL9gEYYHpFHggKkRnYfLt+4u1N8z1yAPeMDH
   KD5P8MRcFEvAd1/trYb2aMEOXqd8J8Pts8sQWOLwPfh0WOMau1uRhgmXb
   w==;
X-CSE-ConnectionGUID: WYHIwumhTECO0xmlzGmZHQ==
X-CSE-MsgGUID: +m5kc23vS7qacR40XOLTrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="72345742"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="72345742"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 22:15:32 -0800
X-CSE-ConnectionGUID: Pj1GQVOFRsqZrvJuRHsaaw==
X-CSE-MsgGUID: DapuPcptS7yR3gSSG93FjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="236129327"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 22:15:28 -0800
Message-ID: <f3ab0156-3d7c-470d-9c1e-922195ea27af@linux.intel.com>
Date: Thu, 15 Jan 2026 14:15:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/5] iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
To: Mostafa Saleh <smostafa@google.com>, linux-mm@kvack.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
 mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, xiaqinxin@huawei.com, rdunlap@infradead.org
References: <20260114164322.787125-1-smostafa@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260114164322.787125-1-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/26 00:43, Mostafa Saleh wrote:
> Changes in v7:
> v6:https://lore.kernel.org/linux-iommu/20260109171805.901995-1- 
> smostafa@google.com/
> - Add a new function page_ext_get_phys() and use it instead of
>    pfn_valid() + phys_to_page().
> - Drop R-bs on patch 4.

This series has been applied. If you have any further fixups, it's
better to submit them as follow-up patches.

Thanks,
baolu
