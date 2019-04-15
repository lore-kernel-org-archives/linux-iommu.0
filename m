Return-Path: <SRS0=E2BV=SR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA0EC10F0E
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 11:26:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B88E5206BA
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 11:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B88E5206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darnok.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6C21CEEF;
	Mon, 15 Apr 2019 11:26:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 85AB4EED
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 11:26:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com
	[209.85.167.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B41096C5
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 11:26:41 +0000 (UTC)
Received: by mail-lf1-f66.google.com with SMTP id t30so12766115lfd.8
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 04:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
	:from:date:message-id:subject:to:cc;
	bh=Gtltvyt5bPf4pEYBWaZi4zNXKSd5ik7zfMHdcuVAsvo=;
	b=WFTy4zWEZ96qrC2uFbZrV+aPPHnxQRlSC0Y1frVAPU+sfZfNpg7gX0pihIpK1XTxiL
	zIBgQzbJp+gCzk9uuo9P6gXGX44pCpC5aCvTY41eg1XvT7SGZM/2xyvhOG3nvLZQuNDs
	V3qDmBqLXrXxjvrZ25huS5cw+PUKx7iTUOIXK/QmPOgkpt5tV8D//1BnLFIz6y6SRP50
	FxOBV8ZsyUXD+fq5FXKLCbugHw28lP0kwrmO23nwr8vSbaMBFEQPXdJUQxDHgC18dtNE
	YQgVLYn5oxdEc80Lt+g1RDZACfob3bGu6pHN4h6v31fEqHjs+4iejVOzgSRXRo+1cLd3
	GaKQ==
X-Gm-Message-State: APjAAAWJAbc2cYhCy17gfjpShR+bKboioqp0kcwv3Lq0aAGjB3fXkODd
	YOjz7Il0P2ElFg2u8ybZy1h40msct3yqgJbmMhg=
X-Google-Smtp-Source: APXvYqx2XB0789itDfHvUjZ5Id3fdUxLaHBr5ccySZs+cQ+zhuXKbqXfdJ1rNyVktsIxlJ23YCGZwM3RRUXBv0Wxgpc=
X-Received: by 2002:a19:ec01:: with SMTP id b1mr1406735lfa.128.1555327599960; 
	Mon, 15 Apr 2019 04:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <1555069106-2964-1-git-send-email-dongli.zhang@oracle.com>
	<5bdc3265-e5a4-e8c8-9098-0bba18a66f19@oracle.com>
	<38f6f868-013e-5619-b939-a8273fc64ee4@oracle.com>
In-Reply-To: <38f6f868-013e-5619-b939-a8273fc64ee4@oracle.com>
From: Konrad Rzeszutek Wilk <konrad@darnok.org>
Date: Mon, 15 Apr 2019 07:26:28 -0400
Message-ID:
 <CAPbh3rvyVd_D9tMfE-Bo2JmdabaiQnaipmmadc67tUt_Lrt2gw@mail.gmail.com>
Subject: Re: [PATCH 1/1] swiotlb: save io_tlb_used to local variable before
	leaving critical section
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: konrad.wilk@oracle.com, joe.jin@oracle.com, haakon.bugge@oracle.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	robin.murphy@arm.com, hch@lst.de
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
Reply-To: konrad@darnok.org
Content-Type: multipart/mixed; boundary="===============6932956733148858444=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190415112628.qmHxzHiOw7t_87vXqxRrPQCKQDY7TTEXkRAK4iW0nfo@z>

--===============6932956733148858444==
Content-Type: multipart/alternative; boundary="0000000000001ae7b505868fedb0"

--0000000000001ae7b505868fedb0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2019, 2:50 AM Dongli Zhang <dongli.zhang@oracle.com> wrote:

> As the patch to be fixed is still in Konrad's own tree, I will send the v=
2
> for
> the patch to be fixed, instead of an incremental fix.
>

I squashed it in.


> Dongli Zhang
>
> On 4/12/19 10:13 PM, Joe Jin wrote:
> > I'm good to have this patch, which helps identify the cause of failure =
is
> > fragmentation or it really been used up.
> >
> > On 4/12/19 4:38 AM, Dongli Zhang wrote:
> >> When swiotlb is full, the kernel would print io_tlb_used. However, the
> >> result might be inaccurate at that time because we have left the
> critical
> >> section protected by spinlock.
> >>
> >> Therefore, we backup the io_tlb_used into local variable before leavin=
g
> >> critical section.
> >>
> >> Fixes: 83ca25948940 ("swiotlb: dump used and total slots when swiotlb
> buffer is full")
> >> Suggested-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
> >> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> >
> > Reviewed-by: Joe Jin <joe.jin@oracle.com>
> >
> > Thanks,
> > Joe
> >
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

--0000000000001ae7b505868fedb0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Mon, Apr 15, 2019, 2:50 AM Dongli Zhang &lt;<a href=
=3D"mailto:dongli.zhang@oracle.com">dongli.zhang@oracle.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">As the patch to be fixed is still i=
n Konrad&#39;s own tree, I will send the v2 for<br>
the patch to be fixed, instead of an incremental fix.<br></blockquote></div=
></div><div dir=3D"auto"><br></div><div dir=3D"auto">I squashed it in.</div=
><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
<br>
Dongli Zhang<br>
<br>
On 4/12/19 10:13 PM, Joe Jin wrote:<br>
&gt; I&#39;m good to have this patch, which helps identify the cause of fai=
lure is<br>
&gt; fragmentation or it really been used up.<br>
&gt; <br>
&gt; On 4/12/19 4:38 AM, Dongli Zhang wrote:<br>
&gt;&gt; When swiotlb is full, the kernel would print io_tlb_used. However,=
 the<br>
&gt;&gt; result might be inaccurate at that time because we have left the c=
ritical<br>
&gt;&gt; section protected by spinlock.<br>
&gt;&gt;<br>
&gt;&gt; Therefore, we backup the io_tlb_used into local variable before le=
aving<br>
&gt;&gt; critical section.<br>
&gt;&gt;<br>
&gt;&gt; Fixes: 83ca25948940 (&quot;swiotlb: dump used and total slots when=
 swiotlb buffer is full&quot;)<br>
&gt;&gt; Suggested-by: H=C3=A5kon Bugge &lt;<a href=3D"mailto:haakon.bugge@=
oracle.com" target=3D"_blank" rel=3D"noreferrer">haakon.bugge@oracle.com</a=
>&gt;<br>
&gt;&gt; Signed-off-by: Dongli Zhang &lt;<a href=3D"mailto:dongli.zhang@ora=
cle.com" target=3D"_blank" rel=3D"noreferrer">dongli.zhang@oracle.com</a>&g=
t;<br>
&gt; <br>
&gt; Reviewed-by: Joe Jin &lt;<a href=3D"mailto:joe.jin@oracle.com" target=
=3D"_blank" rel=3D"noreferrer">joe.jin@oracle.com</a>&gt; <br>
&gt; <br>
&gt; Thanks,<br>
&gt; Joe<br>
&gt; <br>
_______________________________________________<br>
iommu mailing list<br>
<a href=3D"mailto:iommu@lists.linux-foundation.org" target=3D"_blank" rel=
=3D"noreferrer">iommu@lists.linux-foundation.org</a><br>
<a href=3D"https://lists.linuxfoundation.org/mailman/listinfo/iommu" rel=3D=
"noreferrer noreferrer" target=3D"_blank">https://lists.linuxfoundation.org=
/mailman/listinfo/iommu</a></blockquote></div></div></div>

--0000000000001ae7b505868fedb0--

--===============6932956733148858444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6932956733148858444==--
