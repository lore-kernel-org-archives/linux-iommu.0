Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD751866
	for <iommu@lists.linux.dev>; Wed, 31 May 2023 03:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685503672; x=1717039672;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TYMzU74WAhBotOE3c77ui6pPmq/ocGmpdHVCBH4pbX4=;
  b=PjSvsr0k112D4vkPS7G89FtXqV0KQRUPrV+qp3bbCozf3bexWxzVrLvX
   QAwzHgXugh/iBGbp7psilfvMWxUaawxOQZTcgco3yCDKn0cu3605K/gDU
   GtJIVba8tvGaxom4PITcgpkCJnYX7UtCRpQ3bSqazoEkFRpojuPcFAP3L
   iPdU02sNnJf7ny5ssLTAkY2U3QUzpUc/GtJNHESj/mdx+JJdPpG3uOajr
   cciHjcpyCSUareAGn+Osc+OlBcf+i/GMS/Zboc+0EdinqKqx166qn0O0E
   Mh5wxHvjzYRUPWBEQj6svej+o8ZwMgcZeJcisuECqvdefYbh5LZ/99KHe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="339715116"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="339715116"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 20:27:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="831049681"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="831049681"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga004.jf.intel.com with ESMTP; 30 May 2023 20:27:49 -0700
Message-ID: <3e75f9de-4c67-93aa-9fb4-28da9849dd48@linux.intel.com>
Date: Wed, 31 May 2023 11:26:55 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/vt-d: Use BUG_ON to check NULL value of 'table'
Content-Language: en-US
To: Yanfei Xu <yanfei.xu@intel.com>, dwmw2@infradead.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com
References: <20230530092503.152926-1-yanfei.xu@intel.com>
 <20230530092503.152926-3-yanfei.xu@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230530092503.152926-3-yanfei.xu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/30/23 5:25 PM, Yanfei Xu wrote:
> Checking NULL value of 'table' variable deserves a BUG_ON as the
> following code will trigger a crash by dereferencing the NULL
> 'table' pointer. Crash in advance with BUG_ON to avoid WARN_ON
> plus NULL pointer dereferencing can simplify the crash log.
> 
> Signed-off-by: Yanfei Xu<yanfei.xu@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index e98f1b122b49..8aa3bfdb7f95 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1944,7 +1944,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
>   	if (sm_supported(iommu)) {
>   		unsigned long pds;
>   
> -		WARN_ON(!table);
> +		BUG_ON(!table);

BUG_ON() is not recommended. Perhaps,

		if (!table)
			-ENODEV;

?

Best regards,
baolu
