Return-Path: <SRS0=bJ3n=6P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDD0C4724C
	for <iommu@archiver.kernel.org>; Fri,  1 May 2020 04:48:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D56EB20857
	for <iommu@archiver.kernel.org>; Fri,  1 May 2020 04:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ImTUdlEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56EB20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A5F36882CB;
	Fri,  1 May 2020 04:48:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9+KP6dE+gmcN; Fri,  1 May 2020 04:48:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 49E0888279;
	Fri,  1 May 2020 04:48:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31B36C0864;
	Fri,  1 May 2020 04:48:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE74AC016F
 for <iommu@lists.linux-foundation.org>; Fri,  1 May 2020 02:33:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 942B886DF3
 for <iommu@lists.linux-foundation.org>; Fri,  1 May 2020 02:33:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j9eVYTUxCpQg for <iommu@lists.linux-foundation.org>;
 Fri,  1 May 2020 02:33:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9022C86D39
 for <iommu@lists.linux-foundation.org>; Fri,  1 May 2020 02:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588300424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FmTXwQDIMo+IjpBIspuTIpC6trFCfV96jFy7feBDa3U=;
 b=ImTUdlEggsmq7N1QtnckU3WKGA0GsL5qX4BAzcsXQpsZwTieDq6KlhvAUNFfGrvC4aWOFa
 HFu0Vg1ThMKWDoAfIbKpxbag8lvBIAn9I0pKThT58E72grx3wKIo06a2r8pgn504LUSpET
 htTaFPiZx6J40lFDguggBH/FcP57Xg0=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-5GMjnOeSPJ6w9eWq6hiKfw-1; Thu, 30 Apr 2020 22:33:40 -0400
X-MC-Unique: 5GMjnOeSPJ6w9eWq6hiKfw-1
Received: by mail-vk1-f199.google.com with SMTP id n1so4167559vke.6
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 19:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FmTXwQDIMo+IjpBIspuTIpC6trFCfV96jFy7feBDa3U=;
 b=czINjvkSl3iWsuMHTsz9WAxYHXOuD9spJBOp/7TEO1neh8HZKRcoP4UhNtK6wd25Oq
 Q5b2yb7gc4jNku+Kj2xmsVo3Y4QT2yAJxeiJPvhgswqxYpvySl3VJdEteQLh8EOR5VTa
 Kle4KRFnbjE+ES9dhZOdhp9b+Hl0u9RuflUBqNwoJM9T+hJsZ0G0WR581o2gth/6qBoU
 doJKXtyBrfOqJfmnODsvuovooaan2hjd6O3WysEdVsi0FfMVzAgpscSXJ1iSCr8R9VxH
 ts8eM06Fkqjnm0PcOeqPmGWzuwYJ2BolBywy5g+5jcNzOkao8NJ8zWpgF2lQ1k5iIJeq
 UmPw==
X-Gm-Message-State: AGi0PuZm2biAMhVNSSAL3AWXnS/j4iOj+hzSxTi8tAjqDFqIA7JNM15B
 o4Q36b9rTl/QoKBoIvooOlvOG0Bwm2JHhPsagFPWC8lPV/q4ccRjIvj7iBHQINl4tZNn3FDfyaD
 h/BSVjP/g8S2Z3Yl3dM35H0T5Pn2H1AGJEVeLj0o6lRFXlw==
X-Received: by 2002:a1f:4106:: with SMTP id o6mr1255006vka.52.1588300419596;
 Thu, 30 Apr 2020 19:33:39 -0700 (PDT)
X-Google-Smtp-Source: APiQypKzJZChxr1bIOT3BrCLUuQh+Ikon7C/tnK/FqweuMnIX4otnNYFiYRZlgH/GIaMCFHcKeYabPii/TDhlHZceM8=
X-Received: by 2002:a1f:4106:: with SMTP id o6mr1254987vka.52.1588300419383;
 Thu, 30 Apr 2020 19:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200414131348.444715-1-hch@lst.de>
 <20200414131348.444715-22-hch@lst.de>
 <20200414151344.zgt2pnq7cjq2bgv6@debian>
In-Reply-To: <20200414151344.zgt2pnq7cjq2bgv6@debian>
From: John Dorminy <jdorminy@redhat.com>
Date: Thu, 30 Apr 2020 22:33:28 -0400
Message-ID: <CAMeeMh8Q3Od76WaTasw+BpYVF58P-HQMaiFKHxXbZ_Q3tQPZ=A@mail.gmail.com>
Subject: Re: [PATCH 21/29] mm: remove the pgprot argument to __vmalloc
To: Wei Liu <wei.liu@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Mailman-Approved-At: Fri, 01 May 2020 04:48:01 +0000
Cc: linux-hyperv@vger.kernel.org, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, Michael Kelley <mikelley@microsoft.com>,
 linux-mm@kvack.org, "K. Y. Srinivasan" <kys@microsoft.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>,
 x86@kernel.org, Christoph Hellwig <hch@lst.de>,
 Peter Zijlstra <peterz@infradead.org>, Gao Xiang <xiang@kernel.org>,
 Laura Abbott <labbott@redhat.com>, Nitin Gupta <ngupta@vflare.org>,
 Daniel Vetter <daniel@ffwll.ch>, Haiyang Zhang <haiyangz@microsoft.com>,
 linaro-mm-sig@lists.linaro.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Minchan Kim <minchan@kernel.org>, iommu@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
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
Content-Type: multipart/mixed; boundary="===============0770348132251471010=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============0770348132251471010==
Content-Type: multipart/alternative; boundary="0000000000004b5c5705a48d02f1"

