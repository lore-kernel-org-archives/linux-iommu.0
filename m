Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2267A31
	for <iommu@lists.linux.dev>; Mon, 22 May 2023 01:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684719880; x=1716255880;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6SOQe/1i7ESxVfMLC7Q050UYtfAJ+dtZJDKbqpBo6mk=;
  b=FaXsD22ORN2/zJVFVoQSXaTJJAQ1UJxtDeTtChFcUzGONn0N+YfM/Bnj
   J7B6Fxex6iTX9L5sg6TZKmox/Vrf+jSE60AWhXRClAh/6C3C0lUqZlibq
   vph9IBUANm2O6MfNm/2b3hR73rrsPegmw3eDn9U+pMuJlV16i+7ZLJN0S
   rZqsOaOhUm+6vHSluSB9QAtOsnD8apJI0xhI1e6pTCe5QMvt3LhHV+ZTA
   rE8wcA7ZfSDZtXNXdW7g+0OalLqnxdHG266uYRQIhewjxvF+RZ3d3LOQp
   91A2KRUJvaNZmRvL2KaNNBYbmdCM9LPMS0tFDltx6kbpviw7qFjSaV09S
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="355149110"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="355149110"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 18:44:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="736237888"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="736237888"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 21 May 2023 18:44:37 -0700
Message-ID: <eab789ac-89e4-2159-bd4e-c281f0e4b39b@linux.intel.com>
Date: Mon, 22 May 2023 09:43:57 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 08/10] iommu: Always destroy the iommu_group during
 iommu_release_device()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, David Woodhouse <dwmw2@infradead.org>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
References: <8-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <8-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/23 2:42 AM, Jason Gunthorpe wrote:
> Have release fully clean up the iommu related parts of the struct device,
> no matter what state they are in.
> 
> Split the logic so that the three things owned by the iommu core are
> always cleaned up:
>   - Any attached iommu_group
>   - Any allocated dev->iommu and its contents including a fwsepc
>   - Any attached driver via a struct group_device
> 
> This fixes a minor bug where a fwspec created without an iommu_group being
> probed would not be freed.
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
