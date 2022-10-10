Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B60D7E
	for <iommu@lists.linux.dev>; Mon, 10 Oct 2022 11:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665401578; x=1696937578;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VOeaJcpwzZJ0pJxWdJglMMEshugCfS9igKMdjRFdHpY=;
  b=C52qzo0tFL6FCISVQMbN7RXdKNXvUirsUmc1u9RE4mFUE9qjAz6INbc7
   jJxcwN/lDEJ9d4eDrZO/Hu+WvDD2KC0/4VnYxfxsRU+pn+pLNZHhhTlg3
   Tl9zUQhRMYLR8yk1RUZNbu35C9p7itIIo4YZne/1arjF2ssI9OlDqmaHT
   PWkEm5v+Byb09DJIgYCs5p52D2aCkMrdRUX3F/UBs0CeNW1Z36FOJJIVY
   KzZrBeeqw3v09X1swbl4kDCCrWu/2+vu3NENY8H6okGQc2f5iY+jGboXv
   RSLo2g5jgjHL1Z+0Uvv954ufdWt/XvYGADV281Lu6gM3thUY3Mj4dMaVn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="301812631"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="301812631"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 04:32:47 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="688754888"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="688754888"
Received: from jbai-mobl.ccr.corp.intel.com (HELO [10.254.211.42]) ([10.254.211.42])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 04:32:45 -0700
Message-ID: <35cf84fb-7672-671a-4354-0fb66bd2f8e7@linux.intel.com>
Date: Mon, 10 Oct 2022 19:32:43 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/vt-d: Clean up si_domain in the init_dmars() error
 path
To: Jerry Snitselaar <jsnitsel@redhat.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20221010065608.281860-1-jsnitsel@redhat.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20221010065608.281860-1-jsnitsel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/10/10 14:56, Jerry Snitselaar wrote:
> A splat from kmem_cache_destroy() was seen with a kernel prior to
> commit ee2653bbe89d ("iommu/vt-d: Remove domain and devinfo mempool")
> when there was a failure in init_dmars(), because the iommu_domain
> cache still had objects. While the mempool code is now gone, there
> still is a leak of the si_domain memory if init_dmars() fails. So
> clean up si_domain in the init_dmars() error path.
> 
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Fixes: 86080ccc223a ("iommu/vt-d: Allocate si_domain in init_dmars()")
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> ---
>   drivers/iommu/intel/iommu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 31bc50e538a3..8f1f80a4d0c5 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3042,6 +3042,8 @@ static int __init init_dmars(void)
>   		disable_dmar_iommu(iommu);
>   		free_dmar_iommu(iommu);
>   	}
> +	if (si_domain)
> +		domain_exit(si_domain);

Thank you for the patch.

Above requires si_domain to be NULL or a valid pointer. So do you also
need to add the following change?

--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2410,6 +2410,7 @@ static int __init si_domain_init(int hw)

         if (md_domain_init(si_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
                 domain_exit(si_domain);
+               si_domain = NULL;
                 return -EFAULT;
         }

Best regards,
baolu
