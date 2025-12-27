Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9711A08A3
	for <iommu@lists.linux.dev>; Sat, 27 Dec 2025 20:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766869172; cv=none; b=oaxsC9kbLyfX6Ly8wVo6ZDprlXqx8NwnZvueL11CZz4uWlM/SnOap4bRMdLhEqXVX7B41rcAdKlUChwdYHvlOxP24+HV11LcoVwVAxdtgl9bFqTzZIdnoK7UoyDCNdgSNQXhnDmMdvt7yqrFepF5C8bcsTjnxq52lAP9dRGmkjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766869172; c=relaxed/simple;
	bh=5BrI1QCayDLAzCBOu4RaXbRDKRpvhYKViuJ2VaNbDHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqEPRXu7UAbatDzQgIPpZno93GQXvHEnQo1WwXIzGslM7AugRSr9d9Mh9g7+Wsn+EOSseiMoCxvKPtcP9/29AE35xd9JlKURA0XGSJsT2xKejAXA9MRSyHyJupGkeS2lilYcawQLM8RkLzP8eZwrVoB0ylipktPLkj873JB90I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYC1xqI4; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYC1xqI4"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ee14ba3d9cso87971151cf.1
        for <iommu@lists.linux.dev>; Sat, 27 Dec 2025 12:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766869170; x=1767473970; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYfo4DcmoDPGkLlBpUwQdj2xZvXjZDeunEqpnCANZoQ=;
        b=LYC1xqI4v/TXxnIJP9JdNTeNpyjJ3ezRWhrzDg751BlPzRkiGdZYg0IxNVFiK500OY
         t7qjWOFsYpSW1CuI0ZHd9j4Tlh4SDjD6Zm2VqB8rl6GQ41tNkPKr3xADD2OxKFQZANHz
         +vTBCCJKoiwOWob+MddEyXYGYvmlEw97ulNYvYTLVrBXwY0dTkQw5hBrnKB8UZg87jfW
         RG5CUypq4ElMk1brvvpdkaQLxFv8bcQBbrm5sATY5woF8BH19k+Zu4AFcFtsMe8SBwgy
         9oxZlDG4hUd+QcrYc9V136UHzydz85FQ0mbXAd3C7iMca8/0GYuP2DsmIDIxBaMyQMVV
         QpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766869170; x=1767473970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LYfo4DcmoDPGkLlBpUwQdj2xZvXjZDeunEqpnCANZoQ=;
        b=skJ/WDb1k1jNZ6+6l3JTt60psELvcG7qD2X3kwqIT98wFT8Mbbx9SOrUkZRjpv06U9
         16fRW0j1ljItXinVwx59Mx1/0BxUuvGYyxZLAWsSYhPT8X9JaBQhZrbHobs/Ou6YHCBU
         T3qcwc9iZQnjUfsdeTIUdQLJDn6C7zr8yeQBSKBqBE2/TlwpnndacaNlurVXuSsNAW74
         b/Nj3EWl0eHZZSeSnEID1A3A8hNuRQrWoLPqjHfRo7Zj4wpylnN1TLTmgicUU4y8/uX6
         jK49vyWpyShTC1nkh4PT6ZhMjv7gOnuFG11Plzp+qRSMcLWScjmakgcsnxlbJDKHIs9G
         3Vbw==
X-Forwarded-Encrypted: i=1; AJvYcCVDDNG62TottNoZRCvnTIdXnMWWHwVsvyvBlHMBcLLqaLPc1PFGOT8hzWLWqFg/WaF0HSxKVA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZM4rpQcGChsymWf7h7I8RUXykYcrHnXwbaYDNqKxvf1D5TOVa
	FB3HpId0JJCftYc3xdVIJjDbAJkWyrfWgfrW8z411TOnRHp+forzB3pmNoF+1LOHC5V8CPRslxZ
	1MvIzNOmZ3JhT9zZYkrr1sr/UQlokszs=
