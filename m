Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D73C603C
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 01:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657072426; x=1688608426;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cllxWuAAFHFoBQ2YHklsc1bQWN4Ue9DGBlCsCLtMYVY=;
  b=DqdcywRBAMvxMouIMH4yS/vJ25gUizGRlA5XXGarFK3DH4GuOsrQxZHp
   hNsyKv3yfoWDrKnsj0FuaTHQ/2vfaXtAZ1ibldoPtdOxc90Qi32nBIQWh
   qJiOlpBXYwgXHk8Iy1yYCblScjSQjlI70GS+vhWLMYcsWGZiU9hb/PC/8
   LiKgHK1H1ODtk0xpx29bO4jR60MCFSRPV6a+hOpod/dx58wa4MSxLFy8Z
   WRItjMv/vjhjwKNLzQAfKNGh7layD4dO6IRHeLJXpKhxbkzC1sHDPMxwT
   wGzjAWtEXnZhHXjsFa6lorc7iDr9UZmu17cBujz7aqKKjhHMtxjXiAZO9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="283639474"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="283639474"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 18:53:45 -0700
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="650433945"
Received: from zhuoliu-mobl1.ccr.corp.intel.com (HELO [10.249.174.206]) ([10.249.174.206])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 18:53:42 -0700
Message-ID: <1fab4c8a-7bc5-9a50-d48a-0dc590cac7a6@linux.intel.com>
Date: Wed, 6 Jul 2022 09:53:40 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc: baolu.lu@linux.intel.com, will@kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, suravee.suthikulpanit@amd.com,
 vasant.hegde@amd.com, mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
 schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/15] iommu: Always register bus notifiers
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
References: <cover.1657034827.git.robin.murphy@arm.com>
 <8c380309f264cd0dfc73ba2ec060adc9515af2f2.1657034828.git.robin.murphy@arm.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <8c380309f264cd0dfc73ba2ec060adc9515af2f2.1657034828.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/7/6 01:08, Robin Murphy wrote:
>   /*
>    * Use a function instead of an array here because the domain-type is a
>    * bit-field, so an array would waste memory.
> @@ -152,6 +172,10 @@ static int __init iommu_subsys_init(void)
>   			(iommu_cmd_line & IOMMU_CMD_LINE_STRICT) ?
>   				"(set via kernel command line)" : "");
>   
> +	/* If the system is so broken that this fails, it will WARN anyway */

Can you please elaborate a bit on this? iommu_bus_init() still return
errors.

> +	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++)
> +		iommu_bus_init(iommu_buses[i]);
> +
>   	return 0;

Best regards,
baolu
