Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6E4322B74
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 06:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773125219; cv=none; b=AOz/CGxt/m6rFPm/ZbFCRQU7SY4p+GWd/3PRJC09/Qm6qIjh/YjpMylj8luP/4DNsuqKuqUVNdUItrlk86cYxguc4oFATD0+9eEm1kV0REc5zIEG6XTa4R1cOVKNxYGP7eprIP49tJbA67ngIO6q6//myyoeZwbOBwDe0RYh6UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773125219; c=relaxed/simple;
	bh=HsqWOmPMti3rmre9716MYfiT9jCTYR3fveMxOR5Ked8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=diFk964coqPxQJLhHQ9imzw6vSd/ms8ahB7APE7lB+YDVJf3Gy0ZGCyu3xGGO60MdHfQ8dpxg6s4KecrOpblEh0PUlVsRwPiKSh2NzC9uCj/VedU+2osGHF515wBuWnye23gGFZAeRvJTNofCYx9DUx305FxtZKKy+2wpVWDzFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bMaIzRDp; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bMaIzRDp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773125218; x=1804661218;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=HsqWOmPMti3rmre9716MYfiT9jCTYR3fveMxOR5Ked8=;
  b=bMaIzRDpLSzLz36ZuAq09ABXwMjKi4QFdoHs7TLJyUqFNLIjxefxUe+O
   QWKDn026rcO2SZ34fpPpfw70BZARBpQoCPW3p5kCWNldEIGY/eY35IJ5N
   +0ZY8zTFtLHgmPGupAnQIu+Qjl2jL7VNOaN7aHospxatFUIu3VUNep4kR
   6B3stOdekHKMZcJX/UDloVJORJdCDBuaaR4L3AoXKkNi09Q2LUAcxlGEr
   wa8NYm+SDPT2lZmkPD/5mnSzzK+nDQf9iR1OwPS7UrgSF/OURrO+oGxOO
   6UDRgSLOJD+IcEmMoH/M0KItTQ3XDteVvdcIrofi4tktocrhwBhBf1/NG
   A==;
X-CSE-ConnectionGUID: tAS20LJ8QsSjq4VsibVFDw==
X-CSE-MsgGUID: UqzMb4sBTxeVVu3DI1K8xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="84873527"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="84873527"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 23:46:57 -0700
X-CSE-ConnectionGUID: rJ2EUHNYTJSyVuSiUny+0Q==
X-CSE-MsgGUID: eeQ8VV8hScO09HVjrMNMEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="250470971"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 23:46:55 -0700
Message-ID: <2993ad99-d118-4719-81e9-862182648301@linux.intel.com>
Date: Tue, 10 Mar 2026 14:46:07 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iommu/vt-d: fix intel iommu iotlb sync hardlockup and
 retry
From: Baolu Lu <baolu.lu@linux.intel.com>
To: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>,
 dwmw2@infradead.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 kevin.tian@intel.com, skhawaja@google.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260306101516.3885775-1-guanghuifeng@linux.alibaba.com>
 <f6af2887-a524-4bb0-8ea8-acdca50e66fe@linux.alibaba.com>
 <889933b2-a707-4632-a96a-f7e1ccc4c8b9@linux.intel.com>
Content-Language: en-US
In-Reply-To: <889933b2-a707-4632-a96a-f7e1ccc4c8b9@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/10/26 14:02, Baolu Lu wrote:
> On 3/9/26 17:05, guanghuifeng@linux.alibaba.com wrote:
>> There are some concerns:
>>
>> 1. During the invalid request execution process, the IOMMU first 
>> fetches requests
>>
>>      from the invalid queue to the internal cache.
>>
>>
>> 2. If an ITE timeout occurs during the execution of a request fetched 
>> to the cache in step 1,
>>
>>      the IOMMU driver clears the ITE status, allowing IOMMU to resume 
>> processing requests from the invalid queue.
>>
>>
>> 3. For requests already fetched in step 1 that experience an ITE 
>> timeout, after the IOMMU driver clears the ITE,
>>
>>      will IOMMU directly discard these timed-out/cached requests? or 
>> will it continue to execute these cached requests again?
>>
>>
>> Currently, the IOMMU driver implementation first clears ite to resume 
>> IOMMU execution
>>
>> before setting desc_status to QI_ABORT.
>>
>> If IOMMU will re-execute requests from the cache, then the IOMMU 
>> driver needs to be modified.
> 
> You are right.
> 
> The driver logic assumes that once an ITE error is cleared, the IOMMU
> will not resume its previous execution but will instead fetch new
> descriptors from the queue. This behavior was introduced by commit
> 6ba6c3a4cacfd ("VT-d: add device IOTLB invalidation support"), which has
> been part of the driver since 2009.

By the way, section 6.5.2.11 of the spec states:

"
... At the time ITE field is Set, hardware aborts any inv_wait_dsc
commands pending in hardware and does not increment the Invalidation
Queue Head register. When software clears the ITE field in the Fault
Status Register, hardware fetches descriptor pointed by the Invalidation
Queue Head register. ...
"

This implies that the hardware must abort the previous execution and
restart by fetching new requests.

Thanks,
baolu
