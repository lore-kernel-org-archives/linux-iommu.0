Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDC51E5B6A
	for <iommu@lists.linux.dev>; Mon, 30 Jun 2025 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751267489; cv=none; b=tLsbdy7/5jHPblNDMFLjOm4eYCmoouuQ2iE3FNHRG8xaL0JEoKtCWQEO5gBB/EYrs6DA3jjAD4jLBJL1DKqXD3vywxgIVtLXHgvetOvelHpLcgGBrQkMzTINc7lvayD9FOtpC3tT8Rwtu99q4+t2PGqr/ljmVRC6Y9nW1DW/eaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751267489; c=relaxed/simple;
	bh=CD9GkYSZkdyta01MbugTF9qolMg0aSy7vBt9KH/VEyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtCe4tVLKo95XVjnd6wR3fy7YZ6+n5ZdLS1p5s0KVmMyYNUKr5SolkCMd8CUkotqwxnyj2b2PVzjzg2XmmFniwEUDRSW3AucH/Hq6WbfD+TfsC6Reh2uU7Qvvf6rRBwlb4b0f2zS9W+w0XRmdDtTvjKih62Vd09ogg7xzBWRJ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBRop8K/; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBRop8K/"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-553b16a0e38so4436146e87.1
        for <iommu@lists.linux.dev>; Mon, 30 Jun 2025 00:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751267486; x=1751872286; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=649GzEwjbDrk2Om7zf1W6Es3+z3Jo3wk6Roc/+z8/HU=;
        b=kBRop8K/9pwxqtl3J/uJJ6heDCpxbgybrYIN2t9OV2aLmmDu8h2itmeeDyPlXTLirP
         sC46+tOecfJH59J1wk7OfP87+5I1Dp5+kgJSsZNI5dgV5Rj/PGIdDDUe6iDSEPEgKo8F
         4eEUE4W1pDCHh5bjK+lRQzIu2/bcmr/N92d3Yge0xGTPfgR5viOeQbZx2wEvea+Nb5PD
         upMAOz+8OKnXYr8M6yM6Lk18jOq+1bEa8GDyC8v/krc1XAEHzQrbjE545SrXAc1BRlXC
         HytVWlAWIRT9VB6eusfPB/EHkrFf8bWsendOiKkG/MPIEGKSlEcXF4mdFVOSMnWklrV3
         tqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751267486; x=1751872286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=649GzEwjbDrk2Om7zf1W6Es3+z3Jo3wk6Roc/+z8/HU=;
        b=v70isJz8ppcUAEGPv5Utjd+6uTT0XjKY9PXf1dRD9g+CIBG9gvLBHKPdq8LCX9N5EK
         DzsX4wuLZRFXiaR+W/Miu7sW66RKLZ8NcH9aYKlxcWeGDmyvR/o9bQEfJvScw5UGtuoK
         ELdyAyiRyQfLyYY5iUUBZwHiGgDj9pfr4nMF6ZfGy00P1rLhQQds6ZEDXDKTzEUbSdi3
         RClTWt/ds7NylSkG1XttGHzlb8o1ijU4hA+cgeEYPw9mszOmlbPdfRHAK6HVVLPQHV7k
         FncAXyZ6EdPtgTP53uUb+OQIExCH8FMav1qWJSd65x4xgrmVDtHq9iICxWRgoq4z1ud1
         WMHA==
X-Forwarded-Encrypted: i=1; AJvYcCXwhwkxJj2Po1zvX5ExPv9mgfdpBR67vcv+02MwZKsiGU9iLgRucI44r3LOQ3iaYzH1nr5evg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYdgNI4XY6L0Q31sdiR/zdSKH2gBAP/UVERZTEldcBBaqNhGjd
	CHZ3C0mIHlHqgkZFsMLlPHryRTMsIEpvuPtfWMC3e59Kfeix4gYfQ8dB
X-Gm-Gg: ASbGncuYg5elPaVBQ/oEU3V78P800MNV/AzuMMVRJlogaoHdl+G9mZ7OZMSIrPMMIuk
	k3XBdsGMnrtIw6gAb09Ci5jfnLnZWijwWSyQrwcr1hNtGxFwdz2gemh2NEMoVTuig7atQWfW5Zs
	hFY48HPaCAmxloaGKs6CWY4H73e4f9zsPwjF2oaRwuZQ0SKAuZiV3JCX0C77/luYm++CDv6FmnR
	i94Ma13tA5EfKDnuCX/jE51t2YA/EV4GaLg0Soq5dmL079EyjOEWz3b2Wn9GrbnM/4Iojyo0l7j
	KlSVO76NYKCwrNdwn36ZYipYtQOjhfYG8OJr3fhOqS01L4zDHngbNO6O69XUbWR1meGUETRF89w
	y61Taekh9IEwNLkBI488qKF19ERLqS72nOPJ9m1iPGjt6QIMB6Q==
