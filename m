Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF7E10E5
	for <iommu@lists.linux.dev>; Fri, 30 Sep 2022 02:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664505215; x=1696041215;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Hdve1KlyAO6JRxScYXKJu8tB9KqUJZPyIUhA+f3vBxk=;
  b=KACl3q/B4aOnoek4zVHVeyL8wmVAt4K1Zrw0F5LWDFatwKw1uuJAho/g
   DwK8bMeLx+az0IuhdRYIPySwhOBHZSOWQKsSwvsH5O3JvsVX+DvYm9DMm
   5qLIh+X7QQoD1nNz07L5tInH11/fQ2KXop2xbLgzWSwT1Fao3qBTyFQys
   WZzloM3sj2QcFfsTKbldiPa7p9ZXMzStiaPRr8FhoAi5H8IBMENgNXylt
   lU79y06QQiDkiMFyK03+HHrK8QKsdSlvwsgYlpGtPY/DwGsEqSF2sgkGN
   U59/vpwK7Zqr3FsjJxMUEFJBZ3LQJrWmIBwzzqd2GvHryDTshhXoAYX2q
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="289246911"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="289246911"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 19:29:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="685106383"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="685106383"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 29 Sep 2022 19:29:16 -0700
Message-ID: <c1122131-6e93-2588-38a0-c404bc34f2c1@linux.intel.com>
Date: Fri, 30 Sep 2022 10:23:10 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iommu/vt-d: Fix lockdep splat in intel_iommu_init()
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20220927053109.4053662-1-baolu.lu@linux.intel.com>
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

A gentle ping. Any comments to this fix? It's better to work out a
feasible solution before the users keep complaining. :-)

Best regards,
baolu
