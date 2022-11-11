Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43CE652
	for <iommu@lists.linux.dev>; Fri, 11 Nov 2022 06:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668149973; x=1699685973;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=i67AgbXdRQ3CyneZ77WU7qORoWlfF+NKMNtu5t38A/Y=;
  b=kf26Jg1QXKFSKKSPom/nsdX/gS59hvLfZKCU6zCqY0Bf1gh0wvoarGX8
   oGmSB/19WqOZz9U+K9CRvl4+Ut5bUCY3cgIyJNbSQmFML2MyQnEwVltEv
   ogBaYii/Vdu/eW9yrqN8oB8gefe2Ac6PVRR/y5nrQoLS+cWEFdgDz9EbI
   Of0X74pGrCyHKLiaqYt5APnc66lBQgzlHhHlVD4c2ICRHq4gJFK9E9ve8
   85cLl6DdRSmiaMdmMPvpDY9X/4hCEG+i46wkPIQdokacD2m0u0KOxMewe
   F9xHUoHgXj2qmoFjWRAe+FU0CkFFCkwh6ukCPKxgUXusFX5BEV6BnY6DL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="291944272"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="291944272"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 22:59:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="637487433"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="637487433"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.57]) ([10.254.212.57])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 22:59:30 -0800
Message-ID: <d7f72290-c11a-64f7-c8ac-b752835d182d@linux.intel.com>
Date: Fri, 11 Nov 2022 14:59:28 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Pan, Jacob jun"
 <jacob.jun.pan@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20221108073408.1005721-1-baolu.lu@linux.intel.com>
 <20221108073408.1005721-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52766AB454992F154C301CB28C009@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 2/8] iommu/vt-d: Improve iommu_enable_pci_caps()
In-Reply-To: <BN9PR11MB52766AB454992F154C301CB28C009@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/11/11 11:45, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, November 8, 2022 3:34 PM
>>
>> The PCI subsystem triggers WARN() if a feature is repeatedly enabled.
>> This improves iommu_enable_pci_caps() to avoid unnecessary kernel
>> traces through checking and enabling. This also adds kernel messages
>> if any feature enabling results in failure. It is worth noting that
>> PRI depends on ATS. This adds a check as well.
> 
> Cannot we have a helper to check whether this device has been attached
> to any domain? If no in the blocking path then disable PCI caps. If no
> in the attaching path then enable PCI caps.
> 
> I just didn't get the point of leaving them enabled while the device can
> not do any DMA at all.

Ideally, the kernel owns the default policy (default on or off). The
upper layers are able to control it over IOMMUFD uAPI or kerneld kAPI.
I can't see the benefits of associating these features with the
existence of any domain.

The VT-d spec seems to use the same idea. The control of PASID/ATS are
placed in the device context fields, while the setting of domains are
placed in the PASID entry fields.

Best regards,
baolu
