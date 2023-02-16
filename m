Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3903017D7
	for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 02:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676515599; x=1708051599;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f4N1SzHki54gzC9bI+cSq31GTJao9kbgTePjVLn/Hb0=;
  b=j94/tLCsk1SdxW4jgCuOhfCyrB/d/5kp0V/6/YN6g9yD64LYlE+ibdWn
   Zeef4WszmiEboBYN9XketY8vV8SxhzvTt+UAKY+jpVIZpAVDOs1IRq8ha
   vzUgnp3Iq592floblDficbU099wu8ojy3go3706XqXMLR5vhOzbWzKCko
   QVUbJm7lap62ucNihl+94QVZsMed8ryzDR+3ur53G9GPJpRkK9wRvIlsl
   431vWqimYHjADPLfS/mtOXyYCucgBxGnmI/ZniuUUAc9uccrlMX20eVo0
   1EjDeSceorNSlhIHgkY8fdU2dZCkPEDX7LV8dKpRWW7iMFn29AZp29bwI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="319661078"
X-IronPort-AV: E=Sophos;i="5.97,301,1669104000"; 
   d="scan'208";a="319661078"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 18:46:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="812795596"
X-IronPort-AV: E=Sophos;i="5.97,301,1669104000"; 
   d="scan'208";a="812795596"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 15 Feb 2023 18:46:34 -0800
Message-ID: <1cf45b73-1685-5eea-a894-8282eea019ac@linux.intel.com>
Date: Thu, 16 Feb 2023 10:38:11 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, Bharat Bhushan <bharat.bhushan@nxp.com>,
 Eric Auger <eric.auger@redhat.com>, Joerg Roedel <jroedel@suse.de>,
 Olof Johansson <olof@lixom.net>,
 Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
 Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] iommu: Fix error unwind in iommu_group_alloc()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>
References: <0-v1-8f616bee028d+8b-iommu_group_alloc_leak_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <0-v1-8f616bee028d+8b-iommu_group_alloc_leak_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/16/23 9:21 AM, Jason Gunthorpe wrote:
> If either iommu_group_grate_file() fails then then the iommu_group

iommu_group_create_file()

> is leaked.
> 
> Destroy it on these error paths.
> 
> Found by kselftest/iommu/iommufd_fail_nth
> 
> Fixes: bc7d12b91bd3 ("iommu: Implement reserved_regions iommu-group sysfs file")
> Fixes: c52c72d3dee8 ("iommu: Add sysfs attribyte for domain type")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Other look good to me.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/iommu.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index dd9b60897c8673..e41c9df1504ba3 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -775,12 +775,16 @@ struct iommu_group *iommu_group_alloc(void)
>   
>   	ret = iommu_group_create_file(group,
>   				      &iommu_group_attr_reserved_regions);
> -	if (ret)
> +	if (ret) {
> +		kobject_put(group->devices_kobj);
>   		return ERR_PTR(ret);
> +	}
>   
>   	ret = iommu_group_create_file(group, &iommu_group_attr_type);
> -	if (ret)
> +	if (ret) {
> +		kobject_put(group->devices_kobj);
>   		return ERR_PTR(ret);
> +	}
>   
>   	pr_debug("Allocated group %d\n", group->id);
>   
> 
> base-commit: c643eb52cb7c1f6747ddc60d8a187a3ca0746a12
