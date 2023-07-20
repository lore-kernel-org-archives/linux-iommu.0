Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AA73D99;
	Thu, 20 Jul 2023 06:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689833504; x=1721369504;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Sp/D0IoRlThT3xMqxSlsQoLksVxUt7yQUAZqjq0Puqs=;
  b=I6gwLudb1yPwqi40CZWkHIGyIfoknP8AQQPHTkKFMY+IscHw1C+PR1Wa
   w3YLzqaGVWrdePfuvrZ86EzqwIa6rxITimrTvDz9vQe3giX9bicFrgw5e
   PLD1JxYlpynCKOeaobPqjQOpYtM8kjt4IlM8EEaP+8iC7n6+v9Af9pVjw
   erHp5tLk7Q8DUSG7ZqNFrFx0+HmEPSGcTNb/TzurYyPmgrplNX4f9rMQO
   v1oyt4TK45He8Tr15fK+WHLd7+as+T+mkD0JEVS4eH1yBUYJCFcf1lHLx
   CuD54I7kELmZFa1LyVJh0PrinrT1JlwQtNzfCZvLiPCIj5tSVSWeSsoGj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="397516202"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="397516202"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 23:11:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="898170973"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="898170973"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.191.114]) ([10.252.191.114])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 23:11:36 -0700
Message-ID: <c7dd16ba-e4ab-b531-4a31-d310d1f943cc@linux.intel.com>
Date: Thu, 20 Jul 2023 14:11:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 01/10] iommu: Remove useless group refcounting
To: Jason Gunthorpe <jgg@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 David Woodhouse <dwmw2@infradead.org>, Heiko Stuebner <heiko@sntech.de>,
 iommu@lists.linux.dev, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Orson Zhai <orsonzhai@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
 Will Deacon <will@kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>
References: <1-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <1-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/7/19 3:05, Jason Gunthorpe wrote:
> Several functions obtain the group reference and then release it before
> returning. This gives the impression that the refcount is protecting
> something for the duration of the function.
> 
> In truth all of these functions are called in places that know a device
> driver is probed to the device and our locking rules already require
> that dev->iommu_group cannot change while a driver is attached to the
> struct device.
> 
> If this was not the case then this code is already at risk of triggering
> UAF as it is racy if the dev->iommu_group is concurrently going to
> NULL/free. refcount debugging will throw a WARN if kobject_get() is
> called on a 0 refcount object to highlight the bug.
> 
> Remove the confusing refcounting and leave behind a comment about the
> restriction.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
