Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB933126DA
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 06:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777011300; cv=none; b=eqUqBSqO3Kxx7+3nUgoEOxOBPLi4MvbfmihrKZH0ROirplKfdn3piRzOXZhi7yJHfXmWTXzx/L2laL4I+Uhs+b3Gt14cTKRiULvJj9lIgt2JeFQ6yS5QjJTcXidHlZdy4wg34Lf39tHgkfRg2CH+Qvi+uR0E73xXM1UqPZPaxvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777011300; c=relaxed/simple;
	bh=V4c15qZZXFIcG+V4dBLVE0EzHfsGwN5rXez3CjgMKac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AfO3IF+AbYH9gQwqBQxMMrCEMb3LF2wWcrvIQ68WgDbOJoQU+CAX8miLzWq+DB3RQLy6b7mDviDc7xPEuqDpl+nJF1jFVnhWkJ2PKAYs3fSNZZSan6M4UKn195FyuzNv0MViNzJHHTMjD36WW5zen1zMqbKoP+XeH3JHpkDNXQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C32VcYQd; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C32VcYQd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777011297; x=1808547297;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V4c15qZZXFIcG+V4dBLVE0EzHfsGwN5rXez3CjgMKac=;
  b=C32VcYQdhWxjsKLwrNc0FvxMqrleLPhA+j5N/I4uGJSmfLOzO33dKqCH
   wzX1J1ocRSNnyVuirxjle1Rt1QBFpKLIFMRVRrRioQ0pDFsv10IYen3ff
   oQH5HHmEJu+2o3C70ikN9Hbnk660hlN86tHav44myKePah12jazuZHuRe
   oWQE4ehI6OdaRG8CFS/WvztZgQshg1rWExDz6MAhntrCXqpaKF+4xf9+K
   UQEuttRcwFBeganEpFxPKzsVl5pZ6QuzghbGxSB54emZCQMd0T8gyJAeS
   qT2V428jKNHC6Zd7Pivgt2TDp442RratQE9g8BMjQk8FSKtH5zRgmL169
   g==;
X-CSE-ConnectionGUID: 7ylCUEu0T8KvbRdWaenD2w==
X-CSE-MsgGUID: wg59583FSauiCNsYFByGNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="89072022"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="89072022"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 23:14:56 -0700
X-CSE-ConnectionGUID: miXg/0/ZQ+2/3cbxRMT09Q==
X-CSE-MsgGUID: 5HwzKZFwR3ieIr+ZS1iX3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="230202834"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 23:14:54 -0700
Message-ID: <ef2b7197-3d07-44d8-9093-da88eb8f693a@linux.intel.com>
Date: Fri, 24 Apr 2026 14:12:48 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc v7 4/6] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
To: Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org,
 kevin.tian@intel.com, jgg@nvidia.com
Cc: will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, xueshuai@linux.alibaba.com
References: <cover.1776551790.git.nicolinc@nvidia.com>
 <ab6d836f38c31b76275b1372874641a925a136dc.1776551790.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ab6d836f38c31b76275b1372874641a925a136dc.1776551790.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/19/26 07:41, Nicolin Chen wrote:
> Shuai found that cxl_reset_bus_function() calls pci_reset_bus_function()
> internally while both are calling pci_dev_reset_iommu_prepare/done().
> 
> As pci_dev_reset_iommu_prepare() doesn't support re-entry, the inner call
> will trigger a WARN_ON and return -EBUSY, resulting in failing the entire
> device reset.
> 
> On the other hand, removing the outer calls in the PCI callers is unsafe.
> As pointed out by Kevin, device-specific quirks like reset_hinic_vf_dev()
> execute custom firmware waits after their inner pcie_flr() completes. If
> the IOMMU protection relies solely on the inner reset, the IOMMU will be
> unblocked prematurely while the device is still resetting.
> 
> Instead, fix this by making pci_dev_reset_iommu_prepare/done() reentrant.
> 
> Introduce gdev->reset_depth to handle the re-entries on the same device.
> 
> Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
> Cc:stable@vger.kernel.org
> Reported-by: Shuai Xue<xueshuai@linux.alibaba.com>
> Closes:https://lore.kernel.org/all/absKsk7qQOwzhpzv@Asurada-Nvidia/
> Suggested-by: Kevin Tian<kevin.tian@intel.com>
> Reviewed-by: Shuai Xue<xueshuai@linux.alibaba.com>
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
