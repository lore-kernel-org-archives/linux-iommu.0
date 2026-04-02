Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09809388E69
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775119239; cv=none; b=fsU51EaYNU/xUU7lgWqYy9zihwz+cdtRzNkt/IQZ7wf+mDOh89iKqLrWleTZPejdMzGxykQ0QKWxK4gVM1elfHiDItftxALOHeB1G5qSdImsvjX9nJ7ysajT25/gPTRYqZTfHeMhj8QS5Z/UANWkCKAHiobusQ7nOwxLERLj7uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775119239; c=relaxed/simple;
	bh=GK5SKsuPdPWtbsE65q2V4IojHNAgAtSi+hceAwThqXI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hiZvBJPunoQWEg9jYyKAQvMFp0SJzpWfSWZtJDMIxcVvG8/MamZEgh5mwQdhZXNIAmgvxqcHqBtM/mF5q8T4VCaPAVpTeMOQgHK0FjyOdLXryz3rZvfYWKFdYw3hUzkuVVoIqpsUy3vrXHz2d3+qLeZG1OpFb1RLIzXV+9oAebU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+ZvXCoT; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+ZvXCoT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775119238; x=1806655238;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=GK5SKsuPdPWtbsE65q2V4IojHNAgAtSi+hceAwThqXI=;
  b=J+ZvXCoTi5T+FjAMsnLUQgU1cMKvQtWEwjBO5MOA3rC1rqa201ugS8kf
   HncJKets7nMFxkR91WejKBHCHlkn3Qvmt8zVjJhV+CmtqMTR17GmL9mOY
   DMGXoUpbaaZqibYQBKoIZbdBK22QAUaGK0Dqj9RyyT0f1f8GQ910UKHjk
   i9s2wygyHFHWvvWNxdl5Gv2CZyPkmldMRHAayJ1kj69peso84RMrDtZpe
   18YKYkxibs9U66NvpzVwCHhufY9E8o76ch9HkKAXPieTU7+d94tClUzk+
   qCeYq+uf+xlRNqGnFNRji9vbnxENE/UQL3VCe1rPNOXwAAgfwjED5xtQn
   g==;
X-CSE-ConnectionGUID: UiEkDMRIR4q6hJ2RPrvjQQ==
X-CSE-MsgGUID: jWZWA/jnT7G6H/IDodkk0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="75211877"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="75211877"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 01:40:37 -0700
X-CSE-ConnectionGUID: 70VZZjqWSTqUy0kRR8okhA==
X-CSE-MsgGUID: x1bxZh7qQNu1e0dcGaUj2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="227184328"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 01:40:36 -0700
Message-ID: <5b23df32-ed14-417f-b694-a191f4423aac@linux.intel.com>
Date: Thu, 2 Apr 2026 16:39:08 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] iommu/vt-d: Simplify
 calculate_psi_aligned_address()
From: Baolu Lu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>
References: <20260402065734.1687476-1-baolu.lu@linux.intel.com>
 <20260402065734.1687476-11-baolu.lu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20260402065734.1687476-11-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/2/26 14:57, Lu Baolu wrote:
> From: Jason Gunthorpe<jgg@nvidia.com>
> 
> This is doing far too much math for the simple task of finding a power
> of 2 that fully spans the given range. Use fls directly on the xor
> which computes the common binary prefix.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> Link:https://lore.kernel.org/r/4-v1-f175e27af136+11647- 
> iommupt_inv_vtd_jgg@nvidia.com
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/cache.c | 49 ++++++++++++-------------------------
>   1 file changed, 16 insertions(+), 33 deletions(-)

Hi Joerg,

Can you please remove this last patch from the pull request? The AI
reviewer reported an issue in this patch.

https://sashiko.dev/#/patchset/20260402065734.1687476-1-baolu.lu%40linux.intel.com

We need more time to evaluate and address this before it is merged into
linux-next.

Thanks,
baolu
