Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793329649;
	b=VUMB6AZXi4r0mRmwTfeWlTtYJ7gXUmxrcBwwi1n9WOT3QcL4L0HVusAuPzGaD+hpECqn
	 VDZHs3CCdkEWrF3xiHVgh+VMrEfUHAtKd1fWerizpHyRDdr0rrHGLV3vBb3SqUrJpTs15
	 txYxSVbuvH0FwOHBDnR54oo8gPaoxm/i4Kj6mTFaMLaKQDT9UFonRLcJykrMOrOZHfEop
	 YumHNo6KmdOIn24I3He7t7N2IwqSqtqeRBeWTJ1UV5luXH4TjuVVLMYD9jJ6D8KLxSLX1
	 MzO6zlGfRll3WqBNIVSMld8ZrYcbGwGJVNhJ2AzhWqCsm0mkAoqvX5zEHcFdtcOV2rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793329649;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=aHgpdCEoD5lWUeN6+WJA5Jj9bBqBJTPp6GiL3jJIPFM=;
	b=UZ29OapsTOhSJnVWfmie52Z61IVCkaD6CIKg0QJuQQHqWLT3g5cp/TJwQH0jPegE6Mfc
	 JkaeEd/FbnlfcYezniBt0GrMS3QZbOzXTC7Sk7JkJxcwQXz1shJUV5vNxNCg3B66mat/U
	 LO58/wJjMLADzv2QKKYho9pohrnVKQGMCE++piAadCFmFtj/4jdfwBGr/6Gj4jLjz+PBk
	 ta+l9e6totYR4c6+vbOooWjpYCJedzkZP9jP/0S+S4t3XSlqpehFm2nSVznMoUT5ELnyf
	 23EjnttkQI8HrABRrxg2lqqD9FlQT3HWaTze89ypq/jtKJ1j1dAPrsAaeI/D6Y64o0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ihYm97t3;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B13606A31A
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 03:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65B13606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ihYm97t3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793329648; x=1824865648;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O/zzEIHYeFxsYEQca3VGErkJGqkPr5bCwH/rsaqactw=;
  b=ihYm97t3a28CsECZdxHKRbZ78yldgfhKlvtJuTy98/HhzNe1+lL/GHNg
   z2ERSVxR9ss8xYEsfCUvbMFO5ZbhU+jdHFQ/c6Sj6asKpT5F10F4F3S4c
   vN1a1xqbhJBJj6fYF5IDFOQMsSN3UQpRPnfAO41sHMOBl4JoAiPDBja+K
   9gn9esvxkk6U+Rb2LV0gJjDXJU9sWr3FFr/i0x5mw7EvKsvYjOSxHklUZ
   KSKDLrlz+HT/GQPhMNKeL4vrkL0KH6h4YSKMubN9zJXmA4KughoFO5JLz
   HvtKnx6+GVJH6WGinIAI3c77dN/wzO7uxeMQMh8VSOnEk1ZCWFt0MuRGQ
   Q==;
X-CSE-ConnectionGUID: yZACw+4aQPO646amr25srg==
X-CSE-MsgGUID: x3FGME8BQrSP0szeJwMexA==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2110459"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="2110459"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 20:07:28 -0700
X-CSE-ConnectionGUID: dRudyGz6TzmyUXOiJlCqUw==
X-CSE-MsgGUID: bu7g0lICRlKoS+ecWB/B8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5403253"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 20:07:24 -0700
Message-ID: <14cf71cd-35cd-45b1-a0fe-94d4a76e9e06@linux.intel.com>
Date: Fri, 30 Oct 2026 11:07:20 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>,
 Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>,
 Ankit Soni <Ankit.Soni@amd.com>, Nicolin Chen <nicolinc@nvidia.com>,
 John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 03/18] iommupt: Implement preserve/unpreserve/restore
 callbacks
To: Samiullah Khawaja <skhawaja@google.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 David Woodhouse <dwmw2@infradead.org>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-4-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261025021930.674647-4-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
> Add iommupt ops for presevation, unpresevation and restoration of iommu

... preservation, unpreservation ...

> page tables for liveupdate. Use the existing page walker to preserve the
> ioptdesc of the top_table and the lower tables.
> 
> Preserve top_level, VASZ and FEAT Sign Extended to restore the domain in
> the next kernel. On restore, the domain has only the preserved features
> enabled and all the other features are zeroed. This is ok since the
> restored domain is made immutable and can only be freed. A kunit test is
> added to verify that the IOMMU domain free can be done with trimmed
> features.
> 
> Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
> ---
>   drivers/iommu/generic_pt/iommu_pt.h       | 155 ++++++++++++++++++++++
>   drivers/iommu/generic_pt/kunit_iommu_pt.h |  30 +++++
>   include/linux/generic_pt/iommu.h          |  30 +++++
>   3 files changed, 215 insertions(+)

This patch looks good to me,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
