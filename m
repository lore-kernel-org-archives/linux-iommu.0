Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354392522B6
	for <iommu@lists.linux.dev>; Mon, 12 May 2025 16:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747068172; cv=none; b=YpfUiu6uMi24CsW6rCPIa+WbZkr4cHz3yCrUXChNc2dUi+gVn06PP6EmaaLc0kKcZpFbVGF8fxs+dqk69WDrbTIo5ImBgaGMnZYTA/kldht1RtZmu5B6I9DUSMa/Ew/eFiFfcF/WIs5yYOWIEMSi4VZMlTobywVisk4dtq8Z4wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747068172; c=relaxed/simple;
	bh=4NEeBlcVo8EPUIH6uSkGLOmWnV76wrGd1pi2UJNgQ10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E66nDubAiPnjjTG5YnR1nEUfeGdfePQODGfATEgglCpOqp4vMyyiiFULO9kU3yR7B3GOqtuLNmwfizpX6g1yitxzJenahIBlxH17ZerNL18dKJRFxewlOWUtEBeNgy5HFoNIu5v3RDQGGtNF2rnunZKYn7CVuYWNLW/kaxA1cec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XDgOrdwy; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XDgOrdwy"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6f6ef597120so20247816d6.0
        for <iommu@lists.linux.dev>; Mon, 12 May 2025 09:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1747068169; x=1747672969; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9jSEksFk0IPmw2THI2TM14u1OYvzYeSgfWSUpppsY90=;
        b=XDgOrdwyc7stYGKshvcFKElUO75ttb50DxtNxjuhX1dAuQdi0u+ZfQKu6ATQruOEyR
         Ex5U8rZiJ3dWug+gPXvYMLzm/Bw7tSEz9sV5um3XW+sbw1vJBrhj9ufr41gUyh8NXkmg
         ewsQvbJkzNzeqsFFz2necDObOclvyhGtY6AFFQOhLyLYP54sxwkL+itTObznIcW7lAMu
         Lh3pm8Ccty40kFkqHgq4xxEbOx6dObXc3LwCXryNEqQnyPcPfonF27vJ/Gpj9k7uHmmS
         BGkGFSlNIDmQOhcvt4zl3M9Mv3wCca+b+ieku7dwDiqkqHUcVWEtTII603CDPIYaY38I
         hJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747068169; x=1747672969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jSEksFk0IPmw2THI2TM14u1OYvzYeSgfWSUpppsY90=;
        b=dNZLXn7fKKiAYOTCoEZwmIjqAxG0PgStHd0KSvY83gdvi+nxsWNWKq1DlB1ioUv2dH
         qVn2NwF+xB6ePg1j0oI5f7ELDKOWpQayBi6eXgi2QEDyh4asMIoGnCC/bRW36VsyvSc3
         XMHQFb7Q0Z0vGarRJ07jwE8iS43Krl6/Gmc424GsBJ4GkMV1q80PmWU8wuQuN6Q55hSo
         jvMlKhtcHOsu3n55nTunBy+MzEAYUzDiLYnlWQILhd3Rl6Y5xkHbL7Xt8CRnA13TRvqH
         6MLtQpvOTurwJ7Dq1Bg6f035qRbUmKH5/7lcQLqbEdALRGnlWrwmAvvrT54qa+2GN934
         F35w==
X-Forwarded-Encrypted: i=1; AJvYcCWq+Qx3vUUTTOajTRe4uEmqIUiJAQaCXzN8JMxEI/Lap2TxBClaGhlIShjm8K+Yt7jLYPJUhA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZTYLRNM2vNIct/+F7rDq1fM+fXjsmA8wAvF0NnmqLSVL0Bt7P
	eoiAOPswWcvzhR8UH9vgLTgk1SdFyMqV4RuX/ufT/vEP87KislQkx3qWOZfqjrA=
X-Gm-Gg: ASbGncuFyfvGR/T0meDQfals0ss4exzquxh9YXXM9qDBJwu24BcDNY2AWXz5CaQFL6c
	hvEccopNlOMv+qHTKvysOR2ahC6ZFqNOeuLGGuNMW9MNSDNsrAR7syA9taGTZJ6YlNrOhySH0a7
	e7ElPWFdbObAnMYj5yroYe1x7+T9V2ScNz2jA5FYcqXw9hTgfDw/lnmax4+A/g/gcYmokDomk3y
	BYH5TEOr1u97oEPfnFjcud66eWuknJkgTkhLjfJu4kgqYCrR9N+zrq1fqRXfHcdX6nOZkj4SxGG
	inviFdCKE2Pa2oqGIhgiCQYd3UA1KRuv5wHQIQhDkqjfuvqc7uym6r2r7nfWyz3DUoO1L4H4AIi
	fCSQpE1SOqJaTBgWIvsWgeApHJa8svWvfPocvBw==
X-Google-Smtp-Source: AGHT+IGTze44sKS3PS34pEWNgJkuuq56OX0bHzvAhd6fhWp6wOev3UKy9acjrmM4zvb7NFy+ZXZLxw==
X-Received: by 2002:a05:6214:242c:b0:6ea:d604:9e4f with SMTP id 6a1803df08f44-6f85b680750mr2513886d6.19.1747068168660;
        Mon, 12 May 2025 09:42:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e39f4689sm54710036d6.28.2025.05.12.09.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 09:42:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uEWEp-00000001Ku1-1UPJ;
	Mon, 12 May 2025 13:42:47 -0300
