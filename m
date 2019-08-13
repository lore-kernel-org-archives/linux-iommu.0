Return-Path: <SRS0=4AON=WJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69732C32750
	for <iommu@archiver.kernel.org>; Tue, 13 Aug 2019 12:09:42 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AC50206C2
	for <iommu@archiver.kernel.org>; Tue, 13 Aug 2019 12:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="F1FtNMhK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC50206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tcd.ie
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E9A86CB5;
	Tue, 13 Aug 2019 12:09:41 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4DE8FC75
	for <iommu@lists.linux-foundation.org>;
	Tue, 13 Aug 2019 12:09:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
	[209.85.210.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 849D087E
	for <iommu@lists.linux-foundation.org>;
	Tue, 13 Aug 2019 12:09:39 +0000 (UTC)
Received: by mail-ot1-f66.google.com with SMTP id o101so18512481ota.8
	for <iommu@lists.linux-foundation.org>;
	Tue, 13 Aug 2019 05:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=tcd-ie.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=s+V8X5K4yGWcY4E0ABSSl3E0oh4a7NUzQ9s+ppVlE7k=;
	b=F1FtNMhKMGHQ7cq0RQkzTDiYPIymdc8MAuzaZwFYqpZDFf9C6xG60y5PKgmXXsBOns
	ofrI8O4MG7+Si6UWl0lqSIVXdWPoErYMRS7506TtvXQ6ZxlXyPjeLt81k+jpjzWk80u0
	1rNGvhJEQxSCdocjIXoQe1N3WlrCsI2uKcLGSgfPKs0IBLmuGO8if9V2XBbzOAaMnDgK
	uoAQa4pGPpJCieHcwGeRtPE/yvkCkupjiacvF/lJwCFMh6WJWLIB7Hpo4IrjO+0u+fUy
	slXIbemccnmr6mQrSeaA4Kszp3xdZYzneFbNXw/G0FgXegkGE5a/4Or77JIIpEgi+X+C
	aBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=s+V8X5K4yGWcY4E0ABSSl3E0oh4a7NUzQ9s+ppVlE7k=;
	b=e/cY5SMfauRbc+XI5eO4ixFsRtmtHMvUSC7GGOFGzMXaKIN5CGfm+Z+3FLSllru/Gp
	5SzvIJMIDWNcNTMSvIg5LnuYqKRQ53pwj2xfz49sbwaZZzAh/ScFAutmHzOG03apmVjO
	DTYwU76JgZ03JQJX17fJod/+U3y7RF8Cn+wvp2yooYv4PpTDZ96HRIwHYnuqONSqviRj
	F6tEUhdc4qsnfKvBKXQeDcAWfXSdbSVG+3UZpWrbfP1vmCgDsGRCZOHCtjO0+QrHLVoC
	tM36VFc19B0sjPheqV83OwCPGSg9rik1WU6NUrtkhsLOvCNBU+3KkJ6c06MjXAF78/e/
	P1ow==
X-Gm-Message-State: APjAAAX+Berwi9D1SupEj5ZyxfucaSJlwXJr6SQWRSjLVKKbkvbJK/hL
	+i9NYnP/+y4rYOWygdI5Nwcad5wEDgtjzuAIR41dlw==
X-Google-Smtp-Source: APXvYqzkgOt/bx3cvRsgdT3UFyeEwpsUCCV/wbP0pXOFgHxSTp6e/jsLC4az4z4HlW2Pya1N9m3gTLoq+ugQ3KLwZtM=
X-Received: by 2002:a02:c84b:: with SMTP id r11mr8256390jao.3.1565698178627;
	Tue, 13 Aug 2019 05:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190613223901.9523-1-murphyt7@tcd.ie>
	<20190624061945.GA4912@infradead.org>
	<20190810071952.GA25550@infradead.org>
In-Reply-To: <20190810071952.GA25550@infradead.org>
From: Tom Murphy <murphyt7@tcd.ie>
Date: Tue, 13 Aug 2019 20:09:26 +0800
Message-ID: <CALQxJuvxBc3MH3_B_fZ3FvURHOM3F3dvvZ6x=GtALUAvyu7Qxw@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] iommu/amd: Convert the AMD iommu driver to the
	dma-iommu api
To: Christoph Hellwig <hch@infradead.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Will Deacon <will.deacon@arm.com>,
	virtualization@lists.linux-foundation.org,
	David Brown <david.brown@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org,
	Andy Gross <agross@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Kukjin Kim <kgene@kernel.org>, David Woodhouse <dwmw2@infradead.org>
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
Content-Type: multipart/mixed; boundary="===============4657264066316369039=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

--===============4657264066316369039==
Content-Type: multipart/alternative; boundary="000000000000c3526e058ffe83e2"

--000000000000c3526e058ffe83e2
Content-Type: text/plain; charset="UTF-8"

Hi Christoph,

I quit my job and am having a great time traveling South East Asia.

I definitely don't want this work to go to waste and I hope to repost it
later this week but I can't guarantee it.

Let me know if you need this urgently.

Thanks,
Tom

On Sat 10 Aug 2019, 3:20 p.m. Christoph Hellwig, <hch@infradead.org> wrote:

> On Sun, Jun 23, 2019 at 11:19:45PM -0700, Christoph Hellwig wrote:
> > Tom,
> >
> > next time please cc Jerg as the AMD IOMMU maintainer.
> >
> > Joerg, any chance you could review this?  Toms patches to convert the
> > AMD and Intel IOMMU drivers to the dma-iommu code are going to make my
> > life in DMA land significantly easier, so I have a vested interest
> > in this series moving forward :)
>
> Tom, can you repost the series?  Seems like there hasn't been any
> news for a month.
>

--000000000000c3526e058ffe83e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi Christoph,</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">I quit my job and am having a great time traveling South East =
Asia.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">I definitely=
 don&#39;t want this work to go to waste and I hope to repost it later this=
 week but I can&#39;t guarantee it.</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">Let me know if you need this urgently.</div><div dir=3D"auto"><=
br></div><div dir=3D"auto">Thanks,</div><div dir=3D"auto">Tom</div><div dir=
=3D"auto"><br><div class=3D"gmail_quote" dir=3D"auto"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Sat 10 Aug 2019, 3:20 p.m. Christoph Hellwig, &lt;<a hr=
ef=3D"mailto:hch@infradead.org">hch@infradead.org</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">On Sun, Jun 23, 2019 at 11:19:45PM -0700, Chr=
istoph Hellwig wrote:<br>
&gt; Tom,<br>
&gt; <br>
&gt; next time please cc Jerg as the AMD IOMMU maintainer.<br>
&gt; <br>
&gt; Joerg, any chance you could review this?=C2=A0 Toms patches to convert=
 the<br>
&gt; AMD and Intel IOMMU drivers to the dma-iommu code are going to make my=
<br>
&gt; life in DMA land significantly easier, so I have a vested interest<br>
&gt; in this series moving forward :)<br>
<br>
Tom, can you repost the series?=C2=A0 Seems like there hasn&#39;t been any<=
br>
news for a month.<br>
</blockquote></div></div></div>

--000000000000c3526e058ffe83e2--

--===============4657264066316369039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4657264066316369039==--
