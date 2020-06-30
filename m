Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4316FC433E1
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 07:32:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A2C1207D0
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 07:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2C1207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BEF4F21135;
	Tue, 30 Jun 2020 07:32:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vcg61Nkfh9l7; Tue, 30 Jun 2020 07:32:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 86EFA203A0;
	Tue, 30 Jun 2020 07:32:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58B90C0865;
	Tue, 30 Jun 2020 07:32:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93C9DC016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 07:32:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8197C86935
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 07:32:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bHHF2cic3zh8 for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 07:32:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AE2B086934
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 07:32:06 +0000 (UTC)
Received: from mail-oi1-f199.google.com ([209.85.167.199])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <koba.ko@canonical.com>) id 1jqAkO-0003Lg-CS
 for iommu@lists.linux-foundation.org; Tue, 30 Jun 2020 07:32:04 +0000
Received: by mail-oi1-f199.google.com with SMTP id a12so3730559oia.23
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 00:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1e90/+4iquf4bsRpUW7KG7qb5zPqy3erpE91QO7pcqc=;
 b=grvSz7pYx27rKc3iRjQ4iFsgxREbGs8Jy7ZtfgEk+3sfyzNizTv3VmiklYXH9z/gjQ
 /dFDy2TP3WMuXnHa3tZf5o/PtYSJRy8JxM0CfhSgX4TqGVHV0/8pt6Jt0w07yOukSROL
 QCMvY6kGMkhdzrtsWy621JWoLrn7tQ9+9zuc+7iUJ0AhVFVT+Y6O4Atofp4dwFOV5Rkn
 Y4oalZw3DNJqyFkop1kM/F3joOvp9K5r6BCxiSEmC68nyG6KsD8est6nnM8WGDPLlN1v
 aBw44UQeejDuMqv3O3Z2NBC+5ziPg/xxhbLL3GcKn71BgsxJuzE9KtIPWgh/iMKc8xtx
 tGsA==
X-Gm-Message-State: AOAM533VJ62+/pL/TVnoTd9g4W+FRwAGG+p4b4NL+1IUiMyVjQx+Dimc
 cCRqeZSpE4zDiTLUxCSeMgXFIZ3/P2KYTjWZpJhGIOioyK7s4gixENxU0JOUgfhQ8fmh911Jta0
 FE1Ixzh5g4u6i8okla7pqTQUDkbckIm3Qb3u5H+3Ok4CqvABu+aypha1GdkUUgCA=
X-Received: by 2002:a54:4e1d:: with SMTP id a29mr7387349oiy.139.1593502323391; 
 Tue, 30 Jun 2020 00:32:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyX4MBpSJvuvgywq8t5PrqtCbKxzRmN0WXCifmMIybV7JAtO6jgJKdYKFA7CM/DWXsLhR93b3DeAR3NGRnwawE=
X-Received: by 2002:a54:4e1d:: with SMTP id a29mr7387336oiy.139.1593502323155; 
 Tue, 30 Jun 2020 00:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAJB-X+Ww=bZN2qZ=e=4EkN_RUTiZxHxkdnHh50y9iVqZmT_XQg@mail.gmail.com>
 <111dde48-8018-6d74-5df8-1534143f4de6@linux.intel.com>
In-Reply-To: <111dde48-8018-6d74-5df8-1534143f4de6@linux.intel.com>
From: Koba Ko <koba.ko@canonical.com>
Date: Tue, 30 Jun 2020 15:31:52 +0800
Message-ID: <CAJB-X+WgjKR3PgoF_tn_g__+agCSGJpyB8sh+A62gs0qztDuVQ@mail.gmail.com>
Subject: Re: [Issue]platform/x86: iommu: System can't shutdown because iommu
 driver keeps checking the status of DMA_GSTS_TES
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: "Sun, Jian" <jian.sun@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Kai Heng Feng <kai.heng.feng@canonical.com>,
 David Woodhouse <dwmw2@infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Jun 15, 2020 at 3:20 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> Hi Koba Ko,
>
> On 2020/6/15 11:19, Koba Ko wrote:
> > hi All,
> > I have a machine and there's only intel gpu.
> > the secureboot and vt-d is enabled in BIOS.
> > On the Ubuntu desktop, I do s2idle first and restart the machine.
> > The machine can't restart successfully, so I need to press the
> > power button to shutdown.
> > I tried  each of the following and the issue can't be triggered.
> > 1. disable secure boot in BIOS.
> > 2. intel_iommu=off.
> > 3. intel_iomm=igfx_off.
> > 4. nomodeset
> > 5. i915.modeset=0.
> >
> > After I investigate further, find inte_iommu keeps checking the status
> > of DMA_GSTS_TES.
> > During the procedure of restart, the driver would disable iommu
> > translation and
> > check status of DMA_GSTS_TES until status of DMA_GSTS_TES is 0.
> >
> > If you need more information, I can provide it.
>
> Do you mind telling what platform is it?
>
> Best regards,
> baolu
Hi Baolu,
Sorry, i missed your email.
I'm running on TGL.
My colleague has reported this on bugzilla.
Have tested your patch and it works fine.
https://bugzilla.kernel.org/show_bug.cgi?id=208363

Could you explain more about these patches!? Why do we need  a flag
for active iommu!?

Koba Ko
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
