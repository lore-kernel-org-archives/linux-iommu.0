Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05D4C43334
	for <iommu@archiver.kernel.org>; Tue,  5 Jul 2022 18:27:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 678A7817A9;
	Tue,  5 Jul 2022 18:27:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 678A7817A9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w34ZA35GrVJv; Tue,  5 Jul 2022 18:27:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2012D814B4;
	Tue,  5 Jul 2022 18:27:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2012D814B4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5EA5C0032;
	Tue,  5 Jul 2022 18:27:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E473FC002D
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 18:27:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A78AC415B2
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 18:27:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A78AC415B2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kKWjEUdWk8Da for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 18:27:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CD7E64049F
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CD7E64049F
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 18:27:31 +0000 (UTC)
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-31c89653790so66623727b3.13
 for <iommu@lists.linux-foundation.org>; Tue, 05 Jul 2022 11:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yDaZJQ1t7WZXHXc1sh5v+s4p6BMcgf4NLI5GY92Hi9Y=;
 b=vBHwEyq39b1vTBC+YEdzpAH56B8X1V79r4YIAC8uDBCqwaSM099A6Cm7Y3VjzBS/Ta
 VmzBfZnggtpw189Geeg+9XQP+1Db35bXa1+NqLggdYi1sDO2HgmEJ+f7bjfGKqYFxTNw
 XwIcP1NLsUjpV+QyyMxJZhBE7s9pnjIxrFYtnB0CPJoNCscw/PzTrmZJMMWVEyLMnlUE
 MdY5otKt5FXjTvScjiXrFzaKvxXpe8urpw16aa/HR9Ng2/W+De44nj2bIDhW7xHoFgiD
 LD0piVPgnt0NjtJggWSjXhjUMDzRijDiZ3lJdQQObj7yzvRXAyhk98E0f67X58AyHFtr
 p18g==
X-Gm-Message-State: AJIora/SfWYdVIWudD2KhTUKXuOb7os/N5WgcPiWhW3n4zkM/HUaajy5
 CnPV2xuEH4rnUj0KgvGKI+a24faEUJ9tm0rbtOU=
X-Google-Smtp-Source: AGRyM1s2QEn+mZPivlKtPrgixQUmIChTU4gw5ikon89zd7049nfH/7sTVF3gtghrOQrMUchoZ2CX/5thIM3o6KDInik=
X-Received: by 2002:a0d:d8c8:0:b0:31c:92b1:5dec with SMTP id
 a191-20020a0dd8c8000000b0031c92b15decmr14867269ywe.19.1657045650713; Tue, 05
 Jul 2022 11:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220630094059.1204283-1-eric.auger@redhat.com>
 <Yr1z2gC0+8zbzpFf@myrica>
In-Reply-To: <Yr1z2gC0+8zbzpFf@myrica>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 Jul 2022 20:27:19 +0200
Message-ID: <CAJZ5v0hqcUUTVzkHxGr9pB5G-T5ye5g_=DQVO6L347DpXipwOg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: VIOT: Fix ACS setup
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>, iommu@lists.linux.dev, jinl@redhat.com,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 eric.auger.pro@gmail.com, Len Brown <lenb@kernel.org>
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

On Thu, Jun 30, 2022 at 11:59 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> On Thu, Jun 30, 2022 at 11:40:59AM +0200, Eric Auger wrote:
> > Currently acpi_viot_init() gets called after the pci
> > device has been scanned and pci_enable_acs() has been called.
> > So pci_request_acs() fails to be taken into account leading
> > to wrong single iommu group topologies when dealing with
> > multi-function root ports for instance.
> >
> > We cannot simply move the acpi_viot_init() earlier, similarly
> > as the IORT init because the VIOT parsing relies on the pci
> > scan. However we can detect VIOT is present earlier and in
> > such a case, request ACS. Introduce a new acpi_viot_early_init()
> > routine that allows to call pci_request_acs() before the scan.
> >
> > While at it, guard the call to pci_request_acs() with #ifdef
> > CONFIG_PCI.
> >
> > Fixes: 3cf485540e7b ("ACPI: Add driver for the VIOT table")
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > Reported-by: Jin Liu <jinl@redhat.com>
>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Applied as 5.20 material, thanks!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
