Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2484A2A
	for <iommu@lists.linux.dev>; Wed,  3 May 2023 06:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683095560; x=1714631560;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e5swZYwhebmaWxsOicAhkmAZGeGkAWyKrW2zu6S4FRg=;
  b=GttYtMBdILImotpP7wlw4asna1U3dfSnUCtB3WJfeTCU+g9MN6mjgSv9
   VIbKNtwL+j3JwNtb3H3suYot9RtNdP4m3agLYX+lc1O2dPRO0fwgCtCjI
   5LB7RY/mn0EpgOmpB0Ol0XR88bJfK+zPwiWCEACHUgNnELeJYfYqf1J6u
   ZmSeqe71Oq7c5LGlJhiJOuCxj9bgM9YkrvGLTa6Nql+yCHsUw93bmk5uP
   /L/EQk27LqDzWh1POzrzBYJoZBzSyeAPrJqHYejONRRTYaNYJvKGPW917
   cNaJE/4e4IQUw2Fqvm9k2Biqkw45atyKUj728551Z2WUu2vhw4/aUyscb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="347397787"
X-IronPort-AV: E=Sophos;i="5.99,246,1677571200"; 
   d="scan'208";a="347397787"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 23:32:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="646805690"
X-IronPort-AV: E=Sophos;i="5.99,246,1677571200"; 
   d="scan'208";a="646805690"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga003.jf.intel.com with ESMTP; 02 May 2023 23:32:35 -0700
Message-ID: <db3be8a2-6520-9652-6bee-dbceb320cfc2@linux.intel.com>
Date: Wed, 3 May 2023 14:32:15 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Raj Ashok <ashok.raj@intel.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 "Yu, Fenghua" <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Tony Luck <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 narayan.ranganathan@intel.com
Subject: Re: [PATCH v5 3/7] iommu: Move global PASID allocation from SVA to
 core
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org, vkoul@kernel.org
References: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
 <20230427174937.471668-4-jacob.jun.pan@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230427174937.471668-4-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/28/23 1:49 AM, Jacob Pan wrote:
> +ioasid_t iommu_alloc_global_pasid_dev(struct device *dev)
> +{
> +	int ret;
> +	ioasid_t max;
> +
> +	max = dev_iommu_get_max_pasids(dev);

Perhaps you can use dev->iommu->max_pasids. It's static, so no need to
recalculate it.

> +	ret = ida_alloc_range(&iommu_global_pasid_ida, IOMMU_DEF_RID_PASID + 1, max, GFP_KERNEL);
> +	if (ret < 0)
> +		return IOMMU_PASID_INVALID;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_alloc_global_pasid_dev);

Best regards,
baolu
