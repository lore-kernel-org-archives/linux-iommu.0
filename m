Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1157035A38A
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 06:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777013199; cv=none; b=gVw2FrKc5rpPY+pi6C+Qnhfk9NFRxSeb1/bykDmycEu1ko4vIpKkv39vn9e3yrp8PEp8wtrhM4sP2/pxBks/f83O6DDl5qYAg9cPY0vHnavAVXp4bjTuJ4xaoHtH4x/Ddlrpya+/eEoMUQBXuvkouoJMR1WVPYpzkmKRU63FlUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777013199; c=relaxed/simple;
	bh=rGyCA0QazKR0WD1vidcl1Es98e4ZGvotcDdSD0N/ISE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hNfiKsHa4g7uPtgFgUd0WlKGSXRF7NR1huUlezMHUfLHyehfKE7vB/kL0xQFqfS6QSfirnvrPxzFJGDSSN6lBexCu3iBfHCL4nMGBaVhVg9WaD75ByEIEEROdvomSBU4n4pOviziDyDI81acRekq1cTSPEoV9ChUGD3MWTrXE+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RBAA786t; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RBAA786t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777013198; x=1808549198;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rGyCA0QazKR0WD1vidcl1Es98e4ZGvotcDdSD0N/ISE=;
  b=RBAA786tHahFMsg2C3+vFuYRNRjYie5szeZgpnijpyEig82xp34Txab2
   3d6r4srz6/3e62Aezs6rkAP8udsisaWdw1G5qzkHKCNZ/vPN7SHKUz37Y
   CsxiumFS7LvbJhBqCP3b03asXcVITTPxDtv2rGKh7v9s/7dIci1TDzHJ0
   wdJtHn6X5pRIXwKhaAWm5X2BZSwWDa6dM+k+oL/pFH6tRPjHGsL3ml59V
   KcSH0JO412/dbCHt8RDoOU12YB4hVM769hhhUqJ+uOP+PWF0wUhppiU9x
   ok1j7Hqve3Iaq4hJ8hbIpgyygVcpNXpEOtzY4GiXzNAU9dnE+RiU+sAd1
   w==;
X-CSE-ConnectionGUID: ba9DPZVXQn6xiXPVQxRhOw==
X-CSE-MsgGUID: AkqmkvkOQVGTnHHzymK/Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="77155137"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="77155137"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 23:46:37 -0700
X-CSE-ConnectionGUID: O59Un4zqQVS4wHL5wgBCFg==
X-CSE-MsgGUID: 7vFDs5gaSmiUB2hkTIu12g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="237220355"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 23:46:36 -0700
Message-ID: <031d7f26-d253-42fc-8081-149da87e6a1f@linux.intel.com>
Date: Fri, 24 Apr 2026 14:44:29 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc v7 6/6] iommu: Fix UAF in pci_dev_reset_iommu_done()
 due to concurrent detach
To: Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org,
 kevin.tian@intel.com, jgg@nvidia.com
Cc: will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, xueshuai@linux.alibaba.com
References: <cover.1776551790.git.nicolinc@nvidia.com>
 <96a8ab981d365bdedc5dc705df10414ccf578c9d.1776551790.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <96a8ab981d365bdedc5dc705df10414ccf578c9d.1776551790.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/19/26 07:41, Nicolin Chen wrote:
> In __iommu_group_set_domain_internal(), concurrent domain attachments are
> rejected when any device in the group is recovering. This is necessary to
> fence concurrent attachments to a multi-device group where devices might
> share the same RID due to PCI DMA alias quirks.
> 
> However, IOMMU_SET_DOMAIN_MUST_SUCCEED callers (detach/teardown paths such
> as __iommu_group_set_core_domain and __iommu_release_dma_ownership) should
> not be rejected, as the domain would be free-ed anyway in this nofail path
> while group->domain is still pointing to it. So pci_dev_reset_iommu_done()
> could trigger a UAF when re-attaching group->domain.
> 
> Honor the IOMMU_SET_DOMAIN_MUST_SUCCEED flag, allowing the callers through
> the group->recovery_cnt fence, so as to update the group->domain pointer.
> Instead add gdev->blocked checks in the device iteration loop to avoid any
> concurrent per-device detachment.
> 
> Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
> Cc:stable@vger.kernel.org
> Reported-by: Kevin Tian<kevin.tian@intel.com>
> Closes:https://lore.kernel.org/all/ 
> BN9PR11MB5276D60096EBF15C5753C4BB8C202@BN9PR11MB5276.namprd11.prod.outlook.com/
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)

Agreed with Kevin's comments. With that included in the commit message:

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
