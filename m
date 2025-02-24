Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6956F1DDA15
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 22:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434754; cv=none; b=EKSy13Cej5NYnTDNyh4rii9u7qOhuJO/acGJUKRuUCyrXM25n2adno2TVjohSsPjAzSEe3THKfX1/5FeoWDw1NT9idgetlgv9UIU5163U/pm1OKND/se0j7exJEFAXZD2mL0gZDCK79zkTNyacU8AHbbaO8hlI4t+N9AI6z54Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434754; c=relaxed/simple;
	bh=BkBtXHdVcPv6/CA4W328niK4o+qOe4q15XUIuFlL33Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KzpNAE7IBlhpLNQ5pYmAf5FRTc/JG1AJWqDXe8sgWb9omH1ZP8oMZxYgw7JsYOXhLgox4tj8nF7OBFabokzc+ZlHw0RFQ/Z3LsPfcV/+T6Ny7miup0VCsVfGPZjWztPY5+94avCTIufnQEbSg28BKfcgzrK8iHqfNh3lNMQ0olk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNdGdfyI; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNdGdfyI"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fd02536660so741840a91.2
        for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 14:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740434753; x=1741039553; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHIcNsleTwWKuMXlMG/3febKszSx8ZfGtr3TPtrffRI=;
        b=iNdGdfyIObfPVRE6HJZszuvuAR0p8IdVWahTfwiDZZ8hvYgrbpWHmcbKvc/4/BPeB6
         wP8OiPZz0xGbBhJjEIyuHv1zEHIJBAp0464bfu9GXmx8yGhcD3ee5AnFMv/ucndzRttV
         oKFqlaDwlgFpjzqdqc5Fi4k2FBEzIDuUg1Wl2jV0qh0UAwRuWO6p2LqxXB+IASIA/tO6
         8zYGpC95DjuDiQKy9l1fjuUZTqlPhhrbcbp6/FD2rXlVRvIKe8pBNoGpOiae3Rm3j7Mq
         t8TtpyUyqgzwropx1Ba9sDN0+nxnEnd3Lnxy7BtZRavqbcsRcke/Uts2H98LiS3VHT39
         dx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740434753; x=1741039553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHIcNsleTwWKuMXlMG/3febKszSx8ZfGtr3TPtrffRI=;
        b=iCl35FU7cSdjPUsuPWA4LgMgdbI786pTHLB7nxgkve4wYHVPN17DoUqGoJVJN8ibiF
         UAXAolyUSlFMNzQqKG66K1O7au2i65rFmAv7pHZsIogQDG12gRtkgPU71KgsiKn8Kjrh
         cp/iB2OyCS74q6t3CCiS83GvED/16AUnJuht37JUMyIiZ+FHSCcGzePizURjzO5ol6+p
         3IS4aupfquptNnEVIL1IqgmsLlhmlYGeAn7Ow/4jO65j9VCpu7WueeP7dmah6vTvCaiw
         hua1/qcx/tPEJCS8pzhp0SDkr/hQIvajY21FJD6w+NZjEtgqAtKUih+hOBGxvJOD2TYX
         XHFg==
X-Forwarded-Encrypted: i=1; AJvYcCWH8LHUJ3iBABTR7qXuvLmw7SvPVfN25R6vbVI9wnk8Rg0dDBwZ2AnVcYIf/oDee8pFybBAKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTblSn0ZwLjBfGo6Jhs1Y/s39mLTEl7iZZ0P1rKeCgNAJFlwv/
	alBXs8Rlp/jNq3iL8UGtmSupKnA6H75XSwkxSTNwfs09MZXWyZmhuw6o92d4eyFA1NY243gnLdq
	9VyZSHJdgU0U+yvjTlo4EVo4+smk=
X-Gm-Gg: ASbGncuqjVS26e1jeP8yytchjAWrZrB6RZ8zPV6xEPOxKoDote/TUpX/ut9CrApsY7l
	SYPP0zfe2vDU1/uK6sMQz35ZFpGPsJobXfhdKg3cZenU6WYJKMdv+jm+lHm2D1a5V6UbWAYTBhE
	N77x9oOfA=
X-Google-Smtp-Source: AGHT+IEHRJCdPVay7C8B4eRlDOna0GkWz3nnyAQV6jsCpnvpaPryAQnVfEQ0QZ0vR4GuW9WBJTXPkr8gK0uiKNIyLgM=
X-Received: by 2002:a17:90b:3a81:b0:2ee:b665:12ce with SMTP id
 98e67ed59e1d1-2fce789cc70mr9658756a91.1.1740434752565; Mon, 24 Feb 2025
 14:05:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com> <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
