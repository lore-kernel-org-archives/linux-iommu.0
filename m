Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F3615533F
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 07:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729669304; cv=none; b=ap84jufCrmwP+r1iVxAxyBOORwrMeXTNyV16yBEmleikAlzo148wHwzQUI5vXOCsOwIrbJWHEGi0kzdlJ85n2LzDP1wpUwQQZK7SH2TmcI6+PHLpflAIVZ9tmH9jKu36IkHa1f5aHnGsIEjhpi+K6RvECntBE5a1qvxN2HddhTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729669304; c=relaxed/simple;
	bh=lK/s1B24s6lazKk6ZuJZC6mKnM5vtX1llJDWdArksj4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZWNtCZXLbvtqmy03wkCOZqHy5557uEcxIYmgfVz2nsu/tH7/fYVEV7WR81dAq6Pn1m5b7l4yyIiLySORrjr4WnwcpEDU8Lk/QicgFLXSuBiTJKm53O0DAP8thNrPs0q1n96CD5tv+DsNW5e1vypOpWh1AJjqnadT0a05CRPlYXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ArYVKW9G; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ArYVKW9G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729669303; x=1761205303;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lK/s1B24s6lazKk6ZuJZC6mKnM5vtX1llJDWdArksj4=;
  b=ArYVKW9GP0S1Wnp9Qep9BmYZN3xzhN4WW7E460atua1FNW+fyKxJSwWN
   9g695UrNNrI2wkep0AZkbZ5Lt+i/FK8zn3u4061UyVvnmBp7urWGNXV2l
   8FNE8SIJ5o8ldmcdycL49HLqL0m4LZ7ABmtmCpjZCqGiGvgopMCxedetn
   GqWARaEw+gfNGUtmYWEVSo8VEQRyq0Qh6SVuOjWon2/6HdS6uu70KoVB5
   Vhan8+wRw6z+Mpd+mxBysTmPCvBqXoGWO47C+OeHiwUjtHfpO7jt9nPr+
   rdUARHMmveIH5+Qglo7rlJwOqjd69a7BfmWAY0Cvh2z7N+xuguvhMPre4
   A==;
X-CSE-ConnectionGUID: qMLJKbGDTX6T07Tx3Kje9w==
X-CSE-MsgGUID: fcpyQLQUQd2RiW343Gt9uA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51784960"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51784960"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 00:41:42 -0700
X-CSE-ConnectionGUID: buzNZVnXT9idMFD/8m7Dxw==
X-CSE-MsgGUID: F1uxp14aR/u2ytwb38UCdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="80933272"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.228]) ([10.124.240.228])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 00:41:39 -0700
Message-ID: <f6d109cd-9a7e-416f-87d7-429e584e3b3e@linux.intel.com>
Date: Wed, 23 Oct 2024 15:41:37 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>,
 Kyung Min Park <kyung.min.park@intel.com>
Subject: Re: [PATCH 2/2] iommu/vt-d: Fix checks in pgtable_walk()
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20241022095017.479081-1-zhenzhong.duan@intel.com>
 <20241022095017.479081-3-zhenzhong.duan@intel.com>
 <813d32e8-e84c-4744-bc2c-b76adc10d00f@linux.intel.com>
 <SJ0PR11MB6744EC9F9B202E1BBE7DC4B1924D2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <SJ0PR11MB6744EC9F9B202E1BBE7DC4B1924D2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/23 13:16, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Wednesday, October 23, 2024 12:50 PM
>> Subject: Re: [PATCH 2/2] iommu/vt-d: Fix checks in pgtable_walk()
>>
>> On 2024/10/22 17:50, Zhenzhong Duan wrote:
>>> It's not accurate to dump super page as non-present page,
>>> meanwhile bit7 in first level page table entry is PAT bit,
>> Can you please explain how the 'bit7 in first level page table entry' is
>> relevant to the changes made in this patch?
> When iterate to level 1, it is leaf page table entry, bit 7 is PAT bit instead of PS bit.
> dma_pte_superpage(pte) may return true, then " PTE not present at level 1" may
> be printed out.

I see. Thank you!

If you have a new version, can you please make it a bit clearer? My
understanding is that dma_pte_superpage(pte) should not check against
the leaf page table entries, right?

Thanks,
baolu
