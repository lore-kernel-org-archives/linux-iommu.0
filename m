Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301611CF87
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="adiSmPXv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697460156; x=1728996156;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kJa9LCleZSuKMx8+bUfIFtH/NjUO548v8N9SSN7TIR0=;
  b=adiSmPXvAlgsFH169tIk9yycIFNk1MQws7fEQWV25NeQ/1YyLOM3bmZW
   2thAd9ROi0PWKqKGqvecIp+yTGD58cIN4slXJ35oWZ65b30AtPQcfNddl
   yJpVnVJRm+FQWFTngzyD+jFFSr9Ec01TvV2qxtFDIoaYpueUBcE/PP3+l
   cdJZ2yj5dZ5xvZ328BssFu4bFEkWb2PO6w5K413LFV0GQMKUFUhjwP9Ri
   sLnxbyOyP2gcRFkJlFOeHDV04eIm803WWMBHrLXaLRPCJQ7T3Yk6rDIeG
   2TjviTvBoxDwzBIlzSTBE9SMs9odYtMzX1vW8gHpgqIELDaejRkZ0+nQl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="389374766"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="389374766"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 05:41:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="879413581"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="879413581"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.91]) ([10.249.171.91])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 05:41:40 -0700
Message-ID: <ab9f9259-6ba5-7cdf-10d9-f0b9502ca51d@linux.intel.com>
Date: Mon, 16 Oct 2023 20:41:38 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Yi Liu <yi.l.liu@intel.com>, Yi Y Sun <yi.y.sun@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v3 19/19] iommu/intel: Access/Dirty bit support for SL
 domains
To: Joao Martins <joao.m.martins@oracle.com>, iommu@lists.linux.dev
References: <20230923012511.10379-1-joao.m.martins@oracle.com>
 <20230923012511.10379-20-joao.m.martins@oracle.com>
 <046e8881-2fe4-45db-846e-99122d4dce86@linux.intel.com>
 <5adefd4e-d388-4c89-851b-a37f92d68e06@oracle.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <5adefd4e-d388-4c89-851b-a37f92d68e06@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/10/16 18:42, Joao Martins wrote:
>>> +        domain->dirty_ops = &intel_dirty_ops;
>>>        return domain;
>>>    }
>> The VT-d driver always uses second level for a user domain translation.
>> In order to avoid checks of "domain->use_first_level" in the callbacks,
>> how about check it here and return failure if first level is used for
>> user domain?
>>
> I was told by Yi Y Sun offlist to have the first_level checked, because dirty
> bit in first stage page table is always enabled (and cannot be toggled on/off).
> I can remove it again; initially RFC didn't have it as it was failing in similar
> way to how you suggest here. Not sure how to proceed?

Yi was right. But we currently have no use case for dirty tracking in
the first-level page table. So let's start from only supporting it in
the second level page table.

If we later identify a use case for dirty tracking in the first level
page table, we can then add the code with appropriate testing efforts.

Best regards,
baolu

