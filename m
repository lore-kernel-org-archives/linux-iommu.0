Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795029134;
	b=gazWrpsr4v88jbYP32Hbgfpvi1RTlQ1n3L6lUHZYMN4HnUqG7rhUpmsWCEgo7eFw8+Of
	 1Ww3AMmxQf6nlTPNCGAdgDQJWAo10VeE0I9qZFg1VVE7Eep+vFERTYSob/o6nacG+7bT+
	 W1xMCFRLTBeX2zvFssNq2THF0uCpH3KrtwVFfWsPaeJyMnXoWxb9Nn+nz1uFpJy6zSzuL
	 HIbHwjGfAKoojDzeWQpfCQA3ob9U/DPd9tUzFTuBO3Rwei79XEe1+r1YpV1gqraQ1uyUp
	 L9i4JqvCB8OmdzRAj7L1eghjjuzMf9ke3+UgMieBd7iiHXoxpOmwIkq0MP+cycNdoog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029134;
	h=DMARC-Filter:DKIM-Signature:Received:Content-Type:Mime-Version:
	 Subject:From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:X-Mailer:X-ZohoMailClient;
	bh=ItEIAqfkh9HYjyYLYFlHdsVmiv2JFV6DaAPAUqusY5E=;
	b=Dd4uohxJBS3CNKDtYFZmrw1NsZ7N0KfiRS0sxlk+fAqp998KvlFosXl/j362xRmxS/xC
	 Pqu9wk/c1c27FaaLk8kaRgdFv6dZlSRPhuLgm04BBiD3xLl+33CP3ShzhmY9+k9t4+M1R
	 0LIGMhmKEIZXTtpZQWv/PiWRtLvpOjfLV8FRiJN07sfyhRpID3YuM8TApWIBpT6O/DLvY
	 nsBWZwc8o9ykfWuXBEeHWN8+sPSu4cSL+2OXnweM8G/MHqVi+1oOWB6oLsY034jC87pcn
	 /R3X2dkakZN29k7ZgVHMx8P21znvbd1FuudmcwBdHeAG4iybvb100o5D0nN+zvWzE6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b="CHZhBR/n";
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C66606A31C;
	Wed, 18 Nov 2026 19:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3C66606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=CHZhBR/n
ARC-Seal: i=1; a=rsa-sha256; t=1795029121; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SbUtX7o2tXBdzJcUrHgGFvCZiVPQwSCavGNMjLhqtxToc6mdjCvF+hY/uPLUH2Mx1jfBd/rZkEtEkDX2CHdC+Y933U3oYvzFo930HGLwRY+EdK4HGlq1LtGLCg8gOGKQ2vwnkwbrGN2NANOMos24CInJQgSNNcKYHvkTao3ccqk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795029121; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ItEIAqfkh9HYjyYLYFlHdsVmiv2JFV6DaAPAUqusY5E=; 
	b=SgvkozKZMm+eC8E7ZpbY1jl+DgRg1zV1PC9TvY/pe2RTAzGRnYkiViYXSyY+EYBvC9RWrGDYNdxNXbfap2awXCl9iN3PuSvUH63HW7mvcFT4izNqr8BymTA0mfC4HmXzOABcANtHeBwZ74Pn+Q12a5yUKnjLta8Vs9S06gSZL8A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256; b=CHZhBR/nRwVGvB1bfY3yg+ACd+YE2U6+4nmCDwab8WHPj96FJoWDV4E3sUxOOTd2TbqWhzEVljBHkJVZEXY9l6BQNBFZSybslFRSBhTuCCXhF4PHiY3cN0pD+xwwIfctvrj+4WZ5f/Qau/rzIXzESI9av3/cRYNGKhskUdXY9eY=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=ItEIAqfkh9HYjyYLYFlHdsVmiv2JFV6DaAPAUqusY5E=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795029119789199.42815469236405;
	Wed, 18 Nov 2026 11:11:59 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
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
In-Reply-To: <20261117202055.GA3115493@ziepe.ca>
Date: Wed, 18 Nov 2026 16:11:40 -0300
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
Message-Id: <615C3DA2-4C02-4A8B-AEC4-70D498672559@collabora.com>
References: <20261112-b4-iommu-domain-v1-0-c29e86788dda@collabora.com>
 <20261116193821.GC2452510@ziepe.ca>
 <3EB4C2ED-B699-4532-A562-68B78F6E29C6@collabora.com>
 <20261117202055.GA3115493@ziepe.ca>
To: Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-ZohoMailClient: External


