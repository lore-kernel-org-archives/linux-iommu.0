Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F515C98;
	Mon, 14 Aug 2023 07:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691996443; x=1723532443;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EaawVzEhamol9o/NUQ5Jv/MrePZQM2J7gDQCUGCqzz4=;
  b=UKdRc5Q6n9InwkqV/AKC9JznvwUrz6JwXOnoDsbtRXN//jzFuGTLP5zH
   rNMqnIZiHIzbTX9moiSBgHPAuv0wbxlX5EJuTMsHTxXAGNKDYWhsbqTOG
   QDq4azGzWrxbtJG0b2uoxRagvInULiuU3lfFcAEo5sz39Vl750s/kG1vb
   +JfSYvacFNeYXy5yKgLapHjkupB3xRmR55ZVtCXETzguog1yJCzPhsnYl
   Vx4t9afvpGO+lEucXX4vGFQhetOMB3o6WPGLmxXM+V7n6zvfx4jdSencx
   +nJDBRdRcq1XQshoYWT6ErZ5bmXr0s3jQIEbZ2dM7xvrvaInvWWsSLJ0y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="402961381"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="402961381"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 00:00:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="1063959613"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="1063959613"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.215.205]) ([10.254.215.205])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 00:00:31 -0700
Message-ID: <f6999029-9f94-9198-ce1d-2d04f02ad000@linux.intel.com>
Date: Mon, 14 Aug 2023 15:00:29 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc: baolu.lu@linux.intel.com, Dmitry Osipenko <digetx@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Steven Price <steven.price@arm.com>,
 Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v6 25/25] iommu: Convert remaining simple drivers to
 domain_alloc_paging()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Andy Gross <agross@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Bjorn Andersson
 <andersson@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Kevin Tian <kevin.tian@intel.com>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, linuxppc-dev@lists.ozlabs.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Orson Zhai <orsonzhai@gmail.com>, Rob Clark <robdclark@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Samuel Holland <samuel@sholland.org>,
 Thierry Reding <thierry.reding@gmail.com>, Krishna Reddy
 <vdumpa@nvidia.com>, Chen-Yu Tsai <wens@csie.org>,
 Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
References: <25-v6-e8114faedade+425-iommu_all_defdom_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <25-v6-e8114faedade+425-iommu_all_defdom_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/3 8:08, Jason Gunthorpe wrote:
> These drivers don't support IOMMU_DOMAIN_DMA, so this commit effectively
> allows them to support that mode.
> 
> The prior work to require default_domains makes this safe because every
> one of these drivers is either compilation incompatible with dma-iommu.c,
> or already establishing a default_domain. In both cases alloc_domain()
> will never be called with IOMMU_DOMAIN_DMA for these drivers so it is safe
> to drop the test.
> 
> Removing these tests clarifies that the domain allocation path is only
> about the functionality of a paging domain and has nothing to do with
> policy of how the paging domain is used for UNMANAGED/DMA/DMA_FQ.
> 
> Tested-by: Niklas Schnelle<schnelle@linux.ibm.com>
> Tested-by: Steven Price<steven.price@arm.com>
> Tested-by: Marek Szyprowski<m.szyprowski@samsung.com>
> Tested-by: Nicolin Chen<nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> ---
>   drivers/iommu/msm_iommu.c    | 7 ++-----
>   drivers/iommu/mtk_iommu_v1.c | 7 ++-----
>   drivers/iommu/omap-iommu.c   | 7 ++-----
>   drivers/iommu/s390-iommu.c   | 7 ++-----
>   4 files changed, 8 insertions(+), 20 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
