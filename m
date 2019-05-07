Return-Path: <SRS0=4fho=TH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0849FC004C9
	for <iommu@archiver.kernel.org>; Tue,  7 May 2019 11:30:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7F71205ED
	for <iommu@archiver.kernel.org>; Tue,  7 May 2019 11:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCB73C4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F71205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id ABCC812F3;
	Tue,  7 May 2019 11:30:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 18960481
	for <iommu@lists.linux-foundation.org>;
	Tue,  7 May 2019 10:38:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E3C9B888
	for <iommu@lists.linux-foundation.org>;
	Tue,  7 May 2019 07:03:27 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id s15so20601373wra.12
	for <iommu@lists.linux-foundation.org>;
	Tue, 07 May 2019 00:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=32i+Fooa99u13aPjou+DmQruDSVe4A8WnDlL4vmbKRQ=;
	b=kCB73C4iKVTV49A+4Y/CtbJK1q0Foopxkg2R8Xp8QY4LfvXsN5DO91H+ZZmSqZ/ARw
	w4qlNPJx2WpMnLBlGGF426gp9qn0/e3qe8ZMT/i3YAe1Zt9X16mK9m8lIxlBcnNcgRgj
	MdGKvv6GiUtzpKWyqm3XQlKjNo6OsxtDTVshU+zg9ANClqV2klrWqw4rFgu5zp3iZ0jY
	lH7OP5RY3HXPIOGGM8LBAqjua8RJGZ1OtSLlmkQT9kShMt2LgjP7tP7Zooq/LeFi3wEV
	mLdJy2JHKwnBLQR6oUfr04wcF6PJHqJiBioS3c1FcLoCI0ZQ3hM5VdFXCAXm5UdOO4ar
	MEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=32i+Fooa99u13aPjou+DmQruDSVe4A8WnDlL4vmbKRQ=;
	b=AtaABgx/akitRERw0g05cpzybW+2595pY5g3Ln/LU5rNUBM63tGpEt3DyRTXXIqQ07
	lqFPG09fdC61kcIS5TKgFCfjgYAkHX+yarH1/t7P114R0ZE8V+7PJa3KYU41LUMUJ2ha
	wQR+d3FyJc4UMAAOSeP//rK17QXygzbLqiRL+wMn5yrzW7pTYJkesKPgc37zBpkMcQJH
	Nve56mAdsVh5JBscrW7xFiyg/SnrE3QV01sMGm5TYk14wlqzgJ77Q6tPZiRJKTLJW/WE
	dkG/HIGKEn9KoTJecjV4snpKDLtmTwDP6e6Ea2WeDNVZQviCVNFHmABtk6vfK6DkLULw
	Jyig==
X-Gm-Message-State: APjAAAXe5ooVctVjoXH6CcjEkDadyRkzpxqm7lYUkJwlVEKwTz7WOf1P
	DhGWG5SRAJKsr2FTWqV7kfw8dV/rk/V8RKClOfQ=
X-Google-Smtp-Source: APXvYqzU8mdPnOymuPPmkY4qatZco2+CX8RYodUP0H2WVF+OQNRz6gbkbjrk3+Tyj4Ti84rrfgZ7LX8DbiAGUwD5ykc=
X-Received: by 2002:a5d:5282:: with SMTP id c2mr2205873wrv.88.1557212606536;
	Tue, 07 May 2019 00:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190430110032.25301-1-hch@lst.de>
	<CGME20190430110118epcas2p24019c7551331cc6390e5b5e07b381dd9@epcas2p2.samsung.com>
	<20190430110032.25301-3-hch@lst.de>
	<7a63eeae-4ec3-c82e-c497-8adc7bcb3cea@samsung.com>
	<20190507063618.GA28147@lst.de>
In-Reply-To: <20190507063618.GA28147@lst.de>
From: Manuel Lauss <manuel.lauss@gmail.com>
Date: Tue, 7 May 2019 09:02:50 +0200
Message-ID: <CAOLZvyHPFRfu-BgAJTtiM9NAxR5QqXMxch7mT96V=4DN8QrzsA@mail.gmail.com>
Subject: Re: [PATCH 2/7] au1100fb: fix DMA API abuse
To: Christoph Hellwig <hch@lst.de>
X-Mailman-Approved-At: Tue, 07 May 2019 11:30:55 +0000
Cc: Michal Simek <monstr@monstr.eu>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	James Hogan <jhogan@kernel.org>, Linux-MIPS <linux-mips@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>, LKML <linux-kernel@vger.kernel.org>,
	Paul Burton <paul.burton@mips.com>, iommu@lists.linux-foundation.org,
	linux-fbdev <linux-fbdev@vger.kernel.org>, Ley Foon Tan <lftan@altera.com>
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
Content-Type: multipart/mixed; boundary="===============4463368978053768813=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

--===============4463368978053768813==
Content-Type: multipart/alternative; boundary="000000000000409f67058846d06e"

--000000000000409f67058846d06e
Content-Type: text/plain; charset="UTF-8"

On Tue, May 7, 2019 at 8:37 AM Christoph Hellwig <hch@lst.de> wrote:

> On Mon, May 06, 2019 at 03:49:35PM +0200, Bartlomiej Zolnierkiewicz wrote:
> >
> > On 04/30/2019 01:00 PM, Christoph Hellwig wrote:
> > > Virtual addresses return from dma(m)_alloc_coherent are opaque in what
> > > backs then, and drivers must not poke into them.  Switch the driver
> > > to use the generic DMA API mmap helper to avoid these games.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> > Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>
> Given this actually fixes issues with the current driver, what do you
> think of taking it for 5.2 through your tree?  Also au1200fb has
> basically the same issues, just without abusing the CAC_ADDR helper,
> I could send you a patch for that one as well.
>

Please do, I have hardware to test if required.

Manuel

--000000000000409f67058846d06e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 7, 2019 at 8:37 AM Christ=
oph Hellwig &lt;<a href=3D"mailto:hch@lst.de">hch@lst.de</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, May 06, 201=
9 at 03:49:35PM +0200, Bartlomiej Zolnierkiewicz wrote:<br>
&gt; <br>
&gt; On 04/30/2019 01:00 PM, Christoph Hellwig wrote:<br>
&gt; &gt; Virtual addresses return from dma(m)_alloc_coherent are opaque in=
 what<br>
&gt; &gt; backs then, and drivers must not poke into them.=C2=A0 Switch the=
 driver<br>
&gt; &gt; to use the generic DMA API mmap helper to avoid these games.<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Christoph Hellwig &lt;<a href=3D"mailto:hch@lst.de=
" target=3D"_blank">hch@lst.de</a>&gt;<br>
&gt; <br>
&gt; Acked-by: Bartlomiej Zolnierkiewicz &lt;<a href=3D"mailto:b.zolnierkie=
@samsung.com" target=3D"_blank">b.zolnierkie@samsung.com</a>&gt;<br>
<br>
Given this actually fixes issues with the current driver, what do you<br>
think of taking it for 5.2 through your tree?=C2=A0 Also au1200fb has<br>
basically the same issues, just without abusing the CAC_ADDR helper,<br>
I could send you a patch for that one as well.<br></blockquote><div><br></d=
iv><div>Please do, I have hardware to test if required.</div><div><br></div=
><div>Manuel</div><div><br></div></div></div>

--000000000000409f67058846d06e--

--===============4463368978053768813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4463368978053768813==--
