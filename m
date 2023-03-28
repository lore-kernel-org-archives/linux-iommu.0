Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70847A44
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 04:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679979530; x=1711515530;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DGZ3DU5x+skg2D1FkomJpeBqU8MpbJx454vv+r3PcfA=;
  b=gOXt3IRWuLllBiJhgFFxyu63RhpEthy4Ibq/RDVkpURc4jAO5reVbn8k
   MD5UZLBhQpKSvPNg5ICoGmpIkcdDxWdZEi8yPhZAgW7b4WqHs1ELIVOR1
   84mCVzu08Q0z1rsBGkB9H8TDI7QItgxMELofj8tVKJLMRRNqsh35jLnO9
   ySg/LswKMip1Q12u/Upz6w1ofXZy9eFj2sRZilMGPE3S+AGfEzCwlUIv5
   TLWcSA3HF+6ivsiFhOh/cUcS7OfYgFJAmUVk6Eds/KO+4IxP9pGTnATH5
   fQtVBB94zvbEfLZ25CN81hpkjBayPMm4+fs68wgnTIrtxRGTj85NnFZVq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="339195210"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="339195210"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 21:58:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="714117523"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="714117523"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 27 Mar 2023 21:58:43 -0700
Message-ID: <5577d93a-d892-95b2-807c-8e1b414fa300@linux.intel.com>
Date: Tue, 28 Mar 2023 12:59:04 +0800
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
Subject: Re: [PATCH v2 2/8] iommu/vt-d: Remove PASID supervisor request
 support
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
 Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 dmaengine@vger.kernel.org, vkoul@kernel.org
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
 <20230327232138.1490712-3-jacob.jun.pan@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230327232138.1490712-3-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/23 7:21 AM, Jacob Pan wrote:
> There's no more usage,  remove PASID supervisor support.
> 
> Suggested-by: Lu Baolu<baolu.lu@linux.intel.com>
> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
