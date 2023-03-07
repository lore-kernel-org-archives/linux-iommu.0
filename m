Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13994361
	for <iommu@lists.linux.dev>; Tue,  7 Mar 2023 02:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678155535; x=1709691535;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tQv4gmdXcympjD8IkqsMELkqyJD5tQxJZu6zFQZNSo8=;
  b=j3XCMJpJn04h2c0QgtZOJ9s3fwxyTpdR7gQJkzCbUTjx4x1Z0WWBKGsB
   bf3M3yauPOWZoRoV1C2Y4i81v7gDmKvCo+CKORpGx06jNm2linAdP3lnL
   vDUE/j4PL3FeEbS8eH+neCb9XapolHbEyb/F6KCKbQJuYgIVWR/Vov/w7
   Zt+KYQJC01ybelVXwoP7RDvk1eI0RYEt5Ee+ZHX47b6XTASOZAWXY3LnX
   d/f8o6XvTO7x3uaQfeQtu44PhL7ok7JnfD8XYDaNx4S5c+ubktiVFYl18
   l3FcFFeBcRtsvZrs9r9M+QaIU0ZmT0gU2rpwOY5Luv5Lv6fS3QQEw1IFM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="333212756"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="333212756"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 18:16:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="765460393"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="765460393"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Mar 2023 18:16:20 -0800
Message-ID: <f7c71e0a-59a8-b871-5593-713c9ad38cce@linux.intel.com>
Date: Tue, 7 Mar 2023 10:15:23 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, LKML <linux-kernel@vger.kernel.org>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 dmaengine@vger.kernel.org, vkoul@kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Raj Ashok <ashok.raj@intel.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 "Yu, Fenghua" <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Tony Luck <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH 1/4] iommu/vt-d: Implement set device pasid op for default
 domain
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
 <20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
 <ZAXjVaucrkEvrfsw@nvidia.com> <20230306093626.31c1573e@jacob-builder>
 <ZAYlwzQEcDHZKoju@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZAYlwzQEcDHZKoju@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/7/23 1:41 AM, Jason Gunthorpe wrote:
> On Mon, Mar 06, 2023 at 09:36:26AM -0800, Jacob Pan wrote:
> 
>>> It seems like all this is doing is flushing the PRI queue.
>>> A domain should have a dedicated flag unrelated to the type if it is
>>> using PRI and all PRI using domains should have the PRI queue flushed
>>> here, using the same code as flushing the PRI for a RID attachment.
>> Yes, or if the teardown op is domain-specific, then it works too?
> That could only sense if we end up creating a PRI domain type too..
> 
> Right now PRI is messy because it doesn't really work with unmanaged
> domains and that is something that will have to get fixed sort of
> soonish
> 
> Once PRI is a proper thing then "SVA" is just a PRI domain that has a
> non-managed from-the-mm page table pointer.
> 
> Most of the driver code marked svm should entirely disappear.

Agreed.

There is also another code consolidation we discussed earlier, that is
moving mmu_notifier_register/unregister to drivers/iommu/iommu-sva.c.
It's common for all SVA-capable iommu drivers.

With PRI domain and mm_notifier addressed, we could safely remove the
switch here. SVA domain will be nothing special. :-)

Best regards,
baolu
