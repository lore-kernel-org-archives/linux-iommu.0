Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28F0627
	for <iommu@lists.linux.dev>; Fri, 16 Jun 2023 02:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686881768; x=1718417768;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fU0lLudBphp5iZvj7Ivutn5Srt0z2bVmbg0LGVBVbGM=;
  b=KcmFYZie+CyPbRtoaDBNcQ7RcQ+BLg7SCSnko96c79DAAI9IHfuygvFE
   JdpKdT/4tc4h8UZP6y7sHcQmejh9O3kafPMslDpI3miZiFpBHgyvtS4Pz
   3ycDaLDKXcFxr/5gJU7lcklyfKvDG6NO4XaFeFXgJdGZ4pSctzT6xw8Z9
   mEvQo6KzZfgSc0Hi4bdrV4y16Q+tN3rCZE3bq9v8bxp40+aL8+ioUGxiB
   d/4yo/1IwzZpuPx06g8khak6NP6c1LtPweRmK/MJxOI+3YWonRJSbDID8
   hL8y39mMCl19Q98muh5AuOTWGshFXCjoecCcOw3ke0O11WcUebtaL6IpX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="343833745"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="343833745"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 19:16:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="1042909682"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="1042909682"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jun 2023 19:16:03 -0700
Message-ID: <ecdf9b68-ed90-9d8b-12e8-46e77c456890@linux.intel.com>
Date: Fri, 16 Jun 2023 10:14:53 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Venkata Rao Kakani <quic_vkakani@quicinc.com>,
 Vagdhan Kumar <quic_vagdhank@quicinc.com>
Subject: Re: [PATCH] iommu: export iommu_set_default_translated function
Content-Language: en-US
To: Anvesh Jain P <quic_ajainp@quicinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20230615093308.24989-1-quic_ajainp@quicinc.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230615093308.24989-1-quic_ajainp@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/15/23 5:33 PM, Anvesh Jain P wrote:
> export iommu_set_default_translated function to be used by other modules.
> 
> Signed-off-by: Anvesh Jain P <quic_ajainp@quicinc.com>
> Signed-off-by: Venkata Rao Kakani <quic_vkakani@quicinc.com>
> Signed-off-by: Vagdhan Kumar <quic_vagdhank@quicinc.com>
> ---
>   drivers/iommu/iommu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f1dcfa3f1a1b..1b4a5db58d66 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2730,6 +2730,7 @@ void iommu_set_default_translated(bool cmd_line)
>   		iommu_cmd_line |= IOMMU_CMD_LINE_DMA_API;
>   	iommu_def_domain_type = IOMMU_DOMAIN_DMA;
>   }
> +EXPORT_SYMBOL_GPL(iommu_set_default_translated);

Exporting a symbol without using it is meaningless. It is better to
export and use it in a single series.

Additionally, there is a restriction on the use of this helper. Calling
it after the iommu probe has no effect.

>   
>   bool iommu_default_passthrough(void)
>   {
> 
> base-commit: b6dad5178ceaf23f369c3711062ce1f2afc33644

Best regards,
baolu
