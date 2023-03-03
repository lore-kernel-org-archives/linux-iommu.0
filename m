Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3F11FB3
	for <iommu@lists.linux.dev>; Fri,  3 Mar 2023 09:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677837066; x=1709373066;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZymY3H9NdnOJcpTx0m9d4tusfMSeC+69qgEpN1llX8g=;
  b=SZVrH8DGqJLC3i0C+AyGefDJLVatWFWZzFsK60Pc+1pZMDEOUkdezmgd
   pNpk+SFJqnhS+xf4yaFeFw1fCGNAI/mj9pAUTl42UtuZdqu9DrmA8lVVC
   NGyv+ElZIr70jt5tVVhbtsc/MkKU34/5Yw5jKaFgyursNGy+RtkZmMBuI
   M6/Pzeq/fi3GCB0W65Un+AVZhLQ2gtP8Hi4/G/9EVNH/TsDtYOPnV5UIL
   h0yaaDioBpbm7+SsO9VlJidXhVRTj+40XOrAYonhoBFWZ02eXNweEiger
   dIDTnj+c9s1usf6/XIm/fZnrMolxxmsHp2VmP9tHepjfpzV+lmhWQOiPe
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="332488772"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="332488772"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 01:51:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="668602245"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="668602245"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.208.51]) ([10.254.208.51])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 01:51:02 -0800
Message-ID: <6e60e491-e3db-6342-28be-8cdce2843543@linux.intel.com>
Date: Fri, 3 Mar 2023 17:51:00 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Add opt-in for ATS support on discrete
 devices
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Robin Murphy <robin.murphy@arm.com>
References: <20230228023341.973671-1-baolu.lu@linux.intel.com>
 <Y/3yNaQD5Pkvf61k@nvidia.com>
 <3891a9a8-c796-2644-9473-aafc9ecea64e@linux.intel.com>
 <Y/9bWMoAYF10ynO3@nvidia.com> <0f162421-479e-6ab3-bbaf-0090b1a2472c@arm.com>
 <Y/+OobufnmGhg/R7@nvidia.com>
 <BN9PR11MB5276F192BCECE567DBFE21C08CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276F192BCECE567DBFE21C08CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/3/3 16:19, Tian, Kevin wrote:
> But Baolu, seems there is a small bug on handling satcu->atc_required.
> This indicates that ATS must be enabled as a functional requirement.
> Then we should handle the failure of pci_enable_ats() on such device.

Yes. We have people working on this. For example, when pci=noats is opt-
in, pci_enable_ats() definitely will return failure.

Best regards,
baolu
