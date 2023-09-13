Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEB5803
	for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 02:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694572914; x=1726108914;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Pgc2D+3zfvkfmv8fkBy8k8iJeoSXz10wKKf+lnbUSZQ=;
  b=AF5K1yQFbLZaUdq/hPxHnPZolUGhRc8nZSvWTaBR25VQWCbt9GnEKB8Z
   gbmaSi/gKCxNReoKObHse5ffbISVIP3m8tgFGioKCbJXS88Ach1/YU+Z3
   Fa+wi3+CkrE8A+NJyb8Za22Ae4D4H7Xip4gc2I0rb617UeguSf/TrxGlL
   mwzigGcY4kbhRCAzySMk+FqrnBEVUpHTyePJ+YbKKotdEY2arbY7QEtwJ
   uFZehm4PI6Xv1iBSSpcFmcdbeb72+5SEgB3uVJLYkkC61e0Q7djVZJ2uF
   hX1iwFgn4ENU66qVNDXY+UtO3mVV5kAZBLxEp29PKLNYbsOBjTDCere0s
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="464917152"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="464917152"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 19:41:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="743946569"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="743946569"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga002.jf.intel.com with ESMTP; 12 Sep 2023 19:41:27 -0700
Message-ID: <e2eeda9e-2a9e-67ae-cd36-6e312346c0ba@linux.intel.com>
Date: Wed, 13 Sep 2023 10:38:29 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, Michael Shavit <mshavit@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] mm: Add structure to keep sva information
Content-Language: en-US
To: Tina Zhang <tina.zhang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>
References: <20230912125936.722348-1-tina.zhang@intel.com>
 <20230912125936.722348-5-tina.zhang@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230912125936.722348-5-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/23 8:59 PM, Tina Zhang wrote:
> Introduce iommu_mm_data structure to keep sva information (pasid and the
> related sva domains). Add iommu_mm pointer, pointing to an instance of
> iommu_mm_data structure, to mm.
> 
> Reviewed-by: Vasant Hegde<vasant.hegde@amd.com>
> Signed-off-by: Tina Zhang<tina.zhang@intel.com>
> ---
>   include/linux/iommu.h    | 5 +++++
>   include/linux/mm_types.h | 2 ++
>   2 files changed, 7 insertions(+)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
