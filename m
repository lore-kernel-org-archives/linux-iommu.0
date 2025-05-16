Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CA621A95D
	for <iommu@lists.linux.dev>; Fri, 16 May 2025 06:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747376144; cv=none; b=QmTaMClriA0O/02bNmc/jMr613LquADgtpTs3eObyQviNRpIPCa1pr6CyF0XABVdWasTF5OrndakQD2zyRShpFxVADDv3BybVlhDoKaK6r+Vpb+iBBdcck6QVVZCraB1bIj6FoWw9KUiZrlVWCfEZ7tmLJOVBZl3Oqkl8SR6xiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747376144; c=relaxed/simple;
	bh=wo76qnl2ug16fNSNnM4HCCjl4p6Lo/EkBUyFwuA6QrY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OsFt2Yh4F0FqeQmqjx2c2dizWnjMLntYARzvaGe1bebxGtbSmMDpL09ZuCDmroOk6268SnqlMuw9M8+phtTYgft3nTHKPtqPy2qcmi4X7HCqtjJCjR+WXeTjmxGQupyTnHq+ajuCCykDs0MlZb8DOoCQywHKk7x3HGQxMBY05pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aN5+Xv4L; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aN5+Xv4L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747376143; x=1778912143;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wo76qnl2ug16fNSNnM4HCCjl4p6Lo/EkBUyFwuA6QrY=;
  b=aN5+Xv4LVJKPDgBAxJK7fA+z7X5tFI7q8jLa4Hyg9Obppfi1wrfx0pMd
   OmeVU4lNUSFkfFp639FVdeFwPHhVB28t1u8upidzrFE7X51J8wpxGTxx2
   FETf3p2w3lIQDM4/1np0UDIdjn4/C9BrVRbo0JKejnvOPI00EVZUyzUMs
   8Ns2BdU2fSj9sjnO9j+Oidb62c331aDm95Rjh/JTtSAAGedUifj+rSm6z
   fKwOVLq/S6qMQrvHKb+1tOD3Ai+ZbeXT3Swp7zi4G29fk70cDArbYMKaz
   wQgHkUoAKfs2pMfr4tduxr2u+5uwIay/V4rkffi9QO41pP//uWAOOG6U3
   A==;
X-CSE-ConnectionGUID: yNA2sNgjR8qTYCLfCv9SOQ==
X-CSE-MsgGUID: v+NCI/PGQt+DZZcfTWd6ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="48453618"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="48453618"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 23:15:42 -0700
X-CSE-ConnectionGUID: XJmBCUOYT92kJhlM2oKYWw==
X-CSE-MsgGUID: ahJOLKCJSmu2Oa6Hbe6Y7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="138985586"
Received: from liuweiji-mobl.ccr.corp.intel.com (HELO [10.124.241.206]) ([10.124.241.206])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 23:15:39 -0700
Message-ID: <7055e215-4292-4556-a481-7cd5ffe117fe@linux.intel.com>
Date: Fri, 16 May 2025 14:15:37 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Restore context entry setup order for
 aliased devices
To: Yi Liu <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Aditya Garg <gargaditya08@live.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, kobarity <kobarity@gmail.com>
References: <20250514060523.2862195-1-baolu.lu@linux.intel.com>
 <1826e96b-15bd-472d-b535-c72b58e06561@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <1826e96b-15bd-472d-b535-c72b58e06561@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/16/2025 2:11 PM, Yi Liu wrote:
> 
> On 2025/5/14 14:05, Lu Baolu wrote:
>> Commit 2031c469f816 ("iommu/vt-d: Add support for static identity 
>> domain")
>> changed the context entry setup during domain attachment from a
>> set-and-check policy to a clear-and-reset approach. This inadvertently
>> introduced a regression affecting PCI aliased devices behind PCIe-to-PCI
>> bridges.
> 
> I got what the patch does. But just bit confused on the above description.
> I didn't see the commit 2031c469f816 mentioned any policy thing on the
> context entry setup.  To me, the problem looks to be that the info->domain
> is no more accurate to be used for checking if any domain is attached after
> the above commit. Maybe I missed something. feel free correct me.

The problem was introduced by below change:

--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3691,11 +3691,9 @@ int prepare_domain_attach_device(struct 
iommu_domain *domain,
  static int intel_iommu_attach_device(struct iommu_domain *domain,
                                      struct device *dev)
  {
-       struct device_domain_info *info = dev_iommu_priv_get(dev);
         int ret;

-       if (info->domain)
-               device_block_translation(dev);
+       device_block_translation(dev);

And after the introduction of static identity domain, "info->domain ==
NULL" doesn't mean no domain attaching to device anymore. So this patch
uses a specific flag bit to indicate this.

Thanks,
baolu
