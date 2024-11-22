Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD30170854
	for <iommu@lists.linux.dev>; Fri, 22 Nov 2024 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732307612; cv=none; b=iWy3BDdmbfExN076rSC71SPr+fSZHJCI0v2lyRLPRechiV8PPdkJdZZJPH2rfjf/iZhplxQlz/CronsacfyeJ+KzUyjV7eUK3oNQFjAxYM5jQSYNS9yQ7knCvUeIn9LKc13++C6nskaD/KzXvItsT0ncPm7B66xCf+mnh7i6KaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732307612; c=relaxed/simple;
	bh=LITRt5K4nbGCelcHjyhzVoroqeJ/9JP38P5L6NZbAWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIaj8ZwfeGyUV4lgVc2oCnN7QkQrRjdcqbtnVR9TT4HQqbY1lqgXO0vKlTXRma+mB6rQ39hJD1WNptu/MIYhK1g11GDW1F0rgocuTgF/wO5AncBl1gD+BLYjsqnQa4VaGrKgisl4MFS6IKBrqTI2GpF0xKr0vOCssYR5U7sxn2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGrRryzG; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGrRryzG"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa20944ce8cso650431366b.0
        for <iommu@lists.linux.dev>; Fri, 22 Nov 2024 12:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732307609; x=1732912409; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdtIpBGI3WtRlHvfWANFY4rDk+3Kg9qCxLIyUfYO1ZA=;
        b=YGrRryzG6XtQ0DObQGfnJ7cBvLMqu9BUOEwL0IYhLSK2S71BQFt4eMIVwJAUrKaSPL
         jUwrZGvgWbHURfcGg5yzo9yC2+H95AuSZc7fpI4BVc61rzGWtX+PBQX4Y3YjjHeQ4/4L
         CEuFQlcbWqkoHC1i8Mxo+Dr/suwU3Or/SqFN/+mif2zz+zsll1tB+dxu+TVRuu6wJ9kc
         0s6vtG92CPhXB87kt82nEGyvqwG7Q2gU1flCZ5qaEHypB9GNKBPkviEhOcpXSLFnbH6t
         c5DLCmTzGxkC9TpBCAHbG1QSLlTiB7Ck7mgPLKqEmib50rpcy8zMCirtzb6GMfUs3MGD
         /4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732307609; x=1732912409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdtIpBGI3WtRlHvfWANFY4rDk+3Kg9qCxLIyUfYO1ZA=;
        b=GGV4dY5/1Wat/JaioXpUrix5vyVKZSWQUE+H9Wdxo6hkEZYv+7J166b3N3DSasVlAy
         dUJ9p+cMh6SeXxjN+wXVevnpRJpbnNYAmvhg8hYQK4xPYSIit8ZkRRrW1zwepC0piOAw
         hvSnFKLSqCOTCjtU2Oayr2PiMuiRFNOd7IX6Jc0l4EyhCTBi7amjZkGREwIi3NNxY6A0
         hgVvAoiK7bn6Qg4fXwDaWrurvL4ko+yYwaG8Lo3A4gXj1TwGpUGnydJnHLZmmES5Flk0
         y3u1uNXmCOe8Lku0Y9pMQfKQ2Y6VOYGGeLSrPRjWQnp9tEnZw5A9QZkznGFDtAyQDm78
         U+xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm/n+CI4DlJO9AeIExyhYIk7H/l5BnpLNFVCD1lp0dcYgUlrvRxPmGpHpqYux2iNlKYS0s5w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlXjLgTdX35LUhYBWgoA5EamISEXjTAWwCPV4aT6J0y49lHy8M
	baIawhV9ukBMfOKfgCLfhNAca2QLZxqk16kfidGFJf9UYbzVurp3CQVbE5N93rCgXhJDuJUKKNy
	JUs24/cOoR1QLgf+ZukdvZdUdkbA=
X-Gm-Gg: ASbGncuZcuZlQJPrxZg4W5Lhj/xPVItqNY+km9KIjuVIkK3sb/JV5nwPQBlcUc/5iws
	k9HTPsDQ9jOd2gANSLJCnbXJbD37iiayV
