Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B445A20
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 00:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722904803; cv=none; b=Arr0nZTNwjkGJDPGkDTNL+jjp+KAa3T7iCog8ZYAKDZ/50SrgxsV5kro8AtnxymVsJdUpboQVcuEtWa9PoHF149fiV1nTlFLiFpHpfhSnPybyPgXIzknXGxjILrzFE2iNMKQNPG1SzeaIglx0MStQuCxoKz2va+n9xjpj/ccL1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722904803; c=relaxed/simple;
	bh=fRR3DATEsRrbV2lk8KRxjtv1/FxWvxec6i6bzpLg/mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8we7MZh4JsAi8+62ub3JxhcouQXmEy1HkT4ZBKIFbYOQdb3eQzw2rBf2jUp/XUttWY5oj9+sjA4cWWNcDYNzCmWBuI2hpd99CLF6bihsXNCjBrvZYrx2e+UhRjp9aMjfYw93247WlT+B/I96kwgEJVa4JE7qx7V3qXYKxHBo+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPPzYSq3; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPPzYSq3"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-36868fcb919so108575f8f.2
        for <iommu@lists.linux.dev>; Mon, 05 Aug 2024 17:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722904800; x=1723509600; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRR3DATEsRrbV2lk8KRxjtv1/FxWvxec6i6bzpLg/mA=;
        b=lPPzYSq358j2LGtEpV2WvEIRg75RfEZZG3Fw81/Lo93e9e9bERP7uU2BavtvLvV1/S
         FOgM34ObrleiqpR1+96bs3SNWcTA5Hun7W/X60pMmLX8a9Vy53hRKgBVM07X4jN0NVHc
         F5ztyfqs/yE2yvBiOOW0T5m4HnQPvC5bIsC78DirU/yIZJCWCN58ISj8A5uDPF5gfP5R
         Z5AYsBbJds3jIaXmE2zMzWw1ZhZlkGViiA5Hr8nAxreNGvCf52ecSXzXH2P9p6RU58Jn
         ib7mKgygByBAtHTxr0scxRTrW5tZZsMmknY7uD1dijpsd/au31uTOhmpaAkJffAtcI9e
         IcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722904800; x=1723509600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRR3DATEsRrbV2lk8KRxjtv1/FxWvxec6i6bzpLg/mA=;
        b=nOxyHnW9l5UxrnjVGLEfd792meRu73HkGjBICNBLQk+G16f5n9t4h9UdKLhx8vDWUr
         rVREIAaOzGa7RcIEmNhKmBVV5ytI03j8zJCGlA0kdZD5efxgPjrUOsRzpGzgYGbB2gvC
         JHWWIqTHdXteCybJygEOBPoSb/vl7NeivmdCHnSnKfk4TiLqXIaVgZw7WoIQHN4fC1Fv
         bN+Mo3rPbHp20fO1DLleuVuHUYmF48vLaE3FxiTR7jOr4phk5Cv0FcFhUKno+n4Edymb
         1shSCW/lQHCmWXzZpFnnXrUtacB7b8BOeh32h3DJKmx8q451vSQAzjXCZjwk9Y46ksHO
         aeSA==
X-Forwarded-Encrypted: i=1; AJvYcCVtiohrbWNG/LbwD2Xc7Zd2+mgMBz7sdJjAm6A49M8j/XJj1lXYTL8LHPOdHqzIhqlntzAme+pKqyx0B24dVOoJtAXEl2I=
X-Gm-Message-State: AOJu0YzOca3BXL3nSMZuAYdrAjIwtlwfatot70Ob+ZE+WeG2MebT6OJT
	wGngj/d4JBEnNbRtlRsYqdo0Q+I73RvHPP6ywBD3JHVrO9JdCQ3nbTOZEouM/T7n4dVCZHrhW45
	oImkGBl9ISbnAPQfWu9Cv0mvFcVc=
X-Google-Smtp-Source: AGHT+IEQwDIjU1uPDtehVAQaw1/z3fKCHW7xjJpO2iSqDasNkhxHmMjofXQkPJJAKw0wBpE4lz/mcTzeUCXMSbOYxuo=
X-Received: by 2002:a05:6000:4028:b0:366:e7e2:13c8 with SMTP id
 ffacd0b85a97d-36bbc0f7a96mr13980593f8f.11.1722904800170; Mon, 05 Aug 2024
 17:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0e54954b-0880-4ebc-8ef0-13b3ac0a6838@huawei.com>
 <8743264a-9700-4227-a556-5f931c720211@huawei.com> <CAKgT0Uf4xBJDLMxa3awSnzgZvbb-LN82APkPi7uVpWw+j7wqRA@mail.gmail.com>
 <8d4b6398-1b7d-4c14-b390-0456a6158681@huawei.com>
In-Reply-To: <8d4b6398-1b7d-4c14-b390-0456a6158681@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 6 Aug 2024 06:09:23 +0530
Message-ID: <CAKgT0Ue1+wvoFzymvMhUvbbSTRgW8=qYySkH80KqRKHCXdHWPg@mail.gmail.com>
Subject: Re: [BUG REPORT]net: page_pool: kernel crash at iommu_get_dma_domain+0xc/0x20
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Yonglong Liu <liuyonglong@huawei.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	"shenjian (K)" <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 6:20=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2024/8/3 0:38, Alexander Duyck wrote:
>
> ...
>
> >
> > The issue as I see it is that we aren't unmapping the pages when we
> > call page_pool_destroy. There need to be no pages remaining with a DMA
> > unmapping needed *after* that is called. Otherwise we will see this
> > issue regularly.
> >
> > What we probably need to look at doing is beefing up page_pool_release
> > to add a step that will take an additional reference on the inflight
> > pages, then call __page_pool_put_page to switch them to a reference
> > counted page.
>
> I am not sure if I understand what you meant about, did you mean making
> page_pool_destroy() synchronously wait for the all in-flight pages to
> come back before returning to driver?

Part of the issue is the device appears to be removed from the iommu
before all the pages have been unmap. To fix that we would either need
to unmap all the pages or force the kernel to wait until all of the
pages have been unmapped before the device can be removed from the
iommu group.

> >
> > Seems like the worst case scenario is that we are talking about having
> > to walk the page table to do the above for any inflight pages but it
>
> Which page table are we talking about here?

The internal memory being managed by the kernel in the form of struct
page. Basically we would need to walk through all the struct page
entries and if they are setup to use the page_pool we are freeing we
would have to force them out of the pool.

> > would certainly be a much more deterministic amount of time needed to
> > do that versus waiting on a page that may or may not return.
> >
> > Alternatively a quick hack that would probably also address this would
> > be to clear poll->dma_map in page_pool_destroy or maybe in
>
> It seems we may need to clear pool->dma_sync too, and there may be some
> time window between clearing and checking/dma_unmap?

That is a possibility. However for many platforms dma_sync is a no-op.

> > page_pool_unreg_netdev so that any of those residual mappings would
> > essentially get leaked, but we wouldn't have to worry about trying to
> > unmap while the device doesn't exist.
>
> But how does the page_pool know if it is just the normal unloading proces=
sing
> without VF disabling where the device still exists or it is the abnormal =
one
> caused by the VF disabling where the device will disappear? If it is the =
first
> one, does it cause resource leaking problem for iommu if some calling for=
 iommu
> is skipped?

It wouldn't. Basically we would have to do this for any page pool that
is being destroyed with pages left in-flight. That is why the
preference would likely be to stall for some time and hope that the
pages get unmapped on their own, and then if they can't we would need
to force this process to kick in so we don't spend forever.
