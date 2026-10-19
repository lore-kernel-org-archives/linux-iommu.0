Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F9939099C;
	Mon, 19 Oct 2026 08:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399225; cv=none; b=CUt7Bu6jltVdT0e7pU1QNXnaKDOwl+bZ5hTyBgjA2nxyskWuEeVQ68PgkD6jBMnXARoNVI857rD7quVqsbUPoR8Y86azDcOn7rO7bzleKW7QHDO2GnZKnIw6nZ6swTL/ddJBEBEGeT4XmYTLBIgTVsK870T4xeIkZPnu7FKysPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399225; c=relaxed/simple;
	bh=KWcr5ws1T+Y+q5Rn9N1O4W+X1Ule0Fe3HEH+AFePKBg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uVQrGYPGJiyAYORESpBVQag4MkWO+NqSRFd/U0zN078FwOgzvOHFuoB6Dj8SclV7NXxj0O45apRHKfHu1BEfs0p1yadRfdp14lt5sDtHSXIEdqjtybt9N5cXElWdL5R7JpmLZlFCpXBP+yLZFZd0oBtEVF4fMyNmcaAJzV8dhNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cgAu3hXS; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cgAu3hXS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792399224; x=1823935224;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KWcr5ws1T+Y+q5Rn9N1O4W+X1Ule0Fe3HEH+AFePKBg=;
  b=cgAu3hXS2ZPrQjp1A85r0U1sBZT8/iZRpTtT3itDd5YStLeANxmfYOsb
   K+Pc5pNkDChWjQSuDyhSKcqqPaaO9agaOfCDd10+TddiAAixy+LXxN1X7
   U5Pgyor/gcoyzLnyl8b82H1OHLUPgqP44jcg2wwSvQCtb0b2BMSIPt84v
   y/szHkaGzTvF8PXYTnm5ariuHl6jHmYEPDWoUl3Nzm4KkRXK99mBBlLxP
   PXXnE+Zh0bJKyM48DkNje7FpbnDp0Ao0jsbY+W79MwxcnHVfcnyjsMcCi
   2AxDzlcN7Z/XpVYc8Ae1xzE09fgU8sS8vLrawgN7P2+CT4iBLfilHwodf
   Q==;
X-CSE-ConnectionGUID: U1roqfjwR/is2SDqanP1xw==
X-CSE-MsgGUID: 3Bf+Eg7CTuGtXqulRXqoDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="968950"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="968950"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:40:23 -0700
X-CSE-ConnectionGUID: rafHIO+cQcKjGkQXju9sVQ==
X-CSE-MsgGUID: bVRr0XDMRaG2XWW9ak9Hag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2821155"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:40:19 -0700
Message-ID: <f6112a7c-2ece-4224-b9b0-bf3cdcfa0cbe@linux.intel.com>
Date: Mon, 19 Oct 2026 16:40:16 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev, x86@kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, yilun.xu@linux.intel.com,
 xiaoyao.li@intel.com, Binbin Wu <binbin.wu@linux.intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] coco/tdx-host: Initialize trusted DMA on all
 capable IOMMUs
To: Chao Gao <chao.gao@intel.com>
References: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
 <20261015010705.1973284-5-baolu.lu@linux.intel.com>
 <atXAxzxYdDo6RbHM@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <atXAxzxYdDo6RbHM@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/19/2026 3:03 PM, Chao Gao wrote:
>> +static int tdx_iommu_setup(struct dmar_drhd_unit *drhd)
>> +{
>> +	const struct tdx_sys_info *tdx_sysinfo = tdx_get_sysinfo();
>> +	unsigned int mt_page_count = tdx_sysinfo->tdx_connect.iommu_mt_page_count;
>> +	struct tdx_iommu_state *state;
>> +	u64 r, tdx_iommu_id;
>> +	int ret;
>> +
>> +	struct tdx_iommu_state *iommu_state __free(kfree) = kzalloc_obj(*iommu_state);
>> +	if (!iommu_state)
>> +		return -ENOMEM;
>> +
>> +	struct tdx_iommu_pages *iommu_mt __free(free_mt_pages) =
>> +			tdx_iommu_alloc_mt_pages(drhd, mt_page_count);
>> +	if (!iommu_mt)
>> +		return -ENOMEM;
>> +
>> +	r = tdh_iommu_setup(drhd->reg_base_addr, iommu_mt->root, &tdx_iommu_id);
> 
> Dynamic PAMT was merged in 7.3. With it enabled, the PAMT for 4K pages

I guess you mean v7.4-rc1? v7.3 has already been finalized. Either way,
I will add dynamic PAMT support in the next version when I rebase.

> is no longer allocated up front, and the kernel must add PAMT backing
> before giving a page to the TDX module. So, the IQ buffers and the metadata
> pages need tdx_pamt_get() before TDH.IOMMU.SETUP and tdx_pamt_put() after
> TDH.IOMMU.CLEAR hands them back.

I will add something like the following:

- call tdx_pamt_get() on every 4K page of the IQ buffers and the
   metadata pages before TDH.IOMMU.SETUP, and tdx_pamt_put() on the
   SETUP failure pah;
- call tdx_pamt_put() after TDH.IOMMU.CLEAR succeeds. If CLEAR fails,
   the pages and their PAMT backing stay with the TDX module and are
   leaked;
- probably it is needed to export the PAMT helpers to tdx-host.

Thanks,
baolu


