Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1714AC433EF
	for <iommu@archiver.kernel.org>; Fri,  4 Mar 2022 18:36:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4260408C7;
	Fri,  4 Mar 2022 18:36:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xTWvYUfy_fSw; Fri,  4 Mar 2022 18:36:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3882E4071E;
	Fri,  4 Mar 2022 18:36:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 077B8C0012;
	Fri,  4 Mar 2022 18:36:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08822C000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 18:36:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E9E8460AC9
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 18:36:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5bJ8YUo5cvSC for <iommu@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 18:36:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8D06960AA3
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 18:36:19 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id f8so11861547edf.10
 for <iommu@lists.linux-foundation.org>; Fri, 04 Mar 2022 10:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z7kgXhAx6IomBbir+gF4hSZZXRx/YljCKZVQ3lU5Agc=;
 b=JMLBPI5RHWUnPiQQEFwHRUeG3IXqSfrZy8F/+ICx32Dt41yAx3Fo8JMaZU7h09QB/D
 8R0FwbgvB2fQf3AzvsRmaya/FkTqnGnbFfnlSSIJ9J4WPNsG0ozEunwLzQXAX9GYYJAU
 7Jgy9T1NQZP00BwmvBUci5Kr+giCv3rD0lMew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z7kgXhAx6IomBbir+gF4hSZZXRx/YljCKZVQ3lU5Agc=;
 b=MJ+S84zIj9mXLcYHDqIS2AID7QVPVZio87LX0rC3oHgTtGn5OtTcQa7+VuoQ43GVhg
 BGQFEd1a6B67/pThsxJankArr5AdRzq4A1GVBCDSGqWSrrTJdsTXAbB3X5oMMbE/Czay
 rTgHdJUjLoNRR/rXaRvfIwVaUFA9ETQ40WZWzIGuEbw8rYAQEBR5sD88z6qufRz31Axf
 vG93HzozEo0sguZc21xgTJbpjESEbXdhWNDjwBRJFtElTBX/kOurP4CNLwBmLecHaZYP
 K+/KTA9psjndIfxKYvOdH1KKtFGy1hITihlYfpdDcngw+gxln8bCMmXv97A8f4QsPV5K
 MEGg==
X-Gm-Message-State: AOAM532doFidhdbQEm8vMhRHfUJBBWZWMs5NIOVdFRSlx4lG2FrXC8m6
 KWfDR5zfc7lxPeomBcD1YiDNSPsul1U/J5mL
X-Google-Smtp-Source: ABdhPJy38/7+1Hor90ijM5oNnLq8idUiTYzWii1gN/o7N7P2hXxupoAbG6iRojKRptfLOwRJXuP1HQ==
X-Received: by 2002:a50:d504:0:b0:413:7efe:7d4c with SMTP id
 u4-20020a50d504000000b004137efe7d4cmr34634902edi.316.1646418977345; 
 Fri, 04 Mar 2022 10:36:17 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com.
 [209.85.221.46]) by smtp.gmail.com with ESMTPSA id
 a21-20020a1709062b1500b006da814b08c6sm1986851ejg.94.2022.03.04.10.36.15
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Mar 2022 10:36:15 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id i8so13903521wrr.8
 for <iommu@lists.linux-foundation.org>; Fri, 04 Mar 2022 10:36:15 -0800 (PST)
X-Received: by 2002:a05:6000:2a3:b0:1f0:4945:d924 with SMTP id
 l3-20020a05600002a300b001f04945d924mr19997wry.513.1646418975026; Fri, 04 Mar
 2022 10:36:15 -0800 (PST)
MIME-Version: 1.0
References: <CAAfnVBmDf1fA1ZAufPsPhyOWj0=ynGCVfzX_Cx=pgVmkXe8Tog@mail.gmail.com>
 <eecdc1a2-ea5b-9d4f-9d58-ba87ffa5044d@arm.com>
In-Reply-To: <eecdc1a2-ea5b-9d4f-9d58-ba87ffa5044d@arm.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Fri, 4 Mar 2022 10:36:03 -0800
X-Gmail-Original-Message-ID: <CAAfnVBmHSHvybz+GE02br9TgOSB+LA=ev20XpzdX5xE+vd3Ehg@mail.gmail.com>
Message-ID: <CAAfnVBmHSHvybz+GE02br9TgOSB+LA=ev20XpzdX5xE+vd3Ehg@mail.gmail.com>
Subject: Re: virtio-gpu dedicated heap
To: Robin Murphy <robin.murphy@arm.com>
Cc: virtio-dev@lists.oasis-open.org, Claire Chang <tientzu@google.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, peterz@infradead.org,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 will@kernel.org, hch@lst.de
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0520692234942578756=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============0520692234942578756==
Content-Type: multipart/alternative; boundary="000000000000291c0305d968ca23"

--000000000000291c0305d968ca23
Content-Type: text/plain; charset="UTF-8"

On Fri, Mar 4, 2022 at 4:53 AM Robin Murphy <robin.murphy@arm.com> wrote:

