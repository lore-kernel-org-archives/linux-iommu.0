Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9533C39B4A2
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 08:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777278861; cv=none; b=H6BvXDAtOrxAEatsrVoFz7njIn8at4bH4YzRjXc53TqB+43QGt9vsstINFi6cLJw6HAnWTJ9q3XeDGVcclPkntRIgWsM9AnuGubRXUO8e6nrjda/QK7xekaUPJCyyWhLJVFcWQVM6dVVgBpQstiailXERn/FrmM5QjQFzZ/wNos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777278861; c=relaxed/simple;
	bh=C79Xu1oG+puC/h23bIv0vqDaabXRjcrUyX4HCcpluM8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WKEIDDgUEiSkEe70YCXDO5p3pO/DfgmyVsChHoybhbeJaAHeD8Dx77RFPxubjfwGS8l6tbNfjKd6DtlaWcZqJcgLGkBdsj7CEcHo4DKaA8TerInj6F2dB2mdJIAJ3MmyMYafHmYMp83UTuXBOWfktDlPYtjPAN3enSFp7vvrL5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MryJSL50; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MryJSL50"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777278861; x=1808814861;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C79Xu1oG+puC/h23bIv0vqDaabXRjcrUyX4HCcpluM8=;
  b=MryJSL50XH6RHtw6tJLeM0q2gZGMNVMIZRlYx9FPTxO66FY5Gr3HYBUY
   R8PTC1t/JWo9FtgocNBm2xEjEyoo4KfkZT3P7ixZs8/0MThJ1DYgTn/O3
   gGunhAGg4egrRT+bY8T0gnM+RDTAHsaVYwhVJM6RxNgmzZsdIO9MRnl/l
   M42jaPRKPUInGOK8c0UolHZk8Wy9IbzcU86Ui0pe1fmzQvN5vbDyw9Daz
   fnmHBcHm41P4//ZZtRaeyG57afL8HRHMY6WHZ3iXkhtXipytI80oI7k1f
   BPt88eKfjdA3c9DhS/4puJGC7LvIaIHx1WsTDIrRIyGvjPWD5TkpSZf3c
   w==;
X-CSE-ConnectionGUID: gTMPXglHR9u4iYeQTQWXcg==
X-CSE-MsgGUID: yfs82dLSS1WbJxUdzlEJ+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="88854055"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="88854055"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 01:34:20 -0700
X-CSE-ConnectionGUID: 8+Z0nFdiS26Wllt9SpTf+A==
X-CSE-MsgGUID: W/mmI9cRQ3CYclmLdsKmGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="237903188"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.248.249]) ([10.124.248.249])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 01:34:18 -0700
Message-ID: <455f2958-bf1c-4727-811e-979ad66b79a7@linux.intel.com>
Date: Mon, 27 Apr 2026 16:34:15 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, will@kernel.org, robin.murphy@arm.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 xueshuai@linux.alibaba.com
Subject: Re: [PATCH rc v8 4/8] iommu: Fix pasid attach in
 pci_dev_reset_iommu_prepare/done()
To: Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org,
 kevin.tian@intel.com, jgg@nvidia.com
References: <cover.1777074513.git.nicolinc@nvidia.com>
 <0496b91a776e10220ea84450e3cd9f781e74d396.1777074513.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <0496b91a776e10220ea84450e3cd9f781e74d396.1777074513.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/25/2026 9:15 AM, Nicolin Chen wrote:
> Now the helpers handle per-gdev resets. Replace __iommu_set_group_pasid()
> with set_dev_pasid() accordingly, in the pci_dev_reset_iommu_done().
> 
> Also add max_pasids check as other callers.
> 
> Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
> Cc:stable@vger.kernel.org
> Reported-by: Shuai Xue<xueshuai@linux.alibaba.com>
> Closes:https://lore.kernel.org/all/ad858513-09fc-455e-bbc5- 
> fe38a225cc78@linux.alibaba.com/
> Reviewed-by: Shuai Xue<xueshuai@linux.alibaba.com>
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 25 ++++++++++++++++++-------
>   1 file changed, 18 insertions(+), 7 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
