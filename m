Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018761FD3
	for <iommu@lists.linux.dev>; Thu, 20 Apr 2023 04:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681964721; x=1713500721;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uGkJDuCA5roZl+Gwls4r+YKtHGHUCchxEOme/jljAmg=;
  b=dgHsPoXdjCnrHoiOZXN7UWQa3j9ZtSX+77SUDijF6LGsp/Cy90IlgM7z
   PgMiWJPQBZ2R8AoK4V5mH7vy5Uvtz0lErVfgLBYcgYZX60gj0mKzQ6mxa
   VfN5F6qz8UmMuzujspMCXWj3mYkGK7cp+XDpZrRk2fRR0R/DxAUZUyPXb
   96NGOehoB/TcWP5pnYX44m3H+JiAi7RCmz2NVDdHcm/Y1/5EZdZlfPEzF
   YiJuOXG5+oC50lc5INNORdS5pnXhUaL+AtXgyMOG0AeZBcbINd+VvnHzn
   4A/bF/slIbxUK7rjimtiOsNjTSy2WDI0rifDta6C7UR51PpZtMLhmR2o0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="347489827"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="347489827"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 21:25:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="760994039"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="760994039"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga004.fm.intel.com with ESMTP; 19 Apr 2023 21:25:16 -0700
Message-ID: <132ceb1f-4559-5a99-af47-1a86a677eae7@linux.intel.com>
Date: Thu, 20 Apr 2023 12:25:11 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 10/11] iommu: Split iommu_group_add_device()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
References: <10-v1-8aecc628b904+2f42-iommu_probe_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <10-v1-8aecc628b904+2f42-iommu_probe_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/20/23 12:11 AM, Jason Gunthorpe wrote:
> @@ -451,16 +454,17 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>   		goto out_unlock;
>   
>   	group = dev->iommu_group;
> -	ret = iommu_group_add_device(group, dev);
> +	gdev = iommu_group_alloc_device(group, dev);
>   	mutex_lock(&group->mutex);
> -	if (ret)
> +	if (IS_ERR(gdev)) {
> +		ret = PTR_ERR(gdev);
>   		goto err_put_group;
> +	}
>   
> +	list_add_tail(&gdev->list, &group->devices);

Do we need to put

	dev->iommu_group = group;

here?

>   	if (group_list && !group->default_domain && list_empty(&group->entry))
>   		list_add_tail(&group->entry, group_list);
>   	mutex_unlock(&group->mutex);
> -	iommu_group_put(group);
> -
>   	mutex_unlock(&iommu_probe_device_lock);
>   
>   	return 0;

Best regards,
baolu
