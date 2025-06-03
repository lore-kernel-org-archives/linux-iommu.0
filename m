Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5721199385;
	Tue,  3 Jun 2025 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748972653; cv=none; b=lrBL/dWS5urOt/PoDlCtHKjkU+v9FdQ6HonT9VL7bt2CWzh4Vc9kTx4XtLvnFfjrFvHPP6ZRcujX0pGk/8DRpVUhEz+15DohN4dsC5FfGaTcqvlT73/0d/nbDZa5h3CpgHIeQelIkXvlhtJajxsivSIDxtMHzZigJTPXIcZBV40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748972653; c=relaxed/simple;
	bh=UTb8ZDSnNnfE4kNWe8QXV+RinSAafNMsCyq+Ic89xNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJ7UW6zPT3RqE4ukger0Pw1+1fiTdFDEwpCWBhpqwTbVpC4jWYM4BsPWJmiqkudmbgJZBUXlfEejHonzW3e7YEdvMEqJ6rsplO7MEENQOxYieVaORdjCzUp9wHD9AS+aOP/87TrGWMR6OqzLquOG3cCi17lKyahpHY3bKF0V3Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24B9012FC;
	Tue,  3 Jun 2025 10:43:53 -0700 (PDT)
Received: from [10.57.24.31] (unknown [10.57.24.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABF1B3F5A1;
	Tue,  3 Jun 2025 10:44:07 -0700 (PDT)
Message-ID: <ef7c8bf7-d6b1-4486-bb8c-04d24488ecdc@arm.com>
Date: Tue, 3 Jun 2025 18:43:49 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] EMEM address decode error when using Tegra210 media
 engines
To: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, joro@8bytes.org,
 will@kernel.org, jonathanh@nvidia.com, baolu.lu@linux.intel.com,
 jsnitsel@redhat.com, jroedel@suse.de, regressions@lists.linux.dev,
 linux-tegra@vger.kernel.org, iommu@lists.linux.dev
References: <62e7f7fe-6200-4e4f-ad42-d58ad272baa6@tecnico.ulisboa.pt>
 <20250603153257.GB407166@ziepe.ca>
 <46ef896e-9b73-437f-bfa9-4dcae5089028@tecnico.ulisboa.pt>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <46ef896e-9b73-437f-bfa9-4dcae5089028@tecnico.ulisboa.pt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-06-03 5:52 pm, Diogo Ivo wrote:
> 
> On 6/3/25 4:32 PM, Jason Gunthorpe wrote:
>> On Tue, Jun 03, 2025 at 04:06:47PM +0100, Diogo Ivo wrote:
>>> Hello,
>>>
>>> Commit 50568f87d1e233e introduced a regression when trying to use the 
>>> media
>>> accelerators present on the Tegra X1 SoC.
>>>
>>> I came across this regression when testing the branch [1] that leverages
>>> the NVJPG engine in the Tegra X1 for decoding a JPEG file. After commit
>>> 50568f87d1e233e we see the following error messages after submitting 
>>> a job
>>> through the TEGRA_CHANNEL_SUBMIT IOCTL:
>>
>> Maybe this?
>>
>> @@ -567,7 +567,7 @@ static void tegra_smmu_set_pde(struct 
>> tegra_smmu_as *as, unsigned long iova,
>>          /* The flush the page directory entry from caches */
>>          dma_sync_single_range_for_device(smmu->dev, as->pd_dma, offset,
>> -                                        sizeof(*pd), DMA_TO_DEVICE);
>> +                                        sizeof(pd->val[0]), 
>> DMA_TO_DEVICE);
>>          /* And flush the iommu */
>>          smmu_flush_ptc(smmu, as->pd_dma, offset);
>>
>> It is the only mistake I was able to notice.
>>
>> But I'd be puzzled - I'd expect bigger sizeof would make it slower not
>> broken.. Though your crash sure looks like either missing cache
>> coherency or a bad PTE construction.

I reckon the "unsigned long offset = pd_index * sizeof(*pd);" a few 
lines above is probably more impactful ;)

Robin.

>>
> 
> With this change there is still an error:
> 
> [   21.794016] tegra-mc 70019000.memory-controller: nvjpgsrd: read 
> @0x00000000ffffbe00: EMEM address decode error (SMMU translation error 
> [--S])
> [   21.804409] tegra-mc 70019000.memory-controller: nvjpgsrd: read 
> @0x00000000ffffbe00: Page fault (SMMU translation error [--S])
> 
> the difference being that we only get it for one address compared to the
> previous log.
> 
> Diogo

