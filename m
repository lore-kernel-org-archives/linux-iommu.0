Return-Path: <SRS0=bNYQ=AE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7812EC433DF
	for <iommu@archiver.kernel.org>; Tue, 23 Jun 2020 09:35:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C3920771
	for <iommu@archiver.kernel.org>; Tue, 23 Jun 2020 09:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eW+eBtT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C3920771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 142E588257;
	Tue, 23 Jun 2020 09:35:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xXs67FxXAOYE; Tue, 23 Jun 2020 09:35:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id F289D87F0A;
	Tue, 23 Jun 2020 09:35:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5F7EC0890;
	Tue, 23 Jun 2020 09:35:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7618DC016F
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 09:35:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6239288782
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 09:35:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qq0WmlO2rlnS for <iommu@lists.linux-foundation.org>;
 Tue, 23 Jun 2020 09:35:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4EF0A88770
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 09:35:47 +0000 (UTC)
Received: by mail-ot1-f67.google.com with SMTP id k15so15921181otp.8
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 02:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v1R6rHfzQNI9LvZ5tWWNpYtvel4o9JdZjg0t805zn04=;
 b=eW+eBtT06ljtvfARO56uh8ro1uaTHiZ9kwmgCOys7mMAIpC9tJ0/yNQvDWwFzvTKtc
 2K0zZqA2BHn4Twyg/8ww4MUYWe6izSfAyFI3WWvi4lzX+eOnz3U6fGld1GSWlTP9MTul
 i1OA3gzdH61Us/fatpKr+4l8U8313vGwPPZqvtGIFmnVa8RmFqxdA3tgS1TOLMTPdnDX
 r8mQtkHQ86IPfgOA0cUAemxRlTX/1CmPIQLQFAIa+uOMSnRB0WHYFoLNdOExS30v3tXe
 jL6LJeAuQXL7VyRAs/b4h9Dmmk+YX4TDCKtTNMQrhYCzTZ+Ba9ythdpvlmWRiKp7P85+
 7fCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v1R6rHfzQNI9LvZ5tWWNpYtvel4o9JdZjg0t805zn04=;
 b=YetELFbZJCsOWUgWWGgOGTkq7EgmS9p66qs4ZeIxjE3h7i1UBhVJ1etfW8iCbU6si0
 kdr/bJ3rYk4yEKctj2rF5rbMWIUOZ7yjwkRApiig8W+GcGJXkuWzwgTCiZpT+RCtLsIC
 X2PllWF23hgGSEN1tdAfGqacBQxIMXftCNPdYtfZuUCtuEg31dfYs1KxaUI4EEAXXjSk
 0eOkI3GR5QzCsszPvnrYl+O0VhdaN7X+8M5qUO0R5myUEZmehLewfuNq/YiUNg2Xwmoo
 mnSMeLTL2sTQGC22cdBAu0FS+b+ps3lJXiHHF9Bp8wCQVQ6rioQVcQR7NbKL96Vujn5n
 XXGw==
X-Gm-Message-State: AOAM530Q6cm6m5sy7WIt+IDPBM4wDIn+bxgsYshbB3wjGYiwwWyCOPTg
 IgQQ0yGLugUEJsMTGkkPLD1bH/yk1sXdGrIj7Dg=
X-Google-Smtp-Source: ABdhPJwMUB5hpneOaFh3ctkwVQjnHB3cDNCt7wHl6X4ViNY2Vc7uQ01e09/BXub2oGVxtRmUBGzfqQ98bEaBFvYvWUo=
X-Received: by 2002:a05:6830:2017:: with SMTP id
 e23mr10321861otp.303.1592904946395; 
 Tue, 23 Jun 2020 02:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <1592846920-45338-5-git-send-email-john.garry@huawei.com>
 <202006230905.3HpPgtSC%lkp@intel.com>
 <5ba2e240-b324-d316-c00c-38c03ee49baa@huawei.com>
In-Reply-To: <5ba2e240-b324-d316-c00c-38c03ee49baa@huawei.com>
From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Date: Tue, 23 Jun 2020 11:35:35 +0200
Message-ID: <CADRDgG4=uD3Ni6r7D3kHdSo=ketaXKGririHfFvPYq4qz8KjfQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] iommu/arm-smmu-v3: Remove cmpxchg() in
 arm_smmu_cmdq_issue_cmdlist()
To: John Garry <john.garry@huawei.com>
Cc: "trivial@kernel.org" <trivial@kernel.org>,
 kernel test robot <lkp@intel.com>, will@kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linuxarm <linuxarm@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "maz@kernel.org" <maz@kernel.org>,
 "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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
