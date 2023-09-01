Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA1F15A6
	for <iommu@lists.linux.dev>; Fri,  1 Sep 2023 03:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693537554; x=1725073554;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZzXYA1V6PpYaMUXnnXqgHItAdZIgoY/oUFS+CWsU6+I=;
  b=E1eMgkKpOre646GwQiZkQUncRUtsyJF0OzjlCprtPEMq93WGWg+hUS76
   Bwy805J5caga5eNVvsIrZYBSD9KpF3XVCRdOAOv/nqoPEYbacB5Z5P3gF
   QHrUsBeBQ0ylaWwFWywpnYTir3NNw2qAm71MG5NP9vv/wxnd0JpV+C+1A
   EZWbo20c7y/2LM7tqkY3th99hAKqO/FS6ZmHaMXIKRRgtN2HUgbcj5T2P
   iwDIvS/EZIfHmhCjz7vYrgDy0YtHWMKAbjNVzGmpmWr0eT775TScxWFfQ
   0OzrUMC/SNZ2wUA7N8NQlnTptVCJxvzjm+hUhAqlSrynkxK+3YmmxA70O
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="407118327"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="407118327"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 20:05:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="1070577731"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="1070577731"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.30.41]) ([10.255.30.41])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 20:05:50 -0700
Message-ID: <8830ecd1-f7a3-a708-66b1-2d9698d0d477@linux.intel.com>
Date: Fri, 1 Sep 2023 11:05:48 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Cc: baolu.lu@linux.intel.com
Subject: Re: [PATCH] iommu/tegra-smmu: Fix the NULL vs IS_ERR() bug for
 debugfs_create_dir()
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, linux-tegra@vger.kernel.org,
 iommu@lists.linux.dev, Thierry Reding <thierry.reding@gmail.com>,
 Krishna Reddy <vdumpa@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jonathan Hunter <jonathanh@nvidia.com>
References: <20230831123846.3137304-1-ruanjinjie@huawei.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230831123846.3137304-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/31 20:38, Jinjie Ruan wrote:
> The debugfs_create_dir() function returns error pointers.
> It never returns NULL. So use IS_ERR() to check it.
> 
> Fixes: d1313e7896e9 ("iommu/tegra-smmu: Add debugfs support")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   drivers/iommu/tegra-smmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index e445f80d0226..cd1d80c4c673 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -1056,7 +1056,7 @@ DEFINE_SHOW_ATTRIBUTE(tegra_smmu_clients);
>   static void tegra_smmu_debugfs_init(struct tegra_smmu *smmu)
>   {
>   	smmu->debugfs = debugfs_create_dir("smmu", NULL);
> -	if (!smmu->debugfs)
> +	if (IS_ERR(smmu->debugfs))
>   		return;

There is no need to check the return value of debugfs_create_dir(). This
change cannot fix anything as far as I can see. Just remove the check.

>   
>   	debugfs_create_file("swgroups", S_IRUGO, smmu->debugfs, smmu,

Best regards,
baolu
