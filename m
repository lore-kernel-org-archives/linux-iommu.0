Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BF3261B9B
	for <iommu@lists.linux.dev>; Fri, 28 Nov 2025 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764348487; cv=none; b=Mnu6Is9h9JVlq0rrJzEOBcjbm7Q9IrIcd2RzQPcFGWbPH16KVCt+73ORPqEP4q33674B0rNg76eFbk6eJcSax0oFxPcCYwPX7j0R59Xd5ohxzSpyu8ofOD07QFzDZcc0D3/RpYJfKglujsOyuj7BivssrdeIHU3/CpnvK3LbwxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764348487; c=relaxed/simple;
	bh=yhqyFj9IjCjd45jA0GmNd2OPcFWbGwSFUuAzV/OuujU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fupwM4rAbDrERaM9iPxHuLhSSALN5M92ZqsjyCsiTwF2khb+MZtOhZEbvSItF4hrB9FhjoyGlLrlRMmtb/MPnKchPHxIDmBXnnsPKxUJzOKMCsME0FQXtULZzZuKDkDwZL7uMgDXQ/7gfvdXiYkb87WMcrpxYWPsM2cAFPFR+10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD438176A;
	Fri, 28 Nov 2025 08:47:51 -0800 (PST)
Received: from [10.57.89.189] (unknown [10.57.89.189])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FBA33F73B;
	Fri, 28 Nov 2025 08:47:55 -0800 (PST)
Message-ID: <c8229530-ab87-4b51-8f2b-6199a01095b3@arm.com>
Date: Fri, 28 Nov 2025 16:47:52 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] io: add io_pgtable abstraction
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Will Deacon <will@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Asahi Lina <lina+kernel@asahilina.net>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org
References: <20251112-io-pgtable-v3-1-b00c2e6b951a@google.com>
 <12d99a54-e111-4877-b8cd-cb1e58cd6d30@arm.com> <aSmVQDMXqwc8ctDf@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <aSmVQDMXqwc8ctDf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-11-28 12:27 pm, Alice Ryhl wrote:
[...]
>>> +    /// Map a physically contiguous range of pages of the same size.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// * This page table must not contain any mapping that overlaps with the mapping created by
>>> +    ///   this call.
>>
>> As mentioned this isn't necessarily true of io-pgtable itself, but since
>> you've not included QUIRK_NO_WARN in the abstraction then it's fair if this
>> layer wants to be a little stricter toward Rust users.
> 
> Assuming that we don't allow QUICK_NO_WARN, would you say that it's
> precise as-is?

As an assumption of use for the Rust API, like I say it's fine - it's 
still not really "unsafe" if a caller did try an overlapping mapping; 
the call will still fail gracefully and accurately, it's just it will 
also fire a WARN_ON() since ARM_64_LPAE_S1 without 
IO_PGTABLE_QUIRK_NO_WARN considers this indicative of a usage error or 
race in the caller.

If we do end up wanting to support more opportunistic and/or 
userspace-controlled mappings by Rust drivers in future then we can 
relax this expectation as appropriate.

>>> +    /// * If this page table is live, then the caller must ensure that it's okay to access the
>>> +    ///   physical address being mapped for the duration in which it is mapped.
>>> +    #[inline]
>>> +    pub unsafe fn map_pages(
>>> +        &self,
>>> +        iova: usize,
>>> +        paddr: PhysAddr,
>>> +        pgsize: usize,
>>> +        pgcount: usize,
>>> +        prot: u32,
>>> +        flags: alloc::Flags,
>>> +    ) -> Result<usize> {
>>> +        let mut mapped: usize = 0;
>>> +
>>> +        // SAFETY: The `map_pages` function in `io_pgtable_ops` is never null.
>>> +        let map_pages = unsafe { (*self.raw_ops()).map_pages.unwrap_unchecked() };
>>> +
>>> +        // SAFETY: The safety requirements of this method are sufficient to call `map_pages`.
>>> +        to_result(unsafe {
>>> +            (map_pages)(
>>> +                self.raw_ops(),
>>> +                iova,
>>> +                paddr,
>>> +                pgsize,
>>> +                pgcount,
>>> +                prot as i32,
>>> +                flags.as_raw(),
>>> +                &mut mapped,
>>> +            )
>>> +        })?;
>>> +
>>> +        Ok(mapped)
>>
>> Just to double-check since I'm a bit unclear on the Rust semantics, this can
>> correctly reflect all 4 outcomes back to the caller, right? I.e.:
>>
>> - no error, mapped == pgcount * pgsize (success)
>> - no error, mapped < pgcount * pgsize (call again with the remainder)
>> - error, mapped > 0 (probably unmap that bit, unless clever trickery where
>> an error was expected)
>> - error, mapped == 0 (nothing was done, straightforward failure)
>>
>> (the only case not permitted is "no error, mapped == 0" - failure to make
>> any progress must always be an error)
>>
>> Alternatively you might want to consider encapsulating the partial-mapping
>> handling in this layer as well - in the C code that's done at the level of
>> the IOMMU API calls that io-pgtable-using IOMMU drivers are merely passing
>> through, hence why panfrost/panthor have to open-code their own equivalents,
>> but there's no particular reason to follow the *exact* same pattern here.
> 
> Ah, no this signature does not reflect all of those cases. The return
> type is Result<usize>, which corresponds to:
> 
> struct my_return_type {
>      bool success;
>      union {
>          size_t ok;
> 	int err; // an errno
>      }
> };
> 
> We need a different signature if it's possible to have mapped != 0 when
> returning an error.

Aha, thanks for clarifying - indeed this is not the common "value or 
error" case, it is two (almost) orthogonal return values. However if 
we're not permitting callers to try to do anything clever with -EEXIST 
then it might make sense to just embed the inevitable cleanup-on-failure 
boilerplate here anyway (even if we still leave retry-on-partial-success 
to the caller).

Note that it does appear to be the case that io-pgtable-arm in its 
current state won't actually do this, since it happens to handle all its 
error return cases before any leaf PTEs are touched and "mapped" is 
updated, but the abstraction layer shouldn't assume that in general 
since other implementations like io-pgtable-arm-v7s definitely *can* 
fail with a partial mapping.

>>> +    }
>>> +
>>> +    /// Unmap a range of virtually contiguous pages of the same size.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// This page table must contain a mapping at `iova` that consists of exactly `pgcount` pages
>>> +    /// of size `pgsize`.
>>
>> Again, the underlying requirement here is only that pgsize * pgcount
>> represents the IOVA range of one or more consecutive ranges previously
>> mapped, i.e.:
>>
>> map(0, 4KB * 256);
>> map(1MB, 4KB * 256);
>> unmap(0, 2MB * 1);
>>
>> is legal, since it's generally impractical for callers to know and keep
>> track of the *exact* structure of a given pagetable. In this case there
>> isn't really any good reason to try to be stricter.
> 
> How about this wording?
> 
> This page table must contain one or more consecutive mappings starting
> at `iova` whose total size is `pgcount*pgsize`.

Yes, that's a nice way to put it.

Thanks,
Robin.