Content-Type: multipart/mixed; boundary="===============2786969494739377770=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============2786969494739377770==
Content-Type: multipart/alternative; boundary="0000000000007daf8105a8bd1572"

--0000000000007daf8105a8bd1572
Content-Type: text/plain; charset="UTF-8"

Hi

Den tis 23 juni 2020 11:22John Garry <john.garry@huawei.com> skrev:

> On 23/06/2020 02:07, kernel test robot wrote:
>
> + Rikard, as the GENMASK compile-time sanity checks were added recently
>
> > Hi John,
> >
> > I love your patch! Perhaps something to improve:
> >
> > [auto build test WARNING on iommu/next]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use  as documented in
> > https://git-scm.com/docs/git-format-patch]
> >
> > url:
> https://github.com/0day-ci/linux/commits/John-Garry/iommu-arm-smmu-v3-Improve-cmdq-lock-efficiency/20200623-013438
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
> next
> > config: arm64-randconfig-c024-20200622 (attached as .config)
> > compiler: aarch64-linux-gcc (GCC) 9.3.0
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> >
> > In file included from include/linux/bits.h:23,
> > from include/linux/ioport.h:15,
> > from include/linux/acpi.h:12,
> > from drivers/iommu/arm-smmu-v3.c:12:
> > drivers/iommu/arm-smmu-v3.c: In function 'arm_smmu_cmdq_issue_cmdlist':
> > include/linux/bits.h:26:28: warning: comparison of unsigned expression <
> 0 is always false [-Wtype-limits]
> > 26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
>
> I'd say that GENMASK_INPUT_CHECK() should be able to handle a l=0 and
> h=unsigned value, so I doubt this warn.
>
> Using GENMASK((int)cmdq->q.llq.max_n_shift, 0) resolves it, but it looks
> like GENMASK_INPUT_CHECK() could be improved.
>

Indeed it could, it is fixed in -next.

Rikard

> |                            ^
> > include/linux/build_bug.h:16:62: note: in definition of macro
> 'BUILD_BUG_ON_ZERO'
> > 16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e));
> })))
> > |                                                              ^
> > include/linux/bits.h:39:3: note: in expansion of macro
> 'GENMASK_INPUT_CHECK'
> > 39 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> > |   ^~~~~~~~~~~~~~~~~~~
> >>> drivers/iommu/arm-smmu-v3.c:1404:18: note: in expansion of macro
> 'GENMASK'
> > 1404 |  u32 prod_mask = GENMASK(cmdq->q.llq.max_n_shift, 0);
> > |                  ^~~~~~~
> > include/linux/bits.h:26:40: warning: comparison of unsigned expression <
> 0 is always false [-Wtype-limits]
> > 26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> > |                                        ^
> > include/linux/build_bug.h:16:62: note: in definition of macro
> 'BUILD_BUG_ON_ZERO'
> > 16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e));
> })))
> > |                                                              ^
> > include/linux/bits.h:39:3: note: in expansion of macro
> 'GENMASK_INPUT_CHECK'
> > 39 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> > |   ^~~~~~~~~~~~~~~~~~~
> >>> drivers/iommu/arm-smmu-v3.c:1404:18: note: in expansion of macro
> 'GENMASK'
> > 1404 |  u32 prod_mask = GENMASK(cmdq->q.llq.max_n_shift, 0);
> > |                  ^~~~~~~
> >
> > vim +/GENMASK +1404 drivers/iommu/arm-smmu-v3.c
>
>
>

