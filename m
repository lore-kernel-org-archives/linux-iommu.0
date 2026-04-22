Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008B53659FF
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875809; cv=none; b=gXsP2ihXqkJeNy31NA/V3cBJ9e4vZRZOYgZONHdkn1hq4eI6T1WCT0Fd+42Lh9JH4TSXGUkSoKNtVsHBYwAG+xGUpCu4nYUBo5SXLc0406V+sqNRSHlqTbNg54yO1Vthk0EWQJfkOEu7am7leNXkbEvInTmPx+DOuF0al6iK+ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875809; c=relaxed/simple;
	bh=3kpEt4tyIzeCujOrtWwP6Mi5ZUwWwYdyZCmkAKnE9Mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=laafPVqvCUO+nUmyEJ8jFQs/oCtS/7HzFrMNZX9MtLrnw7PSh3OWBSgiTI9S9SzB+ojEUgQq4dy4QGJy3YeF3vPLmsmWOvR4YTXTuUoOOOtigTzZ4/HhLEyhwX1h3aN9AHDMnX+Wgo4Qc+8h+pBr1xx8BOaW9XtOjUidrP5pSK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ITv64P78; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ITv64P78"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE0751F37;
	Wed, 22 Apr 2026 09:36:41 -0700 (PDT)
Received: from [10.57.20.180] (unknown [10.57.20.180])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52DEE3F23F;
	Wed, 22 Apr 2026 09:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776875807; bh=3kpEt4tyIzeCujOrtWwP6Mi5ZUwWwYdyZCmkAKnE9Mc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ITv64P78gbm2ng42VydpF4SeOSQjad7OUzqS3oRcwOqKG3QTWwVkjzlNGc88e6Rpp
	 DRiBEDCt52mbHoYdVay6aWU0Z5fJPTNDB3lJySbMCL7CBZ5Xot95JVzzk8emtYTq49
	 yXJ93u1tw6FaNahRjKDUTuUIQsJ5qzfWIhyt7XFA=
Message-ID: <fe618d83-fe9d-4b35-a1e7-f71b703cfd7e@arm.com>
Date: Wed, 22 Apr 2026 17:36:33 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3: Allow disabling Stage 1 translation
To: Jason Gunthorpe <jgg@ziepe.ca>, Evangelos Petrongonas <epetron@amazon.de>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Pranjal Shrivastava <praan@google.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 nh-open-source@amazon.com, Zeev Zilberman <zeev@amazon.com>
References: <20260420123221.20801-1-epetron@amazon.de>
 <20260420124032.GO2577880@ziepe.ca>
 <20260422064431.GA49867@dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com>
 <20260422162351.GK3611611@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260422162351.GK3611611@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-04-22 5:23 pm, Jason Gunthorpe wrote:
> On Wed, Apr 22, 2026 at 06:44:31AM +0000, Evangelos Petrongonas wrote:
>> The motivation is live update of the hypervisor: we want to kexec into a
>> new kernel while keeping DMA from passthrough devices flowing, which
>> means the SMMU's translation state has to survive the handover. The Live
>> Update Orchestrator work [1] and the in-progress  "iommu: Add live
>> update state preservation" series [2] are building exactly this plumbing
>> on top of KHO; [2]'s cover letter calls out Arm SMMUv3 support as future
>> work, and an earlier RFC from Amazon [3] sketched the same idea for
>> iommufd.
> 
> It would be appropriate to keep this patch with the rest of that out
> of tree pile, for example in the series that enables s2 only support
> in smmuv3.

Or even better, just make sure that whatever hypervisor supports this 
half-finished WIP mechanism also uses IOMMU_HWPT_ALLOC_NEST_PARENT to 
explicitly get stage 2 domains for VM-assigned devices in the first 
place, rather than swing a big hammer at the kernel (that takes out 
SVA/PASID support as collateral damage...)

Thanks,
Robin.

>> For this use case, Stage 2 is materially easier to persist than Stage 1,
>> for structural rather than performance reasons:
> 
> I don't think so. The driver needs to know each and every STE that
> will survive KHO. The ones that don't survive need to be reset to
> abort STEs. From that point it is trivial enough to include the CD
> memory in the preservation.
> 
> It would help to send a preparation series to switch the ARM STE and
> CD logic away from dma_alloc_coherent and use iommu-pages instead,
> since we only expect iommu-pages to support preservation..
> 
> I could maybe see only supporting non-PASID as a first-series, but a
> CD table with SSID 0 only populated is still pretty trivial.
> 
> Jason

