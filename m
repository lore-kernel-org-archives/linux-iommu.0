Return-Path: <SRS0=Rmex=HD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357E1C433E0
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 21:17:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A33A164E93
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 21:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33A164E93
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6EE1B855CC;
	Mon,  1 Feb 2021 21:17:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l2OejB_RZA2g; Mon,  1 Feb 2021 21:17:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 92B9D8543E;
	Mon,  1 Feb 2021 21:17:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 776F9C0FA7;
	Mon,  1 Feb 2021 21:17:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22B9DC013A
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 21:17:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 05FED85C19
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 21:17:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iqNGgjW1S-xL for <iommu@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 21:17:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com
 [209.85.167.182])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2F19684B88
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 21:17:02 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id n7so20393652oic.11
 for <iommu@lists.linux-foundation.org>; Mon, 01 Feb 2021 13:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Sy9wmCxsO6Z/PtA06C4i8m9oWmKK39OH+8k+7SK1XZ4=;
 b=RPQb+SzKQsFgglnNX5n+K61MAC0iMkt6F+rZjmZ0eAETFg/QchH/4bCUld3G44emqq
 ImNSfieFHvRGwZmv2wXdsIrx8erE/Mqd2cBPYb7jSKqRSXCOwoNqxpkCPLESllxYzkog
 MYcD3wrRAtJWWcAXS+FJgWa7OvjkqHe6CxYuGEk/HzXtv6UA9/9wDFiPludH2GsYsdVa
 X5NU41CXulPPjJpMYhH+glqQDWXaombqqG5nZcdt5jbMYfat6OGqGS/gk7gPuPMbKVqx
 cK4DFl1UnGsaZoNy+LU7PD6epLmDEvUF38uiLcm7bMpzJt393ftOGAaksVyZIRWX4lyH
 jAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Sy9wmCxsO6Z/PtA06C4i8m9oWmKK39OH+8k+7SK1XZ4=;
 b=H/t/7tTrzfcZ2bTFUC50//7/4J70wfsxTBWVj+qkfFmU4omDSWRe+qA3HpiDr4PvB3
 PwSwBTiKIu6LNTm8VjXQ/ixhdoWmCk02ytjtBNv4yHQ4tt2GwfUJiYEi6zvDYl8MuXHP
 igI7qzzCtS/Yz1mH/2F6edSno3fLmFXjdsjrN+TuSqLu1A1f9Ry+oIQMuSrrRl8eKA7w
 sXDrfOdCT0+Hp+YqBpE27MavL82ij1+sxuDabBmL4u5BtG4H+HcBYkzw9Z2QVS3N1R42
 5H+z4oouLjdlN5kyICSoGyQLo8u+rm59PkPYqCbODpGyyO1V4DcaM6DyVdsr0vnwrCwF
 lApg==
X-Gm-Message-State: AOAM533gvoy6loIYdv0b30X3ytdtrQ/Kt0L9ziY/Hs++/Wo43SWoPzEl
 Q1erBqlQnBRsA45dWDDvmqSpq+0xFcC+vzmqEJ2Trw==
X-Google-Smtp-Source: ABdhPJweVb9v/0H5iRo7ZKBrgpn+ca5Cokb91St0ejm/U+7lLqHrjsvEjeoTMlwmE3U4nJiFX4g5/5iz+OnKes0+6EA=
X-Received: by 2002:aca:be0b:: with SMTP id o11mr562227oif.42.1612214221120;
 Mon, 01 Feb 2021 13:17:01 -0800 (PST)
MIME-Version: 1.0
References: <20210201183017.3339130-1-jxgao@google.com>
 <20210201183017.3339130-4-jxgao@google.com>
 <20210201205759.GA2128135@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20210201205759.GA2128135@dhcp-10-100-145-180.wdc.com>
Date: Mon, 1 Feb 2021 13:16:48 -0800
Message-ID: <CAMGD6P2Gz9nWELMdsAhwQvXx3PXv2aXet=Tn9Rca61obZawfgw@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] Adding device_dma_parameters->offset_preserve_mask
 to NVMe driver.
To: Keith Busch <kbusch@kernel.org>
Cc: heikki.krogerus@linux.intel.com, sagi@grimberg.me,
 Saravana Kannan <saravanak@google.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marc Orr <marcorr@google.com>,
 gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, axboe@fb.com,
 bgolaszewski@baylibre.com, iommu@lists.linux-foundation.org, jroedel@suse.de,
 dan.j.williams@intel.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