In-Reply-To: <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 24 Feb 2025 23:05:40 +0100
X-Gm-Features: AWEUYZl9ZKbchwRuutSwEDDiVUkfsWiO5zHcHT16MwA4Q6ucCw9hz2sOiVVW5cQ
Message-ID: <CANiq72mMKx3kD5KEcT0gOa1zkCt-VXxTEhnDa3feq0H7AttUGw@mail.gmail.com>
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: aliceryhl@google.com, dakr@kernel.org, robin.murphy@arm.com, 
	daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, 
	open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Abdiel,

Some quick doc-related nits -- please take them as a general guide for
potential improvements in newer versions etc., given there are still
other comments that could change the contents.

On Mon, Feb 24, 2025 at 12:50=E2=80=AFPM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
>
> +/// Inform the kernel about the device's DMA addressing capabilities. Th=
is will set the mask for
> +/// both streaming and coherent APIs together.

This comment differs from the C side one -- that is OK, but just
wondering if there was a strong reason for that.

> +pub fn dma_set_mask_and_coherent(dev: &Device, mask: u64) -> i32 {

This returns `i32` -- I have not read the users of this, but should we
take the chance to have a `Result` already here? Same below for the
other one.

> +    // SAFETY: device pointer is guaranteed as valid by invariant on `De=
vice`.

To keep things consistent, please start comments with uppercase, i.e.
"SAFETY: Device pointer ..."

It may also be clearer to say "by the type invariant on".

> +/// Possible attributes associated with a DMA mapping.
> +///
> +/// They can be combined with the operators `|`, `&`, and `!`.

Even if it may be trivial, a small example could be nice here (when I
see a sentence like "This can be used ...", I typically consider
whether it is a good place to show how).

> +/// DMA mapping attrributes.

Typo: attributes.

> +    /// let c: CoherentAllocation<u64> =3D CoherentAllocation::alloc_att=
rs(dev.into(), 4, GFP_KERNEL,
> +    ///                                                                 =
 DMA_ATTR_NO_WARN)?;

Please try to format the code as `rustfmt` would normally do it. I
know it is a pain to do it manually -- hopefully
`format_code_in_doc_comments` will eventually be stable.

> +        // We ensure that we catch the failure on this function and thro=
w an ENOMEM

Apart from what Benno said, please try to use Markdown in all comments.

> +    /// Performs the same functionality as `alloc_attrs`, except the `dm=
a_attrs` is 0 by default.

Intra-doc links (I will mark a few more that I think may work).

> +    /// Create a duplicate of the `CoherentAllocation` object but preven=
t it from being dropped.

Intra-doc link.

> +    /// r/w access or use-cases where the pointer to the live data is ne=
eded, `start_ptr()` or
> +    /// `start_ptr_mut()` could be used instead.

Intra-doc links.

> +    /// Performs the same functionality as `as_slice`, except that a mut=
able slice is returned.

Intra-doc link.

> +    /// Reads the value of `field` and ensures that its type is `FromByt=
es`

Intra-doc link.

> +    /// # Safety:

Typo: no colon. Also another one below.

> +    /// This must be called from the `dma_read` macro which ensures that=
 the `field` pointer is
> +    /// validated beforehand.
> +    ///
> +    /// Public but hidden since it should only be used from `dma_read` m=
acro.

Intra-doc links -- even if they are not rendered because it is hidden
(also even if it were a private item).

> +    #[doc(hidden)]
> +    pub unsafe fn field_read<F: FromBytes>(&self, field: *const F) -> F =
{
> +        // SAFETY: By the safety requirements field is valid

Markdown; and please end the sentence with a period for consistency.

> +    /// Writes a value to `field` and ensures that its type is `AsBytes`

Intra-doc link, and period at the end (same below too).

> +/// Reads a field of an item from an allocated region of structs.
> +/// # Examples

Newline between these two lines. Also for the write equivalent one below.

> +/// struct MyStruct { field: u32, }
> +/// // SAFETY: All bit patterns are acceptable values for MyStruct.

Newline between these two, also Markdown. Same below and in the write
equivalent.

I think it is fairly important to have clean examples, since people
will learn from and follow them!

Thanks!

Cheers,
Miguel
