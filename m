Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FB0261375
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 09:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474563; cv=none; b=aL9NYbQJ/4eKVS5fmtpgyPTKukNIXdIE3t81Yw0mvFWMAOP6wN7bfY0JNupdIOeHO3i4AO5W1MfrTCnNOqGPAU3YoQRX+lGAC7GAUwaLfDyRmaV3DMGHKGp4d/mhGWU3DQYPxo7eD9MTKZtsce+RQMMIvaeahgK1N+6iZsBkClM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474563; c=relaxed/simple;
	bh=vHP8iH87HLYw0EXAh2NXut+P7Yu/K0NXb69PESW79T8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZXeR+im5zP3KgK2binlHmfhAxn+LWuIbd9rBLFBZgHnwDecEqosDKuBhAjTVEimDo3CT4pDge2WTvs74RJsIkj/UcxPG3l2LXhEdYziyCPimEso/PG4yEpI2kkN0cp8XL9r4GBmtiW/gwL+p0AiOpGw+Qa9Q9PsrRb1lvyFvWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p9xppg1Y; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p9xppg1Y"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-438a39e659cso34681595e9.2
        for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 01:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740474560; x=1741079360; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EATRkDqeNJ+B0cG+644Rc49PEjwniyGIzEzuzyJ4FDE=;
        b=p9xppg1YE2CjN2MvM0gHxjgoJaGYDiEbDpLcDVdZqrE7Id0YBlRrs+4yeEDrII9DPE
         jW7dayDHIjUkjZKJ0fEonSAMgXFfTk18e7VRLT4GCk8Ujr5AJKHu0bJwsWMitdrctVvL
         +7lK+ot8kGvqxdRgigGvgyT/yT/bHkPhIL+M9OW7z9mi/zxIG779bhc9pG//rWSCKKAh
         oleVHN/f1iLvFXbrA1L8Ksj8VSA8EA5KvyelPbQg7AZ1NKIVM3Fnr5koh3izGnnylRG9
         4IMIf6SQhjVBOhlT1Uepjle2NlhzFqENB02DrV9a5cYB1vZPE0Rg5gF5yWURSInnxf3W
         PgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740474560; x=1741079360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EATRkDqeNJ+B0cG+644Rc49PEjwniyGIzEzuzyJ4FDE=;
        b=Q13W2zWK1VPAML4eDn05qwV2ejy8YRTbFtIImP3IRuMEfDLCzJ85Ad5MRZi1mv5OLp
         EVtSYpjVumYBsu2Igon5OKN9qn20V9jL3jQMZZ9vL8+O4xvQMsq9siD5K/l2glON3Klk
         R20++U4mgcFtbB9R7dLMflbgnTmHpBbQQgO4EgB8CIWCyk0u2g867xY/gE1zi7/CJzfu
         fTHFch+byCOUT2ZVfDHJpMaZMmUALaHHsZkPacxRPx/SbS6s7OxBZo5ZpU8YhSBvNdbk
         h2SHU4mezHt4I9eL0w3dBWKA5Z47vikExoxRjKMbvOdS6FLwDv7bwUcswrGYdi6HVUws
         mVXw==
X-Forwarded-Encrypted: i=1; AJvYcCWdQcBPq0eRDAFLKMYOh1jVermZRyHlt6gnKugG6WmDckOjsVDyIKR0X2gDvsKVlGCuNRPNcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywc/11x8Awc2SyH73O1UwKo+RRfVSzAPYLozI8qrLik6BA16xrx
	dtFfQq4OXflwKhQDoEXrHZXJKRWOFPz9vr5FgrzHQpHN3JpPNcf/t8NZ97e5IZAnPJUn5vaCwoP
	oy5CyRf/IM34pX0aaRZWoCXpKAD/AKifiX9yK
X-Gm-Gg: ASbGncvgNN80vesXb2lp1DsiBKgY1P3HsPEgLTWrDanLkkxBsGyNX4LWCRHfx7TaJ0+
	GE4l8bGdzaogIZ2ZzdfGxjG6pMhUp3OLRXGyGBgxlCUeXOAE8Kr4Zf7yX+8E8qTCuKieIm6X2nK
	UWRQRW8bGGw9G/6Xkz9yM5pAEJtXxTw3mgj2JWzA==