> On 2022-03-04 04:05, Gurchetan Singh wrote:
> > Hi everyone,
> >
> > With the current virtio setup, all of guest memory is shared with host
> > devices.  There has been interest in changing this, to improve isolation
> of
> > guest memory and increase confidentiality.
> >
> > The recently introduced restricted DMA mechanism makes excellent progress
> > in this area:
> >
> >
> https://patchwork.kernel.org/project/xen-devel/cover/20210624155526.2775863-1-tientzu@chromium.org/
> >
> >
> > Devices without an IOMMU (traditional virtio devices for example) would
> > allocate from a specially designated region.  Swiotlb bouncing is done
> for
> > all DMA transfers.  This is controlled by the VIRTIO_F_ACCESS_PLATFORM
> > feature bit.
> >
> >
> https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/3064198
> >
> > This mechanism works great for the devices it was designed for, such as
> > virtio-net.  However, when trying to adapt to it for other devices, there
> > are some limitations.
> >
> > It would be great to have a dedicated heap for virtio-gpu rather than
> > allocating from guest memory.
> >
> > We would like to use dma_alloc_noncontiguous on the restricted dma pool,
> > ideally with page-level granularity somehow.  Continuous buffers are
> > definitely going out of fashion.
> >
> > There are two considerations when using it with the restricted DMA
> approach:
> >
> > 1) No bouncing (aka memcpy)
> >
> > Expensive with graphics buffers, since guest user space would designate
> > shareable graphics buffers with the host.  We plan to use
> > DMA_ATTR_SKIP_CPU_SYNC when doing any DMA transactions with GPU buffers.
> >
> > Bounce buffering will be utilized with virtio-cmds, like the other virtio
> > devices that use the restricted DMA mechanism.
> >
> > 2) IO_TLB_SEGSIZE is too small for graphics buffers
> >
> > This issue was hit before here too:
> >
> > https://www.spinics.net/lists/kernel/msg4154086.html
> >
> > The suggestion was to use shared-dma-pool rather than restricted DMA.
> But
> > we're not sure a single device can have restricted DMA (for
> > VIRTIO_F_ACCESS_PLATFORM) and shared-dma-pool (for larger buffers) at the
> > same time.  Does anyone know?
>
> Yes, it is absolutely intended that a device can have both a
> "restricted-dma-pool" for bouncing data from e.g. user pages, and a
> "shared-dma-pool" from which to allocate dedicated buffers. The
> "restricted-dma-pool" binding even explicitly calls this case out.
>
> As long as the "shared-dma-pool" is suitably sized, it shouldn't make
> much difference to Linux whether it's a simple system memory carveout or
> a special hardware/hypervisor-isolated region. The only real
> considerations for the latter case are firstly that you probably want to
> make sure it is used as a coherent pool rather than a CMA pool (i.e.
> omit the "reusable" property), since if the guest exposes private data
> in shared pages that aren't currently in use for DMA then it rather
> defeats the point, and secondly that if allocating from the pool fails,
> Linux will currently fall back to allocating from regular protected
> memory, which is liable to end badly. There's certainly potential to
> improve on the latter point, but the short-term easy dodge is just to
> make the pool big enough that normal operation won't exhaust it.
>

Thanks for the feedback!  Will experiment with the mixed
"shared-dma-pool" + "restricted-dma" approach for virtio-gpu.


>
> > If not, it sounds like "splitting the allocation into
> > dma_max_mapping_size() chunks" for restricted-dma is also possible.  What
> > is the preferred method?
> >
> > More generally, we would love more feedback on the proposed design or
> > consider alternatives!
>
> Another alternative, if the protection mechanism allows, is to hook into
> the set_memory_(de,en)crypted() APIs to dynamically share buffers as
> they are allocated instead of using a static pool. This should mostly
> work as-is - I think the only impediment is pgprot_decrypted, which
> would need some kind of hook in vmap() to detect it and make the
> corresponding hypervisor call.
>
> Robin.
>

--000000000000291c0305d968ca23
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 4, 2022 at 4:53 AM Robin =
Murphy &lt;<a href=3D"mailto:robin.murphy@arm.com">robin.murphy@arm.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 2=
022-03-04 04:05, Gurchetan Singh wrote:<br>
&gt; Hi everyone,<br>
&gt; <br>
&gt; With the current virtio setup, all of guest memory is shared with host=
<br>
&gt; devices.=C2=A0 There has been interest in changing this, to improve is=
olation of<br>
&gt; guest memory and increase confidentiality.<br>
&gt; <br>
&gt; The recently introduced restricted DMA mechanism makes excellent progr=
ess<br>
&gt; in this area:<br>
&gt; <br>
&gt; <a href=3D"https://patchwork.kernel.org/project/xen-devel/cover/202106=
24155526.2775863-1-tientzu@chromium.org/" rel=3D"noreferrer" target=3D"_bla=
nk">https://patchwork.kernel.org/project/xen-devel/cover/20210624155526.277=
5863-1-tientzu@chromium.org/</a><br>
&gt; <br>
&gt; <br>
&gt; Devices without an IOMMU (traditional virtio devices for example) woul=
d<br>
&gt; allocate from a specially designated region.=C2=A0 Swiotlb bouncing is=
 done for<br>
