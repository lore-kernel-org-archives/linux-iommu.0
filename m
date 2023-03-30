Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E59F1C05;
	Thu, 30 Mar 2023 06:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680158744; x=1711694744;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UD6xKhK18vCA1GM5zVFX4AuWTlEus36ykX89c8krd+8=;
  b=draopZMEnbA7u9dMFatniilejEh5XoTjTfO4dtFa+9YcTXRivfwLaug5
   hobzW+j6bIPWgAMP1pOz+pLQ153RLFgdpyMj6uGcMzas1MdnhfyX1vApt
   Yu4QZ5Y9K8s+BKPLEdLdnvjSbDS2QEGEpV/P6bqlR03sim00cq3DLKeXw
   0xqD0x0y4/hiVDoelcM6XU4h0C2MsNHYXMxCoj2MfDBgRpYgwp1zIXKGf
   VUjOGcUAkMW5K5ILjkDHVsl0bpNSp5eFTEho4HabCwPftRPaq7L4IGP1K
   bACUnJG6Tqwi6O92YNWLPxv/KS9qXfaBEPb/y2T/DKwepb9fEHwSpwWdx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="320736745"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="320736745"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 23:45:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="808516064"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="808516064"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga004.jf.intel.com with ESMTP; 29 Mar 2023 23:45:40 -0700
Message-ID: <0c1c42ee-240f-d1a7-416f-4d9b6040f32a@linux.intel.com>
Date: Thu, 30 Mar 2023 14:45:56 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 08/14] iommu: Make iommu_group_do_dma_first_attach()
 work with owned groups
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
 Will Deacon <will@kernel.org>
References: <8-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <8-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/30/23 7:40 AM, Jason Gunthorpe wrote:
> If the group is already owned then defered attach should not be done and
> the device should be directly connected to the correct domain.
> 
> Owned means that some driver is already bound to devices in the group and
> is operating the group possibly without DMA API support. In this case
> there would be no way to correct the mismatched domain.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
