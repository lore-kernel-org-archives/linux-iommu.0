Return-Path: <SRS0=9w/B=G7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A182C433E0
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 18:06:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99ACE64E21
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 18:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99ACE64E21
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 391152E0F7;
	Thu, 28 Jan 2021 18:06:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vVMHngQap++f; Thu, 28 Jan 2021 18:06:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BD3232E0F8;
	Thu, 28 Jan 2021 18:06:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93B34C08A1;
	Thu, 28 Jan 2021 18:06:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74A6FC013A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 18:06:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5BB4686923
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 18:06:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RNeW7QlQdDQU for <iommu@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 18:06:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9786C8683A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 18:06:34 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id k25so6940583oik.13
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 10:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DDCJvHpdzmh/KYy7jUQHreb+ZWe457AaW5BntNhBhH8=;
 b=R+02G9ZFyz9jDd5TKJlR0oMnuLWci6z+nkJucxEIV0CVDcQeLe8Fo0aTav9F9R4ypU
 S1TKip5i4tEp2mZvsCq7lnUkHZuULLERXql378tXVUjWvnmS7i0TDmnL6fbIe8xazmbI
 QkfFn1Pps7LB7g6jMADjiEldSmPej9gWQxWDADjScgtLjaZBoY9HlNrQx9PRUJP56Tby
 vjoC1BizegDmCDryWnM7wOD9S0gqFM4uSFqaNZHbgUF0FD5DbMSMgIC9LGDZPjCeoq1B
 14HHgi9gXDY0mBVEVnmBNHBiX4yD4fRrdRjuOPKtKjxt8fI5pT3UM9XaQATgFgnkE2yF
 wb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DDCJvHpdzmh/KYy7jUQHreb+ZWe457AaW5BntNhBhH8=;
 b=hGsueT6SHVEXMfLwtTai5CeQeN77uwyTOK6X3AjrHYiqgXhvgl81HM5wnm5S7O6MMU
 yCArJ1956sg4setQUoGcQgb2gqcDN6t5WIWNUqJOOrJCJJQ2Se1NGwcMQ+jAD0X6aqpH
 ldRhu9Utg43mXfq+glrimrzB/5Lr+gFcFrQ6P6DXvWo5lVeitW+fNld+hR9Tn5LAadWt
 7E1pnvkWYFnN/fVc7vlR6zv2jDxb1vBomnv5X2OehnWPthi4zKn4dqyE9Q3iaOb9H99k
 He9Sh4kQO7RHMrbaOJrwM+t+YoYb+3AP+06zEfh1t5UUqLIvR/Gj/vG8H8OnGYLoNbkK
 Tt3Q==
X-Gm-Message-State: AOAM531h/DzWq2G8MbtIvGa/oI5Y1ykgeah8Vz9ogfsWY61bBTvUGt2F
 ldFGbCOkW+efu5uuagVLtidgstb/Q4vGmDHjYWNNoQ==
X-Google-Smtp-Source: ABdhPJyI11exkIain6LaaKDZj6lJwpMVYEcbilZL6+cFxnzwflHyhKwBT8vOC8bwxi8MHnptpJSNK81qJB5fAvE/83c=
X-Received: by 2002:aca:b9c1:: with SMTP id j184mr351856oif.63.1611857193648; 
 Thu, 28 Jan 2021 10:06:33 -0800 (PST)
MIME-Version: 1.0
References: <20210128003829.1892018-1-jxgao@google.com>
 <20210128003829.1892018-3-jxgao@google.com>
 <YBLxMP3sr71BTL+d@Konrads-MacBook-Pro.local>
 <20210128173451.GA31631@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20210128173451.GA31631@redsun51.ssa.fujisawa.hgst.com>
Date: Thu, 28 Jan 2021 10:06:21 -0800
Message-ID: <CAMGD6P00=sK=-H9CfVEJgCnZhs2oBeVK41gc+LnCfqgKWjUcuA@mail.gmail.com>
Subject: Re: [PATCH 2/3] Add swiotlb offset preserving mapping when
 dma_dma_parameters->page_offset_mask is non zero.