X-Google-Smtp-Source: AGHT+IETM9O9HSssquiq/42hR/1lGtNNI4BZqIYmPyKLfK2dsxTYDZg6JA+h2iTQDBGveNTqdzVDncZI23ek3LZoiGg=
X-Received: by 2002:a17:907:31c5:b0:a9a:e0b8:5bac with SMTP id
 a640c23a62f3a-aa4efe2a1f6mr775060566b.23.1732307608637; Fri, 22 Nov 2024
 12:33:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241122191304.4182642-1-bjohannesmeyer@gmail.com>
In-Reply-To: <20241122191304.4182642-1-bjohannesmeyer@gmail.com>
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Date: Fri, 22 Nov 2024 13:33:15 -0700
Message-ID: <CAOZ5it0Yj8taexnFJiAqJhPP_8z5Dv_OjonyGXMbA3Tiu=9ugQ@mail.gmail.com>
Subject: Re: [RFC 0/1] swiotlb: Mitigate potential DoS caused by BUG_ON()
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
> We identified a security issue in the swiotlb unmapping operation, stemmi=
ng
> from the way some drivers save streaming DMA addresses. This issue can
> potentially be exploited by a malicious peripheral device to cause a
> denial-of-service (DoS) via a kernel panic.
>
> **Disclosure Context**
> We previously reported a similar issue to the Linux kernel security team.
> However, they advised submitting such cases directly to the relevant
> subsystem maintainers and the hardening mailing list, because Linux
> implicitly assumes hardware can be trusted.
>
> **Threat Model**
> While Linux drivers typically trust their hardware, there may be specific
> drivers that do not operate under this assumption. Hence, we consider a
> malicious peripheral device that corrupts DMA data to exploit the kernel.
> In this scenario, the device manipulates driver-initialized data (similar
> to the attack described in the Thunderclap paper [0]) to achieve a DoS.
>
> **Background**
> Streaming DMA is often used as follows:
> (1) A driver maps a buffer to DMA using dma_map_single(), which returns a
> DMA address. This address is then saved by the driver for later use.
> (2) When the buffer is no longer needed, the driver unmaps it using
> dma_unmap_single(), passing the previously saved DMA address.
> (3) Under certain conditions---such as the driver using direct mapping
> operations, and the mapped buffer requiring a swiotlb
> buffer---dma_unmap_single() calls swiotlb_release_slots(). Here, the save=
d
> DMA address is passed as its tlb_addr argument.
>
> **Vulnerability**
> It is common for drivers to store the DMA address returned by
> dma_map_single() into a coherent DMA region, which can be manipulated by =
a
> malicious device. For example, the E100 driver and RealTek 8139C+ driver
> map socket buffers into streaming DMA and save their DMA addresses to
> coherent DMA data. While these drivers might assume trusted hardware, thi=
s
> behavior is not necessarily unique to them.
>
> If an untrusted device corrupts the DMA address, it can influence the
> tlb_addr argument passed to swiotlb_release_slots(). Inside this function=
,
> tlb_addr is used to calculate aindex, which is validated via BUG_ON(ainde=
x
> >=3D mem->nareas). By manipulating the DMA address, an attacker can trigg=
er
> this assertion, resulting in a kernel panic and DoS.
>
> I have a PDF document that illustrates how these steps work. Please let m=
e
> know if you would like me to share it with you.
>
> **Proposed mitigation**
> To address this issue, two potential approaches are possible:
>
> (1) Mitigating the *initialization* of attacker data: Prevent drivers fro=
m
> saving critical data, such as DMA addresses, in attacker-controllable
> regions.
> (2) Mitigating the *use* of attacker data: Modify the handling of critica=
l
> data, such as in the BUG_ON() statement, to not result in catastrophic
> outcomes like kernel panics.
>
> While approach (1) is more complete, it is more challenging to deploy
> universally. Hence, we propose mitigating this issue with approach (2):
> i.e., replacing the BUG_ON() assertion with more graceful error handling.
> The attached patch implements this change, ensuring the kernel can handle
> the condition safely without triggering a panic.
>
> **Request for Feedback**
> I am not deeply familiar with the swiotlb internals, so I would appreciat=
e
> any feedback on the patch. In particular, is there a more graceful way to
> handle the error than returning?
>
> Thanks,
>
> Brian Johannesmeyer
>
> [0] Link: https://www.csl.sri.com/~neumann/ndss-iommu.pdf
>
> Brian Johannesmeyer (1):
>   swiotlb: Replace BUG_ON() with graceful error handling
>
>  kernel/dma/swiotlb.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> --
> 2.34.1
>

Whoops -- didn't send to the hardening mailing list. Adding it now.

-Brian
