Return-Path: <SRS0=ag5I=ST=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6B7C282DA
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 23:18:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2C5D2184B
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 23:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bmUIU6sK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C5D2184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 80E0ED07;
	Wed, 17 Apr 2019 23:18:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C92A8C37
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 23:18:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
	[209.85.167.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 34029F4
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 23:18:33 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id u17so100937lfi.3
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 16:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=MovRSmCBZtC0FfepdTAmKtvCaTqkApcKe7AZyWeWly0=;
	b=bmUIU6sKJUij7h28dg7hpNxvADEffY+cXC5BTMaGAk08LOHFA0WpumdZ0cWjETTV/R
	97UwcY+cF21cLiI4RF62jKRUqtn6sHJoEST9IWQkMOQ+A4wkC4yz7z+EMZr5Hj7wFKyD
	EPCgEzmy1qG0ABYsC+JpwdC9Evx0XjNLurMXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=MovRSmCBZtC0FfepdTAmKtvCaTqkApcKe7AZyWeWly0=;
	b=Qi/GZ+WlPVuT/u78sHuF2jUOC/27flHZPffY6Hpxubf6NRYvu5HJCMQcSNBoBhe40M
	9O+a8HSkwExZo2GquYYMBzlziLfn9xOqnXfTWbM/aOCY34Z9LY70w62pNESg5yj1rq35
	4RPX3ihV42gjcKsyrbYmRdINHYmPyj7BuXkxf6rKUMCO8I34bcJ5KmyktlNvU2sykqdk
	SuytuutokMSBVuKpxpsTeFinWT3mMn4dV88/9GQpdlxW3OuqdyJo7oTdp2EjgukONocS
	B/LkIDGnf8XI+AT1t9sdBx3+KbYP92z1rnMKcKGlDKTnNdBLqE+Y3GwjLgeW8HX9SX9H
	6ieA==
X-Gm-Message-State: APjAAAWhqkzHfCdRAIGm9BSokx3T+QowCqJMszuR+VtKLNdzWfwbkG9j
	gKHchluMdxd+N3Kk+i1WO/B8L/DbiJvz9g==
X-Google-Smtp-Source: APXvYqyBalCOhxnNdULbP3w++T5PNH3hAE7xSfDJzfSSz1srOCqvxLrj7Iu4DmHbgsLxwjvTnBX9rA==
X-Received: by 2002:ac2:4421:: with SMTP id w1mr56632lfl.97.1555543111574;
	Wed, 17 Apr 2019 16:18:31 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com.
	[209.85.167.50])
	by smtp.gmail.com with ESMTPSA id u6sm67606lfu.5.2019.04.17.16.18.30
	for <iommu@lists.linux-foundation.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 17 Apr 2019 16:18:31 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id d12so94139lfk.6
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 16:18:30 -0700 (PDT)
X-Received: by 2002:ac2:598b:: with SMTP id w11mr21120489lfn.62.1555543110507; 
	Wed, 17 Apr 2019 16:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
	<20190417161042.GA43453@gmail.com>
	<e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
	<20190417170918.GA68678@gmail.com>
	<56A175F6-E5DA-4BBD-B244-53B786F27B7F@gmail.com>
	<20190417172632.GA95485@gmail.com>
	<063753CC-5D83-4789-B594-019048DE22D9@gmail.com>
	<alpine.DEB.2.21.1904172317460.3174@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1904172317460.3174@nanos.tec.linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Apr 2019 16:18:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBMg9P-nYQR2pS0XwVdikPCBqLsMFqR9nk=wSmAd4_5g@mail.gmail.com>
Message-ID:
 <CAHk-=wgBMg9P-nYQR2pS0XwVdikPCBqLsMFqR9nk=wSmAd4_5g@mail.gmail.com>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
	Ownership (XPFO)
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave@sr71.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>, Khalid Aziz <khalid.aziz@oracle.com>,
	deepa.srinivasan@oracle.com, "H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
	X86 ML <x86@kernel.org>, LSM List <linux-security-module@vger.kernel.org>,
	jsteckli@amazon.de, Arjan van de Ven <arjan@infradead.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, jcm@redhat.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	chris.hyser@oracle.com, linux-arm-kernel@lists.infradead.org,
	Khalid Aziz <khalid@gonehiking.org>, juergh@gmail.com,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
	tyhicks@canonical.com, iommu <iommu@lists.linux-foundation.org>,
	Juerg Haefliger <juerg.haefliger@canonical.com>,
	keescook@google.com, Andrew Morton <akpm@linux-foundation.org>,
	David Woodhouse <dwmw@amazon.co.uk>
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
Content-Type: multipart/mixed; boundary="===============2312796169067829782=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190417231818.kFDYKzxoVFCn4COvUFXThpBh5z6j26BKgTL2XN6DxuI@z>

--===============2312796169067829782==
Content-Type: multipart/alternative; boundary="00000000000088f1ef0586c21a38"

--00000000000088f1ef0586c21a38
Content-Type: text/plain; charset="UTF-8"

On Wed, Apr 17, 2019, 14:20 Thomas Gleixner <tglx@linutronix.de> wrote:

>
> It's not necessarily a W+X issue. The user space text is mapped in the
> kernel as well and even if it is mapped RX then this can happen. So any
> kernel mappings of user space text need to be mapped NX!


With SMEP, user space pages are always NX.

I really think SM[AE]P is something we can already take for granted. People
who have old CPU's workout it are simply not serious about security anyway.
There is no point in saying "we can do it badly in software".

       Linus

>

--00000000000088f1ef0586c21a38
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Apr 17, 2019, 14:20 Thomas Gleixner &lt;<a hre=
f=3D"mailto:tglx@linutronix.de">tglx@linutronix.de</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><br>
It&#39;s not necessarily a W+X issue. The user space text is mapped in the<=
br>
kernel as well and even if it is mapped RX then this can happen. So any<br>
kernel mappings of user space text need to be mapped NX!</blockquote></div>=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">With SMEP, user space p=
ages are always NX.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I re=
ally think SM[AE]P is something we can already take for granted. People who=
 have old CPU&#39;s workout it are simply not serious about security anyway=
. There is no point in saying &quot;we can do it badly in software&quot;.</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0Linus</div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">=C2=A0</blockquote></div></div><div dir=3D"auto"></div></div=
>

--00000000000088f1ef0586c21a38--

--===============2312796169067829782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2312796169067829782==--
