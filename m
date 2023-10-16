Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170B2273F0
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 13:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="emAcPo9s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697461303; x=1728997303;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Cek2Mj9VL4t6yJnSLD+Iis5IEBjCCUrO/gTh8DBNYb0=;
  b=emAcPo9ssoUuMwAHJ4PAlzKjiKCKxkQIiDVSeDzs9diz7s+b3xvWR6oG
   qN3DiE6rGJa8B0Cm1NC8hfu5EZCVLwlqvl5MFbfP65RnAEfDKqzTXDsjx
   v2Mip+yMVkKyD9fIqZDYOFIARvkkwWVRvmZcMcYX3KMX/gi9hFhLwRU9t
   128dD66PcEYifQmeGVGoXe7YstvfgvbxtfHTHF/wjUhpl4Ss1hpmqILrP
   +R5bTvsq0Gjtlw4wFooYc3i/T52cfMT3p/31PFodIfa7PfVALZmYiewHE
   27Jjzv6NSmzVPSHgAepO60UTH7a5NJINekagDpCb98uOgDkHUVtMb/1bh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="382739345"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="382739345"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 06:01:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="732294054"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="732294054"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.91]) ([10.249.171.91])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 06:01:37 -0700
Message-ID: <3e30e72a-c1c6-55a6-8e52-6a6250d2d8de@linux.intel.com>
Date: Mon, 16 Oct 2023 21:01:35 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: baolu.lu@linux.intel.com, Joao Martins <joao.m.martins@oracle.com>,
 iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Yi Liu <yi.l.liu@intel.com>, Yi Y Sun <yi.y.sun@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v3 19/19] iommu/intel: Access/Dirty bit support for SL
 domains
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20230923012511.10379-1-joao.m.martins@oracle.com>
 <20230923012511.10379-20-joao.m.martins@oracle.com>
 <c4816f4b-3fde-4adb-901f-4d568a4fd95a@linux.intel.com>
 <764f159d-a19c-4a1d-86a6-a2791ff21e10@oracle.com>
 <20231016114210.GM3952@nvidia.com>
 <037d2917-51a2-acae-dc06-65940a054880@linux.intel.com>
 <20231016125941.GT3952@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231016125941.GT3952@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/10/16 20:59, Jason Gunthorpe wrote:
> On Mon, Oct 16, 2023 at 08:58:42PM +0800, Baolu Lu wrote:
>> On 2023/10/16 19:42, Jason Gunthorpe wrote:
>>> On Mon, Oct 16, 2023 at 11:57:34AM +0100, Joao Martins wrote:
>>>
>>>> True. But to be honest, I thought we weren't quite there yet in PASID support
>>>> from IOMMUFD perspective; hence why I didn't aim at it. Or do I have the wrong
>>>> impression? From the code below, it clearly looks the driver does.
>>> I think we should plan that this series will go before the PASID
>>> series
>> I know that PASID support in IOMMUFD is not yet available, but the VT-d
>> driver already supports attaching a domain to a PASID, as required by
>> the idxd driver for kernel DMA with PASID. Therefore, from the driver's
>> perspective, dirty tracking should also be enabled for PASIDs.
> As long as the driver refuses to attach a dirty track enabled domain
> to PASID it would be fine for now.

Yes. This works.

Best regards,
baolu
