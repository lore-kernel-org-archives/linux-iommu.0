Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F4A43166
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 13:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741181000; cv=none; b=Ai9iLKL8xGqUC/WB478GHkkzQNoSCm9aQWFXMixmSfKU1OPYXaV+na9X2Wo77/VCtPd2SytopguABGzWKY/581NHMcqGDq9sR2MYzyNlK23efSXion96owp/HMum20l0Xf1fxY+Jj/XHRNjsn1ZaaHYzSkSgG98zM5KrQNmTRFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741181000; c=relaxed/simple;
	bh=CvZzmTRq9RSRFIPDPsLJH64TxFi7393kD1wwL8DuRwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mkJ4PBZMZfImxyGEKSqE/GvaXtydCdpRCoFRO18d8JJfAVrZcmJf/thmOBt7MMLoAnybT8hVC12gkb+LVKvOydhiFiajqFZWwNzjrLiX0zUsIPMB7gGUv9GUdtF2MZAibp8pdgiJFCjHK2RrRmwk9im2VT4ch9P/DmGIeMBEzfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BtCwzd+M; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BtCwzd+M"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390e702d481so3201484f8f.1
        for <iommu@lists.linux.dev>; Wed, 05 Mar 2025 05:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741180996; x=1741785796; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvZzmTRq9RSRFIPDPsLJH64TxFi7393kD1wwL8DuRwo=;
        b=BtCwzd+MXigIr7MnlAmG2wDZkeiEezi4CDDNdgGoG28f0pbzYB4JtTd020Ve6umLd5
         vtua49GTZuH/b0UjyUVmIGyh+c7iHwSXSFdIuR9aoKxfI2/eEAwa12Ohfsv/EK60AzUz
         hALA9oDVgKis5ePavlhaUrlZ19XfTAscK61bBFATE4m3t+DZqU1s2N8hMsQaJenOjsr1
         hsiPA1kNlkmNhQcfuuG9Rgw9VMIKQRsBu8cXw+IxcGW63oqbf0d28z8Noxhu+c+A2H2R
         z/dKUCzx66rcJUvNnbb5ZHXm9N3f+y/MgaAVR7SqIBKwpoofg3XJ+OxdTN5t4OCjVnbE
         4UIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741180996; x=1741785796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvZzmTRq9RSRFIPDPsLJH64TxFi7393kD1wwL8DuRwo=;
        b=VJligarsbzvWwEpoBHR3/rfp7DH8gYti2B9UTrmEtaiTOLy7pyaG9f6DryVrGeJB4m
         dvyPg34phv2UT91YaSK4nHEHTswCa8UEjIM4FiXJ0M3lyJvRdX1GZCwCY04LYdP6NGz+
         meL8m5Egfj3zLhrHjddf2KpSU4yStWLYX/aQj7pqajGHUkd6aCgMFNXthhpqawxURM82
         3JgD1ng4whEfgx+1q7O4yuzkRKFKztRvB+hbJtw5GSdGn3WwjpeD6lgK9hS/vMA87k4Y
         gGy77vUsIPXnaot5nl8jT0XeiMzhOT2KPuGUhfd+xqIbYgytYKiib/Kfz6Y9WaXs1EPB
         4WPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7r+GRSokRVpb6HSakI0K+K8TUi2UagvBeMPmL8w3HUJ7bU0q6xXRRExtm1GH5sQt0XvoUBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkDzwNbq3xMS5PFUHuqGrB7mqdhqBwvORpGt/XeKh/NdjIAj6j
	WPqevJoQSjx3HNGUUNyMG37PSG0LGOWzh6pclG5XJnc9A7IF0TUrXQv7L3QkH4SZRfKMNmfUSxX
	s2TCqDRHEkIDoE0TXpryk8np4iS0gLOw/OEnc
X-Gm-Gg: ASbGncsAYmZzEOR0OrKbZvjGNQbb2rq0tvtOr1tMTyUaqUgcVX8nQDAf18mijnJp8Cw
	C0QaFLdDWrwkLcSTEgD82VFNIz0QMEySsIXIXsSzK/ZWINCiRESWHqCFC/t3EsjtV+q4JDJESp3
	zSCrKRqYrz8sT6lRttZOBP27rZzXWkqyIl/vz1jS2LwwJSB8OnQZ7o6rkz
