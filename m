Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A101A7273
	for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 19:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734033493; cv=none; b=i3YMoYA7tBtyg6o/Gz5nfl5hNOvNrKgKiSXW0wIbwc96vutugRW8UO+lgI4jKXAdRcvsxWC4P2g7WRi6GrCpi5SOKpm75nONpYOX2qxH5eBu3VnoH3/lEHQ1QgFglj4PP/o0eCD5TrYhGlWJ1ge0k215f0IxmFAlbK/gkbF+H/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734033493; c=relaxed/simple;
	bh=sJ1KNowovNm0HPubZssrDATYTz+xau5qC1DIBkbKznk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQPtDI5niJ5i/EBDU4gcM/1fpaMr1kN7aTSjB1tmIlGeOMeXxPWyFnpmJH5skteykp8jAagwCVK++YRggD72OWkzutEJ2Vgg0dU/aB8Ix9Zbn7OdP9QMIfYvAu2FIHynGaIG4R5t70bMC+gow5DyAVPfam+vdn86dMqbv7R9aBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=lfqU+cUA; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="lfqU+cUA"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6f26c517979so7900477b3.2
        for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 11:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1734033489; x=1734638289; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=es3BFB53+lctNKfs4aUSJijTNGpS8BvQvLSU21bgHvQ=;
        b=lfqU+cUAu7U08b6l9uHUgNJs46/w17MDOhWlS8Zn1OVcrH56XwsHhlAfNh/URgAEL7
         RSb89ohtkfCUmA8ArSjOPVrFDubtFODlamWXBuTpFmKyQvgkG+8hTS9Kirzy1qchLBk/
         6jOGgFcig/EpGksUJOvblze0qf/ysXjPjTSiO9CGPhgsOFmDNNJjgTn4pMF3NSfiLsjP
         3yA5Xw7EVxPkqlQzF4yYYFL88Q+wwPjv8UZxQYEBL2qrCPUj0QuFJHUUiz2pLCjqy8Fv
         cIeeFnRr2vMY2hxXkSecus9jM7HTc89q8ZknRzfNKMRTNIUEZX5alIuP5tUEhBiBIdU+
         ZZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734033489; x=1734638289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=es3BFB53+lctNKfs4aUSJijTNGpS8BvQvLSU21bgHvQ=;
        b=BvbwjLJpHAPg7BUDTrAZ+zqhlJF6giLKjKQ0AyEQ3+TLGXAK9aNWmSswrRRXXhXx5T
         Vo7dkPXHPXMhN3roNdQuocZww+PVcsCEFwoEfvRN81fjhUkd7oUzGz+5Crkdl7bGchFU
         VMjKJV2GAtXl9hDNp91DQWml0hYcDfxDeIL5RwloI36Ak64DDTx4fYn5RPIMMS7lnybD
         KLRO4RnJmmKtybjTNyxyEc4LX3H2av+Tj783rKG30jsNKAsw4W6NO8KDaPMnWPifYXxU
         vxghyxl1RPu4IsYxV8YzfNPvmMnrEDpsMDW8ppyr6u1A9suvb9vBgTGsMeZ26UZIikW5
         VQCA==
X-Forwarded-Encrypted: i=1; AJvYcCVS3PjVRJ/r6kmd/5ACcM4CHJeDdgTM7hvtzH9YLA1BY04Kbuz3dtmCrS40jOiKmO4qppP+ZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMYKpcwdwS705QopXcf3Mq+yJKacf4YRzIA+vCDh4tQW1PcegF
	wjpoTAqvLjB532kr69Vde9ift0U2YKnRlMZtgDsqo7qPH+m1h5njD12xLSiLG+sorscOqYWRIOt
	QWG++zqXsfshw39yf7I6J5C9jEmO52TQa/S9vCg==
X-Gm-Gg: ASbGncuqZViwTY34LTyKCPkLRpPXtPw4lc/1wdOh2KIFAFcmP4TKu++hCnLMNJc/36V
	Z5f72pS8+UwnwM7W8fKudqG6qLpsRi4C1baQ0Aw==
