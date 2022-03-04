Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52E9C433EF
	for <iommu@archiver.kernel.org>; Fri,  4 Mar 2022 04:57:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A7A860BD9;
	Fri,  4 Mar 2022 04:57:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9BMCaOgEtnmM; Fri,  4 Mar 2022 04:57:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3E62A60D4E;
	Fri,  4 Mar 2022 04:57:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F627C001D;
	Fri,  4 Mar 2022 04:57:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31C4FC000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 04:56:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1888340182
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 04:56:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xAJSNvLd8ft4 for <iommu@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 04:56:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2C4AB40164
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 04:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646369815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tYZUapdRWCJT08rXyjVTAkvzYeSG2bwC+wCu8ZAu0f0=;
 b=UBpX5uUUiU53N2/VX787Lijbn/BrlSuehcpUhTkaeZNcAksB3VPYW9KW0eWAs4A9w74I6+
 B8AD35lRGzxi/BcVwFk5h2ldYo1r2gGgX08w9OWJ69nmEgUbCTH4n+rHLqZbD3a6+EoR1O
 XQO5bdfsmQTVPtjgvWB17ti4uUN9M5E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-LcxVg0DCMyuBFbhCJ0_QGQ-1; Thu, 03 Mar 2022 23:56:53 -0500
X-MC-Unique: LcxVg0DCMyuBFbhCJ0_QGQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 p18-20020adfba92000000b001e8f7697cc7so2917130wrg.20
 for <iommu@lists.linux-foundation.org>; Thu, 03 Mar 2022 20:56:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=tYZUapdRWCJT08rXyjVTAkvzYeSG2bwC+wCu8ZAu0f0=;
 b=fRSk9NcSAzJ4WmoHueT/pfpk/BBsb5wlrG9DbP3X9dhkG9EMi4ZEUKShTmW+z6dIEc
 j9tLeEva/i6XHMu6IFe5FJ0Dy+j9hluINkMPbqyozIkOu0G/e8T3zbn4LFxsfrvO1BoR
 rqKPDao3r6fQkFeqQp52pthy+kQYprGnBukJ8sXvVufxC7G0/Pmh5sWYf0+TIsZl0/To
 taT/VWEDzvFKa/Vl/k+scYssM/mwBxmM2n8J+EarTA53vC1D6Ier0c/SG81p4MlU4Nbb
 vk7kpKNFUhLIIt2Zipa+qYhnRBHO9sh+nb0j5XVdTzRa6arRgbhpzeLtgS6xBKdUUfgM
 U2oQ==
X-Gm-Message-State: AOAM533QxLVMWpAWYz5849gFKPlF2l9HcpCoEacZA1BQVxuwy/6XO0Zv
 gOLam7l790hT+L4aSsDw8Z6+6yyGcHQRqXD6Qvb2zs8orD/Z7KP05nzgMF+v0GmaCtI5kuXnpLH
 71drASrvPKJHzSDBWs0VrWTyBGYJXtg==
X-Received: by 2002:a05:6000:168c:b0:1f0:567b:3cf8 with SMTP id
 y12-20020a056000168c00b001f0567b3cf8mr4201018wrd.46.1646369812266; 
 Thu, 03 Mar 2022 20:56:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWmlImZmlUewursTtuG9a0VfeOnB81lJClVXMkt6n0KTYklCl1tr8ju6EJBGBQrkZhvE6aMQ==
X-Received: by 2002:a05:6000:168c:b0:1f0:567b:3cf8 with SMTP id
 y12-20020a056000168c00b001f0567b3cf8mr4201009wrd.46.1646369811967; 
 Thu, 03 Mar 2022 20:56:51 -0800 (PST)
Received: from redhat.com ([2.53.6.39]) by smtp.gmail.com with ESMTPSA id
 s17-20020adfdb11000000b001f02d5fea43sm3869294wri.98.2022.03.03.20.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Mar 2022 20:56:51 -0800 (PST)
