Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF56A1C30
	for <iommu@lists.linux.dev>; Wed, 19 Oct 2022 00:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666140948; x=1697676948;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VeJU0AZOxxlPIjiKFRtl8GqedRXYSUZSRdBVzt7wm9Q=;
  b=NoL26Tb5fTxoF4waN5MCBiRKA6OtuWIW74DkpmG6XHld+8ppq+WBznGh
   PEB1JZwIMqEhHCCpqaKOdohy874QSs5tNkfeg+nPYBMVVSwJrCDfaTZh+
   +0kloN+2nJt7BKwHe5wUEfYxUYg0uRYIYfr3Izbp5Xljnj5YBy9Vr+oN0
   6LW+7xgbuAgXW3LwQsBzDE/GrWYRgFaGHEjuXB7fDkULd3+3BNf/XMDtM
   pZ9Q/c1ycvcwhL0VuPEkBkA37N+GdIwzB0o3B8ALuvLC7kNVLF0HGExRh
   P/QL0EiV0wpGyp8nvMiv2IboUCOUhVp7r1Ogxxeefms2UylVXsII4f8uc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="370492859"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="370492859"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 17:55:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="660077816"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="660077816"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 18 Oct 2022 17:55:46 -0700
Message-ID: <e0901d59-ab0a-fb05-221a-8376e741e22b@linux.intel.com>
Date: Wed, 19 Oct 2022 08:49:19 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iommu/vt-d: Fix lockdep splat in intel_iommu_init()
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20220927053109.4053662-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220927053109.4053662-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/22 1:31 PM, Lu Baolu wrote:
> Hi folks,
> 
> As commit c919739ce472 ("iommu/vt-d: Handle race between registration
> and device probe") highlights, a lockdep splat issue happens after
> moving iommu probing device process into iommu_device_register().
> 
> This is due to a conflict that get_resv_regions wants hold the
> dmar_global_lock, but it's also possible to be called from within a
> section where intel_iommu_init() already holds the lock.
> 
> Historically, before commit 5f64ce5411b46 ("iommu/vt-d: Duplicate
> iommu_resv_region objects per device list"), the rcu_lock is used in
> get_resv_regions. This commit converted it to dmar_global_lock in order
> to allowing sleeping in iommu_alloc_resv_region().
> 
> This aims to fix the lockdep issue by making iommu_alloc_resv_region()
> available in critical section and rolling dmar_global_lock back to rcu
> lock in get_resv_regions of the Intel IOMMU driver.
> 
> Best regards,
> baolu
> 
> Lu Baolu (2):
>    iommu: Add gfp parameter to iommu_alloc_resv_region
>    iommu/vt-d: Use rcu_lock in get_resv_regions

Patches has been queued for v6.1.

https://lore.kernel.org/linux-iommu/20221019004447.4563-1-baolu.lu@linux.intel.com/

Best regards,
baolu
