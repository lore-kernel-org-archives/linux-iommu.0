Return-Path: <SRS0=C308=ZZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D56C432C0
	for <iommu@archiver.kernel.org>; Tue,  3 Dec 2019 19:22:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6662A20640
	for <iommu@archiver.kernel.org>; Tue,  3 Dec 2019 19:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIdy+RQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6662A20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 145E287895;
	Tue,  3 Dec 2019 19:22:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wmNYErJDt8ZM; Tue,  3 Dec 2019 19:22:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B1C7086FB1;
	Tue,  3 Dec 2019 19:22:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 965DCC1799;
	Tue,  3 Dec 2019 19:22:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58DD6C087F
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 19:22:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4714B875D8
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 19:22:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xPBOZiQhdCUF for <iommu@lists.linux-foundation.org>;
 Tue,  3 Dec 2019 19:22:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com
 [209.85.222.44])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E44E4875BE
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 19:22:24 +0000 (UTC)
Received: by mail-ua1-f44.google.com with SMTP id f7so1794274uaa.8
 for <iommu@lists.linux-foundation.org>; Tue, 03 Dec 2019 11:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=IjzzGZnMXj1KU3HaAJmJT6eufBkmQY+QglWM858t3G4=;
 b=WIdy+RQwfvVqOuKU+dZjdl0bp3EoAt9LfvCab9zUumRDVfrwIfiwdhkk13Ky6d5REf
 QF6V9moCJXtF0/563p2HbJIni6SByRdPyEir3Wwi0nkAN5FPc2C7vPZr85rFR9y4MLGK
 FY9pMxCabjRIUAg7gwiXQ6shm6DCtq74bfTl0IvroptBi/ZGXPwpg55il/WVCx75dalz
 78Z8a4bRhul6Axwz9DiFBY437xEFzm/LDmrY1FA0/C7jC00YppkTGSAEipBQSMmBLxt9
 VyvksTNTSx2XrOfm0zVssC9zkOxcdbBgidxJWM1lsL8OPu/YAM4BQsVg9J+Gkrq1luFI
 URrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=IjzzGZnMXj1KU3HaAJmJT6eufBkmQY+QglWM858t3G4=;
 b=Dc3K8o+YC4A55FEIA00mDRZpDhfW5q9wA+H/3E9t1ZevmHknv/dXwQsT4s26Wrqf1i
 sR0P8mkNucu8Kq8lFMtEKptug52bWR1BaDrmCYTREE3Zye5JYT7u4Q/6Eqf5mKeYScZ8
 5fu7MLK92qoEK5qhvmB6ufQOGu1cT11ABVo5/OwPSaaag8cljCOVipnpF1OENSssRuhx
 FoWbAAAznQe6k1fMqzNhPjcgUHsouMTGm6c4uBfFuyKow0qtflwDjUuz5m++AslarYTR
 QHki5qt77PuNJPToqdATHGAZtuybPg0gwH3itACdJ/5FMLFOkIUgDcOpwW3ng8hRNKwk
 nMaw==
X-Gm-Message-State: APjAAAUyg4dCfyzHURlpG8xDp8QN8byWkWJfnjBidwXJzZjwUCkW9zCN
 lf7dlgNu67XsPGBhesy4DwKzgvwtzrtKEJK1WXA9LVkv
X-Google-Smtp-Source: APXvYqwXFUsDR9rxP6oXdVFxb3q54ExIWhm3YXJKWSxbA08NMr65sqRHS8J+xvN5DYkRXJVcIP+Mzf2D31Oua9dZUyg=
X-Received: by 2002:ab0:786:: with SMTP id c6mr4552141uaf.62.1575400943619;
 Tue, 03 Dec 2019 11:22:23 -0800 (PST)
MIME-Version: 1.0
References: <CAL20ACJ2cM1Zs3q5rb3jG7fDVNfzySV6WX=+nbdKiS4KT52NaQ@mail.gmail.com>
 <f0913338-3854-6ff7-aa8c-85b96efbed27@linux.intel.com>
 <CAL20ACLtwjDLaPattEkPiufsgHa2k-4Wb_Dw7Urh9we0QwbJfQ@mail.gmail.com>
 <da7fb26f-022b-eaad-1a91-11cf15531f8a@linux.intel.com>
 <CAL20ACL_t0zAnQKvfj=VHM1jBLfOuCkCOFoQxn+S1vJoZfU6yg@mail.gmail.com>
