Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0B938DDB
	for <iommu@lists.linux.dev>; Tue,  5 Nov 2024 03:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730776028; cv=none; b=dN44SxyN3xFsmwERhN2lioSqUvKyGORUsR0MWLOIB0NGV9W5+nCb2ebSkcUoFvDwqCz91h5SKNhfYcDNs+14Fq0LsNyL2kQEn+A7nZIRcYMzTUcm4408sGSCKijiPESw2ynR4OdNKuR6G6gCgOkyaX/LWuCd536c382o6xeh+uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730776028; c=relaxed/simple;
	bh=8pXKTVFA8LgS+0Ocy9l4HvZh0WSPKIy49BvQvdC0UPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EsLVAP7HVg3XOsph+fEwag0oB7TSE5jFUPF84tEXKnbzm/PF8fBoMzjlk1AxnU7Pfnk219HCfpsR66+EtTa2ruFbcHxNdyrAJYRfaTK5MV2TmjHPHcfqZDuTG3MMxfVGhOHlOkiZi5Ley6Gc4ecwJoF9GuL2Z3g01UG+/IOktL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YDgSeFxE; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YDgSeFxE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730776025; x=1762312025;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8pXKTVFA8LgS+0Ocy9l4HvZh0WSPKIy49BvQvdC0UPA=;
  b=YDgSeFxEjpq/oxvKoqT1WUrW+PomoVIrfgJqCjmu7/JSvZ+laeoVOf8Y
   mjiVRtE++jsCNNmKyj4CLfinKU2f31bb/r8TfVqlwERkx86OenSGG1Q9g
   KO8QCzoRxHuKl8oEthQp2Kcl7M0XI0Cuyc0o2Jdi4w3am1QrB/mzy7+bX
   pjJq7q2Y9P15ysU8WRAjw47yZA2Mx0TH7xLG0EtROUawvQZrqGt4T1t4P
   CL8mvu5csO+ukFjr86/rK35XR+PvjgYzIDUP2cEDBox95jSA7h/6ZWhGt
   Db9mMPLQ1hUYigcetGpxJAk+QNEAhP1a05EiJqDXzrXBs6gnRgsn2Op/J
   A==;
X-CSE-ConnectionGUID: 9aVSI8skQyqmI501XkXAWA==
X-CSE-MsgGUID: gwV7hQkHS6GL13e1v5ey1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="48011796"
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="48011796"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 19:07:04 -0800
X-CSE-ConnectionGUID: H7/ww4ZYTHK2DVvSeNCSvQ==
X-CSE-MsgGUID: VAYgeQMxQwyMTONcalVUjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="88608043"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 19:07:02 -0800
Message-ID: <855e1d0a-3e6a-4aaa-934b-f939695dba2b@linux.intel.com>
Date: Tue, 5 Nov 2024 11:06:15 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/13] iommu/vt-d: Consolidate the dev_pasid code in
 intel_svm_set_dev_pasid()
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 kvm@vger.kernel.org, chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
 zhenzhong.duan@intel.com, vasant.hegde@amd.com, will@kernel.org
References: <20241104131842.13303-1-yi.l.liu@intel.com>
 <20241104131842.13303-10-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241104131842.13303-10-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/24 21:18, Yi Liu wrote:
> Use the domain_add_dev_pasid() and domain_remove_dev_pasid().
> 
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/iommu.c |  6 +++---
>   drivers/iommu/intel/iommu.h |  6 ++++++
>   drivers/iommu/intel/svm.c   | 28 +++++++---------------------
>   3 files changed, 16 insertions(+), 24 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
