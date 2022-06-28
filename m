Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F217E367
	for <iommu@lists.linux.dev>; Tue, 28 Jun 2022 05:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656395198; x=1687931198;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TGG80vJaDllAevuk4S1BcXyz1JoWpznRrkuX2d/Mvkc=;
  b=hCS1Z/YKPh15yNpB+x1XkLl5LxSWkeGzJyiuOjmoBmzSuIxEohOS81Ej
   21bULGUK1qqni7lUfFw2s6xmGLZ6bua9IQct5rcHE5+vN54gydMLvnu28
   Hhq0vSik6Wmg3pDIPApj037Cdv1DM6X00TYCC9TReiS8tuX0ZhIz66mpF
   ADsBJgrJ62lSh4KK3yFRMMSZTz7mVajgVVvMySMClmQYYDrCSOozznr75
   X+PHPOkBDdMkmEcBx7mR3wm2ZvCA7dr14z+rMpyFLYsKFdncpgfyak4yr
   8Efshi4I06X7ojDIap9o/rvBhF6EBvc2dTvCmww/t8yFFfx6HeeSGHxa8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="270388145"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="270388145"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 22:46:37 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646759897"
Received: from ltang11-mobl1.ccr.corp.intel.com (HELO [10.249.169.64]) ([10.249.169.64])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 22:46:34 -0700
Message-ID: <14fa06b8-e361-db68-8fe4-490aeb0242da@linux.intel.com>
Date: Tue, 28 Jun 2022 13:46:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc: baolu.lu@linux.intel.com, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
Subject: Re: [PATCH v9 06/11] arm-smmu-v3/sva: Add SVA domain support
Content-Language: en-US
To: Zhangfei Gao <zhangfei.gao@linaro.org>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-7-baolu.lu@linux.intel.com>
 <9266198d-33fd-4cc5-fdaa-3ba5571543b1@linaro.org>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <9266198d-33fd-4cc5-fdaa-3ba5571543b1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID: <20220628054632.w2p5VFgAFI2fSTGiNUdRbtTIVGJP2Q4FLcYPxESB9fo@z>

On 2022/6/27 19:50, Zhangfei Gao wrote:
> 
> On 2022/6/21 下午10:43, Lu Baolu wrote:
>> Add support for SVA domain allocation and provide an SVA-specific
>> iommu_domain_ops.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Have tested the series on aarch64.

Thank you very much! Very appreciated for your help!

Best regards,
baolu