X-Google-Smtp-Source: AGHT+IE+lPF/qLoY6pAEypWuIRGNZppvfbzy6XsQEdtFs6bR6IRA8406DPbu63fZQJOWbgOJrMamI9waVwE+nSHCj4A=
X-Received: by 2002:a05:690c:3805:b0:6ef:7312:d06c with SMTP id
 00721157ae682-6f279b2367dmr120167b3.21.1734033488919; Thu, 12 Dec 2024
 11:58:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAJ+vNU0EL3T+GyNAbVbGqYYQ5NM3h7cgAwqxxBMuZjh+-YQ3bA@mail.gmail.com>
 <1b2ea8b2-6fbe-4118-b6c6-742c8f0be476@quicinc.com> <CAJ+vNU1-OZ3y4p2L+zf64AiVtUv70yZNqkT20jTxyE0_gJb6Jg@mail.gmail.com>
 <0282be95-9094-4d49-b79e-4f7c976dad00@quicinc.com> <CAJ+vNU32EMHjtchJRb1sODBrUKG2vZW4ZEu1_F0+dCCEjCn7Dg@mail.gmail.com>
 <20241209081714.GA25363@lst.de> <593c0d63-d8fd-4439-a57a-97340212c197@arm.com>
 <CAJ+vNU2ypE_Mn_6iKCmf5LYk9Sth=ryWXyewc5MhOKK8VoAKCA@mail.gmail.com>
 <20241210041133.GA17116@lst.de> <CAJ+vNU03Cqsc+O5anwmvJW8Wfd-06LbDMVHjxVFdixf01ZLczQ@mail.gmail.com>
 <5fe372df-ae51-4a8b-9fa3-a4a0ea2d33e3@quicinc.com> <9b2e8ffa-ba2c-46da-a478-eb1fb44b693e@arm.com>
 <80992ae5-e329-4a34-94c8-9345b2e8a9a0@quicinc.com>
In-Reply-To: <80992ae5-e329-4a34-94c8-9345b2e8a9a0@quicinc.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 12 Dec 2024 11:57:57 -0800
Message-ID: <CAJ+vNU1v6JMTcnKhJAPtRu2A-rVjNNUd3MrqAP64EWMiNVuC4g@mail.gmail.com>
Subject: Re: ath11k swiotlb buffer is full (on IMX8M with 4GiB DRAM)
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, ath11k@lists.infradead.org, 
	linux-wireless <linux-wireless@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 9:24=E2=80=AFPM Baochen Qiang <quic_bqiang@quicinc.=
com> wrote:
>
>
>
> On 12/11/2024 9:44 PM, Robin Murphy wrote:
> > On 2024-12-11 2:31 am, Baochen Qiang wrote:
> >>
> >>
> >> On 12/11/2024 7:06 AM, Tim Harvey wrote:
> >>> On Mon, Dec 9, 2024 at 8:11=E2=80=AFPM Christoph Hellwig <hch@lst.de>=
 wrote:
