Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4603840802F
	for <iommu@lists.linux.dev>; Mon,  3 Aug 2026 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760558; cv=none; b=BjWTx/gtKLBwLEewgKN1jLNNKbVzuf5qTWyBOrcHuJfSHTLp/YApksNiSY/z+6nhBzDhsJK5PPCLfPf8zrtfiiuZcNucoMWGujMzoSluhiGXlWp8GtlCN4q9YkXxjYUwLdIHfKqeWGIQW5wmBAL6JvnY7G1Ab/GhQe5bxYJ20hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760558; c=relaxed/simple;
	bh=ZMjJJGjLX5qhiZfYr2Tg/ZhY4THZbGnUayhvkoYQLNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGLJ6g8Fl6A+QL+xfL4GdKOlH9efSmyOMULHn02kRwUclbBoC+D7JxyyZRll90qFBfF8ovklPGUd1BfQm6ER91Du8uRazm9h7KoCnjZ9GA2jvps85ybyqFJSgt3IcRkFcZdBn3CH76LAib/n9a59wRV1GC8/faq/SLtOY1p0R+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gDnxl5xZ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gDnxl5xZ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A843E143D;
	Mon,  3 Aug 2026 05:35:52 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB1FD3F66F;
	Mon,  3 Aug 2026 05:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785760556; bh=ZMjJJGjLX5qhiZfYr2Tg/ZhY4THZbGnUayhvkoYQLNk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gDnxl5xZCWP68FDWod6cKugXD7iQIhJj0mR82DmuQ9EeKCll0DdtT5w8qrPQDVHWY
	 nHMkNIuD5zM/pC/tJ7PTq3Qwa4RzaTpSgvpfkb7zkM7tThKfu9FYohLaynqTzKEDEX
	 mfGw3NeUO7/nBjRUl2XFRc0dl7brIgmUk4Ub81aM=
Message-ID: <00dae86e-cbc3-4d6e-966f-39afd4b8c2ec@arm.com>
Date: Mon, 3 Aug 2026 13:35:52 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu/arm-smmu-v3: Replace sort_nonatomic() with
 sort()
To: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, joro@8bytes.org,
 akpm@linux-foundation.org, cychu@google.com, hhchung@google.com,
 amitamishra@google.com, marscheng@google.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com
References: <20260730181216.2709088-1-visitorckw@gmail.com>
 <20260730181216.2709088-2-visitorckw@gmail.com>
 <am8MpGR14HAg58Gd@willie-the-truck> <am+CPy4+gcGPtR3G@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <am+CPy4+gcGPtR3G@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/08/2026 6:45 pm, Nicolin Chen wrote:
> On Sun, Aug 02, 2026 at 10:23:48AM +0100, Will Deacon wrote:
>> On Thu, Jul 30, 2026 at 06:12:15PM +0000, Kuan-Wei Chiu wrote:
>>> @@ -4047,9 +4047,9 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
>>>   	}
>>>   
>>>   	/* Put the ids into order for sorted to_merge/to_unref arrays */
>>> -	sort_nonatomic(master->streams, master->num_streams,
>>> -		       sizeof(master->streams[0]), arm_smmu_stream_id_cmp,
>>> -		       NULL);
>>> +	sort(master->streams, master->num_streams,
>>> +	     sizeof(master->streams[0]), arm_smmu_stream_id_cmp,
>>> +	     NULL);
>>
>> Makes sense to me. Nicolin, did you choose the nonatomic version
>> specifically?
> 
> It's probably rare to have a large multi-stream array, so I think
> sort() would be fine.

Yeah, probably 99% of the time the size of this array will be 1. An 
exceptional value of "large" might be something like 64 for a massive 
(non-PCI) DMA engine with separate read and write IDs per channel for no 
good reason.

If and when someone ever were to report RCU stalls here then we can 
first ask them what the heck their client device is... and unless and 
until then I wouldn't think it's worth worrying about.

Thanks,
Robin.
