Return-Path: <SRS0=9w/B=G7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BB5C433E0
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 18:35:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9500F64E48
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 18:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9500F64E48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 00EFB1FFFF;
	Thu, 28 Jan 2021 18:35:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 45+7LYUDY3Ex; Thu, 28 Jan 2021 18:35:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id AC5E11FEAE;
	Thu, 28 Jan 2021 18:35:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9038AC0FA8;
	Thu, 28 Jan 2021 18:35:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16CD7C08A1
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 18:35:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 049231FEAE
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 18:35:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lU8e2dnigGb1 for <iommu@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 18:35:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com
 [209.85.219.180])
 by silver.osuosl.org (Postfix) with ESMTPS id 1EAFC20378
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 18:35:49 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id b11so6373285ybj.9
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 10:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nqZGVJRD5efldNcV9lWi9HRW5W2M8k+fXgTxMYbdau0=;
 b=YZ9qa703D+4iTFxt9842rNh0es1aUCxZGZREpGBzKMpzpw1Cu7TFUdiml/zX9ICJnF
 ZZKHd5NF8eQtmNxMUzj20hFkSy5wOpZn4TRv/XYotsZxxr9219xT9kZqAOZSdt26TZom
 aF6OS5CdK9sabyapRUQFAa7Fhnt9fPxEbqyJi5LRYuz7NnVd9zT4ytclUqmAkKYSj5BT
 yEuMFX6DTCE1Tgz+Hj7/0chTjw4v7vNDSjqNhXD0Vu8365YitFyGyTVzEBO0ThUtCW7h
 Rmkh6O/Dpr5nk4AuUJnm06X3qcd/DcmBXLXuhvCBgTfRiGPdwGSRDncmLiiXNfRJwo1v
 4Scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nqZGVJRD5efldNcV9lWi9HRW5W2M8k+fXgTxMYbdau0=;
 b=OKV8vwBZo/Vvsw8KmDPERjNRNZZvuTp+HH3y3g9Rge9CCsUVCnkr9mDBHuFPwtmPLW
 lT0pcKMugfRUe4yx8UV0PJEw0R4V4XERX70Lzd56zj/s3sLkNjYftr3b4FNxQPJa4+jP
 5yBrMPW560mWjJ6+YHyjeWK1L2F1jmwrIMqnXOSwC98xanbg5j3m1CaK8IrNYeruOCi7
 FKxUMKqCwB8qG6mq9YGPxMKCOM7t6OW1dfnPhZ1lnoFg8ywSFzlidLnMKq63E+kBXxVK
 lZW4Yx6iHhnjL/9+aYBv5b8YVE5rg81KymP5w5jHUrEMTCKOvmJsG5yTmAKIifAVWX39
 GUkA==
X-Gm-Message-State: AOAM532VFa9uJ/BvcPH96tl/zQIA3sZgm9EaiiDf53wgg8jRgQ+gXOYK
 QwQwQtVmMnX5J60MNrMqF1gCKk7CxEykqqy7de37cCvXMtkUEw==
X-Google-Smtp-Source: ABdhPJy9d2NlwQXdDPdkxutUzmawQDv5gvTRp/MeYNQc+E/4Po7qf+iLevjwFu9SrLcTvv4V5ngu6pHtEHqOM7M97JY=
X-Received: by 2002:a4a:b987:: with SMTP id e7mr598537oop.92.1611858534234;
 Thu, 28 Jan 2021 10:28:54 -0800 (PST)
MIME-Version: 1.0
References: <20210128003829.1892018-1-jxgao@google.com>
 <20210128003829.1892018-4-jxgao@google.com>
 <0550ca25-1389-ffc2-e738-8127ceb1712f@arm.com> <20210128181804.GC11790@lst.de>
In-Reply-To: <20210128181804.GC11790@lst.de>
Date: Thu, 28 Jan 2021 10:28:42 -0800
Message-ID: <CAMGD6P2GJHYXteE-4jDHFBm=q_vtN7AXpv=TGnS5zcDX3JDdhg@mail.gmail.com>
Subject: Re: [PATCH 3/3] Adding device_dma_parameters->offset_preserve_mask to
 NVMe driver.
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@fb.com, heikki.krogerus@linux.intel.com, sagi@grimberg.me,
 Saravana Kannan <saravanak@google.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marc Orr <marcorr@google.com>,
 gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, bgolaszewski@baylibre.com,
 iommu@lists.linux-foundation.org, jroedel@suse.de, dan.j.williams@intel.com,
 andriy.shevchenko@linux.intel.com, Robin Murphy <robin.murphy@arm.com>
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
Content-Type: multipart/mixed; boundary="===============5807893948638422241=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============5807893948638422241==
Content-Type: multipart/alternative; boundary="0000000000005d05d705b9fa0fb9"

--0000000000005d05d705b9fa0fb9
Content-Type: text/plain; charset="UTF-8"

I have tried to set it once at probe and then leave it in place, however
the NVMe driver does not seem to like it, and the VM does not boot
correctly. I have spent a couple days debugging but I am a bit lost
now.

