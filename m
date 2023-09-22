Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DCC168AA
	for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 12:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695386530; x=1726922530;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n6T69lEv9YGl1TLKPGD4sMuHfJtZkZMg60zc5RvhJJE=;
  b=OOphVith2NIVIVQEiO75M3ff72tu731UI+mRuBukxmgCiKzaEEY+jPsQ
   sb02oHoJ7Cbfgi33ZCmZlZ73en4BlIcbN4Vy6Z6FGl25jCQqosLdu5F7Q
   jHCVq4/z1iQ6ZARVIl6RGRRDOBeaFVGErWhujy1c4W3l/ip/lRWTCZ1G6
   Mk0K3VGXmBskJro1n1a95EZFAtm60nlIrqtul3GF53H2SxvQ4pOJT9OCD
   cVXHB8AEbmL+bxc44rBeEiSqaw9R9U1+Adz949Yjt/ryzU9vvew79J/LU
   DjaZ430MXAjoByvJ7E2D7Z8KlyNhmeKKfp1ac/JpRJxy03AYaXQbFAAJa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="360198440"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="360198440"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 05:42:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="994534054"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="994534054"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.30.83]) ([10.255.30.83])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 05:42:06 -0700
Message-ID: <3a52aaa9-8fa3-6d99-363e-0620e538f2fe@linux.intel.com>
Date: Fri, 22 Sep 2023 20:42:04 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: baolu.lu@linux.intel.com, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Hegde, Vasant" <Vasant.Hegde@amd.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
 "Huang2, Wei" <Wei.Huang2@amd.com>, "jsnitsel@redhat.com"
 <jsnitsel@redhat.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20230921093140.6162-1-vasant.hegde@amd.com>
 <20230921093140.6162-2-vasant.hegde@amd.com>
 <BL1PR12MB5144C5ADC106D450EA73C511F7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921141415.GN13733@nvidia.com>
 <BL1PR12MB51449627A11B2BDA55B97C8CF7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921163154.GO13733@nvidia.com>
 <19c7c139-b002-384f-5766-b87a8013029e@linux.intel.com>
 <20230922115927.GI13733@nvidia.com>
 <a4770035-9f1a-3bff-2ff2-d6b9c81e2c0b@linux.intel.com>
 <20230922121812.GM13733@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230922121812.GM13733@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/9/22 20:18, Jason Gunthorpe wrote:
> On Fri, Sep 22, 2023 at 08:13:02PM +0800, Baolu Lu wrote:
> 
>>> You might make this argument if ACS is also non-isolating though..
>>>
>>> Regardless I think we need to get into a position where the iommu core
>>> is deciding if PRI or ATS is enabled for a device, not the iommu
>>> driver.
>>
>> Agreed. I ever had a series to achieve this and it may be time to
>> revisit them.
>>
>> One additional concern is how the core knows whether ATS should be
>> enabled. In my previous design, the IOMMU core turns on ATS by default
>> if the device is capable of it, but the driver could enable/disable it
>> from its driver probe() callback.
> 
> I think that is a good place to start, maybe we have some command line
> and/or sysfs like we have for the default domain policy.

Yes. It sounds reasonable.

> 
> IMHO iommu drivers should not override this.
> 
> I think it was a mistake that iommu drivers could override to identity
> domains. If we need quirks then the core code should have the quirk
> list, similar to how PCI works.

If I remember it correctly, you have posted a series to address this. Or
I might misunderstood it.

Best regards,
baolu
