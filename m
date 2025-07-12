Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166DFB672
	for <iommu@lists.linux.dev>; Sat, 12 Jul 2025 04:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752293374; cv=none; b=DOExHqE6nXBqsPgU1tRMFT/uyYA7/zO2bKgr7mQEX7KiDRPaUsQY8aCZF9J8xS9+0FtkPk+w99LaOaOVdjn+JFscUaQTVR/+oWfyLDjYaZosxAsdG7vpx2y5SyRDb08ycmqoJ44Pbn208Au5pyBnX4ioyASya8RC4/g5bqdxhWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752293374; c=relaxed/simple;
	bh=ZJPnn8z/XLV+Jur/c3LcHzRPs5oRSCBYt60lFpPVtD0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k0Z1CgdPktOL07Kw6oJGNjpsY7oNUOvDsS63TtUXgugrE5BUPfuurwc/ERkTb5mI6EIG+yeo4MBSX4aPxKbrkiQlsZj4izMKDEY2HV6fDihZktrPNzu8sTHK6dtOF3JwICrk0Fbb6nOs90uIyOpynp2g0KXHQ3nDC85/aaR7WEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qub8g9F/; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qub8g9F/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752293372; x=1783829372;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZJPnn8z/XLV+Jur/c3LcHzRPs5oRSCBYt60lFpPVtD0=;
  b=Qub8g9F/XE2a0Aa/MWae5wCOw2u2bd4ZXeMSMBQEmdHfmLhyhQgAfaLO
   ViYjMM7J+R0yfs/xdvnt40KnKuFtDGEBTpzmNbaVhSxwdeUEV4PgdnhUZ
   QTsNXT4Vd5a1kbjjzcMoOXjaH+/hUpcaZ5QxuFHHmt81at0RYQUm9zF8t
   gTWTIalWB4MXUhFtQIBV5IQ+wOMOZoP9mMZHwhsQ8/ZcJMSqx988AGxZF
   Ev23OsiIqAHHT6WNqg0ChkpDPo5aXO5wO0dnrmwEYWtaASfQbSt2dYaBu
   7ZaEeqooBUNg5BL6hEtewdhiyic3SWyd5OaYA5MdoXBmlIxUxU2VU+XMq
   Q==;
X-CSE-ConnectionGUID: 0qdhSZiTTlalj5FsIyuuIw==
X-CSE-MsgGUID: jVYm/NzdSoCXUWjufR1+bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53804162"
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="53804162"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 21:09:31 -0700
X-CSE-ConnectionGUID: 6NM2SYgvSUyrRLHk/3h3ng==
X-CSE-MsgGUID: pFQAxnvmTNaHO0VCoueZIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="156845907"
Received: from jinwang1-mobl1.ccr.corp.intel.com (HELO [10.124.243.252]) ([10.124.243.252])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 21:09:30 -0700
Message-ID: <394f73e6-227e-4874-8b1f-9d4f2a5984a4@linux.intel.com>
Date: Sat, 12 Jul 2025 12:09:27 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: Re: [PATCH 1/2] iommu/vt-d: Fix missing PASID in dev TLB flush with
 cache_tag_flush_all
To: Ethan MILON <ethan.milon@eviden.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20250708214821.30967-1-ethan.milon@eviden.com>
 <015a0eba-d26d-4565-9cbb-d4c9e700501e@linux.intel.com>
 <2125ee10-7b23-4890-a80c-d561ba06f23d@eviden.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <2125ee10-7b23-4890-a80c-d561ba06f23d@eviden.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/11/2025 4:21 PM, Ethan MILON wrote:
> Hi Baolu,
> 
> Thanks for the review.
> 
> On 7/10/25 10:59, Baolu Lu wrote:
>> Caution: External email. Do not open attachments or click links, unless this email comes from a known sender and you know the content is safe.
>>
>>
>> On 7/9/2025 5:48 AM, Ethan MILON wrote:
>>> The function cache_tag_flush_all() was originally implemented with
>>> incorrect device TLB invalidation logic that does not handle PASID, in
>>> commit c4d27ffaa8eb ("iommu/vt-d: Add cache tag invalidation helpers")
>>>
>>> This causes regressions where full address space TLB invalidations occur
>>> with a PASID attached, such as during transparent hugepage unmapping in
>>> SVA configurations or when calling iommu_flush_iotlb_all(). In these
>>> cases, the device receives a TLB invalidation that lacks PASID.
>>>
>>> This incorrect logic was later extracted into
>>> cache_tag_flush_devtlb_all(), in commit 3297d047cd7f ("iommu/vt-d:
>>> Refactor IOTLB and Dev-IOTLB flush for batching")
>>>
>>> The fix replaces the call to cache_tag_flush_devtlb_all() with
>>> cache_tag_flush_devtlb_psi(), which properly handles PASID.
>>>
>>> Fixes: 4f609dbff51b ("iommu/vt-d: Use cache helpers in arch_invalidate_secondary_tlbs")
>>> Fixes: 4e589a53685c ("iommu/vt-d: Use cache_tag_flush_all() in flush_iotlb_all")
>>>
>> Remove above blank line.
> Noted.
> 
>>> Signed-off-by: Ethan Milon<ethan.milon@eviden.com>
>> checkpatch.pl complains:
>>
>> WARNING: From:/Signed-off-by: email name mismatch: 'From: Ethan MILON
>> <ethan.milon@eviden.com>' != 'Signed-off-by: Ethan Milon
>> <ethan.milon@eviden.com>'
> Understood. Our email server seems to overwrite our last names. I’ll
> look into correcting that.
> 
>>> ---
>>>    drivers/iommu/intel/cache.c | 18 +-----------------
>>>    1 file changed, 1 insertion(+), 17 deletions(-)
>> Other looks good to me.
> Should I send a v2 with the fixes?

No. I can change it manually if you have no objection.

Thanks,
baolu
