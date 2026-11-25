Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795614549;
	b=c2qYLphu36Hetz/gePRgi9++cIaeBVI22jfXJZA6EYY39FLvxx7weQlKS91yfWoBAz0g
	 8tMjidZCHS7bAgdJvZ6Uwa3pXqBskNSqXh9Gay4loMMsRyPCum+Xc6pawy9p+6FZuGXE0
	 u+h4G9dL7Ib7hFWi9ohoNCv0H99YVaDMYJhDNvo3pi0imin7TMuvnp+XFUZsQe7mb3hpe
	 O+z4dXgxKPoeTnts0zGW9zNkp3ayxnxNF+Ntsvosxd5DKJtauSTzY9Z0O0dxEmMi01Ciu
	 3CSaj9eF/UhgPZYbRBwyeN+T13ojo92/RjBQLM89Wa0hkyDAWIdXP4ZhRuTBKLmZ4vw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795614549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=tJvDq5tmnbN1V0lnC7fyUre118RuearxhzthUfCzjqI=;
	b=iu9MIZqJX9v7eFHWd9Ej0QNHrJ3AJKAKIkvJca+Dqq0j5+aHWenwDpg3+lu3fxeYr6Sw
	 98c3Tl/0ha5TX4UVZ7DKcwsq8YqZ4YXw4m4lfsh3Oz3b/QSvRWilOamVy09kn+45Bd8tM
	 9t/ueNm3U2J9FQZsv7A55P+x/S829dcvt906XBL1/RKHrIP+nAd5d9ad3Xr70LrckM7Wj
	 sU4Vc+5N0sUPgJGQK1joyDtLp/iQERfF5l5PLSYyzw5sHMfgQOG1PAuK8NUmjkkZrCmM9
	 p+bz1JckXg9cv5McTchrKn4qHXEVDv6L9DitKzB5zH/SqSKf+nXBeHfP56ZBzXMHO+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WiZ38Zij;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981B6606A321
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 13:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 981B6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WiZ38Zij
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-38692f62b22so6616376eec.0
        for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 05:49:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795614548; cv=none;
        d=google.com; s=arc-20260327;
        b=R/44YeTsvHNiOe1f1vfz5hpxwvGMSbKqwrlhai8wDmEosh7Ow54bg8NrNGyL9hQzsk
         fQtXxgNRT1zZgZGahoX6ac04Ejqa/52zWCM4xFxPMjrTTAD36dG9EAroep25iVPHZunS
         MoAryHCUIzNpdS6HSr/2kuVfgXAG5nOVJgzNUIGLoGC3ZFZTsh5RrTBDo1YOPlZyrs7W
         xfqC1bgfrDP55AeVlMuUbJ5LwcqOxfS62WfA1taQZzssFupOeEi5WTtHZyS4gNt1M07d
         /h1tmifRfsxkDXtWI2EUCfYAY5GAMU6l2MAyqaA2fD67dlTClCiG22jKOiF9IWHSz2oI
         iZ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tJvDq5tmnbN1V0lnC7fyUre118RuearxhzthUfCzjqI=;
        fh=STY0UwL4CfinZYcBYSb6efFSIGtJP0pSKb5NtthMHc8=;
        b=bBa1LJ3D1uSEiqEQVGLlVPzxSDSW7GE9Cn5wQG5+txk1Hz/tdKndsgh94Svmof8sGy
         JNJ8bXwXIRz5JvIShTdCr6lLD8OKHpng3518kuYWv84qfHKhO8q0/jJsXQLr/L9A+tqh
         A74np2t24Ho+af9U0bnyhcFAfl38c5a8Gr/I5jLBBgbURVP7a4YFl/yjSSY21ohUuwEu
         U3Vqh8+5k1d4qTnqWpAjppzcG/OWn/CbWojVZunHD+FPkIjv3eLjye70cKMPUBfnzWjY
         kOsKEcwizc98NJwyaD0VVUzCSkUvIjO9QT9mL5jYFTzZ/IKQq11T9sLMeLL7Oc92uN03
         dgBQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795614548; x=1796219348; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tJvDq5tmnbN1V0lnC7fyUre118RuearxhzthUfCzjqI=;
        b=WiZ38Zije4kAAywB0HRZxLh7veCN+EDIaRVJQy8UWNwQy50Sk8m3XGXPcnyRBArbiS
         pKqLk+eOQ+JyhHrdM94C6I4ovWoeX4fZfyLCFTd6sdw+VqhSkLBqBAJK79ewh68ihvqn
         jK91P64D0TG7mp1vIalpoWXbic49dLB08aarxfVwgKsjeTzBlA2Cr1K7Srn583WRUY5n
         wVXgqnaTDx2KKgt+3ZBiqwEVsoGCma7IUBfvRSQJRR8YledJ94U++YULknH9VwRjwpUu
         TG3s70cRVfK9WN6Dd5y6USe02kPtoH+vULSPkL8qstZINodHbz9qzFuyXUQ+KUL5z8ud
         q/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795614548; x=1796219348;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tJvDq5tmnbN1V0lnC7fyUre118RuearxhzthUfCzjqI=;
        b=Yd3dvkS1/+EFDXWVFMaYBs7LDtqO4zJ5PGXMAlY/gneirPT8BDJ8x7rAnvYSiAoZ8V
         T4izlKjwRShHiImxmfcPgtEA2yiTtSxahWgMmQ2j7HBZhcyYrRMA0dRtemO6jJFT2B1x
         hatVTdCKLEYvKU6Inu+x1/nMDPGFRdT686phmcufBIplOBOO9UPd57lvChxWayTHyD+k
         w2Sncun2GeNV34yi9EjPg0TCmLJSYTP0tTwCJGw+JwpE0gAmNNtkbZTFvr9TDpNceKt4
         +AzLabJkX5hvtUD0fbUq1CxDkcANH/VavkQC/PUwLu0G6tXdY0L3I2BJYXlsgPwIqb5n
         i4Ww==
