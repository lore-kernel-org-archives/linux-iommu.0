Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711FF185E4A;
	Mon,  3 Mar 2025 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741028419; cv=none; b=H7yds8SDqAr0ReOfi+nad71KkD/MmJTGtqhbp0gHiB+Xw1TOHoBtD89ks51kNTZc36CE8VwIXB5vnRhJbG0isqQWWFStcHIAbF8LeHRJ9QqK44pMlnerhMzAcohsPXDDfW7Wq5q0bMCdNztTVtzEL+m4J0sj4pgHzthrDa+vIa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741028419; c=relaxed/simple;
	bh=WnvKPZ0Oo7kUydTf7iYJkS5mw9NzxcUP7F/J0sWZKPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IWvq1/eaHDnDwl+QK8uwU6djQ6xzLsx+ou0zbHF1ZjLClUjrSbYy6PCl3JIFikz+j8mT2F8Su+pdXxHXvpvbeuknowPcrCrISRQzyl8oCM60u+8rDgczLhvEHLUYWmTmUlT6BHGHrxlw09gzeFQ2/63EHt6iqi29OIJsaL5ceFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYN/Jfi0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYN/Jfi0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E733CC4CED6;
	Mon,  3 Mar 2025 19:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741028419;
	bh=WnvKPZ0Oo7kUydTf7iYJkS5mw9NzxcUP7F/J0sWZKPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UYN/Jfi0KDZ09gScm/TPeU4GKRwyVpT2oPgl4UQreDJWZq8OVebvC6M8kbVNKrWOk
	 eEFklE8X1QSo8oztC5hQY7uXs5Zu4GO6AzQLwwESxzeHuBVTGx3tOeoMF4TySoksid
	 xqsik2lFFQB2voxb5tu/SCJuVGZh1LIOKFUyHu8MEYnsw7Wxb4qvokQr/TKhOx56zU
	 eZcc4cS1QhRyavJNYamgSGecanY6k6hgMuEno7wkpnKTXstAsZ5HATX/CSZ9GEqxSo
	 at3ZkOzerB4hiri97Pm//wNLA/2/qnRPxLz3SCZqZCr2EBpo19f9SCTOZp4I3UqJ+2
	 NQ1giRAyOjKcQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>,
	"Benno Lossin" <benno.lossin@proton.me>,
	"Abdiel Janulgue" <abdiel.janulgue@gmail.com>,  <dakr@kernel.org>,
	<robin.murphy@arm.com>,  <rust-for-linux@vger.kernel.org>,
	"Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,
	"Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
	=?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	"Trevor Gross" <tmgross@umich.edu>,
	"Valentin Obst" <kernel@valentinobst.de>,  <linux-kernel@vger.kernel.org>,
	"Christoph Hellwig" <hch@lst.de>,
	"Marek Szyprowski" <m.szyprowski@samsung.com>,  <airlied@redhat.com>,
	<iommu@lists.linux.dev>