X-Google-Smtp-Source: AGHT+IHNWciLgVoVnZAv4nk3kTX/+E/9b5Uc3nIkyNC1isb3S8SjpNtHEANv2m/DUCvVIsnA3lEcug7w6dxzD9bnRJU=
X-Received: by 2002:a5d:6487:0:b0:38f:3b9b:6f91 with SMTP id
 ffacd0b85a97d-3911f74009fmr2224287f8f.12.1741180995002; Wed, 05 Mar 2025
 05:23:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <87bjuil15w.fsf@kernel.org> <t4HxdvR7WBX_861hiTXo72jqC9F9oRpIzgA_dD2yhcSuLISEkC-shMfSgllrFPpnkSZXGfRcc47keudMooNiIQ==@protonmail.internalid>
 <CAH5fLgg5MuUu=TX8mMsPf5RcLhMLHSU4Vct=h8rFX6Z7HjPxeA@mail.gmail.com>
 <87ikoqjg1n.fsf@kernel.org> <KpWTCfIlcLYFBpSvWPfALJ9VQn5a99_RAvxgMBc1aCrSalPB-qaW9IhXyaDG7HM1AcFPX5chj_Yr7IQp3F7UqA==@protonmail.internalid>
 <CAH5fLgh6ubawHh76wq7JPbcuBCWhm91m7Rc01MVsX-a3C6qaVA@mail.gmail.com>
 <87mse2hrd8.fsf@kernel.org> <Z8YMTiKS4T9wC4t_@boqun-archlinux>
 <ae8ac31f-c6ad-46ae-80dd-10ec081a16d1@ralfj.de> <88456D33-C5CA-4F4F-990E-8C5F2AF7EAF9@gmail.com>
 <hkhgihg4fjkg7zleqnumuj65dfvmxa5rzawkiafrf4kn5ss6nw@o7kc6xe2bmuj> <25e7e425-ae72-4370-ae95-958882a07df9@ralfj.de>
In-Reply-To: <25e7e425-ae72-4370-ae95-958882a07df9@ralfj.de>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 5 Mar 2025 14:23:02 +0100
X-Gm-Features: AQ5f1JovG7pJEGKCcNI-5Crs7Wa6SH_Z8cSAq-fFPkgCJUsVI7n8yYOx2AOVgT0
Message-ID: <CAH5fLgidPHQzdUORNpNhtRFsKPU1T-0xdn5OSwYYZh3BgOVRQA@mail.gmail.com>
Subject: Re: Allow data races on some read/write operations
To: Ralf Jung <post@ralfj.de>
Cc: Boqun Feng <boqun.feng@gmail.com>, comex <comexk@gmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Benno Lossin <benno.lossin@proton.me>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, dakr@kernel.org, 
	robin.murphy@arm.com, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	iommu@lists.linux.dev, lkmm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 2:10=E2=80=AFPM Ralf Jung <post@ralfj.de> wrote:
>
> Hi,
>
> On 05.03.25 04:24, Boqun Feng wrote:
> > On Tue, Mar 04, 2025 at 12:18:28PM -0800, comex wrote:
> >>
> >>> On Mar 4, 2025, at 11:03=E2=80=AFAM, Ralf Jung <post@ralfj.de> wrote:
> >> However, these optimizations should rarely trigger misbehavior in
> >> practice, so I wouldn=E2=80=99t be surprised if Linux had some code th=
at
> >> expected memcpy to act volatile=E2=80=A6
> >>
> >
> > Also in this particular case we are discussing [1], it's a memcpy (from
> > or to) a DMA buffer, which means the device can also read or write the
> > memory, therefore the content of the memory may be altered outside the
> > program (the kernel), so we cannot use copy_nonoverlapping() I believe.
> >
> > [1]: https://lore.kernel.org/rust-for-linux/87bjuil15w.fsf@kernel.org/
>
> Is there actually a potential for races (with reads by hardware, not othe=
r
> threads) on the memcpy'd memory? Or is this the pattern where you copy so=
me data
> somewhere and then set a flag in an MMIO register to indicate that the da=
ta is
> ready and the device can start reading it? In the latter case, the actual=
 data
> copy does not race with anything, so it can be a regular non-atomic non-v=
olatile
> memcpy. The flag write *should* be a release write, and release volatile =
writes
> do not exist, so that is a problem, but it's a separate problem from vola=
tile
> memcpy. One can use a release fence followed by a relaxed write instead.
> Volatile writes do not currently act like relaxed writes, but you need th=
at
> anyway for WRITE_ONCE to make sense so it seems fine to rely on that here=
 as well.
>
> Rust should have atomic volatile accesses, and various ideas have been pr=
oposed
> over the years, but sadly nobody has shown up to try and push this throug=
h.
>
> If the memcpy itself can indeed race, you need an atomic volatile memcpy =
--
> which neither C nor Rust have, though there are proposals for atomic memc=
py (and
> arguably, there should be a way to interact with a device using non-volat=
ile
> atomics... but anyway in the LKMM, atomics are modeled with volatile, so =
things
> are even more entangled than usual ;).

For some kinds of hardware, we might not want to trust the hardware.
I.e., there is no race under normal operation, but the hardware could
have a bug or be malicious and we might not want that to result in UB.
This is pretty similar to syscalls that take a pointer into userspace
memory and read it - userspace shouldn't modify that memory during the
syscall, but it can and if it does, that should be well-defined.
(Though in the case of userspace, the copy happens in asm since it
also needs to deal with virtual memory and so on.)

Another thing is that it can be pretty inconvenient if writing to the
DMA memory has to take &mut self. We might need to write to disjoint
regions in parallel, but ownership-wise it behaves like a big Vec<u8>.
Being able to have a &self method for writing is just a lot more
convenient API-wise.

Alice
