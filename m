Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F7F2117
	for <iommu@lists.linux.dev>; Mon, 26 Sep 2022 12:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664195893; x=1695731893;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XCGp0Qj6YNKh0DfMqLieNZxNgiq9Mq0FUMWMYtlQv8Y=;
  b=lp3dlo5rUM3cekXgGxaI269lGCeR3kaVo+I2maPy3mk8uV9ZxhSAL54+
   bgWVYbYPxmW4rBHb8ezOVrZI9nsZX2G7effEm10Ceq3I7jmqowguyiK0+
   JWaT4YIMpgSIaEaMbbutG5Jnzer2XHJtVQQ8aBIL5acSe70vAollRZc7V
   pCsyCb7/C4uJuf2sIK0CjgGbIv4FOlGNzkinL/Wb/AUf+5M4SBZfDJ0r/
   S3ToXlld6lf0CLyhsxQYpaCaIqOsc7jKP6k+rADv1bXQSGLCz541QvML8
   CffB2mJWrmnZsq5btIM73xobuCZtjtt7KdFEvcUkEU0ETg0+QHCtpTThX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="299738103"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="299738103"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 05:38:13 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="763419947"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="763419947"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.209.229]) ([10.254.209.229])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 05:38:11 -0700
Message-ID: <64405aee-0701-5b1f-084a-f0750372a563@linux.intel.com>
Date: Mon, 26 Sep 2022 20:38:09 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] [PULL REQUEST] Intel IOMMU updates for Linux v6.1
To: Joerg Roedel <joro@8bytes.org>
References: <20220923004206.3630441-1-baolu.lu@linux.intel.com>
 <YzGX7ri+CYTpKfeP@8bytes.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YzGX7ri+CYTpKfeP@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Joerg,

On 2022/9/26 20:15, Joerg Roedel wrote:
> Hi Baolu,
> 
> On Fri, Sep 23, 2022 at 08:42:00AM +0800, Lu Baolu wrote:
>> Lu Baolu (5):
>>    iommu/vt-d: Remove unnecessary SVA data accesses in page fault path
>>    iommu/vt-d: Decouple PASID & PRI enabling from SVA
>>    iommu/vt-d: Remove pasid_set_eafe()
>>    iommu/vt-d: Avoid unnecessary global IRTE cache invalidation
>>    iommu/vt-d: Avoid unnecessary global DMA cache invalidation
>>
>> Yi Liu (1):
>>    iommu/vt-d: Rename cap_5lp_support to cap_fl5lp_support
> 
> These don't apply cleanly on v6.0-rc4 or -rc7. Please rebase these
> patches to my x86/vt-d branch and re-send.

This pull request is based on the next branch. There's a conflict
between

de9f8a91eb32 iommu/dma: Clean up Kconfig (core branch)

and

iommu/vt-d: Decouple PASID & PRI enabling from SVA (this series).

Do you prefer applying de9f8a91eb32 to vt-d branch, or let me send a new
v6.0-rc7 based pull request?

Best regards,
baolu

