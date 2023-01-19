Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CC46FC2
	for <iommu@lists.linux.dev>; Thu, 19 Jan 2023 11:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674129457; x=1705665457;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OOSuI8Ptgbyop0bHqYWl6Cev1ihhKUlYoWWsszEriiM=;
  b=Ld6BNIAxy62CgK+XmkZEcn8u2OyXgy38RzLrI62u+91zbhwkJHL7M/DM
   6qLa4Jgtz/ZYP+Kq6YpEvUjCPAccKhRPgDkNEMUtuQ1rTpPjMPUpqZSOl
   DNt12/diIZKjyxD2dc4yRIaL1QpRBiLaX6hnu8SbQNIBFjH1rrwdRn1LD
   MBlcd8hdxlG7g/3OKpiWe3ldRGFLu2P5tdd8q6LxwkUyHbuSrDm9N9P7v
   K2d2G6jP0ZFCd1vgXbBnlCTViTLds66WXqvfckl8b+CmSxRHpP9OXVuZ2
   SAZrKRw+7liKWUHn+GGoVMvS2zZBpLlUpRTF7HhIWG2vCq7bMVBEgnUdw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="305637398"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="305637398"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 03:57:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="692393155"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="692393155"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.185.248]) ([10.252.185.248])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 03:57:23 -0800
Message-ID: <e44077a7-e275-4e34-b7ad-3e1382ea974d@linux.intel.com>
Date: Thu, 19 Jan 2023 19:57:20 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc: baolu.lu@linux.intel.com, Alex Williamson <alex.williamson@redhat.com>,
 ath10k@lists.infradead.org, ath11k@lists.infradead.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 nouveau@lists.freedesktop.org, Niklas Schnelle <schnelle@linux.ibm.com>,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 07/10] iommu/intel: Support the gfp argument to the
 map_pages op
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Kevin Tian <kevin.tian@intel.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>
References: <7-v2-ce66f632bd0d+484-iommu_map_gfp_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <7-v2-ce66f632bd0d+484-iommu_map_gfp_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/1/19 2:00, Jason Gunthorpe wrote:
> Flow it down to alloc_pgtable_page() via pfn_to_dma_pte() and
> __domain_mapping().
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Irrelevant to this patch, GFP_ATOMIC could be changed to GFP_KERNEL in
some places. I will follow up further to clean it up.

For this patch,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
