Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B64187C
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 13:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680096653; x=1711632653;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TqdOVi+L9n1r521DUAYxD/rv1FUDMTs6EmVu75Rfxf0=;
  b=AOJWmDrxg1otmD/4SIcNHJIuRzHlOoXpqYpg9JGy+WkbEdhGdQLGblY5
   r2BGRDkeJ6hQN1K0Z5oh1ytVExfl+TC02I4gza/FuYmYht++8equ5QHbp
   Qcyi6khgwVHYOwRy5DhDJNkTxsHeNApgW3GQkz15MKWTYTCi1kK+DL+PM
   mnAk5nzrga5NNDRSp/CR92sCa57B59750J6jiUNtZmOFXJZTLoW4nAbwJ
   VVzlK9yv4/B9XAwjRo87mQBldeiKFrK+B+Y8lII8CX6gBOwbvnYEvZA7o
   2KeLVSx0DRzBANXQdpp/DtescOjO3Uz3xv6kDwHg4w3NfE9LT7LDaYtOw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="427149359"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="427149359"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:30:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="753579424"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="753579424"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.214.217]) ([10.254.214.217])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:30:51 -0700
Message-ID: <534e6556-40e8-82f7-b3f6-0d0ad67616c0@linux.intel.com>
Date: Wed, 29 Mar 2023 21:30:49 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc: baolu.lu@linux.intel.com, Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH 1/4] iommu/vt-d: Fix null pointer access in
 invalidate_range callback
To: Tina Zhang <tina.zhang@intel.com>, iommu@lists.linux.dev
References: <20230329124654.2698853-1-tina.zhang@intel.com>
 <20230329124654.2698853-2-tina.zhang@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230329124654.2698853-2-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/3/29 20:46, Tina Zhang wrote:
> Add the missing check to avoid null pointer dereference.
> 
> The patch fixes below issue reported by klocwork tool:
> Pointer 'info' returned from call to function 'dev_iommu_priv_get'
> at line 180 may be NULL and may be dereferenced at line 186.
> 
> This patch can fix a potential null pointer dereference issue of
> releasing a device working in svm mode.

The svm logic guarantees that __flush_svm_range_dev() only be called
after iommu_sva_bind_device() and before iommu_sva_unbind_device(). Thus
@info should never be NULL. There's no need to add this check.

Best regards,
baolu

> 
> Reported-by: Yongwei Ma <yongwei.ma@intel.com>
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>   drivers/iommu/intel/svm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 7367f56c3bad..837c1a4642e7 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -179,7 +179,7 @@ static void __flush_svm_range_dev(struct intel_svm *svm,
>   {
>   	struct device_domain_info *info = dev_iommu_priv_get(sdev->dev);
>   
> -	if (WARN_ON(!pages))
> +	if (WARN_ON(!info || !pages))
>   		return;
>   
>   	qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, address, pages, ih);

