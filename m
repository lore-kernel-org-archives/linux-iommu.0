Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C581101
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 02:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691117958; x=1722653958;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YyNSAAHZUlGA/Nj8JDQMCImBLWmGgqOE3kwnXdtnCok=;
  b=NVcObg9WfIdVoENggGqGhEwFzGf/2oEumuAgWxYUwdrHCZLIyU9jA+me
   8pq/srYQiOUNR+P1g+iGR2JEdQZpR3PWwPEicsOVI7bl6V7yD890Mwsq5
   MX/uPzhN+4ikGEjAXa2PEYHazQorMkEtxQkyeonvN8MwCWrqXzcAwbxjV
   N76hIdywZ1A8DvBha0QxpkbNCdxyGdLzRWGCbEP6hgKb4eF+2e5Ay8tag
   p1LPDPVXwNw1d9yPMvdMGDnZOJw8TX9Vy7sxNZrpcA+tom2DvXezZsNu7
   TF86sDJyUJ0PHkAanM1lCc4V+CSgwqeacij7J7YUiuSs/CiMcvSf/AqFg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="373694104"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="373694104"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 19:59:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="1060543668"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="1060543668"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.88]) ([10.254.210.88])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 19:59:02 -0700
Message-ID: <faad1948-5096-c9d3-616a-cd0f0a4b5876@linux.intel.com>
Date: Fri, 4 Aug 2023 10:58:59 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/12] iommu: Remove unrecoverable fault data
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
 <20230727054837.147050-4-baolu.lu@linux.intel.com>
 <BN9PR11MB52767976314CC61A0F8BEFD08C08A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52767976314CC61A0F8BEFD08C08A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/3 15:54, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Thursday, July 27, 2023 1:48 PM
>>
>>   struct iommu_fault {
>>   	__u32	type;
>> -	__u32	padding;
> this padding should be kept.
> 

To keep above 64-bit aligned, right?

I can't think of any other reason to keep it.

Best regards,
baolu
