Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2AE631
	for <iommu@lists.linux.dev>; Mon,  3 Apr 2023 05:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680500954; x=1712036954;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vor67KSJsSE/cFZlx1ZQmjpR2d2MNGp4HgZXneBuAcQ=;
  b=VpOkUtkJjvT0FZCtUMjtz/dz9EoHcSGu3HfNogheSS9msqKVp5RCJirH
   mWhIKh84I7DvBHH+DLPoFihX5xK8XjW1XgA/I9ro7rJdk2nX3fS0an9wZ
   f4saZISUx7qk9acyju03hH3Ys/z7s8tI0dakr6jkijdgSEUm4HJTPX0c+
   w3l7TwCtIb4LqSwrMYv75O8nadozsURtZ9WObDR70QtVjQBzlLD46MnH5
   6tvJn4/Sn90QBz1iboIaZ+HvNqCmfstUm9htCdUSGFqm1Yp6J7RD2Q70S
   frtvnIhnPDbXQ7nIIyDh911YzOUaG0W5NpI0fByOv86Gf2NEMl+v2DgEP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="428103272"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="428103272"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2023 22:49:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="718413118"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="718413118"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga001.jf.intel.com with ESMTP; 02 Apr 2023 22:49:08 -0700
Message-ID: <f6445aed-bf35-7245-3d52-336ebe11a866@linux.intel.com>
Date: Mon, 3 Apr 2023 13:49:22 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dmaengine: idxd: Add enable/disable device IOPF
 feature
Content-Language: en-US
To: iommu@lists.linux.dev, dmaengine@vger.kernel.org
References: <20230324120234.313643-1-baolu.lu@linux.intel.com>
 <20230324120234.313643-2-baolu.lu@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230324120234.313643-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/24/23 8:02 PM, Lu Baolu wrote:
> The iommu subsystem requires IOMMU_DEV_FEAT_IOPF must be enabled before
> and disabled after IOMMU_DEV_FEAT_SVA, if device's I/O page faults rely
> on the IOMMU. Add explicit IOMMU_DEV_FEAT_IOPF enabling/disabling in this
> driver.
> 
> At present, missing IOPF enabling/disabling doesn't cause any real issue,
> because the IOMMU driver places the IOPF enabling/disabling in the path
> of SVA feature handling. But this may change.
> 
> Reviewed-by: Dave Jiang<dave.jiang@intel.com>
> Reviewed-by: Fenghua Yu<fenghua.yu@intel.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>

Hi Dave and Fenghua,

The following iommu patches depends on this one. Can I route it to
Linus through the iommu tree?

Best regards,
baolu
