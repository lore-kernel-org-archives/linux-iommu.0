Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795091097;
	b=T+SnOqgDYTkm9EOCVlt6YJ3vUq4/d9r26Cd47TxLrzdUnFB/CUcJ+CueOFJxFgqVMX3E
	 W48MXSI+9Ylt4ZImvN2sjuPARdaMU5kIOP9Dlrg1fELs6ODZtWK93AxnVXGWjekFoKeZQ
	 av5/tTIdQh3C5hcx8+LqaslEHtl2FJT3+cjvXVYGZvhOIcrPGpzguc+4Mm5k4XIA9e2x7
	 qiSEwSgpkCvbreDGKh8P8F6hBv3rsxNtSjUoZFKVuRuIyhcUJClcBLE4fVFIt+BQ8uMTJ
	 hiyY5Ny62xCaioxqAlnca2Zf7Tihpqdn6KIzGSTvDqrCgrwvu52ZDyyZ9S92+pmZkLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795091097;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=rNajSngytGm8mtvAWgpqThXqlpNe7qAFM40MIDd7694=;
	b=suv1/KFnQyWLUK7lmMofefJhy7WnfWL7Esq/mSgFgcYjX6WKRrFOCZ+qJUBC2suXBDLZ
	 /i+kgEJpL6iU31jCJWbv1B6/rdsoXNP/AqzZUxSTQUR8xoefMN+RyFskTLqW10y0I6oie
	 31+W90/K0CIE5Rdd8/Cd3o+FIB8rLquHMgZ7GHTlZqxhDwyTTxOOtcyd2JOm1jMG2T7SO
	 DG1lCPIxYjk7Uqpr+4gmKHBOUbgwL3E5mtwKxjVIE8t1BuxmHhFAWsYXhQgCS71Z4Wpl2
	 fhfMZ3lQzvG833nPkJbQ9F+F6kgC/fmunZLwEOynGmYouShGgAt8HglP2SA5v4GYeSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ZiQznPLn;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2550A606A324;
	Thu, 19 Nov 2026 12:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2550A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ZiQznPLn
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D0AA1575;
	Thu, 19 Nov 2026 04:24:53 -0800 (PST)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E11413F673;
	Thu, 19 Nov 2026 04:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795091096; bh=QBq9PQw0Pr94poUNHbDPbL4VDmT2XAawnGIjosmoAJI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZiQznPLnW5HNhPtyf5c5HsUBV7TdtnmUz89PVcL0CxCieqVWSDx27MkItSb51oT3L
	 iPto6OFmcmm+RT1ygM+PVHKS1wQlcblpmjOSJ+MyULm+nIsuI6M63/AU7CZSjNT2Pn
	 Ea0eKc7ffcjE6T/63cjVT35v+Xm6NftdkCmgL3tM=
Message-ID: <fe60c0bd-1ee2-4b33-8ca3-564ee08e6db5@arm.com>
Date: Thu, 19 Nov 2026 12:24:50 +0000
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] rust: iommu: add a paging domain abstraction
To: Jason Gunthorpe <jgg@ziepe.ca>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, iommu@lists.linux.dev,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev, Detlev Casanova <detlev.casanova@collabora.com>
References: <20261112-b4-iommu-domain-v1-0-c29e86788dda@collabora.com>
 <20261116193821.GC2452510@ziepe.ca>
 <3EB4C2ED-B699-4532-A562-68B78F6E29C6@collabora.com>
 <20261117202055.GA3115493@ziepe.ca>
 <b145b2ceb92c73a4fa0477d7b3895a6e3b4adf99.camel@collabora.com>
 <20261118160909.GC3115493@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20261118160909.GC3115493@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/11/2026 4:09 pm, Jason Gunthorpe wrote:
> On Wed, Nov 18, 2026 at 10:25:58AM -0500, Nicolas Dufresne wrote:
>> Hi,
>>
>> Le mardi 17 novembre 2026 à 16:20 -0400, Jason Gunthorpe a écrit :
>>> On Tue, Nov 17, 2026 at 05:09:11PM -0300, Daniel Almeida wrote:
>>>> Hi Jason,
>>>>
>>>>> On 16 Nov 2026, at 16:38, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>>>>
>>>>> On Thu, Nov 12, 2026 at 02:00:07PM -0300, Daniel Almeida wrote:
>>>>>> This series adds a Rust abstraction for IOMMU paging domains. A driver
>>>>>> can allocate a domain, attach it to its device, map pages into it, and
>>>>>> install a handler for its faults.
>>>>>>
>>>>>> This will be used by the upcoming rkvenc driver that my colleagues
>>>>>> Detlev Casanova, Nicolas Dufresne and I are working on. More details on
>>>>>> this driver can be found by watching Nicolas Dufresne's talk at LPC 2026
>>>>>> [0].
>>>>>>
>>>>>> As part of the security model, each client will have its own IOMMU
>>>>>> domain. This is needed as the submission model will let userspace set
>>>>>> most of the encoder's registers directly, so the kernel cannot check
>>>>>> every memory access that a job makes the encoder do. With a single
>>>>>> domain, one client could make the encoder read or write the memory of
>>>>>> another client.
>>>>>
>>>>> How do you plan to get the paging domain in the first place?
>>>>
>>>> We plan to alloc a paging domain when a video encoder session is created. Then
>>>> we call iommu_attach_device() before a job runs, and detach back to the default
>>>> domain after it finishes so the next job can attach its own session's domain.
>>>> This is so each session is isolated from each other.
>>>
>>> If you do that you can't use the DMA API at all in your driver as you
>>> have to set 'driver_managed = true'. Is it OK? If it is why not just
>>> use VFIO?
>>>
>>> Or are you planning DT horrors to get yourself a DT created "DMA
>>> struct" ?
>>
>> This seem to digress. All we want to do is use the iommu subsystem as intended
>> for the case the iommu driver is not inside the DRM driver (which seems to have
>> never been the case so far in DRM).
> 
> "As intended" means you use the DMA API and you do not touch
> the paging domain.
> 
> "As intended" means you use iommufd if you want a domain full of user
> controlled mappings.

There is a middle ground, where a kernel driver wants pages to appear at 
specific IOVAs under its own control. This is entirely legitimate to do 
by using the public IOMMU API "as intended" - the fact that people often 
also try to do the wrong things for the wrong reasons, and that any 
attempt to involve dma-buf usually ends up a hot mess, does not make 
that basic premise unsound.

>> The existing infra for that (in C) is pretty abstract an simple in
>> my opinion, and built into the DMA API if you manage which domain to
>> attach to your device at the right time.
> 
> What does this even mean? The DMA API owns the domain, not the
> driver.
> 
> All the cases using these APIs in DRM and media are troubled in one
> way or another.
> 
> For example the recent revelation they have always been using DMABUF entirely wrong:
> 
> https://lore.kernel.org/all/20261009125338.GB13920@nvidia.com/
> 
> Tegra desires to undo their abuses.
> 
> It was never intended for things to work like this, there is missing
> infrastructure.
> 
>> To me, it fits CODEC HW driver which are also simple. The DT horrors
>> you refer to seems totally unfounded, you just describe the iommu
>> and the iommu subsystem will manage it for your device.
> 
> "unfounded? You are not following along, I've written about this now
> many times to many different people. Follow the links and discussion
> from here:
> 
> https://lore.kernel.org/all/20260917144804.GI3196566@ziepe.ca/
> 
> If you use DT correctly there is no place to attach an iommu_domain to
> and you can't even use these APIs. You get DMA API only and that's it.
> 
> You have to do something "wrong" in DT to create fake HW devices to
> even give you a struct device to even attach something to.
> 
> Or you have to entirely give up DMA API and attach to your only struct
> device.

I can't speak for the actual intent of the Rust drivers, but giving them 
the benefit of the doubt, none of that fearmongering should apply: the 
valid use-case is just simple time-division multiplexing.

A = iommu_paging_domain_alloc(dev);
B = iommu_paging_domain_alloc(dev);
iommu_attach(dev, A);
iommu_map(A, iova_x, virt_to_phys(X));
dma_map(dev, X) //still needed for the underlying memory
... //tell dev to do the work for context A using iova_x
dma_unmap(dev, X);
dma_map(dev, Y);
iommu_map(B, iova_y, virt_to_phys(Y));
iommu_detach(dev, A);
iommu_attach(dev, B);
... //do some work in context B

...and so on. The only real subtlety is that while you still need to 
make the DMA map/unmap calls as usual (for the sake of managing cache 
coherency), you only use the returned DMA address for checking 
dma_mapping_error() and the subsequent dma_unmap(); the address you give 
to the device is your own IOVA for the mapping through your unmanaged 
domain.

Plus as I mentioned recently in one of those sketchy dma-buf threads, 
it's also true that at the moment, iommu-dma will still do a load of 
unnecessary work in the unattached default domain for reasons that were 
valid 5 years ago, but that now can and really should be optimised out. 
I guess I'll have to steal a day or two from what I'm supposed to be 
doing to write that patch before I get fed up of explaining it :)

Thanks,
Robin.
