Return-Path: <SRS0=dZmg=UM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07859C31E4A
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 16:55:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D427620665
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 16:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrNaEHWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D427620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AD4EE10A4;
	Thu, 13 Jun 2019 16:55:16 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 116681096
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 16:55:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
	[209.85.166.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 82ADD711
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 16:55:14 +0000 (UTC)
Received: by mail-io1-f65.google.com with SMTP id e5so18493215iok.4
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 09:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=ClC0u2JGR2lSo+6Tvkb2x52kadnHao11/SSLbD6/58k=;
	b=JrNaEHWuGK31T7Uo+VSWno6hHFAJENibo1UonPm+66izBPrzhseMDm7bv7X64xM5DK
	Cw9kQc0KCnUjh4IFkW/C31Zk4kzA6mouPoQfGyg+p3mDujIALjKIKTevGWXwncMxhJwO
	m2kMdmGqR/BatXqMusdoFI5nCzADTl/eYJnHTXoEVhw1h5HEyYenJYrp+kjJoQb3v6xJ
	mOUMwPay5Dm1ubWMu/GLLAxiBdkfT+DerQmRsGvmVB4Tgr0z0KELyQqYVcHzYXJRIgy/
	iSvOID0iZKuxCkn7pAxT6UAXELNV164onq0HuVxvAytjhlCn0A1cPqeVRPVxyuBCioD9
	8QjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=ClC0u2JGR2lSo+6Tvkb2x52kadnHao11/SSLbD6/58k=;
	b=JPzhAZ9yUSbbVb4q2znZ7pwI6URJCPHiTyCnd98eF+NkANV5ioKfaOzkBQ+SmedlVq
	NAvLlBS6IoT28RnseCUzd61VvAHRtwGsUklqXdxo2RLIl8ng+ML8d7Fd6fKbxdYKKva6
	IoWCaExV2f55UI4Dcj6z/NZHtd76qJRnvY6PEmN2vQn72mTZJTep9+/5SGp0TygU9huI
	WplZZGMZx9/EgRAFlImEuDhRlNR6Chqd08Fvn9j7hGuQELMKoWTWasZhWkJ0hasVhPPZ
	pmQrE7mc2/2Fm1fTKhJ96Bg6Vnq3/F4JORt2QduAz8LJ1c3wW6sMkgu/uO23kJ8aDmSv
	lmiA==
X-Gm-Message-State: APjAAAXaxR7s9t+nSBdjNPUXl+yFbZL9rPwUFWHOm2U/Tttm2G0ZcDk1
	G5t9x+rK4NIpWjFx3glQpBFrr/brxU6nHPq+lQ4=
X-Google-Smtp-Source: APXvYqylceZhLVcUp0gOO9Vg8sEwwQ2V26ZkYvdHadRA9KxZ4IFbMZeY52TIAhHmV5cKS4Wm3sFmdLPdFRRz42Unlow=
X-Received: by 2002:a5e:8e42:: with SMTP id r2mr453389ioo.305.1560444913870;
	Thu, 13 Jun 2019 09:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190613162703.986-1-tiny.windzz@gmail.com>
	<20190613162703.986-3-tiny.windzz@gmail.com>
	<ac67e363-70cf-af64-d634-c3b0b6d408fa@ti.com>
In-Reply-To: <ac67e363-70cf-af64-d634-c3b0b6d408fa@ti.com>
From: Frank Lee <tiny.windzz@gmail.com>
Date: Fri, 14 Jun 2019 00:55:02 +0800
Message-ID: <CAEExFWuM+oMUKf440myr0GHAnatdzaxr=0ibFDGVXDHs6J1bzA@mail.gmail.com>
Subject: Re: [PATCH 03/10] iommu/omap: convert to SPDX license tags
To: Suman Anna <s-anna@ti.com>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
	"heiko@sntech.de" <heiko@sntech.de>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"will.deacon@arm.com" <will.deacon@arm.com>,
	"agross@kernel.org" <agross@kernel.org>,
	"krzk@kernel.org" <krzk@kernel.org>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"david.brown@linaro.org" <david.brown@linaro.org>,
	"kgene@kernel.org" <kgene@kernel.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Fri, Jun 14, 2019 at 12:39 AM Suman Anna <s-anna@ti.com> wrote:
>
> Hi Yangtao,
>
> On 6/13/19 11:26 AM, Yangtao Li wrote:
> > Updates license to use SPDX-License-Identifier.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>
> Thanks for the patch. Can you also update another related file
> while at this. Will leave it to Joerg if he prefers it as a separate
> patch, or folded into this patch.
>
> include/linux/platform_data/iommu-omap.h
>

Done.

Yangtao

> Acked-by: Suman Anna <s-anna@ti.com>
>
> regards
> Suman
>
> > ---
> >  drivers/iommu/omap-iommu-debug.c | 5 +----
> >  drivers/iommu/omap-iommu.c       | 5 +----
> >  drivers/iommu/omap-iommu.h       | 5 +----
> >  drivers/iommu/omap-iopgtable.h   | 5 +----
> >  4 files changed, 4 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
> > index 4abc0ef522a8..55ec67a45101 100644
> > --- a/drivers/iommu/omap-iommu-debug.c
> > +++ b/drivers/iommu/omap-iommu-debug.c
> > @@ -1,13 +1,10 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >  /*
> >   * omap iommu: debugfs interface
> >   *
> >   * Copyright (C) 2008-2009 Nokia Corporation
> >   *
> >   * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > - *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License version 2 as
> > - * published by the Free Software Foundation.
> >   */
> >
> >  #include <linux/err.h>
> > diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> > index d2fb347aa4ff..e6442876913f 100644
> > --- a/drivers/iommu/omap-iommu.c
> > +++ b/drivers/iommu/omap-iommu.c
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >  /*
> >   * omap iommu: tlb and pagetable primitives
> >   *
> > @@ -6,10 +7,6 @@
> >   *
> >   * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>,
> >   *           Paul Mundt and Toshihiro Kobayashi
> > - *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License version 2 as
> > - * published by the Free Software Foundation.
> >   */
> >
> >  #include <linux/dma-mapping.h>
> > diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
> > index 1703159ef5af..5256e17d86a7 100644
> > --- a/drivers/iommu/omap-iommu.h
> > +++ b/drivers/iommu/omap-iommu.h
> > @@ -1,13 +1,10 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> >  /*
> >   * omap iommu: main structures
> >   *
> >   * Copyright (C) 2008-2009 Nokia Corporation
> >   *
> >   * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > - *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License version 2 as
> > - * published by the Free Software Foundation.
> >   */
> >
> >  #ifndef _OMAP_IOMMU_H
> > diff --git a/drivers/iommu/omap-iopgtable.h b/drivers/iommu/omap-iopgtable.h
> > index 01a315227bf0..871c2a38f453 100644
> > --- a/drivers/iommu/omap-iopgtable.h
> > +++ b/drivers/iommu/omap-iopgtable.h
> > @@ -1,13 +1,10 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> >  /*
> >   * omap iommu: pagetable definitions
> >   *
> >   * Copyright (C) 2008-2010 Nokia Corporation
> >   *
> >   * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > - *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License version 2 as
> > - * published by the Free Software Foundation.
> >   */
> >
> >  #ifndef _OMAP_IOPGTABLE_H
> >
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
