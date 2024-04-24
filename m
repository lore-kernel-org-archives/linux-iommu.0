Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186CB1E898
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713953088; cv=none; b=SqoPoBKJ7yqNoHxzdOfWh/9PYlXbXOMPBYGoyd6iJE/M023176vxOaegjoKDa5UJd5AZmHDe1N/54oaWqY0OiSod4ixd/ilYUTcj66VwokeVGt4GhIwCWhpl/VTjOkkhYfSit8hV2ye6HujM/HXaBS0kBY3/MVTs7+JolAjUiQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713953088; c=relaxed/simple;
	bh=BGQvchWyLfKZDVca3qKuN3xFFmSB2LxFW2pjdFx71ZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lrHz7sp7Bo4GeJIvVqsxxEJjDoc5rryrTg+4NBGtHdy2PnPl3vm2yjLaeWDD8IqoNrX3XeIBkoVlhgd+Z37DyXKqaTUEQ8suywpWRIOleWaA13X2eiEg5ZvrlSXSJqJbR8trzdxs97csLysJxU8Ay2Ina/PmyVgBE8IHvikTQPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08D3E339;
	Wed, 24 Apr 2024 03:05:14 -0700 (PDT)
Received: from [10.1.25.156] (unknown [10.1.25.156])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A89AB3F73F;
	Wed, 24 Apr 2024 03:04:44 -0700 (PDT)
Message-ID: <90985ae5-fa1c-40f5-b4b3-57350a16e011@arm.com>
Date: Wed, 24 Apr 2024 11:04:43 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] iommu/arm-smmu-v3: Add feature detection for HTTU
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 joro@8bytes.org, kevin.tian@intel.com, nicolinc@nvidia.com,
 mshavit@google.com, robin.murphy@arm.com, will@kernel.org,
 joao.m.martins@oracle.com, jiangkunkun@huawei.com, zhukeqian1@huawei.com,
 linuxarm@huawei.com
References: <20240222094923.33104-1-shameerali.kolothum.thodi@huawei.com>
 <20240222094923.33104-2-shameerali.kolothum.thodi@huawei.com>
 <3733929c-657e-4d24-b5e9-a5d946645abe@arm.com>
 <20240423145237.GD772409@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240423145237.GD772409@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/04/2024 15:52, Jason Gunthorpe wrote:
> On Tue, Apr 23, 2024 at 03:41:30PM +0100, Ryan Roberts wrote:
>> Hi,
>>
>> I'm aiming to (slowly) get more involved with SMMU activities, although I'm sure
>> it will take a while to get up to speed and provide useful input. It was
>> suggested that this series would be a useful starting point to dip my toe in.
>> Please bear with me while I ask stupid questions...
> 
> Nice!
> 
> I would like to see this merged as it was part of the original three
> implementations for iommufd dirty tracking. The other two have been
> merged for a long time now..

My understanding is that this series should pretty much apply on top of
mainline, is that correct? (in practice there are some conflicts, but I think
they are trivial).

I don't think it depends on anything new in your smmuv3_newapi branch?

Could you point me to any series you have on list that I could help with review on?

> 
> Jason

