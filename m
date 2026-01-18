Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AE0275861
	for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 21:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768771619; cv=none; b=OWNslXXQ54GUASuxgnslXzCJmYj7wloryB9AEdaFviTthPcY4YK+OX0Mc5P/zWh97wI0fZVY2syRbVUtS6mNZus7QR5D3iFGh+iGaCnKRNywrhpgz868p7VuZPgfyrqFDMGo1tSxGL4qkp4JrELb1H6W4qA/vCGjgwIOwnxLwD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768771619; c=relaxed/simple;
	bh=2gvCO0PAouKqcfc7nyAjanyPnBYKoxAiGLOBiQYukV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQbOGo3riRaBRejToKoKn0BbF2wvdQRjYA5Fc6LY9BhCn+pGw3fgGCiwaGhTcNYgAJ/gg7TQUdIpMj1/Ut/F4spdB9Wf+F6I7A+iS2uj+v9QF8z8yzAcRGSExHoMjMvsAM/bmz+QfTIqmHG6ZcnNMQSnkjkfk4Mn5H141S6n3DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gVdzOFl5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gVdzOFl5"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47ee301a06aso32840485e9.0
        for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 13:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768771615; x=1769376415; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pnjSbcwTDJPyjARUCkOFovY6DECA+drGJOQrxdaQuI=;
        b=gVdzOFl5SNIMu18SdMN2VffN5W4BuYv3A3VPKTzBZ0TiyVu9wll3hr+0ptpB+8rQBO
         ZWXNI0Dei3YlYPIyAOLnXqUF8TrNfdZJrC719/osiQPjRYEYdMEbJPwGS9WR5TBDbA/7
         i4EWDMeVTgR8Nq9c9nKKuZUl1n2iMnZ3G67IDL3jxGMe5hSmNIXlQIz6H7+jQO99cki5
         eumdWuAo4w9tgDpZUaK6nCp68qkh/JIv5o7ZhDRhfR8tHIjM0IdAvv/gaOCNExjdZEmt
         bQ9zjvQAZXaGJKHENhpnjK7Hc7bqxas5P0+cU5YStVS0Kv9sCRjGUjEgWQwHQ434Hef3
         L/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768771615; x=1769376415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3pnjSbcwTDJPyjARUCkOFovY6DECA+drGJOQrxdaQuI=;
        b=qIWtdjxnl24QbAO7NQTHqK6pwG+Muh21Da4uTAo+CV/jInERs2LJYQrN1FBuHYvPsi
         kb4wuJL8EQO8XE6uYPIW6a857DL2G0t5jCFBntcxinSTP4dRzhmKtb9t34Xgl3q1Ki+a
         sLnml7xe5WN15+gJB8a+fBLMaZtsC47pZnw39XdWM+8XhF02q6aoZeBPeJxQ8KcVZIDg
         QJHVANtF0LosZQQsw77ewzJVDCPuZPKBGMDMTcJtkARi/ThhPzZLLTUiU9QU40Zw3J+H
         zygM1LuOaf+rj7oCCfqNVkmsDHoe9+VUOO6S5T2UxHok7JjTu68a6zl4Qq+Eodi+f3UX
         z2fg==
X-Forwarded-Encrypted: i=1; AJvYcCX4hJD4BmA1OGhmwJnPxx04fKksQEF1STKVLVhy/o3F7YwL/KPUP9/bSwy4KBkjoCO0NP/oag==@lists.linux.dev
X-Gm-Message-State: AOJu0YwbU224q/pitnSsuJDSlMhugI22wWZw620kx4/a/N2JhJeptl8j
	OkS7n4MRlGOSBU/IlOkvb7N/w6u+gpZVh+IsoJzXPJPz3fd2WirBaLhL9ezLnhAWSXibVl49WQj
	CCnqlx8BsFob8CiF3BfI0L6cCvBA+61R7oMoaESV1
X-Gm-Gg: AY/fxX5jcGxiBFcl/PK3TLuhhJwVfsxX+BgaovP0XhApZn7D5zStj6ma1lK7UMN9Zvo
	Uznjtg5k9Igyt4Cp4GkQCzY+qbFGhAmsA0NIVQINF5JAH7NwuOuWYFFjCUSmkywKtmclVPiqY12
	/rC25wPHSjesdlqRDD1Rm7V4aJ27CkqmO/UuZtOPmYppAqLwY674jYjvC/NjdMAk74IO+wacCkQ
	a34nhZ4mtY0XsJJWd4iwqd6XvjkkudX8aR27kSaqP3+gGcfxYBPyFASQy94bJctCHxDmN9m24YR
	MI5fk/tPBANjCpl/0z4+MewmYA==
X-Received: by 2002:a05:600c:4e4e:b0:47e:e5c5:f3a3 with SMTP id
 5b1f17b1804b1-4801eb03400mr115935075e9.24.1768771615269; Sun, 18 Jan 2026
 13:26:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260118-io-pgtable-v6-1-423846996883@google.com> <DFRU7CF0SSWN.3KMT2U5FWC2NU@garyguo.net>
In-Reply-To: <DFRU7CF0SSWN.3KMT2U5FWC2NU@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sun, 18 Jan 2026 22:26:42 +0100
X-Gm-Features: AZwV_Qj7Ytcb-na5JqnBbBWkuBfdmD0Fjpd7nsTfSWVrZPy72RgoS5eee2IXRDQ
Message-ID: <CAH5fLgixtTyrRcHE6i5RWE3_DgeY59b4B81gF4iDEu1shT_ikw@mail.gmail.com>
Subject: Re: [PATCH v6] rust: iommu: add io_pgtable abstraction
To: Gary Guo <gary@garyguo.net>
Cc: Joerg Roedel <joro@8bytes.org>, Miguel Ojeda <ojeda@kernel.org>, Will Deacon <will@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Asahi Lina <lina+kernel@asahilina.net>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org, 
	Deborah Brouwer <deborah.brouwer@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2026 at 4:57=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Sun Jan 18, 2026 at 10:08 AM GMT, Alice Ryhl wrote:
> > +// For the initial users of these rust bindings, the GPU FW is managin=
g the IOTLB and performs all
> > +// required invalidations using a range. There is no need for it get A=
RM style invalidation
> > +// instructions from the page table code.
> > +//
> > +// Support for flushing the TLB with ARM style invalidation instructio=
ns may be added in the
> > +// future.
> > +static NOOP_FLUSH_OPS: bindings::iommu_flush_ops =3D bindings::iommu_f=
lush_ops {
> > +    tlb_flush_all: Some(rust_tlb_flush_all_noop),
> > +    tlb_flush_walk: Some(rust_tlb_flush_walk_noop),
> > +    tlb_add_page: None,
> > +};
> > +
> > +#[no_mangle]
> > +extern "C" fn rust_tlb_flush_all_noop(_cookie: *mut core::ffi::c_void)=
 {}
>
> Any reason that these needs to be `#[no_mangle]`? Would just `extern "C"`=
 not be
> enough? If there is a good reason, I think this should be noted as such (=
note
> that `#[no_mangle]` would be unsafe in edition 2024 so we probably would =
want to
> avoid using it if possible.

No, it's not required because these are referenced only via function
pointers stored in NOOP_FLUSH_OPS. In principle #[no_mangle] may be
removed here.

However, keeping it doesn't hurt either. There's no particular risk of
overlap with other symbols of the same name. I won't send another
version just for this. Joerg may remove it if he cares, but I don't
think it's a big deal.

> The rest LGTM, so
>
> Reviewed-by: Gary Guo <gary@garyguo.net>

Thanks for the review!

Alice
