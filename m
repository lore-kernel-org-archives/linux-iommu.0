Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014A5539C
	for <iommu@lists.linux.dev>; Sat,  4 May 2024 02:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714788338; cv=none; b=c6F9dDRmbmYI6a9lLVPcaLggej/W83tmPzir8YLqP+CbRGM5alK2Ywhn//NbM89TyVtZ3JqnrDVLu2L9LugJND08Dpv432ebWCr/iHOs8DWNfiqL2JfgcE6QShgMeoNWVmWnO2EN2rNVhva+7+/getBouEHcgUoR4bCt/zVheBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714788338; c=relaxed/simple;
	bh=7klp7IIY3XFtHFhsC2ojag4m07iXNC50Ffi+qHgcjKk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OLDKIhS89jL3tEFW2hcXyQKc335GhrPkwWBG4jyN1KgGEwMsN8cE3CQbauUebPYrQRkNQX3L/H9iU/MJQ1GwJoS0p72rZnVbFewgzJR+7hXV2XH4bDupdVcRAf9mQOS+WBejVIyJcnu+xZi4DazbG/53EJlMj1pvWe8o/OG7OlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OLhmNU0s; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OLhmNU0s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714788337; x=1746324337;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7klp7IIY3XFtHFhsC2ojag4m07iXNC50Ffi+qHgcjKk=;
  b=OLhmNU0saBYRE3nj+BTQn/ExYbWijCS8n12xntPb83ueI227HLYHHarr
   PMwVcnyzKKRKHG1CGJ4h8AJvKjvjzsA1bD8nV5Iiq1sbXvCiaGRt03kj/
   9AA+Oje7ED/puU0tZQpxE+nOvArMDGWWXkq+3psmVKidusgu60HXFTSB6
   7eDfWJOWvb6X4/h38FJZei/hVb4fXKePz0WB5xVvP0ysA4zYB8J1oWVWr
   RTblY6KRp51BVH2TGNwQT1+zBxM9CQwSbiG/Yj0KQaf8H/7yIkSsFgwmN
   Ywygf80NFMa33x6xRmDU8baEnOAz2kdavBlEtrQvVtSSztPNmiNaYjKXP
   Q==;
X-CSE-ConnectionGUID: EFNr6cUpTNyyzSK+AQZVXg==
X-CSE-MsgGUID: IDWFKllSTqaV2zK3NZCqDw==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="14395670"
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="14395670"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 19:05:36 -0700
X-CSE-ConnectionGUID: LoYy6EzuQwejfXItCMF5OQ==
X-CSE-MsgGUID: pIjcEpz0SHWP9ccYOy3Ogg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="58817915"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa001.fm.intel.com with ESMTP; 03 May 2024 19:05:32 -0700
Message-ID: <0db1f6d3-5eb7-4cda-877e-80d477333db9@linux.intel.com>
Date: Sat, 4 May 2024 10:03:59 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Nick Kossifidis <mick@ics.forth.gr>,
 Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org, iommu@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux@rivosinc.com
Subject: Re: [PATCH v4 7/7] iommu/riscv: Paging domain support
To: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>
References: <cover.1714752293.git.tjeznach@rivosinc.com>
 <1cda67ed73f0a1d5cb906b3692a90ab35416f2ba.1714752293.git.tjeznach@rivosinc.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <1cda67ed73f0a1d5cb906b3692a90ab35416f2ba.1714752293.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/4/24 12:12 AM, Tomasz Jeznach wrote:
> Introduce first-stage address translation support.
> 
> Page table configured by the IOMMU driver will use the highest mode
> implemented by the hardware, unless not known at the domain allocation
> time falling back to the CPU’s MMU page mode.
> 
> This change introduces IOTINVAL.VMA command, required to invalidate
> any cached IOATC entries after mapping is updated and/or removed from
> the paging domain.  Invalidations for the non-leaf page entries use
> IOTINVAL for all addresses assigned to the protection domain for
> hardware not supporting more granular non-leaf page table cache
> invalidations.
> 
> Signed-off-by: Tomasz Jeznach<tjeznach@rivosinc.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
