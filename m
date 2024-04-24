Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B471422AF
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713962745; cv=none; b=aPjOnuiRwtVwNo8lfFtYs10CABwZuydlE18LuBp/MMHkE+jfe0JL74gqFQ0UO04rTglIZ/ge6q3AsFJ9D1JcFzVNAcIMLVfU2f/UEGAOKkDSkU2h7RVvsq3J8HtfZMQ5klcg/Gb21fkpO74kYYJndgXh8BJ4IaHzkNKDLeghZlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713962745; c=relaxed/simple;
	bh=Mg6SPUTi/aFTY6wOOb72TI+etsZFvSDCOSK9UP30cFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DGYrm9UtJ8ADHXZFrOU5TZNMKiF/pkKoDp5adrJnSjW15Co32zpN63ILqHsaNNg47oTeq87V06Iz1n9BOJDoV2+3cLLygpCaeiDxRsvWLVJMt+tND0/fXFNmaJWhKHRpGX53k3lr0l7N5VFG1RmDOtpsB7QHoug/gIGaetuzw1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79F2A1516;
	Wed, 24 Apr 2024 05:46:10 -0700 (PDT)
Received: from [10.1.25.156] (XHFQ2J9959.cambridge.arm.com [10.1.25.156])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 155333F73F;
	Wed, 24 Apr 2024 05:45:40 -0700 (PDT)
Message-ID: <3b7bd616-3717-4c14-8c36-733706ad50ec@arm.com>
Date: Wed, 24 Apr 2024 13:45:39 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iommu/arm-smmu-v3: Enable HTTU for stage1 with
 io-pgtable mapping
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 joro@8bytes.org, kevin.tian@intel.com, nicolinc@nvidia.com,
 mshavit@google.com, robin.murphy@arm.com, will@kernel.org,
 joao.m.martins@oracle.com, jiangkunkun@huawei.com, zhukeqian1@huawei.com,
 linuxarm@huawei.com
References: <20240222094923.33104-1-shameerali.kolothum.thodi@huawei.com>
 <20240222094923.33104-5-shameerali.kolothum.thodi@huawei.com>
 <364b6a6f-048c-426c-a9c4-aabef551e0c0@arm.com>
 <20240423173202.GB941030@nvidia.com>
 <adbd2725-25c9-469d-a9e4-14fffc1521aa@arm.com>
 <20240424121517.GG941030@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240424121517.GG941030@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/04/2024 13:15, Jason Gunthorpe wrote:
> On Wed, Apr 24, 2024 at 08:58:41AM +0100, Ryan Roberts wrote:
> 
>> Or perhaps I've misunderstood your comment and there is actually always a 1:1
>> relationship between domain and pgtable? But a 1:* relationship between domain
>> and CD?
> 
> Yes, this is the case

Great thanks! See - I said I'd be asking stupid questions...

> 
> Jason

