Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C80628
	for <iommu@lists.linux.dev>; Thu,  9 Mar 2023 02:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678327961; x=1709863961;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NuBmxgRDNL4Na0RMQuWBwVEo4HGT3XkCwSpqJn53O0w=;
  b=LuSEAbJLvgxAWCshBN6rxhhA9Q08U7In528VT6zsawvmzw7/3mrqa4H/
   oyuOzoBhl5aj21pJ+7qp0WaZJr0LwPykHel983Sh15hCaeTTOVGGtKSc6
   zhbc3FT7Cf6Vnfv8GULHnpJpN2e/ZeKV3uEGRWfZr+dDM//HqRrxi40y/
   MBw6kZ8VeagC5a7m47Ecf6isK9zlCK6ejmuasZDFTfvFRSazhPlgPc9Bj
   GFAr7NDrxjaEwtt0agpqe13FWS0BLcp3Y0e/C7O9bSIqi4rDR0Iqv5T3a
   j73vHNCYIJERMYoHY/WNagCysc1YZFVXFs0OL1zapKk6VTNx11a3kCAiG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="320161061"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="320161061"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 18:11:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="766240739"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="766240739"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Mar 2023 18:11:26 -0800
Message-ID: <efa3e59b-cb93-4519-0e3f-cf94b6788765@linux.intel.com>
Date: Thu, 9 Mar 2023 10:10:27 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, kernel test robot <lkp@intel.com>,
 Aditya Srivastava <yashsri421@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, Timur Tabi <timur@tabi.org>,
 Varun Sethi <Varun.Sethi@freescale.com>,
 Emil Medve <Emilian.Medve@Freescale.com>
Subject: Re: [PATCH] iommu/fsl: fix all kernel-doc warnings in fsl_pamu.c
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
References: <20230308034504.9985-1-rdunlap@infradead.org>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230308034504.9985-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/8/23 11:45 AM, Randy Dunlap wrote:
> Fix kernel-doc warnings as reported by the kernel test robot:
> 
> fsl_pamu.c:192: warning: expecting prototype for pamu_config_paace(). Prototype was for pamu_config_ppaace() instead
> fsl_pamu.c:239: warning: Function parameter or member 'omi_index' not described in 'get_ome_index'
> fsl_pamu.c:239: warning: Function parameter or member 'dev' not described in 'get_ome_index'
> fsl_pamu.c:332: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   * Setup operation mapping and stash destinations for QMAN and QMAN portal.
> fsl_pamu.c:361: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   * Setup the operation mapping table for various devices. This is a static
> 
> Fixes: 695093e38c3e ("iommu/fsl: Freescale PAMU driver and iommu implementation.")
> Fixes: cd70d4659ff3 ("iommu/fsl: Various cleanups")
> Signed-off-by: Randy Dunlap<rdunlap@infradead.org>
> Reported-by: kernel test robot<lkp@intel.com>
> Link:lore.kernel.org/r/202302281151.B1WtZvSC-lkp@intel.com
> Cc: Aditya Srivastava<yashsri421@gmail.com>
> Cc: Joerg Roedel<joro@8bytes.org>
> Cc: Will Deacon<will@kernel.org>
> Cc: Robin Murphy<robin.murphy@arm.com>
> Cc:iommu@lists.linux.dev
> Cc: Timur Tabi<timur@tabi.org>
> Cc: Varun Sethi<Varun.Sethi@freescale.com>
> Cc: Emil Medve<Emilian.Medve@Freescale.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
