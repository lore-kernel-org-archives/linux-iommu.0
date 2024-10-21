Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D87194C6C
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 06:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729492061; cv=none; b=baphqJZ0tOQliy8RMHM4C/cvTmDv6PFaEWvQA6BtGZNHC+z1svlSUmP5KpAxJy8iuc1JgedWIsdvYmAWUHK2180T5XxALXnxOfC1JBE4KtQo0D2Jk9kCjj2O8vNAoug0zwnKG7Q3UzPWn5RKVJOoww3zzSto7t3WWrQ0NaGvVC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729492061; c=relaxed/simple;
	bh=KqQV1jBJ1R+LBKBk0CySepX7kupWCVvNeVB8OkPWJI4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Eb9+J0QEmnehmeFswN/oJZUPN9YwjapaenSbai0AJtg5SPJo2QE+6Ggq+dCw3hRzN3YVi57pkHE3FiSFiZMhC+QTERlKnDjijbWzu5wFQxzQSh47FgpsbY6hVyx9MPTrF3fFHEpsuN5gqh1331r7lO/xQmNiBMYZIt4i2MAp26U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nc2xdKSX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nc2xdKSX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729492061; x=1761028061;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KqQV1jBJ1R+LBKBk0CySepX7kupWCVvNeVB8OkPWJI4=;
  b=Nc2xdKSXu0jiNZEFtkEWKmSMa9Xw3AkqlArbG9VKiuEpMZXchUMF79Iy
   p2FTHwxFb3vGagZF3CklR+v3mivwGJzwNgrLOi8CWDjNslAdijdaR25xS
   a14ISAMwDESILt6GqkVsnFMnduNuInsbv/1el4q4eiYb7xy2bZtnvhcWC
   RmA/1R4HlE98xh13MGBvY1i5t5Aa+DxxbnoK5Jzi6n++WjK7fD3Zzus2X
   68WNvIxBde5d+IKU7ccQa5DD5a6ue0301sGIZwyj8dtRmXCrg/EcLh5Sf
   6+HR2CsxdF3shZxlxBemou0YzcS9xk0Mg8OmSn7TDpsk13a1WgEwrdN8x
   A==;
X-CSE-ConnectionGUID: zhyrXKDqTfmmPL+dcgZ9zw==
X-CSE-MsgGUID: fRJco3DxR8i4b8CvdDLdVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40084568"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40084568"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 23:27:40 -0700
X-CSE-ConnectionGUID: 3x7FizEYT7qxA1+28A7rqA==
X-CSE-MsgGUID: 4fDg2/ShTvm6UccG3oNyXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="79363857"
Received: from unknown (HELO [10.238.0.51]) ([10.238.0.51])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 23:27:36 -0700
Message-ID: <17513727-c2db-4aea-a60a-d9bb8b8ac71c@linux.intel.com>
Date: Mon, 21 Oct 2024 14:27:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, alex.williamson@redhat.com,
 eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
 chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
 zhenzhong.duan@intel.com, vasant.hegde@amd.com
Subject: Re: [PATCH v3 9/9] iommu: Make set_dev_pasid op support domain
 replacement
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com, will@kernel.org
References: <20241018055402.23277-1-yi.l.liu@intel.com>
 <20241018055402.23277-10-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241018055402.23277-10-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/18 13:54, Yi Liu wrote:
> The iommu core is going to support domain replacement for pasid, it needs
> to make the set_dev_pasid op support replacing domain and keep the old
> domain config in the failure case.
> 
> AMD iommu driver does not support domain replacement for pasid yet, so it
> would fail the set_dev_pasid op to keep the old config if the input @old
> is non-NULL.
> 
> Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> ---
>   drivers/iommu/amd/pasid.c | 3 +++
>   include/linux/iommu.h     | 3 ++-
>   2 files changed, 5 insertions(+), 1 deletion(-)

I would suggest merging this patch with patch 1/9.

Thanks,
baolu
