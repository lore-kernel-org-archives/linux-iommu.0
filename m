Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675C77B
	for <iommu@lists.linux.dev>; Tue, 19 Jul 2022 00:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658189188; x=1689725188;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=29irNU69Aaj6YHBxBjzfv6PGD4zSfN7x3EpWcwWR9p4=;
  b=dMd/BeJQuElx+5J3mf1BnqOBAdGwY7ir0A5B4FMTw+9lWm+R7H35b8Rb
   tzA93JzRYJJJc2OQDoqOuPlZvwMa0QCpCzWDOVMn2m0jzH5zgSRRH2fQS
   ZhYaVIiq7wjsckeXFr0XvYFwv7cOo2oByegvChpb8nhQr8/VBxkoPCqH0
   497blkZx7/SeZvhC8wRwrZ5EsM9NGndrKqnBJFzNyq5X4FOUvy25AfI+u
   5UFHSEzW3mhEbq7a0tMEyh5onGr+8UXdiW1ZA9q2MIg/2lHBP11fxlLpw
   QGtEZJSqGTnd4UIC5IXkRqOJIVNrADiw/QJdWmzCHiBXqjQCt62ZNgMPe
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="312034259"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="312034259"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 17:06:22 -0700
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="547694963"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.128]) ([10.254.213.128])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 17:06:19 -0700
Message-ID: <9614fd81-5feb-b9c9-8317-26ca82d30d55@linux.intel.com>
Date: Tue, 19 Jul 2022 08:06:02 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc: baolu.lu@linux.intel.com, will@kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, suravee.suthikulpanit@amd.com,
 vasant.hegde@amd.com, mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
 schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
References: <cover.1657034827.git.robin.murphy@arm.com>
 <894db0ccae854b35c73814485569b634237b5538.1657034828.git.robin.murphy@arm.com>
 <903a1677-4217-d793-6295-3927143d98fb@linux.intel.com>
 <6557623d-3e4e-9f3e-e735-fd9654305f65@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 01/15] iommu/vt-d: Handle race between registration and
 device probe
In-Reply-To: <6557623d-3e4e-9f3e-e735-fd9654305f65@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Robin,

On 2022/7/15 20:37, Robin Murphy wrote:
>> In fact the rmrr list in the Intel IOMMU driver is always static after
>> parsing the ACPI/DMAR tables. There's no need to protect it with a lock.
>> Hence we can safely remove below down/up_read().
> 
> IIRC that leads to RCU warnings via for_each_dev_scope(), though. I did 
> try replacing this down_read() with rcu_read_lock(), but then it doesn't 
> like the GFP_KERNEL allocation in iommu_alloc_resv_region(), and that's 
> where I gave up :)
> 
> I'm mostly left wondering whether the dmar_drhd_units list really needs 
> to be RCU protected at all, as that seems to be the root of most of the 
> problems here.

I just posted a fix patch here:

https://lore.kernel.org/linux-iommu/20220718235325.3952426-1-baolu.lu@linux.intel.com/

It can remove the recursive locking and RCU warnings. Can you please
take a look at it?

Best regards,
baolu
