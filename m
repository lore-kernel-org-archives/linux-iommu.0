Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6158C1C31;
	Thu, 30 Mar 2023 07:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680161625; x=1711697625;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wgmXKrWyV+ZaQtnT22iUmCDNKpB6Z71mVipcjiRZs48=;
  b=Bncri9Ay05BiXO7ynQP9XKVEynNmkSehlpCq9jbAobIU0bN/jrgOBbEu
   pAht2GJxvY/l5X3N9iEQiOaxBmkZog8RsxLF7xmgp9jrnFvvjO6NdEPeu
   HP/opPxpAkxer/6yDqoD1oLUYcpt02IJ5Dt3DcATxr9DuVLIpj4lTJGWn
   iswxWbO1Wgp9obMNzlQzs3Fe07WMUKEZqrPTgQQWxGD358B7AH0cKICTW
   oBi/9y11b2KMRS2ZpCd2TY1M+/vS/aTnXZMYEnRtgDndLPQR+m+/PWfEr
   BIF+Gzl45hiHSmt4bozf/pY/AeStSh03NO+LonHCUtb9eJcQc92Y2H8pc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="320744843"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="320744843"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 00:33:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="687134081"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="687134081"
Received: from ztang3-mobl6.amr.corp.intel.com (HELO [10.255.30.251]) ([10.255.30.251])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 00:33:29 -0700
Message-ID: <7d97591a-a783-2315-35ee-65160bfdaf0f@linux.intel.com>
Date: Thu, 30 Mar 2023 15:33:28 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 10/14] iommu: Remove the assignment of group->domain
 during default domain alloc
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
 Will Deacon <will@kernel.org>
References: <10-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <10-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/3/30 7:40, Jason Gunthorpe wrote:
> group->domain should only be set once all the device's drivers have
> had their ops->attach_dev() called. iommu_group_alloc_default_domain()
> doesn't do this, so it shouldn't set the value.
> 
> The previous patches organized things so that each caller of
> iommu_group_alloc_default_domain() follows up with calling
> __iommu_group_set_domain_internal() that does set the group->domain.
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
