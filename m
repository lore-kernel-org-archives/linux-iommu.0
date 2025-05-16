Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF06D22CBFE
	for <iommu@lists.linux.dev>; Fri, 16 May 2025 07:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747381930; cv=none; b=lfeu4872u3ODdVuGpDjR3ChdNVFIAFuM13fQNIDYUS/VL/D4mZIoGy1S6FvZsRPwHgtqSxUZ1t7k4kIvclrFs4PDa288TNQ9JssYjZ8Q2VQelsnJdOesj/UOO7bNecipGnURs3T/gpDGm88c5+KduUS3k+bJccrt24YQysTmCO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747381930; c=relaxed/simple;
	bh=RZtLTcaCAo+O8/+jAdnD3rctE0timMssgJeF/PO5j/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rxhuhIn7IFAvymV9AfMjYnvfu+IY/DKMUr1DA0Zp9Ut4bNNpBFRfEneCnb7nFAnUMLiRprADfKG81ii2jPPHILuO6IHieCxCn/CnYcop4eS7phr/kGX9aFpnAAePtaxfNCVFHNYWQfDfmXweMJoKiz0J0ojfTRgRHrtF2nKmg+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjPGyYRm; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjPGyYRm"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-550e2b9084dso1494032e87.1
        for <iommu@lists.linux.dev>; Fri, 16 May 2025 00:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747381926; x=1747986726; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2p13BRBCFT1dwDPSwRtVCH9OWQNWR2IO/8d7NZCQkfI=;
        b=cjPGyYRmHw4Y8+NUPGeySXM74vVSvSwfboSwjJBT3VPk3gHhwioTQ66w4n5+eEM94f
         e7yafR6dRdRaJlQDSvny0w1qxMecwvHqXiX8FjgE8n2bn+0Xs6u2GErlRjoHBIGgkMaE
         g6M3uHP2x8OK6jOhN3UBsJ09raMeajBMkM4MjGTS/bklBjHT1eQ0VWoa+TssTTse442o
         Ax1QrCMOEbdJUDsk/FB5pg7rxjaZmrKu50j7bJuoEKtBNatnPKg9WF0T8b7GexuzvdLe
         wQvTZ11Mwnu799DxkESWX5jcvjVrgKLKY8XAPJNNy70x4oThzfTPnwX/WogqY8cs11gX
         0WWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747381926; x=1747986726;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2p13BRBCFT1dwDPSwRtVCH9OWQNWR2IO/8d7NZCQkfI=;
        b=opHoDFvIMLTOfcQnFeri668H6ZHqoThh4yrtQM1CvJfZGlFtHHbaBDA4kXuKO6q1JV
         GUqOaGBP1K4/9pNunFvtdSgMHvlRESbRiVvYqvr7XcTJ38ZvlzXAbkitdIEHAio0BbAt
         c+Ege8ObS2U0DnDtVnmNT190hA3/1vL/1IKcd19X3nJZ+JOBnak7QilV+uBZT0tTK7D3
         xkJ0V9cVz5sSLmi9yGbgCH5v4gHwer6w+EZTqqY8b+pb9Y9drHraqXVuKv9OVlAy+fWx
         e7KGo3oa4MNBku4PLSouGa22YfiXEYpwaiDxES6jifHoHReCxc55QUY5rUN7G1/1ODmQ
         gvPA==
X-Forwarded-Encrypted: i=1; AJvYcCWciIgTtroKq4dw61haqytqb4BOB/e9uKdonj/EBUFHiZwxc6tVOJKah/HZCcDKfGofKvkz/w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHm598P+Z7EOBcFZ9MBna18FIh2/g77D8vIUWEtEtGo22jjTbr
	2aJ6hUtJtt9ZsAGeteo4MR3vhPPf2CELNTwZIZppkWF0XWZE5X+pSs39
