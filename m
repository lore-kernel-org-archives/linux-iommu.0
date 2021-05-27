Return-Path: <SRS0=nChL=KW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17162C4707F
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 04:26:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 832E7613B6
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 04:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 832E7613B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 469FC60717;
	Thu, 27 May 2021 04:26:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1fAdwnPtUZ_j; Thu, 27 May 2021 04:26:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A28E60668;
	Thu, 27 May 2021 04:26:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5C67C000E;
	Thu, 27 May 2021 04:26:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 189CAC0001
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 04:26:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E40E64055F
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 04:26:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=solid-run-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T5ml6hXvc2l1 for <iommu@lists.linux-foundation.org>;
 Thu, 27 May 2021 04:26:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 774574040A
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 04:26:29 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id k14so5907838eji.2
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 21:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MuUPMsBblFv1sa2XEzf9FhR5nku7Yzg5FRIozyJMbVs=;
 b=oJ1RrS93T/Y6l9C/Be0U5byek0L3iZSx6/E+PjohXK+Dv5uJuO8eVhzUpS56Cu4Rxr
 C08Cn0ETIGdwku0hFEhDGcnBiUfcj6hVZJXx78N03q7cQaLV547HCzm8/7tTVUli9aJC
 HWn378qDga97k1q+GMZxBZmHRkrU6lox/pb0wnYZgwZCG1s5TVDEzOyJdQQYivkAwlGN
 t2/YidV7QghniSvTFUIBiAMQi/8UEs7zJ90UskmBvE2pZSGEVCcJqQ5LgkEt+8RNN9t+
 obZjJEF2g4vH72lVxTlm7WGemQm2v8+0NIroYYLVRcb/GwcLf8+5AI/eVlpiC9djkhKL
 4jwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MuUPMsBblFv1sa2XEzf9FhR5nku7Yzg5FRIozyJMbVs=;
 b=l8GSC2ydDmibuccYXPud3fUWG9aiO+F2YOF54eikpeyK2Tfh6faBno9A0HTcTjD/N4
 FnaqDoXSv6RmncKie/YLHWIvkDjanihGdt6y0mrCFirunGCHWQx1nEIcfaoiesAmlMFT
 VTn0W2WURn2tPsNfgm46rJpBqmFrWIxYQ+jC67+XCi361t++64kXqPlpy/57OW36lJv0
 mPvBQweyTgUA7ot/6RutcADQYAe+SMAEBkfdaTKb8OaEYviJOK6LJL0snINd4s6WmkSh
 V+NcB3gLyNgP74WGhIHfD61uDdsPWvXO9iNbKORtQRFQcQeqWPE6yKmQfvP40Ark2SLE
 /poQ==
X-Gm-Message-State: AOAM530Cv7cXz7PZS71KlxLEBHenTdjqTresrCSZmOIUtbhnCmg9LgSV
 CaQxWQg0t+q23S8tOfDn9LzToGIibtyZ8OuPCwsQAQ==
X-Google-Smtp-Source: ABdhPJwLBPm+M32hCgK1/i4GtoIfZcGVvMGzA9iXyPCuW/JYMi8Lqp3Mepx9n6LiB4zDvZG1eZkKf5Y8jqeCKL158Lc=
X-Received: by 2002:a17:906:4704:: with SMTP id
 y4mr1759294ejq.68.1622089587584; 
 Wed, 26 May 2021 21:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-4-shameerali.kolothum.thodi@huawei.com>
 <13c2499e-cc0c-d395-0d60-6c3437f206ac@nxp.com>
 <260859e85c854b90b513599f4febfbad@huawei.com>
