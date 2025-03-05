Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E82019DF48;
	Wed,  5 Mar 2025 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741199925; cv=none; b=WJhmLYPLp44XwEjYdV9QQCiwy2R0PorI8omGR4YbjRFYYV+WhopA1f0/kMtjBIt3wOuMPBTcDqCyBcdVrkbBdJplaIu0AVSy1cYLTOr96N3fVERIrUY+hnI3gHG8olvTWe+KRbKbNsj7FMXgyoNr7BEwii4FvIKSfRl4lca91c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741199925; c=relaxed/simple;
	bh=jnlYquWUWCXFkjZHXuXtKZdS0DV1u8yLj54ooDG+33o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CuduoLCyYwySUY0Lo4OgiUAlJHeuuW4hqf43SyC6YnXSIxerLkXqjyK93ai9BknQirfn3XYGs4VW2/6WlxMBBZP1FvoEHvh7jUW3ECpHeMa4cYAbRJ+5Kodtt+7SdsKfRS8gEeFLiXyABr71VbWuI7/vb89lbLbzuZHD73lWkrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VN22wHZi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VN22wHZi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF07C4CED1;
	Wed,  5 Mar 2025 18:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741199924;
	bh=jnlYquWUWCXFkjZHXuXtKZdS0DV1u8yLj54ooDG+33o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VN22wHZifU9RHzZrSGZ8TZThoFEAxoz/vJihPyepbxQnfrQhnJVrv340Tsa7Pwmmf
	 4G/f7QKqzkfpiSLnzBFfccnNW/oFF4pIY0mZy7IKYA1pHzsjbiAETHazkhdnXM5aP7
	 TCT0gOGls/LeWaaLkTtI4Jr0EG9zPTqivFi8UK7n6QGbpOJHEyQ/VmBFtDFo1y1l+B
	 GtLhOXWGmJn0TcweRqmPDOwr7vWaJS+O9txxJkT2yU3KL9C0b/30DKV+EvvF+0fvQJ
	 3HK/Mlew5rIsztmyk8ToEbLh3RnDnR5iSrLbwvvFED5IVyEwR/J79fGgMLVWIIg7OD
	 6rc008cDx6ADg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Ralf Jung" <post@ralfj.de>
Cc: "Boqun Feng" <boqun.feng@gmail.com>,  "comex" <comexk@gmail.com>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Daniel Almeida"
 <daniel.almeida@collabora.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,  <dakr@kernel.org>,
  <robin.murphy@arm.com>,  <rust-for-linux@vger.kernel.org>,  "Miguel
 Ojeda" <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Gary
 Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Valentin Obst"
 <kernel@valentinobst.de>,  <linux-kernel@vger.kernel.org>,  "Christoph
 Hellwig" <hch@lst.de>,  "Marek Szyprowski" <m.szyprowski@samsung.com>,
  <airlied@redhat.com>,  <iommu@lists.linux.dev>,  <lkmm@lists.linux.dev>
Subject: Re: Allow data races on some read/write operations
In-Reply-To: <25e7e425-ae72-4370-ae95-958882a07df9@ralfj.de> (Ralf Jung's
	message of "Wed, 05 Mar 2025 14:10:22 +0100")
References: <87bjuil15w.fsf@kernel.org>
	<t4HxdvR7WBX_861hiTXo72jqC9F9oRpIzgA_dD2yhcSuLISEkC-shMfSgllrFPpnkSZXGfRcc47keudMooNiIQ==@protonmail.internalid>
	<CAH5fLgg5MuUu=TX8mMsPf5RcLhMLHSU4Vct=h8rFX6Z7HjPxeA@mail.gmail.com>
	<87ikoqjg1n.fsf@kernel.org>
	<KpWTCfIlcLYFBpSvWPfALJ9VQn5a99_RAvxgMBc1aCrSalPB-qaW9IhXyaDG7HM1AcFPX5chj_Yr7IQp3F7UqA==@protonmail.internalid>
	<CAH5fLgh6ubawHh76wq7JPbcuBCWhm91m7Rc01MVsX-a3C6qaVA@mail.gmail.com>
	<87mse2hrd8.fsf@kernel.org> <Z8YMTiKS4T9wC4t_@boqun-archlinux>
	<ae8ac31f-c6ad-46ae-80dd-10ec081a16d1@ralfj.de>
	<88456D33-C5CA-4F4F-990E-8C5F2AF7EAF9@gmail.com>
	<hkhgihg4fjkg7zleqnumuj65dfvmxa5rzawkiafrf4kn5ss6nw@o7kc6xe2bmuj>
	<9wOjabjsxQUrlTOfcLXOYjYxTroyzIPZCy1xeZsv7IctEqEe-iUaGCL4xKebv01sARjrMfYNkPx4sJLtKLmPXA==@protonmail.internalid>
	<25e7e425-ae72-4370-ae95-958882a07df9@ralfj.de>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 19:38:33 +0100
