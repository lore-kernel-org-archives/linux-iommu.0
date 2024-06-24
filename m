Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C96F13DBAD
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235938; cv=none; b=X8LCJ5KSNObR9OP4xh8cSCsESU3uR13xVUmKv+ThWzWV+LtT02id6EUpGrmCvvxxMYasm8iuuYHJhguiRytHOZqUn+WJgMottINHifqBlg/cfm2zeJsIIr3WMNItlPEudnzQB3ccOwwUFC3x9SyLVQTipAfU/m3aizQeU4Oxk68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235938; c=relaxed/simple;
	bh=zrkwHiNIQ2L8lyXpvA3rc8HPF5KTBzpD1FEkTtXmBz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QbQRRX7SupWKVzwnSlCS7tOq2DSujylP6p96aOzB2q8ByebWUIx0J+fi1z2rYD6yTiHcZDkZxxxbyKG5h9HATgE2AucIXYNKtZTvX4im1UrHm5k5XHRXP8PG6kdZHVQlwpnPuWCsCosPqJOx9RB6ogBN8X8iEjlz7vzC27URcEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21F5FDA7;
	Mon, 24 Jun 2024 06:32:40 -0700 (PDT)
Received: from [10.57.74.124] (unknown [10.57.74.124])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 211473F6A8;
	Mon, 24 Jun 2024 06:32:13 -0700 (PDT)
Message-ID: <c4c44f66-fb9c-4d71-ac35-f3fef75832bd@arm.com>
Date: Mon, 24 Jun 2024 14:32:12 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/iova: Bettering utilizing cpu_rcaches in no-strict
 mode
To: "zhangzekun (A)" <zhangzekun11@huawei.com>, joro@8bytes.org,
 will@kernel.org, john.g.garry@oracle.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240624083952.52612-1-zhangzekun11@huawei.com>
 <5149c162-cf38-4aa4-9e96-27c6897cad36@arm.com>
 <0322849d-dc1f-4e1c-a47a-463f3c301bdc@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <0322849d-dc1f-4e1c-a47a-463f3c301bdc@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-06-24 2:13 pm, zhangzekun (A) wrote:
> 
> 在 2024/6/24 18:56, Robin Murphy 写道:
>> On 2024-06-24 9:39 am, Zhang Zekun wrote:
>>> Currently, when iommu working in no-strict mode, fq_flush_timeout()
>>> will always try to free iovas on one cpu. Freeing the iovas from all
>>> cpus on one cpu is not cache-friendly to iova_rcache, because it will
>>> first filling up the cpu_rcache and then pushing iovas to the depot,
>>> iovas in the depot will finally goto the underlying rbtree if the
>>> depot_size is greater than num_online_cpus().
>>
>> That is the design intent - if the excess magazines sit in the depot 
>> long enough to be reclaimed then other CPUs didn't want them either. 
>> We're trying to minimise the amount of unused cached IOVAs sitting 
>> around wasting memory, since IOVA memory consumption has proven to be 
>> quite significant on large systems.
> 
> Hi, Robin,
> 
> It does waste some memory after this change, but since we have been 
> freeing iova on each cpu in strict-mode for years, I think this change 
> seems reasonable to make the iova free logic identical to strict-mode.
> This patch try to make the speed of allcating and freeing iova roughly 
> same by better utilizing the iova_rcache, or we will more likely enter 
> the slowpath. The save of memory consumption is actually at the cost of 
> performance, I am not sure if we need such a optimization for no-strict 
> mode which is mainly used for performance consideration.
> 
>>
>> As alluded to in the original cover letter, 100ms for IOVA_DEPOT_DELAY 
>> was just my arbitrary value of "long enough" to keep the initial 
>> implementation straightforward - I do expect that certain workloads 
>> might benefit from tuning it differently, but without proof of what 
>> they are and what they want, there's little justification for 
>> introducing extra complexity and potential user ABI yet.
>>
>>> Let fq_flush_timeout()
>>> freeing iovas on cpus who call dma_unmap* APIs, can decrease the overall
>>> time caused by fq_flush_timeout() by better utilizing the iova_rcache,
>>> and minimizing the competition for the iova_rbtree_lock().
>>
>> I would have assumed that a single CPU simply throwing magazines into 
>> the depot list from its own percpu cache is quicker, or at least no 
>> slower, than doing the same while causing additional 
>> contention/sharing by interfering with other percpu caches as well. 
>> And where does the rbtree come into that either way? If an observable 
>> performance issue actually exists here, I'd like a more detailed 
>> breakdown to understand it.
>>
>> Thanks,
>> Robin.
>>
> 
> This patch is firstly intent to minimize the chance of softlock issue in 
> fq_flush_timeout(), which is already dicribed erarlier in [1], which has 
> beed applied in a commercial kernel[2] for years.
> 
> However, the later tests show that this single patch is not enough to 
> fix the softlockup issue, since the root cause of softlockup is the 
> underlying iova_rbtree_lock. In our softlockup scenarios, the average
> time cost to get this spinlock is about 6ms.

That should already be fixed, though. The only reason for 
fq_flush_timeout() to interact with the rbtree at all was due to the 
notion of a fixed-size depot which could become full. That no longer 
exists since 911aa1245da8 ("iommu/iova: Make the rcache depot scale 
better").

Thanks,
Robin.