In-Reply-To: <260859e85c854b90b513599f4febfbad@huawei.com>
From: Jon Nettleton <jon@solid-run.com>
Date: Thu, 27 May 2021 06:25:48 +0200
Message-ID: <CABdtJHsoN8-9+uogbRP+Tn2d0wjo8XNzKFOPOUwE+S4NVRoawQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory
 regions
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Linuxarm <linuxarm@huawei.com>,
 "steven.price@arm.com" <steven.price@arm.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 wanghuiqiang <wanghuiqiang@huawei.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 yangyicong <yangyicong@huawei.com>,
 "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On Wed, May 26, 2021 at 6:36 PM Shameerali Kolothum Thodi
<shameerali.kolothum.thodi@huawei.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Laurentiu Tudor [mailto:laurentiu.tudor@nxp.com]
> > Sent: 26 May 2021 08:53
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> > linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> > iommu@lists.linux-foundation.org
> > Cc: jon@solid-run.com; Linuxarm <linuxarm@huawei.com>;
> > steven.price@arm.com; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
> > yangyicong <yangyicong@huawei.com>; Sami.Mujawar@arm.com;
> > robin.murphy@arm.com; wanghuiqiang <wanghuiqiang@huawei.com>
> > Subject: Re: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory
> > regions
> >
> > Hi Shameer,
> >
> > On 5/24/2021 2:02 PM, Shameer Kolothum wrote:
> > > Add a helper function that retrieves RMR memory descriptors
> > > associated with a given IOMMU. This will be used by IOMMU
> > > drivers to setup necessary mappings.
> > >
> > > Now that we have this, invoke it from the generic helper
> > > interface.
> > >
> > > Signed-off-by: Shameer Kolothum
> > <shameerali.kolothum.thodi@huawei.com>
> > > ---
> > >  drivers/acpi/arm64/iort.c | 50
> > +++++++++++++++++++++++++++++++++++++++
> > >  drivers/iommu/dma-iommu.c |  4 ++++
> > >  include/linux/acpi_iort.h |  7 ++++++
> > >  3 files changed, 61 insertions(+)
> > >
> > > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > > index fea1ffaedf3b..01917caf58de 100644
> > > --- a/drivers/acpi/arm64/iort.c
> > > +++ b/drivers/acpi/arm64/iort.c
> > > @@ -12,6 +12,7 @@
> > >
> > >  #include <linux/acpi_iort.h>
> > >  #include <linux/bitfield.h>
> > > +#include <linux/dma-iommu.h>
> > >  #include <linux/iommu.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/list.h>
> > > @@ -837,6 +838,53 @@ static inline int iort_add_device_replay(struct
> > device *dev)
> > >     return err;
> > >  }
> > >
> > > +/**
> > > + * iort_iommu_get_rmrs - Helper to retrieve RMR info associated with
> > IOMMU
> > > + * @iommu: fwnode for the IOMMU
> > > + * @head: RMR list head to be populated
> > > + *
> > > + * Returns: 0 on success, <0 failure
> > > + */
> > > +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
> > > +                   struct list_head *head)
> > > +{
> > > +   struct iort_rmr_entry *e;
> > > +   struct acpi_iort_node *iommu;
> > > +   int rmrs = 0;
> > > +
> > > +   iommu = iort_get_iort_node(iommu_fwnode);
> > > +   if (!iommu || list_empty(&iort_rmr_list))
> > > +           return -ENODEV;
> > > +
> > > +   list_for_each_entry(e, &iort_rmr_list, list) {
> > > +           int prot = IOMMU_READ | IOMMU_WRITE | IOMMU_NOEXEC |
> > IOMMU_MMIO;
> >
> > We have a case with an IP block that needs EXEC rights on its reserved
> > memory, so could you please drop the IOMMU_NOEXEC flag?
>
> Ok, I think I can drop that one if there are no other concerns. I was not quite
> sure what to include here in the first place as the IORT spec is not giving any
> further details about the RMR regions(May be the flags field can be extended to
> describe these details).

We probably need to bring this back up to the ACPI forums. This is probably
something that should be attached to the memory range node which does have
4 extra reserved bytes.

-Jon

>
> Thanks,
> Shameer
>
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
