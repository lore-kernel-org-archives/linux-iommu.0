Return-Path: <SRS0=Z2AP=ZY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3984C432C0
	for <iommu@archiver.kernel.org>; Mon,  2 Dec 2019 03:34:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A9BC20881
	for <iommu@archiver.kernel.org>; Mon,  2 Dec 2019 03:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/dAOe0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9BC20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CC38287D6A;
	Mon,  2 Dec 2019 03:34:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D+-Z9ioGCKBO; Mon,  2 Dec 2019 03:34:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8B2A6857D6;
	Mon,  2 Dec 2019 03:34:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63FFDC1DD9;
	Mon,  2 Dec 2019 03:34:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04985C087F
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 03:34:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CE07F204C0
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 03:34:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9gEc9dvnPGGr for <iommu@lists.linux-foundation.org>;
 Mon,  2 Dec 2019 03:34:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com
 [209.85.217.54])
 by silver.osuosl.org (Postfix) with ESMTPS id 7ADAB20495
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 03:34:07 +0000 (UTC)
Received: by mail-vs1-f54.google.com with SMTP id f8so1235028vsq.8
 for <iommu@lists.linux-foundation.org>; Sun, 01 Dec 2019 19:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=dsZKdicXBqjHaYrsUJJbJe56C2gRimPVPEZkWMPAXso=;
 b=o/dAOe0q1w0obUvW1I2eGwceDqAkBL4iry7IO9QqcZQXB9vuq612ruiCVkAaWMKqOf
 MLUFtDc6ph5pbgt7vI1c5KhHsKWeXWufedHT3UwazJ4AeduFEG/iO/ytEAzX5jiwR7xy
 wrQzZiRfa+k/mtA4GarfEMvcNI6/dwBedugAxGYD9p33RCPPxKP3DQFvZ68gNUjCmgdZ
 Gx34iRFC8DnsEZuOmkgB8mIZGyEMhHKfvChB84bRNpqm6ozjEdJOPZjraOZBrWxfPUQ2
 jpphjozqoHM6XCL/JQZDkXPKmm4IHTiQoviUziEfsrd4bs638HYP8EEPIxOQteqtutDq
 tfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=dsZKdicXBqjHaYrsUJJbJe56C2gRimPVPEZkWMPAXso=;
 b=UfaCZJl2NRdPmyZN8EGnQur5b+hQqIpkHIHTNDZZr+oIx4xyOOXc6a2pJ/eFN4HRwY
 I731kVjbpUnCXP3rXte95T38K/NPWF7AbWtUDdtuyzQ8/vKvgUAWT1yHYLQjGERjk84f
 v8NHT5Ue4Bhc8O7LguG0BPiIxiRZhYknMZyMg+zhN1eoe26c81mPcjh/zbtYStoJUl20
 fsYMkhS9OnPkoHp6oV/5pOdgE83sIFTJKWTLSEj94u9fH8RUNZ9RgPvRQRmBOzGsIBEo
 6iJsuVtTAw/7yxvRubGluFaoqpx4LgosQTKcOLdDNpSysfH2t9xk3VRsA3YM/se7DGLo
 GcfA==
X-Gm-Message-State: APjAAAUjXJEGAx0Q2+1PpTBMGeE8sc2Y7jH61punxWhDfkNbLZE9nNPE
 Z+yX08lufbKl4PGm3FT/5zN/cXsDLQ8hdAlnlhPiow==
X-Google-Smtp-Source: APXvYqzOHUBJOJAeY1qqwBUG/02rUoVA/9Sq//wj3UOBdw5I//0AexQ7zdN56wOAmqvZ/khZnDN3LvLa/FEaoTOhMlc=
X-Received: by 2002:a05:6102:224b:: with SMTP id
 e11mr30191382vsb.17.1575257646434; 
 Sun, 01 Dec 2019 19:34:06 -0800 (PST)
MIME-Version: 1.0
References: <CAL20ACJ2cM1Zs3q5rb3jG7fDVNfzySV6WX=+nbdKiS4KT52NaQ@mail.gmail.com>
 <f0913338-3854-6ff7-aa8c-85b96efbed27@linux.intel.com>
 <CAL20ACLtwjDLaPattEkPiufsgHa2k-4Wb_Dw7Urh9we0QwbJfQ@mail.gmail.com>
 <da7fb26f-022b-eaad-1a91-11cf15531f8a@linux.intel.com>
In-Reply-To: <da7fb26f-022b-eaad-1a91-11cf15531f8a@linux.intel.com>
From: Anand Misra <am.online.edu@gmail.com>
Date: Sun, 1 Dec 2019 19:33:55 -0800
Message-ID: <CAL20ACL_t0zAnQKvfj=VHM1jBLfOuCkCOFoQxn+S1vJoZfU6yg@mail.gmail.com>
Subject: Re: kernel BUG at drivers/iommu/intel-iommu.c:667!
To: Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org
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
Content-Type: multipart/mixed; boundary="===============6447465499289107245=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============6447465499289107245==
Content-Type: multipart/alternative; boundary="000000000000720e650598b040f2"

--000000000000720e650598b040f2
Content-Type: text/plain; charset="UTF-8"

[+iommu_list]

Application isn't aware of hugepage but a userspace (lower) level stack is
aware of the type of memory being allocated on behalf of application, which
in turn communicates w/ driver via ioctl. I'm trying to make it more
agnostic by using dma_map_sg() when multiple GBs are required by
application. Otherwise, I'm using dmap_map_page(). Admittedly, I'm learning
these concepts/APIs for Linux along the way.

Thanks,
-am


