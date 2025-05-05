Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6D31E5B7C
	for <iommu@lists.linux.dev>; Mon,  5 May 2025 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746439229; cv=none; b=pvyZkJ6CFR2luwNsCjKAxCh/vvWmvtjwa8KfvyhUdg1odZg8NBhdkGXdJj0sRCo8smOeV/ywXmxv+6rg1saxuBH1TMd1p6exCcFKLS5z46mERxuZbZXr4UYQbswROFzhs02JZgtI7abTEMOsu9sgRx2ceqZYu5RgztKoxfC209Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746439229; c=relaxed/simple;
	bh=Km+TINB0CWZALLBWBc4SAkK6bvOGzq+9JbzdiYWHnJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gB+NTbToYe8sBK1ZFkR6TQg/waJrmkRBOKK8iINYmwyIXq9xIXsTVA3euIEo2X6Rpd/kPcKMkAJOfWS1gPGMggRraAiPGKkw/AWhSu+cnWM1Vi3oDqN3yfahuLi15BFvgxKUcz4wffQlGCUJcwWtrV9Wzo2r4AshbUXFxsCxczI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ToomlAlu; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ToomlAlu"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-604ad0347f5so982005eaf.2
        for <iommu@lists.linux.dev>; Mon, 05 May 2025 03:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746439226; x=1747044026; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUO+n2qCCkVBKkF0xc34yA7zFKP1PRXVjAuF6gNjM7w=;
        b=ToomlAluP7IIphv2rbt7w2Z/2NUNatoHHgr3GHeoS974y6t8o6yFgWA0iIkEurrqd4
         wq0DdlNKFVUQ5K7iD98FTdJXCiUSoeL/rC3nlK2340vTr6BlrVGP9sq0d5wMXEBwzShg
         BCl8lsQAMb6MPkuzxAR1hZJbMqZp57yMzKr/lmvDeDiI5WUYRlmCYii7/vvdQqJcAVKV
         u/uyw9e083xv9Jp+yV2zGMTQRe7OFWv5LpCWWK7Gpml/5jgJfc8jRLiXUlYkIDzoNoI1
         igb5NZq4Np8PSaseGmeERIFjIn+Tfoz/4fZgdBoBNuA2a8pSS8+uk4XuWK2sR/t0u7j6
         8bBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746439226; x=1747044026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUO+n2qCCkVBKkF0xc34yA7zFKP1PRXVjAuF6gNjM7w=;
        b=uA3liXgvKjdP/bm/C6Hg1fSzNqT8x+H32uqHdNUq5aSADjfQwywyHOK50t6PiYvZk0
         0uroGNcDvIBo0T4krQP12jOeYutHWH/Ci/mpalTwnm5WEWHsTxq/i2kJlRqP5/4Su8b7
         K3E/Q2E/jlJ9GITzGagjW4FBdqzDD2eMaiXxCvyVT3JUqDAxkBInqZplzd9wMRihfy4h
         mPMwRgbmwmnY5rwTnCFvjG6mS2VkWpiqVsDO6qWLDJgdqfbvyXHrcFc5C/YeS61J4PYE
         H795QrdLd9sBW7M/lcmIFTMIzBWhMfG58WKo+JwjMunTmOh1ygISxexAcWDg4Q1AYZvO
         DefQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI5LPQtoHsYvElEnjG5C3J7jd8+6V1IYcbe74BD6MffuluxhSxoot1lpkWQUJj20WXsshTmg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzjynIgT4Q54yjBCvzlDuwLDwBrx50ahyVR9e5sBXahGjYJP4GU
	thc33wwwufXCN3CMEvL18SCq03R9EU29y1E8pt/KP0qFdewj98MtnqtMBFhgT8hhj0GFnVolTOQ
	zTMCCwecPvmEJkjNU77Vxind5X5nW6TsdjhQSeA==
X-Gm-Gg: ASbGnctvvzLBkJ5JoAaMHflWo9gkKPec0K3c7MviYostNiQd+iD+IRV7Uk+dDNgVvds
	Jw21Jcv0kNgINjhSE8f/UvmsrgJlimGCcgfbGF0uJyluaESSzU2pX+Qp3upJqfaIE06uP4R6POF
	E4KQYcG+OXjQVNtkM9GUe4Tzo=
X-Google-Smtp-Source: AGHT+IEfTkbjK5JWEDIXSUVf0w92h26obU5oYSgxTn7TbvfY+I0Zkozng+KfK0iBSmGp52i/r+Q8MQct9dxWARB5Up4=
X-Received: by 2002:a05:6870:972c:b0:2d5:230f:b34d with SMTP id
 586e51a60fabf-2dae82cc070mr3868126fac.1.1746439225695; Mon, 05 May 2025
 03:00:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250502100049.1746335-1-jens.wiklander@linaro.org>
 <20250502100049.1746335-11-jens.wiklander@linaro.org> <43e85d6a-ef99-4d61-910e-1d62814fd9ed@arm.com>
In-Reply-To: <43e85d6a-ef99-4d61-910e-1d62814fd9ed@arm.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 5 May 2025 12:00:12 +0200
X-Gm-Features: ATxdqUFPin2MFa6t0S3tPjOQfIF3WcjTWu_QNb2z1h_FFrZyFMNu2bu0GEdtH9Y
Message-ID: <CAHUa44GC-HRUNGkta-EfMD00VzPBvqcVqU4Zj7kvW8CPnahdMg@mail.gmail.com>
Subject: Re: [PATCH v8 10/14] dma-contiguous: export dma_contiguous_default_area
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, 
	Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, 
	Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, 
	Rouven Czerwinski <rouven.czerwinski@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 2, 2025 at 3:11=E2=80=AFPM Robin Murphy <robin.murphy@arm.com> =
wrote:
>
> On 02/05/2025 10:59 am, Jens Wiklander wrote:
> > Export the global variable dma_contiguous_default_area so
> > dev_get_cma_area() can be called a module.
>
> What dma_map_ops implementation is in a module? Without any other
> context, I can't help thinking this smells of something sketchy.

I see that you found the rest of the patch set
https://lore.kernel.org/lkml/20250502100049.1746335-1-jens.wiklander@linaro=
.org/

Thanks,
Jens


>
> Thanks,
> Robin.
>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: iommu@lists.linux.dev
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >   kernel/dma/contiguous.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> > index 8df0dfaaca18..eb361794a9c5 100644
> > --- a/kernel/dma/contiguous.c
> > +++ b/kernel/dma/contiguous.c
> > @@ -53,6 +53,7 @@
> >   #endif
> >
> >   struct cma *dma_contiguous_default_area;
> > +EXPORT_SYMBOL(dma_contiguous_default_area);
> >
> >   /*
> >    * Default global CMA area size can be defined in kernel's .config.