X-Gm-Gg: ASbGncsGchEBeOe/HUSf3IqDB9NACTVWB4ESnMPBg9Wb+UKIrLZcmMLpnnu92euTSCF
	+ZzvCFw9kPB8aPJAC0+lveKNMxOFmbQHsLZ2MnOfuBEcXFeGOyt+KJEehFdhKhxojtDAPK/HggH
	PZXpLRlbWpbsk9YXu4ZyV/XH2PiNBBH3aBZfD6jAiWSEp9pZGr7UY9L4DwCp84IDpH1sOf0ep/Y
	6ySUdklm4TrnpTNXMtpM0J4d9qBu667l9siT8A3IF0bY4Oyt6A6GSX3piWDJJ7fxoB2dVn5O6+E
	HBqB9TBH/aJsw7Yru4a7WniOTqcNUGPtjy6FPC/09ftNXBXhtAohvcQZTIJkhSGN/ISP0m5MqVI
	NlniqQ0muOO4cjiDuW2MZpep2UADa
X-Google-Smtp-Source: AGHT+IEcluKzAsdcCcYSxVEC0m54JCo1lSRIWpxTXMTxyf0b695CL0VEKO3BNKmqHRgH4RatP6CCTQ==
X-Received: by 2002:a05:6512:4508:b0:54a:c514:76f0 with SMTP id 2adb3069b0e04-550e9764327mr437100e87.14.1747381925232;
        Fri, 16 May 2025 00:52:05 -0700 (PDT)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e7038518sm307786e87.210.2025.05.16.00.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 00:52:04 -0700 (PDT)
Message-ID: <777e3d93-ab43-4335-9a95-cf0fed98ad63@gmail.com>
Date: Fri, 16 May 2025 10:52:03 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] rust: add initial scatterlist bindings
To: Lyude Paul <lyude@redhat.com>, dakr@kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
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
References: <20250512095544.3334680-1-abdiel.janulgue@gmail.com>
 <20250512095544.3334680-2-abdiel.janulgue@gmail.com>
 <36b45e41522a61409b379c15f21bb547d4913d1e.camel@redhat.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <36b45e41522a61409b379c15f21bb547d4913d1e.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15/05/2025 23:01, Lyude Paul wrote:
> On Mon, 2025-05-12 at 12:53 +0300, Abdiel Janulgue wrote:
>> Add the rust abstraction for scatterlist. This allows use of the C
>> scatterlist within Rust code which the caller can allocate themselves
>> or to wrap existing kernel sg_table objects.
>>
>> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
>> ---
>>   rust/bindings/bindings_helper.h |   1 +
>>   rust/helpers/helpers.c          |   1 +
>>   rust/helpers/scatterlist.c      |  25 +++
>>   rust/kernel/lib.rs              |   1 +
>>   rust/kernel/scatterlist.rs      | 275 ++++++++++++++++++++++++++++++++
>>   5 files changed, 303 insertions(+)
>>   create mode 100644 rust/helpers/scatterlist.c
>>   create mode 100644 rust/kernel/scatterlist.rs
>>
>> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
>> index ab37e1d35c70..a7d3b97cd4e0 100644
>> --- a/rust/bindings/bindings_helper.h
>> +++ b/rust/bindings/bindings_helper.h
>> @@ -14,6 +14,7 @@
>>   #include <linux/cred.h>
>>   #include <linux/device/faux.h>
>>   #include <linux/dma-mapping.h>
>> +#include <linux/dma-direction.h>
>>   #include <linux/errname.h>
>>   #include <linux/ethtool.h>
>>   #include <linux/file.h>
>> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
>> index 1e7c84df7252..f45a15f88e25 100644
>> --- a/rust/helpers/helpers.c
>> +++ b/rust/helpers/helpers.c
>> @@ -28,6 +28,7 @@
>>   #include "rbtree.c"
>>   #include "rcu.c"
>>   #include "refcount.c"
>> +#include "scatterlist.c"
>>   #include "security.c"
>>   #include "signal.c"
>>   #include "slab.c"
>> diff --git a/rust/helpers/scatterlist.c b/rust/helpers/scatterlist.c
>> new file mode 100644
>> index 000000000000..5ab0826f7c0b
>> --- /dev/null
>> +++ b/rust/helpers/scatterlist.c
>> @@ -0,0 +1,25 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/dma-direction.h>
>> +
>> +void rust_helper_sg_set_page(struct scatterlist *sg, struct page *page,
>> +			     unsigned int len, unsigned int offset)
>> +{
>> +	return sg_set_page(sg, page, len, offset);
>> +}
>> +
>> +dma_addr_t rust_helper_sg_dma_address(struct scatterlist *sg)
>> +{
>> +	return sg_dma_address(sg);
>> +}
>> +
>> +unsigned int rust_helper_sg_dma_len(struct scatterlist *sg)
>> +{
>> +	return sg_dma_address(sg);
>> +}
>> +
>> +void rust_helper_dma_unmap_sgtable(struct device *dev, struct sg_table *sgt,
>> +				   enum dma_data_direction dir, unsigned long attrs)
>> +{
>> +	return dma_unmap_sgtable(dev, sgt, dir, attrs);
>> +}
>> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
>> index fa852886d4d1..a8d5fcb55388 100644
>> --- a/rust/kernel/lib.rs
>> +++ b/rust/kernel/lib.rs
>> @@ -87,6 +87,7 @@
>>   pub mod print;
>>   pub mod rbtree;
>>   pub mod revocable;
>> +pub mod scatterlist;
>>   pub mod security;
>>   pub mod seq_file;
>>   pub mod sizes;
>> diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
>> new file mode 100644
>> index 000000000000..122a6f94bf56
>> --- /dev/null
>> +++ b/rust/kernel/scatterlist.rs
>> @@ -0,0 +1,275 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Scatterlist
>> +//!
>> +//! C header: [`include/linux/scatterlist.h`](srctree/include/linux/scatterlist.h)
>> +
>> +use crate::{
>> +    bindings,
>> +    device::Device,
>> +    error::{Error, Result},
>> +    page::Page,
>> +    types::{ARef, Opaque},
>> +};
>> +use core::ops::{Deref, DerefMut};
>> +
>> +/// A single scatter-gather entry, representing a span of pages in the device's DMA address space.
>> +///
>> +/// # Invariants
>> +///
>> +/// The `scatterlist` pointer is valid for the lifetime of an SGEntry instance.
>> +#[repr(transparent)]
>> +pub struct SGEntry(Opaque<bindings::scatterlist>);
>> +
>> +impl SGEntry {
>> +    /// Convert a raw `struct scatterlist *` to a `&'a SGEntry`.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Callers must ensure that the `struct scatterlist` pointed to by `ptr` is valid for the lifetime
>> +    /// of the returned reference.
>> +    pub unsafe fn as_ref<'a>(ptr: *mut bindings::scatterlist) -> &'a Self {
>> +        // SAFETY: The pointer is valid and guaranteed by the safety requirements of the function.
>> +        unsafe { &*ptr.cast() }
>> +    }
> 
> We might want this to be pub(crate) for the time being. Since it's easier to
> go from private to public then it is to go in the other direction, and I think
> this function is likely only to be used by other kernel crates rather than
> drivers.
> 
>> +
>> +    /// Convert a raw `struct scatterlist *` to a `&'a mut SGEntry`.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// See safety requirements of [`SGEntry::as_ref`]. In addition, callers must ensure that only
>> +    /// a single mutable reference can be taken from the same raw pointer, i.e. for the lifetime of the
>> +    /// returned reference, no other call to this function on the same `struct scatterlist *` should
>> +    /// be permitted.
>> +    unsafe fn as_mut<'a>(ptr: *mut bindings::scatterlist) -> &'a mut Self {
>> +        // SAFETY: The pointer is valid and guaranteed by the safety requirements of the function.
>> +        unsafe { &mut *ptr.cast() }
>> +    }
>> +
>> +    /// Returns the DMA address of this SG entry.
>> +    pub fn dma_address(&self) -> bindings::dma_addr_t {
>> +        // SAFETY: By the type invariant of `SGEntry`, ptr is valid.
>> +        unsafe { bindings::sg_dma_address(self.0.get()) }
>> +    }
>> +
>> +    /// Returns the length of this SG entry.
>> +    pub fn dma_len(&self) -> u32 {
>> +        // SAFETY: By the type invariant of `SGEntry`, ptr is valid.
>> +        unsafe { bindings::sg_dma_len(self.0.get()) }
>> +    }
>> +
>> +    /// Set this entry to point at a given page.
>> +    pub fn set_page(&mut self, page: &Page, length: u32, offset: u32) {
>> +        let c: *mut bindings::scatterlist = self.0.get();
>> +        // SAFETY: according to the `SGEntry` invariant, the scatterlist pointer is valid.
>> +        // `Page` invariant also ensure the pointer is valid.
>> +        unsafe { bindings::sg_set_page(c, page.as_ptr(), length, offset) };
>> +    }
>> +
>> +    /// Obtain the raw `struct scatterlist *`.
>> +    pub fn as_raw(&self) -> *mut bindings::scatterlist {
>> +        self.0.get()
>> +    }
> 
> Should probably also be pub(crate)
> 
>> +}
>> +
>> +/// DMA mapping direction.
>> +///
>> +/// Corresponds to the kernel's [`enum dma_data_direction`].
>> +///
>> +/// [`enum dma_data_direction`]: srctree/include/linux/dma-direction.h
>> +#[derive(Copy, Clone, PartialEq, Eq)]
>> +#[repr(u32)]
>> +pub enum DmaDataDirection {
>> +    /// Direction isn't known.
>> +    DmaBidirectional = bindings::dma_data_direction_DMA_BIDIRECTIONAL,
>> +    /// Data is going from the memory to the device.
>> +    DmaToDevice = bindings::dma_data_direction_DMA_TO_DEVICE,
>> +    /// Data is coming from the device to the memory.
>> +    DmaFromDevice = bindings::dma_data_direction_DMA_FROM_DEVICE,
>> +    /// No direction (used for debugging).
>> +    DmaNone = bindings::dma_data_direction_DMA_NONE,
>> +}
>> +
>> +/// The base interface for a scatter-gather table of DMA address spans.
>> +///
>> +/// This structure represents the Rust abstraction for a C `struct sg_table`. This implementation
>> +/// abstracts the usage of an already existing C `struct sg_table` within Rust code that we get
>> +/// passed from the C side.
>> +///
>> +/// # Invariants
>> +///
>> +/// The `sg_table` pointer is valid for the lifetime of an SGTable instance.
>> +#[repr(transparent)]
>> +pub struct SGTable(Opaque<bindings::sg_table>);
>> +
>> +impl SGTable {
>> +    /// Convert a raw `struct sg_table *` to a `&'a SGTable`.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Callers must ensure that the `struct sg_table` pointed to by `ptr` is initialized and valid for
>> +    /// the lifetime of the returned reference.
>> +    pub unsafe fn as_ref<'a>(ptr: *mut bindings::sg_table) -> &'a Self {
>> +        // SAFETY: Guaranteed by the safety requirements of the function.
>> +        unsafe { &*ptr.cast() }
>> +    }
> 
> pub(crate)
> 
>> +
>> +    /// Obtain the raw `struct sg_table *`.
>> +    pub fn as_raw(&self) -> *mut bindings::sg_table {
>> +        self.0.get()
>> +    }
> 
> pub(crate)
> 
>> +
>> +    /// Returns a mutable iterator over the scather-gather table.
>> +    pub fn iter_mut(&mut self) -> SGTableIterMut<'_> {
>> +        SGTableIterMut {
>> +            // SAFETY: dereferenced pointer is valid due to the type invariants on `SGTable`.
> 
> This seems to be missing a justification for the other part of the safety
> contract for this function, e.g. proving that you hold the only possible
> reference to this data - thus a mutable reference is safe.
> 
> should be easy here though, you can just say that &mut self proves we have
> exclusive access

Good catch!

> 
>> +            pos: Some(unsafe { SGEntry::as_mut((*self.0.get()).sgl) }),
>> +        }
>> +    }
>> +
>> +    /// Returns an iterator over the scather-gather table.
>> +    pub fn iter(&self) -> SGTableIter<'_> {
>> +        SGTableIter {
>> +            // SAFETY: dereferenced pointer is valid due to the type invariants on `SGTable`.
>> +            pos: Some(unsafe { SGEntry::as_ref((*self.0.get()).sgl) }),
>> +        }
>> +    }
>> +}
>> +
>> +/// SAFETY: The `SGTable` should be `Send` across threads.
>> +unsafe impl Send for SGTable {}
>> +
>> +/// A mutable iterator through `SGTable` entries.
>> +pub struct SGTableIterMut<'a> {
>> +    pos: Option<&'a mut SGEntry>,
>> +}
>> +
>> +impl<'a> IntoIterator for &'a mut SGTable {
>> +    type Item = &'a mut SGEntry;
>> +    type IntoIter = SGTableIterMut<'a>;
>> +
>> +    fn into_iter(self) -> Self::IntoIter {
>> +        self.iter_mut()
>> +    }
>> +}
>> +
>> +impl<'a> Iterator for SGTableIterMut<'a> {
>> +    type Item = &'a mut SGEntry;
>> +
>> +    fn next(&mut self) -> Option<Self::Item> {
>> +        self.pos.take().map(|entry| {
>> +            let sg = entry.as_raw();
>> +            // SAFETY: `sg` is guaranteed to be valid and non-NULL while inside this closure. The calls
>> +            // to `SGEntry::as_mut` are unique for each scatterlist entry object as well.
>> +            unsafe {
>> +                let next = bindings::sg_next(sg);
>> +                self.pos = (!next.is_null()).then(|| SGEntry::as_mut(next));
>> +                SGEntry::as_mut(sg)
>> +            }
>> +        })
>> +    }
>> +}
>> +
>> +/// An iterator through `SGTable` entries.
>> +pub struct SGTableIter<'a> {
>> +    pos: Option<&'a SGEntry>,
>> +}
>> +
>> +impl<'a> IntoIterator for &'a SGTable {
>> +    type Item = &'a SGEntry;
>> +    type IntoIter = SGTableIter<'a>;
>> +
>> +    fn into_iter(self) -> Self::IntoIter {
>> +        self.iter()
>> +    }
>> +}
>> +
> 
> I think you might have made a mistake below
> 
>> +impl<'a> Iterator for SGTableIter<'a> {
>> +    type Item = &'a SGEntry;
>> +
>> +    fn next(&mut self) -> Option<Self::Item> {
>> +        self.pos.map(|entry| {
>> +            let sg = entry.as_raw();
> 
>                 ^ sg is the last iterator position
> 
>> +            // SAFETY: `sg` is guaranteed to be valid and non-NULL while inside this closure.
>> +            unsafe {
>> +                let next = bindings::sg_next(sg);
> 
>                     ^ and we fetch the next iterator position
> 
>> +                self.pos = (!next.is_null()).then(|| SGEntry::as_ref(next));
>> +                SGEntry::as_ref(sg)
> 
>                     ^ but then we return the previous iterator position, sg
>> +            }
> 
> Bit of a nickpit here - but we might want to break this into two unsafe
> blocks. Something I don't think most people realize is that unsafe blocks can
> technically have a slight performance penalty since they invalidate various
> assumptions the compiler relies on that would hold true otherwise, making
> certain optimizations impossible. That's the main reason why when I previously
> showed you this iterator I kept the `self.pos` assignment outside of the
> unsafe block.
> 
> (BTW - just so you know you're totally welcome to take or leave the version of
> this iterator I wrote. I'm not super concerned with authorship for a small
> piece of code like this, but the choice is yours of course :)
> 

Hey no worries, I can attribute you in v2 :)

>> +        })
>> +    }
>> +}
>> +
>> +/// A scatter-gather table that owns the allocation and can be mapped for DMA operation using `Device`.
> 
> Probably want `Device` to be [`Device`]
> 
>> +pub struct DeviceSGTable {
>> +    sg: SGTable,
>> +    dir: DmaDataDirection,
>> +    dev: ARef<Device>,
>> +}
>> +
>> +impl DeviceSGTable {
>> +    /// Allocate and construct the scatter-gather table.
>> +    pub fn alloc_table(dev: &Device, nents: usize, flags: kernel::alloc::Flags) -> Result<Self> {
> 
> Maybe just call this new() for consistency
> 
>> +        let sgt: Opaque<bindings::sg_table> = Opaque::uninit();
>> +
>> +        // SAFETY: The sgt pointer is from the Opaque-wrapped `sg_table` object hence is valid.
>> +        let ret = unsafe { bindings::sg_alloc_table(sgt.get(), nents as _, flags.as_raw()) };
>> +        if ret != 0 {
>> +            return Err(Error::from_errno(ret));
>> +        }
> 
> You can just use from_result here btw
>> +
>> +        Ok(Self {
>> +            sg: SGTable(sgt),
>> +            dir: DmaDataDirection::DmaNone,
>> +            dev: dev.into(),
>> +        })
>> +    }
>> +
>> +    /// Map this scatter-gather table describing a buffer for DMA.
>> +    pub fn dma_map(&mut self, dir: DmaDataDirection) -> Result {
>> +        // SAFETY: Invariants on `Device` and `SGTable` ensures that the `self.dev` and `self.sg`
>> +        // pointers are valid.
>> +        let ret = unsafe {
>> +            bindings::dma_map_sgtable(
>> +                self.dev.as_raw(),
>> +                self.sg.as_raw(),
>> +                dir as _,
>> +                bindings::DMA_ATTR_NO_WARN as _,
>> +            )
>> +        };
>> +        if ret != 0 {
>> +            return Err(Error::from_errno(ret));
>> +        }
> 
> Same for here: from_result()
> 
>> +        self.dir = dir;
>> +        Ok(())
>> +    }
>> +}
>> +
>> +// TODO: Implement these as macros for objects that want to derive from `SGTable`.
>> +impl Deref for DeviceSGTable {
>> +    type Target = SGTable;
>> +
>> +    fn deref(&self) -> &Self::Target {
>> +        &self.sg
>> +    }
>> +}
>> +
>> +impl DerefMut for DeviceSGTable {
>> +    fn deref_mut(&mut self) -> &mut Self::Target {
>> +        &mut self.sg
>> +    }
>> +}
>> +
>> +impl Drop for DeviceSGTable {
>> +    fn drop(&mut self) {
>> +        if self.dir != DmaDataDirection::DmaNone {
>> +            // SAFETY: Invariants on `Device` and `SGTable` ensures that the `self.dev` and `self.sg`
>> +            // pointers are valid.
>> +            unsafe {
>> +                bindings::dma_unmap_sgtable(self.dev.as_raw(), self.sg.as_raw(), self.dir as _, 0)
>> +            };
>> +        }
>> +        // SAFETY: Invariant on `SGTable` ensures that the `self.sg` pointer is valid.
>> +        unsafe { bindings::sg_free_table(self.sg.as_raw()) };
>> +    }
>> +}
> 