--0000000000004b5c5705a48d02f1
Content-Type: text/plain; charset="UTF-8"

Greetings;

I recently noticed this change via the linux-next tree.

It may not be possible to edit at this late date, but the change
description refers to PROT_KERNEL, which is a symbol which does not appear
to exist; perhaps PAGE_KERNEL was meant? The mismatch caused me and a
couple other folks some confusion briefly until we decided it was supposed
to be PAGE_KERNEL; if it's not too late, editing the description to clarify
so would be nice.

Many thanks.

John Dorminy



On Tue, Apr 14, 2020 at 11:15 AM Wei Liu <wei.liu@kernel.org> wrote:

> On Tue, Apr 14, 2020 at 03:13:40PM +0200, Christoph Hellwig wrote:
> > The pgprot argument to __vmalloc is always PROT_KERNEL now, so remove
> > it.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Michael Kelley <mikelley@microsoft.com> [hyperv]
> > Acked-by: Gao Xiang <xiang@kernel.org> [erofs]
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/hyperv/hv_init.c              |  3 +--
> [...]
> >
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index 5a4b363ba67b..a3d689dfc745 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -95,8 +95,7 @@ static int hv_cpu_init(unsigned int cpu)
> >        * not be stopped in the case of CPU offlining and the VM will
> hang.
> >        */
> >       if (!*hvp) {
> > -             *hvp = __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO,
> > -                              PAGE_KERNEL);
> > +             *hvp = __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
> >       }
>
> Acked-by: Wei Liu <wei.liu@kernel.org>
>
>

--0000000000004b5c5705a48d02f1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Greetings;<br><br></div><div>I recently noticed this =
change via the linux-next tree.</div><div><br></div><div>It may not be poss=
ible to edit at this late date, but the change description refers to PROT_K=
ERNEL, which is a symbol which does not appear to exist; perhaps PAGE_KERNE=
L was meant? The mismatch caused me and a couple other folks some confusion=
 briefly until we decided it was supposed to be PAGE_KERNEL; if it&#39;s no=
t too late, editing the description to clarify so would be nice.<br><br></d=
iv><div>Many thanks.<br><br></div><div>John Dorminy<br></div><div><br><br><=
/div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_a=
ttr">On Tue, Apr 14, 2020 at 11:15 AM Wei Liu &lt;<a href=3D"mailto:wei.liu=
@kernel.org">wei.liu@kernel.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Tue, Apr 14, 2020 at 03:13:40PM +0200, =
Christoph Hellwig wrote:<br>
&gt; The pgprot argument to __vmalloc is always PROT_KERNEL now, so remove<=
br>
&gt; it.<br>
&gt; <br>
&gt; Signed-off-by: Christoph Hellwig &lt;<a href=3D"mailto:hch@lst.de" tar=
get=3D"_blank">hch@lst.de</a>&gt;<br>
&gt; Reviewed-by: Michael Kelley &lt;<a href=3D"mailto:mikelley@microsoft.c=
om" target=3D"_blank">mikelley@microsoft.com</a>&gt; [hyperv]<br>
&gt; Acked-by: Gao Xiang &lt;<a href=3D"mailto:xiang@kernel.org" target=3D"=
_blank">xiang@kernel.org</a>&gt; [erofs]<br>
&gt; Acked-by: Peter Zijlstra (Intel) &lt;<a href=3D"mailto:peterz@infradea=
d.org" target=3D"_blank">peterz@infradead.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 arch/x86/hyperv/hv_init.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 3 +--<br>
[...]<br>
&gt; <br>
&gt; diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c<br>
&gt; index 5a4b363ba67b..a3d689dfc745 100644<br>
&gt; --- a/arch/x86/hyperv/hv_init.c<br>
&gt; +++ b/arch/x86/hyperv/hv_init.c<br>
&gt; @@ -95,8 +95,7 @@ static int hv_cpu_init(unsigned int cpu)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * not be stopped in the case of CPU offlini=
ng and the VM will hang.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!*hvp) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*hvp =3D __vmalloc(PA=
GE_SIZE, GFP_KERNEL | __GFP_ZERO,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PAGE_KERNEL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*hvp =3D __vmalloc(PA=
GE_SIZE, GFP_KERNEL | __GFP_ZERO);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
Acked-by: Wei Liu &lt;<a href=3D"mailto:wei.liu@kernel.org" target=3D"_blan=
k">wei.liu@kernel.org</a>&gt;<br>
<br>
</blockquote></div>

--0000000000004b5c5705a48d02f1--


--===============0770348132251471010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0770348132251471010==--

