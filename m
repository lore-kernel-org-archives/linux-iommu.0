Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214A4174DA;
	Thu, 20 Jul 2023 09:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689846990; x=1721382990;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=04cRS58otusgNog6qUGU0l9UCsLobYH5YmKv9H67S/4=;
  b=Tuye7rhePvcE5l4bj85Vr6NOk8KPuc2syjPTMlesnhZNfG3LfhaTP3cu
   x9pDFh2W/0DKrC+tKt3ear7bQfS6e3s5Tk7AZ/9MN2YIH+Ct5dftMEw7f
   l1kthFYrwq8Ocfint+18yN7rPorgs9w9kSSDCupDc0tmwDIEvT20sZM92
   5IrzaA/GvPsm8Jo512SrZyg+cr4Et3KB+f0Mwbqi3Cvcny61q8ue1MRRI
   5eDAsnwwSsnkIe2sDh7XmiglpxVOOH+ZmGhvyAQaDVLOEq4QOnN9Nd/Ng
   vbWy9CM84alpOBy2cG2aUK5mPvWVxyPbyok7fTz0j00GammRdloFQxkb9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="430457023"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="430457023"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 02:56:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="724329685"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="724329685"
Received: from kechengh-mobl.gar.corp.intel.com (HELO [10.252.191.109]) ([10.252.191.109])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 02:56:21 -0700
Message-ID: <d7e38f1f-00ba-5d86-3295-fd74f1a461a5@linux.intel.com>
Date: Thu, 20 Jul 2023 17:56:18 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 10/10] iommu/intel: Fix missing locking for
 show_device_domain_translation()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 David Woodhouse <dwmw2@infradead.org>, Heiko Stuebner <heiko@sntech.de>,
 iommu@lists.linux.dev, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Orson Zhai <orsonzhai@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
 Will Deacon <will@kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>
References: <10-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <10-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/7/19 3:05, Jason Gunthorpe wrote:
> This is called from bus_for_each_dev() and must lock the device before
> calling iommu_group_get().
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
