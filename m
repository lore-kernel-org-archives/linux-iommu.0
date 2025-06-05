Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635191E1DEC
	for <iommu@lists.linux.dev>; Thu,  5 Jun 2025 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749130248; cv=none; b=M0Zemfn+C+6aGr3o2QSVlw0z2qZsNwcwncwP4MEcn/VC8h6kAjPoqsiK8Cu6rHe3CDnVPXYpoF18cWW9XHCCveGTCe7VAjNV9ZFtKz115ROWlK22N1dYrHwvoxUzoPILWL/pdkk0nt6hUAAWkd4OZ8cVo141JRbs71N4olaxBgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749130248; c=relaxed/simple;
	bh=NMWEAjEnzZjApTVwiRgXnucHoBIYdvfSZ3X1Z3+VKyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DWxBdmk0VtogsSdyJrwME7OJgLqBddsxMhDsHpMh8IbzVKo0M2hntHKQNTgVvmpzkxIpRlBXEMb8brkz19Hc4ZzSYtvRHC55/PQkWYfEO5XH/MS5RDsf9OjOXLMe8G+9XZe7ELw2uDmb7TGxNt7HKluWPvly6NSFk+dd6DYlxq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pue3hTV4; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pue3hTV4"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5533c562608so963149e87.3
        for <iommu@lists.linux.dev>; Thu, 05 Jun 2025 06:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749130244; x=1749735044; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ELiHfGb3gJOhYFEbnYSWkZyihCqMCFVCR+nZR19Yl7U=;
        b=Pue3hTV44iNv/WZO5U9alxe2zwr0uRmdNnu96sdAvpjZd6kLsmnxCKQqZaqZFduEip
         STcAAhO57VWQNMaGS28aoYB1hcRfC6E31j1fJfPfsjjMCbl7bp78ct9GNlSfFcqLBmaP
         8bHVeWrwQvgD2OCaZqFohwTxJzSZcKfdJDG+YSTXYcMAWZQcR3LvDl2IEEmjwy9o7YKI
         MWfxQZWjT1uI6t0fpLI/DB/zsr6S/eG8uf7mBLx/DF6lsFrPOp4BiAidWNSX864ukiqj
         jRKUMDXA91aOoEalocOo5ggx24K0VcO2NwpjI+cxsTpiwcMB4p822oKv2pJV+azcQRaf
         z8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749130244; x=1749735044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ELiHfGb3gJOhYFEbnYSWkZyihCqMCFVCR+nZR19Yl7U=;
        b=Lm7L3YadK0Vk5Jr75tMulJJxkh5fluWFzzLGkPnF6OOgLE5pWCIXpfjXLtzTvl2+o4
         XMb6u5zWSOfHjF7oLh4qlpf8zkaM8ykwY18YvzywgkcNoESfL3C4CWRq8eDFtkgDfcDI
         QYzJcbdvVLoUlH3KpFlUYBVC0SrHTlivVaKeLkT5MGwVWaM0ooBTCk5ScBPNfMuYXT/n
         Ci/FO8zsThbJKAg/a0FaJ42XyD/6AtEtniqQmj4saNLdZQbdJIsEdsYDRy8bv2GXCImP
         WiVAQYhlntEfV+gRKEjnA7e2phOLARFbB3Ovf4tSgHWmvwG+T5fux8P+Cu4CQ5Puqs4e
         hR7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW53wU4k4Pq+BStA2p+G5jPgnIc/aFtU89U2ehwbX+0dVLYhgTJyPBlX6bEbR7LmJ+uMq5zYA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWl8n4sjat/sgc+RizZrN/K+/8VaDpaZHsJZmt29tF5jm9Q+XE
	rUq+gkznLG+X5Teklwp0DOlwLU1AySGENcwibU1CmnjyM6APKwiz/BpN
X-Gm-Gg: ASbGnctsOksgXalqK6YQPUI6pkGB9ngzCjfLtViYCZ2Ge4INbzyhg9KCbWFEcTqCVt1
	BMs25pQdmP2pcx6CGzSHhP2few4qwabXjvhUwSDOSiWaiGpOELIe3UH4uWfBNOrsuVWK6CUpSl8
	VqMzK+6HBVoNTYMlmcyPUUzOdqg1VDrKwDD/6dAZafPl/qJp6D81Z6bWiyzHu76I8yo8vH2zx72
	sETsjIj34aB3R42iaBsJXYtMzlFexHdubLMFexOQO88yLMk6uK3P8KwcL2Ay8bPnC2gKJfhjMFd
	LloH0hJ067noxsZ5/fLlRL08+qZ/lt1ss7MXH6Y4gr3EJLjpQlyAj0JtjYzNMOEHxBA63asuuy1
	8Gy8XUGH3O5MDazurySUXGVMcRTZC
X-Google-Smtp-Source: AGHT+IEF+PITkMRWLVOjyJ0cqd4cnK3Xcxhp4Mve7qYR67GwKQOBFCd8LgQs47YQTlm7h85zXe3RRQ==
X-Received: by 2002:a05:6512:ea0:b0:553:2f57:f8af with SMTP id 2adb3069b0e04-55356bf152amr2102514e87.20.1749130244273;
        Thu, 05 Jun 2025 06:30:44 -0700 (PDT)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5533787d325sm2605610e87.49.2025.06.05.06.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 06:30:43 -0700 (PDT)
Message-ID: <27e17dbf-df6a-48fc-a652-ad48a776f668@gmail.com>
Date: Thu, 5 Jun 2025 16:30:42 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rust: add initial scatterlist bindings
To: Alexandre Courbot <acourbot@nvidia.com>, Lyude Paul <lyude@redhat.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: dakr@kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
 rust-for-linux@vger.kernel.org,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 Petr Tesarik <petr@tesarici.cz>, Andrew Morton <akpm@linux-foundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Sui Jingfeng <sui.jingfeng@linux.dev>, Randy Dunlap <rdunlap@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>
