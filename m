Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F3D64C;
	Thu, 20 Jul 2023 06:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689835189; x=1721371189;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q2420lO/67HLept/Ynkd6CkJPfVmitWqJ8oLR0JwEpg=;
  b=HYUlt8X2nr/i6/tFduvLNh9Hi6E0NF7teuEDVOtNatYMGN1Ca5/oEW7g
   WtJPWJOxVYtYZDdlWO9rjT+xho3FxnbWtQYQJX/aBr50g1c9ZONNQ7KEw
   d+rrZYrq+vOWbkea/rr2h6QLyZ+kLT2LkZyB6qrec5XDX0rxp2PKMliSB
   CbaFy91ODVWl8qFjajDcXuJp+zfqq+R5voejcfQHhjyMcO5sJoypD0G9C
   4DarO+k+HcW6coIlvslNDEKWID8Am26DwX2vHUVkgC5w7SzZzQJ3igHbS
   5LVh3SXIaQNYXsBl6Ts2O5qp7I2Cd6dwHR19pK0X0H96GMDA0Yw7P3bCP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="369302166"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="369302166"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 23:33:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="701510991"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="701510991"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.191.114]) ([10.252.191.114])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 23:33:04 -0700
Message-ID: <ea1d5d22-cf91-de8c-5d31-0959765a56b8@linux.intel.com>
Date: Thu, 20 Jul 2023 14:33:00 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 02/10] iommu: Add a lockdep assertion for remaining
 dev->iommu_group reads
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
References: <2-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <2-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/7/19 3:05, Jason Gunthorpe wrote:
> The remaining reads are all in functions called under ops->device_group.
> 
> Broadly these functions are walking around the device tree (eg going up
> the PCI bus tree) and are trying to de-duplicate group allocations
> according to their logic.
> 
> Since these functions don't hold any particular per-device locks their
> reads to dev->iommu_group are being locked by the caller's
> iommu_probe_device_lock, and this explains why iommu_probe_device_lock
> needs to be a global lock.
> 
> Rename iommu_probe_device_lock to dev_iommu_group_lock, make it local to
> the module and annotate all the device_group helpers with
> iommu_group_get_locked() that includes a lockdep to indicate that they are
> special.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
