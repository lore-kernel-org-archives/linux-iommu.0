Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DA2329C5D
	for <iommu@lists.linux.dev>; Mon,  9 Feb 2026 20:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770667697; cv=pass; b=fz9I6lQx3GRzKAsmJaiQBhsjJ1HPLNQSvnnlFPGuILrkjYTbR4oBBDSsHjwkNtrVGBPFl/fIyoAyzv0XXGtq1gLsMUHEJQnt0cFpCHaCPPLRFFgvDuXiUz/xj8hT+KyTyIZ8h+17pgPtdAFV0zqMTOo4xVZORxrtfqoWj7qPu7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770667697; c=relaxed/simple;
	bh=87ivso5DI1kS8+gT+30C4NuY1qiQblQsyNrdFsbbIQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KvB9WvGBk8Z+j81++SYvAuRDihMCnnzWmeIodfZ86WgnXlptMyv/bVa7tItP2vLUk6epLIkFFYcqHZ38bhQnFThnwIWXwGudP+P01TRPJXgDdzM85C+OBJXXJh2stwPLAiUW+1GzSdBS/LWGicu5zSefTj42QqM1itqIocfwock=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=smYw9X9H; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="smYw9X9H"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8849dc12f6so12234966b.1
        for <iommu@lists.linux.dev>; Mon, 09 Feb 2026 12:08:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770667696; cv=none;
        d=google.com; s=arc-20240605;
        b=BEWRe/I6aVsKqC1rENo1piZytzrHUWIB6GRPJOQhRKEdwVqLoykd7FxtNVEYa++BHl
         FCxKy+8m1ECDmtTZIb9qtEVHRr6c5Qwboi7fbQJasmI1TLutDihkiGJGSehyaDpkZz/H
         2PUlnOoMG9bLNzK5NU33eFyBgkvR8TiGwStbAgOaJTpJT0nePN4+XS8JPl+I3jayXT8f
         OKHw8n5KQZ+YerVpK65D1bFoKIne14os3AbzvR3FZmmL2R0voSxlPWzK7h/jGERKtRKX
         vvRgGbs23OGxvDhHuAgYNwFWXIT152Sz+B1O36G+YxvqT1KP1Rd711TKUvlGL2z2lw5d
         ppVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/ogWTbSZ6gUFcHF4DB6Cif+r0lW3KkX6R4Nx10iOT0E=;
        fh=qRyxQrRNBkc86TnuayKeOCJbx8gunlK8TsR3q3dLBKo=;
        b=S5FouE19PARJrSUdjyYbW+ZJ1Dyff3EvWRiDeE4MRqH/yO85uxAsMWDw3CfOky5wY4
         SnBE676OirMFG5nPzIdEFcemWBACKwHWh2xQlJY8JFRoPEUgwHlWbE0tIDqjtVZkzx9T
         6QXKLNmHLnbjcgH4y1Q6QHGmoXa8dzOj0hVEl7UI4fnNScV4dO/NBjMhIoqszKfcDXGV
         99sr8GeY2aA+wae+xkID09tRgA01aoAVm/whXutDfYG6VwAtROBnjZMAchVPfqniwhaj
         WRuHU41dnfBex00tKMYqv3RrIvR3A3veCGgtIUxIzvWEUDMUvG88U7pNGq9ycUBica/w
         gh1A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770667696; x=1771272496; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ogWTbSZ6gUFcHF4DB6Cif+r0lW3KkX6R4Nx10iOT0E=;
        b=smYw9X9HlF60bZXLSL40XQ8ew+6buysHO15r/Wzi7c0Ql8BFYEvwm0tDXWZGLa2mk9
         8p2anVvrbTseKuv980ZyJPiPsw08Rggh9WrL8GCNYU336U0ZgkIBqPQPgpfA/0G3zP8+
         CywViyFT6dxkNE0doEKve0qRIAX8FSqv75IANv3FovyC7gwF6WtlHJMu/UPWbkmzKmmS
         GzI7cnTMUi4vzGF0B3W0IyX9mySfkDaURfVKTMjcua3iMpDMuYnbga9jdS5XyHkJaV2T
         YgdF6lD4+1xeAigfIME01X23KEvlIO1CeUSomNas3OxyxqGgC17xLVB9Mb5FEqafg0jB
         zcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770667696; x=1771272496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/ogWTbSZ6gUFcHF4DB6Cif+r0lW3KkX6R4Nx10iOT0E=;
        b=nFTd/obqphbRYqpiGAgvwik4Iln3al7jIJpGoUBnDyHyEyS/B1QFT6mFwosXnIM4P1
         VcZSqdk4x6QaxAckimm7tYkEQprhaWBlRjTpMCuP0hnhkn8wxN3VeaqOdbOZlbebK51M
         pMwT1IGcx0og7pFmuBPixH55CGb9jxNk01b73UTldlA5PxObGCAniOsI1ld91URGw3i5
         a82IW3jFZkLsiH+irWjSxls4FNtcYNSqMVMVFDRoBjUt9w4UrC8wEv4NfBqHLfhWqkyv
         H+Rm77OthcyeMbczmghoc6y/HKGP6/iK0fSgaitmMF2tED/1xVlaZ3F0zo1YYGZ/f8AD
         swCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYyGzWgY9hEDsPgMpChPxIy3FDIYLI15j5NXaZS+xrWeMbYNfxILQw7AAHp57lAl79V4AnOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtLTn79ZhWUpnJGni6rprQ1veME5tAPqsUwQyJJ4jWp7Df0HqR
	FwS1JqSXvDKHwCiOL6749wNZYZFHCCK+tMv0JNcCuCo2Bqd4qbfEXkd81LYT8eW6BCFC0B/Fq9M
	f3P19rqCsXEAMRkMVW27v4QNZ/dFYHZMt3torxbg=