Basically whenever nvme_setup_prp_simple
<https://elixir.bootlin.com/linux/v5.11-rc5/source/drivers/nvme/host/pci.c#L803>
is
mapping with the mask,
I am getting timeout issues on boot, which to my knowledge shows NVMe
driver failure:

> [    5.500662] random: crng init done
> [    5.502933] random: 7 urandom warning(s) missed due to ratelimiting
> [  132.077795] dracut-initqueue[472]: Warning: dracut-initqueue timeout -
> starting timeout scripts
> [  132.614755] dracut-initqueue[472]: Warning: dracut-initqueue timeout -
> starting timeout scripts
>

I have checked that all the mappings happened correctly:

> [    4.773570] nvme 0000:00:04.0: nvme setup prp simple is mapping 200
> data, with offset 200, from fffffc9acd6c6040, mapped at 7affb200
> [    4.784540] nvme 0000:00:04.0: nvme setup prp simple is mapping 200
> data, with offset 400, from fffffc9acd6c6040, mapped at 7affc400
> [    4.794096] nvme 0000:00:04.0: nvme setup prp simple is mapping 200
> data, with offset 600, from fffffc9acd6c6040, mapped at 7affd600
> [    4.801983] nvme 0000:00:04.0: nvme setup prp simple is mapping 200
> data, with offset 800, from fffffc9acd6c6040, mapped at 7affe800
> [    4.806873] nvme 0000:00:04.0: nvme setup prp simple is mapping 200
> data, with offset a00, from fffffc9acd6c6040, mapped at 7afffa00
> [    4.812382] nvme 0000:00:04.0: nvme setup prp simple is mapping 200
> data, with offset c00, from fffffc9acd6c6040, mapped at 7b000c00
> [    4.817423] nvme 0000:00:04.0: nvme setup prp simple is mapping 200
> data, with offset e00, from fffffc9acd6c6040, mapped at 7b001e00
> [    4.823652] nvme 0000:00:04.0: nvme setup prp simple is mapping 200
> data, with offset 200, from fffffc9acd6c60c0, mapped at 7b003200
> [    4.828679] nvme 0000:00:04.0: nvme setup prp simple is mapping 200
> data, with offset 400, from fffffc9acd6c60c0, mapped at 7b004400
> [    4.833875] nvme 0000:00:04.0: nvme setup prp simple is mapping 200
> data, with offset 600, from fffffc9acd6c60c0, mapped at 7b005600
> [    4.838926] nvme 0000:00:04.0: nvme setup prp simple is mapping 200
> data, with offset 800, from fffffc9acd6c60c0, mapped at 7b006800

...

I have compared it to not setting the mask. The only difference in result is
that instead of being mapped to *200|* 400|*600 etc, they are all mapped
to *000. So I believe the mapping is done correctly, and according to NVMe
<https://nvmexpress.org/wp-content/uploads/NVM-Express-1_4b-2020.09.21-Ratified.pdf>
spec
<https://nvmexpress.org/wp-content/uploads/NVM-Express-1_4b-2020.09.21-Ratified.pdf>
figure
108/109, the mapping should have the offset kept. I am not
sure what caused the error that eventually led to the failure. Is there
another
bug in the NVMe driver?

On Thu, Jan 28, 2021 at 10:18 AM Christoph Hellwig <hch@lst.de> wrote:

> On Thu, Jan 28, 2021 at 06:00:58PM +0000, Robin Murphy wrote:
> > If it were possible for this to fail, you might leak the DMA mapping
> here.
> > However if dev->dma_parms somehow disappeared since a dozen lines above
> > then I think you've got far bigger problems anyway.
> >
> > That said, do you really need to keep toggling this back and forth all
> the
> > time? Even if the device does make other mappings elsewhere that don't
> > necessarily need the same strict alignment, would it be significantly
> > harmful just to set it once at probe and leave it in place anyway?
>
> Yes, we should kept it set all the time.  While some NVMe devices have
> the optional to use SGLs that do not have this limitation, I have
> absolutely no sympathy for anyone running NVMe with swiotlb as that
> means their system imposes an addressing limitation.  We need to make
> sure it does not corrupt data, but we're not going to make any effort
> to optimize for such a degenerated setup.
>


-- 
Jianxiong Gao

