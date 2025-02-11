Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6245C263C97;
	Tue, 11 Feb 2025 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308402; cv=none; b=pF/Izk8RotgDwxr4AnP99ASdhRXMhjYU4a88tDFnXGjWxHRalpSMwBzh0gdltCSsdPqzNcxwxUwrvBH2uqMeCcXmna4KrR7/lGa8PVxQZGsOP1mqyP7oCmnXWPaP7A2a/Yk8q4y2S++FYQkObzHUetY1jTJQbNwtNAbO2eBL2lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308402; c=relaxed/simple;
	bh=+OTFB44uko1/DM7HK6FfvYUYcwW5Mc0PpeWcRkJ2+I0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZ6Jfuch7C8NSxEFsZYRDYfnMA10379k2k0eN3CprAbZi+CV4znetspJg390wVf10A6WDJNHxWYysLXz1h+9qPP97OyFRGyYhD1HAsImPfelQ/LNIrH77c72/mAhkcOi6myY0Ko5d6Ru6DdN6Bnxo3P0QlsAAODCUgFgprcB9aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D63E1D14;
	Tue, 11 Feb 2025 13:13:39 -0800 (PST)
Received: from [10.57.35.63] (unknown [10.57.35.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 533493F5A1;
	Tue, 11 Feb 2025 13:13:15 -0800 (PST)
Message-ID: <97dfb0d9-1d7d-4174-9a7d-aac6f4ffaea8@arm.com>
Date: Tue, 11 Feb 2025 21:13:13 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] iommu/dart: Assert !locked when configuring
To: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: Sven Peter <sven@svenpeter.dev>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250210-locked-dart-v1-0-5d97fe247f35@rosenzweig.io>
 <20250210-locked-dart-v1-5-5d97fe247f35@rosenzweig.io>
 <756ba6d7-b18e-4139-851b-496b1820117a@arm.com>
 <20250211192152.GA810942@robin.jannau.net>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250211192152.GA810942@robin.jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-02-11 7:21 pm, Janne Grunau wrote:
> On Tue, Feb 11, 2025 at 06:41:00PM +0000, Robin Murphy wrote:
>> On 2025-02-10 7:39 pm, Alyssa Rosenzweig wrote:
>>> Configuration is only possible and needed for non-locked DARTs and will
>>> fail for locked DARTs. We cannot try -- assert that we do not.
>>
>> Except now we absolutely will - if a locked DART and its client device
>> are advertised to Linux, instead of gracefully refusing to touch it,
>> we'll now attach the client to a DMA domain, firing a barrage of
>> multiple WARNs in the process, and give it DMA ops which still cannot
>> work. I'm not really convinced this series on its own leaves us in a
>> better position than we're already in now... :/
>>
>> How hideous is the rest of what's required to actually make this usable?
> 
> The TTBR can not be changed but the preset first level table can
> modified at will. The driver keeps a shadow first label table and syncs
> that to the preset 1st level table on flush_tbl().
> It gets more complicated by the fact that the iommu for the display
> coprocessor is locked and mappings for its firmware and boot framebuffer
> are preinstalled and have to be maintained or restored on
> initialization.
> This is handled via reserved memory with translation.
> 
> Downstream change to handle this is in
> https://github.com/AsahiLinux/linux/commit/d90cc3590ea460e1c574b4b7c47fdafb2794af6a
> not including the change to parse / handle reserved memory with
> translation in iommu core.

Oh, if we handwave away the reserved region stuff for now, it doesn't 
seem *too* terrible, so definitely worth trying to land the bones of it 
along with this prep work, I reckon. From a quick look I think it might 
possibly be even cleaner as an io-pgtable quirk, to essentially skip 
allocating/freeing L1 and have some mechanism to fill in data->pgd with 
the remap afterwards (possible super cheeky version - also prepopulate 
cfg->apple_dart_cfg.ttbr and have alloc/free handle the 
remapping/unmapping themselves...). I'm not 100% sure off-hand, but 
since you avoid the DMA API and don't seem to have any other dependency 
on data->pgd having a linear map VA (other than the virt_to_phys() in 
the normal alloc path which you'd skip anyway), it feels like it ought 
to work out.

I guess to support multiple domains you do still end up having to 
save/restore the L1 contents at the driver level when attaching, so some 
kind of shadow table notion isn't entirely unavoidable... oh well, it's 
a thought, at least.

Thanks,
Robin.
