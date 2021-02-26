Return-Path: <SRS0=CXUA=H4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D392C433E6
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 21:30:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFA4564F2D
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 21:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA4564F2D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pensando.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 527B14F0C5;
	Fri, 26 Feb 2021 21:30:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o0j0T7WVXKFf; Fri, 26 Feb 2021 21:30:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2CA2E4F0C7;
	Fri, 26 Feb 2021 21:30:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7411C0013;
	Fri, 26 Feb 2021 21:30:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2AF86C0001
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 21:25:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 03A9C4F0A7
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 21:25:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K-MsKfcpdVqR for <iommu@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 21:24:58 +0000 (UTC)
X-Greylist: delayed 00:06:32 by SQLgrey-1.8.0
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
 [209.85.208.181])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7CE1C4F08E
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 21:24:58 +0000 (UTC)
Received: by mail-lj1-f181.google.com with SMTP id h4so12022122ljl.0
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 13:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pensando.io; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AIlvTHHpn35EI5lUaE3JSLd1JA7V4jwbW3KJzgxboj0=;
 b=CL/9Ckh30gg4otq/URfvfaXbHbLE/LPJyraA5jZWiWSM4/SfVt1sEm1+FRWKus5KcS
 vpgPEC1fLYWS8ky8A0tL/KOG32ZiELRdv+7nVtK0djkchUV/woQouvZSyKXLCcub0SkD
 d1+/EL//YoumAcsts46Ja8vFQw9MApvSpiGDUa/7rNakkO7q77XIGU7EpFIoPVBGbLys
 AKl+h9qVOkvFLDTVvP2Rj/LwLUFvWeBJj79C/ND9VeON1migOnj1AxeNDIRqyNQKZ6F+
 uUdmli5+9pHoBnwAADYCPTqE4VbXi0DOs1tTB1z7QJZu8tKXg4XNyuvuS+z7J6Za0oUL
 PmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AIlvTHHpn35EI5lUaE3JSLd1JA7V4jwbW3KJzgxboj0=;
 b=XW4HMm7TWjpLqT2dIPbg26eFUQKbzAVdV6ocRV1jZxGdI7aYK9hjyDaKu2pZ5+NDlN
 UeGn2X9hL0xDHPSH6VIC+4GlY76wbh5JxAq3DHtIvBkp1qTBqYFMJtzNEm2T7As02hCC
 fdqstqQgBm7GOUlA4U1InoQnhF9KOLPTZmjHRgiGEzdNXcKpl884gi5ZOva95r9TE4Q5
 pN/o0BExZzM5kYP++GBBm/8a2+TUKIbdcxvzD24XBAoZ7rrbjHzAbNuZ3rBH6lBOpDHm
 6PHVuiERWm9dHxWiuQXIbztWarX+fmtwrQgwCfs01Uk89qA7/6tN8HhFGxeNVuidsVBR
 3PNQ==
X-Gm-Message-State: AOAM532qphjj1SA9ajBgcP5Tj2vsBR2Ue9B6x+C+nj465oAXKepUgUzp
 FdoNHq367LaXiQzruoxqS48utXFR/lJZKgr5A8/9eMnVGsKINwuS
X-Google-Smtp-Source: ABdhPJye4nfcx7ZLYWWXQ8YiFhkYgVs3dxQM2J4Uab0peBJzm47EBk3KY1eC1CC+YjV1G79TH6+BIl8R9G4/lgVqPhg=
X-Received: by 2002:a05:6402:17d5:: with SMTP id
 s21mr3937386edy.65.1614374304784; 
 Fri, 26 Feb 2021 13:18:24 -0800 (PST)
MIME-Version: 1.0
References: <20210226204307.50413-1-brad@pensando.io>
 <YDlhZDgsAZ2j0b1z@Konrads-MacBook-Pro.local>
In-Reply-To: <YDlhZDgsAZ2j0b1z@Konrads-MacBook-Pro.local>
From: Brad Larson <brad@pensando.io>
Date: Fri, 26 Feb 2021 13:18:14 -0800
Message-ID: <CAK9rFnytTUHFHMshini8Pngfw2tGxuVhtNj2bmqeosOr_ZpQGQ@mail.gmail.com>
Subject: Re: [PATCH] swiotlb: swiotlb_tbl_map_single() kernel BUG in
 iommu-helper.h:30
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
X-Mailman-Approved-At: Fri, 26 Feb 2021 21:30:03 +0000
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, hch@lst.de
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
Content-Type: multipart/mixed; boundary="===============3715827895175373106=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============3715827895175373106==
Content-Type: multipart/alternative; boundary="000000000000f8b0a205bc43ce5b"

