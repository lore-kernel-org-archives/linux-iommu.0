Return-Path: <SRS0=smho=GI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE8BC433DB
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 19:07:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B91422D6F
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 19:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B91422D6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DDA9D203F3;
	Tue,  5 Jan 2021 19:07:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SJl-9o5EL6-N; Tue,  5 Jan 2021 19:07:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BC14820353;
	Tue,  5 Jan 2021 19:07:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1556C0891;
	Tue,  5 Jan 2021 19:07:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74F3FC013A
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 19:07:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5F45C203F3
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 19:07:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id auR1UqYKxPcw for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 19:07:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44])
 by silver.osuosl.org (Postfix) with ESMTPS id E797920353
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 19:07:15 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id j12so713753ota.7
 for <iommu@lists.linux-foundation.org>; Tue, 05 Jan 2021 11:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/PG1QCX34vETNdx9wglxp4v/B7XzPRZVQkE05OdAi1k=;
 b=JJsyTgdumJzuqlQMBhaBlQ/rxjB9uA7enIhVC+gGLU/QudKJMzXRwdX/aeeMRjCPd+
 aKn7LRFBY6r9H7xSbjZAeVq3bi8UCyIvoDgxqAWjul5dRF0ywHvLI0t73l8As665htEu
 OnLhjOkcNeouXBhOxN/x5aKsB5Of0hwz2HAjH5GEx4qoVHsNTrkUBvf5fOrXaFMq6kXE
 NlMT0PCdVZSKVaKxTUD7olki78B24UcfwZdrSOYd4g4vN+KQW0dTtNIe0ytghgquQnrr
 68flepwPCQidR2ezPLFW8K0isvRmy4OC8fpRomFnhdcHHaJt7jjbHBWfpr4VGu6wYP2V
 4Opw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/PG1QCX34vETNdx9wglxp4v/B7XzPRZVQkE05OdAi1k=;
 b=DWJx0rfnvwghCQjWU+e3CrVhlZp7eigQsKj6pKPrO1jAoeeDdhown0j6pEMgQwkb5J
 YCnjlGrS3pWpNKuvUn1ZLjIo1HfJ8Jzg7x/xAYXjaKwJ/uPnGheWt+P7Pcribzfh0qU2
 temsFsJpnNt6qmiKkN6IE24OPQgraD3Hq8fBQTZvXDhMNEZrBgib5WnQ4jvU80adi+2D
 YugQhICy5e3SVKE1JwtDvEUvyhNrnQPZmEX7m7umFRk3mqO7ss/GgEK6o1c8FYZuSDIP
 KV9lE9GYDTd5S9bLYrCjsgGe0ukZNT0LctD9NTfnLhvKNbgu48zTXHFfsmWfrg2defpB
 cUiw==
X-Gm-Message-State: AOAM532ae5QaRXIpLUlZ1eK8gi6yWf5ban7yx2mfGIU2inMRh4LYw8Sk
 EdN17Ycra+AxAibaofN7XCZKCch7K9zsXmmPh8rXGg==
X-Google-Smtp-Source: ABdhPJyVvQgr7p1kxRwov1VN/7/u7grkuT3s52k80+bYx00IfpCB5aJlgIZih/HhVcsahvB80Vd2ekzsZygTyfUic2w=
X-Received: by 2002:a9d:3e85:: with SMTP id b5mr734903otc.8.1609873634890;
 Tue, 05 Jan 2021 11:07:14 -0800 (PST)
MIME-Version: 1.0
References: <20201207214204.1839028-1-jxgao@google.com>
 <20201211203938.GA16598@char.us.oracle.com>
In-Reply-To: <20201211203938.GA16598@char.us.oracle.com>
Date: Tue, 5 Jan 2021 11:07:03 -0800
Message-ID: <CAMGD6P3nWB_QgLsUXUBV_CKn3frbug08eaxw+f7ffLmZWKLU7w@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] Keep offset when mapping data via SWIOTLB.
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, iommu@lists.linux-foundation.org,
 David Rientjes <rientjes@google.com>, kbusch@kernel.org, robin.murphy@arm.com,
 hch@lst.de
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
From: Jianxiong Gao via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jianxiong Gao <jxgao@google.com>
Content-Type: multipart/mixed; boundary="===============2771495294403062592=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============2771495294403062592==
Content-Type: multipart/alternative; boundary="00000000000024929105b82bea31"

--00000000000024929105b82bea31
Content-Type: text/plain; charset="UTF-8"

Hi Konrad,

Thanks for testing it out. I have updated the patch and tested
on 5.11.0-rc2+ with dhclient successfully. Could you please help me verify
if the patch works on your side?

