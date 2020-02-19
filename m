Return-Path: <SRS0=JfOd=4H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71C7C34056
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 18:57:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A483A2064C
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 18:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="UF5CLgMF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A483A2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6D42A203FD;
	Wed, 19 Feb 2020 18:57:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c87PjR3CFaEI; Wed, 19 Feb 2020 18:57:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id ABF9C20355;
	Wed, 19 Feb 2020 18:57:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 920A5C1D80;
	Wed, 19 Feb 2020 18:57:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 771C1C013E
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 18:57:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6482686974
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 18:57:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vV4Bmi9j8BbX for <iommu@lists.linux-foundation.org>;
 Wed, 19 Feb 2020 18:57:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E42D08461B
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 18:57:17 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id e8so1823867wrm.5
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 10:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AoyqCRzkYZXtU+rwBHKwzenmOanHoC+YkT8sbj/4rTM=;
 b=UF5CLgMF4HpgUgudzBAhRirn91yrif05F7zCWfgJO6U7Ftmbdbrw4jRtUMrxL+J3c+
 N75J+X5xn1922DGsWNv+KF/5RIwA8geZHj07M6zPMTJqCUX7K+8rjJNPLU1m6TP1P4Eu
 htkN9p+8eOLmuLnR/NLq6BshmvWK6aZGsxZKDDAWF2qa1atC6QZqUCsTnMoV6p6mgwoe
 858GvJqQ2oN/XIppTs3X2oO/1Gp2Aqiaw7xVPqrgf7Z6AYdQj52vJvPaqZ0MN4+/p8pV
 7XJk73x3gW5T7Cnyg3jbpX9lpgt6Tk6CO8JJhMcFkTWRkygTYiGjxQMAfX9jF0L5Ev95
 V+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AoyqCRzkYZXtU+rwBHKwzenmOanHoC+YkT8sbj/4rTM=;
 b=qAKdp7huWWOhu6ioYXR7IQewxuzmRo1dNc0ObbTUX+amD73hpVFGnmYYGkEqU1wMJe
 HmltTmKxocfzPn6WrszLgqXmx9IXqgQ8XAZyuKV6idqTKCkkgbdhehkM7QDKbWbKgJ9I
 5K5k2ve9mKmhx1dtpsKpGmMO/mko3UkGK+wj3krF/okviLAVlyzodaxY3Ap+lOZudxSi
 Cvmww1uNodpRfhmgZE6UjugFtAkmVtHDtcypA9y1n74Ao4bCn7dqzxCwMxJVHcU0gktX
 aHIRnWFlbYaILAA0ppMgv4BAHBxcS00c14iUGcMimRCDjYecw7JbUb3tcbl5DA6lvrph
 0T8w==
X-Gm-Message-State: APjAAAUBjW8qNnoPjLUw+W7PsQg+3/b6k+bI6xqj9RC9GgFTl89D8+AW
 q73voVISFFfKxE92sJoEgkXbI4mFT/sIUJgeBgMbIarUWvc=
X-Google-Smtp-Source: APXvYqzWizp4siqBgqn0gF3a09PvHwhmU3+DWZ3+bOHFqMZjsWjZBjN22klW+iUJp2MW32ue0IWwQJnAIbEV/DmbXyY=
X-Received: by 2002:a05:6402:3191:: with SMTP id
 di17mr25233629edb.283.1582138313037; 
 Wed, 19 Feb 2020 10:51:53 -0800 (PST)
MIME-Version: 1.0
References: <20200218222324.231915-1-yonghyun@google.com>
 <8efc6ea2-d51e-624c-5cc2-4049bb224122@linux.intel.com>
 <20200219044235.GA1397@epycbox.lan>
In-Reply-To: <20200219044235.GA1397@epycbox.lan>
Date: Wed, 19 Feb 2020 10:51:42 -0800
Message-ID: <CAEauFbw_FGWuQJMpr7PgyyCAefKChXoszKAz-ykBKgxFc-aa4g@mail.gmail.com>
Subject: Re: [PATCH] iommu/vt-d: Fix a bug in intel_iommu_iova_to_phys() for
 huge page
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, Havard Skinnemoen <hskinnemoen@google.com>,
 iommu@lists.linux-foundation.org, Deepa Dinamani <deepadinamani@google.com>,
 Moritz Fischer <moritzf@google.com>, David Woodhouse <dwmw2@infradead.org>
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
From: Yonghyun Hwang via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yonghyun Hwang <yonghyun@google.com>
Content-Type: multipart/mixed; boundary="===============6532765396965694390=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============6532765396965694390==
Content-Type: multipart/alternative; boundary="00000000000022c793059ef248d4"

