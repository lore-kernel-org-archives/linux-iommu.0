Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6337F23AA
	for <iommu@lists.linux.dev>; Wed, 16 Nov 2022 05:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668576425; x=1700112425;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tGeJ0MsSq8gz23Js7dgRVd2ZHtA6s2M81myKLSyDLWw=;
  b=D/W9uaGPhV+TP0kzNHVDaxcp8uc1svBrvcDBHZGE8mLO1a7OmF379ct6
   SKCnDKGAFgukWGTFFrCDhED5al1eqJY6Sy3v6RL5Hsrc1g2nWw5xxOBVD
   bcNAOzMGiGdy0TUWS7g6dZx52FNTPvJsaPbQ5l7i9tKOsAv1DkzbB6I5k
   a1UzZkUINnEPHruE3weBXjV1vJtSq0pydT/Al8JjESKYarTNgSBUg+2Vm
   RaE4sGtL07BsayTLO5GGvkNTbV4G1kL9E4khJ1P3o3wi1gVjXtKDz8zrb
   s6sZ4mJIMmXcLOTrA/mGGdAku5az3auySLPtNQaYHyjGnqZd/HDGJCOF1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="374587714"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="374587714"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 21:27:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="641492454"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="641492454"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga007.fm.intel.com with ESMTP; 15 Nov 2022 21:27:03 -0800
Message-ID: <40f5a81b-c40e-27e9-bc71-421f80792a79@linux.intel.com>
Date: Wed, 16 Nov 2022 13:20:07 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Cc: baolu.lu@linux.intel.com
Subject: Re: [PATCH] iommu/vt-d: Present Access bit for IOVA in FL non-leaf
 paging entries
Content-Language: en-US
To: Tina Zhang <tina.zhang@intel.com>, iommu@lists.linux.dev
References: <20221113010324.1094483-1-tina.zhang@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20221113010324.1094483-1-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/22 9:03 AM, Tina Zhang wrote:
> The A/D bits are presented for IOVA over first level(FL) usage for both
> kernel DMA (i.e, domain typs is IOMMU_DOMAIN_DMA) and user space DMA
> usage (i.e., domain type is IOMMU_DOMAIN_UNMANAGED).
> 
> Preseting A bit in FL requires to present the bit in very related paging
> entries, including the non-leaf ones. Otherwise, DMA fault may come out.
> For example, in a case of ECAP_REG.SMPWC==0, the DMA fault would be
> "SM: A/D bit update needed in first-level entry when set up in no
> snoop".
> 
> Signed-off-by: Tina Zhang<tina.zhang@intel.com>

Patch queued for v6.1. Thank you!

https://lore.kernel.org/linux-iommu/20221116051544.26540-1-baolu.lu@linux.intel.com/

Best regards,
baolu