--0000000000007daf8105a8bd1572
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi<br><br><div class=3D"gmail_quote"><div dir=3D"ltr=
" class=3D"gmail_attr">Den tis 23 juni 2020 11:22John Garry &lt;<a href=3D"=
mailto:john.garry@huawei.com">john.garry@huawei.com</a>&gt; skrev:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">On 23/06/2020 02:07, kernel test robot wrot=
e:<br>
<br>
+ Rikard, as the GENMASK compile-time sanity checks were added recently<br>
<br>
&gt; Hi John,<br>
&gt; <br>
&gt; I love your patch! Perhaps something to improve:<br>
&gt; <br>
&gt; [auto build test WARNING on iommu/next]<br>
&gt; [If your patch is applied to the wrong git tree, kindly drop us a note=
.<br>
&gt; And when submitting patch, we suggest to use=C2=A0 as documented in<br=
>
&gt; <a href=3D"https://git-scm.com/docs/git-format-patch" rel=3D"noreferre=
r noreferrer" target=3D"_blank">https://git-scm.com/docs/git-format-patch</=
a>]<br>
&gt; <br>
&gt; url:=C2=A0 =C2=A0 <a href=3D"https://github.com/0day-ci/linux/commits/=
John-Garry/iommu-arm-smmu-v3-Improve-cmdq-lock-efficiency/20200623-013438" =
rel=3D"noreferrer noreferrer" target=3D"_blank">https://github.com/0day-ci/=
linux/commits/John-Garry/iommu-arm-smmu-v3-Improve-cmdq-lock-efficiency/202=
00623-013438</a><br>
&gt; base:=C2=A0 =C2=A0<a href=3D"https://git.kernel.org/pub/scm/linux/kern=
el/git/joro/iommu.git" rel=3D"noreferrer noreferrer" target=3D"_blank">http=
s://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git</a> next<br>
&gt; config: arm64-randconfig-c024-20200622 (attached as .config)<br>
&gt; compiler: aarch64-linux-gcc (GCC) 9.3.0<br>
&gt; <br>
&gt; If you fix the issue, kindly add following tag as appropriate<br>
&gt; Reported-by: kernel test robot &lt;<a href=3D"mailto:lkp@intel.com" ta=
rget=3D"_blank" rel=3D"noreferrer">lkp@intel.com</a>&gt;<br>
&gt; <br>
&gt; All warnings (new ones prefixed by &gt;&gt;, old ones prefixed by &lt;=
&lt;):<br>
&gt; <br>
&gt; In file included from include/linux/bits.h:23,<br>
&gt; from include/linux/ioport.h:15,<br>
&gt; from include/linux/acpi.h:12,<br>
&gt; from drivers/iommu/arm-smmu-v3.c:12:<br>
&gt; drivers/iommu/arm-smmu-v3.c: In function &#39;arm_smmu_cmdq_issue_cmdl=
ist&#39;:<br>
&gt; include/linux/bits.h:26:28: warning: comparison of unsigned expression=
 &lt; 0 is always false [-Wtype-limits]<br>
&gt; 26 |=C2=A0 =C2=A0__builtin_constant_p((l) &gt; (h)), (l) &gt; (h), 0))=
)<br>
<br>
I&#39;d say that GENMASK_INPUT_CHECK() should be able to handle a l=3D0 and=
 <br>
h=3Dunsigned value, so I doubt this warn.<br>
<br>
Using GENMASK((int)cmdq-&gt;q.llq.max_n_shift, 0) resolves it, but it looks=
 <br>
like GENMASK_INPUT_CHECK() could be improved.<br></blockquote></div></div><=
div dir=3D"auto"><br></div><div dir=3D"auto">Indeed it could, it is fixed i=
n -next.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Rikard=C2=A0</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>
&gt; include/linux/build_bug.h:16:62: note: in definition of macro &#39;BUI=
LD_BUG_ON_ZERO&#39;<br>
&gt; 16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e));=
 })))<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^=
<br>
&gt; include/linux/bits.h:39:3: note: in expansion of macro &#39;GENMASK_IN=
PUT_CHECK&#39;<br>
&gt; 39 |=C2=A0 (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))<br>
&gt; |=C2=A0 =C2=A0^~~~~~~~~~~~~~~~~~~<br>
&gt;&gt;&gt; drivers/iommu/arm-smmu-v3.c:1404:18: note: in expansion of mac=
ro &#39;GENMASK&#39;<br>
&gt; 1404 |=C2=A0 u32 prod_mask =3D GENMASK(cmdq-&gt;q.llq.max_n_shift, 0);=
<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~=
~<br>
&gt; include/linux/bits.h:26:40: warning: comparison of unsigned expression=
 &lt; 0 is always false [-Wtype-limits]<br>
&gt; 26 |=C2=A0 =C2=A0__builtin_constant_p((l) &gt; (h)), (l) &gt; (h), 0))=
)<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br=
>
&gt; include/linux/build_bug.h:16:62: note: in definition of macro &#39;BUI=
LD_BUG_ON_ZERO&#39;<br>
&gt; 16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e));=
 })))<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^=
<br>
&gt; include/linux/bits.h:39:3: note: in expansion of macro &#39;GENMASK_IN=
PUT_CHECK&#39;<br>
&gt; 39 |=C2=A0 (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))<br>
&gt; |=C2=A0 =C2=A0^~~~~~~~~~~~~~~~~~~<br>
&gt;&gt;&gt; drivers/iommu/arm-smmu-v3.c:1404:18: note: in expansion of mac=
ro &#39;GENMASK&#39;<br>
&gt; 1404 |=C2=A0 u32 prod_mask =3D GENMASK(cmdq-&gt;q.llq.max_n_shift, 0);=
<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~=
~<br>
&gt; <br>
&gt; vim +/GENMASK +1404 drivers/iommu/arm-smmu-v3.c<br>
<br>
<br>
</blockquote></div></div></div>

--0000000000007daf8105a8bd1572--

--===============2786969494739377770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2786969494739377770==--
