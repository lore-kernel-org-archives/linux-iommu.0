Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31CD1FD3
	for <iommu@lists.linux.dev>; Thu, 20 Apr 2023 04:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681964607; x=1713500607;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XukRQffyaLcurPj0MIxT2KBrbiwJQ4mOpE0STVWyGKg=;
  b=kg9MvWlZ+sJM/C5DnJp2P9LI0Zv1AdInC0yPWCKVMffHPt5rL/TDzw61
   IQdGQRbeN71JnHVIsYMwZE2mieH18DTlxLPyx3d48vYxO3vNl45p8OWpJ
   ryrco3KJ08bZTpCquNu7d3dfPTDH5mljfO4LhfdnHev9J2+RJ/SVU+XGV
   yToH28IYG3CWMiIQZsMXtbTdODmS6eC8i7r8liokRoOvVmVt/K+JORqfL
   EWnjYeVaXJ+Nqqi7RZaiOuxW0sl1zxjQoEsZLvQSRe/P88qQxF1cVDXs+
   pmbEzAWxh6GVYq9EYQUIYA3CRMF5QSmQazv/bKLjA17ujQpsWtsWDrFW3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="345630235"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="345630235"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 21:23:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="781099157"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="781099157"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Apr 2023 21:23:15 -0700
Message-ID: <da60a120-e1dd-3b61-d6c4-ba0d955e2339@linux.intel.com>
Date: Thu, 20 Apr 2023 12:23:11 +0800
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
Subject: Re: [PATCH 08/11] iommu: Always destroy the iommu_group during
 iommu_release_device()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
References: <8-v1-8aecc628b904+2f42-iommu_probe_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <8-v1-8aecc628b904+2f42-iommu_probe_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/20/23 12:11 AM, Jason Gunthorpe wrote:
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index dbaf3ed9012c45..a82516c8ea87ad 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -569,7 +569,6 @@ static void __iommu_group_remove_device(struct device *dev)
>   			dev->iommu_group = NULL;
>   		goto out;

Nit, given that below line has been removed, can above simply be a
loop break?

>   	}
> -	WARN(true, "Corrupted iommu_group device_list");
>   out:
>   	mutex_unlock(&group->mutex);

Best regards,
baolu

