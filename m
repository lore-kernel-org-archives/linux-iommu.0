Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0E235BDC2
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 05:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768369525; cv=none; b=ZOVo9edviQ2/iYUfrHKQ9L44s0se89vor85ED5lO6yYCO9zjOLnIWIYoDRtGOEKZqSw2H0shE2jF7sK6nEQ+pyDUfojJK1p5K2vsRCxMq927YZoyCy76awUH+LkubTa4eMX5x5lJEQ/jwuw7pqe2G0n8pWbeMH4B9vY4dURa5W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768369525; c=relaxed/simple;
	bh=aMeL2laT0NhLCwJfSRDJEB8bVxQ/LT7NOk83/6mB4vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KhQloAcipJfrbRwyifTJ/tIc6J/z6YjOFGxtOAQ32FQXv1lJhuulao8DHZKYMiaL4aELUQVu8QeCPcyOvIrSwARHNklMVzyTgcYU0uS01rZvgocoTHtyDlJ4LxeGReR7GvvTsGmuvH0u8CN+QPToB0LB7U5HZOrxy65+Vgg6sYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UdOlwTw4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UdOlwTw4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768369515; x=1799905515;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aMeL2laT0NhLCwJfSRDJEB8bVxQ/LT7NOk83/6mB4vc=;
  b=UdOlwTw4h3Em4hxZ7us7nv8tzttJOxnofxjDABPoDn/qgwflD0hYS9ig
   nots0yMY/CWbeATk0NeiWi2doTxsa7R+Zin6/QbzqggFHev69JMNKqBLE
   9WWBmSdZit3HMAFf4yt9wIUhJddvO94f5O5uzFjeTgPOIz9J8VRIUBo3h
   3tDoUSmSlaS8KSjIVZBS7YgVUu6EcJH0YslH0DNpY1+mLRDLZ3a7Rw2oQ
   sUGnlXFpRjTec29OarHKUHlRDvab+qCwWzMjpkazGPxLTJus2ypOtctCK
   x6tylnyxYVKVjEFcgGQIiLFBcqV3mSrZ9Zz7hJDDF+z1d9YfRGwa6kVgr
   Q==;
X-CSE-ConnectionGUID: 7tMwTEjmRXaed89D8M4VOg==
X-CSE-MsgGUID: JNF/93/4TS6KArWrIWBOUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="73518870"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="73518870"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:45:13 -0800
X-CSE-ConnectionGUID: lT4+8GHkQK2IY0OY7UrCjA==
X-CSE-MsgGUID: /xwQOJRXS9e910HJBYxe/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="204377298"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:45:10 -0800
Message-ID: <ef58cd8a-504d-457b-b731-f7dfdba0e43c@linux.intel.com>
Date: Wed, 14 Jan 2026 13:45:16 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iommu/vt-d: Rework hitless PASID entry replacement
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Dmytro Maluka <dmaluka@chromium.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-4-baolu.lu@linux.intel.com>
 <CAAywjhSv56Y9rJLVdqV9N54c7S30ZUjyNh05xc-EW2+dS74GFQ@mail.gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CAAywjhSv56Y9rJLVdqV9N54c7S30ZUjyNh05xc-EW2+dS74GFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/14/26 03:27, Samiullah Khawaja wrote:
> On Mon, Jan 12, 2026 at 7:03 PM Lu Baolu<baolu.lu@linux.intel.com> wrote:
>> The Intel VT-d PASID table entry is 512 bits (64 bytes). Because the
>> hardware may fetch this entry in multiple 128-bit chunks, updating the
>> entire entry while it is active (P=1) risks a "torn" read where the
>> hardware observes an inconsistent state.
>>
>> However, certain updates (e.g., changing page table pointers while
>> keeping the translation type and domain ID the same) can be performed
>> hitlessly. This is possible if the update is limited to a single
>> 128-bit chunk while the other chunks remains stable.
>>
>> Introduce a hitless replacement mechanism for PASID entries:
>>
>> - Update 'struct pasid_entry' with a union to support 128-bit
>>    access via the newly added val128[4] array.
>> - Add pasid_support_hitless_replace() to determine if a transition
>>    between an old and new entry is safe to perform atomically.
>>    - For First-level/Nested translations: The first 128 bits (chunk 0)
>>      must remain identical; chunk 1 is updated atomically.
> Looking at the specs, the DID is part of the first 128 bits (chunk 0),
> so I guess for the first level the hitless replacement would not be
> supported since each domain will have a different DID?

It's not necessarily true that each domain will have a different DID. On
Intel IOMMU, all SVA domains can share a single DID. Similarly, multiple
nested domains sitting on top of the same second-stage page table can
also share a DID.

Thanks,
baolu
