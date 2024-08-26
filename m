Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DC210F7
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724677761; cv=none; b=EpRGuV/I8bBAVwvYxrQaWXoF+Hz9BcIfpg97iXu4M5ExWFLODoxUhynpf9fLSO7XINal4o6Y4QmhCGg6UP1nHHFiCUUZX4566qSqLC9XDWpZTSMfmRYR+/0EN8EEXxICkg9Bg835hizZQHdcaYx9nbB1u6xeB6H13o7MIguAsnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724677761; c=relaxed/simple;
	bh=krS2VaBppneILM7gfTnfx3OVkr1ELQSKXTwWYy1xhHk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XOcnBf0Xk2nOQAxX+ovQG0nDK//zk/bciDdMSE8tUq5r4d2WgpYZVykNciqCnElOnnR6wyb/FyhVdNtsO0jAD+xiMh/hbOPxfnzhPnD637ESSid7+fp4CVgwSOycnsqu50tUfULu54ejGuMjzKa/icFSr26Yyc88GcnO7BlrGaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zzurg8pP; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zzurg8pP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724677761; x=1756213761;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=krS2VaBppneILM7gfTnfx3OVkr1ELQSKXTwWYy1xhHk=;
  b=Zzurg8pPFz8Wky8wa5bWjdiJC3rMjkGbUlHp0yIH6tzjB2WB02/NAtcX
   2DIaESX4LQUnOt1YR8Hg7LCnI9q8RAh9AUYbgV1qT4uVbCV4iXGeC44AQ
   cU0uy9pTVwbPf0InNLuVbR1qeu+00p4WNyU5KzU+Md4YAzfVqGDt61Atw
   cwXXuWEUkGbj9jAz/ch3giDaeGUK5H6pd9hzToZwrHM98Ngb8+sutZuvw
   fwdr3qMRhO/pvqrmHG8KDMN75quZ5WOiDRBrgI8h1vRGF4f/YFQJPjVrz
   VYgd8rPpawp/U5QxGU2r5J5eA3SvNNzPB1qAxVLrgXKhdGaJms/mIsvy4
   Q==;
X-CSE-ConnectionGUID: SV57LA4YR0OM832aYvkTlQ==
X-CSE-MsgGUID: sNW8/jQgQeOiHe1KNrP3cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23279049"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="23279049"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 06:09:20 -0700
X-CSE-ConnectionGUID: H9y2qJELRqC22Fs7EA7Qvg==
X-CSE-MsgGUID: D+EWo81qTsqNgvuS/BZTzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="62476930"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.238.251]) ([10.124.238.251])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 06:09:17 -0700
Message-ID: <242056a5-9d16-415a-9913-0add5b050f47@linux.intel.com>
Date: Mon, 26 Aug 2024 21:09:14 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Minwoo Im <minwoo.im@samsung.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 Joel Granados <j.granados@samsung.com>, Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH RFC PREVIEW 1/6] iommu/vt-d: Separate page request queue
 from SVM
To: Klaus Jensen <its@irrelevant.dk>, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>
References: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>
 <20240826-iopf-for-all-v1-1-59174e6a7528@samsung.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240826-iopf-for-all-v1-1-59174e6a7528@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/26 19:40, Klaus Jensen wrote:
> From: Joel Granados<j.granados@samsung.com>
> 
> IO page faults are no longer dependent on CONFIG_INTEL_IOMMU_SVM. Move
> all Page Request Queue (PRQ) functions that handle prq events to a new
> file in drivers/iommu/intel/prq.c. The page_req_des struct is made
> available in drivers/iommu/intel/iommu.h.
> 
> No functional changes are intended. This is a preparation patch to
> enable the use of IO page faults outside the SVM and nested use cases.
> 
> Signed-off-by: Joel Granados<j.granados@samsung.com>
> ---
>   drivers/iommu/intel/Makefile |   2 +-
>   drivers/iommu/intel/iommu.c  |  18 +--
>   drivers/iommu/intel/iommu.h  |  40 +++++-
>   drivers/iommu/intel/prq.c    | 290 ++++++++++++++++++++++++++++++++++++++++
>   drivers/iommu/intel/svm.c    | 308 -------------------------------------------
>   5 files changed, 331 insertions(+), 327 deletions(-)
> 
> diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
> index c8beb0281559..d3bb0798092d 100644
> --- a/drivers/iommu/intel/Makefile
> +++ b/drivers/iommu/intel/Makefile
> @@ -1,6 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_DMAR_TABLE) += dmar.o
> -obj-$(CONFIG_INTEL_IOMMU) += iommu.o pasid.o nested.o cache.o
> +obj-$(CONFIG_INTEL_IOMMU) += iommu.o pasid.o nested.o cache.o prq.o
>   obj-$(CONFIG_DMAR_TABLE) += trace.o cap_audit.o
>   obj-$(CONFIG_DMAR_PERF) += perf.o
>   obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o

Thanks for the patch! Now that IOPF is separate from SVA, the Kconfig
needs to be updated accordingly.

diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index f52fb39c968e..2888671c9278 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -15,6 +15,7 @@ config INTEL_IOMMU
         select DMA_OPS
         select IOMMU_API
         select IOMMU_IOVA
+       select IOMMU_IOPF
         select IOMMUFD_DRIVER if IOMMUFD
         select NEED_DMA_MAP_STATE
         select DMAR_TABLE
@@ -51,7 +52,6 @@ config INTEL_IOMMU_SVM
         depends on X86_64
         select MMU_NOTIFIER
         select IOMMU_SVA
-       select IOMMU_IOPF
         help
           Shared Virtual Memory (SVM) provides a facility for devices
           to access DMA resources through process address space by

Thanks,
baolu
