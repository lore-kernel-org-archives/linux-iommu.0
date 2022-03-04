Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C68C433EF
	for <iommu@archiver.kernel.org>; Fri,  4 Mar 2022 10:01:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EBCD60804;
	Fri,  4 Mar 2022 10:01:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0V780483cIpu; Fri,  4 Mar 2022 10:01:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AB6DD60ADE;
	Fri,  4 Mar 2022 10:01:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5332AC001D;
	Fri,  4 Mar 2022 10:01:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 491BBC000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 04:07:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 257BB4161D
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 04:07:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ajJwMwjSuz2B for <iommu@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 04:07:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E096741599
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 04:07:15 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 o18-20020a05600c4fd200b003826701f847so5899174wmq.4
 for <iommu@lists.linux-foundation.org>; Thu, 03 Mar 2022 20:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=hMCzXITnLG97BMV0ckfkRDxUmttEucHzyk9GKZ7o3gI=;
 b=RC27xdo3GgNt69hw1gXE3K9lveajEXrAr9NtbV+lc9GQknM+LsYlWOVx9K6NNqlRF4
 sWccc7IFYU/0zHyRoXrNpoplv1kPprszhCnqxA0Yo2qCqtNPMEcyRt8z1nfH0eV6VqM+
 uvIAZPUji+zaqWAsuv9slC/mwnlVxezPNZbyU9c4k0OIjOG5NlCAD9tOyTPlI+lsVNgs
 YAQPEVywQcFRW9ZcHeTMovyioD2Bm2wSSt6z7uJajZzAmzqrZ/afWf8lNQ4UXRTCeeyj
 s+K1sqfj2XWkFJ4E7Dc3m+Kx1dRvWw2aSSZn35MGDtqjfDgDkJ8rsYoAr8CdeUf4YpSm
 gV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=hMCzXITnLG97BMV0ckfkRDxUmttEucHzyk9GKZ7o3gI=;
 b=0TIfxv8/3WLcdjaj7ZLHFMqfQuKGR0zVKgHeeKRgTzHBN/QVWZfJAGnWYhAexHus2l
 y/izo3xtDpPyaAtUKkJe1wzWf2xOCBQaeUjr0dMZA9oNB0f9aed7s5aqQTCm6il8GO3M
 3Z75T96ryfL9Dv3GDRikvxyubTtXW5RT+UNVWtHKtZs/qLIqLyE2E/4dypEpZjIkKTXU
 4QuUk9OAIFJ5gfPBM/MkZ0Jo/ni9JeFh8fDFljdBbS1Nswz81bE3rk+ZVgGTsdCpLenC
 w4veEG6QbSfm+qXFwy2RjWtrnTrsxZcUYkWIBRRT+JRezQbB/nQW49jN/d7Rv/uizX8g
 iPxA==
X-Gm-Message-State: AOAM533/mbl7J7x4a7aAQ34Ht5w5sLSg0hObMlEoX0I9eVakTiKEeR9Y
 RD4AS2D8ecaAwwBtgXIV/mUc4Yu+OaiOaKl/9i1+Kw==
X-Google-Smtp-Source: ABdhPJxGUa2SM6oPz9v3MSKW38stVE/BnGPnIv69Faa+CDpE0E4l3ocXhJ0vipiBIy0FeLwDWlnwtIudMtSPiPmyZs4=
X-Received: by 2002:a05:600c:3505:b0:383:40d9:f31a with SMTP id
 h5-20020a05600c350500b0038340d9f31amr5989939wmq.189.1646366833894; Thu, 03
 Mar 2022 20:07:13 -0800 (PST)
MIME-Version: 1.0
References: <CAAfnVBmDf1fA1ZAufPsPhyOWj0=ynGCVfzX_Cx=pgVmkXe8Tog@mail.gmail.com>
In-Reply-To: <CAAfnVBmDf1fA1ZAufPsPhyOWj0=ynGCVfzX_Cx=pgVmkXe8Tog@mail.gmail.com>
Date: Thu, 3 Mar 2022 20:07:03 -0800
Message-ID: <CAAfnVBmCUHKRUVA=UouoSUH-eTyTTpNReU6i8TSD94iyYWyQzg@mail.gmail.com>
Subject: Re: virtio-gpu dedicated heap
To: virtio-dev@lists.oasis-open.org, peterz@infradead.org, 
 m.szyprowski@samsung.com, hch@lst.de, "Michael S. Tsirkin" <mst@redhat.com>,
 robin.murphy@arm.com, will@kernel.org, Claire Chang <tientzu@google.com>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org
