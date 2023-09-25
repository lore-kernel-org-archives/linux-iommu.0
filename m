Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5977215B0;
	Mon, 25 Sep 2023 02:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695609015; x=1727145015;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=38lEStwphX64OpE2A2DbRTLCtqjQh1vzpQGGTEpXLCk=;
  b=nRdjH2JMUjRmbDjIN3a7v0l5XovMXCgIJzhPrn4Iik5TA2cPV+ihbGwX
   Q20OV2F1fF9YIGk/6wHPRLF1VsOb0Q8wxnUQNQ8BZN0TyiQ+XGK5HYH5n
   3wQtZtkrIIRNUHmp+ktaLS19IfUmxOSCewqq+xAEew+TQ3Ac0w6UUICjh
   PgbQzID7RgcLr2uTmQC8Kt+A51V9w1s6o/Scsp/pTD2DxWhr4rByDt5TB
   w1cMAfPWYwkh4EbLXoiC7WGki/QpiUnikC+j4wXApKURYwgC1poA1WwA0
   3pxMUiP6+sZDwcWxEY6IRc0bDsS3DeqKhC50WcOnkYmGTmz4SDYJpHd89
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="380026686"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="380026686"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 19:30:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="741746070"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="741746070"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga007.jf.intel.com with ESMTP; 24 Sep 2023 19:30:08 -0700
Message-ID: <4c3bc724-e162-98d7-1ecd-0ed8950bbb34@linux.intel.com>
Date: Mon, 25 Sep 2023 10:26:54 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: baolu.lu@linux.intel.com
Subject: Re: [PATCH 1/8] iommu: Move IOMMU_DOMAIN_BLOCKED global statics to
 ops->blocked_domain
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Alyssa Rosenzweig
 <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Hector Martin <marcan@marcan.st>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Sven Peter <sven@svenpeter.dev>, Will Deacon <will@kernel.org>
References: <1-v1-8060f06462cc+c0a39-dart_paging_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <1-v1-8060f06462cc+c0a39-dart_paging_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/23 1:07 AM, Jason Gunthorpe wrote:
> Following the pattern of identity domains, just assign the BLOCKED domain
> global statics to a value in ops. Update the core code to use the global
> static directly.
> 
> Update powerpc to use the new scheme and remove its empty domain_alloc
> callback.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> ---
>   arch/powerpc/kernel/iommu.c | 9 +--------
>   drivers/iommu/iommu.c       | 2 ++
>   include/linux/iommu.h       | 3 +++
>   3 files changed, 6 insertions(+), 8 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
