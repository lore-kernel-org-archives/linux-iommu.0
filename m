Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDD23C6BA
	for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738000070; cv=none; b=kaLhFa748R/58ML7Z4yvJ48mKOfrImvclY4H6Yy6Ju6KEE1AsQDlTZto7GdgzR67JxoRntCqd3Kq3U3N1QQD/hjNQfLg6YemW/MxT9aUat2RaK+jNrgqsBsU1ACHiIAj6wnU0MFWhRCNyycvIAA1gWQwFTBmJBTTSRuCjcbAqbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738000070; c=relaxed/simple;
	bh=hPYmbEUCp7iIhh115VWVrSODZIGTULkBUYhG2VADp4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GtxM900NxvlVOvBwXdkZZYzr0vbfwncYF4ak24gb4vYhoJ2XF+Spy2vIAWE+gsDWriHTYCM3YlrNeH6LMHqmnYt/5rGRWOkQ982uVSrYg7XLwM23vho/bLac64e+cRxB2mf36rkcX/2chELVYrEu8Z+e9oImUU8G8wol5i6B4mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJAXlWY2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJAXlWY2"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21a0374a1fcso9214265ad.2
        for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 09:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738000068; x=1738604868; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPYmbEUCp7iIhh115VWVrSODZIGTULkBUYhG2VADp4k=;
        b=iJAXlWY2X4VZktqrn8GDUd3qO4f0+YPNUbYhjcfR6rOrcjCsLfdZYKPQvQjhwwnxHM
         KEd3DHYh4h78b6sxtv9oiyrxm31+X3Wozg7VL2YfjUJ3O2V4gJVD6LvUaFTNg6D6XcaW
         hqGQDcFTG3qkiNO3mGtMS028FGQeZuodqI8AWI0dKpYJVlhCcaChvcqGglE6VST7SVlf
         2ZF5R+JozMEtmVhM+gC135B/YxJWvRG3od/HPVxe5cX3mZw1Bkt6yIM/QWnvA+cjuj4D
         fYTAbfTrGDsmGe4OrPW3/MMp3Wx2jD2fhxvyR9MTMOcD9dMrWZzkaaO3HgC3pBFdZ/Vg
         AYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738000068; x=1738604868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPYmbEUCp7iIhh115VWVrSODZIGTULkBUYhG2VADp4k=;
        b=XKLlx366GG1Ec28WMO3KzQiUI8Dr/SksxviKAth2BvWCyNbHJva6ptRlUfFmFEO+k3
         hf59YCC9nv68aSub3xCaz+Oyr/jWQKGk08xbuKIvOZi7/CbF6CiBV0K8HGwiDaDIPWBx
         dbFgsSetQcMfRKpbef65WiMGna5LZqwhH42HPtninvLG/278khpVYKYSqusiM2KcdPak
         G1txDm+7jbpccnfLuYbXQmAqT2Ddo73bRzy9BmtfneTG+mh0MEvQ+QkCX6/Bja2Viurd
         kdvNtOqJtT+UHmvC49hyvBKblDA6dQ2voRY+BqdJt7W3jQENbgQZpRAhaO+wsZ3jZjoi
         4vSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWA4TeqHxxXssdUKgSYQS5OyFn+jE/vK5fRdwPYCveMjWfM0xNm3M8I5981hao5a4q+7p4X8w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgCmbbb+LN0LK4zj5sGJs39e/tn23HNjOoer9NRAy8IIAlOvGD
	wTd0/mHV38ThL6ejQnoZ/dWS5Vpc3ak+UAZhWUNgDIEIufZZR3ffMalXosrdlKhTSp6d6z/wIdo
	o9yIXcMwf72HuLwGC0kiHgueXGkY=
X-Gm-Gg: ASbGncvtIufLFxj/vWGnuChBPXUnLkLL+aiLXNN/zAIUDz9I8jpmrjOJNeReqpWIZLJ
	jPtf4NpGsJpt9xflufIz114l3U2dd+ZWZkdX64O4p9BsdGsvPkLD38CXXi8Jg5QB1UeAVKPtxIw
	mN9Vctkr6uj03oXmOHeA==
X-Google-Smtp-Source: AGHT+IHi7SkZWcG3QPpYFvorx3JGWtZ4d6yy3ERoWvh9SbpH52TbIPugBTipbABwOfJfwkvEjOCXaKOBhQG+/Yuf79c=
X-Received: by 2002:a17:902:f68c:b0:215:b8b6:d2c4 with SMTP id
 d9443c01a7336-21c35551599mr233228605ad.4.1738000068469; Mon, 27 Jan 2025
 09:47:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAEHp+Gasm2ZuYPusn1ZsMuePpjV0atutVGTr9n3-DT=tQODYkQ@mail.gmail.com>
 <50b71ac2-b84f-4f09-8795-d1c89a7c56af@arm.com>
In-Reply-To: <50b71ac2-b84f-4f09-8795-d1c89a7c56af@arm.com>
From: Dima Stepanov <dstepanov.src@gmail.com>
Date: Mon, 27 Jan 2025 18:47:37 +0100
X-Gm-Features: AWEUYZluomvG73DT3G_MgMRBxvP-P4gznzu_7OEpypuOz2NdPzNzw-3LFX4_lTA
Message-ID: <CAEHp+GZRNApNBxznU8YioJO7+ezosKtUmTqaQXe8J6r2QyGjcw@mail.gmail.com>
Subject: Re: [PATCH] kernel/dma: dma_common_find_pages returns pages for
 requested address
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 12:50=E2=80=AFPM Robin Murphy <robin.murphy@arm.com=
> wrote:
>
> No, that's a bug in the caller of dma_mmap_attrs(). As the kerneldoc
> says, cpu_addr/dma_addr/size must still represent the whole buffer as
> returned by the allocator - any offset for the mapping itself relative
> to the start of the buffer is expressed in vma->pgoff.
>
> Thanks,
> Robin.

I see, thanks for clarification Robin. I was confused, because depending
on the backend it will work or not work. But i believe that in this case it=
 is
undefined behavior. That is unfortunate to me, since the idea behind was:
- The memory allocated once because of device/firmware
- Different users could request a part of this memory from the kernel and
mmap it

And i didn't want to expose this offset information to the user. Wanted to
rely on the kernel to mmap the proper part of the buffer.

Thanks,
Dima.
