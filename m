Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E24EA1
	for <iommu@lists.linux.dev>; Thu, 31 Aug 2023 02:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693449924; x=1724985924;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GvqqUn/QYIsd9Wy6pXz11sbZ+wHEshiG1oiKNfieeGo=;
  b=FB40op/cS1dHjaRAkY5RhAua/5GSniOSkoac84DuN6RwPM782U4ZmgUW
   wq5KvNcPI5NQifM0unVNHOTPhjnKYgZgfABv3rZiqVdHQe95nScwJfv3e
   B1LZEuD+/iCh58Gp2ifUoF8gup9fVnD9LQ8YcK6cQhI4RQ73z2RoSZb3A
   xTqNuqCq2Ay8RI0Dvwbg0TlWPnnOtcDH9a4YeUrGCd4PIVzcEdx1s7xAw
   OaSJzyQ6RVJvXJpzuKDlnF2yHX0k0LHC6xmLztBIfJypr+X/EJ7S62QLU
   XZbIjbDEIYiadfrE+dN0h5rka396pnP6NRf+HLVhSipU9o7bg7s6pXUF3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="355294608"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="355294608"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 19:45:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="716148213"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="716148213"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.87]) ([10.254.210.87])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 19:45:20 -0700
Message-ID: <92bceb62-b33f-2380-9229-af9634b12c95@linux.intel.com>
Date: Thu, 31 Aug 2023 10:45:17 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] mm: Add structure to keep sva information
Content-Language: en-US
To: Tina Zhang <tina.zhang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Michael Shavit <mshavit@google.com>
References: <20230827084401.819852-1-tina.zhang@intel.com>
 <20230827084401.819852-4-tina.zhang@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230827084401.819852-4-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/27 16:43, Tina Zhang wrote:
> Introduce iommu_mm_data structure to keep sva information (pasid and the
> related sva domains). Add iommu_mm pointer, pointing to an instance of
> iommu_mm_data structure, to mm.
> 
> Signed-off-by: Tina Zhang<tina.zhang@intel.com>
> ---
>   include/linux/iommu.h    | 5 +++++
>   include/linux/mm_types.h | 2 ++
>   2 files changed, 7 insertions(+)

Nit:

iommu also has a per-device private pointer, it's defined as struct
dev_iommu and stored at dev->iommu. Is it valuable to align both?

Best regards,
baolu