X-Gm-Gg: AY/fxX7zR9vrD3MOJgxXP5UVJ5iF6pjdSgr+eXJSd2ErU9Sl2NFDWurEsO3cu7RF5Bi
	b8r1sK4bVvCSfscHSXxHgQRmO2c/5jtZUKkKS96O28Eja8HZ1KdB+oWIbBFNXZtq4AHI9S5UhW+
	jy+Zia3AXEbBadZKiFc2KWbyDasp4X1mVOB1PfRhdLtQfJKfto3ZWjqseqal/GkEEikr1paFyEB
	agZNWSu+yxRxJrFjHjgv7dozr300t/Y/raJXA42G7tRPoHk4zUTjrj3zt7PN2MtWqvfig==
X-Google-Smtp-Source: AGHT+IHlaEEZSdrmBhcD5E1NDs69ZAi4VCsoBGkUPdmFJ+vi7IWuMZm/ebLyp+IkRb6IMCkz4IBpkkjebsgKR6Oxf8Q=
X-Received: by 2002:ac8:7583:0:b0:4f4:c0b3:f50d with SMTP id
 d75a77b69052e-4f4c1cc43famr221104131cf.2.1766869170002; Sat, 27 Dec 2025
 12:59:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251226225254.46197-1-21cnbao@gmail.com> <20251226225254.46197-9-21cnbao@gmail.com>
 <20251227201642.GQ11869@unreal>
In-Reply-To: <20251227201642.GQ11869@unreal>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 28 Dec 2025 09:59:18 +1300
X-Gm-Features: AQt7F2rxXlxLqJeMe-griN6e55GdsgQR49MF8zyADfJXBQnZzf4d6g65OQ5pwik
Message-ID: <CAGsJ_4xssfB7hNOWLDianQfx+9wC2e4qZKtRBUzEZ-v97Sa63Q@mail.gmail.com>
Subject: Re: [PATCH RFC v2 8/8] dma-iommu: Support DMA sync batch mode for
 iommu_dma_sync_sg_for_{cpu, device}
To: Leon Romanovsky <leon@kernel.org>
Cc: catalin.marinas@arm.com, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	will@kernel.org, iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Ada Couprie Diaz <ada.coupriediaz@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Suren Baghdasaryan <surenb@google.com>, Joerg Roedel <joro@8bytes.org>, 
	Tangquan Zheng <zhengtangquan@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 28, 2025 at 9:16=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Sat, Dec 27, 2025 at 11:52:48AM +1300, Barry Song wrote:
> > From: Barry Song <baohua@kernel.org>
> >
> > Apply batched DMA synchronization to iommu_dma_sync_sg_for_cpu() and
> > iommu_dma_sync_sg_for_device(). For all buffers in an SG list, only
> > a single flush operation is needed.
> >
> > I do not have the hardware to test this, so the patch is marked as
> > RFC. I would greatly appreciate any testing feedback.
> >
> > Cc: Leon Romanovsky <leon@kernel.org>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Tangquan Zheng <zhengtangquan@oppo.com>
> > Signed-off-by: Barry Song <baohua@kernel.org>
> > ---
> >  drivers/iommu/dma-iommu.c | 15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index ffa940bdbbaf..b68dbfcb7846 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -1131,10 +1131,9 @@ void iommu_dma_sync_sg_for_cpu(struct device *de=
v, struct scatterlist *sgl,
> >                       iommu_dma_sync_single_for_cpu(dev, sg_dma_address=
(sg),
> >                                                     sg->length, dir);
> >       } else if (!dev_is_dma_coherent(dev)) {
> > -             for_each_sg(sgl, sg, nelems, i) {
> > +             for_each_sg(sgl, sg, nelems, i)
> >                       arch_sync_dma_for_cpu(sg_phys(sg), sg->length, di=
r);
> > -                     arch_sync_dma_flush();
> > -             }
> > +             arch_sync_dma_flush();
>
> This and previous patches should be squashed into the one which
> introduced arch_sync_dma_flush().

Hi Leon,

The series is structured to first introduce no functional change by
replacing all arch_sync_dma_for_* calls with arch_sync_dma_for_* plus
arch_sync_dma_flush(). Subsequent patches then add batching for
different scenarios as separate changes.

Another issue is that I was unable to find a board that both runs
mainline and exercises the IOMMU paths affected by these changes.
As a result, patches 7 and 8 are marked as RFC, while the other
patches have been tested on a real board running mainline + changes.

Thanks
Barry
