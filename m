Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE18396B9D
	for <iommu@lists.linux.dev>; Fri,  6 Mar 2026 13:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772803344; cv=none; b=p3P0d11ffo8FcLXm7iVyi2G0vMXWkAYn7ifuS5/0qdG4HjPOgJ0woDAYALKrZ5tsBfo0vHCimWLdDAq1UF29NStYD/M/8oMRxNsJPlRpJcvqgpXIWLe7Mb1QyNMkeMuq07y9osH59p84jecRPhS5Ae1eTkVotRFHpXSU9uoXCoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772803344; c=relaxed/simple;
	bh=11QXhQfuvUNRlJINKf5EH7huhyH6YK705G82NDC1sUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gaavpQfk5024cwJFdbM07ShgVlrXnLiEJJRGZYsDFUtUHBylNpz924iDONR5tjNtE7RHYCDG+iBuJOx52SiNZlhGJ6AHIXNm0dH8IDV/ID2AMv3wcwGwFD1P4nn3tzLrFqPA9zRNSPFciV5rUnQw2SVe2L4AFiZYo1pz6NuvVog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD4CD497;
	Fri,  6 Mar 2026 05:22:13 -0800 (PST)
Received: from [10.57.57.97] (unknown [10.57.57.97])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE9CC3F836;
	Fri,  6 Mar 2026 05:22:13 -0800 (PST)
Message-ID: <60d77adc-d5a6-40e2-a497-a57004f23e7e@arm.com>
Date: Fri, 6 Mar 2026 13:22:11 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, joro@8bytes.org, bhelgaas@google.com, rafael@kernel.org,
 lenb@kernel.org, praan@google.com, kees@kernel.org,
 baolu.lu@linux.intel.com, smostafa@google.com,
 Alexander.Grest@microsoft.com, kevin.tian@intel.com,
 miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, vsethi@nvidia.com
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com> <aanygWWZLA1htDdQ@Asurada-Nvidia>
 <20260305234158.GB1651202@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260305234158.GB1651202@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-03-05 11:41 pm, Jason Gunthorpe wrote:
> On Thu, Mar 05, 2026 at 01:15:45PM -0800, Nicolin Chen wrote:
> 
>> You mean in arm_smmu_cmdq_issue_cmdlist() that issued the timed
>> out ATC command?
> 
> Yes, it was my off hand thought.
> 
>> So my test case was to trigger a device fault followed by an ATC
>> command. But, I found that the ATC command submission returned 0
>> while only the ISR received:
>>      CMDQ error (cons 0x03000003): ATC invalidate timeout
>>      arm_smmu_debugfs_atc_write: ATC_INV ret=0
>>
>> It seems difficult to insert a CMDQ_OP_CFGI_STE in the submission
>> thread?
> 
> I didn't look, but I thought the CMDQ stops on the ATC invalidation,
> flags the error and the ISR NOP's the failing CMDQ entry and restarts
> it to resume the thread? Is that something else?
> 
> If so you could insert the STE flush instead of a NOP

Nope, sadly the timeout is asynchronous, and CERROR_ATC_INV_SYNC is only 
reported on the *next* CMD_SYNC - it can't even tell us which 
CMD_ATC_INV(s) had a problem. Also there is no NOP; currently the only 
command rewriting we do is for CERROR_ILL, where we turn the illegal 
command into a CMD_SYNC.

We couldn't necessarily rely on being able to rewind the hardware CONS 
pointer from a CMD_SYNC, as by that point we're likely to have observed 
it and updated llq->cons, such that other threads could move llq->prod 
forward and fill that space with new commands.

Thanks,
Robin.

> Otherwise the arm_smmu_cmdq_issue_cmdlist() can just push another CMD
> to the queue and sync, it is obviously in a context that can do that.
> 
> Jason