--00000000000022c793059ef248d4
Content-Type: text/plain; charset="UTF-8"

Hello Lu and Moritz,

I think it's better to keep "if (level > 1)" because level_to_offset_bits()
returns (unsigned int) -1 * LEVEL_STRIDE if level becomes 0.

static inline unsigned int level_to_offset_bits(int level)
{
  return (level - 1) * LEVEL_STRIDE;
}

On Tue, Feb 18, 2020 at 8:42 PM Moritz Fischer <mdf@kernel.org> wrote:

> Hi Baolu, Yonghyun
>
> On Wed, Feb 19, 2020 at 11:15:36AM +0800, Lu Baolu wrote:
> > Hi Yonghyun,
> >
> > Thanks for the patch.
> >
> > On 2020/2/19 6:23, Yonghyun Hwang wrote:
> > > intel_iommu_iova_to_phys() has a bug when it translates an IOVA for a
> huge
> > > page onto its corresponding physical address. This commit fixes the
> bug by
> > > accomodating the level of page entry for the IOVA and adds IOVA's lower
> > > address to the physical address. >
> > > Signed-off-by: Yonghyun Hwang <yonghyun@google.com>
> > > ---
> > >   drivers/iommu/intel-iommu.c | 11 +++++++++--
> > >   1 file changed, 9 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > > index 0c8d81f56a30..ed6e69adb578 100644
> > > --- a/drivers/iommu/intel-iommu.c
> > > +++ b/drivers/iommu/intel-iommu.c
> > > @@ -5555,13 +5555,20 @@ static phys_addr_t
> intel_iommu_iova_to_phys(struct iommu_domain *domain,
> > >     struct dma_pte *pte;
> > >     int level = 0;
> > >     u64 phys = 0;
> > > +   const unsigned long pfn = iova >> VTD_PAGE_SHIFT;
> >
> > Why do you need a "const unsigned long" here?
>


It's because pfn_to_dma_pte() takes pfn for its second parameter as
"unsigned int" type and pfn is not changed in intel_iommu_iova_to_phys().



> >
> > >     if (dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN)
> > >             return 0;
> > > -   pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level);
> > > -   if (pte)
> > > +   pte = pfn_to_dma_pte(dmar_domain, pfn, &level);
> > > +   if (pte) {
> > >             phys = dma_pte_addr(pte);
> > > +           if (level > 1)
> > > +                   phys += (pfn &
> > > +                           ((1UL << level_to_offset_bits(level)) - 1))
> > > +                           << VTD_PAGE_SHIFT;
> > > +           phys += iova & (VTD_PAGE_SIZE - 1);
> >
> > How about
>
> >
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index 9dc37672bf89..bd17c2510bb2 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -5693,8 +5693,14 @@ static phys_addr_t intel_iommu_iova_to_phys(struct
> > iommu_domain *domain,
> >         u64 phys = 0;
> >
> >         pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT,
> &level);
> > -       if (pte)
> > +       if (pte) {
> > +               unsigned long offset_mask;
> > +
> > +               offset_mask = BIT_MASK(level_to_offset_bits(level) +
> > +                                      VTD_PAGE_SHIFT) - 1;
> >                 phys = dma_pte_addr(pte);
> > +               phys += iova & (bitmask - 1);
> Did you mean:
>
> phys += iova & (offset_mask - 1);
>
> > +       }
>
> At that point why not define a helper:
>
> static inline unsigned long offset_mask(int level)
> {
>         return BIT_MASK(level_to_offset_bits(level) + VTD_PAGE_SHIFT) - 1;
> }
>
> At which point the above would reduce to:
>
> if (pte)
>         phys = dma_pte_addr(pte) + iova & offset_mask(level) - 1;
>


Let me introduce the helper function and upstream the patch again. Thank
you Lu and Moritz.



>
> I might've fatfingered something here, but you get the idea :)
>
> Cheers,
> Moritz
>

On Tue, Feb 18, 2020 at 8:42 PM Moritz Fischer <mdf@kernel.org> wrote:

> Hi Baolu, Yonghyun
>
> On Wed, Feb 19, 2020 at 11:15:36AM +0800, Lu Baolu wrote:
> > Hi Yonghyun,
> >
> > Thanks for the patch.
> >
> > On 2020/2/19 6:23, Yonghyun Hwang wrote:
> > > intel_iommu_iova_to_phys() has a bug when it translates an IOVA for a
> huge
> > > page onto its corresponding physical address. This commit fixes the
> bug by
> > > accomodating the level of page entry for the IOVA and adds IOVA's lower
> > > address to the physical address. >
> > > Signed-off-by: Yonghyun Hwang <yonghyun@google.com>
> > > ---
> > >   drivers/iommu/intel-iommu.c | 11 +++++++++--
> > >   1 file changed, 9 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > > index 0c8d81f56a30..ed6e69adb578 100644
> > > --- a/drivers/iommu/intel-iommu.c
> > > +++ b/drivers/iommu/intel-iommu.c
> > > @@ -5555,13 +5555,20 @@ static phys_addr_t
> intel_iommu_iova_to_phys(struct iommu_domain *domain,
> > >     struct dma_pte *pte;
> > >     int level = 0;
> > >     u64 phys = 0;
> > > +   const unsigned long pfn = iova >> VTD_PAGE_SHIFT;
> >
> > Why do you need a "const unsigned long" here?
> >
> > >     if (dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN)
> > >             return 0;
> > > -   pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level);
> > > -   if (pte)
> > > +   pte = pfn_to_dma_pte(dmar_domain, pfn, &level);
> > > +   if (pte) {
> > >             phys = dma_pte_addr(pte);
> > > +           if (level > 1)
> > > +                   phys += (pfn &
> > > +                           ((1UL << level_to_offset_bits(level)) - 1))
> > > +                           << VTD_PAGE_SHIFT;
> > > +           phys += iova & (VTD_PAGE_SIZE - 1);
> >
> > How about
>
> >
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index 9dc37672bf89..bd17c2510bb2 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -5693,8 +5693,14 @@ static phys_addr_t intel_iommu_iova_to_phys(struct
> > iommu_domain *domain,
> >         u64 phys = 0;
> >
> >         pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT,
> &level);
> > -       if (pte)
> > +       if (pte) {
> > +               unsigned long offset_mask;
> > +
> > +               offset_mask = BIT_MASK(level_to_offset_bits(level) +
> > +                                      VTD_PAGE_SHIFT) - 1;
> >                 phys = dma_pte_addr(pte);
> > +               phys += iova & (bitmask - 1);
> Did you mean:
>
> phys += iova & (offset_mask - 1);
>
> > +       }
>
> At that point why not define a helper:
>
> static inline unsigned long offset_mask(int level)
> {
>         return BIT_MASK(level_to_offset_bits(level) + VTD_PAGE_SHIFT) - 1;
> }
>
> At which point the above would reduce to:
>
> if (pte)
>         phys = dma_pte_addr(pte) + iova & offset_mask(level) - 1;
>
> I might've fatfingered something here, but you get the idea :)
>
> Cheers,
> Moritz
>

--00000000000022c793059ef248d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace,monospace">Hello Lu and Moritz,</div><div class=3D"gmail=
_default" style=3D"font-family:monospace,monospace"><br></div><div class=3D=
"gmail_default" style=3D"font-family:monospace,monospace">I think it&#39;s =
better to keep &quot;if (level &gt; 1)&quot; because level_to_offset_bits()=
 returns (unsigned int) -1 * LEVEL_STRIDE if level becomes 0.</div><div cla=
ss=3D"gmail_default" style=3D"font-family:monospace,monospace"><br></div><d=
iv class=3D"gmail_default" style=3D"font-family:monospace,monospace">static=
 inline unsigned int level_to_offset_bits(int level)<br>{<br>=C2=A0 return =
(level - 1) * LEVEL_STRIDE;<br>}</div></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 18, 2020 at 8:42 PM Morit=
z Fischer &lt;<a href=3D"mailto:mdf@kernel.org">mdf@kernel.org</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Baolu, Yon=
ghyun<br>
<br>
On Wed, Feb 19, 2020 at 11:15:36AM +0800, Lu Baolu wrote:<br>
&gt; Hi Yonghyun,<br>
&gt; <br>
&gt; Thanks for the patch.<br>
&gt; <br>
&gt; On 2020/2/19 6:23, Yonghyun Hwang wrote:<br>
&gt; &gt; intel_iommu_iova_to_phys() has a bug when it translates an IOVA f=
or a huge<br>
&gt; &gt; page onto its corresponding physical address. This commit fixes t=
he bug by<br>
&gt; &gt; accomodating the level of page entry for the IOVA and adds IOVA&#=
39;s lower<br>
&gt; &gt; address to the physical address. &gt;<br>
&gt; &gt; Signed-off-by: Yonghyun Hwang &lt;<a href=3D"mailto:yonghyun@goog=
le.com" target=3D"_blank">yonghyun@google.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 =C2=A0drivers/iommu/intel-iommu.c | 11 +++++++++--<br>
&gt; &gt;=C2=A0 =C2=A01 file changed, 9 insertions(+), 2 deletions(-)<br>
&gt; &gt; <br>
&gt; &gt; diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-io=
mmu.c<br>
&gt; &gt; index 0c8d81f56a30..ed6e69adb578 100644<br>
&gt; &gt; --- a/drivers/iommu/intel-iommu.c<br>
&gt; &gt; +++ b/drivers/iommu/intel-iommu.c<br>
&gt; &gt; @@ -5555,13 +5555,20 @@ static phys_addr_t intel_iommu_iova_to_ph=
ys(struct iommu_domain *domain,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0struct dma_pte *pte;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0int level =3D 0;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0u64 phys =3D 0;<br>
&gt; &gt; +=C2=A0 =C2=A0const unsigned long pfn =3D iova &gt;&gt; VTD_PAGE_=
SHIFT;<br>
&gt; <br>
&gt; Why do you need a &quot;const unsigned long&quot; here?<br></blockquot=
e><div><span style=3D"font-family:monospace,monospace"></span><br></div><di=
v><div><br></div><div><div class=3D"gmail_default" style=3D"font-family:mon=
ospace,monospace">It&#39;s because pfn_to_dma_pte() takes pfn for its secon=
d parameter as &quot;unsigned int&quot; type and pfn is not changed in=C2=
=A0intel_iommu_iova_to_phys().</div></div></div><div><br></div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0if (dmar_domain-&gt;flags &amp; DOMAIN_FLAG_LO=
SE_CHILDREN)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt; -=C2=A0 =C2=A0pte =3D pfn_to_dma_pte(dmar_domain, iova &gt;&gt; V=
TD_PAGE_SHIFT, &amp;level);<br>
&gt; &gt; -=C2=A0 =C2=A0if (pte)<br>
&gt; &gt; +=C2=A0 =C2=A0pte =3D pfn_to_dma_pte(dmar_domain, pfn, &amp;level=
);<br>
&gt; &gt; +=C2=A0 =C2=A0if (pte) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys =3D dma_pte_a=
ddr(pte);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (level &gt; 1)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0phys +=3D (pfn &amp;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((1UL &lt;&lt; level_to_offset_bits(level=
)) - 1))<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;&lt; VTD_PAGE_SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys +=3D iova &amp; (V=
TD_PAGE_SIZE - 1);<br>
&gt; <br>
&gt; How about<br>
<br>
&gt; <br>
&gt; diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c=
<br>
&gt; index 9dc37672bf89..bd17c2510bb2 100644<br>
&gt; --- a/drivers/iommu/intel-iommu.c<br>
&gt; +++ b/drivers/iommu/intel-iommu.c<br>
&gt; @@ -5693,8 +5693,14 @@ static phys_addr_t intel_iommu_iova_to_phys(str=
uct<br>
&gt; iommu_domain *domain,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 phys =3D 0;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pte =3D pfn_to_dma_pte(dmar_domain, i=
ova &gt;&gt; VTD_PAGE_SHIFT, &amp;level);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pte)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pte) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long =
offset_mask;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offset_mask =
=3D BIT_MASK(level_to_offset_bits(level) +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VTD_PAGE_SH=
IFT) - 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys =3D =
dma_pte_addr(pte);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys +=3D iova=
 &amp; (bitmask - 1);<br>
Did you mean:<br>
<br>
phys +=3D iova &amp; (offset_mask - 1);<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
At that point why not define a helper:<br>
<br>
static inline unsigned long offset_mask(int level)<br>
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return BIT_MASK(level_to_offset_bits(level) + V=
TD_PAGE_SHIFT) - 1;<br>
}<br>
<br>
At which point the above would reduce to:<br>
<br>
if (pte)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 phys =3D dma_pte_addr(pte) + iova &amp; offset_=
mask(level) - 1;<br></blockquote><div><br></div><div><br></div><div><div cl=
ass=3D"gmail_default" style=3D"font-family:monospace,monospace">Let me intr=
oduce the helper function and upstream the patch again. Thank you Lu and Mo=
ritz.</div></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
<br>
I might&#39;ve fatfingered something here, but you get the idea :)<br>
<br>
Cheers,<br>
Moritz<br>
</blockquote></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Tue, Feb 18, 2020 at 8:42 PM Moritz Fischer &lt;<a hr=
ef=3D"mailto:mdf@kernel.org">mdf@kernel.org</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">Hi Baolu, Yonghyun<br>
<br>
On Wed, Feb 19, 2020 at 11:15:36AM +0800, Lu Baolu wrote:<br>
&gt; Hi Yonghyun,<br>
&gt; <br>
&gt; Thanks for the patch.<br>
&gt; <br>
&gt; On 2020/2/19 6:23, Yonghyun Hwang wrote:<br>
&gt; &gt; intel_iommu_iova_to_phys() has a bug when it translates an IOVA f=
or a huge<br>
&gt; &gt; page onto its corresponding physical address. This commit fixes t=
he bug by<br>
&gt; &gt; accomodating the level of page entry for the IOVA and adds IOVA&#=
39;s lower<br>
&gt; &gt; address to the physical address. &gt;<br>
&gt; &gt; Signed-off-by: Yonghyun Hwang &lt;<a href=3D"mailto:yonghyun@goog=
le.com" target=3D"_blank">yonghyun@google.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 =C2=A0drivers/iommu/intel-iommu.c | 11 +++++++++--<br>
&gt; &gt;=C2=A0 =C2=A01 file changed, 9 insertions(+), 2 deletions(-)<br>
&gt; &gt; <br>
&gt; &gt; diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-io=
mmu.c<br>
&gt; &gt; index 0c8d81f56a30..ed6e69adb578 100644<br>
&gt; &gt; --- a/drivers/iommu/intel-iommu.c<br>
&gt; &gt; +++ b/drivers/iommu/intel-iommu.c<br>
&gt; &gt; @@ -5555,13 +5555,20 @@ static phys_addr_t intel_iommu_iova_to_ph=
ys(struct iommu_domain *domain,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0struct dma_pte *pte;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0int level =3D 0;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0u64 phys =3D 0;<br>
&gt; &gt; +=C2=A0 =C2=A0const unsigned long pfn =3D iova &gt;&gt; VTD_PAGE_=
SHIFT;<br>
&gt; <br>
&gt; Why do you need a &quot;const unsigned long&quot; here?<br>
&gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0if (dmar_domain-&gt;flags &amp; DOMAIN_FLAG_LO=
SE_CHILDREN)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt; -=C2=A0 =C2=A0pte =3D pfn_to_dma_pte(dmar_domain, iova &gt;&gt; V=
TD_PAGE_SHIFT, &amp;level);<br>
&gt; &gt; -=C2=A0 =C2=A0if (pte)<br>
&gt; &gt; +=C2=A0 =C2=A0pte =3D pfn_to_dma_pte(dmar_domain, pfn, &amp;level=
);<br>
&gt; &gt; +=C2=A0 =C2=A0if (pte) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys =3D dma_pte_a=
ddr(pte);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (level &gt; 1)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0phys +=3D (pfn &amp;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((1UL &lt;&lt; level_to_offset_bits(level=
)) - 1))<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;&lt; VTD_PAGE_SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys +=3D iova &amp; (V=
TD_PAGE_SIZE - 1);<br>
&gt; <br>
&gt; How about<br>
<br>
&gt; <br>
&gt; diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c=
<br>
&gt; index 9dc37672bf89..bd17c2510bb2 100644<br>
&gt; --- a/drivers/iommu/intel-iommu.c<br>
&gt; +++ b/drivers/iommu/intel-iommu.c<br>
&gt; @@ -5693,8 +5693,14 @@ static phys_addr_t intel_iommu_iova_to_phys(str=
uct<br>
&gt; iommu_domain *domain,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 phys =3D 0;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pte =3D pfn_to_dma_pte(dmar_domain, i=
ova &gt;&gt; VTD_PAGE_SHIFT, &amp;level);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pte)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pte) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long =
offset_mask;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offset_mask =
=3D BIT_MASK(level_to_offset_bits(level) +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VTD_PAGE_SH=
IFT) - 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys =3D =
dma_pte_addr(pte);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys +=3D iova=
 &amp; (bitmask - 1);<br>
Did you mean:<br>
<br>
phys +=3D iova &amp; (offset_mask - 1);<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
At that point why not define a helper:<br>
<br>
static inline unsigned long offset_mask(int level)<br>
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return BIT_MASK(level_to_offset_bits(level) + V=
TD_PAGE_SHIFT) - 1;<br>
}<br>
<br>
At which point the above would reduce to:<br>
<br>
if (pte)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 phys =3D dma_pte_addr(pte) + iova &amp; offset_=
mask(level) - 1;<br>
<br>
I might&#39;ve fatfingered something here, but you get the idea :)<br>
<br>
Cheers,<br>
Moritz<br>
</blockquote></div>

--00000000000022c793059ef248d4--

--===============6532765396965694390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6532765396965694390==--
