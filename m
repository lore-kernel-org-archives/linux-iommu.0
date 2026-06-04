Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70B3385D64
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 03:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780544731; cv=none; b=RPZXJ2Ic0WlEstyktFV3vP46cPzBpBE0s94GVSA3HIUcV1fYA1vttiaueJqPpJ9YTa02bhwoRWaXBqeJskBF2bRc7HKPqeQV2E38ZrJqoL1800HUEcAG5C810Vwikgi5BXs9RifgDUCD6hfpB1moQ2m21j/c0ixJksOKeIk4mcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780544731; c=relaxed/simple;
	bh=oRHYiWjENp0NeEu99m7zuAH7tyzP66diLRnbSCOI/4M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fA7gWMptCS2/5c5FobNmnPuQF/aCU+3UmxxFRc3zn0VSiL14tSR505CdcVvqEh8zZD8xqg/7W9Yc1/HTrUfR6Tcell4pxZWwAEmTVACXHgLtCAqY7ZmqWVAj8sdEMwbeo3BFg/LnTdGJP3s1HGWNtkXuUpuRXGen3xIyBKoCwOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ItDTFZ/X; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ItDTFZ/X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780544730; x=1812080730;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=oRHYiWjENp0NeEu99m7zuAH7tyzP66diLRnbSCOI/4M=;
  b=ItDTFZ/XcIuBzogUYGlpkeAA0guCpld5Qky7NTaChwKFs3v37/kyE1V4
   8hPErf6IAQJYaohuQDkvNjkI2cJfB0wD0uJtTorHp7T3CoXWCrDzsUgGq
   9UyMQ6Rk7yzOIY7I5vgwXC38J8h4N1OLP1FIRRHDv+kJvkVZz1VoFFuQd
   lOSQz2vLyGzo18up+TIYba9GovOG9qcW4yXxJMPCi7/m71ENUB2j3dKpH
   csnxxB9lTdAHNqXMJyhvGEcFjri35nGwmmGcMujg36XGt2pyivz0Z4b5U
   OA2N4xFG4jhLlMYkOuDd009Q/zf4sLDrvNz7WuxnjPM1+MtzhP54kJnFo
   w==;
X-CSE-ConnectionGUID: JxNDRo58S++Gmgcipk/iyg==
X-CSE-MsgGUID: sEXdixsMTE2y75hggnv5HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81398425"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="81398425"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 20:45:28 -0700
X-CSE-ConnectionGUID: 3lLfFli9R7SkriF7y7Ty4g==
X-CSE-MsgGUID: 3cAeF5XwRQelTrV6M/g86A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="243593284"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 20:45:26 -0700
Message-ID: <c9c542bb-5b67-4ec3-a5ca-28c59292809e@linux.intel.com>
Date: Thu, 4 Jun 2026 11:44:30 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] [PULL REQUEST] Intel IOMMU updates for v7.2
From: Baolu Lu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Pranjal Shrivastava <praan@google.com>,
 Guanghui Feng <guanghuifeng@linux.alibaba.com>,
 =?UTF-8?Q?Micha=C5=82_Grzelak?= <michal.grzelak@intel.com>,
 Michael Bommarito <michael.bommarito@gmail.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260602233426.357499-1-baolu.lu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20260602233426.357499-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/3/26 07:34, Lu Baolu wrote:
> Hi Joerg,
> 
> The following changes are queued for v7.2-rc1. This update introduces
> a few quick fixes and several refactorings, including:
> 
> - Add the PCI segment number to DMA fault messages.
> - Improve support for non-PRI mode SVA.
> - Ensure atomicity during context entry teardown.
> - Fix RB-tree corruption and a UAF error in the probe error path.
> 
> These patches are based on v7.1-rc6. Please consider pulling them for
> the iommu/vt-d branch.
> 
> Best regards,
> baolu
> 
> Guanghui Feng (1):
>    iommu/vt-d: Improve IOMMU fault information
> 
> Lu Baolu (1):
>    iommu/vt-d: Avoid WARNING in sva unbind path
> 
> Michael Bommarito (1):
>    iommu/vt-d: Clear Present bit before tearing down scalable-mode
>      context entry
> 
> Michał Grzelak (1):
>    iommu/vt-d: Remove typo from pasid_pte_config_nested()
> 
> Pranjal Shrivastava (2):
>    iommu/vt-d: Fix RB-tree corruption in probe error path

[...]

>    iommu/vt-d: Fix Use-After-Free in probe error path

This patch is unnecessary per the discussion here:

https://lore.kernel.org/linux-iommu/505c8f52-2526-4d78-bdff-1bf67f49129d@linux.intel.com/

I will send a v2 pull request with this patch removed.

Thanks,
baolu
