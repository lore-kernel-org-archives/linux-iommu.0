Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFBA11CA9
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875809; cv=none; b=HfzuDo8zQIUVdgCqO8Q5kNc1gl3forqpGO4KuQcmMantjbvXUfVsPq9FJ0Ih6CM4+YPh9DDEGovnCMl9+jxXxcAYt9xxaWT+2/AWXkuYt3dEnaGGGmFrexLjaOnWlej8QbEL6WeHK4KOu1IoJy76y3RLATOZcjzfUFp2pRHIl2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875809; c=relaxed/simple;
	bh=A5PPOBJOpPvDRe5BePeyQ5B7xJX/FSbcMpShYRQKn0E=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D/s6NWjPmKKwjj1PpWS0r/Yr97rQ4mFfC5CxImQsii3AsgtSYpDolRT2QagLvlVX4vYjEhNhaXGPtO92fRaWcSEQVcr+CmUlZy1bUg+vy3r0/WN4onUwgm+El7syv3SclQSWM1nK1nfuUmsvnxkZpVZ4XB4OJ+sf/CW3khFqmEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L7XAgZha; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L7XAgZha"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741875808; x=1773411808;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A5PPOBJOpPvDRe5BePeyQ5B7xJX/FSbcMpShYRQKn0E=;
  b=L7XAgZhaD9vtrJ5jWge7kMAQPPLO/9cUi+y4VoGg706oaMVMsJK2oJu0
   I3aAFL9sLr6zF45kqJ8rCkYmgwLNx3FsSZFcDBJsyd+WofQfC41YImovP
   k2Q64S6O8k3HGYu1TV5KDYwReIDgpmX3qsqu+ICOXlCziE4/hd93UjBLQ
   OxDBVFfdKA4zglyPrgOi0Skkcb60tto3blldaENO5OHCw6KrZHl7fCwCv
   Q9MLJ/2KMIrL2bPjYmr51APpqNY8ZUX6cxOQb8Y/KBHUH40QFpnW3513M
   4wX68MIreOI76f5GEoKB/QBHk8jkfwGD+0k97Wa94f05PRTA0wiMAO2AS
   g==;
X-CSE-ConnectionGUID: uQ22fO6ZQqyFDSjLdkoQRg==
X-CSE-MsgGUID: eG0WLbi+QzOLD8o6lW3mmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="46781066"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="46781066"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 07:23:27 -0700
X-CSE-ConnectionGUID: ADKTsvOPQESkpGsquwjb8Q==
X-CSE-MsgGUID: 0L1ggzzZSSeDhvcvHIgIeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="144155547"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.153]) ([10.124.240.153])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 07:23:26 -0700
Message-ID: <4951eb3c-aa2b-46cf-87bd-37b09447748d@linux.intel.com>
Date: Thu, 13 Mar 2025 22:23:23 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: Regression on drm-tip
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
References: <SJ1PR11MB612953431F94F18C954C4A9CB9D32@SJ1PR11MB6129.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <SJ1PR11MB612953431F94F18C954C4A9CB9D32@SJ1PR11MB6129.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/3/13 16:51, Borah, Chaitanya Kumar wrote:
> Hello Lu,
> 
> Hope you are doing well. I am Chaitanya from the linux graphics team in Intel.
> 
> This mail is regarding a regression we are seeing in our CI runs[1] on drm-tip repository.
> 
> `````````````````````````````````````````````````````````````````````````````````
> <4>[    2.856622] WARNING: possible circular locking dependency detected
> <4>[    2.856631] 6.14.0-rc5-CI_DRM_16217-gc55ef90b69d3+ #1 Tainted: G          I
> <4>[    2.856642] ------------------------------------------------------
> <4>[    2.856650] swapper/0/1 is trying to acquire lock:
> <4>[    2.856657] ffffffff8360ecc8 (iommu_probe_device_lock){+.+.}-{3:3}, at: iommu_probe_device+0x1d/0x70
> <4>[    2.856679]
>                    but task is already holding lock:
> <4>[    2.856686] ffff888102ab6fa8 (&device->physical_node_lock){+.+.}-{3:3}, at: intel_iommu_init+0xea1/0x1220
> `````````````````````````````````````````````````````````````````````````````````
> Details log can be found in [2].
> 
> After bisecting the tree, the following patch [3] seems to be the first "bad" commit
> 
> `````````````````````````````````````````````````````````````````````````````````````````````````````````
> commit b150654f74bf0df8e6a7936d5ec51400d9ec06d8
> Author: Lu Baolumailto:baolu.lu@linux.intel.com
> Date:   Fri Feb 28 18:27:26 2025 +0800
> 
>      iommu/vt-d: Fix suspicious RCU usage
> 
> `````````````````````````````````````````````````````````````````````````````````````````````````````````
> 
> We also verified that if we revert the patch the issue is not seen.
> 
> Could you please check why the patch causes this regression and provide a fix if necessary?

Can you please take a quick test to check if the following fix works?

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index e540092d664d..06debeaec643 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -2051,8 +2051,13 @@ int enable_drhd_fault_handling(unsigned int cpu)
                 if (iommu->irq || iommu->node != cpu_to_node(cpu))
                         continue;

+               /*
+                * Call dmar_alloc_hwirq() with dmar_global_lock held,
+                * could cause possible lock race condition.
+                */
+               up_read(&dmar_global_lock);
                 ret = dmar_set_interrupt(iommu);
-
+               down_read(&dmar_global_lock);
                 if (ret) {
                         pr_err("DRHD %Lx: failed to enable fault, 
interrupt, ret %d\n",
                                (unsigned long long)drhd->reg_base_addr, 
ret);

Thanks,
baolu
