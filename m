Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E1A19C542;
	Wed,  5 Mar 2025 18:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200251; cv=none; b=u+BaiVfyVSn48B8CYEA3Fz7xz6sy9QgQhp3VvosB2XfvfPN1UW6bYT6YjU5Yk5BMKCQFwhi+VTU6oGhl/8p2RCsPoYPxNLT5K33HG5p6Cvp/s1lH1W7aLBqF8LEDSB9cy+Ks26AMU7Y8rkseE/g3g8IfZMMh9y05fzWAi3enuso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200251; c=relaxed/simple;
	bh=rz2u+yhpHdNdyfyhdEIB4K+V3QkZKS2rxaRVdy6U+Wk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tr2FM/ix506m/li/w8dTO1BfGV4KiORYtBMeufK2s4Sz6RK0lFdgRr6wC2S8/egsq5otmit4DVbAUmTIggMgeFtunHLW4HDxhrtKkHIsmZ+TE2o4y4TwjbBo+ghPqsryNU8/wDf/Y+IP9T0R878FpFrbMl3+lV16xtMWZku/MjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZY+F5o7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZY+F5o7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2388C4CEE8;
	Wed,  5 Mar 2025 18:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741200250;
	bh=rz2u+yhpHdNdyfyhdEIB4K+V3QkZKS2rxaRVdy6U+Wk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aZY+F5o7E/PF3JWX0chEfU+AGJe6SukhXGHKUrn+yAXchuGNjIe7ET12TvPHioi8B
	 /prVxEBWez6yYNfABwn68DiLrBzxvDepqNTxk+ZQTmT2kZArhHxAqkA1xsWbEeNDCQ
	 JiFkuU/relcHkka1XgtP/53btrQbIIBzWrArUO4YQ3BZt8J5+gX7xnKS0K+xEC+1uf
	 AMkLtGvjzvfnrQwW+s+1uhDmvnrrwqFmLSrf/pmzOgam1PuHWPo7IkI4JGc7Hlb0mr
	 lqaP1lh+EBRoxMDxd9Wpeahhp+ydNH0J6+ignuupBPLMw6R3rB1kCJL2HdoorQxCc4
	 mn8AXwyrjFXjg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Ralf Jung" <post@ralfj.de>
Cc: "Alice Ryhl" <aliceryhl@google.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "comex" <comexk@gmail.com>,  "Daniel Almeida"
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
In-Reply-To: <3aabca39-4658-454a-b0e3-e946e72977e1@ralfj.de> (Ralf Jung's
	message of "Wed, 05 Mar 2025 14:27:42 +0100")
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
	<CAH5fLgidPHQzdUORNpNhtRFsKPU1T-0xdn5OSwYYZh3BgOVRQA@mail.gmail.com>
	<18cmxblLU2QAa4YP25RWCKEnxuonOwWXavYmSsS4C5D40o8RaCkIXo0UDZ2SPnksk5nWYB29Y4zHkjQeOgd4ng==@protonmail.internalid>
	<3aabca39-4658-454a-b0e3-e946e72977e1@ralfj.de>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 19:43:59 +0100
Message-ID: <87eczb71xs.fsf@kernel.org>
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
> On 05.03.25 14:23, Alice Ryhl wrote:
>> On Wed, Mar 5, 2025 at 2:10=E2=80=AFPM Ralf Jung <post@ralfj.de> wrote:
>>>
>>> Hi,
>>>
>>> On 05.03.25 04:24, Boqun Feng wrote:
>>>> On Tue, Mar 04, 2025 at 12:18:28PM -0800, comex wrote:
>>>>>
>>>>>> On Mar 4, 2025, at 11:03=E2=80=AFAM, Ralf Jung <post@ralfj.de> wrote:
>>>>> However, these optimizations should rarely trigger misbehavior in
>>>>> practice, so I wouldn=E2=80=99t be surprised if Linux had some code t=
hat
>>>>> expected memcpy to act volatile=E2=80=A6
>>>>>
>>>>
>>>> Also in this particular case we are discussing [1], it's a memcpy (from
>>>> or to) a DMA buffer, which means the device can also read or write the
>>>> memory, therefore the content of the memory may be altered outside the
>>>> program (the kernel), so we cannot use copy_nonoverlapping() I believe.
>>>>
>>>> [1]: https://lore.kernel.org/rust-for-linux/87bjuil15w.fsf@kernel.org/
>>>
>>> Is there actually a potential for races (with reads by hardware, not ot=
her
>>> threads) on the memcpy'd memory? Or is this the pattern where you copy =
some data
>>> somewhere and then set a flag in an MMIO register to indicate that the =
data is
>>> ready and the device can start reading it? In the latter case, the actu=
al data
>>> copy does not race with anything, so it can be a regular non-atomic non=
-volatile
>>> memcpy. The flag write *should* be a release write, and release volatil=
e writes
>>> do not exist, so that is a problem, but it's a separate problem from vo=
latile
>>> memcpy. One can use a release fence followed by a relaxed write instead.
>>> Volatile writes do not currently act like relaxed writes, but you need =
that
>>> anyway for WRITE_ONCE to make sense so it seems fine to rely on that he=
re as well.
>>>
>>> Rust should have atomic volatile accesses, and various ideas have been =
proposed
>>> over the years, but sadly nobody has shown up to try and push this thro=
ugh.
>>>
>>> If the memcpy itself can indeed race, you need an atomic volatile memcp=
y --
>>> which neither C nor Rust have, though there are proposals for atomic me=
mcpy (and
>>> arguably, there should be a way to interact with a device using non-vol=
atile
>>> atomics... but anyway in the LKMM, atomics are modeled with volatile, s=
o things
>>> are even more entangled than usual ;).
>>
>> For some kinds of hardware, we might not want to trust the hardware.
>> I.e., there is no race under normal operation, but the hardware could
>> have a bug or be malicious and we might not want that to result in UB.
>> This is pretty similar to syscalls that take a pointer into userspace
>> memory and read it - userspace shouldn't modify that memory during the
>> syscall, but it can and if it does, that should be well-defined.
>> (Though in the case of userspace, the copy happens in asm since it
>> also needs to deal with virtual memory and so on.)
>
> Wow you are really doing your best to combine all the hard problems at th=
e same
> time. ;)
> Sharing memory with untrusted parties is another tricky issue, and even l=
eaving
> aside all the theoretical trouble, practically speaking you'll want to
> exclusively use atomic accesses to interact with such memory. So doing th=
is
> properly requires atomic memcpy. I don't know what that is blocked on, bu=
t it is
> good to know that it would help the kernel.

I am sort of baffled by this, since the C kernel has no such thing and
has worked fine for a few years. Is it a property of Rust that causes us
to need atomic memcpy, or is what the C kernel is doing potentially dangero=
us?


Best regards,
Andreas Hindborg

