Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343DF4C7B
	for <iommu@lists.linux.dev>; Fri, 31 May 2024 01:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717118356; cv=none; b=ZibBq7xyEzuYqO71Csf1YiMZA3+ugEy4lCjc0sIulgO0w7BOTIU6ASRxbPtQMWE+CX1S2dlBmj/We16oZJius/KA2+kN46/cnO2rfqT3GebLdvgLC1VKaF7sReRODjyY8FEL2VY7d6Tao1AT+OlmdfcCMb8yktmqsH6U1OaM+II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717118356; c=relaxed/simple;
	bh=LFRDMDUTn01WZjrLsF2FrdVRP8HD0U8X+Q6SBR2aAQ0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HhSAI+HFSBVa58sScJUzf8TiRhuaCSnmNUmRRSqmovwDcga4KZQJb6diB+hA8mJ3n0owdS8goxPtmWfqATCQjDyiKePvVFDpbBLbBaq6pVfbkYGRDvMCX/+WCI0q343qeIKfNSIb+ElTzCfeIGIE4rMsLq8n5fPeeZCgzx3oOOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OhwSnPGD; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OhwSnPGD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717118356; x=1748654356;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LFRDMDUTn01WZjrLsF2FrdVRP8HD0U8X+Q6SBR2aAQ0=;
  b=OhwSnPGDvOImctGtHWGxg1cFV+Pav3YjXmwFmMkshTlfC/NGwr34NLpj
   PjGgcNIMo1mN+8jB6TjDTeKbIfrkpWWpuInhWe9esDp1EEHHZlTdXkdld
   hmDuXGcNjcOMOiZr4NQjjrg1dUToNJl5C684uR8ctIDCVwEVsk3tEtCO4
   oQOTeXUFMAvBF6Ljw45WhhBOoovHydncxFcMkj4i6yP646kF2djYTeoHV
   eGdiEHulYk71+Vpp30Kglh77nmg0jIvlHgIl/+Q9fFDhCXyAitGQpydfV
   X8FmONohW6LbCNx+cIzHbWqYdaXS4JpqQp0/j3lRADQYh+rJd3uCam0++
   g==;
X-CSE-ConnectionGUID: H/xRwlG5Qcqm4o+yU9bcBQ==
X-CSE-MsgGUID: 0bEmesatSQW6w2rg8cnbzg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13771003"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="13771003"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 18:19:15 -0700
X-CSE-ConnectionGUID: AcSUE+0cROSDB+Rbre3XqQ==
X-CSE-MsgGUID: oQQ1JPt2RCKqgao01z8BHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="40571285"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa004.fm.intel.com with ESMTP; 30 May 2024 18:19:13 -0700
Message-ID: <b6ebac8d-02f5-4153-b687-a4d40056f697@linux.intel.com>
Date: Fri, 31 May 2024 09:17:05 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: device_def_domain_type documentation header does not match
 implementation
To: Diederik de Haas <didi.debian@cknow.org>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
References: <14311965.TaHA55BQu8@bagend>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <14311965.TaHA55BQu8@bagend>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/30/24 9:57 PM, Diederik de Haas wrote:
> While looking into ``drivers/iommu/intel/iommu.c::device_def_domain_type``
> function I noticed a discrepancy between the documentation header and the
> implementation.
> 
> ``@startup: true if this is during early boot``
> 0e31a7266508 ("iommu/vt-d: Remove startup parameter from
> device_def_domain_type()")
> removed the ``startup`` function parameter
> 
> returns ``IOMMU_DOMAIN_DMA: device requires a dynamic mapping domain``
> 28b41e2c6aeb ("iommu: Move def_domain type check for untrusted device into
> core")
> moved the possible return of ``IOMMU_DOMAIN_DMA`` to ``drivers/iommu/iommu.c``
> 
> But neither updated the documentation header.

Yeah, I think the @startup line should be removed. It is irrelevant.
Others remain good to me.

Best regards,
baolu
