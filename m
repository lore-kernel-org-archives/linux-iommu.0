Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFF62451F3;
	Wed,  5 Mar 2025 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184807; cv=pass; b=cfAevzMD4spI4WKPpnrlq99dfg2df/LnAtfdY3h+dsl80q/5FUimwHBzoC3HEXRWzckjo+9KWBMjW8bBWzEj2MyWEvmIK4ic1fpkCwucqrf4LacpVakDTfyryHC3LfF3an6Prgqt7b1FPXR6W8erjSYTSMwU49whJf36xU4tO0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184807; c=relaxed/simple;
	bh=/Z9S0QzKDsuLG0+3X3XdL82r5DXrvOFAaAskQNYSId4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SDYoJHYnqPZj6Vioegbf4xWFKt6cWDTlGUY3d5HF7omOtgs2ROo+AeGOnYm9zkbIEtlr961CtHMo99cC8ZD+yUhVBvztZH/pQ+ItD0OKBwaWgx9m9grYDe7AaWe7sF3k+c/wSV9oB6VSwY9RuCBzCKqhrIk6y1o4RTTtX7IBQvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=RekStM0K; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="RekStM0K"
ARC-Seal: i=1; a=rsa-sha256; t=1741184778; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UNe32RR04FyEtxJr78wuwJoPPVIRQJ/9ZZVrbt8MSyvtwmPpfoQlWjDO6l2ibYVqLMdcFelA5vds3leEP0F4NFkbOsjRHu644aLrsSDHwUqcVpCxiBw+TcvbQiSsdvHSKyjUJ8yT5kBIJNwtauWVdquf8RomVTEXIOlT4r6jhjA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741184778; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AdsW+1At4dzqwKDMRG+xhUkB9QjIq0jRnj5pAKgqr7Q=; 
	b=OXt96sUQvHVTNUyBiyYNSAjazgswZrJYRHmjY537bKwCQcl0w9CKzRYO8t+/3+mybKlS8XOrrCs07zXBl49bjHw/UaNji5pvZOAaPeZFYpFsFLjIrwNGMNFx3iVf0jAhjXGOyu1By8r0WaIxSmTvp25Qh0mFTJcXDH3keQzF110=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741184778;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=AdsW+1At4dzqwKDMRG+xhUkB9QjIq0jRnj5pAKgqr7Q=;
	b=RekStM0KWIrf2d7tmLV0YwK/ffv+lYmKJenAW06PEzAbke5LQEb7vHepf7wdPP2M
	0LQHWJwHa7RIV1CF5IIDXBR5jwGf6ItIj9K5PdOa/rrvdeLJBjPIWKrwnne+CqyK30v
	qHIWs7N7ed3dkSwT0fr3oZuRjxhJ8KCNhXT8lm/k=
Received: by mx.zohomail.com with SMTPS id 1741184776075416.8048596435848;
	Wed, 5 Mar 2025 06:26:16 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: Allow data races on some read/write operations
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <25e7e425-ae72-4370-ae95-958882a07df9@ralfj.de>
Date: Wed, 5 Mar 2025 11:25:58 -0300
Cc: Boqun Feng <boqun.feng@gmail.com>,
 comex <comexk@gmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 dakr@kernel.org,
 robin.murphy@arm.com,
 rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 airlied@redhat.com,
 iommu@lists.linux.dev,
 lkmm@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <23E19975-0AF5-4223-B05D-4891747B7C15@collabora.com>
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
 <25e7e425-ae72-4370-ae95-958882a07df9@ralfj.de>
To: Ralf Jung <post@ralfj.de>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External

Hi Rafl,

