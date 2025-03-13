Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DB025FA0D
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858214; cv=none; b=cUe6Vy7B69UH70yGxX4UmRBq5h2v7xtC0+KJDBSs3QHsLrl+uigOa6GCDDreaW4P4QGWiYoU16yyXfnGiPQe34HTuYhW3z2MXiTLLhkKI6ruoWRPMajF1qLIbANbqLdKpyW6jIgpUSBYNLFcv+qsBF8tK3bVDTtYj68IuySdWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858214; c=relaxed/simple;
	bh=9A9aWfK66AcpdLfD2H0fwAZBqHh3y2XzHBKKmsqHBwA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uQ1fsqS42vbcpmGyqjBiCioPtsZjW/uvG9f5QAmXq5hUO3SQXP7Q3te7ePXfxTeK52FP6IbTf09Lcy2fZQlt1HwD9DVf+rtbm3/MjEgffcMMOHK0Fxvw+sLJ9IUbj3NbgZmyS/25hZqsLR0HQj/jZZ7zfmBQdIRNOASFrQalkZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=les2C6wd; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="les2C6wd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741858213; x=1773394213;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9A9aWfK66AcpdLfD2H0fwAZBqHh3y2XzHBKKmsqHBwA=;
  b=les2C6wdh6hJ5CHN1UlFrIoQ2e/NebGzlYVpLC729nA8gIBYoZxITaVW
   ueKotJn62S7+nd8uX60JwujNjX6EpmIrC2W7xp3e5E0/qBtJBVBk/zpaP
   92l2t0uHV7KDVLv2+kLOYZeWRmGpXAT3nSOizDsWclE2tgdCK5URpNq0w
   hxyJAqc0bvWULqSAAgKSK0wNNRxlDfc72Z3gQkZamCJm3FNX1vXtAscSo
   y+ww7ioovufSg1b6MmLZkFZZbKk4WfE4CAJrr9IFozStSvPTUa7lGi8Vh
   iQIz+0uAS/Buto7jEhMf9wWcoexN/dnu1lq+WzsWTjqp9r12L51A9J6Vt
   A==;
X-CSE-ConnectionGUID: /TZiX4r+SWSgt8jvpU09Dg==
X-CSE-MsgGUID: 2srr5OcsRWqxndusfdn60A==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="43165186"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="43165186"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 02:30:12 -0700
X-CSE-ConnectionGUID: ThHyzZFJSJ21MNu6FnbVTw==
X-CSE-MsgGUID: bFY35IFOQBq8cUZQfmaHZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="151851976"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.153]) ([10.124.240.153])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 02:30:10 -0700
Message-ID: <9902ee4c-6223-4550-b25c-984629618f58@linux.intel.com>
Date: Thu, 13 Mar 2025 17:30:07 +0800
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

Sure. I will look into this issue.

Thanks,
baolu