On Sun, Dec 1, 2019 at 7:12 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi,
>
> On 12/2/19 11:00 AM, Anand Misra wrote:
> > Thanks, Lu Baolu. This is the dev version we've in our company. I can
> > try on a Ubuntu with a recent kernel version. Although, do you think
> I'm  > going in the right direction? Is it possible to have multiple
> hugepages
> > mapped via iommu to get contiguous mapping for DMA?
> >
>
> You mentioned:
>
> "
> I'm trying to use iommu for multiple hugepages (mmap'ed by process and
> pushed to driver via ioctl). The expectation is to have multiple
> hugepages mapped via iommu with each huge page having an entry in iommu
> (i.e. minimize table walk for DMA). Is this possible?
> "
>
> Currently huge page mapping is hidden in iommu driver according to the
> iommu capability and size of map range. Why do you want to be aware of
> it in driver or even application level?
>
> Best regards,
> baolu
>
> > -am
> >
> >
> > On Sun, Dec 1, 2019 at 6:24 PM Lu Baolu <baolu.lu@linux.intel.com
> > <mailto:baolu.lu@linux.intel.com>> wrote:
> >
> >     Hi,
> >
> >     On 12/2/19 9:46 AM, Anand Misra wrote:
> >      > Hello:
> >      >
> >      > I'm in process of adding iommu support in my driver for a PCIe
> >     device.
> >      > The device doesn't publish ACS/ATS via its config space. I've
> >     following
> >      > config:
> >      >
> >      > Linux cmdline: "intel-iommu=on iommu=pt
> >      > vfio_iommu_type1.allow_unsafe_interrupts=1
> >     pcie_acs_override=downstream"
> >      > Centos kernel: 3.10.0-1062.1.2.el7.x86_64
> >      >
> >
> >     Can you please use the latest kernel for test? 3.10 seems to be
> pretty
> >     old and there are a lot of changes after it.
> >
> >     Best regards,
> >     baolu
> >
>

--000000000000720e650598b040f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace">[+iommu_list]</div><div class=3D"gmail_default" style=
=3D"font-family:monospace"><br></div><div class=3D"gmail_default" style=3D"=
font-family:monospace">Application isn&#39;t aware of hugepage but a usersp=
ace (lower) level stack is aware of the type of memory being allocated on b=
ehalf of application, which in turn communicates w/ driver via ioctl. I&#39=
;m trying to make it more agnostic by using dma_map_sg() when multiple GBs =
are required by application. Otherwise, I&#39;m using dmap_map_page(). Admi=
ttedly, I&#39;m learning these concepts/APIs for Linux along the way.<br></=
div><div class=3D"gmail_default" style=3D"font-family:monospace"><br></div>=
<div class=3D"gmail_default" style=3D"font-family:monospace">Thanks,</div><=
div class=3D"gmail_default" style=3D"font-family:monospace">-am</div><div c=
lass=3D"gmail_default" style=3D"font-family:monospace"><br></div></div><br>=
<div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, De=
c 1, 2019 at 7:12 PM Lu Baolu &lt;<a href=3D"mailto:baolu.lu@linux.intel.co=
m">baolu.lu@linux.intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">Hi,<br>
<br>
On 12/2/19 11:00 AM, Anand Misra wrote:<br>
&gt; Thanks, Lu Baolu. This is the dev version we&#39;ve in our company. I =
can <br>
&gt; try on a Ubuntu with a recent kernel version. Although, do you think I=
&#39;m=C2=A0 &gt; going in the right direction? Is it possible to have mult=
iple hugepages<br>
&gt; mapped via iommu to get contiguous mapping for DMA?<br>
&gt;<br>
<br>
You mentioned:<br>
<br>
&quot;<br>
I&#39;m trying to use iommu for multiple hugepages (mmap&#39;ed by process =
and<br>
pushed to driver via ioctl). The expectation is to have multiple<br>
hugepages mapped via iommu with each huge page having an entry in iommu<br>
(i.e. minimize table walk for DMA). Is this possible?<br>
&quot;<br>
<br>
Currently huge page mapping is hidden in iommu driver according to the<br>
iommu capability and size of map range. Why do you want to be aware of<br>
it in driver or even application level?<br>
<br>
Best regards,<br>
baolu<br>
<br>
&gt; -am<br>
&gt; <br>
&gt; <br>
&gt; On Sun, Dec 1, 2019 at 6:24 PM Lu Baolu &lt;<a href=3D"mailto:baolu.lu=
@linux.intel.com" target=3D"_blank">baolu.lu@linux.intel.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:baolu.lu@linux.intel.com" target=3D"_blan=
k">baolu.lu@linux.intel.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 12/2/19 9:46 AM, Anand Misra wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Hello:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; I&#39;m in process of adding iommu support in=
 my driver for a PCIe<br>
&gt;=C2=A0 =C2=A0 =C2=A0device.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; The device doesn&#39;t publish ACS/ATS via it=
s config space. I&#39;ve<br>
&gt;=C2=A0 =C2=A0 =C2=A0following<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; config:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Linux cmdline: &quot;intel-iommu=3Don iommu=
=3Dpt<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; vfio_iommu_type1.allow_unsafe_interrupts=3D1<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0pcie_acs_override=3Ddownstream&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Centos kernel: 3.10.0-1062.1.2.el7.x86_64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Can you please use the latest kernel for test? 3.10=
 seems to be pretty<br>
&gt;=C2=A0 =C2=A0 =C2=A0old and there are a lot of changes after it.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Best regards,<br>
&gt;=C2=A0 =C2=A0 =C2=A0baolu<br>
&gt; <br>
</blockquote></div></div>

--000000000000720e650598b040f2--

--===============6447465499289107245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6447465499289107245==--
