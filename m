Return-Path: <SRS0=bViT=VU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D32C7618E
	for <iommu@archiver.kernel.org>; Tue, 23 Jul 2019 08:49:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81586223A1
	for <iommu@archiver.kernel.org>; Tue, 23 Jul 2019 08:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="jCfIiomx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81586223A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 53C2AB88;
	Tue, 23 Jul 2019 08:49:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 23A882C
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Jul 2019 08:49:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
	[209.85.167.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 438C9FE
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Jul 2019 08:49:33 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id z15so24477305lfh.13
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Jul 2019 01:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=QY/kaCLgMzrdZqg8c7kz7chfhTByIE9LqkdSjkxFStE=;
	b=jCfIiomxlkBY1ybuLeuoyu95sfNYHe1hY/Q6JR6Dx0Mb8ukHn//C6KmjS7rfxSWZK5
	4QXoItFTIuNphC2C9lQWFBBsAfu+xm2RZNxa0VfsQTAGKg2zhI3D1O2/oySY59PnCT5i
	WV+kL52wSx7fAO8eiBBkmwxQgFVd77BuLg73JkrJVJY3rkrYq+imHJbJbkE3PTCK1LVe
	Ufn/1aOtoiyKmlU2UTC4fsLiBjSqK7edkptMfS05Lvm4G/OtW3NGeKAZeFgwELuNX2l2
	xfqr16H/q7TkbTZeDAQs14Xy13wtuGdfRpKhGc2HNYdRNv2xPCVlOG0JHhIb42ffiICl
	0acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=QY/kaCLgMzrdZqg8c7kz7chfhTByIE9LqkdSjkxFStE=;
	b=WWIVNFKORPmk6mp8hoABZueCsr0h83CeHwx5tkNrvQnkppemA60NEV1HqdtXg1cRgk
	Uz3TfC0RSAMvk9nYeAv5hBHoSsMpMpuH2NK256u+lVBwf96ihOtLPCbpbDL9EQsoBXY2
	6/ihDKOdLSdQi9sgGDezgVjsqE6fUBf4mmDcq91azhi32IKhwY2E+YhZr1qaZ9z1NfJP
	/dlvajgFuFqm75ic4JuFwGQlBrOKEzSZs8Iaqzi22CVQ/h6R03jcgzGFiCxeuORQGeFX
	hr49bwfSXxKU0PL8bnDA55G3oVdw6mVl1CbIAc531a7PW99jiyVWsHU7WE/RvgwgOMb2
	X3Ew==
X-Gm-Message-State: APjAAAX2LwgRfUEVvaVqqi4b9lZJa8/SHP2b8kYJbi4qR7zqJUpn4gcY
	y8ZhGU+vkIM3Hia0Cf5VMsabmcADm+33NjlGayhckrtqJyuY1OqLsqNSoQM/BWplzLqiwx4Vjru
	4iZIwJD2oAqetCC7AkI1yzx8vduFA4EFp6V96f5qwoCmgEviwi2xHmkZLypKBNaJifVr04+cCNA
	lf6PtO7vQgksqUwvw6FYUgyfVxmC1KZAV1ErYFigV5OR8q9miFDIOzgzZAbqb3
X-Google-Smtp-Source: APXvYqxgRaGk7B+9khU+YZhmKIlkQeQjRhZXnWnb6ToOX6k0V1hk0RX5HZZkupyTsvvyYHZ/a/bX2R0xUCQe7ZctLUU=
X-Received: by 2002:ac2:4c84:: with SMTP id d4mr34368910lfl.1.1563871771635;
	Tue, 23 Jul 2019 01:49:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190716213806.20456-1-dima@arista.com>
	<20190723081735.GJ12009@8bytes.org>
In-Reply-To: <20190723081735.GJ12009@8bytes.org>
Date: Tue, 23 Jul 2019 09:49:21 +0100
Message-ID: <CAGrbwDTP+kgJMeu+ox-5g0pyJs-psFt4iR22+eHBBubr4z-i3g@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/vt-d: Don't queue_iova() if there is no flush
	queue
To: Joerg Roedel <joro@8bytes.org>
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Cc: Dmitry Safonov <0x7f454c46@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
	stable@vger.kernel.org, iommu@lists.linux-foundation.org,
	David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
From: Dmitry Safonov via iommu <iommu@lists.linux-foundation.org>
Reply-To: Dmitry Safonov <dima@arista.com>
Content-Type: multipart/mixed; boundary="===============1311569386344627521=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

--===============1311569386344627521==
Content-Type: multipart/alternative; boundary="0000000000006c557d058e5545b9"

--0000000000006c557d058e5545b9
Content-Type: text/plain; charset="UTF-8"

On Tue 23 Jul 2019, 9:17 a.m. Joerg Roedel, <joro@8bytes.org> wrote:

> On Tue, Jul 16, 2019 at 10:38:05PM +0100, Dmitry Safonov wrote:
>
> > @@ -235,6 +236,11 @@ static inline void init_iova_domain(struct
> iova_domain *iovad,
> >  {
> >  }
> >
> > +bool has_iova_flush_queue(struct iova_domain *iovad)
> > +{
> > +     return false;
> > +}
> > +
>
> This needs to be 'static inline', I queued a patch on-top of my fixes
> branch.


Ugh, copy-n-paste declaration.

Thanks much,
Dmitry

--0000000000006c557d058e5545b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Tue 23 Jul 2019, 9:17 a.m. Joerg Roedel, &lt;<a href=3D"mai=
lto:joro@8bytes.org">joro@8bytes.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">On Tue, Jul 16, 2019 at 10:38:05PM +0100, Dmitry Safonov w=
rote:<br>
<br>
&gt; @@ -235,6 +236,11 @@ static inline void init_iova_domain(struct iova_d=
omain *iovad,<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +bool has_iova_flush_queue(struct iova_domain *iovad)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return false;<br>
&gt; +}<br>
&gt; +<br>
<br>
This needs to be &#39;static inline&#39;, I queued a patch on-top of my fix=
es<br>
branch.</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">Ugh, copy-n-paste declaration.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Thanks much,=C2=A0</div><div dir=3D"auto">Dmitry</div></div>

--0000000000006c557d058e5545b9--

--===============1311569386344627521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1311569386344627521==--
