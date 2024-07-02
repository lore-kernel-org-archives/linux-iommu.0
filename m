Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F6864D
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 01:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719885022; cv=none; b=Ce964yHtRY9PufZZu/FgaAeGnum1e2CIrHPyF7SJl8WHpdSuYFqu3nzQxr5urQwqto2qPLxHv/w5jsVJ4YdqscAsRfxQ5AHpDJRHtca/CDa/e3fPxjLgUAEXd1tfoyBbf/GJoMzGoyyvjhSYJ+2rOusnelLlOYR+APbyNDpjiyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719885022; c=relaxed/simple;
	bh=NJPq6whGdWS9pS61VaPFsZuhrJHHsApIw8HmAptvHYw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tzG3pkAE9+DUt8vi5r/6Vwpmr7Lyv3PnZ5rWaWMx3FM885ytbKDJcMurs4VcsAlO94akGuhQ9XLAhETU7gP6+ddqE7jHHTP9twydGdYPm7eu+MHobDQMGE54TcisvC330OlW9GyILu23okEd77X6yQt9c0konEximWAQObVtnIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RCY4c1m0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RCY4c1m0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719885021; x=1751421021;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NJPq6whGdWS9pS61VaPFsZuhrJHHsApIw8HmAptvHYw=;
  b=RCY4c1m0l7l4t79nNTGbTbQAvhjI0qqY1RlFFhYqwh7xW6J5tJ5hAio1
   RcACOLHIe46Wpj4GJmdH4ZDD2aszTu+Lsnik4XjnbC2M/Uxjqr4tYpctG
   kRGWO6q7fPlpbbGlEO0JPpVn43W4P35GxkmbHG0MD9Vv79+wVjWPEj9mv
   lSV56OfEmhjv+7F8xTqxhHIpx1RnCb10m2xvEciiLYbkVMVu+vuiYkOF0
   VynoMlxiUmzfpZ6B4TBQFZAmqvqLylbGmQ/qKvlnAbrNHkEPjBQGF8Esv
   So4rGGGb2T8cFk+2ISyFfLh2psRIjKoelBxnAWHXORcEM7lh9nGRe23gY
   A==;
X-CSE-ConnectionGUID: 3lnuNTLET365VOlfXP+/xg==
X-CSE-MsgGUID: NBNTUmABSdWSs0n0F9us1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="34487459"
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="34487459"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 18:50:20 -0700
X-CSE-ConnectionGUID: X4VH42WOQ9aPF4gjszu5cA==
X-CSE-MsgGUID: 5WQ3g2/ITtiz/tGEhwblfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="45689780"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa008.fm.intel.com with ESMTP; 01 Jul 2024 18:50:19 -0700
Message-ID: <14a7db3a-663a-4e3f-b29c-a733e98efc32@linux.intel.com>
Date: Tue, 2 Jul 2024 09:47:36 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] iommu/vt-d: Add helper to flush caches for context
 change
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20240701112317.94022-1-baolu.lu@linux.intel.com>
 <20240701112317.94022-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276502F9B5AB45EE9BF28628CDC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276502F9B5AB45EE9BF28628CDC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/24 9:11 AM, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Monday, July 1, 2024 7:23 PM
>> +
>> +	/*
>> +	 * For scalable mode:
>> +	 * - Domain-selective PASID-cache invalidation to affected domains
>> +	 * - Domain-selective IOTLB invalidation to affected domains
>> +	 * - Global Device-TLB invalidation to affected functions
>> +	 */
>> +	if (flush_domains) {
>> +		/*
>> +		 * If the IOMMU is running in scalable mode and there might
>> +		 * be potential PASID translations, the caller should hold
>> +		 * the lock to ensure that context changes and cache flushes
>> +		 * are atomic.
>> +		 */
>> +		assert_spin_locked(&iommu->lock);
>> +		for (i = 0; i < info->pasid_table->max_pasid; i++) {
>> +			pte = intel_pasid_get_entry(info->dev, i);
>> +			if (!pte || !pasid_pte_is_present(pte))
>> +				continue;
>> +
>> +			did = pasid_get_domain_id(pte);
>> +			qi_flush_pasid_cache(iommu, did,
>> QI_PC_ALL_PASIDS, 0);
>> +			iommu->flush.flush_iotlb(iommu, did, 0, 0,
>> DMA_TLB_DSI_FLUSH);
>> +		}
>> +	}
>> +
>> +	__context_flush_dev_iotlb(info);
>> +}
> this only invalidates devtlb w/o PASID. We miss a pasid devtlb invalidation
> with global bit set.

I am not sure about this. The spec says "Global Device-TLB invalidation
to affected functions", I am not sure whether this implies any PASID-
based-Device-TLB invalidation.

If so, perhaps we need a separated fix to address this.

Best regards,
baolu