> >>>>
> >>>> On Mon, Dec 09, 2024 at 11:15:02AM -0800, Tim Harvey wrote:
> >>>>> After a lot of back and forth and investigation this is due to the
> >>>>> IMX8M SoC's not having an IOMMU thus swiotlb is being used and ath1=
1k
> >>>>> is requesting some buffers that are too large for swiotlb to provid=
e.
> >>>>> There is a specific patch which added the HAL_WBM2SW_RELEASE buffer=
s
> >>>>> to cacheable memory that could be reverted to fix this but the conc=
ern
> >>>>> was that it would impact performance moving those buffers to
> >>>>> non-cacheable memory (there are three ~1MiB buffers being allocated=
):
> >>>>> commit d0e2523bfa9cb ("ath11k: allocate HAL_WBM2SW_RELEASE ring fro=
m
> >>>>> cacheable memory").
> >>>>
> >>>> The combination of "buffers" and "swiotlb" sounds like Robin was rig=
ht
> >>>> below.
> >>>>
> >>>>> The chain of events as best I can tell are:
> >>>>>
> >>>>> commit 6452f0a3d565 ("ath11k: allocate dst ring descriptors from
> >>>>> cacheable memory")
> >>>>> - Nov 12 2021 (made it into Linux 5.17)
> >>>>> - changes allocation of reo_dst rings to cacheable memory to allow
> >>>>> cached descriptor access to optimize CPU usage
> >>>>> - this is flawed because it uses virt_to_phys() to allocate cacheab=
le
> >>>>> memory which does not work on systems with an IOMMU enabled or usin=
g
> >>>>> software IOMMU (swiotlb); this causes a kernel crash on client
> >>>>> association
> >>>>
> >>>> And this is where it started to take a wrong turn, that everyhing
> >>>> later basically made worse.  If you have long living and potentially
> >>>> large DMA allocations, you need to use dma_alloc_* interfaces.
> >>>>
> >>>> 5.17 already had dma_alloc_pages for quite a while which was and sti=
ll is
> >>>> the proper interface to use.  For much older kernel you'd be stuck
> >>>> with dma_alloc_noncoherent or dma_alloc_attrs with the right flag,
> >>>> but even that would have been much better.
> >>>
> >>> Christoph,
> >>>
> >>> I'm not clear what you are suggesting be done here. Are you suggestin=
g
> >>> that ath11k has been using the wrong mechanism by calling
> >>> dma_map_single for cached DMA buffers? I'm not all that familiar with
> >>> ath11k so I can't tell what buffers are considered long living.
> >>
> >> those buffers are allocated when driver load and freed when driver unl=
oad, so IMO they are
> >> long living.
> >
> > The point is that if this driver wants a notion of "cached DMA buffers"=
, then it should
> > allocate such buffers the proper way, not try to reinvent it badly. Tha=
t means using
> > dma_alloc_pages(), or modern dma_alloc_noncoherent() which is essential=
ly the same thing
> > but with the dma_map_page() call automatically done for you as well.
>
> yeah, you are right, Robin. didn't know there are convenient interfaces l=
ike these already.
>
> Tim, can you work out a patch then?
>

How about:

diff --git a/drivers/net/wireless/ath/ath11k/dp.c
b/drivers/net/wireless/ath/ath11k/dp.c
index fbf666d0ecf1..557e06187e95 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -105,9 +105,8 @@ void ath11k_dp_srng_cleanup(struct ath11k_base
*ab, struct dp_srng *ring)
                return;

        if (ring->cached) {
-               dma_unmap_single(ab->dev, ring->paddr_unaligned, ring->size=
,
-                                DMA_FROM_DEVICE);
-               kfree(ring->vaddr_unaligned);
+               dma_free_noncoherent(ab->dev, ring->size, ring->vaddr_unali=
gned,
+                                    ring->paddr_unaligned, DMA_FROM_DEVICE=
);
        } else {
                dma_free_coherent(ab->dev, ring->size, ring->vaddr_unaligne=
d,
                                  ring->paddr_unaligned);
@@ -249,28 +248,18 @@ int ath11k_dp_srng_setup(struct ath11k_base *ab,
struct dp_srng *ring,
                default:
                        cached =3D false;
                }
-
-               if (cached) {
-                       ring->vaddr_unaligned =3D kzalloc(ring->size, GFP_K=
ERNEL);
-                       if (!ring->vaddr_unaligned)
-                               return -ENOMEM;
-
-                       ring->paddr_unaligned =3D dma_map_single(ab->dev,
-
ring->vaddr_unaligned,
-                                                              ring->size,
-                                                              DMA_FROM_DEV=
ICE);
-                       if (dma_mapping_error(ab->dev, ring->paddr_unaligne=
d)) {
-                               kfree(ring->vaddr_unaligned);
-                               ring->vaddr_unaligned =3D NULL;
-                               return -ENOMEM;
-                       }
-               }
        }

-       if (!cached)
+       if (cached) {
+               ring->vaddr_unaligned =3D dma_alloc_noncoherent(ab->dev,
ring->size,
+
&ring->paddr_unaligned,
+                                                             DMA_FROM_DEVI=
CE,
+                                                             GFP_KERNEL);
+       } else {
                ring->vaddr_unaligned =3D dma_alloc_coherent(ab->dev, ring-=
>size,

&ring->paddr_unaligned,
                                                           GFP_KERNEL);
+       }

        if (!ring->vaddr_unaligned)
                return -ENOMEM;

If this is what we are talking about here I can submit that with a
proper commit log. Note there are a lot of other calls to
dma_map_single in the ath drivers and my understanding is those may be
just fine for small short-lived buffers but I'm not clear if that is
what they are always used for.

Best Regards,

Tim

> >
> > Thanks,
> > Robin.
>
