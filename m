Return-Path: <SRS0=OQvg=FN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA25EC4361B
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 15:21:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FC2923AAC
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 15:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC2923AAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C033487A4B;
	Wed,  9 Dec 2020 15:21:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lbsJ8ii5RF5x; Wed,  9 Dec 2020 15:21:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F129F87A2B;
	Wed,  9 Dec 2020 15:21:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8F51C0893;
	Wed,  9 Dec 2020 15:21:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 397F6C013B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Dec 2020 06:45:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3493787ACE
 for <iommu@lists.linux-foundation.org>; Tue,  8 Dec 2020 06:45:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dBlxcyeURbRT for <iommu@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 06:45:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com
 [209.85.166.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7502887AC2
 for <iommu@lists.linux-foundation.org>; Tue,  8 Dec 2020 06:45:42 +0000 (UTC)
Received: by mail-io1-f66.google.com with SMTP id p187so15920998iod.4
 for <iommu@lists.linux-foundation.org>; Mon, 07 Dec 2020 22:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rL+wsfeGY2xDh+eJecj0/Gh1nF+19yExPVK7v/8qFIE=;
 b=gHQYkqd3gUpNiE3eFTHhEY1QZosGBKPzz1G2wSesgr7IGUX137cklLEbo0JhMWEXj/
 Hy8fUorKiyGsl3oUbQjfHgecDty1jczRUDnbj0D0giPCKkZyH1u7Eny23TYnNGSp7SD+
 OZ/N2fhFQ6ERSQIqcnt6aKZncMgTM8oaofsRAO+MXdbjtud+Pdv3xcHMxJiCdoGlbVJE
 GgYdlA3DgrT1c3weQZcrZ4IdK12xoGcKdXg6R+uK8z3rhFFffHT+PYzDZ5vEgpI/WYCo
 eIUS1Dh3j2bEHulhuB7D6d402Aeyr+WuahtL7zNnxTN88GRuLoe5g8qgvrWPxXWltwwz
 0g0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rL+wsfeGY2xDh+eJecj0/Gh1nF+19yExPVK7v/8qFIE=;
 b=U4G9J6JG/EjQiQfbE6MYp9xEgVrLNN6q3Cj0pWpq6bByORSOYk34ky48QhEt/ot3EC
 pkzuIV54BSqlvNygn8+CCN16iCng3doow3shuOuon77Puua8OZmgyr6KFSnXB1AirXTC
 nUO7UGsWc26VpWIgI0ZWaHr9+DmETGSoGxgP9MCoJI+EjWj8g/dQSGb1MyzRBlhDmR7m
 QgdRbWQ4r+bbeSaLJlV2DLMU+AveK0T17OaHGSjDjNcC/kH8dKcwdGe+vVX2GwD6beXr
 z6KQ9nSbouz20AES59zhZCINBtJYMhwn5Aeu35mta/QYGN2W/B3xPpG7ABUe3vZ7I177
 r+yg==
X-Gm-Message-State: AOAM530iAzxxMpSCGRITOzz69kQT7UPDNoxgmFAoeXv3l+2I9S77s7Uz
 HhLFRrOiv5horkV2DRQS3zT13Z1qoQQbCMigqsZ0Hw==
X-Google-Smtp-Source: ABdhPJy9yv69fikO0FgVWJSIfA3iHtF7Z+gC1ugnKkndIs2+bA2lGUHDGuzIu0DqIxf1yXjNxUl4lpajogqbIsxQC5c=
X-Received: by 2002:a02:b709:: with SMTP id g9mr25410086jam.90.1607409941575; 
 Mon, 07 Dec 2020 22:45:41 -0800 (PST)
MIME-Version: 1.0
References: <20201125221917.150463-1-ribalda@chromium.org>
 <20201130083410.GD32234@lst.de>
 <20201201033658.GE3723071@google.com> <20201201144916.GA14682@lst.de>
 <CAAFQd5BBEbmENrrZ-vMK9cKOap19XWmfcxwrxKfjWx-wEew8rg@mail.gmail.com>
In-Reply-To: <CAAFQd5BBEbmENrrZ-vMK9cKOap19XWmfcxwrxKfjWx-wEew8rg@mail.gmail.com>
Date: Tue, 8 Dec 2020 15:45:25 +0900
Message-ID: <CAME7YmOEi6FUzpAeaM5VitiLzL6oRnbfD04NPwd0Fa-U48t7=g@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] media: uvcvideo: Use dma_alloc_noncontiguos API
To: Tomasz Figa <tfiga@chromium.org>
X-Mailman-Approved-At: Wed, 09 Dec 2020 15:21:50 +0000
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Ricardo Ribalda <ribalda@chromium.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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
From: Sergey Senozhatsky via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sergey Senozhatsky <senozhatsky@google.com>
Content-Type: multipart/mixed; boundary="===============1666694484821333903=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============1666694484821333903==
Content-Type: multipart/alternative; boundary="00000000000093eb2605b5ee4ab3"