X-Mailman-Approved-At: Fri, 04 Mar 2022 10:01:21 +0000
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
From: Gurchetan Singh via iommu <iommu@lists.linux-foundation.org>
Reply-To: Gurchetan Singh <gurchetansingh@google.com>
Content-Type: multipart/mixed; boundary="===============1271126572620050301=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============1271126572620050301==
Content-Type: multipart/alternative; boundary="0000000000004e526405d95ca65e"

--0000000000004e526405d95ca65e
Content-Type: text/plain; charset="UTF-8"

+iommu@lists.linux-foundation.org not iommu-request

On Thu, Mar 3, 2022 at 8:05 PM Gurchetan Singh <gurchetansingh@chromium.org>
wrote:

> Hi everyone,
>
> With the current virtio setup, all of guest memory is shared with host
> devices.  There has been interest in changing this, to improve isolation of
> guest memory and increase confidentiality.
>
> The recently introduced restricted DMA mechanism makes excellent progress
> in this area:
>
>
> https://patchwork.kernel.org/project/xen-devel/cover/20210624155526.2775863-1-tientzu@chromium.org/
>
>
> Devices without an IOMMU (traditional virtio devices for example) would
> allocate from a specially designated region.  Swiotlb bouncing is done for
> all DMA transfers.  This is controlled by the VIRTIO_F_ACCESS_PLATFORM
> feature bit.
>
>
> https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/3064198
>
> This mechanism works great for the devices it was designed for, such as
> virtio-net.  However, when trying to adapt to it for other devices, there
> are some limitations.
>
> It would be great to have a dedicated heap for virtio-gpu rather than
> allocating from guest memory.
>
> We would like to use dma_alloc_noncontiguous on the restricted dma pool,
> ideally with page-level granularity somehow.  Continuous buffers are
> definitely going out of fashion.
>
> There are two considerations when using it with the restricted DMA
> approach:
>
> 1) No bouncing (aka memcpy)
>
> Expensive with graphics buffers, since guest user space would designate
> shareable graphics buffers with the host.  We plan to use
> DMA_ATTR_SKIP_CPU_SYNC when doing any DMA transactions with GPU buffers.
>
> Bounce buffering will be utilized with virtio-cmds, like the other virtio
> devices that use the restricted DMA mechanism.
>
> 2) IO_TLB_SEGSIZE is too small for graphics buffers
>
> This issue was hit before here too:
>
> https://www.spinics.net/lists/kernel/msg4154086.html
>
> The suggestion was to use shared-dma-pool rather than restricted DMA.  But
> we're not sure a single device can have restricted DMA (for
> VIRTIO_F_ACCESS_PLATFORM) and shared-dma-pool (for larger buffers) at the
> same time.  Does anyone know?
>
> If not, it sounds like "splitting the allocation into
> dma_max_mapping_size() chunks" for restricted-dma is also possible.  What
> is the preferred method?
>
> More generally, we would love more feedback on the proposed design or
> consider alternatives!
>