> On 17 Nov 2026, at 17:20, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>=20
> On Tue, Nov 17, 2026 at 05:09:11PM -0300, Daniel Almeida wrote:
>> Hi Jason,
>>=20
>>> On 16 Nov 2026, at 16:38, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>>=20
>>> On Thu, Nov 12, 2026 at 02:00:07PM -0300, Daniel Almeida wrote:
>>>> This series adds a Rust abstraction for IOMMU paging domains. A =
driver
>>>> can allocate a domain, attach it to its device, map pages into it, =
and
>>>> install a handler for its faults.
>>>>=20
>>>> This will be used by the upcoming rkvenc driver that my colleagues
>>>> Detlev Casanova, Nicolas Dufresne and I are working on. More =
details on
>>>> this driver can be found by watching Nicolas Dufresne's talk at LPC =
2026
>>>> [0].
>>>>=20
>>>> As part of the security model, each client will have its own IOMMU
>>>> domain. This is needed as the submission model will let userspace =
set
>>>> most of the encoder's registers directly, so the kernel cannot =
check
>>>> every memory access that a job makes the encoder do. With a single
>>>> domain, one client could make the encoder read or write the memory =
of
>>>> another client.
>>>=20
>>> How do you plan to get the paging domain in the first place?
>>=20
>> We plan to alloc a paging domain when a video encoder session is =
created. Then
>> we call iommu_attach_device() before a job runs, and detach back to =
the default
>> domain after it finishes so the next job can attach its own session's =
domain.
>> This is so each session is isolated from each other.
>=20
> If you do that you can't use the DMA API at all in your driver as you
> have to set 'driver_managed =3D true'. Is it OK? If it is why not just
> use VFIO?

No, not OK :/ We want to use GEM shmem, which calls into the DMA API =
internally
through drm_gem_shmem_get_pages_sgt() -> dma_map_sgtable().

>=20
> Or are you planning DT horrors to get yourself a DT created "DMA
> struct" ?

I wasn't even aware such hacks existed. In any case, I am not proposing =
more
hacks, no.

>=20
>>> Using paging domains directly is very complicated, I'm not excite d =
to
>>> see DRM trying to do this at all. IMHO there are many unanswered
>>> questions how it could even do this safely.
>>=20
>> In a very simplified way, this is not unlike how GPU drivers =
currently work. In
>> fact, from a cursory look, this seems to be how rocket (the NPU =
driver) works
>> too. Since we are merely porting the same ideas to video codec =
hardware, I am a bit
>> surprised by your discontentment.
>=20
> In my experiance any place I see DRM touching the iommu it is
> immediately suspect. We keep uncovering horrors that people buried in
> there. Yes, you can point to some DRM places doing something like
> this, with a convoluted struct device scheme and DT hacks to make it
> functional, no you should not copy it and certainly not entomb it in
> rust. :(

Sounds reasonable.

>=20
>> In any case, we need this isolation due to the submission model used.
>> Most Vulkan drivers know their hardware pretty well, so a level of =
abstraction
>> on top of it like V4L2 is unnecessary. Therefore, in order to achieve =
a leaner
>> kernel driver, userspace programs most of the encoder's registers =
directly, so
>> the kernel cannot validate every address a job makes the encoder =
access.
>=20
> Sure, but you haven't explained what the iommu gets attached to (ie
> where does the SID come from), how cache flushing works, who programs
> the mappings, who is managing page pinning, etc.

The SID comes from the platform_device backing the encoder, as far as I =
am
aware. Pinning is handled by the GEM shmem layer.

The CPU mappings are write-combined, so the only cache maintenance is =
the clean
of newly allocated pages, which dma_map_sgtable() does in
drm_gem_shmem_get_pages_sgt(). The mappings themselves are chosen by the =
kernel
driver. We don't care about what the actual IOVA is. All we care about =
is that a
given GEM object is mapped to a given domain, and that we have some IOVA
representing the start of the allocation, such that we can pass that to =
the
device.

>=20
> Are you sure you shouldn't be using iommufd for this, tied into your
> driver? It was intended for exactly this use case, to allow drivers to
> delegate their translation to userspace. Though that doesn't relly
> solve the questions about what it is even being attached to..

I had a cursory look at iommufd, but it seems like:

a) it requires IOMMU_CAP_CACHE_COHERENCY, which is not offered by the =
rk_iommu
backing the RK3588 SoC we are currently targeting. In fact, IIUC, this =
does not
seem to be possible, since the encoder is not cache coherent with the =
CPU?
I.e., does iommufd expect hardware cache coherency/snooping?

b) there is no way to do what I said above about GEM, i.e.: there is no
connection between iommufd and GEM.

>=20
>> The fault handler is used in the same way it is used in GPU drivers: =
to kill
>> sessions if they fault. This way the driver can simply refuse further =
work from
>> a misbehaving client, for example. It is also the natural place to =
enqueue a
>> reset if the codec hardware is frozen as a result of the fault.
>=20
> IIRC no GPU driver does that, they hook the obsolete fault handler not
> supported in new iommu drivers not the new PRI based one... IDK we
> have even wired this up to work this way.
>=20
> It is nicer if the HW can tell you it faulted rather than expect the
> iommu to do it.

See my reply in another part of this thread about how handlers work in =
Mali,
just as a comparison point.

>=20
> Jason

You seem to be saying that what I'm proposing here has a few pitfalls =
that have
come up over the years. Perhaps we can massage iommufd to make our use =
case
work? I can volunteer to do whatever work is needed, of course.

Same caveat as before: feel free to correct me at any point above, as I =
have no
previous experience with the iommu internals.

=E2=80=94 Daniel



