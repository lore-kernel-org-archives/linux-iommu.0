Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3305213D503
	for <iommu@lists.linux.dev>; Mon,  2 Feb 2026 02:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769999527; cv=none; b=GCUIUc/cX/sraSiw9QtzzwLuZkgV26THTsJJc4NjKUTy5yTGxawbGIVsacg+gCyg2oDT4C0XPRYqLKtdfKsgLv/wc37AtqI1HNf1dPgvtVidvANeuO1sSp0VLNf+3cqttS2GRzWLMFaM7Rhbpc2PvUBj1bHLLnmeGmz/3xQcZJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769999527; c=relaxed/simple;
	bh=t9qL2mLx1EoB+c04XfJayhSehakaBPA6qjQmIPMn3lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CF9kJ91ws3kv77IHfbQsfYW+uYkotp/n1IeAZeGJUS8XuOE7rQFSLyEwNRyfrGNhM0nmOF9az8i0x7lvZ1WeKPYXTu0dxfBSO6toMAjZgB1il+iIgXumLg2QW88foaPz6EIxObTKL2ESySWm3l0NUtrgwXOWpcazOxwdAJdea6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QX8eVBiG; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QX8eVBiG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769999525; x=1801535525;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t9qL2mLx1EoB+c04XfJayhSehakaBPA6qjQmIPMn3lk=;
  b=QX8eVBiGFaE3FdJ3RXmZtgVlZznqN3vmo6PfV/cRWaAUvnOQY4Om/Kxf
   e+lhtJ+HzpcvcQ7krYVlhWjFsaMyHYZQpHu54HeML/v8CEdWviTNklKXg
   7rSaVxk6UjlEgFbM6cPFhNHLpFjr6dTYEAcuhFf7ssYys6pxvpR9VJei3
   kxxG0n8hlzvj2YW/lwYxPcq6jCVnfh2m/HLcv6pMJZ/SogEO5Lpzf3KgN
   sVL9AjHQGpVreiRtPy4JhHRvVsUYxTBvlsEkV+4ZXxML0tgWdv7aQfgyL
   BgyCHz3dYQIGZcaq50U70zeVW55yEmtcXTYRj9jWn4zKvJOD5NNT6w9wO
   Q==;
X-CSE-ConnectionGUID: 8f3B17rpSxKgvd+/DeMtoA==
X-CSE-MsgGUID: JbR7qa7/RD2fotbMcae7/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="71053438"
X-IronPort-AV: E=Sophos;i="6.21,267,1763452800"; 
   d="scan'208";a="71053438"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2026 18:32:04 -0800
X-CSE-ConnectionGUID: oC1dKgFoQoGn9xFt2HKADA==
X-CSE-MsgGUID: iwEUQNooRvqpkjQB2R2qKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,267,1763452800"; 
   d="scan'208";a="209472328"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2026 18:32:03 -0800
Message-ID: <00d4c485-5f01-4b8a-8073-f269be1e86f7@linux.intel.com>
Date: Mon, 2 Feb 2026 10:31:36 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: fix missing lock in intel_pasid_replace_*()
 functions
To: Ziyi Guo <n7l8m4@u.northwestern.edu>,
 David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260130190655.1622261-1-n7l8m4@u.northwestern.edu>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260130190655.1622261-1-n7l8m4@u.northwestern.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/31/26 03:06, Ziyi Guo wrote:
> intel_pasid_replace_first_level(), intel_pasid_replace_second_level(),
> intel_pasid_replace_pass_through(), and intel_pasid_replace_nested()
> call their respective pasid_pte_config_*() helpers before acquiring
> iommu->lock. However, each config function has
> lockdep_assert_held(&iommu->lock).
> 
> The corresponding intel_pasid_setup_*() functions correctly acquire
> iommu->lock before calling the config helpers.
> 
> Let spin_lock(&iommu->lock) before the pasid_pte_config_*() calls to
> fix the lockdep assertions and ensure consistent access to IOMMU state.
> 
> Signed-off-by: Ziyi Guo<n7l8m4@u.northwestern.edu>
> ---
>   drivers/iommu/intel/pasid.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)

Thanks for the patch. It looks like this was addressed by commit
c3b1edea3791 ("iommu/vt-d: Fix race condition during PASID entry
replacement"), currently in iommu/next. Let me know if you think there
is still something missing.

Thanks,
baolu