> On 5 Mar 2025, at 10:10, Ralf Jung <post@ralfj.de> wrote:
>=20
> Hi,
>=20
> On 05.03.25 04:24, Boqun Feng wrote:
>> On Tue, Mar 04, 2025 at 12:18:28PM -0800, comex wrote:
>>>=20
>>>> On Mar 4, 2025, at 11:03=E2=80=AFAM, Ralf Jung <post@ralfj.de> =
wrote:
>>>>=20
>>>> Those already exist in Rust, albeit only unstably:
>>>> =
<https://doc.rust-lang.org/nightly/std/intrinsics/fn.volatile_copy_memory.=
html>.
>>>> However, I am not sure how you'd even generate such a call in C? =
The
>>>> standard memcpy function is not doing volatile accesses, to my
>>>> knowledge.
>>>=20
>>> The actual memcpy symbol that exists at runtime is written in
>>> assembly, and should be valid to treat as performing volatile
>>> accesses.
>=20
> memcpy is often written in C... and AFAIK compilers understand what =
that function does and will, for instance, happily eliminate the call if =
they can prove that the destination memory is not being read from again. =
So, it doesn't behave like a volatile access at all.
>=20
>>> But both GCC and Clang special-case the memcpy function.  For =
example,
>>> if you call memcpy with a small constant as the size, the optimizer
>>> will transform the call into one or more regular loads/stores, which
>>> can then be optimized mostly like any other loads/stores (except for
>>> opting out of alignment and type-based aliasing assumptions).  Even =
if
>>> the call isn=E2=80=99t transformed, the optimizer will still make =
assumptions.
>>> LLVM will automatically mark memcpy `nosync`, which makes it =
undefined
>>> behavior if the function =E2=80=9Ccommunicate[s] (synchronize[s]) =
with another
>>> thread=E2=80=9D, including through =E2=80=9Cvolatile accesses=E2=80=9D=
. [1]
>=20
> The question is more,  what do clang and GCC document / guarantee in a =
stable way regarding memcpy? I have not seen any indication so far that =
a memcpy call would ever be considered volatile, so we have to treat it =
like a non-volatile non-atomic operation.
>=20
>>> However, these optimizations should rarely trigger misbehavior in
>>> practice, so I wouldn=E2=80=99t be surprised if Linux had some code =
that
>>> expected memcpy to act volatile=E2=80=A6
>>>=20
>> Also in this particular case we are discussing [1], it's a memcpy =
(from
>> or to) a DMA buffer, which means the device can also read or write =
the
>> memory, therefore the content of the memory may be altered outside =
the
>> program (the kernel), so we cannot use copy_nonoverlapping() I =
believe.
>> [1]: =
https://lore.kernel.org/rust-for-linux/87bjuil15w.fsf@kernel.org/
>=20
> Is there actually a potential for races (with reads by hardware, not =
other threads) on the memcpy'd memory? Or is this the pattern where you =
copy some data somewhere and then set a flag in an MMIO register to =
indicate that the data is ready and the device can start reading it? In =
the latter case, the actual data copy does not race with anything, so it =
can be a

This is device-specific.

e.g.: for video codecs, if you don=E2=80=99t set a bit that starts the =
decode or
encode process for the current frame, everything remains as-is, i.e.: =
untouched
by the hardware. I can=E2=80=99t vouch for all other devices, and people =
have
already chimed in to say this is not necessarily the case for some of =
them.

> regular non-atomic non-volatile memcpy. The flag write *should* be a =
release write, and release volatile writes do not exist, so that is a =
problem, but it's a separate problem from volatile memcpy. One can use a =
release fence followed by a relaxed write instead. Volatile writes do =
not currently act like relaxed writes, but you need that anyway for =
WRITE_ONCE to make sense so it seems fine to rely on that here as well.
>=20
> Rust should have atomic volatile accesses, and various ideas have been =
proposed over the years, but sadly nobody has shown up to try and push =
this through.
>=20
> If the memcpy itself can indeed race, you need an atomic volatile =
memcpy -- which neither C nor Rust have, though there are proposals for =
atomic memcpy (and arguably, there should be a way to interact with a =
device using non-volatile atomics... but anyway in the LKMM, atomics are =
modeled with volatile, so things are even more entangled than usual ;).
>=20
> Kind regards,
> Ralf
>=20

=E2=80=94 Daniel

