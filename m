Return-Path: <SRS0=7UOM=KT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150E5C04FF3
	for <iommu@archiver.kernel.org>; Mon, 24 May 2021 12:03:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91AA16109F
	for <iommu@archiver.kernel.org>; Mon, 24 May 2021 12:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AA16109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4EBDE402A0;
	Mon, 24 May 2021 12:03:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fk5o-2Rr404b; Mon, 24 May 2021 12:03:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id D8715402C4;
	Mon, 24 May 2021 12:03:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC344C000D;
	Mon, 24 May 2021 12:03:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C657C0001
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 12:03:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7CCE940286
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 12:03:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SrmaV0Um5TIn for <iommu@lists.linux-foundation.org>;
 Mon, 24 May 2021 12:03:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 545CE40238
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 12:03:51 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 cu11-20020a17090afa8bb029015d5d5d2175so11107336pjb.3
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 05:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oAc7ld9N1Dk1FVKGN5HZxntwSJ+p2Nr0HWoM0dDDuQ4=;
 b=mfK49YKe9N/WtK3lbnD8yOGaCkPOIL6d8JWqYO3oYLsPnPfpBeiaVqI8cUgUK9S/rd
 fivFOitRomrtCm51Ae0STF3b8tUH1H5J8nS44NdBgce4Veh2YPKBSv8sogxew8HSUfpm
 j5237ZL9SG39WtldeRaJmqsXtKAD6ObQTFf4jV4mpP1OVmckfPu7qFa5b2LXxiWUVVR7
 vvS0XCmaUVJJI+9ocDMGm3drLavCbkl+qpQAjIRM1zMd3iQEfbDJ9HmhznWPZXBAvqHe
 WSHphyHzCa9s/2bcMNtjJNSq9XijsYJ8DZ46t4eQXoFhosUC0m5tFU3HU6gPy4qBUQ2r
 VmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oAc7ld9N1Dk1FVKGN5HZxntwSJ+p2Nr0HWoM0dDDuQ4=;
 b=sY5oUjssjSHTB3Hx+9acXeZcQ9kKExt2/HNOcXcgYRyONYG7YqGvcQjzDjgODwGHos
 NmoNnKrmxDUdWJjcV3rISC57o+jwhCG35sfJbWWT589QvxXStLC/TAzITh4CPTOqD4F/
 v0oQqDSB/YYG67RYF5T27gMlJB5pH5wX21il07/GOxh6rB3tTr6X7sfFh/JihNDQXAuq
 mFdeSuld2Rf3HgfpHZaQn5DGwAZo5b9+gTAzLGMfFDnOICNihl2X0e/2TB5tRU2JMwnB
 2Jb0Hd2qfH1IBZ1aTMYpt565DigZWwerl05O0+z766F1xDDkQpHrBaCM2L0r9J4uwq0S
 KlGQ==
X-Gm-Message-State: AOAM530C5CmAnKIYKSrDzeyoOl+SC/UwJtWlGpPwqlEzRLM2qx/SrTrY
 zSlcH56UVaq7X8dnnNAh6hxFbrTWu80gDQKC9L3pUQ==
X-Google-Smtp-Source: ABdhPJxq4jWjyD3HRbunRuiUhSmQrxJbILthUzzX168/93XgwugE1P+/OSCAUZJWBAe4sVCnu4THcNfo1P9Er3RnqVQ=
X-Received: by 2002:a17:90a:4a0e:: with SMTP id
 e14mr25191332pjh.209.1621857830483; 
 Mon, 24 May 2021 05:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191226221709.3844244-1-bjorn.andersson@linaro.org>
 <20200108091641.GA15147@willie-the-truck>
