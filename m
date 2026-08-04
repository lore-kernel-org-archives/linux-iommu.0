Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7533B3939BF
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 05:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785821315; cv=none; b=KPzmP8Ug2BRIk4sYRy/bw3yXTCsapGhVURipiznGcfoYXlVxbpjxtHjJwZVE0ojxTjyvtkEOUncMNUvbngjAQPfTJ0CxpXNmwk6p/g4U6wlw/cR2Jk/ULRxHuId4T3qBLGfkIzW5EffLOL/6FdPFmFPkbde+XledkeZsvNLeYLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785821315; c=relaxed/simple;
	bh=N42M/YYQQO7WV3QpJhth7oHB0iyQhNmlbKbM7fecXKo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d/lf2Bmm+JBzOD5BY376aCKkoDX6xjh2YlcneQTxYm/BM0VIXQp4WsYqeGCuNxOyA4TyEdRQlJorAWxHvCVOiDSOTQXYpuPsSK7xQmw7jAKZJHLfQoHCVQiB4gmMMxNaMhsHyqb3crxbdBmaF6slmqhmT7iSgO3+TmcJBRFhqpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YiEYv3Zw; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YiEYv3Zw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785821313; x=1817357313;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N42M/YYQQO7WV3QpJhth7oHB0iyQhNmlbKbM7fecXKo=;
  b=YiEYv3Zwz4CsJ7HTD3HkUjJhfRbXpusZ9IICbKkiSq3p4cRLPEnfDY7v
   JK8D4u8J4d7AWDFzQ1ow8Krec6QaZjWXvitRcpFm7PfS3X5MONDEtthZH
   XNVBOyKxHqjNqHV+A+av1ypVQ4puMErVbbuv7fUEHGgswD0Y1ZSkkuFWr
   bDvXaP3L98WQ8OdbUfbcfVt3+kI59D8oh+dBQGEUyJJN4xXmS6fe3jMUV
   9lXWtUyIQpQGa5KUkgZl7sHflieVn28zfzjQGASAARlqf2p12HWcrCjYk
   yGTyg39mfNV0TqID0luIbqByCL7KLraYbJtrvXP942sddEnZqI+Lt26Gk
   Q==;
X-CSE-ConnectionGUID: EtDzDHJzTVO3Frk/pEmokQ==
X-CSE-MsgGUID: HlF6RrmjRzqnQmTKL9lgbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86239699"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86239699"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 22:28:33 -0700
X-CSE-ConnectionGUID: NVVE/OYDRNyae3kZ58B2Ag==
X-CSE-MsgGUID: ONy9K4HzQ46TVsbzD83Wug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="284797070"
Received: from unknown (HELO [10.238.0.222]) ([10.238.0.222])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 22:28:30 -0700
Message-ID: <04718cf6-3096-4dd3-ab35-48d950998479@linux.intel.com>
Date: Tue, 4 Aug 2026 13:28:28 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, ZhaoJinming <zhaojinming@uniontech.com>,
 Kevin Tian <kevin.tian@intel.com>, Dmitry Antipov <dmantipov@yandex.ru>,
 Guanghui Feng <guanghuifeng@linux.alibaba.com>,
 Desnes Nunes <desnesn@redhat.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW+WklumDqOmCruS7tl0gW1BBVENIIDAzLzIwXSBp?=
 =?UTF-8?Q?ommu/vt-d=3A_Fix_CACHE=5FTAG=5FNESTING=5FDEVTLB_polluting_shared_?=
 =?UTF-8?Q?variables_in_flush_loop?=
To: "Li,Rongqing" <lirongqing@baidu.com>, Joerg Roedel <joro@8bytes.org>
References: <20260804023714.3080506-1-baolu.lu@linux.intel.com>
 <20260804023714.3080506-4-baolu.lu@linux.intel.com>
 <d507f3039cec41a0be8782df1196294f@baidu.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <d507f3039cec41a0be8782df1196294f@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/4/2026 11:16 AM, Li,Rongqing wrote:
> 
> 
>> From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
>>
>> In cache_tag_flush_range(), the CACHE_TAG_NESTING_DEVTLB case modifies the
>> shared local variables 'addr' and 'mask' before falling through to
>> CACHE_TAG_DEVTLB. This causes all subsequent CACHE_TAG_DEVTLB entries in
>> the same loop iteration to incorrectly use the full-range flush parameters
>> (addr=0, mask=MAX_AGAW_PFN_WIDTH) instead of the precisely calculated PSI
>> range. This is not the intended behavior, as regular DEVTLB entries should always
>> perform targeted range-based invalidation.
>>
>> Fix this by having CACHE_TAG_NESTING_DEVTLB directly call
>> cache_tag_flush_devtlb_psi() with the full-range constants and break, instead of
>> modifying shared variables and falling through. This ensures
>> CACHE_TAG_DEVTLB always uses the original calculated addr and mask for
>> precise range flush.
>>
>> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/cache.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c index
>> fdc88817709f..26a758b0f501 100644
>> --- a/drivers/iommu/intel/cache.c
>> +++ b/drivers/iommu/intel/cache.c
>> @@ -454,9 +454,8 @@ void cache_tag_flush_range(struct dmar_domain
>> *domain, unsigned long start,
>>   			 * affected by a change in S2. So just flush the entire
>>   			 * device cache.
>>   			 */
>> -			addr = 0;
>> -			mask = MAX_AGAW_PFN_WIDTH;
>> -			fallthrough;
>> +			cache_tag_flush_devtlb_psi(domain, tag, 0,
>> MAX_AGAW_PFN_WIDTH);
>> +			break;
>>   		case CACHE_TAG_DEVTLB:
>>   			cache_tag_flush_devtlb_psi(domain, tag, addr, mask);
>>   			break;
>> --
>> 2.43.0
> 
> This patch introduces a subtle side effect on the tracing logic later in this function.
> At the end of cache_tag_flush_range(), trace_cache_tag_flush_range(tag, start, end, addr, mask) is called to log
> the flush operation.
> 
> With this patch: bypassed the assignment and used break, addr and mask retain their original range values.
> This causes the tracepoint to log an incorrect, smaller range while the actual hardware execution was a full-range flush.

The tracepoint here records what the caller requested: a specific cache-
invalidation type for a specific range. In this helper, we may widen the
invalidation range for implementation reasons (as described in the
comments), but that does not change the caller’s original intent.
Therefore, this tracepoint should log the caller-requested range.

If we want to observe the actual invalidation range sent to hardware,
that is already covered by the qi_submit trace event, which logs the
real invalidation descriptors submitted by the driver.

> 
> My patch has not this issue:
> https://lore.kernel.org/linux-iommu/20260605003950.1720-1-lirongqing@baidu.com/
Thanks,
baolu