Message-ID: <87pliv726u.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Ralf Jung" <post@ralfj.de> writes:

> Hi,
>
> On 05.03.25 04:24, Boqun Feng wrote:
>> On Tue, Mar 04, 2025 at 12:18:28PM -0800, comex wrote:
>>>
>>>> On Mar 4, 2025, at 11:03=E2=80=AFAM, Ralf Jung <post@ralfj.de> wrote:
>>>>
>>>> Those already exist in Rust, albeit only unstably:
>>>> <https://doc.rust-lang.org/nightly/std/intrinsics/fn.volatile_copy_mem=
ory.html>.
>>>> However, I am not sure how you'd even generate such a call in C? The
>>>> standard memcpy function is not doing volatile accesses, to my
>>>> knowledge.
>>>
>>> The actual memcpy symbol that exists at runtime is written in
>>> assembly, and should be valid to treat as performing volatile
>>> accesses.
>
> memcpy is often written in C... and AFAIK compilers understand what that
> function does and will, for instance, happily eliminate the call if they =
can
> prove that the destination memory is not being read from again. So, it do=
esn't
> behave like a volatile access at all.
>
>>> But both GCC and Clang special-case the memcpy function.  For example,
>>> if you call memcpy with a small constant as the size, the optimizer
>>> will transform the call into one or more regular loads/stores, which
>>> can then be optimized mostly like any other loads/stores (except for
>>> opting out of alignment and type-based aliasing assumptions).  Even if
>>> the call isn=E2=80=99t transformed, the optimizer will still make assum=
ptions.
>>> LLVM will automatically mark memcpy `nosync`, which makes it undefined
>>> behavior if the function =E2=80=9Ccommunicate[s] (synchronize[s]) with =
another
>>> thread=E2=80=9D, including through =E2=80=9Cvolatile accesses=E2=80=9D.=
 [1]
>
> The question is more,  what do clang and GCC document / guarantee in a st=
able
> way regarding memcpy? I have not seen any indication so far that a memcpy=
 call
> would ever be considered volatile, so we have to treat it like a non-vola=
tile
> non-atomic operation.
>
>>> However, these optimizations should rarely trigger misbehavior in
>>> practice, so I wouldn=E2=80=99t be surprised if Linux had some code that
>>> expected memcpy to act volatile=E2=80=A6
>>>
>>
>> Also in this particular case we are discussing [1], it's a memcpy (from
>> or to) a DMA buffer, which means the device can also read or write the
>> memory, therefore the content of the memory may be altered outside the
>> program (the kernel), so we cannot use copy_nonoverlapping() I believe.
>>
>> [1]: https://lore.kernel.org/rust-for-linux/87bjuil15w.fsf@kernel.org/
>
> Is there actually a potential for races (with reads by hardware, not other
> threads) on the memcpy'd memory?

There is another use case for this: copying data to/from a page that is
mapped into user space. In this case, a user space process can
potentially modify the data in the mapped page while we are
reading/writing that data. This would be a misbehaved user space
process, but it should not be able to cause UB in the kernel anyway.

The C kernel just calls memcpy directly for this use case.

For this use case, we do not interpret or make control flow decisions
based on the data we read/write. And _if_ user space decides to do
concurrent writes to the page, we don't care if the data becomes
garbage. We just need the UB to be confined to the data moved from that
page, and not leak into the rest of the kernel.


Best regards,
Andreas Hindborg