Date: Mon, 12 May 2025 13:42:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: dakr@kernel.org, lyude@redhat.com, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
	rust-for-linux@vger.kernel.org,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Petr Tesarik <petr@tesarici.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [RFC PATCH 1/2] rust: add initial scatterlist bindings
Message-ID: <20250512164247.GF138689@ziepe.ca>
References: <20250512095544.3334680-1-abdiel.janulgue@gmail.com>
 <20250512095544.3334680-2-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512095544.3334680-2-abdiel.janulgue@gmail.com>

On Mon, May 12, 2025 at 12:53:27PM +0300, Abdiel Janulgue wrote:
> +impl SGEntry {
> +    /// Convert a raw `struct scatterlist *` to a `&'a SGEntry`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the `struct scatterlist` pointed to by `ptr` is valid for the lifetime
> +    /// of the returned reference.
> +    pub unsafe fn as_ref<'a>(ptr: *mut bindings::scatterlist) -> &'a Self {
> +        // SAFETY: The pointer is valid and guaranteed by the safety requirements of the function.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    /// Convert a raw `struct scatterlist *` to a `&'a mut SGEntry`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// See safety requirements of [`SGEntry::as_ref`]. In addition, callers must ensure that only
> +    /// a single mutable reference can be taken from the same raw pointer, i.e. for the lifetime of the
> +    /// returned reference, no other call to this function on the same `struct scatterlist *` should
> +    /// be permitted.
> +    unsafe fn as_mut<'a>(ptr: *mut bindings::scatterlist) -> &'a mut Self {
> +        // SAFETY: The pointer is valid and guaranteed by the safety requirements of the function.
> +        unsafe { &mut *ptr.cast() }
> +    }
> +
> +    /// Returns the DMA address of this SG entry.
> +    pub fn dma_address(&self) -> bindings::dma_addr_t {
> +        // SAFETY: By the type invariant of `SGEntry`, ptr is valid.
> +        unsafe { bindings::sg_dma_address(self.0.get()) }
> +    }
> +
> +    /// Returns the length of this SG entry.
> +    pub fn dma_len(&self) -> u32 {
> +        // SAFETY: By the type invariant of `SGEntry`, ptr is valid.
> +        unsafe { bindings::sg_dma_len(self.0.get()) }
> +    }
> +
> +    /// Set this entry to point at a given page.
> +    pub fn set_page(&mut self, page: &Page, length: u32, offset: u32) {
> +        let c: *mut bindings::scatterlist = self.0.get();
> +        // SAFETY: according to the `SGEntry` invariant, the scatterlist pointer is valid.
> +        // `Page` invariant also ensure the pointer is valid.
> +        unsafe { bindings::sg_set_page(c, page.as_ptr(), length, offset) };
> +    }

I think this is repeating the main API mistake of scatterlist here in
Rust.

Scatterlist is actually two different lists of value pairs stored in
overlapping memory.

It's lifetime starts out with a list of CPU pages using struct page *

Then it is DMA mapped and you get a list of DMA ranges using
dma_len/dma_address. At this point the CPU list becoms immutable

Iterators work over one list or the other, never ever both at once. So
you should never have a user facing API where they get a type with
both a set_page and a dma_len.

Arguably set_page probably shouldn't exist in the rust bindings, it is
better to use one of the append functions to build up the initial
list.

> +/// DMA mapping direction.
> +///
> +/// Corresponds to the kernel's [`enum dma_data_direction`].
> +///
> +/// [`enum dma_data_direction`]: srctree/include/linux/dma-direction.h
> +#[derive(Copy, Clone, PartialEq, Eq)]
> +#[repr(u32)]
> +pub enum DmaDataDirection {

Shouldn't this in the DMA API headers?

> +impl DeviceSGTable {
> +    /// Allocate and construct the scatter-gather table.
> +    pub fn alloc_table(dev: &Device, nents: usize, flags: kernel::alloc::Flags) -> Result<Self> {
> +        let sgt: Opaque<bindings::sg_table> = Opaque::uninit();
> +
> +        // SAFETY: The sgt pointer is from the Opaque-wrapped `sg_table` object hence is valid.
> +        let ret = unsafe { bindings::sg_alloc_table(sgt.get(), nents as _, flags.as_raw()) };
> +        if ret != 0 {
> +            return Err(Error::from_errno(ret));
> +        }
> +
> +        Ok(Self {
> +            sg: SGTable(sgt),
> +            dir: DmaDataDirection::DmaNone,
> +            dev: dev.into(),
> +        })
> +    }
> +
> +    /// Map this scatter-gather table describing a buffer for DMA.
> +    pub fn dma_map(&mut self, dir: DmaDataDirection) -> Result {
> +        // SAFETY: Invariants on `Device` and `SGTable` ensures that the `self.dev` and `self.sg`
> +        // pointers are valid.
> +        let ret = unsafe {
> +            bindings::dma_map_sgtable(
> +                self.dev.as_raw(),
> +                self.sg.as_raw(),

Can't call this function on an unbound driver, didn't someone add
special types for this recently?

> +impl Drop for DeviceSGTable {
> +    fn drop(&mut self) {
> +        if self.dir != DmaDataDirection::DmaNone {
> +            // SAFETY: Invariants on `Device` and `SGTable` ensures that the `self.dev` and `self.sg`
> +            // pointers are valid.

Wrong safety statement, Device must be on a bound driver to call this
function, a valid pointer (eg device refcount) is not enough.

Jason
