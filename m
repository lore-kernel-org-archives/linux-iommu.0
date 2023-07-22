Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD9117ABB;
	Sat, 22 Jul 2023 14:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690034471; x=1721570471;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fyulF7Tr+j4LZay3c2TRm4558/eA92Ao/qgr4Ol3LFc=;
  b=gR7eMdgXbxL9PgSt5EEz28Q42LLuUBPaqTqZ7fl6xmcvkDPFrAZZKalZ
   Vavz+ptcoAi8dGFMJ+geSO+wMFq5xcDKZkr4bgMnGoHqpzN953Gj0Ku+M
   2x2dln+UGrSMVeDfugYZ3S5o7jmwQco27XrMFl7tzHj18kwkcVFJLbSo8
   +7eEgI8OCU7j9Gc2ohrDha92CyRcvw1PinybN5i1HWfqpT3C/sR+Ejxc4
   d6F6A2t5Oc5HCUqCz7fupD2F5JeRncNuUH3cnR6U14eBXqIe9BfqqRkTC
   q8gcrYTeFkU1waLlKH0SMPT2ZGkTJwwINrBYr3MBt9J+jt58gww2xE/3Y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="398089973"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="398089973"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 07:01:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="760278657"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="760278657"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.173.108]) ([10.249.173.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 07:01:06 -0700
Message-ID: <1122d8bf-b10f-9376-e103-5fa9a0cba561@linux.intel.com>
Date: Sat, 22 Jul 2023 22:01:04 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, Baolin Wang <baolin.wang@linux.alibaba.com>,
 David Woodhouse <dwmw2@infradead.org>, Heiko Stuebner <heiko@sntech.de>,
 iommu@lists.linux.dev, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Orson Zhai <orsonzhai@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
 Will Deacon <will@kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 03/10] iommu: Add generic_single_device_group()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <3-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
 <32eadc5b-bb39-5bb1-f124-44feead97ce9@linux.intel.com>
 <ZLkiu7IyimCckiFs@nvidia.com>
 <c98c37bb-57c5-faec-1d17-730f3ceb2b21@linux.intel.com>
 <ZLq+PzR57D+RN2JF@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZLq+PzR57D+RN2JF@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/7/22 1:19, Jason Gunthorpe wrote:
> On Thu, Jul 20, 2023 at 10:01:54PM +0800, Baolu Lu wrote:
> 
>> Then, another small comment:
>>
>> iommu->singleton_group will be freed with above put, right? Do you need
>> to set iommu->singleton_group to NULL? Given that iommu_device is not
>> freed here.
> Well, I think the general API is we expect the caller to free the
> iommu_device after calling unregister so this would be like all the
> other places we free or put something then go on to release the
> memory.
> 
> At the very least if the caller thinks it should re-use the
> iommu_device then it needs to zero it.
> 
> Notice this also doesn't hold the lock while putting it, we require no
> concurrent calls to probe with unregister.

Fair enough. Thanks for the explanation.

Best regards,
baolu