From: Jianxiong Gao via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jianxiong Gao <jxgao@google.com>
Content-Type: multipart/mixed; boundary="===============2769807100572937647=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============2769807100572937647==
Content-Type: multipart/alternative; boundary="000000000000f4018305ba4cdf5d"

--000000000000f4018305ba4cdf5d
Content-Type: text/plain; charset="UTF-8"

>
> On Mon, Feb 01, 2021 at 10:30:17AM -0800, Jianxiong Gao wrote:
> > @@ -868,12 +871,24 @@ static blk_status_t nvme_map_data(struct nvme_dev
> *dev, struct request *req,
> >       if (!iod->nents)
> >               goto out_free_sg;
> >
> > +     offset_ret = dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE
> - 1);
> > +     if (offset_ret) {
> > +             dev_warn(dev->dev, "dma_set_min_align_mask failed to set
> offset\n");
> > +             goto out_free_sg;
> > +     }
> > +
> >       if (is_pci_p2pdma_page(sg_page(iod->sg)))
> >               nr_mapped = pci_p2pdma_map_sg_attrs(dev->dev, iod->sg,
> >                               iod->nents, rq_dma_dir(req),
> DMA_ATTR_NO_WARN);
> >       else
> >               nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
> >                                            rq_dma_dir(req),
> DMA_ATTR_NO_WARN);
> > +
> > +     offset_ret = dma_set_min_align_mask(dev->dev, 0);
> > +     if (offset_ret) {
> > +             dev_warn(dev->dev, "dma_set_min_align_mask failed to reset
> offset\n");
> > +             goto out_free_sg;
> > +     }
> >       if (!nr_mapped)
> >               goto out_free_sg;
>
> Why is this setting being done and undone on each IO? Wouldn't it be
> more efficient to set it once during device initialization?
>
> And more importantly, this isn't thread safe: one CPU may be setting the
> device's dma alignment mask to 0 while another CPU is expecting it to be
> NVME_CTRL_PAGE_SIZE - 1.
>

I was having trouble getting the OS booted when setting it once during
initialization. However when I rebased to the latest rc6 this morning it
seems to be working with setting the mask on probe. I am still testing out
and will appreciate any idea what may cause the nvme driver to fail
with a single mask.

-- 
Jianxiong Gao

--000000000000f4018305ba4cdf5d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On Mon, Feb 01, 2021 at 10:30:17AM -0800, Jianxiong Gao =
wrote:<br>
&gt; @@ -868,12 +871,24 @@ static blk_status_t nvme_map_data(struct nvme_de=
v *dev, struct request *req,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!iod-&gt;nents)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_free_sg=
;<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0offset_ret =3D dma_set_min_align_mask(dev-&gt;dev=
, NVME_CTRL_PAGE_SIZE - 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (offset_ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_warn(dev-&gt;dev,=
 &quot;dma_set_min_align_mask failed to set offset\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_free_sg;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_pci_p2pdma_page(sg_page(iod-&gt;sg)))=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nr_mapped =3D pc=
i_p2pdma_map_sg_attrs(dev-&gt;dev, iod-&gt;sg,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iod-&gt;nents, rq_dma_dir(req), DM=
A_ATTR_NO_WARN);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nr_mapped =3D dm=
a_map_sg_attrs(dev-&gt;dev, iod-&gt;sg, iod-&gt;nents,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 rq_dma_dir(req), DMA_ATTR_NO_WARN);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0offset_ret =3D dma_set_min_align_mask(dev-&gt;dev=
, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (offset_ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_warn(dev-&gt;dev,=
 &quot;dma_set_min_align_mask failed to reset offset\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_free_sg;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!nr_mapped)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_free_sg=
;<br>
<br>
Why is this setting being done and undone on each IO? Wouldn&#39;t it be<br=
>
more efficient to set it once during device initialization?<br>
<br>
And more importantly, this isn&#39;t thread safe: one CPU may be setting th=
e<br>
device&#39;s dma alignment mask to 0 while another CPU is expecting it to b=
e<br>
NVME_CTRL_PAGE_SIZE - 1.<br>
</blockquote></div><div><br></div>I was having trouble getting the OS boote=
d when setting it once during=C2=A0<div>initialization. However when I reba=
sed to the latest rc6 this morning it</div><div>seems to be working with se=
tting the mask on probe. I am still testing out</div><div>and will apprecia=
te any idea what may cause the nvme driver to fail</div><div>with a single =
mask.<br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmai=
l_signature"><div dir=3D"ltr">Jianxiong Gao</div></div></div></div>

--000000000000f4018305ba4cdf5d--

--===============2769807100572937647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2769807100572937647==--
