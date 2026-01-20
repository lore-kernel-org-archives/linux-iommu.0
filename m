Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E85381701
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 07:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768892960; cv=none; b=D7JNma79ZO2PDLm1h+fknhuG+Z/10fh7sb7Z0Nphfys/AsC6Y0LmUlrIDH3SPcgBbN3YxS0MbCJAA3eSG5YtMBh/zBPz0ziJK97DFAaMCzAyp5bgrIE98QGwwDMB89m8EonVV0t7mg97VG3Acsi1chVOuZj5McifLcsZwb4SUos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768892960; c=relaxed/simple;
	bh=ZSFXElsdNq6BIF8BdWINoT50UXaUe24TzAjWabTLutM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZK7NFLAscrTAcflEz8TPNPffTHfHGheSA7qU9NNI9BIbFLvDAHUP8z1+e9Dd4z7Ovu0wIhjS9O224wNgtkCzhBE3QAnVGB9gHbOnYUsmsEKSF6EZSvdXzuvcPHhtUOnbtqHe+8Y2jbj0nFuKzCnrS8QoE9QwJFaPzDIo/Nb7bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1Aq3YQu; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1Aq3YQu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768892956; x=1800428956;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZSFXElsdNq6BIF8BdWINoT50UXaUe24TzAjWabTLutM=;
  b=J1Aq3YQuEJPtpfzIGh/27a73ozJAA7/LnumkFN1Wq4xOlfB1eTHF5q+y
   A+cuL7Oq/2geUsAW1obJcQ+tUcWhdbHQGTTFgdQQ9iN/Qrkcjmb5vt6s3
   Pi7ERmC3A9tg1j3Lc5RfIfWpPpBKx+4Zm2Z51cUE6rBn8SCy6iQlu7wwR
   TXdjiGYWT0qDcr7RZYQ8O+1L5uaFO+j4tFTT0JXr1LlKqy3J/qSQZ1vpO
   jW8h8vgqUEFLFmpU69nM/QmQ5yuTagylixyIsGjMYcCl0OzT6r+/DtCy6
   N3WBhGBEsEGnFzySoUFkbq/0W+t5YduEky9JovfQb8qnggimZGnYQPvwM
   w==;
X-CSE-ConnectionGUID: 3u+0PtSgQXqVLJtvX4Taug==
X-CSE-MsgGUID: 9CDbPV2/Q9+luN/XPoCOUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70181552"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="70181552"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:09:09 -0800
X-CSE-ConnectionGUID: QUs9TrPQRLy7M7SHVOO4cA==
X-CSE-MsgGUID: +/s3z4ZKQ6yEkrTbEKv3qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="205843635"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:09:08 -0800
Message-ID: <ee99368c-95de-4d4b-a541-9c50d6b35b98@linux.intel.com>
Date: Tue, 20 Jan 2026 15:09:04 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/vt-d: Flush piotlb for SVM and Nested domain
To: Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com
Cc: joro@8bytes.org, iommu@lists.linux.dev, jgg@nvidia.com
References: <20251223065824.6164-1-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251223065824.6164-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/23/25 14:58, Yi Liu wrote:
> Besides the paging domains that use FS, SVM and Nested domains need to
> use piotlb invalidation descriptor as well.
> 
> Fixes: b33125296b50 ("iommu/vt-d: Create unique domain ops for each stage")
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> ---
> Change log:
> v2:
> - Use domain.type to filter nested and SVA type domain. This eliminates
>    the SVA domain ops reference issue when SVM is compiled out. (Kevin)
> - Add a intel_domain_use_piotlb() helper to cover the three cases which
>    need to flush piotlb. (Kevin)
> 
> v1:https://lore.kernel.org/linux-iommu/20251208091907.74719-1- 
> yi.l.liu@intel.com/
> ---
>   drivers/iommu/intel/cache.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)

Queued for iommu next.

Thanks,
baolu