Thank you

NVMe driver and other applications depend on the data offset
to operate correctly. Currently when unaligned data is mapped via
SWIOTLB, the data is mapped as slab aligned with the SWIOTLB. When
booting with --swiotlb=force option and using NVMe as interface,
running mkfs.xfs on Rhel fails because of the unalignment issue.
This patch makes sure the mapped data preserves
its offset of the orginal address. Tested on latest kernel that
this patch fixes the issue.

Signed-off-by: Jianxiong Gao <jxgao@google.com>
Acked-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/swiotlb.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 781b9dca197c..56a35e71b3fd 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -483,6 +483,12 @@ phys_addr_t swiotlb_tbl_map_single(struct device
*hwdev, phys_addr_t orig_addr,
        max_slots = mask + 1
                    ? ALIGN(mask + 1, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT
                    : 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
+
+       /*
+        * We need to keep the offset when mapping, so adding the offset
+        * to the total set we need to allocate in SWIOTLB
+        */
+       alloc_size += offset_in_page(orig_addr);

        /*
         * For mappings greater than or equal to a page, we limit the stride
@@ -567,6 +573,11 @@ phys_addr_t swiotlb_tbl_map_single(struct device
*hwdev, phys_addr_t orig_addr,
         */
        for (i = 0; i < nslots; i++)
                io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
+       /*
+        * When keeping the offset of the original data, we need to advance
+        * the tlb_addr by the offset of orig_addr.
+        */
+       tlb_addr += offset_in_page(orig_addr);
        if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
            (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
                swiotlb_bounce(orig_addr, tlb_addr, mapping_size,
DMA_TO_DEVICE);
--


On Fri, Dec 11, 2020 at 12:39 PM Konrad Rzeszutek Wilk <
konrad.wilk@oracle.com> wrote:

> On Mon, Dec 07, 2020 at 01:42:04PM -0800, Jianxiong Gao wrote:
> > NVMe driver and other applications depend on the data offset
> > to operate correctly. Currently when unaligned data is mapped via
> > SWIOTLB, the data is mapped as slab aligned with the SWIOTLB. When
> > booting with --swiotlb=force option and using NVMe as interface,
> > running mkfs.xfs on Rhel fails because of the unalignment issue.
> > This patch makes sure the mapped data preserves
> > its offset of the orginal address. Tested on latest kernel that
> > this patch fixes the issue.
> >
> > Signed-off-by: Jianxiong Gao <jxgao@google.com>
> > Acked-by: David Rientjes <rientjes@google.com>
>
> This breaks DHCP with upstream kernel (applied this on top v5.10-rc7)
> and used swiotlb=262144,force and now the dhclient is not working:
>
> [  119.300502] bnxt_en 0000:3b:00.0 eno2np0: NIC Link is Up, 25000 Mbps
> full duplex, Flow control: ON - receive & transmit
> [  119.437573] bnxt_en 0000:3b:00.0 eno2np0: FEC autoneg off encoding: None
> [   90.064220] dracut-initqueue[1477]: Warning: dhcp for interface eno2np0
> failed
> [  101.155295] dracut-initqueue[1477]: Warning: dhcp for interfa[
> 142.361359] bnxt_en 0000:3b:00.1 eno3np1: NIC Link is Up, 25000 Mbps full
> duplex, Flow control: ON - receive & transmit
> ce eno2np0 faile[  142.501860] bnxt_en 0000:3b:00.1 eno3np1: FEC autoneg
> off encoding: None
> d
> [  113.054108] dracut-initqueue[1477]: Warning: dhcp for interface eno3np1
> failed
> [  123.867108] dracut-initqueue[1477]: Warning: dhcp for interface eno3np1
> failed
> [  251.888002] dracut-initqueue[1477]: Warning: dracut-initqueue timeout -
> starting timeout scripts
>
> Dropping from linux-next.
>
> > ---
> >  kernel/dma/swiotlb.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index 781b9dca197c..56a35e71b3fd 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -483,6 +483,12 @@ phys_addr_t swiotlb_tbl_map_single(struct device
> *hwdev, phys_addr_t orig_addr,
> >       max_slots = mask + 1
> >                   ? ALIGN(mask + 1, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT
> >                   : 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
> > +
> > +     /*
> > +      * We need to keep the offset when mapping, so adding the offset
> > +      * to the total set we need to allocate in SWIOTLB
> > +      */
> > +     alloc_size += offset_in_page(orig_addr);
> >
> >       /*
> >        * For mappings greater than or equal to a page, we limit the
> stride
> > @@ -567,6 +573,11 @@ phys_addr_t swiotlb_tbl_map_single(struct device
> *hwdev, phys_addr_t orig_addr,
> >        */
> >       for (i = 0; i < nslots; i++)
> >               io_tlb_orig_addr[index+i] = orig_addr + (i <<
> IO_TLB_SHIFT);
> > +     /*
> > +      * When keeping the offset of the original data, we need to advance
> > +      * the tlb_addr by the offset of orig_addr.
> > +      */
> > +     tlb_addr += orig_addr & (PAGE_SIZE - 1);
> >       if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
> >           (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
> >               swiotlb_bounce(orig_addr, tlb_addr, mapping_size,
> DMA_TO_DEVICE);
> > --
> > 2.27.0
> >
> >
>


-- 
Jianxiong Gao

--00000000000024929105b82bea31
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Konrad,<div><br></div><div>Thanks for testing it out. I=
 have updated the patch and tested on=C2=A05.11.0-rc2+ with dhclient succes=
sfully. Could you please help me verify if the patch works on your=C2=A0sid=
e?</div><div><br></div><div>Thank you</div><div><br></div><div>NVMe driver =
and other applications depend on the data offset<br>to operate correctly. C=
urrently when unaligned data is mapped via<br>SWIOTLB, the data is mapped a=
s slab aligned with the SWIOTLB. When<br>booting with --swiotlb=3Dforce opt=
ion and using NVMe as interface,<br>running mkfs.xfs on Rhel fails because =
of the unalignment issue.<br>This patch makes sure the mapped data preserve=
s<br>its offset of the orginal address. Tested on latest kernel that<br>thi=
s patch fixes the issue.<br><br>Signed-off-by: Jianxiong Gao &lt;<a href=3D=
"mailto:jxgao@google.com" target=3D"_blank">jxgao@google.com</a>&gt;<br>Ack=
ed-by: David Rientjes &lt;<a href=3D"mailto:rientjes@google.com" target=3D"=
_blank">rientjes@google.com</a>&gt;<br>---<br>=C2=A0kernel/dma/swiotlb.c | =
11 +++++++++++<br>=C2=A01 file changed, 11 insertions(+)<br><br>diff --git =
a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c<br>index 781b9dca197c..56a35e=
71b3fd 100644<br>--- a/kernel/dma/swiotlb.c<br>+++ b/kernel/dma/swiotlb.c<b=
r>@@ -483,6 +483,12 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hw=
dev, phys_addr_t orig_addr,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 max_slots =3D ma=
sk + 1<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ? ALIGN(mask + 1, 1 &lt;&lt; IO_TLB_SHIFT) &gt;&gt; IO_TLB_SHIFT<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 1UL=
 &lt;&lt; (BITS_PER_LONG - IO_TLB_SHIFT);<br>+<br>+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0/*<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * We need to keep the offset when map=
ping, so adding the offset<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * to the total s=
et we need to allocate in SWIOTLB<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>+=
=C2=A0 =C2=A0 =C2=A0 =C2=A0alloc_size +=3D offset_in_page(orig_addr);<br><b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* For=
 mappings greater than or equal to a page, we limit the stride<br>@@ -567,6=
 +573,11 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_a=
ddr_t orig_addr,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 for (i =3D 0; i &lt; nslots; i++)<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 io_tlb_orig_addr[index+i] =3D orig_addr + (=
i &lt;&lt; IO_TLB_SHIFT);<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 * When keeping the offset of the original data, we need t=
o advance<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * the tlb_addr by the offset of o=
rig_addr.<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0tlb_addr +=3D offset_in_page(orig_addr);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
if (!(attrs &amp; DMA_ATTR_SKIP_CPU_SYNC) &amp;&amp;<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 (dir =3D=3D DMA_TO_DEVICE || dir =3D=3D DMA_BIDIRE=
CTIONAL))<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 swiotl=
b_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);<font color=3D"#=
888888"><br>--</font><br></div><div><br></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Dec 11, 2020 at 12:39=
 PM Konrad Rzeszutek Wilk &lt;<a href=3D"mailto:konrad.wilk@oracle.com" tar=
get=3D"_blank">konrad.wilk@oracle.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">On Mon, Dec 07, 2020 at 01:42:04PM -08=
00, Jianxiong Gao wrote:<br>
&gt; NVMe driver and other applications depend on the data offset<br>
&gt; to operate correctly. Currently when unaligned data is mapped via<br>
&gt; SWIOTLB, the data is mapped as slab aligned with the SWIOTLB. When<br>
&gt; booting with --swiotlb=3Dforce option and using NVMe as interface,<br>
&gt; running mkfs.xfs on Rhel fails because of the unalignment issue.<br>
&gt; This patch makes sure the mapped data preserves<br>
&gt; its offset of the orginal address. Tested on latest kernel that<br>
&gt; this patch fixes the issue.<br>
&gt; <br>
&gt; Signed-off-by: Jianxiong Gao &lt;<a href=3D"mailto:jxgao@google.com" t=
arget=3D"_blank">jxgao@google.com</a>&gt;<br>
&gt; Acked-by: David Rientjes &lt;<a href=3D"mailto:rientjes@google.com" ta=
rget=3D"_blank">rientjes@google.com</a>&gt;<br>
<br>
This breaks DHCP with upstream kernel (applied this on top v5.10-rc7)<br>
and used swiotlb=3D262144,force and now the dhclient is not working:<br>
<br>
[=C2=A0 119.300502] bnxt_en 0000:3b:00.0 eno2np0: NIC Link is Up, 25000 Mbp=
s full duplex, Flow control: ON - receive &amp; transmit<br>
[=C2=A0 119.437573] bnxt_en 0000:3b:00.0 eno2np0: FEC autoneg off encoding:=
 None<br>
[=C2=A0 =C2=A090.064220] dracut-initqueue[1477]: Warning: dhcp for interfac=
e eno2np0 failed<br>
[=C2=A0 101.155295] dracut-initqueue[1477]: Warning: dhcp for interfa[=C2=
=A0 142.361359] bnxt_en 0000:3b:00.1 eno3np1: NIC Link is Up, 25000 Mbps fu=
ll duplex, Flow control: ON - receive &amp; transmit<br>
ce eno2np0 faile[=C2=A0 142.501860] bnxt_en 0000:3b:00.1 eno3np1: FEC auton=
eg off encoding: None<br>
d<br>
[=C2=A0 113.054108] dracut-initqueue[1477]: Warning: dhcp for interface eno=
3np1 failed<br>
[=C2=A0 123.867108] dracut-initqueue[1477]: Warning: dhcp for interface eno=
3np1 failed<br>
[=C2=A0 251.888002] dracut-initqueue[1477]: Warning: dracut-initqueue timeo=
ut - starting timeout scripts<br>
<br>
Dropping from linux-next.<br>
<br>
&gt; ---<br>
&gt;=C2=A0 kernel/dma/swiotlb.c | 11 +++++++++++<br>
&gt;=C2=A0 1 file changed, 11 insertions(+)<br>
&gt; <br>
&gt; diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c<br>
&gt; index 781b9dca197c..56a35e71b3fd 100644<br>
&gt; --- a/kernel/dma/swiotlb.c<br>
&gt; +++ b/kernel/dma/swiotlb.c<br>
&gt; @@ -483,6 +483,12 @@ phys_addr_t swiotlb_tbl_map_single(struct device =
*hwdev, phys_addr_t orig_addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0max_slots =3D mask + 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0? =
ALIGN(mask + 1, 1 &lt;&lt; IO_TLB_SHIFT) &gt;&gt; IO_TLB_SHIFT<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: =
1UL &lt;&lt; (BITS_PER_LONG - IO_TLB_SHIFT);<br>
&gt; + <br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * We need to keep the offset when mapping, so ad=
ding the offset<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * to the total set we need to allocate in SWIOTL=
B<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0alloc_size +=3D offset_in_page(orig_addr);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * For mappings greater than or equal to a p=
age, we limit the stride<br>
&gt; @@ -567,6 +573,11 @@ phys_addr_t swiotlb_tbl_map_single(struct device =
*hwdev, phys_addr_t orig_addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; nslots; i++)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0io_tlb_orig_addr=
[index+i] =3D orig_addr + (i &lt;&lt; IO_TLB_SHIFT);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * When keeping the offset of the original data, =
we need to advance<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * the tlb_addr by the offset of orig_addr.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tlb_addr +=3D orig_addr &amp; (PAGE_SIZE - 1);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(attrs &amp; DMA_ATTR_SKIP_CPU_SYNC) &a=
mp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(dir =3D=3D DMA_TO_DEVICE || d=
ir =3D=3D DMA_BIDIRECTIONAL))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0swiotlb_bounce(o=
rig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);<br>
&gt; -- <br>
&gt; 2.27.0<br>
&gt; <br>
&gt; <br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
><div dir=3D"ltr">Jianxiong Gao</div></div>

--00000000000024929105b82bea31--

--===============2771495294403062592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2771495294403062592==--