References: <20250528221525.1705117-1-abdiel.janulgue@gmail.com>
 <20250528221525.1705117-2-abdiel.janulgue@gmail.com>
 <20250529004550.GB192517@ziepe.ca> <DA9JTYA0EQU8.26M0ZX80FOBWY@nvidia.com>
 <95ff963ddabf7c3cd2cfd07d0231a0073ff6847e.camel@redhat.com>
 <DAED5BUK7TUQ.4JRHFMWZ99W3@nvidia.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <DAED5BUK7TUQ.4JRHFMWZ99W3@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/06/2025 08:51, Alexandre Courbot wrote:
> On Thu Jun 5, 2025 at 3:21 AM JST, Lyude Paul wrote:
>> On Fri, 2025-05-30 at 23:02 +0900, Alexandre Courbot wrote:
>>> On Thu May 29, 2025 at 9:45 AM JST, Jason Gunthorpe wrote:
>>>> On Thu, May 29, 2025 at 01:14:05AM +0300, Abdiel Janulgue wrote:
>>>>> +impl SGEntry<Unmapped> {
>>>>> +    /// Set this entry to point at a given page.
>>>>> +    pub fn set_page(&mut self, page: &Page, length: u32, offset: u32) {
>>>>> +        let c: *mut bindings::scatterlist = self.0.get();
>>>>> +        // SAFETY: according to the `SGEntry` invariant, the scatterlist pointer is valid.
>>>>> +        // `Page` invariant also ensures the pointer is valid.
>>>>> +        unsafe { bindings::sg_set_page(c, page.as_ptr(), length, offset) };
>>>>> +    }
>>>>> +}
>>>>
>>>> Wrong safety statement. sg_set_page captures the page.as_ptr() inside
>>>> the C datastructure so the caller must ensure it holds a reference on
>>>> the page while it is contained within the scatterlist.
>>>>
>>>> Which this API doesn't force to happen.
>>>>
>>>> Most likely for this to work for rust you have to take a page
>>>> reference here and ensure the page reference is put back during sg
>>>> destruction. A typical normal pattern would 'move' the reference from
>>>> the caller into the scatterlist.
>>>
>>> As Jason mentioned, we need to make sure that the backing pages don't get
>>> dropped while the `SGTable` is alive. The example provided unfortunately fails
>>> to do that:
>>>
>>>      let sgt = SGTable::alloc_table(4, GFP_KERNEL)?;
>>>      let sgt = sgt.init(|iter| {
>>>          for sg in iter {
>>>              sg.set_page(&Page::alloc_page(GFP_KERNEL)?, PAGE_SIZE as u32, 0);
>>>          }
>>>          Ok(())
>>>      })?;
>>>
>>> Here the allocated `Page`s are dropped immediately after their address is
>>> written by `set_page`, giving the device access to memory that may now be used
>>> for completely different purposes. As long as the `SGTable` exists, the memory
>>> it points to must not be released or reallocated in any way.
>>>
>>> To that effect, we could simply store the `Page`s into the `SGTable`, but that
>>> would cover only one of the many ways they can be constructed. For instance we
>>> may want to share a `VVec` with a device and this just won't allow doing it.
>>>
>>> So we need a way to keep the provider of the pages alive into the `SGTable`,
>>> while also having a convenient way to get its list of pages. Here is rough idea
>>> for doing this, it is very crude and probably not bulletproof but hopefully it
>>> can constitute a start.
>>>
>>> You would have a trait for providing the pages and their range:
>>>
>>>      /// Provides a list of pages that can be used to build a `SGTable`.
>>>      trait SGTablePages {
>>>          /// Returns an iterator to the pages providing the backing memory of `self`.
>>>          fn pages_iter<'a>(&'a self) -> impl Iterator<Item = &'a bindings::page>;
>>>          /// Returns the effective range of the mapping.
>>>          fn range(&self) -> Range<usize>;
>>>      }
>>>
>>> The `SGTable` becomes something like:
>>>
>>>      struct SGTable<P: SGTablePages, T: MapState>
>>>      {
>>>          table: Opaque<bindings::sg_table>,
>>>          pages: P,
>>>          _s: PhantomData<T>,
>>>      }
>>
>> Hopefully I'm not missing anything here but - I'm not sure how I feel about
>> this making assumptions about the memory layout of an sg_table beyond just
>> being a struct sg_table. For instance, in the gem shmem helpers I had this for
>> exposing the SGTable that is setup for gem shmem objects:
>>
>> struct OwnedSGTable<T: drm::gem::shmem::DriverObject> {
>>      sg_table: NonNull<SGTable>
>>      _owner: ARef<Object<T>>
>> }
>>
>> So, I'm not really sure we have any reasonable representation for P here as we
>> don't handle the memory allocation for the SGTable.
> 
> Maybe I need more context to understand your problem, but the point of
> this design is precisely that it doesn't make any assumption about the
> memory layout - all `P` needs to do is provide the pages describing the
> memory backing.
> 
> Assuming that `_owner` here is the owner of the memory, couldn't you
> flip your data layout and pass `_owner` (or rather a newtype wrapping
> it) to `SGTable`, thus removing the need for a custom type?

I think what Lyude has in mind here (Lyude, correct me if I'm wrong) is 
for cases where we need to have a rust SGTable instances for those 
struct sg_table that we didn't allocate ourselves for instance in the 
gem shmem bindings. So memory layout needs to match for
#[repr(transparent)] to work

