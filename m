Return-Path: <SRS0=BRyA=YI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5A5ECE588
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 13:09:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CE5521848
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 13:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxS3jNtI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE5521848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0736FE18;
	Tue, 15 Oct 2019 13:09:44 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AE35FE0E
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 13:09:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 97A9E6D6
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 13:09:41 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id 5so20837658wmg.0
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 06:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=AZLh4M45F8+IHDYQfQ59rTfgOYaS9KZGvrjR75EFs2c=;
	b=AxS3jNtI/paOnEUyOVl8yf+sRnICTDCB/pSCdYKfqkRkvuJ48UwgjiyPnmBbdvcUs8
	3bWp50PWeCqic3cx0h/bmR/N91vRZx/oZafvItIrV5SGwMPhvzxGlNKbK4sYYgdXiQkz
	ptjWMVNHgLfdJ/glRcVuUQhaNdBkL6ntYldvg9qQY1GrLBFM8wQsygF5/N/WS/h7CGTD
	Lg/C+nW4EG1Kuve3pGCEP/ieDMFTRCjKVzxSDqgl4fJjyOxzAMmZYAcsEFahsfv7y2TL
	t1fQZNKcB5KO9ky8Wf27LlVxKnJwkNISTUlal+eOASfb4iJtpubaWu7Ypb/w6wvranm1
	LUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=AZLh4M45F8+IHDYQfQ59rTfgOYaS9KZGvrjR75EFs2c=;
	b=efAP/ROMdKX/IPnexbgu6917MvbQUWBQmcXShdpFS1DhGaAV/hT8Phxy+Cy2TModa4
	MMSY9ZVZelc8y6IGWilBzv549qQSphadGIXYgwPscphHMZwIRM19bq74Zv1XXzoIaXK4
	ZsTq23l4776V5XPOSc8xlHNDipYZdoq/njEs2Z3oRh+SEDcHPL3vX4zj1zZYIpEM2VhX
	ttppVtpY6TEMRZDl6103O2OiBBZsdz8vk7wWQ+nHiS8iG2Of22Br1Ku+GgYXTmOGl0uk
	uttUIDT2S/+OZZWSQcDTeZASMg7XYT2O47DMc3XPWeQRcZRSPUNPH6Pw+pHdSAM5Q/yR
	yGJw==
X-Gm-Message-State: APjAAAUSVzDlWSOHx+SHVbRu9sDFgIyOJjpsEgrb6TEk5bXhtKr54WFY
	XyWQYJE0fY+c0UV33v4jr3v7X0WwnorGYFP5RiM=
X-Google-Smtp-Source: APXvYqw7BzekgKwEuFDENzlpilT/WQOhMMJM0W/kjTFmA6tcRQKrddwRlgXqkc9dE6v0IjOeWL5ccaRoNMDX9hiAPU4=
X-Received: by 2002:a1c:a651:: with SMTP id p78mr19694786wme.53.1571144979978; 
	Tue, 15 Oct 2019 06:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20191001220205.6423-1-kholk11@gmail.com>
	<20191001220205.6423-2-kholk11@gmail.com>
	<20191015111454.GG14518@8bytes.org>
	<CAK7fi1YZXW=mqC5HWtfBWsioAq-duejAk6RgtD8npKZR=af38w@mail.gmail.com>
	<20191015124008.GB17570@8bytes.org>
In-Reply-To: <20191015124008.GB17570@8bytes.org>
From: AngeloGioacchino Del Regno <kholk11@gmail.com>
Date: Tue, 15 Oct 2019 15:09:29 +0200
Message-ID: <CAK7fi1YT_Or0bD3DwofQ_BLUsKyY3M7T8XCmDp1PAK9To7b64g@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] firmware: qcom: scm: Add function to set IOMMU
	pagetable addressing
To: Joerg Roedel <joro@8bytes.org>
Cc: MSM <linux-arm-msm@vger.kernel.org>, iommu@lists.linux-foundation.org,
	Andy Gross <agross@kernel.org>, marijns95@gmail.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Il giorno mar 15 ott 2019 alle ore 14:40 Joerg Roedel
<joro@8bytes.org> ha scritto:
>
> On Tue, Oct 15, 2019 at 02:33:47PM +0200, AngeloGioacchino Del Regno wrote:
> > Il giorno mar 15 ott 2019 alle ore 13:14 Joerg Roedel
> > <joro@8bytes.org> ha scritto:
> > >
> > > On Wed, Oct 02, 2019 at 12:01:59AM +0200, kholk11@gmail.com wrote:
> > > > From: "Angelo G. Del Regno" <kholk11@gmail.com>
> > > >
> > > > Add a function to change the IOMMU pagetable addressing to
> > > > AArch32 LPAE or AArch64. If doing that, then this must be
> > > > done for each IOMMU context (not necessarily at the same time).
> > >
> > > This patch lacks a Signed-off-by.
> > >
> >
> > I'm sorry for that. Should I resend or is it enough for me to write it here?
> >
> > Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
>
> Please resend, but you are free to wait for the reviews/acks from Rob
> Clark, which I'd like to see on the series.
>
> Regards,
>
>         Joerg

Okay, no problem. I will wait for the reviews/acks from Rob before
resending in order to limit the amount of emails in everyone's inbox :))

Angelo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