In-Reply-To: <CAL20ACL_t0zAnQKvfj=VHM1jBLfOuCkCOFoQxn+S1vJoZfU6yg@mail.gmail.com>
From: AM <am.online.edu@gmail.com>
Date: Tue, 3 Dec 2019 11:22:12 -0800
Message-ID: <CAL20ACLnsBVG6g6BBVASP9jYBzXQJR-y7WRY-D4a8Rv+aZtWCg@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============4721674777466794741=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============4721674777466794741==
Content-Type: multipart/alternative; boundary="0000000000009f92ee0598d19df6"

--0000000000009f92ee0598d19df6
Content-Type: text/plain; charset="UTF-8"

Hi Lu Baolu,

I tried kernel 4.18.0-147.6.el8.x86_64+debug and used the following API
sequence for mapping multiple hugepages:

get_user_pages_fast()
sg_alloc_table_from_pages()
// also tried sg_alloc_table() w/ sg_set_page() using 1GB size for each
entry
dma_map_sg()

I'm able to DMA upto 1GB successfully and validate the data. Also, DMA
above 1GB completes w/o any error, but data isn't correct starting
immediately after 1GB i.e. second GB offset 0x40000000 starts showing data
mismatches.

I've used get_user_pages_fast() in two ways to no avail:
1. populate page array w/ first page of 1GB hugepage and used sg_set_page()
for
   setting 1GB size of the page entry. This debugging effort uses the fact
   that all pages following the first page of huge page start address are
contiguous.
   Ideally dma_map_sg() should coalesce contiguous pages, and my intention
was to collect
   more data from debugging.
2. populate page array w/ all pages from all hugepages

Thanks,
-am



On Sun, Dec 1, 2019 at 7:33 PM Anand Misra <am.online.edu@gmail.com> wrote:

> [+iommu_list]
>
> Application isn't aware of hugepage but a userspace (lower) level stack is
> aware of the type of memory being allocated on behalf of application, which
> in turn communicates w/ driver via ioctl. I'm trying to make it more
> agnostic by using dma_map_sg() when multiple GBs are required by
> application. Otherwise, I'm using dmap_map_page(). Admittedly, I'm learning
> these concepts/APIs for Linux along the way.
>
> Thanks,
> -am
>
>
> On Sun, Dec 1, 2019 at 7:12 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
>> Hi,
>>
>> On 12/2/19 11:00 AM, Anand Misra wrote:
>> > Thanks, Lu Baolu. This is the dev version we've in our company. I can
>> > try on a Ubuntu with a recent kernel version. Although, do you think
>> I'm  > going in the right direction? Is it possible to have multiple
>> hugepages
>> > mapped via iommu to get contiguous mapping for DMA?
>> >
>>
>> You mentioned:
>>
>> "
>> I'm trying to use iommu for multiple hugepages (mmap'ed by process and
>> pushed to driver via ioctl). The expectation is to have multiple
>> hugepages mapped via iommu with each huge page having an entry in iommu
>> (i.e. minimize table walk for DMA). Is this possible?
>> "
>>
>> Currently huge page mapping is hidden in iommu driver according to the
>> iommu capability and size of map range. Why do you want to be aware of
>> it in driver or even application level?
>>
>> Best regards,
>> baolu
>>
>> > -am
>> >
>> >
>> > On Sun, Dec 1, 2019 at 6:24 PM Lu Baolu <baolu.lu@linux.intel.com
>> > <mailto:baolu.lu@linux.intel.com>> wrote:
>> >
>> >     Hi,
>> >
>> >     On 12/2/19 9:46 AM, Anand Misra wrote:
>> >      > Hello:
>> >      >
>> >      > I'm in process of adding iommu support in my driver for a PCIe
>> >     device.
>> >      > The device doesn't publish ACS/ATS via its config space. I've
>> >     following
>> >      > config:
>> >      >
>> >      > Linux cmdline: "intel-iommu=on iommu=pt
>> >      > vfio_iommu_type1.allow_unsafe_interrupts=1
>> >     pcie_acs_override=downstream"
>> >      > Centos kernel: 3.10.0-1062.1.2.el7.x86_64
>> >      >
>> >
>> >     Can you please use the latest kernel for test? 3.10 seems to be
>> pretty
>> >     old and there are a lot of changes after it.
>> >
>> >     Best regards,
>> >     baolu
>> >
>>
>

