Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD22429023
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 07:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827941; cv=none; b=nHDBhDjUtsmBMY2HiHvoM77hkwnIbiI0+lLqZ5KTSCmCMu0NioCdhJ1lzjPS7O1YzNFyVe2ASqCa6cWvX5h8pWEw9LHeO51R50CH4sOFTrianja2hk21iAEs7FO0cJR9/G74SzTtn7zP94WNto9AulosqalEYEFY88a5Kvo9QbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827941; c=relaxed/simple;
	bh=R6N8MrPZWml0hWue4zcFCfYRP59ibTn2Eu97xzGkdAM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B5X+Ug1HtfGQf40KQhhd0ssz4BcuvcZkvIvKr92JD1xYLIcfKt/mBDFLeDakA8qu+RYveh0bbCO/0Y58QVWb8LqmmBAAGX+eU8PN7nQau+VDi+37j2OVpr27j9ag1OsJuMWiU+AqFZV06CPTMX1T+D2ITZ/u0yJMQdGom5JAml0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EJI3mOMq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EJI3mOMq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785827938; x=1817363938;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R6N8MrPZWml0hWue4zcFCfYRP59ibTn2Eu97xzGkdAM=;
  b=EJI3mOMqbUF2zOqJTHL2cy6AvSSLxNKP3bIFb7UdwLoXJDXHiTW0Ca7+
   fdhNPXjElfOyEQu7oiVhOjvq/hSp1OYAA85My1TQbqQzwpi7W7Soz+3Kn
   zPn0DYqQOFELTEJrns9tpGn683wYSMSBgi8qH0Yas9R3NfWDXHMnyjwTA
   M3mvZpAMH3Go83/xBmYGVK/nKzx590LoNN+vw2o3xxRgbgbsYTMRSXGEE
   0JW96rqhNw+7A1IKCY2uyN5Qi86rzsObhUfnXUhITDUh8FC+H259ZzGMm
   FZ7D8JA2u0hM+fbUQy8Y+LvwHlfF5G7ujX/gRHrEZoNOucSCJu56PvvpD
   w==;
X-CSE-ConnectionGUID: 5t9vYesoSUiioiR9K0eRig==
X-CSE-MsgGUID: tBS+CDHPRLiSgi8Z9BBVug==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="96732825"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="96732825"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 00:18:58 -0700
X-CSE-ConnectionGUID: kyqIWL0uS7+STXeq0FHHtQ==
X-CSE-MsgGUID: CGmmEcHCTdCTwBXqm9CLiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="284816066"
Received: from unknown (HELO [10.238.0.222]) ([10.238.0.222])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 00:18:55 -0700
Message-ID: <713cc13d-bfb5-40c1-97b4-bb97d2831b95@linux.intel.com>
Date: Tue, 4 Aug 2026 15:18:53 +0800
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
 <04718cf6-3096-4dd3-ab35-48d950998479@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <04718cf6-3096-4dd3-ab35-48d950998479@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/4/2026 1:28 PM, Baolu Lu wrote:
> On 8/4/2026 11:16 AM, Li,Rongqing wrote:
>>
>>
>>> From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
>>>
>>> In cache_tag_flush_range(), the CACHE_TAG_NESTING_DEVTLB case 
>>> modifies the
>>> shared local variables 'addr' and 'mask' before falling through to
>>> CACHE_TAG_DEVTLB. This causes all subsequent CACHE_TAG_DEVTLB entries in
>>> the same loop iteration to incorrectly use the full-range flush 
>>> parameters
>>> (addr=0, mask=MAX_AGAW_PFN_WIDTH) instead of the precisely calculated 
>>> PSI
>>> range. This is not the intended behavior, as regular DEVTLB entries 
>>> should always
>>> perform targeted range-based invalidation.
>>>
>>> Fix this by having CACHE_TAG_NESTING_DEVTLB directly call
>>> cache_tag_flush_devtlb_psi() with the full-range constants and break, 
>>> instead of
>>> modifying shared variables and falling through. This ensures
>>> CACHE_TAG_DEVTLB always uses the original calculated addr and mask for
>>> precise range flush.
>>>
>>> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
>>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>> ---
>>>   drivers/iommu/intel/cache.c | 5 ++---
>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/ 
>>> cache.c index
>>> fdc88817709f..26a758b0f501 100644
>>> --- a/drivers/iommu/intel/cache.c
>>> +++ b/drivers/iommu/intel/cache.c
>>> @@ -454,9 +454,8 @@ void cache_tag_flush_range(struct dmar_domain
>>> *domain, unsigned long start,
>>>                * affected by a change in S2. So just flush the entire
>>>                * device cache.
>>>                */
>>> -            addr = 0;
>>> -            mask = MAX_AGAW_PFN_WIDTH;
>>> -            fallthrough;
>>> +            cache_tag_flush_devtlb_psi(domain, tag, 0,
>>> MAX_AGAW_PFN_WIDTH);
>>> +            break;
>>>           case CACHE_TAG_DEVTLB:
>>>               cache_tag_flush_devtlb_psi(domain, tag, addr, mask);
>>>               break;
>>> -- 
>>> 2.43.0
>>
>> This patch introduces a subtle side effect on the tracing logic later 
>> in this function.
>> At the end of cache_tag_flush_range(), 
>> trace_cache_tag_flush_range(tag, start, end, addr, mask) is called to log
>> the flush operation.
>>
>> With this patch: bypassed the assignment and used break, addr and mask 
>> retain their original range values.
>> This causes the tracepoint to log an incorrect, smaller range while 
>> the actual hardware execution was a full-range flush.
> 
> The tracepoint here records what the caller requested: a specific cache-
> invalidation type for a specific range. In this helper, we may widen the
> invalidation range for implementation reasons (as described in the
> comments), but that does not change the caller’s original intent.
> Therefore, this tracepoint should log the caller-requested range.
> 
> If we want to observe the actual invalidation range sent to hardware,
> that is already covered by the qi_submit trace event, which logs the
> real invalidation descriptors submitted by the driver.

I will add the following in the commit message:

"
This change slightly affects trace_cache_tag_flush_range() behavior.
Previously, after addr/mask were overwritten, the tracepoint could
record a full-range flush even when the caller requested a narrower
range.

The tracepoint should reflect caller intent. Although this helper may
widen the actual hardware invalidation range for implementation reasons,
that does not change what the caller requested, so logging the requested
range is the correct behavior.

If the actual invalidation range sent to hardware is needed, it is
already visible via the qi_submit trace event, which records the
invalidation descriptors emitted by the driver.
"

Thanks,
baolu
