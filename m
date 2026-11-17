Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794946186;
	b=0CHjnYHlI2tnkXzdh/7vVHfKJPDSvw3w1okhoHItisyr+iM1RBqj5KIqcO6upxjE9Wc2
	 eXAyHtvy1Qbcn9LiHEwakzhuNY9URbIudDf7ZehCAYqSMgu5o91Z4JoyMv9eZHK+83dh/
	 vhdJ84kQ1IgCkPlv4fVhEBBUKtJoEVwbufv1BJnDDn28u04N/tSkFFscOxjvtus5NX7aX
	 CL2C2mGXKomLKpsK3pbngVfbhftpuZtUDGsVE1kpVz7+LZf1Mlk1jPkealdu29WnUaI9i
	 hCSSjLWMNYLhBMl0MLql+N9Bag+GhGB40Tvj/GUmhj21WUkAlWkI+3x5fGQjteLXVKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946186;
	h=DMARC-Filter:DKIM-Signature:Received:Content-Type:Mime-Version:
	 Subject:From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:X-Mailer:X-ZohoMailClient;
	bh=l9gKzF4csGCLy05jMvgfB5xApHRqMpbBUWpf7823ToM=;
	b=FLdlnOvmmeL10FefaEZrF4s4F7Q/Cm/xoCCxH5OW0+OShEuAamZYjDaCzOOhvPY5rNvL
	 0LhPT/sUd7+WV1qgKXf3ojSp8suXVaQ9E0YVl5aIlI9ZAIUEliwj58ksHPFoQIQeaKlud
	 j61WosJxAGHKYuqCCk661Ukt4+YvmSPB/1s36nK1qsswK0rmSV6HCuZglqls5waKX0/fh
	 EbMz82fEgsxjOBzRUUD/WPCRbEn2aWUkIObCh5ILKhP0x8jgwHTbdarofT47G38fqkmrh
	 9u/frxxFB8H/IdGvqz/eP4GsKFcisPx5/61dDhEDSEZHv6EF4pKKW/KlCtiyBHRxXkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=DCc13ZXw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401D9606A31C;
	Tue, 17 Nov 2026 20:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 401D9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=DCc13ZXw
ARC-Seal: i=1; a=rsa-sha256; t=1794946172; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=me11B3I2YcRhEMyfakc6pNPNwfJvrjXm8jNgAbUbG8OA/byoFsHKL/8BYiarnYIKzRGzpqsFLuHW3/6f0doZQj1onXJfrUIXXbI1VbIkSzeiIzSaREp9ROCEK38397BMqh1fpl9tTZGa/imXC9HSHf8mdEaOc0tb1AatzsO4CtA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794946172; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=l9gKzF4csGCLy05jMvgfB5xApHRqMpbBUWpf7823ToM=; 
	b=hrJBuzx4sVZWl2/1ZHOgLiEVJKTRSVJqa58ZpmQiC0ZQSPsPszX1QULo81TSUElWrK/pi1ORASwmG4LgBmDS9oHH6orIRQH1cJTBU1N3C90OMjJ1C/GI3jNZkSCTz7HyH+VjQ07D1M78dhJLmnkvOsoGnmpYk34RkQuRmDOCmn0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256; b=DCc13ZXwsJeG8n0EEwMr9TM5O3UfhaRO2ImVjMMy2z4vZu+etNesJFdJj/6LHWwxIAgNurZZI+MJDQ14DBdMie11AjJ6fbat3BIMdS4u5lAQ9brqqbL3oXeeQ7+MjPl0bKt/GmXW366C074B+Z4iAmV1kvJa36fTN6Gb3SvF00s=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=l9gKzF4csGCLy05jMvgfB5xApHRqMpbBUWpf7823ToM=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794946170789661.6773741019286;
	Tue, 17 Nov 2026 12:09:30 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH 0/6] rust: iommu: add a paging domain abstraction
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20261116193821.GC2452510@ziepe.ca>
Date: Tue, 17 Nov 2026 17:09:11 -0300
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 iommu@lists.linux.dev,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3EB4C2ED-B699-4532-A562-68B78F6E29C6@collabora.com>
References: <20261112-b4-iommu-domain-v1-0-c29e86788dda@collabora.com>
 <20261116193821.GC2452510@ziepe.ca>
To: Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-ZohoMailClient: External

Hi Jason,

> On 16 Nov 2026, at 16:38, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>=20
> On Thu, Nov 12, 2026 at 02:00:07PM -0300, Daniel Almeida wrote:
>> This series adds a Rust abstraction for IOMMU paging domains. A =
driver
>> can allocate a domain, attach it to its device, map pages into it, =
and
>> install a handler for its faults.
>>=20
>> This will be used by the upcoming rkvenc driver that my colleagues
>> Detlev Casanova, Nicolas Dufresne and I are working on. More details =
on
>> this driver can be found by watching Nicolas Dufresne's talk at LPC =
2026
>> [0].
>>=20
>> As part of the security model, each client will have its own IOMMU
>> domain. This is needed as the submission model will let userspace set
>> most of the encoder's registers directly, so the kernel cannot check
>> every memory access that a job makes the encoder do. With a single
>> domain, one client could make the encoder read or write the memory of
>> another client.
>=20
> How do you plan to get the paging domain in the first place?


We plan to alloc a paging domain when a video encoder session is =
created. Then
we call iommu_attach_device() before a job runs, and detach back to the =
default
domain after it finishes so the next job can attach its own session's =
domain.
This is so each session is isolated from each other.

>=20
> Using paging domains directly is very complicated, I'm not excite d to
> see DRM trying to do this at all. IMHO there are many unanswered
> questions how it could even do this safely.

In a very simplified way, this is not unlike how GPU drivers currently =
work. In
fact, from a cursory look, this seems to be how rocket (the NPU driver) =
works
too. Since we are merely porting the same ideas to video codec hardware, =
I am a bit
surprised by your discontentment.

(Note, though, that I have never worked on IOMMU drivers, so it is =
possible that
I am missing some context or some history here, in which case, sorry.)

In any case, we need this isolation due to the submission model used.
Most Vulkan drivers know their hardware pretty well, so a level of =
abstraction
on top of it like V4L2 is unnecessary. Therefore, in order to achieve a =
leaner
kernel driver, userspace programs most of the encoder's registers =
directly, so
the kernel cannot validate every address a job makes the encoder access.

Instead of validating, we rely on each session having its own address =
space, so
a job from session X can only reach memory that was mapped for session =
X, and
so misbehaving sessions cannot affect one another. You cannot read or =
write
buffers from another session unless the buffer is explicitly shared.

Again, this is pretty similar to GPU drivers, where a VM_BIND ioctl can =
bind
a given buffer range to an address range in a specific address space.

> It would be better to come with a user so we can try to understand
> what you are even planning.

We do have a user, it is just work in progress. We will likely post an
RFC soon (i.e.: next few weeks I assume).

>=20
>> Patch 6 adds Domain::with_fault_handler(), which allocates a domain
>> with a FaultHandler installed. One handler can serve several domains.
>=20
> You intend to use fault handler?? That's even more esoteric.
>=20
> Jason

The fault handler is used in the same way it is used in GPU drivers: to =
kill
sessions if they fault. This way the driver can simply refuse further =
work from
a misbehaving client, for example. It is also the natural place to =
enqueue a
reset if the codec hardware is frozen as a result of the fault.

What in this model is fundamentally incompatible with how you expect =
paging
domains to be used? In other words, what exactly do you mean when you =
say:

> IMHO there are many unanswered questions how it could even do this =
safely.


-- Daniel

