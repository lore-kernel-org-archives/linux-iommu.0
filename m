Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E12F15C6
	for <iommu@lists.linux.dev>; Fri, 31 Mar 2023 03:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680233245; x=1711769245;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Fcx8FyvHsYPvovBDCbTWifOO8wc9SaAyk43k8G86Opg=;
  b=oFmDDu4cUYsTrrMFkmYzlM8mUiYxidSX0wL44i4rYZ35GwOknfHVfcK0
   MwGcq2Y1tikngmm6p8GZWcBOdFkkhafglzdvgDKrrUcJbN3MwSY7OpGyB
   nUZw9tpZ4+luo0xbfHFm46ycO9QJiujigz/X+vn/pJM2/k8bO2QcQEvdw
   Isb9LFb3rHBS3snH9ifQeC5bvs3Vsq9Lzs3zDysxEbtBTCVGjnvn2VisK
   6PEUbrKCwfkJmq8Abf+TBbO/tjS604g7FrfzVBqIszPINDqcAw5mzvqol
   jmjeHdMp6W5EYAc0y+rbRZt9goI/hDR2MBZPBNU0E6diDmL9KbrDoxkXB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="320995366"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="320995366"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 20:27:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="717558043"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="717558043"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga001.jf.intel.com with ESMTP; 30 Mar 2023 20:27:22 -0700
Message-ID: <74239dba-34c7-e565-a293-16e022523f4c@linux.intel.com>
Date: Fri, 31 Mar 2023 11:27:38 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com
Subject: Re: [PATCH v2 7/7] iommu/vt-d: Remove BUG_ON in
 dmar_insert_dev_scope()
Content-Language: en-US
To: Tina Zhang <tina.zhang@intel.com>, iommu@lists.linux.dev
References: <20230331024236.2716001-1-tina.zhang@intel.com>
 <20230331024236.2716001-8-tina.zhang@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230331024236.2716001-8-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/31/23 10:42 AM, Tina Zhang wrote:
> The dmar_insert_dev_scope() could fail if any unexpected condition is
> encountered. However, in this situation, the kernel should attempt
> recovery and proceed with execution. Remove BUG_ON with WARN_ON, so that
> kernel can avoid being crashed when an unexpected condition occurs.
> 
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>   drivers/iommu/intel/dmar.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 9684c96247f8..7eceee081235 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -262,7 +262,8 @@ int dmar_insert_dev_scope(struct dmar_pci_notify_info *info,
>   						   get_device(dev));
>   				return 1;
>   			}
> -		BUG_ON(i >= devices_cnt);
> +		if (WARN_ON(i >= devices_cnt))
> +			return -EINVAL;

You have returned an error number. Do you still need a WARN_ON()?

>   	}
>   
>   	return 0;

Best regards,
baolu
