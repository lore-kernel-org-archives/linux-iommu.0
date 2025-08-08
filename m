Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E95F226CFC;
	Fri,  8 Aug 2025 20:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754684644; cv=none; b=SQ3c7DWRn7w+R+/ZrBOoiZkuUVnGgk6pDqo/2fWaTjMAJjqIr8CD+d3fEfhXMHpvLoxtlTXRjdsoFXe91/tKre5LML9hWly9DMMjXrqiUJB0CSOmBIZhWknSdaaa1wFRiaK6iuqcA2wecWxahXuJ7ab0DF9jCa1QODsAxUMj+8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754684644; c=relaxed/simple;
	bh=BtM6BMMEeqaSoA6VVVaVCAYSIxGqXH8ttenj0C6a8Jc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=egedd46FN0LTGUgMgq+akhqDEckIeQSzmu2EIyPcPHI9U9rmjNUi/H/vxjw2S7zDdc/bxUWSzmtKvgqox9lUffAcPVrlV4XNlnVZTYsKV8tmuqrv9qu7yS9BIjNmk2fGu4jvVkg1Lq9uq66rLjnvsMnBiKdtoqHbqwvQyVgdUi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FseJN0PP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FseJN0PP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0DDC4CEF1;
	Fri,  8 Aug 2025 20:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754684643;
	bh=BtM6BMMEeqaSoA6VVVaVCAYSIxGqXH8ttenj0C6a8Jc=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=FseJN0PPqrsHZ38kA7I2DzDDzzEWr8hB5ncW30fPtSfxMQ+2ECejMPfgLh8+4PYL/
	 r9F1G9lWv4P9VgvmidjJWV3GNe3WoUsiXh7lzZviKcRdb94JSho5e5vwMBz6baHFU8
	 Eiml2H9EjIGp5j7FoYBiijBslNkcDseV9/Vn+1cdZJ6XbU2Q8k9TNtosiS6+OtPoaw
	 5/tZX5zE24Z9uzxl2QSUVF5WHA6SAmmJvbIVSdsQpTDDf4OIG9MPK0IyFcIdyGwJcE
	 IUV2i6Qd7CNbTFf2Ho8hp9B+b2V12I40AmFyGki0VI8bk85mK0yGH2hlry/DvccyWG
	 CBToF3o4OJNwA==
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 Aug 2025 22:23:57 +0200
Message-Id: <DBXBSI1JIA2I.25JIR4ETX81BG@kernel.org>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, <acourbot@nvidia.com>, <dakr@kernel.org>,
 <jgg@ziepe.ca>, <lyude@redhat.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@gmail.com>, "FUJITA
 Tomonori" <fujita.tomonori@gmail.com>, <linux-kernel@vger.kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Herbert Xu" <herbert@gondor.apana.org.au>, "Caleb
 Sander Mateos" <csander@purestorage.com>, "Petr Tesarik"
 <petr@tesarici.cz>, "Sui Jingfeng" <sui.jingfeng@linux.dev>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, "Robin Murphy"
 <robin.murphy@arm.com>, <airlied@redhat.com>, <iommu@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] rust: add initial scatterlist abstraction
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250718103359.1026240-1-abdiel.janulgue@gmail.com>
 <svnEDqCdZr-7JmEPS7j6SimFKAzIdtHcYetQSBcQ2vjeupZsBpT_ELybyR3nO_ZXM4nkQJG9UwyKRCNkyO7-HA==@protonmail.internalid> <20250718103359.1026240-2-abdiel.janulgue@gmail.com> <877bze553r.fsf@kernel.org>
In-Reply-To: <877bze553r.fsf@kernel.org>

On Fri Aug 8, 2025 at 3:13 PM CEST, Andreas Hindborg wrote:
> "Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:
>> +    /// let mut pages =3D KVec::new();
>> +    /// let _ =3D pages.push(Page::alloc_page(GFP_KERNEL)?, GFP_KERNEL)=
;
>> +    /// let _ =3D pages.push(Page::alloc_page(GFP_KERNEL)?, GFP_KERNEL)=
;
>> +    /// let sgt =3D SGTable::new_owned(PagesArray(pages), GFP_KERNEL)?;
>> +    /// # Ok::<(), Error>(())
>> +    /// ```
>> +    pub fn new_owned(pages: P, flags: kernel::alloc::Flags) -> Result<S=
elf> {
>> +        // SAFETY: `sgt` is not a reference.
>> +        let mut sgt: bindings::sg_table =3D unsafe { core::mem::zeroed(=
) };
>
> I think this unsafe goes away with recent pin-init patches.
>
> https://lore.kernel.org/r/20250523145125.523275-1-lossin@kernel.org

Yes that should work. I'll send a new version when -rc1 comes out.

---
Cheers,
Benno