Date: Thu, 3 Mar 2022 23:56:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gurchetan Singh <gurchetansingh@google.com>
Subject: Re: virtio-gpu dedicated heap
Message-ID: <20220303235527-mutt-send-email-mst@kernel.org>
References: <CAAfnVBmDf1fA1ZAufPsPhyOWj0=ynGCVfzX_Cx=pgVmkXe8Tog@mail.gmail.com>
 <CAAfnVBmCUHKRUVA=UouoSUH-eTyTTpNReU6i8TSD94iyYWyQzg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAfnVBmCUHKRUVA=UouoSUH-eTyTTpNReU6i8TSD94iyYWyQzg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtio-dev@lists.oasis-open.org, Claire Chang <tientzu@google.com>,
 peterz@infradead.org, will@kernel.org, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com, hch@lst.de
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

$ ./scripts/get_maintainer.pl -f ./drivers/gpu/drm/virtio/

David Airlie <airlied@linux.ie> (maintainer:VIRTIO GPU DRIVER)
Gerd Hoffmann <kraxel@redhat.com> (maintainer:VIRTIO GPU DRIVER)
Daniel Vetter <daniel@ffwll.ch> (maintainer:DRM DRIVERS)
dri-devel@lists.freedesktop.org (open list:VIRTIO GPU DRIVER)
virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER)
linux-kernel@vger.kernel.org (open list)

You might want to CC these people.

On Thu, Mar 03, 2022 at 08:07:03PM -0800, Gurchetan Singh wrote:
> +iommu@lists.linux-foundation.org=A0not iommu-request
> =

> On Thu, Mar 3, 2022 at 8:05 PM Gurchetan Singh <gurchetansingh@chromium.o=
rg>
> wrote:
> =

>     Hi everyone,
> =

>     With the current virtio setup, all of guest memory is shared with host
>     devices.=A0 There=A0has been=A0interest in changing this, to improve =
isolation of
>     guest memory and increase confidentiality.=A0=A0
> =

>     The recently introduced restricted DMA mechanism makes excellent prog=
ress
>     in this area:
> =

>     https://patchwork.kernel.org/project/xen-devel/cover/
>     20210624155526.2775863-1-tientzu@chromium.org/=A0=A0
> =

>     Devices without an IOMMU (traditional virtio devices for example) wou=
ld
>     allocate from a specially designated region.=A0 Swiotlb bouncing is d=
one for
>     all DMA transfers.=A0 This is controlled by the VIRTIO_F_ACCESS_PLATF=
ORM
>     feature bit.
> =

>     https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm=
/+/
>     3064198
> =

>     This mechanism works great for the devices it was designed for, such =
as
>     virtio-net.=A0 However, when trying to adapt to it for other devices,=
 there
>     are some limitations.=A0=A0
> =

>     It would be great=A0to have a dedicated heap for virtio-gpu rather th=
an
>     allocating from guest memory.=A0=A0
> =

>     We would like to use dma_alloc_noncontiguous on the restricted dma po=
ol,
>     ideally with page-level granularity somehow.=A0 Continuous buffers are
>     definitely going out of fashion.
> =

>     There are two considerations when using it with the restricted DMA
>     approach:
> =

>     1) No bouncing (aka memcpy)
> =

>     Expensive with graphics buffers, since guest=A0user space would desig=
nate
>     shareable graphics buffers with the host.=A0 We plan to use
>     DMA_ATTR_SKIP_CPU_SYNC when doing any DMA transactions with GPU buffe=
rs.
> =

>     Bounce buffering will be utilized with virtio-cmds, like the other vi=
rtio
>     devices that use the restricted DMA mechanism.
> =

>     2) IO_TLB_SEGSIZE is too small for graphics buffers
> =

>     This issue was hit before here too:
> =

>     https://www.spinics.net/lists/kernel/msg4154086.html
> =

>     The suggestion was to use shared-dma-pool rather than restricted DMA.=
=A0 But
>     we're not sure a single device can have restricted DMA (for
>     VIRTIO_F_ACCESS_PLATFORM) and shared-dma-pool (for larger buffers) at=
 the
>     same time.=A0 Does anyone know?=A0
> =

>     If not, it sounds like "splitting the allocation into dma_max_mapping=
_size
>     () chunks" for restricted-dma is also possible.=A0 What is the prefer=
red
>     method?
> =

>     More generally, we would love more feedback on the proposed design or
>     consider alternatives!
> =


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