X-Google-Smtp-Source: AGHT+IFxrPMGSdGOqlXKMD0hWwFLfHk5WHZkY7RSqDHeuAL00r1cMbIjWLFI8IOGYbIrq+TGQY+D6A==
X-Received: by 2002:a05:6512:1329:b0:553:263d:ab90 with SMTP id 2adb3069b0e04-5550b8167d6mr3601024e87.18.1751267485235;
        Mon, 30 Jun 2025 00:11:25 -0700 (PDT)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2ee0casm1318597e87.239.2025.06.30.00.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 00:11:24 -0700 (PDT)
Message-ID: <dad04702-17bc-4554-b64b-e57f34d371a7@gmail.com>
Date: Mon, 30 Jun 2025 10:11:23 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rust: add initial scatterlist bindings
To: Alexandre Courbot <acourbot@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: dakr@kernel.org, lyude@redhat.com, Miguel Ojeda <ojeda@kernel.org>,
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
 <5c72682a-ede9-4a48-a214-f1795115816b@gmail.com>
 <DAY4I5PUNEHR.3UBD2WCPS1ZBV@nvidia.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <DAY4I5PUNEHR.3UBD2WCPS1ZBV@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/06/2025 14:18, Alexandre Courbot wrote:
> On Thu Jun 5, 2025 at 10:22 PM JST, Abdiel Janulgue wrote:
>>
>>
>> On 30/05/2025 17:02, Alexandre Courbot wrote:
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
>>>       let sgt = SGTable::alloc_table(4, GFP_KERNEL)?;
>>>       let sgt = sgt.init(|iter| {
>>>           for sg in iter {
>>>               sg.set_page(&Page::alloc_page(GFP_KERNEL)?, PAGE_SIZE as u32, 0);
>>>           }
>>>           Ok(())
>>>       })?;
>>>
>>> Here the allocated `Page`s are dropped immediately after their address is
>>> written by `set_page`, giving the device access to memory that may now be used
>>> for completely different purposes. As long as the `SGTable` exists, the memory
>>> it points to must not be released or reallocated in any way.
>>
>>
>> Hi just a silly observation while trying to think about other ways to
>> tie the page lifetime to the sgtable. Why can't we just use a lifetime
>> bound annotation?
>>
>> It's simpler and it seems to work:
>>
>>
>> impl<'b> SGEntry<'b, Unmapped> {
>>       pub fn set_page<'a: 'b> (&mut self, page: &'a Page, length: u32,
>> offset: u32)
>>
>> So with this, my erroneous example fails to compile. Here the compiler
>> enforces the use  of the api so that the page of the lifetime is always
>> tied to the sgtable:
>>
>>
>> let sgt = sgt.init(|iter| {
>>      |                             ---- has type
>> `kernel::scatterlist::SGTableIterMut<'1>`
>> 71 |             for sg in iter {
>>      |                 -- assignment requires that borrow lasts for `'1`
>> 72 |                 sg.set_page(&Page::alloc_page(GFP_KERNEL)?,
>> PAGE_SIZE as u32, 0);
>>      |                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>                - temporary value is freed at the end of this statement
>>      |                              |
>>      |                              creates a temporary value which is
>> freed while still in use
> 
> That would work for this example, but IIUC the bound lifetime will also
> prevent you from doing any sort of dynamic lifetime management using a
> smart pointer, meaning you cannot store the SGTable into another object?
> 
> Whereas storing any generic owner lets use pass a regular reference
> (which lifetime will thus propagate to the SGTable) to serve your
> example, but also works with any smart pointer.

Thanks for the explanation, indeed that's the limitation if we use a 
lifetime bound on SGTable.
Anyways, I just submitted the v2[1] which should be able to enforce the 
ownership of the pages to the SGTable.

/Abdiel

[1]https://lore.kernel.org/rust-for-linux/20250626203247.816273-1-abdiel.janulgue@gmail.com/