--000000000000f8b0a205bc43ce5b
Content-Type: text/plain; charset="UTF-8"

>
> On Fri, Feb 26, 2021 at 12:43:07PM -0800, Brad Larson wrote:
> > Kernel Oops introduced in next-20210222 due to get_max_slots return arg
> size.
> > In the function find_slots() variable max_slots is zero when
> boundary_mask is
> > 0xffffffffffffffff.
>
> I am looking at the stable/for-linus-5.12 and what I sent out for
> a GIT PULL and I believe this is already squashed in:
>
> 531 static int find_slots(struct device *dev, phys_addr_t orig_addr,
>
> 532                 size_t alloc_size)
>
> 533 {
>
> 534         unsigned long boundary_mask = dma_get_seg_boundary(dev);
>
> 535         dma_addr_t tbl_dma_addr =
>
> 536                 phys_to_dma_unencrypted(dev, io_tlb_start) &
> boundary_mask;
> 537         unsigned long max_slots = get_max_slots(boundary_mask);
>
> Could you double-check please?
>

Yes this is squashed in the snippet you are showing.  The bug was
introduced in
next-20210222 and is still there when I updated to next-20210226 today.


On Fri, Feb 26, 2021 at 1:00 PM Konrad Rzeszutek Wilk <
konrad.wilk@oracle.com> wrote:

> On Fri, Feb 26, 2021 at 12:43:07PM -0800, Brad Larson wrote:
> > Kernel Oops introduced in next-20210222 due to get_max_slots return arg
> size.
> > In the function find_slots() variable max_slots is zero when
> boundary_mask is
> > 0xffffffffffffffff.
>
> I am looking at the stable/for-linus-5.12 and what I sent out for
> a GIT PULL and I believe this is already squashed in:
>
> 531 static int find_slots(struct device *dev, phys_addr_t orig_addr,
>
> 532                 size_t alloc_size)
>
> 533 {
>
> 534         unsigned long boundary_mask = dma_get_seg_boundary(dev);
>
> 535         dma_addr_t tbl_dma_addr =
>
> 536                 phys_to_dma_unencrypted(dev, io_tlb_start) &
> boundary_mask;
> 537         unsigned long max_slots = get_max_slots(boundary_mask);
>
> Could you double-check please?
>
> >
> > [    0.242119] kernel BUG at ./include/linux/iommu-helper.h:30!
> > [    0.247793] Internal error: Oops - BUG: 0 [#1] SMP
> > [    0.252595] Modules linked in:
> > [    0.255657] CPU: 0 PID: 93 Comm: kworker/0:1 Not tainted
> 5.11.0-next-20210224+ #25
> > [    0.263245] Hardware name: Elba ASIC Board (DT)
> > [    0.267784] Workqueue: events_freezable mmc_rescan
> > [    0.272592] pstate: 60000085 (nZCv daIf -PAN -UAO -TCO BTYPE=--)
> > [    0.278612] pc : swiotlb_tbl_map_single+0x2b0/0x6a0
> > [    0.283505] lr : swiotlb_tbl_map_single+0x440/0x6a0
> > [    0.288395] sp : ffffffc0122736b0
> > [    0.291713] x29: ffffffc0122736b0 x28: ffffffc010e30000
> > [    0.297039] x27: 00000000bbf58000 x26: 0000000000000000
> > [    0.302364] x25: 0000000000000000 x24: 0000000000000001
> > [    0.307689] x23: 0000000000000000 x22: 0000000000000000
> > [    0.313013] x21: 0000000000000000 x20: 0000000000000000
> > [    0.318338] x19: 0000001241fd4600 x18: ffffffc010d288c8
> > [    0.323662] x17: 0000000000000007 x16: 0000000000000001
> > [    0.328987] x15: ffffffc092273367 x14: 3a424c54204f4920
> > [    0.334311] x13: 6572617774666f73 x12: 20726e2030207865
> > [    0.339636] x11: 646e692078787820 x10: 3062653737317830
> > [    0.344960] x9 : 2074666968732031 x8 : ffffff977cf82368
> > [    0.350285] x7 : 0000000000000001 x6 : c0000000ffffefff
> > [    0.355609] x5 : 0000000000017fe8 x4 : 0000000000000000
> > [    0.360934] x3 : 0000000000000000 x2 : 18b0d50da009d000
> > [    0.366258] x1 : 0000000000000000 x0 : 0000000000000042
> > [    0.371583] Call trace:
> > [    0.374032]  swiotlb_tbl_map_single+0x2b0/0x6a0
> > [    0.378573]  swiotlb_map+0xa8/0x2b0
> >
> > Signed-off-by: Brad Larson <brad@pensando.io>
> > ---
> >  kernel/dma/swiotlb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index 369e4c3a0f2b..c10e855a03bc 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -534,7 +534,7 @@ static int find_slots(struct device *dev,
> phys_addr_t orig_addr,
> >       unsigned long boundary_mask = dma_get_seg_boundary(dev);
> >       dma_addr_t tbl_dma_addr =
> >               phys_to_dma_unencrypted(dev, io_tlb_start) & boundary_mask;
> > -     unsigned int max_slots = get_max_slots(boundary_mask);
> > +     unsigned long max_slots = get_max_slots(boundary_mask);
> >       unsigned int iotlb_align_mask =
> >               dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
> >       unsigned int nslots = nr_slots(alloc_size), stride;
> > --
> > 2.17.1
> >
>

--000000000000f8b0a205bc43ce5b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-wi=
dth:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-=
left:1ex"><span class=3D"gmail-im">On Fri, Feb 26, 2021 at 12:43:07PM -0800=
, Brad Larson wrote:<br>&gt; Kernel Oops introduced in next-20210222 due to=
 get_max_slots return arg size.<br>&gt; In the function find_slots() variab=
le max_slots is zero when boundary_mask is<br>&gt; 0xffffffffffffffff.<br><=
br></span>I am looking at the stable/for-linus-5.12 and what I sent out for=
<br>a GIT PULL and I believe this is already squashed in:<br><br>531 static=
 int find_slots(struct device *dev, phys_addr_t orig_addr,=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0<br>532=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t alloc_size)=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=
<br>533 {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>534=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long boundary_mask =3D dma_get_s=
eg_boundary(dev);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=
=A0<br>535=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_addr_t tbl_dma_addr =3D=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0<br>536=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0phys_to_dma_unencrypted(dev, io_tlb_start) &amp; boundary_mask=
;=C2=A0 =C2=A0 =C2=A0<br>537=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long=
 max_slots =3D get_max_slots(boundary_mask);<br><br>Could you double-check =
please?<br></blockquote><div>=C2=A0</div><div>Yes this is squashed in the s=
nippet you are showing.=C2=A0 The bug was introduced in</div><div><font fac=
e=3D"arial, sans-serif"><span style=3D"color:rgb(0,0,0)">next-20210222 and =
is still there when I updated to=C2=A0</span><span style=3D"color:rgb(0,0,0=
)">next-20210226 today.</span>=C2=A0</font></div><br></div></div></div></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On F=
ri, Feb 26, 2021 at 1:00 PM Konrad Rzeszutek Wilk &lt;<a href=3D"mailto:kon=
rad.wilk@oracle.com">konrad.wilk@oracle.com</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-wi=
dth:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-=
left:1ex">On Fri, Feb 26, 2021 at 12:43:07PM -0800, Brad Larson wrote:<br>
&gt; Kernel Oops introduced in next-20210222 due to get_max_slots return ar=
g size.<br>
&gt; In the function find_slots() variable max_slots is zero when boundary_=
mask is<br>
&gt; 0xffffffffffffffff.<br>
<br>
I am looking at the stable/for-linus-5.12 and what I sent out for<br>
a GIT PULL and I believe this is already squashed in:<br>
<br>
531 static int find_slots(struct device *dev, phys_addr_t orig_addr,=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
532=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t all=
oc_size)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 <br>
533 {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
534=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long boundary_mask =3D dma_ge=
t_seg_boundary(dev);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 <br>
535=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_addr_t tbl_dma_addr =3D=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0<br>
536=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys_to_dm=
a_unencrypted(dev, io_tlb_start) &amp; boundary_mask;=C2=A0 =C2=A0 =C2=A0<b=
r>
537=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long max_slots =3D get_max_sl=
ots(boundary_mask);<br>
<br>
Could you double-check please?<br>
<br>
&gt; <br>
&gt; [=C2=A0 =C2=A0 0.242119] kernel BUG at ./include/linux/iommu-helper.h:=
30!<br>
&gt; [=C2=A0 =C2=A0 0.247793] Internal error: Oops - BUG: 0 [#1] SMP<br>
&gt; [=C2=A0 =C2=A0 0.252595] Modules linked in:<br>
&gt; [=C2=A0 =C2=A0 0.255657] CPU: 0 PID: 93 Comm: kworker/0:1 Not tainted =
5.11.0-next-20210224+ #25<br>
&gt; [=C2=A0 =C2=A0 0.263245] Hardware name: Elba ASIC Board (DT)<br>
&gt; [=C2=A0 =C2=A0 0.267784] Workqueue: events_freezable mmc_rescan<br>
&gt; [=C2=A0 =C2=A0 0.272592] pstate: 60000085 (nZCv daIf -PAN -UAO -TCO BT=
YPE=3D--)<br>
&gt; [=C2=A0 =C2=A0 0.278612] pc : swiotlb_tbl_map_single+0x2b0/0x6a0<br>
&gt; [=C2=A0 =C2=A0 0.283505] lr : swiotlb_tbl_map_single+0x440/0x6a0<br>
&gt; [=C2=A0 =C2=A0 0.288395] sp : ffffffc0122736b0<br>
&gt; [=C2=A0 =C2=A0 0.291713] x29: ffffffc0122736b0 x28: ffffffc010e30000<b=
r>
&gt; [=C2=A0 =C2=A0 0.297039] x27: 00000000bbf58000 x26: 0000000000000000<b=
r>
&gt; [=C2=A0 =C2=A0 0.302364] x25: 0000000000000000 x24: 0000000000000001<b=
r>
&gt; [=C2=A0 =C2=A0 0.307689] x23: 0000000000000000 x22: 0000000000000000<b=
r>
&gt; [=C2=A0 =C2=A0 0.313013] x21: 0000000000000000 x20: 0000000000000000<b=
r>
&gt; [=C2=A0 =C2=A0 0.318338] x19: 0000001241fd4600 x18: ffffffc010d288c8<b=
r>
&gt; [=C2=A0 =C2=A0 0.323662] x17: 0000000000000007 x16: 0000000000000001<b=
r>
&gt; [=C2=A0 =C2=A0 0.328987] x15: ffffffc092273367 x14: 3a424c54204f4920<b=
r>
&gt; [=C2=A0 =C2=A0 0.334311] x13: 6572617774666f73 x12: 20726e2030207865<b=
r>
&gt; [=C2=A0 =C2=A0 0.339636] x11: 646e692078787820 x10: 3062653737317830<b=
r>
&gt; [=C2=A0 =C2=A0 0.344960] x9 : 2074666968732031 x8 : ffffff977cf82368<b=
r>
&gt; [=C2=A0 =C2=A0 0.350285] x7 : 0000000000000001 x6 : c0000000ffffefff<b=
r>
&gt; [=C2=A0 =C2=A0 0.355609] x5 : 0000000000017fe8 x4 : 0000000000000000<b=
r>
&gt; [=C2=A0 =C2=A0 0.360934] x3 : 0000000000000000 x2 : 18b0d50da009d000<b=
r>
&gt; [=C2=A0 =C2=A0 0.366258] x1 : 0000000000000000 x0 : 0000000000000042<b=
r>
&gt; [=C2=A0 =C2=A0 0.371583] Call trace:<br>
&gt; [=C2=A0 =C2=A0 0.374032]=C2=A0 swiotlb_tbl_map_single+0x2b0/0x6a0<br>
&gt; [=C2=A0 =C2=A0 0.378573]=C2=A0 swiotlb_map+0xa8/0x2b0<br>
&gt; <br>
&gt; Signed-off-by: Brad Larson &lt;<a href=3D"mailto:brad@pensando.io" tar=
get=3D"_blank">brad@pensando.io</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 kernel/dma/swiotlb.c | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c<br>
&gt; index 369e4c3a0f2b..c10e855a03bc 100644<br>
&gt; --- a/kernel/dma/swiotlb.c<br>
&gt; +++ b/kernel/dma/swiotlb.c<br>
&gt; @@ -534,7 +534,7 @@ static int find_slots(struct device *dev, phys_add=
r_t orig_addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long boundary_mask =3D dma_get_seg_=
boundary(dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dma_addr_t tbl_dma_addr =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys_to_dma_unen=
crypted(dev, io_tlb_start) &amp; boundary_mask;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0unsigned int max_slots =3D get_max_slots(boundary=
_mask);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned long max_slots =3D get_max_slots(boundar=
y_mask);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int iotlb_align_mask =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_get_min_alig=
n_mask(dev) &amp; ~(IO_TLB_SIZE - 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int nslots =3D nr_slots(alloc_size)=
, stride;<br>
&gt; -- <br>
&gt; 2.17.1<br>
&gt; <br>
</blockquote></div>

--000000000000f8b0a205bc43ce5b--

--===============3715827895175373106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3715827895175373106==--
