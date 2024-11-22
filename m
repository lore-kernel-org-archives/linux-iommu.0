Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB1517DE15
	for <iommu@lists.linux.dev>; Fri, 22 Nov 2024 20:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732307677; cv=none; b=BcLNZpwBv6QQHu2V7dmGmdXSLvR/1vl0Cbp5DW33GXO/z0aKkSx3ituVscq/w2Gr/uG2z6ifFMGF8CFPIJYAptz366fUxhQKRsUj5hZgZBR6HncP7kq6uhJy5gLdH5eAwGXa1/CEEIunDyRbFhCaDjyuKTxQS/Qh+qWWC2ht65Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732307677; c=relaxed/simple;
	bh=tyVliHYoWPxTSuVUMXN5P0bi34BX74mjEspyucHncgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VLrm9mrzomkmL/gNsEK+UwmnQVkh4qM/1vi+17GdlXN7xuXpK35dJWi6ByjLC+mWWh7OMS1Lw46wCUe/qNzUHmyvXoxZlEIawbDv7cevNREwswXHKUuT+gN2w+t7MweVsk73wAhmXxuzlrgTun32abzbGu+80Oxt0l7xZF2hJRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAx4akCp; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAx4akCp"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53dd8b7796dso860744e87.1
        for <iommu@lists.linux.dev>; Fri, 22 Nov 2024 12:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732307674; x=1732912474; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27/W48BXXkoR+L+LgIt1Vcffca5rx+DKUvYdFX1hBCs=;
        b=ZAx4akCphF9NUXiapmtrdH/lSVcfpcv/Moe4fGxx5D3VI+3BsBZzvQQV51GObmsoyQ
         f30ecaxI3R1EwXUDMPRp9yaU2elVTJhv/Z9rV4fc7M+qrgBjABFCXVeVKPl1B81s1rqB
         75cOtNYX/ktmxwD3RinJN4VQqMO3KNgJ9n92csbySJdW6ulmO7MxXki6yUghEF4dX1Ka
         GNhIOv8g/B/Gvtflyy74wttDkT9/+YIwnh74BQjpsOHjsW2Qi757PakV8pwC1j0jSg0w
         7u/McCKJ9jpK73PH2XOiz0KQKNCaGsc234EfumHfLGmfpdEjIvXJ0blg7WkGSIdXVG6M
         mHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732307674; x=1732912474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27/W48BXXkoR+L+LgIt1Vcffca5rx+DKUvYdFX1hBCs=;
        b=Klzdp7wqk/3eWZtjKzirMM7/NmK2CPXeI155yMoWouLTI4uYQTX3uBIQNaJ2m20QZD
         btFhBpAOSPKnIUd3+bRX6iB0CwylChu1mCqC57UWlmTDMeT6osIhAisBJ4IszfwrSygU
         +O+bsIC9el4jWdH21ppU6tehEo4zhSSUJLsFacsEQdmcLjIMrGndcFsTGc2Y6Bx8NjYI
         mpdMq0NCoUa05U02LYJQ49ULgizt+PcwHnroZ0x+Vl6vb1bqc58cjdYZoovDEfsFUI3G
         U7zchdQCXqEa0VXKhDN9d/OZDExx6cXBRjau0eTmb5Iki3d5Y6HLzgGv8AeJeeDsfvKT
         mMjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrfHYSs/mMsZzgHwH55NNFIr7AVj83vTJS8eE9/EDVgl0zLccZafdKuiWumCaR8Dvkee/hDw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxdq/AS5pO4Wiu/csMsRm6+FStZe1+yc3Q34jon6ZlbWZO7OBsC
	geCpVAQJs23hDtdnCqm3pZGFJnjqDmtt1qeJBVmnNuYyXoAu+L7eBrWmncMHZRMvn/OubNO4F9u
	QbOa288oIMyaZdII32mSrErCS16c=
X-Gm-Gg: ASbGncsP9ispxVGeIOKsCNdkf+S9/SXB1u10ZhGGcIpie8N4Uo6H42OLCPf5ijoAmM1
	BY+qu4gUa6Sl52RCnfqWju1tUV0rBsHLr
X-Google-Smtp-Source: AGHT+IHgCi72nGTNGWZ1pUQriMQ3jhYTMfVH+ysIEbPbyi+hsGaA6LLZnk0LjVwQWBBdL43JWP5pFRZBbtpZN0Kb1R0=
X-Received: by 2002:a05:6512:e85:b0:53d:d605:f8cb with SMTP id
 2adb3069b0e04-53dd605f911mr2471603e87.45.1732307673713; Fri, 22 Nov 2024
 12:34:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241122191304.4182642-1-bjohannesmeyer@gmail.com> <20241122191304.4182642-2-bjohannesmeyer@gmail.com>
In-Reply-To: <20241122191304.4182642-2-bjohannesmeyer@gmail.com>
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Date: Fri, 22 Nov 2024 13:34:20 -0700
Message-ID: <CAOZ5it34Gk_MU-gYzL5iuiHCx6fohQFSJFDp2AKj7waUCNzLyA@mail.gmail.com>
Subject: Re: [RFC 1/1] swiotlb: Replace BUG_ON() with graceful error handling
To: Tianyu Lan <Tianyu.Lan@microsoft.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Raphael Isemann <teemperor@gmail.com>, Cristiano Giuffrida <giuffrida@cs.vu.nl>, Herbert Bos <h.j.bos@vu.nl>, 
	Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 12:13=E2=80=AFPM Brian Johannesmeyer
<bjohannesmeyer@gmail.com> wrote:
>
> Replace the BUG_ON() assertion in swiotlb_release_slots() with a
> conditional check and return. This change prevents a corrupted tlb_addr
> from causing a kernel panic.
>
> Co-developed-by: Raphael Isemann <teemperor@gmail.com>
> Signed-off-by: Raphael Isemann <teemperor@gmail.com>
> Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
> ---
>  kernel/dma/swiotlb.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index aa0a4a220719..54b4f9665772 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -834,7 +834,11 @@ static void swiotlb_release_slots(struct device *dev=
, phys_addr_t tlb_addr)
>          * While returning the entries to the free list, we merge the ent=
ries
>          * with slots below and above the pool being returned.
>          */
> -       BUG_ON(aindex >=3D mem->nareas);
> +       if (unlikely(aindex >=3D mem->nareas)) {
> +               dev_err(dev, "%s: invalid area index (%d >=3D %d)\n", __f=
unc__,
> +                       aindex, mem->nareas);
> +               return;
> +       }
>
>         spin_lock_irqsave(&area->lock, flags);
>         if (index + nslots < ALIGN(index + 1, IO_TLB_SEGSIZE))
> --
> 2.34.1
>

Whoops -- didn't send to the hardening mailing list. Adding it now.

-Brian
