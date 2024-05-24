Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C712363B8
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 01:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716513005; cv=none; b=Z7eqXr+sEHB+dlp3k3wSkYzdLFCtypvkaGahIfkZOcY1Zg+Yi0ItO9rAyjdmKFHXgRvbEN6dJ46SQvzKECZPCOZhRzwjVZOIIxEu2wvsyknFyRjI9FMKbW77KsjUhZ411fWnsMHxEz+NwBXAMSMoo6poxCRD/PBK0x4SVinsbV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716513005; c=relaxed/simple;
	bh=9zABepybl5Xgb4WhZA5zrlZW3sm8pmuNcyyKqdDjNS4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RKv+SZLy8MsQFmnKbcxS2B6bpVZNNlHyPb9H1LZ1oqjaroux4oNBHg/9OndBEG6BPBS0h+oww5hqy1WuM4l+1l27aGifaA9VyM7sBtPD6AH9g7F+UskHvZV2D6tPwWMEY31uTsYIHxzakUJ+YpntyQzepQa4202itc/0rb0PbXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DK5VZN6k; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DK5VZN6k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716513004; x=1748049004;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9zABepybl5Xgb4WhZA5zrlZW3sm8pmuNcyyKqdDjNS4=;
  b=DK5VZN6k3femHbGi+X8L/hKRLIAv1H8lua4wQFTd9+fMcUKlfCAfjOBS
   xZ8ZoJjESAnkQ5yXo3qVguzL3OZalo/XpQQA/Dzc2l3xcmV+xohazXFKZ
   jAaCFfcLERI4mnV4YVjKKa2Q2hE+adqHg817B1O25CFAyTmWQR2FUHT/U
   eRoUnz/ODH9RHJK1Twbh4HX6XnsUzYMYHtwkbP4rePB/cVIdWD+JnR+dF
   pL96Um7h1TH5EesHqD51htp1H5yf6323tIeKwsZ7wAGYQ1f9Fe2QuzJWF
   ynLfFnwtGI/5+n2hVEYmICkxcCYBiPE9dMKwHZZ2oiAeZ0kqnFzzCSN/x
   g==;
X-CSE-ConnectionGUID: YBLKPqskTOeNUCB4dQ+TPw==
X-CSE-MsgGUID: coDwwPYPQUe8/vSmXgIOtg==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="16662218"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="16662218"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 18:10:03 -0700
X-CSE-ConnectionGUID: g7IsVQLASryIB31Jt5lnsw==
X-CSE-MsgGUID: VClbEt7rTEarGLeuFs+a+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="65065176"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa001.fm.intel.com with ESMTP; 23 May 2024 18:10:01 -0700
Message-ID: <a6a8f04b-0dd8-462b-8bad-8b7c2dc0d736@linux.intel.com>
Date: Fri, 24 May 2024 09:08:04 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/3] iommu/vt-d: Use try_cmpxchg64() in
 intel_pasid_get_entry()
To: Uros Bizjak <ubizjak@gmail.com>
References: <20240522082729.971123-1-ubizjak@gmail.com>
 <20240522082729.971123-2-ubizjak@gmail.com>
 <c1892ba9-4eae-40fc-b3ab-73d0f82a74ea@linux.intel.com>
 <CAFULd4Z=YkV1Hbs4DikPBwO-6rg8tfDLGeacSCnfbC02E5y+Cg@mail.gmail.com>
 <b100a3c4-e5c3-41da-8c02-3a4986b49eec@linux.intel.com>
 <CAFULd4aXBAxPS7hXJ_RKMzZu60yTr7gK1m3K8z0yq1mjYn3dyA@mail.gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CAFULd4aXBAxPS7hXJ_RKMzZu60yTr7gK1m3K8z0yq1mjYn3dyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/23/24 9:57 PM, Uros Bizjak wrote:
> On Thu, May 23, 2024 at 3:44 PM Baolu Lu<baolu.lu@linux.intel.com>  wrote:
>> On 2024/5/23 21:34, Uros Bizjak wrote:
>>>>> +             if (!try_cmpxchg64(&dir[dir_index].val, &tmp,
>>>>> +                                (u64)virt_to_phys(entries) | PASID_PTE_PRESENT)) {
>>>> Above change will cause a dead loop during boot. It should be
>>> No, it is correct as written:
>>>
>>> if (cmpxchg64(*ptr, 0, new))
>>>
>>> can be written as:
>>>
>>> if (cmpxchg64(*ptr, 0, new) != 0)
>>>
>>> this is equivalent to:
>>>
>>> tmp = 0ULL;
>>> if (!try_cmpxchg64(*ptr, &tmp, new))
>> The return value of both cmpxchg64() and try_cmpxchg64() is the old
>> value that was loaded from the memory location, right?
> Actually, try_cmpxchg() returns true if successful and false if it fails.

Oh! I misunderstood this.

> 
>              tmp = 0ULL;
>              if (!try_cmpxchg64(*ptr, &tmp, new))
> 
> The logic in the above snippet can be interpreted as:
> 
> if we fail to compare *ptr with 0, then:
> 
>              iommu_free_page(entries);
>              goto retry;
> 
> as intended in the original code.

Okay, it's fine.

Best regards,
baolu
