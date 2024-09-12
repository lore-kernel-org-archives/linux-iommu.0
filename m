Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AA91A2645
	for <iommu@lists.linux.dev>; Thu, 12 Sep 2024 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147327; cv=none; b=ZP/YnhA7bzS0Yh/NLI/d6F3lM+g0K1a3H/xIFSsW9ZNNS0W9S8C6ARryn6BZvD0HTQ90dICpjENlwsLIVVDOmybSB8zcX8tqM8t/FTZKsFqtPTZ44KqMweZZshDkmi4bK7pjCJ7da4Lz4ZYqDFdQJADPhWLwKB7JQBkL86wEPbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147327; c=relaxed/simple;
	bh=MdqbgFBVMAvbKkIASOdv9K0wTHBtWRES3QTJEJacpoM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fMHTivF/TkeGD0ymi+II50mSp2q6C525Y7SUQaGLUWS3uC4uTEhBLUp0TwYJutVgwMCmLwnAP6uMZTFLAsIk80HoiXJC4bRzcVSiQjjsPvJrIvH1kxyU1Y5DgXxZBocvjtJfiJ0vMhCbuTiKPmRfsjlxBMrO4pwkxv80EEHqFTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AHx14bf5; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AHx14bf5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726147326; x=1757683326;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MdqbgFBVMAvbKkIASOdv9K0wTHBtWRES3QTJEJacpoM=;
  b=AHx14bf5bO+lI3CUkBNp/FaGdqtD07zLL8LPU1OsLv3ALpJQwcF5E/ck
   CF7DGw05+6wcaWRgFvEg50Psa/u6kZ8ngpA1HoFtdng8fK/67sfvJkKYl
   07fBdFU80UwvAUMuPyDrLnAepa9R99UmrvVIDHLse6/F163mS9PKE/uWG
   MdGfWxRgXtX+cfAa7bqkGvNYRhWmymQxdewv+ycQAN2cU8ZKRQUFGPebJ
   7c3MW4AtW6ERldNqDn945va6szIGbxDVFPJDv+w/lIgKW06mWYx04VR+z
   l0LP0a/wdhvpy1NIRT3FPn7uyn8uFgWQIDrD9y0dH9ddv0wGfeSiLXMUV
   g==;
X-CSE-ConnectionGUID: WcJB64MZRACx2arMlx9xQw==
X-CSE-MsgGUID: IJ/eHPJ/Sqa8z/sNbmlQlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="36345279"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="36345279"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 06:22:06 -0700
X-CSE-ConnectionGUID: GX4NjLEqR3ulhz4L6aHU6Q==
X-CSE-MsgGUID: z5/foyD8TpGamSWwEZ6ltQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67630900"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.239.20]) ([10.124.239.20])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 06:22:03 -0700
Message-ID: <5244f1fb-6e25-46f5-a6b6-9509de231374@linux.intel.com>
Date: Thu, 12 Sep 2024 21:22:00 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, alex.williamson@redhat.com,
 eric.auger@redhat.com, nicolinc@nvidia.com, chao.p.peng@linux.intel.com,
 iommu@lists.linux.dev, zhenzhong.duan@intel.com,
 linux-kselftest@vger.kernel.org, vasant.hegde@amd.com
Subject: Re: [PATCH v2 2/6] iommu/vt-d: Move intel_drain_pasid_prq() into
 intel_pasid_tear_down_entry()
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
References: <20240912130427.10119-1-yi.l.liu@intel.com>
 <20240912130427.10119-3-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240912130427.10119-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/12 21:04, Yi Liu wrote:
> Draining PRQ is mostly conjuncted with pasid teardown, and with more callers coming,
> move it into it in the intel_pasid_tear_down_entry(). But there is scenario that only
> teardown pasid entry but no PRQ drain, so passing a flag to mark it.

Is it a reasonable case where PRI needs to be drained but the pasid
entry won't be torn down? For example, could this happen when a PRI is
disabled?

> 
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/iommu.c |  8 ++++----
>   drivers/iommu/intel/pasid.c | 13 +++++++++++--
>   drivers/iommu/intel/pasid.h |  8 +++++---
>   drivers/iommu/intel/svm.c   |  3 ++-
>   4 files changed, 22 insertions(+), 10 deletions(-)

Thanks,
baolu
