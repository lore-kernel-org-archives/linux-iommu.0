Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2DB23D7
	for <iommu@lists.linux.dev>; Fri,  8 Mar 2024 01:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709862405; cv=none; b=gOMuk4QdS8/MDU5q2JahFHxamc5oY7qaD9vEqV/oBwefgMGhVxfKxxFyK5YyH0lcmZXglyxJvHDOCI//UASP4oXZJvx3u0c79am71HDigiyZL46bX5mKOKZZK6tNFHrfQQHiZJ/2XyzwzLhysgOvxjIpJp8rUYU7e5/LCcLhglU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709862405; c=relaxed/simple;
	bh=IVPq8N2j/iOv1/7Yev/gBsEV7HoD32GIq2O/4f9aOlE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Qz8M3ouKTkQySdzoGtrMTqA2qqquaCJsKSEmG2ffw9j4VUqxFJFXzNtP6oooyv8xFwpBtJCRl7bBOlhsh1L/jZExIDosCBJwayXTPzjgcWtAiME6lndq0pKmFT9M9cRnQRQjMfQQvcgidtnqwBHd5PrsCBultsPVP3nE0ljZlgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iwd7Qkay; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iwd7Qkay"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709862404; x=1741398404;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IVPq8N2j/iOv1/7Yev/gBsEV7HoD32GIq2O/4f9aOlE=;
  b=Iwd7Qkay4GCvI0cct6QMrdhf3Gud2dPVvjcoAJQlH/i4pM8cI2VwYzsY
   chFRPUbPkPBWjnAqGoM2emYM3TTWisyF2lVpukLhaEU1PYw2SL8e/E/Tz
   QDc9kzO/VJ93t65SeFf2hGGoMFWbqHwE8PAK3CfrVoEU8OyiFbUa2WRzb
   Wqg+18swkFM9hye3RZMYiZncAhkOfDmolYiEck/LjsIGLgLW2DuqG27OB
   tHmlXhSvl+TGCQ/jQXv/2TJ/GWmZaugUsbM4ftiRykmokUE+CmIUnPdg4
   t7SfjmiN2fTWJOHTQdyx0o265OTNrQp8Bz5QfcgUD5HeMCjWZZhdsOj4l
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4498345"
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="4498345"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 17:46:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="10244795"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 07 Mar 2024 17:46:38 -0800
Message-ID: <6afb82b4-379d-4a6c-8cc0-00fc72caa72e@linux.intel.com>
Date: Fri, 8 Mar 2024 09:40:30 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, haifeng.zhao@linux.intel.com,
 iommu@lists.linux.dev, jgg@ziepe.ca, jiaqing.huang@intel.com,
 joro@8bytes.org, kevin.tian@intel.com, linux-kernel@vger.kernel.org,
 robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH] iommu: fix compilation without CONFIG_IOMMU_INTEL
Content-Language: en-US
To: Bert Karwatzki <spasswolf@web.de>
References: <20240307194419.15801-1-spasswolf@web.de>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240307194419.15801-1-spasswolf@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/8/24 3:44 AM, Bert Karwatzki wrote:
> When the kernel is comiled with CONFIG_IRQ_REMAP=y but without
> CONFIG_IOMMU_INTEL compilation fails since commit def054b01a8678 with an
> undefined reference to device_rbtree_find(). This patch makes sure that
> intel specific code is only compiled with CONFIG_IOMMU_INTEL=y.
> 
> Fixes: def054b01a8678 ("iommu/vt-d: Use device rbtree in iopf reporting path")

I think it should fix below commit:

Fixes: 80a9b50c0b9e ("iommu/vt-d: Improve ITE fault handling if target 
device isn't present")

> 
> Signed-off-by: Bert Karwatzki<spasswolf@web.de>

For users who want a configuration with interrupt remapping and without
DMA remapping, they can achieve this by selecting
IOMMU_DEFAULT_PASSTHROUGH or using kernel command "iommu.passthrough=1".

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu


