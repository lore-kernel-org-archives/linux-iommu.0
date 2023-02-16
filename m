Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6695663
	for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 13:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676555122; x=1708091122;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0l+RPbcf2hm7NN6r12F9dZZzVVPHF2aVireRQ7ilgwE=;
  b=TDdJHyNImg3f9qJhQN40NnsgIVFFF68MzuAnjGVuXioj+xUVgHf2UMvb
   z2wHkcj8/tUKapfWoL+4jLDAlLouxQMxdgP9tUJxT3M/do1e9fZmkJsNt
   VFYgnN6Xl0hcl17pQEB0xFoQtUHoDt6iCqzHI/oAqot8w+5zoi55RLeqU
   JzgoOJE2Yd5uCOLIgNdwItsclh5eLYpP3fTQ5IEdJzwHojD26QcHrAEoB
   fiYNZfKF1Jc7y0Soe5Z5KYFxXT+k5+OZTVBmQMg9lmmUU1cvRVjQl0RRG
   4UgFbpjWRUmbZ3p7czPXrvCzwIC5Fh3Y7sL8JokKgOnJcir+x9b+au/pV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="311347519"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="311347519"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 05:45:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="915667201"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="915667201"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.211.109]) ([10.254.211.109])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 05:45:19 -0800
Message-ID: <88e0b71e-5674-8b03-e038-9ab75503c817@linux.intel.com>
Date: Thu, 16 Feb 2023 21:45:18 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Cc: baolu.lu@linux.intel.com, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Tina Zhang <tina.zhang@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] [PULL REQUEST] iommu/vt-d: Fixes for v6.2-rc8
To: Joerg Roedel <joro@8bytes.org>
References: <20230216130816.151824-1-baolu.lu@linux.intel.com>
 <Y+4yuaciYYnptpKI@8bytes.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y+4yuaciYYnptpKI@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/2/16 21:42, Joerg Roedel wrote:
> Hi Baolu,
> 
> On Thu, Feb 16, 2023 at 09:08:12PM +0800, Lu Baolu wrote:
>> Below iommu/vt-d fixes are queued for your fixes branch.
>>
>> - Two performance optimizations
>> - Fix PASID directory pointer coherency
>> - Fix missed rollbacks in error path
>>
>> Please consider it for the iommu/fixes branch.
> So nothing of this seems really critical (e.g. fixes a regression that a
> number of people are encountering). Especially the performance
> optimizations do not qualify as fixes at this stage of the cycle. I will
> queue them in the VT-d branch so that they go upstream in the next merge
> window, unless you convince me otherwise.

Yes. Nothing really critical. It's fine to put them in the vt-d branch.

Best regards,
baolu