Subject: Allow data races on some read/write operations
In-Reply-To: <CAH5fLgh6ubawHh76wq7JPbcuBCWhm91m7Rc01MVsX-a3C6qaVA@mail.gmail.com>
 (Alice
	Ryhl's message of "Mon, 03 Mar 2025 16:44:51 +0100")
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
	<20250224115007.2072043-3-abdiel.janulgue@gmail.com>
	<6dea7b6a-1534-47e7-94d2-d67417c3d4c1@proton.me>
	<tnwDK3QN_Xr0Yoa3U8HVxS5OqjvxIhgmmO_ifTGJR_EtIzjoxawOHtnbOJ9yChsUWXyFPcU9beIdrgbpfGZI8w==@protonmail.internalid>
	<3202F69F-397E-4BC4-8DD8-E2D4B0AB056F@collabora.com>
	<87bjuil15w.fsf@kernel.org>
	<t4HxdvR7WBX_861hiTXo72jqC9F9oRpIzgA_dD2yhcSuLISEkC-shMfSgllrFPpnkSZXGfRcc47keudMooNiIQ==@protonmail.internalid>
	<CAH5fLgg5MuUu=TX8mMsPf5RcLhMLHSU4Vct=h8rFX6Z7HjPxeA@mail.gmail.com>
	<87ikoqjg1n.fsf@kernel.org>
	<KpWTCfIlcLYFBpSvWPfALJ9VQn5a99_RAvxgMBc1aCrSalPB-qaW9IhXyaDG7HM1AcFPX5chj_Yr7IQp3F7UqA==@protonmail.internalid>
	<CAH5fLgh6ubawHh76wq7JPbcuBCWhm91m7Rc01MVsX-a3C6qaVA@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 03 Mar 2025 20:00:03 +0100
Message-ID: <87mse2hrd8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


[New subject, was: Re: [PATCH v12 2/3] rust: add dma coherent allocator abs=
traction]

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Mon, Mar 3, 2025 at 4:21=E2=80=AFPM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>>
>> "Alice Ryhl" <aliceryhl@google.com> writes:
>>
>> > On Mon, Mar 3, 2025 at 2:00=E2=80=AFPM Andreas Hindborg <a.hindborg@ke=
rnel.org> wrote:
>> >>
>> >> "Daniel Almeida" <daniel.almeida@collabora.com> writes:
>> >>
>> >> > Hi Benno,
>> >> >
>> >>
>> >> [...]
>> >>
>> >> >>> +    /// Writes data to the region starting from `offset`. `offse=
t` is in units of `T`, not the
>> >> >>> +    /// number of bytes.
>> >> >>> +    ///
>> >> >>> +    /// # Examples
>> >> >>> +    ///
>> >> >>> +    /// ```
>> >> >>> +    /// # fn test(alloc: &mut kernel::dma::CoherentAllocation<u8=
>) -> Result {
>> >> >>> +    /// let somedata: [u8; 4] =3D [0xf; 4];
>> >> >>> +    /// let buf: &[u8] =3D &somedata;
>> >> >>> +    /// alloc.write(buf, 0)?;
>> >> >>> +    /// # Ok::<(), Error>(()) }
>> >> >>> +    /// ```
>> >> >>> +    pub fn write(&self, src: &[T], offset: usize) -> Result {
>> >> >>> +        let end =3D offset.checked_add(src.len()).ok_or(EOVERFLO=
W)?;
>> >> >>> +        if end >=3D self.count {
>> >> >>> +            return Err(EINVAL);
>> >> >>> +        }
>> >> >>> +        // SAFETY:
>> >> >>> +        // - The pointer is valid due to type invariant on `Cohe=
rentAllocation`
>> >> >>> +        // and we've just checked that the range and index is wi=
thin bounds.
>> >> >>> +        // - `offset` can't overflow since it is smaller than `s=
elfcount` and we've checked
>> >> >>> +        // that `self.count` won't overflow early in the constru=
ctor.
>> >> >>> +        unsafe {
>> >> >>> +            core::ptr::copy_nonoverlapping(src.as_ptr(), self.cp=
u_addr.add(offset), src.len())
>> >> >>
>> >> >> Why are there no concurrent write or read operations on `cpu_addr`?
>> >> >
>> >> > Sorry, can you rephrase this question?
>> >>
>> >> This write is suffering the same complications as discussed here [1].
>> >> There are multiple issues with this implementation.
>> >>
>> >> 1) `write` takes a shared reference and thus may be called concurrent=
ly.
>> >> There is no synchronization, so `copy_nonoverlapping` could be called
>> >> concurrently on the same address. The safety requirements for
>> >> `copy_nonoverlapping` state that the destination must be valid for
>> >> write. Alice claims in [1] that any memory area that experience data
>> >> races are not valid for writes. So the safety requirement of
>> >> `copy_nonoverlapping` is violated and this call is potential UB.
>> >>
>> >> 2) The destination of this write is DMA memory. It could be concurren=
tly
>> >> modified by hardware, leading to the same issues as 1). Thus the
>> >> function cannot be safe if we cannot guarantee hardware will not write
>> >> to the region while this function is executing.
>> >>
>> >> Now, I don't think that these _should_ be issues, but according to our
>> >> Rust language experts they _are_.
>> >>
>> >> I really think that copying data through a raw pointer to or from a
>> >> place that experiences data races, should _not_ be UB if the data is =
not
>> >> interpreted in any way, other than moving it.
>> >>
>> >>
>> >> Best regards,
>> >> Andreas Hindborg
>> >
>> > We need to make progress on this series, and it's starting to get late
>> > in the cycle. I suggest we:
>>
>> There is always another cycle.
>>
>> >
>> > 1. Delete as_slice, as_slice_mut, write, and skip_drop.
>> > 2. Change field_read/field_write to use a volatile read/write.
>>
>> Volatile reads/writes that race are OK?
>
> I will not give a blanket yes to that. If you read their docs, you
> will find that they claim to not allow it. But they are the correct
> choice for DMA memory, and there's no way in practice to get
> miscompilations on memory locations that are only accessed with
> volatile operations, and never have references to them created.
>
> In general, this will fall into the exception that we've been given
> from the Rust people. In cases such as this where the Rust language
> does not give us the operation we want, do it like you do in C. Since
> Rust uses LLVM which does not miscompile the C part of the kernel, it
> should not miscompile the Rust part either.

This exception we got for `core::ptr::{read,write}_volatile`, did we
document that somewhere?

I feel slightly lost when trying to figure out what fits under this
exception and what is UB. I think that fist step to making this more
straight forward is having clear documentation.

For cases where we need to do the equivalent of `memmove`/`memcpy`, what
are is our options?

In case we have no options, do you know who would be the right people on
the Rust Project side to contact about getting an exception for this
case?


Best regards,
Andreas Hindborg


