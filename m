Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D686FC2
	for <iommu@lists.linux.dev>; Thu, 19 Jan 2023 11:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674128872; x=1705664872;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DuOBg1V/kEEpNk+BV4bYqVrWJSOOFRR3sdWDamFrvt0=;
  b=GUc1sDL2PLjN2+V+ZitG8REELvXg2ry77rnL1wALEEp9g7zCLSwtkvhP
   2GEG53DjwoA7MfgR/pV33eujZZCrD8Lc95Rb9kpwdpV4DLV69thjCb8+Y
   2g/8F/8h9/X2fOGgOFvyOLZKw9aUQxSGE3TF2N2obI0bexlZivji6/uUz
   Pgm4qrguFrApgul0eZ1z0PWYaTGsC1sFuzQB25cknUn6XFl/+zjOKriR/
   k0A//aYL/4Bv5kuSZhHP9C13jk3sDtFkq7MwY8iU5N/kXWUm11HQJLEKl
   hWs6L0dsW+vW51TNVYm8UG0RWo4pPV/qzgL/+9UQabnZU6sLtHbIWxQdK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="308821082"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="308821082"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 03:47:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="988957189"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="988957189"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.185.248]) ([10.252.185.248])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 03:47:45 -0800
Message-ID: <08c874f6-0c59-0b74-a2c8-7ad61356af6f@linux.intel.com>
Date: Thu, 19 Jan 2023 19:47:42 +0800
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
Subject: Re: [PATCH v2 06/10] iommu/intel: Add a gfp parameter to
 alloc_pgtable_page()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Kevin Tian <kevin.tian@intel.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>
References: <6-v2-ce66f632bd0d+484-iommu_map_gfp_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <6-v2-ce66f632bd0d+484-iommu_map_gfp_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/1/19 2:00, Jason Gunthorpe wrote:
> This is eventually called by iommufd through intel_iommu_map_pages() and
> it should not be forced to atomic. Push the GFP_ATOMIC to all callers.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