--0000000000004e526405d95ca65e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">+<a class=3D"gmail-rABsFf gmail-RffVmb gm=
ail-AL18ce" target=3D"_blank" href=3D"mailto:iommu@lists.linux-foundation.o=
rg" style=3D"font-size:13px;text-decoration-line:none;color:rgb(60,64,67);o=
verflow:hidden;text-overflow:ellipsis;white-space:nowrap;font-family:Roboto=
,RobotoDraft,Helvetica,Arial,sans-serif">iommu@lists.linux-foundation.org</=
a>=C2=A0not iommu-request<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, Mar 3, 2022 at 8:05 PM Gurchetan Sing=
h &lt;<a href=3D"mailto:gurchetansingh@chromium.org">gurchetansingh@chromiu=
m.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div dir=3D"ltr"><div style=3D"margin:0px;padding:0px 0px 20px;width:7=
84px;font-family:Roboto,RobotoDraft,Helvetica,Arial,sans-serif;font-size:me=
dium"><div><div id=3D"gmail-m_-1460655657268867490gmail-:2op" style=3D"dire=
ction:ltr;margin:8px 0px 0px;padding:0px;font-size:0.875rem"><div id=3D"gma=
il-m_-1460655657268867490gmail-:2nx" style=3D"font-variant-numeric:normal;f=
ont-variant-east-asian:normal;font-stretch:normal;font-size:small;line-heig=
ht:1.5;font-family:Arial,Helvetica,sans-serif;overflow:hidden"><div dir=3D"=
ltr"><div>Hi everyone,</div><div><br></div><div>With the current virtio set=
up, all of guest memory is shared with host devices.=C2=A0 There=C2=A0has b=
een=C2=A0interest in changing this, to improve isolation of guest memory an=
d increase confidentiality.=C2=A0=C2=A0</div><div><br></div><div>The recent=
ly introduced restricted DMA mechanism makes excellent progress in this are=
a:</div><div><br></div><div><div><a href=3D"https://patchwork.kernel.org/pr=
oject/xen-devel/cover/20210624155526.2775863-1-tientzu@chromium.org/" targe=
t=3D"_blank">https://patchwork.kernel.org/project/xen-devel/cover/202106241=
55526.2775863-1-tientzu@chromium.org/</a>=C2=A0=C2=A0</div><div><br></div><=
/div><div>Devices without an IOMMU (traditional virtio devices for example)=
 would allocate from a specially designated region.=C2=A0 Swiotlb bouncing =
is done for all DMA transfers.=C2=A0 This is controlled by the VIRTIO_F_ACC=
ESS_PLATFORM feature bit.</div><div><br></div><div><a href=3D"https://chrom=
ium-review.googlesource.com/c/chromiumos/platform/crosvm/+/3064198" target=
=3D"_blank">https://chromium-review.googlesource.com/c/chromiumos/platform/=
crosvm/+/3064198</a><br></div><div><br></div><div>This mechanism works grea=
t for the devices it was designed for, such as virtio-net.=C2=A0 However, w=
hen trying to adapt to it for other devices, there are some limitations.=C2=
=A0=C2=A0</div><div><br></div><div>It would be great=C2=A0to have a dedicat=
ed heap for virtio-gpu rather than allocating from guest memory.=C2=A0=C2=
=A0</div><div><br></div><div><div>We would like to use dma_alloc_noncontigu=
ous on the restricted dma pool, ideally with page-level granularity somehow=
.=C2=A0 Continuous buffers are definitely going out of fashion.</div></div>=
<div><br></div><div>There are two considerations when using it with the res=
tricted DMA approach:</div><div><br></div><div>1) No bouncing (aka memcpy)<=
/div><div><br></div><div>Expensive with graphics buffers, since guest=C2=A0=
user space would designate shareable graphics buffers with the host.=C2=A0 =
We plan to use DMA_ATTR_SKIP_CPU_SYNC when doing any DMA transactions with =
GPU buffers.</div><div><br></div><div>Bounce buffering will be utilized wit=
h virtio-cmds, like the other virtio devices that use the restricted DMA me=
chanism.</div><div><br></div><div>2) IO_TLB_SEGSIZE is too small for graphi=
cs buffers</div><div><br></div><div>This issue was hit before here too:</di=
v><div><br></div><div><a href=3D"https://www.spinics.net/lists/kernel/msg41=
54086.html" target=3D"_blank">https://www.spinics.net/lists/kernel/msg41540=
86.html</a></div><div><br></div><div>The suggestion was to use shared-dma-p=
ool rather than restricted DMA.=C2=A0 But we&#39;re not sure a single devic=
e can have restricted DMA (for VIRTIO_F_ACCESS_PLATFORM) and shared-dma-poo=
l (for larger buffers) at the same time.=C2=A0 Does anyone know?=C2=A0</div=
><div><br></div><div>If not, it sounds like &quot;splitting the allocation =
into dma_max_mapping_size() chunks&quot; for restricted-dma is also possibl=
e.=C2=A0 What is the preferred method?</div><div><br></div><div>More genera=
lly, we would love more feedback on the proposed design or consider alterna=
tives!</div></div></div></div></div></div></div>
</blockquote></div></div>

--0000000000004e526405d95ca65e--

--===============1271126572620050301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1271126572620050301==--
