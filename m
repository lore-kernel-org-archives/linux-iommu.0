Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B179C433DF
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 03:28:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34171206E6
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 03:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34171206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E757085B73;
	Tue,  7 Jul 2020 03:28:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2QA6BbBa_xXM; Tue,  7 Jul 2020 03:28:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 16C1385BD0;
	Tue,  7 Jul 2020 03:28:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDB21C0893;
	Tue,  7 Jul 2020 03:28:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50CD5C016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 03:28:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 38960893AF
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 03:28:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id shwknRkugBeK for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 03:28:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 25BAA89395
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 03:28:14 +0000 (UTC)
Received: from mail-oo1-f71.google.com ([209.85.161.71])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <koba.ko@canonical.com>) id 1jseHD-0006Ay-RO
 for iommu@lists.linux-foundation.org; Tue, 07 Jul 2020 03:28:12 +0000
Received: by mail-oo1-f71.google.com with SMTP id q5so12079768ook.23
 for <iommu@lists.linux-foundation.org>; Mon, 06 Jul 2020 20:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JWJ62s8035AwMjPdpYDA6UZDbxEpjF3hLCFmfSbPnhw=;
 b=LEX5Eq/yUr+Hh4UUgQYvfaLC0NbXbtMmMyqBTKGO03Cq3YCn5CqBZckQLMAHthP4xO
 3DnHYDayVgbHa/bx0KNCK1KwTd4UCoBXaceFYHxuNKZ69nj++Gr3MWrLBSTfNEnWRIEY
 Hr2QG1BX567fYLIuf6huJhssckJQ0mr9sT+w8sbpYfT4CYD/qjPTRN9/XSjJQUcAaHUm
 XYF0njBrP9UhQr7mV227fw/ML5ksKL0jVGVslZ2Vi1wssooDr6J7gpgpzqp+UQyCArnD
 WTwOYCfDuoNLyhjiOwS6CoeqsdV+DkcGNIDVjD9hrcH6sznnFE4xmJrmRvcFwYL+I8JB
 nl3g==
X-Gm-Message-State: AOAM533sncXI++Hx5QO9XQHeEj/2xaBwLV+2/1jB/HSuYYSc7gNcmoiW
 8OKexylPxAOl65fK/eLzbBAHZvytrHxEYxTX0u5hLclQrJW7+8pVY3RWyzhgD9zgaGt+mioQduf
 ZfJO5x3lKHf80DmRxT4zyv1MkduaFY3xDG2PYGpRo3PYvpW4pJ98dzWO8sLOA/UI=
X-Received: by 2002:aca:8ce:: with SMTP id 197mr1899323oii.17.1594092490693;
 Mon, 06 Jul 2020 20:28:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyna30yFOPxRyadhhJOflPmmw2do7BPAlij7cxa7CDYjzknGb8L/FQ83wtloVUjfR2pfguLS/roP/8gqlN5e2k=
X-Received: by 2002:aca:8ce:: with SMTP id 197mr1899310oii.17.1594092490392;
 Mon, 06 Jul 2020 20:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAJB-X+Ww=bZN2qZ=e=4EkN_RUTiZxHxkdnHh50y9iVqZmT_XQg@mail.gmail.com>
 <111dde48-8018-6d74-5df8-1534143f4de6@linux.intel.com>
 <CAJB-X+WgjKR3PgoF_tn_g__+agCSGJpyB8sh+A62gs0qztDuVQ@mail.gmail.com>
 <66cacbab-b04d-33f3-053e-4d554ac7c662@linux.intel.com>
In-Reply-To: <66cacbab-b04d-33f3-053e-4d554ac7c662@linux.intel.com>
From: Koba Ko <koba.ko@canonical.com>
Date: Tue, 7 Jul 2020 11:27:59 +0800
Message-ID: <CAJB-X+Uo2yw+SC6X2sfDsG9YusyL9iJAuR0wG_L+KYtSkz=Cmg@mail.gmail.com>
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

Dear Baolu,
On Tue, Jun 30, 2020 at 3:52 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> Hi Koba,
>
> On 2020/6/30 15:31, Koba Ko wrote:
> > On Mon, Jun 15, 2020 at 3:20 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
> >>
> >> Hi Koba Ko,
> >>
> >> On 2020/6/15 11:19, Koba Ko wrote:
> >>> hi All,
> >>> I have a machine and there's only intel gpu.
> >>> the secureboot and vt-d is enabled in BIOS.
> >>> On the Ubuntu desktop, I do s2idle first and restart the machine.
> >>> The machine can't restart successfully, so I need to press the
> >>> power button to shutdown.
> >>> I tried  each of the following and the issue can't be triggered.
> >>> 1. disable secure boot in BIOS.
> >>> 2. intel_iommu=off.
> >>> 3. intel_iomm=igfx_off.
> >>> 4. nomodeset
> >>> 5. i915.modeset=0.
> >>>
> >>> After I investigate further, find inte_iommu keeps checking the status
> >>> of DMA_GSTS_TES.
> >>> During the procedure of restart, the driver would disable iommu
> >>> translation and
> >>> check status of DMA_GSTS_TES until status of DMA_GSTS_TES is 0.
> >>>
> >>> If you need more information, I can provide it.
> >>
> >> Do you mind telling what platform is it?
> >>
> >> Best regards,
> >> baolu
> > Hi Baolu,
> > Sorry, i missed your email.
> > I'm running on TGL.
> > My colleague has reported this on bugzilla.
> > Have tested your patch and it works fine.
> > https://bugzilla.kernel.org/show_bug.cgi?id=208363
> >
> > Could you explain more about these patches!? Why do we need  a flag
> > for active iommu!?
> >
>
> We're still investigating this issue. If we find out more, I'll let you
> know. Thanks a lot for the reporting.
>
> Best regards,
> baolu
>
Sorry for disturbing,
Do you have any updates for this issue?!
https://bugzilla.kernel.org/show_bug.cgi?id=208363

Koba KO
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
