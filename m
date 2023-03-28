Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37D97F0
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 04:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679979313; x=1711515313;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7t8HEByj4cLff00VoXO0IFf+83/zzmjcbsLyOg5ScbM=;
  b=j74m1kgki+jpG51XDQT4N24mE42p7CeooTzR2bzKQ5rP3FqLSau0jpgS
   jC7ePsSM+H8LK4gba3W/kn91TzOV++MLrA9TAvkswNN9PYe1RKfIrbbE2
   vM6SbaVik6OP4i/hWsUUW8OOHuNt0/9+FF6by1q8FFhs/0cm1MNT5tyyw
   0tepuFqH0rnG1w7mYYZ168l4qQdKoeueUm4ta0PYl/zm2gvOb7kccMjcR
   gUNrbvgUJXw5p/sIjvFKMOmqr6YHpqsFzAazSnhuCEueSrj6GxfIpywfu
   tbpz3nx6sFJcHFKz8lfms09GqkcN4Hunj9d9cAfahzYfnK8k26Si4UmDm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="337974779"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="337974779"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 21:55:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="1013395525"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="1013395525"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga005.fm.intel.com with ESMTP; 27 Mar 2023 21:54:57 -0700
Message-ID: <8839763d-8a40-caad-4048-0d335fb3beb9@linux.intel.com>
Date: Tue, 28 Mar 2023 12:55:16 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Raj Ashok <ashok.raj@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Tony Luck <tony.luck@intel.com>,
 "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH v2 1/8] iommu/vt-d: Use non-privileged mode for all PASIDs
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
 Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 dmaengine@vger.kernel.org, vkoul@kernel.org
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
 <20230327232138.1490712-2-jacob.jun.pan@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230327232138.1490712-2-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/23 7:21 AM, Jacob Pan wrote:
> Supervisor Request Enable (SRE) bit in a PASID entry is for permission
> checking on DMA requests. When SRE = 0, DMA with supervisor privilege
> will be blocked. However, for in-kernel DMA this is not necessary in that
> we are targeting kernel memory anyway. There's no need to differentiate
> user and kernel for in-kernel DMA.
> 
> Let's use non-privileged (user) permission for all PASIDs used in kernel,
> it will be consistent with DMA without PASID (RID_PASID) as well.
> 
> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
