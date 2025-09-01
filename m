Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61B91C84A2
	for <iommu@lists.linux.dev>; Mon,  1 Sep 2025 05:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756706309; cv=none; b=cIxPV/83+KzPHjGF/sQOe7OYj9vcCIpiG3YGM4MaMvawxHSoWug97ghL8ylfNuDGYhFX7pPKcmcXMqcd6oxDgmSqBCpmYTHWBEs0WJS9Htt22qQyxhnVcfSoQTTwA71UBbFwhiytq+YV6wNNL9/mE+2pUc9Nb96V4gZC/6GjR1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756706309; c=relaxed/simple;
	bh=ZZCloPK1tsMqhTQoF7MYB39jpIRVLodyy94vXZE7maM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GpUZLdgJzkdjBRvHM/xKoYku/fOSTk0SamkQ10RrDoNL2RCZKAIuF5B+B1TzRScylb8A2Rask3mPEqIaeRoMUDizmv5FUC4u4EAVqWwH5Nau7K//RlQDQgaKSKymNaQWh0tz7QDXEwnHz0GZdCV0xb6fsPtyvDsdNwMukDv92JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fu2SiHq8; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fu2SiHq8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756706307; x=1788242307;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZZCloPK1tsMqhTQoF7MYB39jpIRVLodyy94vXZE7maM=;
  b=fu2SiHq8/TO4k03G1fJrAVKBGjLrH+aKc/J03aDeaL2SCmWQsgHsmBRv
   TnxvSiypcq26S60whZwZj2OMIJ1UGOnyaZQpZh2oNYkzU4fTAHUE9lLa1
   MC55SPYWei75jQtm+DuxijZsdkMZCA34TUgZnK8oghip9zJG0VEODMWeU
   7EC1239FBDTSJZAgR9e+vHeG2T53wYnQH3xSUslziDvLia3EvOl3JCVaf
   us00oX8gyPAtkMJCjKG+A6lTvTpOu+q0njCfxdiZAw9rxiEzuMCC9qEU5
   wPVEEIHXPK2WI8WBx0DN+UkbNssDrfN4PZBzCiJlzjGsm3SfRax/82Fit
   w==;
X-CSE-ConnectionGUID: nWx2ulO7RZeDLP32kavPtQ==
X-CSE-MsgGUID: WPVYlHRxTAaA3hNo71H7HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="76347593"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="76347593"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2025 22:58:27 -0700
X-CSE-ConnectionGUID: Lnd7pXliRImuQ/pInjmbLw==
X-CSE-MsgGUID: ErwQ2eOWRISfvjt6FkkNwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="176149562"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2025 22:58:23 -0700
Message-ID: <ad661a4a-0078-49f6-b999-19c2ed76389b@linux.intel.com>
Date: Mon, 1 Sep 2025 13:55:46 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/intel: Fix __domain_mapping()'s usage of
 switch_to_super_page()
To: Eugene Koira <eugkoira@amazon.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: dwmw2@infradead.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, longpeng2@huawei.com, graf@amazon.de,
 nsaenz@amazon.com, nh-open-source@amazon.com, stable@vger.kernel.org
References: <20250826143816.38686-1-eugkoira@amazon.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250826143816.38686-1-eugkoira@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/25 22:38, Eugene Koira wrote:
> switch_to_super_page() assumes the memory range it's working on is aligned
> to the target large page level. Unfortunately, __domain_mapping() doesn't
> take this into account when using it, and will pass unaligned ranges
> ultimately freeing a PTE range larger than expected.
> 
> Take for example a mapping with the following iov_pfn range [0x3fe400,
> 0x4c0600], which should be backed by the following mappings:
> 
>     iov_pfn [0x3fe400, 0x3fffff] covered by 2MiB pages
>     iov_pfn [0x400000, 0x4bffff] covered by 1GiB pages
>     iov_pfn [0x4c0000, 0x4c05ff] covered by 2MiB pages
> 
> Under this circumstance, __domain_mapping() will pass [0x400000, 0x4c05ff]
> to switch_to_super_page() at a 1 GiB granularity, which will in turn
> free PTEs all the way to iov_pfn 0x4fffff.
> 
> Mitigate this by rounding down the iov_pfn range passed to
> switch_to_super_page() in __domain_mapping()
> to the target large page level.
> 
> Additionally add range alignment checks to switch_to_super_page.
> 
> Fixes: 9906b9352a35 ("iommu/vt-d: Avoid duplicate removing in __domain_mapping()")
> Signed-off-by: Eugene Koira<eugkoira@amazon.com>
> Cc:stable@vger.kernel.org
> ---
>   drivers/iommu/intel/iommu.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)

Queued for v6.17-rc. Thank you!

Thanks,
baolu
