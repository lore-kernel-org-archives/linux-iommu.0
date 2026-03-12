Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C5D374731
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 08:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773302428; cv=none; b=dDq2rcy3jn0tDok73d+bdHLAeOl457I0m8zsWTunDdVJcjZigkmdS9e4UaHfdta4852MttD8QSftoXQ4f4gTsx9B761SfIPogMedPaHAdgqS8vvs0O3T7qy54gfcTR1pH1g9T0cCrZjIG+gBvWATEPEEz5rE+/EZuC3P1yTA9So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773302428; c=relaxed/simple;
	bh=twCY2OYLdJray5LyvgCijxZc35ERGmxIFZ/LD39cLJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E1WniCem4vE1ezgfxWhB2cvt0g1SuRT5Nn87Nf4tdMYXVP0DEQ6X+dEAWZCel+C0ntJcW/biszNqFtnbqd9Lg/BqR7Mc461LptGbZJhsTrKgWeLM5sT4ffPomBXUMjQALFXbsDsdeBBRToK/hL+6OZxsCVgkHosVAaXcK64U9no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UuAzVjQH; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UuAzVjQH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773302427; x=1804838427;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=twCY2OYLdJray5LyvgCijxZc35ERGmxIFZ/LD39cLJo=;
  b=UuAzVjQHFENRXad/rCweamX9dLk7nJVVe8vX1UKPrIZmyl5217TgznFb
   b6kSKbhkH4jYiWpUljBtp8NWUeQUf5kNKaccsAHZz5FAFNz2dvBJ9yr6K
   fxe58T9qcEpEBv+47BZa4WsfOh1XxljKI0Adqe7R5LQvDzCvRq/fv681y
   zkKbtI3Fq//WU9WG5LMHxRcUm6JXm0psW1tui87hn/GsqTzQZ3riADm8+
   qD8RGrAvDDlEF2b31U+aFlGTt3twIpCgGgXH/Gmch018VbnigeOXYatvT
   OPSu8o5wfhgtgAcyGli0WIGgE4eUD8xG16iu2Jbp4MWnCRJrQ6OqV/pNZ
   A==;
X-CSE-ConnectionGUID: EPD+Vx4LRcS1RcZtc9lKOA==
X-CSE-MsgGUID: 34cV+cBUQ1KP28ZtuX3aZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74426815"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="74426815"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 01:00:27 -0700
X-CSE-ConnectionGUID: Bi5j44bTR8aIFyTBIz42Nw==
X-CSE-MsgGUID: 3B38RmleTaqrPDX6i44JlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="220929433"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 01:00:24 -0700
Message-ID: <43d53037-c8cb-43ce-b99d-93ad59fac72f@linux.intel.com>
Date: Thu, 12 Mar 2026 15:59:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] iommu/vt-d: Require CMPXCHG16B for PASID support
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Dmytro Maluka <dmaluka@chromium.org>, Samiullah Khawaja
 <skhawaja@google.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
 <20260309060648.276762-4-baolu.lu@linux.intel.com>
 <20260309134208.GF3717316@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260309134208.GF3717316@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/9/26 21:42, Jason Gunthorpe wrote:
> On Mon, Mar 09, 2026 at 02:06:43PM +0800, Lu Baolu wrote:
>> The Intel IOMMU driver is moving toward using the generic entry_sync
>> library for PASID table entry updates. This library requires 128-bit
>> atomic write operations (cmpxchg128) to update 512-bit PASID entries in
>> atomic quanta, ensuring the hardware never observes a torn entry.
>>
>> On x86_64, 128-bit atomicity is provided by the CMPXCHG16B instruction.
>> Update the driver to:
>>
>> 1. Limit INTEL_IOMMU to X86_64, as 128-bit atomic operations are not
>>     available on 32-bit x86.
>> 2. Gate pasid_supported() on the presence of X86_FEATURE_CX16.
>> 3. Provide a boot-time warning if a PASID-capable IOMMU is detected on
>>     a CPU lacking the required instruction.
> This is fine, but it also occured to me that we could change the
> writer somewhat to just detect what the update granual is and fall
> back to 64 bit in this case. So everything still works, it just does
> non-present alot more often.

That's a good point. Though I don't expect many real-world use cases for
PASID on platforms lacking CX16, making the entry_sync library and the
driver adaptive would make the infrastructure more robust. I will look
into supporting a 64-bit fallback.

Thanks,
baolu