&gt; all DMA transfers.=C2=A0 This is controlled by the VIRTIO_F_ACCESS_PLA=
TFORM<br>
&gt; feature bit.<br>
&gt; <br>
&gt; <a href=3D"https://chromium-review.googlesource.com/c/chromiumos/platf=
orm/crosvm/+/3064198" rel=3D"noreferrer" target=3D"_blank">https://chromium=
-review.googlesource.com/c/chromiumos/platform/crosvm/+/3064198</a><br>
&gt; <br>
&gt; This mechanism works great for the devices it was designed for, such a=
s<br>
&gt; virtio-net.=C2=A0 However, when trying to adapt to it for other device=
s, there<br>
&gt; are some limitations.<br>
&gt; <br>
&gt; It would be great to have a dedicated heap for virtio-gpu rather than<=
br>
&gt; allocating from guest memory.<br>
&gt; <br>
&gt; We would like to use dma_alloc_noncontiguous on the restricted dma poo=
l,<br>
&gt; ideally with page-level granularity somehow.=C2=A0 Continuous buffers =
are<br>
&gt; definitely going out of fashion.<br>
&gt; <br>
&gt; There are two considerations when using it with the restricted DMA app=
roach:<br>
&gt; <br>
&gt; 1) No bouncing (aka memcpy)<br>
&gt; <br>
&gt; Expensive with graphics buffers, since guest user space would designat=
e<br>
&gt; shareable graphics buffers with the host.=C2=A0 We plan to use<br>
&gt; DMA_ATTR_SKIP_CPU_SYNC when doing any DMA transactions with GPU buffer=
s.<br>
&gt; <br>
&gt; Bounce buffering will be utilized with virtio-cmds, like the other vir=
tio<br>
&gt; devices that use the restricted DMA mechanism.<br>
&gt; <br>
&gt; 2) IO_TLB_SEGSIZE is too small for graphics buffers<br>
&gt; <br>
&gt; This issue was hit before here too:<br>
&gt; <br>
&gt; <a href=3D"https://www.spinics.net/lists/kernel/msg4154086.html" rel=
=3D"noreferrer" target=3D"_blank">https://www.spinics.net/lists/kernel/msg4=
154086.html</a><br>
&gt; <br>
&gt; The suggestion was to use shared-dma-pool rather than restricted DMA.=
=C2=A0 But<br>
&gt; we&#39;re not sure a single device can have restricted DMA (for<br>
&gt; VIRTIO_F_ACCESS_PLATFORM) and shared-dma-pool (for larger buffers) at =
the<br>
&gt; same time.=C2=A0 Does anyone know?<br>
<br>
Yes, it is absolutely intended that a device can have both a <br>
&quot;restricted-dma-pool&quot; for bouncing data from e.g. user pages, and=
 a <br>
&quot;shared-dma-pool&quot; from which to allocate dedicated buffers. The <=
br>
&quot;restricted-dma-pool&quot; binding even explicitly calls this case out=
.<br>
<br>
As long as the &quot;shared-dma-pool&quot; is suitably sized, it shouldn&#3=
9;t make <br>
much difference to Linux whether it&#39;s a simple system memory carveout o=
r <br>
a special hardware/hypervisor-isolated region. The only real <br>
considerations for the latter case are firstly that you probably want to <b=
r>
make sure it is used as a coherent pool rather than a CMA pool (i.e. <br>
omit the &quot;reusable&quot; property), since if the guest exposes private=
 data <br>
in shared pages that aren&#39;t currently in use for DMA then it rather <br=
>
defeats the point, and secondly that if allocating from the pool fails, <br=
>
Linux will currently fall back to allocating from regular protected <br>
memory, which is liable to end badly. There&#39;s certainly potential to <b=
r>
improve on the latter point, but the short-term easy dodge is just to <br>
make the pool big enough that normal operation won&#39;t exhaust it.<br></b=
lockquote><div><br></div><div>Thanks for the feedback!=C2=A0 Will experimen=
t with the mixed &quot;shared-dma-pool&quot;=C2=A0+ &quot;restricted-dma&qu=
ot; approach for virtio-gpu.</div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
<br>
&gt; If not, it sounds like &quot;splitting the allocation into<br>
&gt; dma_max_mapping_size() chunks&quot; for restricted-dma is also possibl=
e.=C2=A0 What<br>
&gt; is the preferred method?<br>
&gt; <br>
&gt; More generally, we would love more feedback on the proposed design or<=
br>
&gt; consider alternatives!<br>
<br>
Another alternative, if the protection mechanism allows, is to hook into <b=
r>
the set_memory_(de,en)crypted() APIs to dynamically share buffers as <br>
they are allocated instead of using a static pool. This should mostly <br>
work as-is - I think the only impediment is pgprot_decrypted, which <br>
would need some kind of hook in vmap() to detect it and make the <br>
corresponding hypervisor call.<br>
<br>
Robin.<br>
</blockquote></div></div>

--000000000000291c0305d968ca23--

--===============0520692234942578756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0520692234942578756==--
