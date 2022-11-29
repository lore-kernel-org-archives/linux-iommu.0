Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C197C
	for <iommu@lists.linux.dev>; Tue, 29 Nov 2022 02:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669688543; x=1701224543;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tbc+ZueGykxDbF9jnsj+Z1gJ1TR24nDwb3s1ZF8qrDE=;
  b=c+pNgdZtXdSyn+Z8xuK5+S54AlMh1SjGuJq52Cbc9r4wuS0/yCQMTWA+
   B5glfJlaJ2qgSGUFsNq+ZVXIqGWEIp7y3R3k44i/KX+SfKXvBxHtheqZc
   vCsToVAnvg/+ILmuoEEwRK+D5iuUu1At4kQVIKfM19mNVJtOKP20cD+gq
   0V63tBcE9q5SRiJDGEsnBnhcTSU2ocecd4+KO0M2bfdOKwW9c3ezV64qv
   O9t0BREWVLUk6mbI9Rk6Y9SPwM2fgl/wd320I3Wb0NhhkEqitolJcr4uH
   BJrdhrC+kh7PJzEYGCz+DLCxKo4U4d9DDW34cQFmko0nNUNuGWDwm1OHY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="312630484"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="312630484"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 18:22:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="594094969"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="594094969"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga003.jf.intel.com with ESMTP; 28 Nov 2022 18:22:15 -0800
Message-ID: <777eb770-7db2-0cb8-876e-67d86abffa42@linux.intel.com>
Date: Tue, 29 Nov 2022 10:15:03 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Rob Clark <robdclark@gmail.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Thierry Reding <thierry.reding@gmail.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/20] iommu: Add set_platform_dma iommu ops
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
 <20221128064648.1934720-11-baolu.lu@linux.intel.com>
 <Y4TBng2SY0eGE7wx@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y4TBng2SY0eGE7wx@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/28/22 10:11 PM, Jason Gunthorpe wrote:
> On Mon, Nov 28, 2022 at 02:46:38PM +0800, Lu Baolu wrote:
>> When VFIO finishes assigning a device to user space and calls
>> iommu_group_release_dma_owner() to return the device to kernel, the IOMMU
>> core will attach the default domain to the device. Unfortunately, some
>> IOMMU drivers don't support default domain, hence in the end, the core
>> calls .detach_dev instead.
>>
>> This adds set_platform_dma iommu ops to make it clear that what it does
>> is returning control back to the platform DMA ops.
>>
>> Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   include/linux/iommu.h | 4 ++++
>>   1 file changed, 4 insertions(+)
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> 
>> + * @set_platform_dma: Returning control back to the platform DMA ops. Only
>> + *                    valid for IOMMU drivers which don't support default
>> + *                    domain.
> I would add:
> 
>    This op is to support old IOMMU drivers, new drivers should use
>    default domains, and the common IOMMU DMA ops.

Done. Thank you!

Best regards,
baolu
