Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4322D12E2
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137951; cv=none; b=OK36V+P8KIXNRPN2WoHJLuFq0ohYPD1KMIV42Jvr5qzVVxGQ0PxLxEk3qiiohkumhEigasPW/9vn8j4nF3e9pdj8mFq4m5F1WolR653F+kUjAILyt9QjJBHsCmakqGl8uhoxghYK7ZYMroVUahvv9k57EY2q1CX0FeUq9XoeinE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137951; c=relaxed/simple;
	bh=UZryUlbevuUyYlFXvst4pgITLilLVWH3OuuiwXdC5aU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hCVZ/4IrPIz52C/p7vVpMmWOTc2ddkrvKMC7Vi2RRp5xzAG2LofFJix4eAkxowELhLLnE1WuhEEbm9c+wuslA/qZ2uOAUIgnrsKDdKjEbaOWjPFDewij7VCPRT7Bs/zsdOpM47dDEUBOLrXbUf7Nt7uET/z9oIqdNXwOMfOtvyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hyCO3tnM; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hyCO3tnM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752137948; x=1783673948;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UZryUlbevuUyYlFXvst4pgITLilLVWH3OuuiwXdC5aU=;
  b=hyCO3tnMDUtCywBIhgbh/6Vd+9S5bRaop2bnUN0bQbY7VSGbTlp4Ci40
   a6B/5SkuEEnMfi66df02gS42fMH/9kyGfjVYIUYQM/yy1Ji0t4tiopHig
   ftVreFFNt451vaaKSB6kGS2w9WfclWSbCZfpwXDlAWA0z821fyleI/uSK
   +aCXdNrF2aV26sT9gFvttaz8B0Ks1nqpjLgP4m0kTJ7BQSPkOC0q4YwH0
   b8KrLvB9XPQwB67e3ZzWmZ81e2Kt2APVvlfWy9sJ6GJ2TCwmt13U8AtVa
   me3mQT428aEpaHhgaQ0W0HTZrSguTcPmpR3zclCCxr80UpLUc8XFtQFr/
   A==;
X-CSE-ConnectionGUID: N8zg9u/aRPmYDDuIEDhD7A==
X-CSE-MsgGUID: +k5Ut/XlTH2EDbCfipRPmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="76954530"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="76954530"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 01:59:08 -0700
X-CSE-ConnectionGUID: Or8XDnHWQ3WAsSCmU+MDgQ==
X-CSE-MsgGUID: eHon4wleRZW59xqiUWCZgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="186990996"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.243.252]) ([10.124.243.252])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 01:59:05 -0700
Message-ID: <015a0eba-d26d-4565-9cbb-d4c9e700501e@linux.intel.com>
Date: Thu, 10 Jul 2025 16:59:01 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: Re: [PATCH 1/2] iommu/vt-d: Fix missing PASID in dev TLB flush with
 cache_tag_flush_all
To: Ethan MILON <ethan.milon@eviden.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20250708214821.30967-1-ethan.milon@eviden.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250708214821.30967-1-ethan.milon@eviden.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/2025 5:48 AM, Ethan MILON wrote:
> The function cache_tag_flush_all() was originally implemented with
> incorrect device TLB invalidation logic that does not handle PASID, in
> commit c4d27ffaa8eb ("iommu/vt-d: Add cache tag invalidation helpers")
> 
> This causes regressions where full address space TLB invalidations occur
> with a PASID attached, such as during transparent hugepage unmapping in
> SVA configurations or when calling iommu_flush_iotlb_all(). In these
> cases, the device receives a TLB invalidation that lacks PASID.
> 
> This incorrect logic was later extracted into
> cache_tag_flush_devtlb_all(), in commit 3297d047cd7f ("iommu/vt-d:
> Refactor IOTLB and Dev-IOTLB flush for batching")
> 
> The fix replaces the call to cache_tag_flush_devtlb_all() with
> cache_tag_flush_devtlb_psi(), which properly handles PASID.
> 
> Fixes: 4f609dbff51b ("iommu/vt-d: Use cache helpers in arch_invalidate_secondary_tlbs")
> Fixes: 4e589a53685c ("iommu/vt-d: Use cache_tag_flush_all() in flush_iotlb_all")
> 

Remove above blank line.

> Signed-off-by: Ethan Milon<ethan.milon@eviden.com>

checkpatch.pl complains:

WARNING: From:/Signed-off-by: email name mismatch: 'From: Ethan MILON 
<ethan.milon@eviden.com>' != 'Signed-off-by: Ethan Milon 
<ethan.milon@eviden.com>'

> ---
>   drivers/iommu/intel/cache.c | 18 +-----------------
>   1 file changed, 1 insertion(+), 17 deletions(-)

Other looks good to me.

Thanks,
baolu
