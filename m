Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3392468C
	for <iommu@lists.linux.dev>; Thu, 13 Jul 2023 04:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689220939; x=1720756939;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O39lNRRLEZrxdCfFdPTtwQM5foocmidb2nO67vHXx6E=;
  b=NJyuV6cR5/Rp5wl7nEGaN1UVsekn8SbTBsbLk5pLwHYrAVqvtyZFtRTS
   luxwEJ8tgilaWn+NenP/6WwF7/sCs8U1uizW/kuCPU0rQnZHzvSwct+vV
   K/d4WFjAcK54mfx0r3b+6nEskSS+RzTjA6lFzkZGMgbWoQfZ14qWNOJ2u
   nfbG3HrlNKBRSxN81Qgci6hqNDxUm45sJN/CmreANdGJI0DBfbpGOr8Zh
   8F5/Qq9xyFBi4Ms/txGzITWYb60S2rY6LrSc7J+z5lkPRTiWLQ5EIxZN1
   K4IDHG09wODbwvwJYthloBkuTecL0RM5n0SBTKXb3yWcB+sS9iXYcUqzn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="367706904"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; 
   d="scan'208";a="367706904"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 21:02:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="791871498"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; 
   d="scan'208";a="791871498"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.187.96]) ([10.252.187.96])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 21:02:13 -0700
Message-ID: <155838f4-eac0-4e8c-adc6-e4efa2a786e2@linux.intel.com>
Date: Thu, 13 Jul 2023 12:02:09 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/9] iommu: Add common code to handle IO page faults
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20230711010642.19707-1-baolu.lu@linux.intel.com>
 <20230711010642.19707-4-baolu.lu@linux.intel.com>
 <BN9PR11MB52761F71BA509501C1766E9A8C31A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <cbbe1175-40f3-805e-02c2-f887b3289f04@linux.intel.com>
 <20230712094522.GB507884@myrica>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230712094522.GB507884@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/7/12 17:45, Jean-Philippe Brucker wrote:
> On Wed, Jul 12, 2023 at 10:32:13AM +0800, Baolu Lu wrote:
>>> btw is there value of moving the group handling logic from
>>> iommu_queue_iopf() to this common function?
>>>
>>> I wonder whether there is any correctness issue if not forwarding
>>> partial request to iommufd. If not this can also help reduce
>>> notifications to the user until the group is ready.
>>
>> I don't think there's any correctness issue. But it should be better if
>> we can inject the page faults to vm guests as soon as possible. There's
>> no requirement to put page requests to vIOMMU's hardware page request
>> queue at the granularity of a fault group. Thoughts?
> 
> Not sure I understand you correctly, but we can't inject partial fault
> groups: if the HW PRI queue overflows, the last fault in a group may be
> lost, so the non-last faults in that group already injected won't be
> completed (until PRGI reuse), leaking PRI request credits and guest
> resources.

Yeah, that's how vIOMMU injects the faults. On host/hypervisor side, my
understanding is that faults should be uploaded as soon as possible.

Best regards,
baolu