In-Reply-To: <20200108091641.GA15147@willie-the-truck>
From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 24 May 2021 13:03:39 +0100
Message-ID: <CAF2Aj3iKk2LSA5XC76pNiLV8a76BkibUitof-dix8rqkc0qiow@mail.gmail.com>
Subject: Re: [PATCH 0/3] iommu/arm-smmu: Qualcomm bootsplash/efifb
To: Will Deacon <will@kernel.org>
Cc: Patrick Daly <pdaly@codeaurora.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Thierry Reding <treding@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Pratik Patel <pratikp@codeaurora.org>
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
Content-Type: multipart/mixed; boundary="===============0166090039321826061=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============0166090039321826061==
Content-Type: multipart/alternative; boundary="000000000000dcc52405c31233cf"

--000000000000dcc52405c31233cf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Jan 2020 at 09:16, Will Deacon <will@kernel.org> wrote:

> On Thu, Dec 26, 2019 at 02:17:06PM -0800, Bjorn Andersson wrote:
> > These patches implements the stream mapping inheritance that's necessar=
y
> in
> > order to not hit a security violation as the display hardware looses it=
s
> stream
> > mapping during initialization of arm-smmu in various Qualcomm platforms=
.
> >
> > This was previously posted as an RFC [1], changes since then involves t=
he
> > rebase and migration of the read-back code to the Qualcomm specific
> > implementation, the mapping is maintained indefinitely - to handle prob=
e
> > deferring clients - and rewritten commit messages.
>
> I don't think we should solve this in a Qualcomm-specific manner. Please
> can
> you take a look at the proposal from Thierry [1] and see whether or not i=
t
> works for you?
>

Did this or Thierry's solution ever gain traction?

Or are all the parties still 'solving' this downstream?


> Thanks,
>
> Will
>
> [1]
> https://lore.kernel.org/lkml/20191209150748.2471814-1-thierry.reding@gmai=
l.com
>


--=20
Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
Linaro Services Senior Technical Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--000000000000dcc52405c31233cf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Wed, 8 Jan 2020 at 09:16, Will Deacon =
&lt;<a href=3D"mailto:will@kernel.org">will@kernel.org</a>&gt; wrote:<br></=
div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On Thu, Dec 26, 2019 at 02:17:06PM -0800, Bjorn Andersson wrote:<br>
&gt; These patches implements the stream mapping inheritance that&#39;s nec=
essary in<br>
&gt; order to not hit a security violation as the display hardware looses i=
ts stream<br>
&gt; mapping during initialization of arm-smmu in various Qualcomm platform=
s.<br>
&gt; <br>
&gt; This was previously posted as an RFC [1], changes since then involves =
the<br>
&gt; rebase and migration of the read-back code to the Qualcomm specific<br=
>
&gt; implementation, the mapping is maintained indefinitely - to handle pro=
be<br>
&gt; deferring clients - and rewritten commit messages.<br>
<br>
I don&#39;t think we should solve this in a Qualcomm-specific manner. Pleas=
e can<br>
you take a look at the proposal from Thierry [1] and see whether or not it<=
br>
works for you?<br></blockquote><div><br></div><div>Did this or=C2=A0Thierry=
&#39;s solution ever gain traction?</div><div><br></div><div>Or are all the=
 parties still &#39;solving&#39; this downstream?</div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
Thanks,<br>
<br>
Will<br>
<br>
[1] <a href=3D"https://lore.kernel.org/lkml/20191209150748.2471814-1-thierr=
y.reding@gmail.com" rel=3D"noreferrer" target=3D"_blank">https://lore.kerne=
l.org/lkml/20191209150748.2471814-1-thierry.reding@gmail.com</a><br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div=
><span style=3D"font-size:12.8px">Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]</=
span></div><div><span style=3D"font-size:12.8px">Linaro Services Senior Tec=
hnical Lead</span></div><div><span style=3D"font-size:12.8px">Linaro.org =
=E2=94=82 Open source software for ARM SoCs</span></div><div><span style=3D=
"font-size:12.8px">Follow Linaro: Facebook | Twitter | Blog</span></div></d=
iv></div></div></div></div></div>

--000000000000dcc52405c31233cf--

--===============0166090039321826061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0166090039321826061==--