X-Google-Smtp-Source: AGHT+IGZInk/hQzrlT6txuFwQsEo9tTw27WKXN7JW2r7IlfD+fs1wRIJAj+kaIZ/YJM1ku4z/kVfmBxq/4O+Kp5n6Yo=
X-Received: by 2002:a05:600c:1c1d:b0:439:9496:181c with SMTP id
 5b1f17b1804b1-439aebdc9e1mr120554755e9.29.1740474560036; Tue, 25 Feb 2025
 01:09:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com> <6dea7b6a-1534-47e7-94d2-d67417c3d4c1@proton.me>
 <a65125ce-524f-4226-9e59-32b731ad97f0@gmail.com>
In-Reply-To: <a65125ce-524f-4226-9e59-32b731ad97f0@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 25 Feb 2025 10:09:07 +0100
X-Gm-Features: AQ5f1JqWFjMHJGx6yaV8UawGsqN9xXNnmKqO6WA4uvUistTtsMQKb-M2EASAR3I
Message-ID: <CAH5fLgh_Hu8-DkNgPBUM+k+4wrfznz0HcRxHnVxYnEY+XwVbxg@mail.gmail.com>
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, dakr@kernel.org, robin.murphy@arm.com, 
	daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 9:15=E2=80=AFAM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
>
> Hi,
>
> On 24/02/2025 22:07, Benno Lossin wrote:
> >> +    ///
> >> +    /// # Safety
> >> +    ///
> >> +    /// It is the callers responsibility to avoid separate read and w=
rite accesses to the region
> >> +    /// while the returned slice is live.
> > This safety requirement is worded quite differently compared to the one
> > on `as_slice`, why?
> >
> >> +    pub unsafe fn as_slice_mut(&self, offset: usize, count: usize) ->=
 Result<&mut [T]> {
> >> +        let end =3D offset.checked_add(count).ok_or(EOVERFLOW)?;
> >> +        if end >=3D self.count {
> >> +            return Err(EINVAL);
> >> +        }
> >> +        // SAFETY:
> >> +        // - The pointer is valid due to type invariant on `CoherentA=
llocation`,
> >> +        // we've just checked that the range and index is within boun=
ds. The immutability of the
> >> +        // of data is also guaranteed by the safety requirements of t=
he function.
> >> +        // - `offset` can't overflow since it is smaller than `self.c=
ount` and we've checked
> >> +        // that `self.count` won't overflow early in the constructor.
> >> +        Ok(unsafe {core::slice::from_raw_parts_mut(self.cpu_addr.add(=
offset), count) })
> >> +    }
> >> +
> >> +    /// Writes data to the region starting from `offset`. `offset` is=
 in units of `T`, not the
> >> +    /// number of bytes.
> >> +    ///
> >> +    /// # Examples
> >> +    ///
> >> +    /// ```
> >> +    /// # fn test(alloc: &mutkernel::dma::CoherentAllocation<u8>) -> =
Result {
> >> +    /// let somedata: [u8; 4] =3D [0xf; 4];
> >> +    /// let buf: &[u8] =3D &somedata;
> >> +    /// alloc.write(buf, 0)?;
> >> +    /// # Ok::<(), Error>(()) }
> >> +    /// ```
> >> +    pub fn write(&self, src: &[T], offset: usize) -> Result {
> >> +        let end =3D offset.checked_add(src.len()).ok_or(EOVERFLOW)?;
> >> +        if end >=3D self.count {
> >> +            return Err(EINVAL);
> >> +        }
> >> +        // SAFETY:
> >> +        // - The pointer is valid due to type invariant on `CoherentA=
llocation`
> >> +        // and we've just checked that the range and index is within =
bounds.
> >> +        // - `offset` can't overflow since it is smaller than `self.c=
ount` and we've checked
> >> +        // that `self.count` won't overflow early in the constructor.
> >> +        unsafe {
> >> +core::ptr::copy_nonoverlapping(src.as_ptr(), self.cpu_addr.add(offset=
), src.len())
> > Why are there no concurrent write or read operations on `cpu_addr`?
>
> Thanks for the feedback! I noticed an additional safety requirement in
> slice::from_raw_parts_mut:
>
> "The memory referenced by the returned slice must not be accessed
> through any other pointer (not derived from the return value) for the
> duration of lifetime 'a. Both read and write accesses are forbidden."
>
> I can see now though why both as_slice and as_slice_mut docs needs more
> clarity. i.e., they could be worded similarly and add the additional
> safety requirement of slice::from_raw_parts_mut of having no other r/w
> access while the slice is live?

You can use the same wordins as `Page::read_raw` and `Page::write_raw`
for your as_slice[_mut] methods. See rust/kernel/page.rs.

Alice
