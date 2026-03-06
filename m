Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37051283FD8
	for <iommu@lists.linux.dev>; Fri,  6 Mar 2026 05:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772775368; cv=none; b=L1xcuGuJq818B4+0th29J5HIR1mwzqfCgd7813nSAFrqLhvL0gcsu4yYaOcE1uwJ7oQlnrTp0sRR7COjSnDTYpcWR+U4tU7IUu9N4U5v064I8Lo2M038xqfNUoUOga3ynHNvCOhetm5rV3OkU6bAvsSTuxD78sEJATB+PsGkkwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772775368; c=relaxed/simple;
	bh=t/3rwNO/Z9wzwV8WvwtIeuA7QW4WLG/g2amWr56HDbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=slJwcvzeff5S82JbA32X1ZnIII3qxfo5lsFffblZHmhiBni8jaQb/VERjyHbUrKSdRjq/O/SniGfj2ay6TiSsIQST7Fob26qyXT028LMN1cV+wZeiGXHI+fnKOLmzt6weNuXVXOmN6DZnIPeyt2xMPC+VQyNejpQdO6mTy/mcX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZSOQwQJe; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZSOQwQJe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772775367; x=1804311367;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t/3rwNO/Z9wzwV8WvwtIeuA7QW4WLG/g2amWr56HDbo=;
  b=ZSOQwQJeXDfOGAxbbXGfhEjsylx1/TU+9P7PMPsluB1iV1w9Zh5m50tL
   ORB3Gd0CUoDmb3CSApIbS9MoEECCTx6ImaRjfCM6vokmNFP7+fTwSDr6E
   J/IvLePX/k0sGCHbWxSonU6Httpv6tMv+9HASaXaO/7nasjeEEi1UT1W5
   krebMak91KJqtpt/MVqKmTnQrdpnc1Y3RszG8/YtWiEtgGOjtK9QPYCBM
   u33fsn4jxkO9bR7hmcL6gcZGLFeY4OIyHHyzewPxclzPBFUyzVL66K+B3
   rblbvrQnYqhUIdL4RJv5bgo0tt22t8ToKMSjAnhGbMkTdQj7wAM5K9y8n
   A==;
X-CSE-ConnectionGUID: fzaQm47FSXi4VALI98Y0xw==
X-CSE-MsgGUID: umO+NTHmRXqNiGaQJ8J0nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="73070833"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="73070833"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 21:36:06 -0800
X-CSE-ConnectionGUID: +PwxrBEuTTO6/WdSmMRF2Q==
X-CSE-MsgGUID: zbYvy1MBSbC5RxJX+fT0Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="249386813"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 21:36:04 -0800
Message-ID: <5e73da9e-7f3c-43a8-b437-3d9942a6fcc6@linux.intel.com>
Date: Fri, 6 Mar 2026 13:35:22 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] iommu/sva: Fix crash in iommu_sva_unbind_device()
To: Lizhi Hou <lizhi.hou@amd.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, yi.l.liu@intel.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, vasant.hegde@amd.com
References: <20260305061842.3953885-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260305061842.3953885-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/26 14:18, Lizhi Hou wrote:
> domain->mm->iommu_mm can be freed by iommu_domain_free():
>    iommu_domain_free()
>      mmdrop()
>        __mmdrop()
>          mm_pasid_drop()
> After iommu_domain_free() returns, accessing domain->mm->iommu_mm may
> dereference a freed mm structure, leading to a crash.
> 
> Fix this by moving the code that accesses domain->mm->iommu_mm to before
> the call to iommu_domain_free().
> 
> Fixes: e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries for kernel address space")
> Signed-off-by: Lizhi Hou<lizhi.hou@amd.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
