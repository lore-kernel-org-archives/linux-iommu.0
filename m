Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2296FDF
	for <iommu@lists.linux.dev>; Mon,  3 Apr 2023 16:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680541056; x=1712077056;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7UYdKObsD+8SbBqsCmRC+KpRgQ2bEtZdumWSJIQRY/Y=;
  b=VU0QUSlIQgRYbiHTbLJ4BhR+CZr5EVKjgmBq1dfaOLKv4XAL3y8pIOek
   SDppBvF0rzoJo4M0+00GWb4OVZOVk5sHuTCBEDAJA1eKivlu2l9fbq736
   G+7T5am1IVc2/ZZRAU5bhEmf4sQwu3TEHIfwHn887RLvGg3FaZ++mmIgE
   KPuwttluG8fmdJHang+hYk2MIACf7hlNCy65HofuHx9FSC1cEB6wtdgw/
   P+6qrP3R52myEaThvA94vXMXXgH6u6IUtdL1iM6PL2YcEDYWJFL3A+16x
   ZjmVl2PPqmtpjcZI5Yu7Lb1VHKuOlolrvUDx3uB+M217qnGiOMHOOM5U3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="428244433"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="428244433"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 09:57:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="663271365"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="663271365"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.181.144]) ([10.213.181.144])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 09:57:34 -0700
Message-ID: <cea7d7ff-bf03-eb7d-a836-b51b9addef5b@intel.com>
Date: Mon, 3 Apr 2023 09:57:33 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/6] dmaengine: idxd: Add enable/disable device IOPF
 feature
Content-Language: en-US
To: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
 dmaengine@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20230324120234.313643-1-baolu.lu@linux.intel.com>
 <20230324120234.313643-2-baolu.lu@linux.intel.com>
 <f6445aed-bf35-7245-3d52-336ebe11a866@linux.intel.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <f6445aed-bf35-7245-3d52-336ebe11a866@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/2/23 10:49 PM, Baolu Lu wrote:
> On 3/24/23 8:02 PM, Lu Baolu wrote:
>> The iommu subsystem requires IOMMU_DEV_FEAT_IOPF must be enabled before
>> and disabled after IOMMU_DEV_FEAT_SVA, if device's I/O page faults rely
>> on the IOMMU. Add explicit IOMMU_DEV_FEAT_IOPF enabling/disabling in this
>> driver.
>>
>> At present, missing IOPF enabling/disabling doesn't cause any real issue,
>> because the IOMMU driver places the IOPF enabling/disabling in the path
>> of SVA feature handling. But this may change.
>>
>> Reviewed-by: Dave Jiang<dave.jiang@intel.com>
>> Reviewed-by: Fenghua Yu<fenghua.yu@intel.com>
>> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> 
> Hi Dave and Fenghua,
> 
> The following iommu patches depends on this one. Can I route it to
> Linus through the iommu tree?

Hi Baolu, you'll need an ack from Vinod, who is the dmaengine subsystem 
maintainer. I have no objections.


> 
> Best regards,
> baolu
