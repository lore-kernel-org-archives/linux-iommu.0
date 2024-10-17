Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F123D1D461B
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729176493; cv=none; b=dyRWyonjvTnzmnm4eyga9bhIa5ell23hFV7SBU0dee6JOT9267+sUfNLwjV+EaviF1/2gqAqrXQh3/77H+lBqYdWGKPupYzyuUCCDBDV++3M8MqlBSKRjSQbsq3m0y03lj21occRvr/DfZeeFHvJwIxGz0o2JnDvD1GmnCEP2q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729176493; c=relaxed/simple;
	bh=jC4MoM7tQYIEeDGc7s0mG+jfcCutFWrOwl3Rzs9m5YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=acXH0jHtaFlw1U5c+1PKjoY0YQ9ZC86yjF9liW0i3Dvh5du3wO7HqN6lT2fNwa7vi6eO8HFEw89XSw73D/PF0umcWaum6YY60/GbYTTjhv0/V1jwig3q3cTYnyquCtJeqJFWPiUlW/q73bhqiGE29zfVkVAk9Jf2XpH/tQbEfKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W0BCE122; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W0BCE122"
Message-ID: <32ad3314-c2bc-4d3c-b4ae-28f96ac965af@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729176487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YTWVb9RWUjH60M/uyjEmwiRUfPzjPzTlenFxRoK5pGo=;
	b=W0BCE1222ZeobCZh91PXx76cOow0MSyU7XQwDs6N7iAEyACHfcuefgx/vUTteEIR59pAe2
	BcVh1Y/HD6MlIBO4gEMzBrGlJuBQwVitlLybYdrm7wIiKHZ6Mi7baRnQjiMZ15evTVEK1R
	y7DR+ixRjsSHDglqYB2KSEozDkvqJ6k=
Date: Thu, 17 Oct 2024 10:48:00 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [syzbot] [iommu?] kernel BUG in dma_alloc_attrs
To: Christoph Hellwig <hch@lst.de>
Cc: syzbot <syzbot+b4bfacdec173efaa8567@syzkaller.appspotmail.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 m.szyprowski@samsung.com, robin.murphy@arm.com,
 syzkaller-bugs@googlegroups.com
References: <670ebde5.050a0220.d9b66.0154.GAE@google.com>
 <20241016080240.GA30380@lst.de>
 <da9db10e-98fd-405c-9167-a29235f5470b@linux.dev>
 <20241017144020.GA22666@lst.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20241017144020.GA22666@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/17/24 10:40, Christoph Hellwig wrote:
> On Thu, Oct 17, 2024 at 10:31:40AM -0400, Sean Anderson wrote:
>> On 10/16/24 04:02, Christoph Hellwig wrote:
>> > The problem is that the dma alloc/free tracing calls virt_to_phys
>> > on the allocated/free memory.  But that memory can be vmalloced as
>> > in this case.  I think we don't have weirdo allocators or pools any
>> > more that are neither in the direct kernel mapping or vmalloc, so
>> > we might be able to do an
>> > 
>> > 		if (is_vmalloc_addr())
>> > 			page_to_phys(vmalloc_to_page()))
>> 
>> Do we need offset_in_page?
> 
> The DMA allocator always returns page aligned memory.
> 
>> Since this function returns a virtual address, I think that would be
>> fine.
> 
> Ok, I'll look into that.  I'll need to check if %p gets obsfucated
> for traces like it does for normal dmesg first, though.
> 

I have a patch written up for this; will send it after testing.

--Sean