--00000000000093eb2605b5ee4ab3
Content-Type: text/plain; charset="UTF-8"

On Tue, Dec 8, 2020 at 1:54 PM Tomasz Figa <tfiga@chromium.org> wrote:

>
> In any case, Sergey is going to share a preliminary patch on how the
> current API would be used in the V4L2 videobuf2 framework. That should
> give us more input on how such a helper could look.
>


My current WIP (deep WIP) series can be found at [0]. The patch that adds
new
DMA API support is at the head of the series [1]. New DMA API requires us to
have several internal videobuf2 API changes before we can proceed [2]: v4l2
and
videobuf2 core do not pass enough information to the vb2 allocators now.
Previously,
if user space requests non-coherent allocation v4l2 would set queue
dma_attr bit,
videobuf2 core would pass queue->dma_attrs to vb2 allocator, which would
those dma_attrs for dma_alloc(). So everything was transparent (sort of).
Since we
don't have that dma_attr flag anymore, there is no way for v4l2 to pass the
request
information (coherent or non-coherent) to the vb2 allocator. Hence we need
to rework
the vb2 allocator API. I currently pass vb2 pointer, but we decided to
rework it again
and to pass dedicated VB2_ALLOC_FLAGS from the videobuf2 core to the
allocator. This is still in my private tree and not completely ready, will
push those
patches to github later.

Another thing to notice is that the new API requires us to have two
execution branches
in allocators - one for the current API; and one for the new API (if it's
supported and
if user-space requested non-coherent allocation).

[0] https://github.com/sergey-senozhatsky/linux-next-ss/commits/master
[1]
https://github.com/sergey-senozhatsky/linux-next-ss/commit/a45f48b483daee59594c62e4aaf01790aab960c8
[2]
https://github.com/sergey-senozhatsky/linux-next-ss/commit/b784145101c398da7fe9e2608b6001e58e05a9b5

-ss

--00000000000093eb2605b5ee4ab3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Tue, Dec 8, 2020 at 1:54 PM Tomasz Fig=
a &lt;<a href=3D"mailto:tfiga@chromium.org">tfiga@chromium.org</a>&gt; wrot=
e:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex"><br>In any case, Sergey is going to share a preliminary patch=
 on how the<br>
current API would be used in the V4L2 videobuf2 framework. That should<br>
give us more input on how such a helper could look.<br></blockquote><div>=
=C2=A0</div><div><br></div><div>My current WIP (deep WIP) series can be fou=
nd at [0]. The patch that adds new</div><div>DMA API support is at the head=
 of the series [1]. New DMA API requires us to</div><div>have several inter=
nal videobuf2 API changes before we can proceed [2]: v4l2 and</div><div>vid=
eobuf2 core do not pass enough information to the vb2 allocators now. Previ=
ously,</div><div>if user space requests non-coherent allocation v4l2 would =
set queue dma_attr bit,</div><div>videobuf2 core would pass queue-&gt;dma_a=
ttrs to vb2 allocator, which would=C2=A0</div><div>those dma_attrs for dma_=
alloc(). So everything was transparent=C2=A0(sort of). Since we</div><div>d=
on&#39;t have that dma_attr flag anymore, there is no way for v4l2 to pass =
the request</div><div>information (coherent or non-coherent) to the vb2 all=
ocator. Hence we need to rework</div><div>the vb2 allocator API. I currentl=
y pass vb2 pointer, but we decided to rework it again</div><div>and to pass=
 dedicated VB2_ALLOC_FLAGS from the videobuf2 core to the=C2=A0</div><div>a=
llocator. This is still in my private tree and not completely ready, will p=
ush those</div><div>patches to github later.</div><div><br></div><div>Anoth=
er thing to notice is that the new API requires us to have two execution br=
anches</div><div>in allocators - one for the current API; and one for the n=
ew API (if it&#39;s supported and</div><div>if user-space requested non-coh=
erent allocation).</div><div><br></div><div>[0]=C2=A0<a href=3D"https://git=
hub.com/sergey-senozhatsky/linux-next-ss/commits/master">https://github.com=
/sergey-senozhatsky/linux-next-ss/commits/master</a></div><div>[1]=C2=A0<a =
href=3D"https://github.com/sergey-senozhatsky/linux-next-ss/commit/a45f48b4=
83daee59594c62e4aaf01790aab960c8">https://github.com/sergey-senozhatsky/lin=
ux-next-ss/commit/a45f48b483daee59594c62e4aaf01790aab960c8</a></div><div>[2=
]=C2=A0<a href=3D"https://github.com/sergey-senozhatsky/linux-next-ss/commi=
t/b784145101c398da7fe9e2608b6001e58e05a9b5">https://github.com/sergey-senoz=
hatsky/linux-next-ss/commit/b784145101c398da7fe9e2608b6001e58e05a9b5</a></d=
iv><div><br></div><div>-ss</div></div></div>

--00000000000093eb2605b5ee4ab3--

--===============1666694484821333903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1666694484821333903==--
