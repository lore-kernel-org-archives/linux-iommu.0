Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1B2248F73;
	Sat, 16 May 2026 03:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778901642; cv=none; b=plk2NvhZ0YzdcuHK+FsJqO9ymsX1GCrxKZpIUqs1b6i6wiPL6gt7/VqVLHfSzjzP6WgnD/dKzsC3grpD5yIEYz7mMzceeDfeFXFEGTua04HVxR6N8lscJm2mN7C//9JQre2CJm7h8qf9zJjTN4YJmzTRfgNxj74rtOyYYa2/odE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778901642; c=relaxed/simple;
	bh=d9gHZC/7030Jz3Q2AezS8Fm3v0vfnP0Fw7dyfPCxHOM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EgEATylj9js2nVgM1bgrs4k8nTYX+KwSPjdqWSiGprfdgrs/JMnFY0SYryIg/HdAkznUiBLCLmt9F6JJRJEshPYf8o+PQi1AmnzdgucwE7Yrf3QUDnU+X7QMmuchnIr6/rDd7s5mIjv+OK1eWe8nTNZbmHwOo8HnGDYzWN2FSeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=m+ufTgVV; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="m+ufTgVV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=d9gHZC/7030Jz3Q2AezS8Fm3v0vfnP0Fw7dyfPCxHOM=; b=m+ufTgVVNfC9MwQXpgRHTxv7Qw
	9gboQ7UkPET0erhE5QrKNXslkCSzC0dcPQ+TSHDBr0pTH26ZXn7nIfXwusmfJ7EOnCD5fWZkzDULt
	P5yKIDB47ZQqQMTYY+dKUnHLuenypp3u+/Jl27XT7AbmChzucHOnVc+JcJtGcqCSjdWBCGUme1xT2
	Wde25bVj+zMJPtklOp/QDfp1uOTUGKPKKqNXF/Q7LlDByArsiR0a+7anyLKFfcwBXUpWgJL/VJJTS
	RZE1GyHFS0W5VamXNOAg4Mom7fvwEJSQkEwqJzl0oXgyEFcjsKAd0wNRj1t3fcjVTSp8NLuIUYkzo
	f+qPsUPA==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wO5Zh-000000006ho-0DNO;
	Fri, 15 May 2026 23:20:25 -0400
Message-ID: <87439b0b88bfa4d4771052090e107d38ae5f0eee.camel@surriel.com>
Subject: Re: [PATCH 5/5] iova: add KUnit test suite
From: Rik van Riel <riel@surriel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	will@kernel.org, iommu@lists.linux.dev, kyle@mcmartin.ca,
 kernel-team@meta.com,  Rik van Riel	 <riel@meta.com>
Date: Fri, 15 May 2026 23:20:24 -0400
In-Reply-To: <20260515224317.GM7702@ziepe.ca>
References: <20260513020304.1528751-1-riel@surriel.com>
	 <20260513020304.1528751-6-riel@surriel.com>
	 <20260515224317.GM7702@ziepe.ca>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Fri, 2026-05-15 at 19:43 -0300, Jason Gunthorpe wrote:
> On Tue, May 12, 2026 at 10:00:22PM -0400, Rik van Riel wrote:
> > From: Rik van Riel <riel@meta.com>
> >=20
> > Add a kunit suite for the augmented-rbtree IOVA allocator, plus an
> > iova_domain_verify_invariants() helper (compiled only when the test
> > config is enabled) that walks the tree and confirms every node's
> > gap_to_prev, clamped_gap32, __subtree_max_gap, and
> > __subtree_max_gap32
> > match what recomputation from scratch yields.
> >=20
> > Test cases:
> > =C2=A0 - test_init_destroy: domain lifecycle, no leaks.
> > =C2=A0 - test_basic_alloc_free: single alloc/free roundtrip, top-down
> > reuse.
> > =C2=A0 - test_size_aligned: alignment of size_aligned allocs across
> > orders 0..7.
> > =C2=A0 - test_top_down_preference: sequential allocs decrease in pfn_lo=
.
> > =C2=A0 - test_limit_pfn_respected: 100 allocs all stay <=3D limit_pfn.
> > =C2=A0 - test_reserve_iova: allocs avoid the reserved range.
> > =C2=A0 - test_find_iova: lookup by pfn returns the right iova.
> > =C2=A0 - test_32bit_in_64bit_domain: 1000 64-bit allocs followed by a
> > 32-bit
> > =C2=A0=C2=A0=C2=A0 alloc must still find a slot below DMA_BIT_MASK(32) =
--
> > exercises
> > =C2=A0=C2=A0=C2=A0 the __subtree_max_gap32 augmentation.
> > =C2=A0 - test_two_phase_alignment: pack size-2 size_aligned allocs, fre=
e
> > =C2=A0=C2=A0=C2=A0 every other; subsequent size-2 alloc must succeed vi=
a the
> > phase-2
> > =C2=A0=C2=A0=C2=A0 fallback search since phase-1's S+A-1 threshold prun=
es the
> > size-2
> > =C2=A0=C2=A0=C2=A0 gaps.
> > =C2=A0 - test_pci_32bit_workaround_pattern: alternate 32-bit-first
> > allocation
> > =C2=A0=C2=A0=C2=A0 attempts with 64-bit fallback, mirroring dma-iommu.c=
.
> > =C2=A0 - test_stress_random: 2048 random alloc/free operations with
> > mixed
> > =C2=A0=C2=A0=C2=A0 sizes, alignments, and 32/64-bit limits, with period=
ic
> > invariant
> > =C2=A0=C2=A0=C2=A0 checks.
> >=20
> > Each test verifies the augmented invariants both during and after
> > the
> > test run so that any sequencing bug in insert / erase / rotate /
> > propagate is caught at the operation that introduced it.
> >=20
> > Tested by: building drivers/iommu/iova.o and drivers/iommu/iova-
> > kunit.o
> > (no warnings); runtime execution requires booting a kernel with
> > CONFIG_IOMMU_IOVA_KUNIT_TEST=3Dy under qemu-system-x86_64 (not
> > available
> > on this devvm).
> =C2=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^^^
>=20
> Heh, you should still read the patches when using claude :)
>=20
I saw it. Then I got distracted by something else,
and forgot to fix it :/

> Can you add a .kunitconfig please? The tests should run with a
> command like:

I'll address your comments, and also the issues
found by Sashiko. I'll try to get v2 ready within
a week or two.

--=20
All Rights Reversed.
