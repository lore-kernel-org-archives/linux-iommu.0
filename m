Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2C0628
	for <iommu@lists.linux.dev>; Thu,  9 Mar 2023 02:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678327747; x=1709863747;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h7L7WFI4DwTz9+2kCVoTF5JK2hgOIRTigia0Dllu/WQ=;
  b=CMjsMSrvN3AIUTSme8//WGLJILk+YML+A0IC0aLNFx5bIvPXvPX/j0Gl
   GplmjoaqHDC0VSLMPrC8aYVkj199gzRHEHLtAfgK3K0V/KAIvTMb7Sf3X
   7AB6vAZa6+AyVPPtj+TFahrKhaL9AlV5zKtcYFgSlqMmWEx3BiDex+hYE
   S3h6Nnwpz0JuaJz+jP3KU11+14JHWS2TlVDl/0/a4GdUTP8Y385rce6bX
   +mRrDeJv5Ncart59FoSrtb2TuVdmgdpL1eF3UgH5uznvSUPNY/yemPFIN
   nPNNiir8wRKZObZHOu5N1HeOjy12Wg3EbonSo3BVpFH/KYvbyvdABwQvT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="335036051"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="335036051"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 18:09:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="746132715"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="746132715"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga004.fm.intel.com with ESMTP; 08 Mar 2023 18:09:03 -0800
Message-ID: <c1c8cc6f-6553-e60d-838e-dfaf06e3e412@linux.intel.com>
Date: Thu, 9 Mar 2023 10:08:05 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Orson Zhai
 <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] iommu: sprd: release dma buffer to avoid memory leak
Content-Language: en-US
To: Chunyan Zhang <chunyan.zhang@unisoc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20230308034158.509458-1-chunyan.zhang@unisoc.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230308034158.509458-1-chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/8/23 11:41 AM, Chunyan Zhang wrote:
> Release page table DMA buffer when the IOMMU domain is not used:
> 
> - Domain freed.
> 
> - IOMMU is attaching to a new domain.
>    Since one sprd IOMMU servers only one client device, if the IOMMU has
>    been attached to other domain, it has to be detached first, that's
>    saying the DMA buffer should be released, otherwise that would
>    cause memory leak issue.
> 
> Signed-off-by: Chunyan Zhang<chunyan.zhang@unisoc.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