X-Gm-Message-State: APuU4Z9rOVIHS9q5T68xsgX6KazZvTbmWDEV7idccshgKfCly0pDXJvT
	77/n97XGu+4rVCoYiT3zGozLuB6qcvTuII9cFENlEXImzedl5PAyNF0L5uEZC9WZe/41/Y4qz7b
	5bH/gd5uIno8sRSE6uJ3pxm9plfifzmY=
X-Gm-Gg: AZFdTZfBcDw0as7KJP3S7Je77uaY8FPilTC4rOhVmnZxx4FePxELkQDbqZT4fDEAGVu
	rtYWByJD7Xz6XMsldSnkZlb4yE6MFGaI7KOfy2FWu1+3+ovwQ8bA/AJKMAAisPUI/H2CvJc9LPj
	edPLKNfbWYcI/bnefKiG7K2NJAcjH08eBMmlFr7J8UpHP4vu054QGtQ6XL3boAQ7cioXF78FPt5
	FW3LIgpWAXACOEh4QajAyp+VbeBGKGjw4V7w6bmvMDwa1JtBdDYAVAGBWXyKWlMNvPDC/rsv2Kz
	HSh2zD975T3cPMKu38s654vNKn4YFLaMJBDiRw8CRle8zv0Sx+J82jnCipr6luPFIvmvcL/BDx4
	uCpnTh0YY4UIOnIVZXGYjm5Jta2mB6Y6VQUyUezX2LoBRfu4ih1/xz1tSXw==
X-Received: by 2002:a05:7300:c8cc:b0:386:6116:c389 with SMTP id
 5a478bee46e88-3866116c625mr14937713eec.15.1795614547537; Wed, 25 Nov 2026
 05:49:07 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <CAGvcwsDdKSZe0reeuT0eQabaSbM6+KAfwFimxiqhvKrjD2nQeg@mail.gmail.com>
 <awX_cNOqtTjAP33a@ryzen> <CAGvcwsDwi9vNcCLxdBz-Arx=5i-fFvqxP+QbRKrx7hK4yqmvRg@mail.gmail.com>
 <awa_ys0XSt9UwAZE@ryzen>
