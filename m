Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAC71FC8
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 05:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691127378; x=1722663378;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Nr2qXOc8VggqBic2CF/1tIEuRpxuNBYG4z12oSvPugc=;
  b=E4ToAElHT2FCMhjsmw+Mpv1kUXXcdMdrhiiJfzWZNVSGN2v3ee3wrYcr
   LRPHlKFPzVpYSdN5eC/oU5IY1OcCfIFDRlvisLyfRE2TpE8kntb8dc+Nl
   GcOD7feN7pxk/QDW/aGNJk7l72uC+wXrRBXEFucUsLdrVrFVeCNQ+yR36
   aOncx/IoAB07uT823MZgW4ndoxgNhHBR4a9BFI2HxmOU762vBoplkajDF
   9tecUKsrIiIYGmi8CQybyseqiOdx+vqxwuOBzg9raMc4KMR3Qaqv4/ys+
   gtQAs2wCrxXn5eaxN2bPzfaPGRF2LRU4wJowVRCmLVQXZhT+t2a0tVyyy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="367533244"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="367533244"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 22:36:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="764958786"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="764958786"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 03 Aug 2023 22:36:14 -0700
Message-ID: <d8fbb693-fc6d-7787-a4c5-1d0e19b00df2@linux.intel.com>
Date: Fri, 4 Aug 2023 13:34:03 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
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
 <faad1948-5096-c9d3-616a-cd0f0a4b5876@linux.intel.com>
 <BN9PR11MB527614E61BC257FE113EFE358C09A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527614E61BC257FE113EFE358C09A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/4/23 11:51 AM, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Friday, August 4, 2023 10:59 AM
>>
>> On 2023/8/3 15:54, Tian, Kevin wrote:
>>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>>> Sent: Thursday, July 27, 2023 1:48 PM
>>>>
>>>>    struct iommu_fault {
>>>>    	__u32	type;
>>>> -	__u32	padding;
>>> this padding should be kept.
>>>
>>
>> To keep above 64-bit aligned, right?
>>
> 
> yes

Okay, thanks!

Best regards,
baolu
