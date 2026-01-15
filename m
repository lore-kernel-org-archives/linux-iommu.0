Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2C421B9DA
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 02:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768443976; cv=none; b=YD2ntYExlQ0rHLwW+tfL1FZ54ZsqeWJxWYQAjyR1j2DOxU/QilSAg5VBvaOxOUdlqHs6YDUR18qXEMF5uRZd/ZibFnItyXPvXgZmscASpnfLqGtf5Hcj+SL0ilkoWGjsXXCAseuZYa4d5kPeUoe9DxwdrxMRZGQv22uCWq61RXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768443976; c=relaxed/simple;
	bh=mrvTsLSyZASPkEq8eoLsqBbQSJGGHf/bcVtSAC2Rkxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vr8uHrF4F3oAg5ouiM+oQGoGsmSERkqGrcvWmki2RNsthBUXPuhMdSmxOlHAx1OX3sMmTN0dA96du3dwrv3BpqSzargdq3V+l4JBXzCjTLeTN5+s9cSo46g+qSjGiIa88+4iQzA9UXdzRCA/0XgHJO/noNC2meCAb9f+DpBC6Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dKKfPDNi; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dKKfPDNi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768443975; x=1799979975;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mrvTsLSyZASPkEq8eoLsqBbQSJGGHf/bcVtSAC2Rkxs=;
  b=dKKfPDNiGdQtwGjbcfOr2hoJXVeuznbXsNevpjUPLZAQiAeonbLK1BmQ
   X8c52D6U6iPLh8IjoyPtL8POeVnzwlrKTBOMBUM3KJZ8jieCLGLhntlde
   25Yg5JpMTPS7slanFhwIV2CT/jlNmRvS++t0BiX/de+XHXD7pZLKe7EMY
   E2GulU2+ik+QDgPcoiKB051IhqBmZIs0EXarMiTSFmPeKF2VQ3A5xjX0c
   IGSkrj2Ds53WyoJyLKpeZwszftohhT6E3Z+Ctc99hwycEkc9oPgZ8H6/N
   +a63PO0D2EyUAALJbp8qH+p5aqLRsN4GiJlWeu95Q8EfwgOTH/5bkPSJl
   g==;
X-CSE-ConnectionGUID: frectNkoShW+CdlvxaTk7w==
X-CSE-MsgGUID: qdgMpih/RJiQNLut3f+lqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="81117261"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="81117261"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 18:26:15 -0800
X-CSE-ConnectionGUID: YePebot+Qx2PzVnHNu8uHQ==
X-CSE-MsgGUID: s7/EAOEFQ6mQ0HSk/3NZsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="204052299"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 18:26:12 -0800
Message-ID: <a2b12b1b-abd6-4d3b-b3f8-07c9f71bc7f0@linux.intel.com>
Date: Thu, 15 Jan 2026 10:26:16 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iommu/vt-d: Use 128-bit atomic updates for context
 entries
To: Dmytro Maluka <dmaluka@chromium.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
 Aashish Sharma <aashish@aashishsharma.net>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-2-baolu.lu@linux.intel.com>
 <aWacsq9gDrAgPxli@google.com>
 <1e967054-d2bd-4c3d-99eb-315a40bac9de@linux.intel.com>
 <aWd2KCSU6XTNmQ4R@mitya-t14-2025>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <aWd2KCSU6XTNmQ4R@mitya-t14-2025>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/26 18:55, Dmytro Maluka wrote:
> On Wed, Jan 14, 2026 at 01:14:36PM +0800, Baolu Lu wrote:
>> On 1/14/26 03:27, Dmytro Maluka wrote:
>>> On Tue, Jan 13, 2026 at 11:00:46AM +0800, Lu Baolu wrote:
>>>> +static __always_inline void intel_iommu_atomic128_set(u128 *ptr, u128 val)
>>>> +{
>>>> +	/*
>>>> +	 * Use the cmpxchg16b instruction for 128-bit atomicity. As updates
>>>> +	 * are serialized by a spinlock, we use the local (unlocked) variant
>>>> +	 * to avoid unnecessary bus locking overhead.
>>>> +	 */
>>>> +	arch_cmpxchg128_local(ptr, *ptr, val);
>>> Any reason why not cmpxchg128_local()? (except following the AMD driver)
>>
>> Yes. This follows the AMD IOMMU driver. Both drivers use spin lock to
>> synchronize the update of table entries. They only need the atomicity of
>> the 128-bit instruction itself. So arch_cmpxchg128_local() works.
> 
> Yeah, but my question was merely: why use the raw arch_*() version, not
> cmpxchg128_local() which is the same but also includes optional
> kasan/kcsan instrumentation:
> 
> #define cmpxchg128_local(ptr, ...) \
> ({ \
> 	typeof(ptr) __ai_ptr = (ptr); \
> 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
> 	raw_cmpxchg128_local(__ai_ptr, __VA_ARGS__); \
> })
> 
> IOW, why bypass this instrumentation?

You are right. There is no strong technical reason to bypass the kasan/
kcsan instrumentation here. My use of the arch_ version was primarily
following the existing pattern in the AMD driver, likely under the
assumption that the spinlock provided sufficient synchronization.

That said, Jason has suggested the generic entry_sync library to handle
these types of multi-quanta updates across different IOMMU drivers. I
plan to adopt that in the next version.

Thanks,
baolu