In-Reply-To: <awa_ys0XSt9UwAZE@ryzen>
From: Pe3k <pe3cek@gmail.com>
Date: Wed, 25 Nov 2026 14:48:53 +0100
X-Gm-Features: Aa3M54qXC8BBPvMGYvAl-y0oqEiJ2UAcVDa3IEBXuTekQnzPUbClOSDC6vixiKg
Message-ID: <CAGvcwsCvuedSN4Fs1TaFRTVc2QbcQK94P6+xqH3qmEvNqq3d9g@mail.gmail.com>
Subject: Re: iommu/vt-d: data corruption, AHCI gets IOVAs inside its RMRR (HP Gen8)
To: Niklas Cassel <cassel@kernel.org>
Cc: iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>, 
	David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Niklas,

Yes, 5.10 works.

I picked 5.10 because it is the last release before VT-d moved its DMA
API to dma-iommu (in 5.11). Until then the VT-d driver reserved the RMRRs
in each domain's IOVA space itself. Since then the IOVA allocator, which
is the part that hands AHCI addresses inside its RMRR, has been generic
code. So 5.10 was the obvious first candidate for a good kernel.

I tested the mainline 5.10 and 5.11 builds on the spare Gen8 with
intel_iommu=3Don, translated default domain, and the same load:

  5.10.0: clean. 0 of 6 copies bad, no DMAR errors, and an
          intel_iommu:map_sg trace filtered to the RMRR caught nothing.
  5.11.0: broken, same as 6.12. 23 x "DMA PTE for vPFN 0xf1f80..0xf1f94
          already set" (with the WARN in __domain_mapping), 2 of 6 copies
          bad with zeros and RMRR firmware data, and iommu:map shows
          iova=3D0xf1f80000 from iommu_dma_map_sg <=3D ata_qc_issue.

So it is a regression between 5.10 and 5.11. The likely commit is
c588072bba6b ("iommu/vt-d: Convert intel iommu driver to the iommu ops").
After it, the domain's reserved IOVAs seem to come only from the device
that sets up the domain (00:1f.0 here, which has no RMRR), so 00:1f.2's
RMRR is never reserved. I have not bisected inside 5.10..5.11, but I can
if it helps.

Thanks,
Peter

On Wed, Nov 25, 2026 at 12:00=E2=80=AFPM Niklas Cassel <cassel@kernel.org> =
wrote:
>
> On Wed, Nov 25, 2026 at 11:01:17AM +0100, Pe3k wrote:
> > bugzilla 221713 looks like the same bug. The ML10 v2 in comment 15 show=
s
> > "DMA PTE for vPFN 0xf1f81 already set (to f1f81003 ...)", which is insi=
de
> > the same HP RMRR (0xf1f7e000-0xf1f94fff) that I see on 6.12, and its 7.=
x
> > symptom is the same "Emask 0x40 (internal error)". Their bisect of the =
7.x
> > symptom points to d373449d8e97 ("iommu/vt-d: Use the generic iommu page
> > table"), but the RMRR overlap is there long before that (they saw the
> > PTE error back to 6.0, and I see it on 6.12). So my guess is that
> > d373449d8e97 only changed how the overlap shows up.
> >
> > The H97 thread looks different to me. There the faults are "non-zero
> > reserved fields in PTE" at 0xff4xxxxx, outside any RMRR, and they depen=
d
> > on the request size.
> >
> > sp_off: on this machine the only DRHD reports no superpage support
> > (cap c9008020660262, SLLPS =3D 0), so I would not expect it to change
> > anything. I tested it anyway:
> >
> > 7.3.4 with intel_iommu=3Don,sp_off: no change. It still has 0 DMAR erro=
rs
> > and 221 failed commands with "Emask 0x40 (internal error)" (121 READ
> > FPDMA QUEUED, 100 WRITE FPDMA QUEUED). 3 of 6 copies lost 8 MiB each
> > (zeros), and the iommu:map trace again shows 21 maps with
> > iova=3D0xf1f7e000 size=3D0 from iommu_dma_map_sg.
>
> You mentioned that 6.12.118, 7.3.4 and 7.4-rc4 is all bad.
> Is there any kernel version where you did not need iommu=3Dpt for a relia=
ble
> system without corruption?
>
> This seems like either an Intel IOMMU bug or a HP ProLiant MicroServer Ge=
n8
> specific bug to me. Hopefully someone more knowledgeable in those areas w=
ill
> chime in.
>
>
> Kind regards,
> Niklas



--
