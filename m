Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB907C
	for <iommu@lists.linux.dev>; Wed,  8 Mar 2023 02:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678242289; x=1709778289;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T/tjOgbeN2d/sg5f4egU/DU2gu++1HrMEaAOm2wBhdA=;
  b=W7vdxRryzxuVThwNTLok4hAYJPfm/XK4oQk9xtmIO2wSV4DckGE0CuQL
   dla6yhjzK6E8Zxap2F864qqlgzjNs+SKKjB+1NrK/CY0bge2VukBh3jFW
   PiwajPj0CO/iLFloxLNLBdCZMNtLhHUUX5tbAVNaLYMOgpodwOR7/Iz5L
   AgWMFqZXM9efQSJ7SrZxvUZMk6NF5iOnckJa8YFt4EztGhXFZqwhMjfiv
   cGyKA6nWJp/ufBt0zNGsJj+NB4IL9BnUwH5Za4NZKiMH5FAIO6p/77w0j
   Kc3WdwToE8srCCvGVQBbA0wth6UiYiLeV2nBAScHGxwF0LPhVppHxe2kA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="337554172"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="337554172"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 18:24:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="676804666"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="676804666"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga002.jf.intel.com with ESMTP; 07 Mar 2023 18:24:46 -0800
Message-ID: <e37f4226-b4ee-9a80-187c-ac13733d353c@linux.intel.com>
Date: Wed, 8 Mar 2023 10:23:48 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, dmaengine@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Alistair Popple <apopple@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Stoakes <lstoakes@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux.dev
Subject: Re: [PATCH v2 08/16] iommu: define and export
 iommu_access_remote_vm()
Content-Language: en-US
To: Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>
References: <20230306163138.587484-1-fenghua.yu@intel.com>
 <20230306163138.587484-9-fenghua.yu@intel.com>
 <f7b0cbef-3d7d-e5aa-1971-fe230d0c80e1@linux.intel.com>
 <932aebd3-c655-3266-1acb-e41e8cbfb771@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <932aebd3-c655-3266-1acb-e41e8cbfb771@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/8/23 1:55 AM, Fenghua Yu wrote:
> Hi, Baolu,
> 
> On 3/6/23 17:41, Baolu Lu wrote:
>> On 3/7/23 12:31 AM, Fenghua Yu wrote:
>>> Define and export iommu_access_remote_vm() to allow IOMMU related
>>> drivers to access user address space by PASID.
>>>
>>> The IDXD driver would like to use it to write the user's completion
>>> record that the hardware device is not able to write to due to user
>>> page fault.
>>
>> I don't quite follow here. Isn't I/O page fault already supported?
> 
> The following patch 9 in this series explains in details why IDXD device 
> cannot use page fault to write to user memory: 
> https://lore.kernel.org/dmaengine/20230306163138.587484-10-fenghua.yu@intel.com/
> 
> "DSA supports page fault handling through PRS. However, the DMA engine
> that's processing the descriptor is blocked until the PRS response is
> received. Other workqueues sharing the engine are also blocked.
> Page fault handing by the driver with PRS disabled can be used to
> mitigate the stalling.

Ah! Get your point now. Thanks for the explanation.

> 
> With PRS disabled while ATS remain enabled, DSA handles page faults on
> a completion record by reporting an event in the event log. In this
> instance, the descriptor is completed and the event log contains the
> completion record address and the contents of the completion record."
> 
> That's why IDXD driver needs this IOMMU's helper 
> iommu_access_remote_vm() to copy the completion record from event log 
> buffer to user space.
> 
> Thanks.
> 
> -Fenghua

Best regards,
baolu
