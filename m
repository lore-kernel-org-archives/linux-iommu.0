Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD50367
	for <iommu@lists.linux.dev>; Tue, 28 Jun 2022 12:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656419966; x=1687955966;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xH+zDbWm9NnK+jA1wnqDI01ZjKwfPCHuUTs1IQUIh5U=;
  b=TVysiuiO+Mca+KsjGPgEgnbvBmp5Rqd04eu6tVi8zKnrdwDOxswIz4+7
   sG4bvgkIPPL9M5mjwd7SVlii1FoFX+jV5iZUfW9276DDxPoqL6ZtjjNQe
   miQwfOMWyZjYGBuIRMfqj4V9wRLVCRLYLkeVPTJzAFO5gJ8XGT3cUAL5W
   V9NSh05dRAjSvoYJXdNpQaO1NjaCZidtZKH4wDmpDYDObfcDnSEj8Y6Pz
   JZNSfpiwXc0szcYZpC8mKx8uUhuVCyvtSFU1UsPSZyx9N3PlW+QDVPtg/
   cf9BfKW9QREyfewbO/TbiC6ViWGYKPtqiPVOFlXn6kFE9laVe/Y2vEc8H
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="368041587"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="368041587"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 05:39:08 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646897670"
Received: from ltang11-mobl1.ccr.corp.intel.com (HELO [10.249.169.64]) ([10.249.169.64])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 05:39:05 -0700
Message-ID: <e311ead5-776b-ad71-5ad9-98f9ab6e569a@linux.intel.com>
Date: Tue, 28 Jun 2022 20:39:04 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
 Jerry Snitselaar <jsnitsel@redhat.com>, Mike Travis <mike.travis@hpe.com>,
 Dimitri Sivanich <sivanich@hpe.com>, Russ Anderson <russ.anderson@hpe.com>,
 iommu@lists.linux.dev, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/6] iommu/vt-d: Reset DMAR_UNITS_SUPPORTED
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>, Steve Wahl <steve.wahl@hpe.com>,
 Kevin Tian <kevin.tian@intel.com>
References: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID: <20220628123904.GZ72bnjf3a0tNzMzmE9YkzMaTHSswpXrtbqyHZJZPak@z>

On 2022/6/25 20:51, Lu Baolu wrote:
> Hi folks,
> 
> This is a follow-up series of changes proposed by this patch:
> 
> https://lore.kernel.org/linux-iommu/20220615183650.32075-1-steve.wahl@hpe.com/
> 
> It removes several static arrays of size DMAR_UNITS_SUPPORTED and sets
> the DMAR_UNITS_SUPPORTED to 1024.
> 
> Please help review and suggest.

This series is also available on github:

https://github.com/LuBaolu/intel-iommu/commits/vtd-next-for-v5.20

Best regards,
baolu

> 
> Best regards,
> baolu
> 
> Lu Baolu (6):
>    iommu/vt-d: Remove unused domain_get_iommu()
>    iommu/vt-d: Use IDA interface to manage iommu sequence id
>    iommu/vt-d: Refactor iommu information of each domain
>    iommu/vt-d: Add VTD_FLAG_IOMMU_PROBED flag
>    iommu/vt-d: Remove global g_iommus array
>    iommu/vt-d: Make DMAR_UNITS_SUPPORTED default 1024
> 
>   include/linux/dmar.h        |   6 +-
>   drivers/iommu/intel/iommu.h |  29 ++++--
>   drivers/iommu/intel/dmar.c  |  33 ++-----
>   drivers/iommu/intel/iommu.c | 188 ++++++++++++++----------------------
>   drivers/iommu/intel/pasid.c |   2 +-
>   drivers/iommu/intel/svm.c   |   2 +-
>   6 files changed, 103 insertions(+), 157 deletions(-)
> 