To: Keith Busch <kbusch@kernel.org>
Cc: heikki.krogerus@linux.intel.com, sagi@grimberg.me,
 Saravana Kannan <saravanak@google.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marc Orr <marcorr@google.com>,
 gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, axboe@fb.com,
 bgolaszewski@baylibre.com, iommu@lists.linux-foundation.org, jroedel@suse.de,
 dan.j.williams@intel.com, andriy.shevchenko@linux.intel.com,
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
From: Jianxiong Gao via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jianxiong Gao <jxgao@google.com>
Content-Type: multipart/mixed; boundary="===============9185993065575634807=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============9185993065575634807==
Content-Type: multipart/alternative; boundary="0000000000007541ac05b9f9bf35"

--0000000000007541ac05b9f9bf35
Content-Type: text/plain; charset="UTF-8"

The error can't be fixed by just updating the NVMe driver.
The NVMe spec (and as pointed out by Chirstoph, some other drivers) rely on
the offset of address to copy data correctly. When data is mapped via
swiotlb,
the current implementation always copy the data at 2k/4k aligned address.


On Thu, Jan 28, 2021 at 9:35 AM Keith Busch <kbusch@kernel.org> wrote:

> On Thu, Jan 28, 2021 at 12:15:28PM -0500, Konrad Rzeszutek Wilk wrote:
> > On Wed, Jan 27, 2021 at 04:38:28PM -0800, Jianxiong Gao wrote:
> > > For devices that need to preserve address offset on mapping through
> > > swiotlb, this patch adds offset preserving based on page_offset_mask
> > > and keeps the offset if the mask is non zero. This is needed for
> > > device drivers like NVMe.
> >
> > <scratches his head>
> >
> > Didn't you send this patch like a month ago and someone pointed
> > out that the right fix would be in the NVMe driver?
> >
> > Is there an issue with fixing the NVMe driver?
>
> You got it backwards. The initial "fix" used a flag specific to the nvme
> driver, and it was pointed out that it should just be the generic
> behaviour.
>


-- 
Jianxiong Gao

--0000000000007541ac05b9f9bf35
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The error can&#39;t be fixed by just updating the NVMe dri=
ver.<div>The NVMe spec (and as pointed out by Chirstoph, some other drivers=
) rely on<div>the offset of address to copy data correctly. When data is ma=
pped via swiotlb,</div><div>the current implementation always copy the data=
 at 2k/4k aligned address.<br></div></div><div><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 28, 20=
21 at 9:35 AM Keith Busch &lt;<a href=3D"mailto:kbusch@kernel.org">kbusch@k=
ernel.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Thu, Jan 28, 2021 at 12:15:28PM -0500, Konrad Rzeszutek Wilk =
wrote:<br>
&gt; On Wed, Jan 27, 2021 at 04:38:28PM -0800, Jianxiong Gao wrote:<br>
&gt; &gt; For devices that need to preserve address offset on mapping throu=
gh<br>
&gt; &gt; swiotlb, this patch adds offset preserving based on page_offset_m=
ask<br>
&gt; &gt; and keeps the offset if the mask is non zero. This is needed for<=
br>
&gt; &gt; device drivers like NVMe.<br>
&gt; <br>
&gt; &lt;scratches his head&gt;<br>
&gt; <br>
&gt; Didn&#39;t you send this patch like a month ago and someone pointed<br=
>
&gt; out that the right fix would be in the NVMe driver?<br>
&gt; <br>
&gt; Is there an issue with fixing the NVMe driver?<br>
<br>
You got it backwards. The initial &quot;fix&quot; used a flag specific to t=
he nvme<br>
driver, and it was pointed out that it should just be the generic<br>
behaviour.<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr">Jianxiong Gao</div></div>

--0000000000007541ac05b9f9bf35--

--===============9185993065575634807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============9185993065575634807==--