--0000000000005d05d705b9fa0fb9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I have tried to set it once at probe and then leave it in =
place, however=C2=A0<div>the NVMe driver does not seem to like it, and the =
VM does not boot</div><div>correctly. I have spent a couple days debugging =
but I am a bit lost=C2=A0</div><div>now.=C2=A0</div><div><br></div><div>Bas=
ically whenever <a href=3D"https://elixir.bootlin.com/linux/v5.11-rc5/sourc=
e/drivers/nvme/host/pci.c#L803" target=3D"_blank">nvme_setup_prp_simple=C2=
=A0</a>=C2=A0is mapping with the mask,</div><div>I am getting timeout issue=
s on boot, which to my knowledge shows NVMe</div><div>driver failure:</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">[ =C2=A0 =C2=A05.500662] =
random: crng init done<br>[ =C2=A0 =C2=A05.502933] random: 7 urandom warnin=
g(s) missed due to ratelimiting<br>[ =C2=A0132.077795] dracut-initqueue[472=
]: Warning: dracut-initqueue timeout - starting timeout scripts<br>[ =C2=A0=
132.614755] dracut-initqueue[472]: Warning: dracut-initqueue timeout - star=
ting timeout scripts<br></blockquote><div><br></div><div>I have checked tha=
t all the mappings happened correctly:</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">[ =C2=A0 =C2=A04.773570] nvme 0000:00:04.0: nvme setup p=
rp simple is mapping 200 data, with offset 200, from fffffc9acd6c6040, mapp=
ed at 7affb200<br>[ =C2=A0 =C2=A04.784540] nvme 0000:00:04.0: nvme setup pr=
p simple is mapping 200 data, with offset 400, from fffffc9acd6c6040, mappe=
d at 7affc400<br>[ =C2=A0 =C2=A04.794096] nvme 0000:00:04.0: nvme setup prp=
 simple is mapping 200 data, with offset 600, from fffffc9acd6c6040, mapped=
 at 7affd600<br>[ =C2=A0 =C2=A04.801983] nvme 0000:00:04.0: nvme setup prp =
simple is mapping 200 data, with offset 800, from fffffc9acd6c6040, mapped =
at 7affe800<br>[ =C2=A0 =C2=A04.806873] nvme 0000:00:04.0: nvme setup prp s=
imple is mapping 200 data, with offset a00, from fffffc9acd6c6040, mapped a=
t 7afffa00<br>[ =C2=A0 =C2=A04.812382] nvme 0000:00:04.0: nvme setup prp si=
mple is mapping 200 data, with offset c00, from fffffc9acd6c6040, mapped at=
 7b000c00<br>[ =C2=A0 =C2=A04.817423] nvme 0000:00:04.0: nvme setup prp sim=
ple is mapping 200 data, with offset e00, from fffffc9acd6c6040, mapped at =
7b001e00<br>[ =C2=A0 =C2=A04.823652] nvme 0000:00:04.0: nvme setup prp simp=
le is mapping 200 data, with offset 200, from fffffc9acd6c60c0, mapped at 7=
b003200<br>[ =C2=A0 =C2=A04.828679] nvme 0000:00:04.0: nvme setup prp simpl=
e is mapping 200 data, with offset 400, from fffffc9acd6c60c0, mapped at 7b=
004400<br>[ =C2=A0 =C2=A04.833875] nvme 0000:00:04.0: nvme setup prp simple=
 is mapping 200 data, with offset 600, from fffffc9acd6c60c0, mapped at 7b0=
05600<br>[ =C2=A0 =C2=A04.838926] nvme 0000:00:04.0: nvme setup prp simple =
is mapping 200 data, with offset 800, from fffffc9acd6c60c0, mapped at 7b00=
6800=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">..=
.=C2=A0</blockquote><div>I have compared it to not setting the mask. The on=
ly difference in result is</div><div>that instead of being mapped to *200|*=
 400|*600 etc, they are all mapped=C2=A0</div><div>to *000. So I believe th=
e mapping is done correctly, and according to <a href=3D"https://nvmexpress=
.org/wp-content/uploads/NVM-Express-1_4b-2020.09.21-Ratified.pdf" target=3D=
"_blank">NVMe</a></div><div><a href=3D"https://nvmexpress.org/wp-content/up=
loads/NVM-Express-1_4b-2020.09.21-Ratified.pdf" target=3D"_blank">spec</a>=
=C2=A0figure 108/109, the mapping should have the offset kept. I am not=C2=
=A0</div><div>sure what caused the error that eventually led to the failure=
. Is there another</div><div>bug in the NVMe driver?</div></div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 28, 2=
021 at 10:18 AM Christoph Hellwig &lt;<a href=3D"mailto:hch@lst.de" target=
=3D"_blank">hch@lst.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On Thu, Jan 28, 2021 at 06:00:58PM +0000, Robin Murph=
y wrote:<br>
&gt; If it were possible for this to fail, you might leak the DMA mapping h=
ere. <br>
&gt; However if dev-&gt;dma_parms somehow disappeared since a dozen lines a=
bove <br>
&gt; then I think you&#39;ve got far bigger problems anyway.<br>
&gt;<br>
&gt; That said, do you really need to keep toggling this back and forth all=
 the <br>
&gt; time? Even if the device does make other mappings elsewhere that don&#=
39;t <br>
&gt; necessarily need the same strict alignment, would it be significantly =
<br>
&gt; harmful just to set it once at probe and leave it in place anyway?<br>
<br>
Yes, we should kept it set all the time.=C2=A0 While some NVMe devices have=
<br>
the optional to use SGLs that do not have this limitation, I have<br>
absolutely no sympathy for anyone running NVMe with swiotlb as that<br>
means their system imposes an addressing limitation.=C2=A0 We need to make<=
br>
sure it does not corrupt data, but we&#39;re not going to make any effort<b=
r>
to optimize for such a degenerated setup.<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
><div dir=3D"ltr">Jianxiong Gao</div></div>

--0000000000005d05d705b9fa0fb9--

--===============5807893948638422241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5807893948638422241==--
