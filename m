Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC13CA29
	for <iommu@lists.linux.dev>; Sun, 21 May 2023 06:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684650155; x=1716186155;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ekzYqo7EzgZT0OkwVWM3WQ4Ormn8rtrKMWfR7boXeYc=;
  b=ZuWDNHQb0MoaIRsXJ4OkGdk1l1hnLSlbR1lmV0iIrBOewNo3VYzJHGi8
   YuTOxtO0vQFpp0zJ0TAP1dMc8i2Czm4Sp+fpSiqFs1hfAWsZqS4XrN591
   3LKoO7Jb4NKeVJuUzaRIMemNi44IUzJrmPcC3sTd2jgaPUeIBp25/EXxf
   0YBm90rSlXu3ropXNPo+cJfQ728HH4BBP7ssKB4UsP5OqSztgoJi9sBPX
   bgWTwrfnL0J56ksSs5UiTFs55/LyrSG6gWnzJrqeMqqRpZLTY97GIEY9s
   P46Nqv4q0XxiBefDxN5zlchzdr9Ng47NYiFiBtsRbFLOGEXxowY52rRGn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10716"; a="332282580"
X-IronPort-AV: E=Sophos;i="6.00,181,1681196400"; 
   d="scan'208";a="332282580"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2023 23:22:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10716"; a="1033113548"
X-IronPort-AV: E=Sophos;i="6.00,181,1681196400"; 
   d="scan'208";a="1033113548"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 20 May 2023 23:22:30 -0700
Message-ID: <ab7d4bfc-d599-0875-cbdd-0be8cc5d9d7f@linux.intel.com>
Date: Sun, 21 May 2023 14:21:48 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Raj Ashok <ashok.raj@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Tony Luck <tony.luck@intel.com>,
 "Zanussi, Tom" <tom.zanussi@intel.com>, narayan.ranganathan@intel.com
Subject: Re: [PATCH v6 1/4] iommu: Generalize default PCIe requester ID PASID
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
 Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 dmaengine@vger.kernel.org, vkoul@kernel.org
References: <20230519203223.2777255-1-jacob.jun.pan@linux.intel.com>
 <20230519203223.2777255-2-jacob.jun.pan@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230519203223.2777255-2-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/23 4:32 AM, Jacob Pan wrote:
> PCIe Process address space ID (PASID) is used to tag DMA traffic, it
> provides finer grained isolation than requester ID (RID).
> 
> For each RID, 0 is as a special PASID for the legacy DMA (without
> PASID), thus RID_PASID. This is universal across all architectures,
> therefore warranted to be declared in the common header.
> Noting that VT-d could support none-zero RID_PASID, but currently not
> used.
> 
> By having a common RID_PASID, we can avoid conflicts between different
> use cases in the generic code. e.g. SVA and DMA API with PASIDs.
> 
> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
