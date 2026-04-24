Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D195330651
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 05:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777007492; cv=none; b=ImiTMEE8jSiBkWuF68ov1xOewHFLeJ7y9gu0NMy/CpTKi4JfqwcivItWLu/qJPEctz6ucXRwVs4pCfy3fxjDK8WTOg16qsUzW12QVVYBwEVc7L4xNpNljXn/pSkEYi/yPH9fGXNmyJ6nb9m4drshEO5uEKhkiLGf2lI7wvCPROw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777007492; c=relaxed/simple;
	bh=CYXNDhFC+ZT8VlxhCoacdT9IM9RGdMxxo6R/h1mHMWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VwmluQgJOabtHDjnoC3cYdXLp8+lM1vATdFg1Xvb1RxhGjNTHzR/rDDSI0nutDdgTEAnt0yJB8cjzvvSDA744mKIeCsFbW/ykzwPH4Dc8ASO8pKF1sQabMi4vbuF0BXAGkGEcepYhBTC1h9gB/9K6sDvsQY2XnGA/hVHV1iuFRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLMijfaL; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLMijfaL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777007491; x=1808543491;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CYXNDhFC+ZT8VlxhCoacdT9IM9RGdMxxo6R/h1mHMWs=;
  b=gLMijfaLBwgQRBPy0Ilo24Bhoo0UyumIPk1mhq+nf2jMKQ413Q6EBzV/
   w4/IRzTRqCaWXBRInM+4DVj3cpjb6XTb7G1QUupXdblHTfMWUH7vZEHEO
   acIoXhqSuwgQCq+xaYs0v90MEbLdulAYUYQGQE+CJgVtZXYCqHqTXQVI3
   tf+chFUigz3owgiiawAVt1h+pQCB6LSivPUR6j9GO5vAWLwWnLAYdUZP3
   uCfuo/r3oGP98tCP+9YpB2f7ntq8V3LjccZTLCfzQxlZ+F39aPgNci8mU
   tIuhYz3Stx9bAOofY3Bq45JaCPY8HSgyu+QgH2a395nx09ac5SzB2dyhj
   Q==;
X-CSE-ConnectionGUID: qtSSnyYDTrGkWBKNG/C0rg==
X-CSE-MsgGUID: vjv9glRxQVqrPfIbpm3AAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="77015634"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="77015634"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 22:11:30 -0700
X-CSE-ConnectionGUID: UEyYfouGSaCxSZqxlrIqNg==
X-CSE-MsgGUID: XutVOgBvShyT2jJGVxF7lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="234637681"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 22:11:28 -0700
Message-ID: <480fbd63-0fe6-4e57-a724-faabf116dc25@linux.intel.com>
Date: Fri, 24 Apr 2026 13:09:22 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc v7 1/6] iommu: Fix kdocs of pci_dev_reset_iommu_done()
To: Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org,
 kevin.tian@intel.com, jgg@nvidia.com
Cc: will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, xueshuai@linux.alibaba.com
References: <cover.1776551790.git.nicolinc@nvidia.com>
 <b503d422582900fa0e856aff8299c3e5a47d0284.1776551790.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <b503d422582900fa0e856aff8299c3e5a47d0284.1776551790.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/19/26 07:41, Nicolin Chen wrote:
> Remove the duplicated word. No functional change.
> 
> Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
> Reviewed-by: Shuai Xue<xueshuai@linux.alibaba.com>
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
