Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DFB3EB10C;
	Fri, 12 Jun 2026 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781285058; cv=none; b=lGkVHaq3jgloLIF3uwq+4AOGevC5FlXinSclQJgaGkjjykP3ahKP7LyuujZN9NYY31vWjHiI4wQDnyMjROHmLDomwxaNAhP+Xm80WBOktN7bHNlCcuMlFpqfxaPrDAaySG1Hnvrx/iDQYyUDSaPwF8KtWAod0eur1dvQVmTTBfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781285058; c=relaxed/simple;
	bh=88TFdHqpI8AuGLWZ/IXz2k7c5gcV8evd9fE3OvGjK0w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KlBEFQTL36DbHS9ABgMiA9kYDTO6SQgEVYvHXY6px0asVHJXel3eq6Htc0wrQ+J3EBkSLbtq6e2fAWVLAcM8uIznmnSWZu6PRD+WWcc4ruHR0ZNsL1bWRlUbLB3JezVCV/n3i2h0jMbPUpu52LvMiRFER9SlAJB+99SFIbMBVLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=ZU8b7V7H; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="ZU8b7V7H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=88TFdHqpI8AuGLWZ/IXz2k7c5gcV8evd9fE3OvGjK0w=; b=ZU8b7V7HElrGluX807mYHS/FJg
	Ist9UBczKKIr7SDcagHgRX2I6529oB5/C5d2eKsplFoNEyEysS2rNH/P5LL1E+567ndMKdwJL+sPh
	vYgejYLOuGlYIZcaOhdgMqp0mi9syM6lSB0E4yOjkUXGFBImSFyuNKsEEUdN4oA3ZwqFtAH6e3gIr
	MAHHIgVhbJZj8cSdbJAu5TeyNlwUlzL2SNltxzoG/BObt5M36VtCrXaRYeE1vw8diT550d8cIPV48
	fEARdPv8/hAK0K02tU8U/nMIrdmM0v85fP7aT8ZTOGe3zLL6HuK/2scM3PiRZcgQ0+++UzGGxLZzb
	TntrRBpA==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wY5bq-000000004zO-2KtF;
	Fri, 12 Jun 2026 13:23:58 -0400
Message-ID: <ff5f9e09edbcb9c87feac6af00a1d835c783be4f.camel@surriel.com>
Subject: Re: [PATCH v3 3/3] iova: defer maple tree erase on GFP_ATOMIC
 failure
From: Rik van Riel <riel@surriel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, "Liam R. Howlett" <liam@infradead.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
 robin.murphy@arm.com, 	joro@8bytes.org, will@kernel.org,
 iommu@lists.linux.dev, kyle@mcmartin.ca, Rik van Riel <riel@meta.com>
Date: Fri, 12 Jun 2026 13:23:58 -0400
In-Reply-To: <20260612164852.GL1066031@ziepe.ca>
References: <20260603033653.4144138-1-riel@surriel.com>
	 <20260603033653.4144138-4-riel@surriel.com>
	 <20260609130418.GI2764304@ziepe.ca>
	 <61d51d4b5779d80145ceb38e9632a7cc8a79dbec.camel@surriel.com>
	 <20260612164852.GL1066031@ziepe.ca>
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

On Fri, 2026-06-12 at 13:48 -0300, Jason Gunthorpe wrote:
> On Fri, Jun 12, 2026 at 12:02:55PM -0400, Rik van Riel wrote:
> >=20
> > The mas_erase() function calls mas_nomem(mas, GFP_KERNEL),
> > which is not safe to call while holding a spinlock.
>=20
> Oh, the kdoc doesn't say that, it doesn't return any error code if it
> can't allocate memory, and not a single caller checks for erase
> failures.
>=20
> I assumed internally it "somehow worked out" even though there are
> allocations in the callchains..
>=20
> This is probably a better question for Liam? Can mtree_erase actually
> fail ENOMEM? Is it safe to call it in an atomic context?

Yes, it can fail.

When it does, __free_iova and friends fall back to
asynchronously freeing the iova from a worker.

If we are ok with always asynchronously freeing
iovas, we might be able to simplify the code by
always going through that helper.

If there are cases where asynchronously freeing
the iova breaks the system, we cannot use the
maple tree, but need the augmented rbtree, instead.

I do still have a cleaned up version of the augmented
rbtree, if asynchronous freeing is a real concern.

--=20
All Rights Reversed.
