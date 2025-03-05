Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5D916DC12;
	Wed,  5 Mar 2025 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200104; cv=none; b=alCN+5FU4/ORm+K/tOpT1hVILRck6vxPxXFPBWTk4WbZJIwY/aX20WToRZ8SEp+4EA/D/kfRA08Tc+xX2jz4Ie7321d8wplVQkVi3ubABD5439QQulnOBu+uZ7Fm5m4KSArJHVXZuV1gpxax1NRTH2BF2dOqbC4Tqsts9yG9gwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200104; c=relaxed/simple;
	bh=jrTF4JMcaFmMJw5i9Y0SheL3I3+C988b/8M3zT7DPQQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KC8fjnzOseEjWh70fU2YSDR/0Eg1Cg2NcgQbWlyUtpMSNcHO1zSIBMCU8QFbNUX4e8VRBW0IwEpw8iIRCQ8c3eNx+a1llskxtmZselY9Rg0zV5Uu3KZruFwionzbTZvTbiWZ/3dXqCsEhAgZHnMASvXXVUavSimDP4kCYg1OTB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quE/LTeX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quE/LTeX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A491C4CED1;
	Wed,  5 Mar 2025 18:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741200103;
	bh=jrTF4JMcaFmMJw5i9Y0SheL3I3+C988b/8M3zT7DPQQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=quE/LTeXSwhUffGGAzooZ1Yl/ZraoMBEHvZ8jjPjn/FCnwQue38yuTstJRn6s3Qaw
	 q7IYjHDop4LrJ7b4gqOOEc5jBjHU2qHiaJ3UScJInIt3p44P65C+rtC1qziO4d5dXY
	 bt6bUvqAqw2OL+PNvOuPPg1W4ettR23PdU6lCiOmaaKUncfzwPZ8f64VLj9l2LlkrE
	 7C82peiCumji0FLb5M3vHYP4UDMCGZwZIYob/gVIsGq5pV15b9N/D18sqLZnYe3nqP
	 tikuzsuJZmnIqe4aGakZudz7foF1QaH0A3cvMLGTOLHH6jtaR8td/9out/BGLf2Bgs
	 p8LJOj+56FqMw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Ralf Jung" <post@ralfj.de>,  "Boqun Feng" <boqun.feng@gmail.com>,
  "comex" <comexk@gmail.com>,  "Daniel Almeida"
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
In-Reply-To: <CAH5fLgidPHQzdUORNpNhtRFsKPU1T-0xdn5OSwYYZh3BgOVRQA@mail.gmail.com>
 (Alice
	Ryhl's message of "Wed, 05 Mar 2025 14:23:02 +0100")
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
	<c8XEELyWlEkykLJUfbrplzODPHngzTQyo4_bP9rgjpSIEgY8M6anS_c28cFdUUuBmC36WQhx6WmBZytIHu7VTw==@protonmail.internalid>
	<CAH5fLgidPHQzdUORNpNhtRFsKPU1T-0xdn5OSwYYZh3BgOVRQA@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 19:41:34 +0100
Message-ID: <87jz93721t.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Wed, Mar 5, 2025 at 2:10=E2=80=AFPM Ralf Jung <post@ralfj.de> wrote:
>>
>> Hi,
>>
>> On 05.03.25 04:24, Boqun Feng wrote:
>> > On Tue, Mar 04, 2025 at 12:18:28PM -0800, comex wrote:
>> >>
>> >>> On Mar 4, 2025, at 11:03=E2=80=AFAM, Ralf Jung <post@ralfj.de> wrote:
>> >> However, these optimizations should rarely trigger misbehavior in
>> >> practice, so I wouldn=E2=80=99t be surprised if Linux had some code t=
hat
>> >> expected memcpy to act volatile=E2=80=A6
>> >>
>> >
>> > Also in this particular case we are discussing [1], it's a memcpy (from
>> > or to) a DMA buffer, which means the device can also read or write the
>> > memory, therefore the content of the memory may be altered outside the
>> > program (the kernel), so we cannot use copy_nonoverlapping() I believe.
>> >
>> > [1]: https://lore.kernel.org/rust-for-linux/87bjuil15w.fsf@kernel.org/
>>
>> Is there actually a potential for races (with reads by hardware, not oth=
er
>> threads) on the memcpy'd memory? Or is this the pattern where you copy s=
ome data
>> somewhere and then set a flag in an MMIO register to indicate that the d=
ata is
>> ready and the device can start reading it? In the latter case, the actua=
l data
>> copy does not race with anything, so it can be a regular non-atomic non-=
volatile
>> memcpy. The flag write *should* be a release write, and release volatile=
 writes
>> do not exist, so that is a problem, but it's a separate problem from vol=
atile
>> memcpy. One can use a release fence followed by a relaxed write instead.
>> Volatile writes do not currently act like relaxed writes, but you need t=
hat
>> anyway for WRITE_ONCE to make sense so it seems fine to rely on that her=
e as well.
>>
>> Rust should have atomic volatile accesses, and various ideas have been p=
roposed
>> over the years, but sadly nobody has shown up to try and push this throu=
gh.
>>
>> If the memcpy itself can indeed race, you need an atomic volatile memcpy=
 --
>> which neither C nor Rust have, though there are proposals for atomic mem=
cpy (and
>> arguably, there should be a way to interact with a device using non-vola=
tile
>> atomics... but anyway in the LKMM, atomics are modeled with volatile, so=
 things
>> are even more entangled than usual ;).
>
> For some kinds of hardware, we might not want to trust the hardware.
> I.e., there is no race under normal operation, but the hardware could
> have a bug or be malicious and we might not want that to result in UB.
> This is pretty similar to syscalls that take a pointer into userspace
> memory and read it - userspace shouldn't modify that memory during the
> syscall, but it can and if it does, that should be well-defined.
> (Though in the case of userspace, the copy happens in asm since it
> also needs to deal with virtual memory and so on.)

Could you point me to this code? As mentioned in a parallel email in
this thread, zero copy file i/o has this property. User space pages are
mapped into the kernel and read from / written to. C just calls `memcpy`
for this.


Best regards,
Andreas Hindborg


