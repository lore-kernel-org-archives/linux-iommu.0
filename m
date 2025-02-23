Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043B51F03FA
	for <iommu@lists.linux.dev>; Sun, 23 Feb 2025 13:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740316108; cv=none; b=lMD58IIxCeEla3ht/nzvvJ0vlOcg8MnYigFL3GKho8FCvRq0zYPrpUIsIW0lc/9PpvDDz6yMBxcJ/Kv9enTS9YIE6YGhEE3k7YzDW0svaOnNp1UHy6u+zVNO1T7MURjCLkYb4+VW+Xgnt4JkkdNMyYP1rXxaITmkn9XROvWnFXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740316108; c=relaxed/simple;
	bh=LyqTbOKWMny3tCoOnXU6urFuzZ1OGMpPD7GseIJzAwk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d61einEDToA20FLi/cOLfY/LSqacHm/8EkTiH8VU8TLhv5rT+HMAZ/xhkihPIXzQqoUVfPd1ggFmmz1Mn+XUncInZkaCl4TMzoUhhodeKNUmJGHjPQchfpTn30dR22mNsgK+FZYSibI87Rvceei6A4KR5JyPJtTU2KRwQKWXJoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EJvqfxfz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EJvqfxfz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740316107; x=1771852107;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LyqTbOKWMny3tCoOnXU6urFuzZ1OGMpPD7GseIJzAwk=;
  b=EJvqfxfzoCXjPyZxbFr7e791EEf0NzYxCQv0a/ndE2hRCRViEZAlICRs
   JHlCGrMTp/7TbMR2UAXm2Iwv6PZjSxfez165nzRQYPjPy8iFLs+jMsQK+
   Gs6/7eteImcpCW6UMZwp+r3O9e4Kiz62/ze2aCV+/QUMZYOvDHyfSoT4l
   uPkKbZ25jfAHD5HVqEwxVYJhRLc6O8Z4Oq7c5mqBUg+EIzk1G+yKs6SPa
   YYlypD2YV4SxoAE/u6G0VyfbaCBsxf6n33ZQQL4UT48D4XNE6Fbe10dWI
   dg9HsWqnoLYr6vG46MkBUu/F+VIuXOxDwCFscepXNWY1LiJO+8EJklEN0
   g==;
X-CSE-ConnectionGUID: oxMD5JqZQLWkTgyiJJMkng==
X-CSE-MsgGUID: qyCtBTk5S+aWQDHvCnFygg==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="40270921"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="40270921"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 05:08:26 -0800
X-CSE-ConnectionGUID: FAgCVakXQy6LszoqsUmptw==
X-CSE-MsgGUID: wka8VnzxRmGZWY/zaIzPWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="115784068"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.93]) ([10.124.240.93])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 05:08:24 -0800
Message-ID: <55cb9bbf-a3c4-4749-82b9-074d4def8a41@linux.intel.com>
Date: Sun, 23 Feb 2025 21:08:21 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, kevin.tian@intel.com, iommu@lists.linux.dev,
 robin.murphy@arm.com, nicolinc@nvidia.com, will@kernel.org
Subject: Re: [PATCH v2 1/4] iommu: Make @handle mandatory in
 iommu_{attach|replace}_group_handle()
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com
References: <20250221143335.49874-1-yi.l.liu@intel.com>
 <20250221143335.49874-2-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250221143335.49874-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/2/21 22:33, Yi Liu wrote:
> Caller of the two APIs always provide a valid handle, make @handle as
> mandatory parameter. Take this chance incoporate the handle->domain
> set under the protection of group->mutex in iommu_attach_group_handle().
> 
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Nicolin Chen<nicolinc@nvidia.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommu.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