X-Gm-Gg: AZuq6aL7AdzXu2U5O+kY/TcSByjZAOjy7tWEZ8+qcjbgteSYC5tGcBIV310FzPDw0TB
	KK4C7QgH+2rr4soyaMHWzUJ2E79QTi55d7Q/unZiD38Fa5MD67sI670phcgm496jzQKSWW7piYZ
	4+CQUf/JgpNtBl7lqNEALZVm3gv5kq3iqLiF3Wl84CWrSwZBCKktFDcCOQakZCiwkRUt6uIcrZv
	A574qCy+WfESN4Guh0Z87zPrDN04CboUh1S0Gnl0td3+NRlEdSMdohHYU9qe223UasxJu2S1/i2
	R3fRgJXAco/EvlfpwrI=
X-Received: by 2002:a17:907:6d0f:b0:b74:984c:a3de with SMTP id
 a640c23a62f3a-b8edf25a954mr696952366b.28.1770667695453; Mon, 09 Feb 2026
 12:08:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260209153809.250835-1-jiri@resnulli.us> <20260209153809.250835-5-jiri@resnulli.us>
In-Reply-To: <20260209153809.250835-5-jiri@resnulli.us>
From: John Stultz <jstultz@google.com>
Date: Mon, 9 Feb 2026 12:08:03 -0800
X-Gm-Features: AZwV_QgqaltPSA0q99dWV0j2auNF_GQoTvkX0OemEzMtzBNfhVP0pPFcsDiXkzY
Message-ID: <CANDhNCoHEZsNRmU+3z5AbeAy05H7PTtUdTq1apNd5k0f9hWW8A@mail.gmail.com>
Subject: Re: [PATCH 4/5] dma-buf: heaps: allow heap to specify valid heap flags
To: Jiri Pirko <jiri@resnulli.us>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	iommu@lists.linux.dev, linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, tjmercier@google.com, 
	christian.koenig@amd.com, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	jgg@ziepe.ca, leon@kernel.org, sean.anderson@linux.dev, ptesarik@suse.com, 
	catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com, 
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com, 
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 7:38=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote:
>
> From: Jiri Pirko <jiri@nvidia.com>
>
> Currently the flags, which are unused, are validated for all heaps.
> Since the follow-up patch introduces a flag valid for only one of the
> heaps, allow to specify the valid flags per-heap.

I'm not really in this space anymore, so take my feedback with a grain of s=
alt.

While the heap allocate flags argument is unused, it was intended to
be used for generic allocation flags that would apply to all or at
least a wide majority of heaps.

It was definitely not added to allow for per-heap or heap specific
flags (as this patch tries to utilize it). That was the mess we had
with ION driver that we were trying to avoid.

The intent of dma-buf heaps is to try to abstract all the different
device memory constraints so there only needs to be a [usage] ->
[heap] mapping, and otherwise userland can be generalized so that it
doesn't need to be re-written to work with different devices/memory
types.  Adding heap-specific allocation flags prevents that
generalization.

So instead of adding heap specific flags, the general advice has been
to add a separate heap name for the flag property.

Now, there has been many discussions around "protected buffers" (which
doesn't seem to map exactly to this confidental computing primitive,
but sounds like it might be related) , which have bounced between
being a allocation flag or a device specific heap without much
resolution. I appreciate in this patch seires you've pushed your
concept down into a DMA_ATTR_, as I do feel the kernel should have a
deeper sense of protected buffers (or any general propery like this)
as a concept if it is going to be a generic allocation flag, instead
of it being a somewhat thin creation of the outer heap-driver layer.

But, it seems like the use case here is still far too narrow for a top
level allocation flag.

So I'd advocate against introducing heap-specific flags like this.

thanks
-john
