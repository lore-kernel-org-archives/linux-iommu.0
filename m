Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE771B4F2A
	for <iommu@lists.linux.dev>; Mon, 14 Oct 2024 18:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728929369; cv=none; b=JPHIUp52NlT4JTz6RgIkpeQkeyY75autnHZLVq72+x1QZoR9srOXBV8fLQjaOwFhbwXK/ldCs0nhMSAy5uTLB7fArcvxm4W+PW9vbtZPElRi3Vwia0TyJuY19/Qx+8/pXyaxGekWHxaPJGkLnQPa8YUKF+m3mT+ZUz5CZZs64vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728929369; c=relaxed/simple;
	bh=QWPFvEXhnNSElL02iFk/bzB2xt65kkr795ytO+XzExM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8DVYYA10sonu3/aTSKEamg+xpiw+aVITEetCtNc33Aof0Igaxo1uBqv5IpZkWI54ncJZWjOu1cOTe54u0ptvpBxLOh1kO0xlTfA4pyxIbNqwpl33FbotVKbek4JBHYSfIYjiBGKMlhqx/o3xNavtqMTLCfePMs8QtsLoCTJQAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C93B1007;
	Mon, 14 Oct 2024 11:09:55 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 513A73F71E;
	Mon, 14 Oct 2024 11:09:24 -0700 (PDT)
Message-ID: <7411ae1d-5e36-46da-99cf-c485ebdb31bc@arm.com>
Date: Mon, 14 Oct 2024 19:09:08 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Report] annoyed dma debug warning "cacheline tracking EEXIST,
 overlapping mappings aren't supported"
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>,
 Hamza Mahfooz <someguy@effective-light.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-block@vger.kernel.org,
 io-uring@vger.kernel.org, linux-raid@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <ZwxzdWmYcBK27mUs@fedora>
 <426b5600-7489-43a7-8007-ac4d9dbc9aca@suse.de>
 <20241014074151.GA22419@lst.de> <ZwzPDU5Lgt6MbpYt@fedora>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <ZwzPDU5Lgt6MbpYt@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/10/2024 8:58 am, Ming Lei wrote:
> On Mon, Oct 14, 2024 at 09:41:51AM +0200, Christoph Hellwig wrote:
>> On Mon, Oct 14, 2024 at 09:23:14AM +0200, Hannes Reinecke wrote:
>>>> 3) some storage utilities
>>>> - dm thin provisioning utility of thin_check
>>>> - `dt`(https://github.com/RobinTMiller/dt)
>>>>
>>>> I looks like same user buffer is used in more than 1 dio.
>>>>
>>>> 4) some self cooked test code which does same thing with 1)
>>>>
>>>> In storage stack, the buffer provider is far away from the actual DMA
>>>> controller operating code, which doesn't have the knowledge if
>>>> DMA_ATTR_SKIP_CPU_SYNC should be set.
>>>>
>>>> And suggestions for avoiding this noise?
>>>>
>>> Can you check if this is the NULL page? Operations like 'discard' will
>>> create bios with several bvecs all pointing to the same NULL page.
>>> That would be the most obvious culprit.
>>
>> The only case I fully understand without looking into the details
>> is raid1, and that will obviously map the same data multiple times
> 
> The other cases should be concurrent DIOs on same userspace buffer.

active_cacheline_insert() does already bail out for DMA_TO_DEVICE, so it 
returning -EEXIST to tickle the warning would seem to genuinely imply 
these are DMA mappings requesting to *write* the same cacheline 
concurrently, which is indeed broken in general.

Thanks,
Robin.