--0000000000009f92ee0598d19df6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e">Hi Lu Baolu,</div><div class=3D"gmail_default" style=3D"font-family:mono=
space"><br></div><div class=3D"gmail_default" style=3D"font-family:monospac=
e">I tried kernel 4.18.0-147.6.el8.x86_64+debug and used the following API =
sequence for mapping multiple hugepages:</div><div class=3D"gmail_default" =
style=3D"font-family:monospace"><br></div><div class=3D"gmail_default" styl=
e=3D"font-family:monospace">get_user_pages_fast()</div><div class=3D"gmail_=
default" style=3D"font-family:monospace">sg_alloc_table_from_pages()</div><=
div class=3D"gmail_default" style=3D"font-family:monospace"> // also tried =
sg_alloc_table() w/ sg_set_page() using 1GB size for each entry<br></div><d=
iv class=3D"gmail_default" style=3D"font-family:monospace">dma_map_sg()</di=
v><div class=3D"gmail_default" style=3D"font-family:monospace"><br></div><d=
iv class=3D"gmail_default" style=3D"font-family:monospace">I&#39;m able to =
DMA upto 1GB successfully and validate the data. Also, DMA above 1GB comple=
tes w/o any error, but data isn&#39;t correct starting immediately after 1G=
B i.e. second GB offset 0x40000000 starts showing data mismatches.</div><di=
v class=3D"gmail_default" style=3D"font-family:monospace"><br></div><div cl=
ass=3D"gmail_default" style=3D"font-family:monospace">I&#39;ve used get_use=
r_pages_fast() in two ways to no avail:</div><div class=3D"gmail_default" s=
tyle=3D"font-family:monospace">1. populate page array w/ first page of 1GB =
hugepage and used sg_set_page() for</div><div class=3D"gmail_default" style=
=3D"font-family:monospace">=C2=A0=C2=A0 setting 1GB size of the page entry.=
 This debugging effort uses the fact</div><div class=3D"gmail_default" styl=
e=3D"font-family:monospace">=C2=A0=C2=A0 that all pages following the first=
 page of huge page start address are contiguous.</div><div class=3D"gmail_d=
efault" style=3D"font-family:monospace">=C2=A0=C2=A0 Ideally dma_map_sg() s=
hould coalesce contiguous pages, and my intention was to collect</div><div =
class=3D"gmail_default" style=3D"font-family:monospace">=C2=A0=C2=A0 more d=
ata from debugging.<br></div><div class=3D"gmail_default" style=3D"font-fam=
ily:monospace">2. populate page array w/ all pages from all hugepages<br></=
div><div class=3D"gmail_default" style=3D"font-family:monospace"><br></div>=
<div class=3D"gmail_default" style=3D"font-family:monospace">Thanks,</div><=
div style=3D"font-family:monospace" class=3D"gmail_default">-am</div><div c=
lass=3D"gmail_default" style=3D"font-family:monospace"><br></div><div class=
=3D"gmail_default" style=3D"font-family:monospace"><br></div></div><br><div=
 class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Dec 1,=
 2019 at 7:33 PM Anand Misra &lt;<a href=3D"mailto:am.online.edu@gmail.com"=
>am.online.edu@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gma=
il_default" style=3D"font-family:monospace">[+iommu_list]</div><div class=
=3D"gmail_default" style=3D"font-family:monospace"><br></div><div class=3D"=
gmail_default" style=3D"font-family:monospace">Application isn&#39;t aware =
of hugepage but a userspace (lower) level stack is aware of the type of mem=
ory being allocated on behalf of application, which in turn communicates w/=
 driver via ioctl. I&#39;m trying to make it more agnostic by using dma_map=
_sg() when multiple GBs are required by application. Otherwise, I&#39;m usi=
ng dmap_map_page(). Admittedly, I&#39;m learning these concepts/APIs for Li=
nux along the way.<br></div><div class=3D"gmail_default" style=3D"font-fami=
ly:monospace"><br></div><div class=3D"gmail_default" style=3D"font-family:m=
onospace">Thanks,</div><div class=3D"gmail_default" style=3D"font-family:mo=
nospace">-am</div><div class=3D"gmail_default" style=3D"font-family:monospa=
ce"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Sun, Dec 1, 2019 at 7:12 PM Lu Baolu &lt;<a href=3D"mail=
to:baolu.lu@linux.intel.com" target=3D"_blank">baolu.lu@linux.intel.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<=
br>
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
</blockquote></div>

--0000000000009f92ee0598d19df6--

--===============4721674777466794741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4721674777466794741==--
