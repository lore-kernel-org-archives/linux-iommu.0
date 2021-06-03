Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB621C47082
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 12:28:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97E2B613E7
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 12:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E2B613E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7157C400E5;
	Thu,  3 Jun 2021 12:28:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L296GDJFXxHu; Thu,  3 Jun 2021 12:28:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id B813D400F7;
	Thu,  3 Jun 2021 12:28:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AF5BC000F;
	Thu,  3 Jun 2021 12:28:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 171C6C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 12:28:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 08521608F6
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 12:28:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=solid-run-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aX--MuDBis-n for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 12:28:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 368A7607F9
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 12:28:04 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id r11so6848248edt.13
 for <iommu@lists.linux-foundation.org>; Thu, 03 Jun 2021 05:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cupGVl/5IxTa3rKFLjJb5XZgvnX7W+pc3ZwSu6gCUuU=;
 b=rf0uRuH8SyYiJW8SWeFHcGQEDeU9+71HgbKqphlndA9glZbX/gj1s7bwPrvwDHpr//
 wd4rCrv2w0mWzaCSh9OcEjSYoVl0jOX4cZLQfkK4CSGar3mR9VDp9JOx1UoQrX7gw4lo
 CPR9sv5FoDbjo5il2gYeA4FGndDB7BBpiv9RQTbH3wDzr6aHXOwKjIuScOr+vWXDPUxG
 RwzBYo4nCJalkbCd4jUIUoW2XzcQ2xNuAuzHg8Ul3ZGW5tP6A+LozCti9ajxBrTT8IMQ
 6XstNKNkXalKWFbF3u0ODc6y+v+R6lPKIec1ez9yseIEGQ2tCpAD8eLhvGeQ/q+n2Uyw
 Nv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cupGVl/5IxTa3rKFLjJb5XZgvnX7W+pc3ZwSu6gCUuU=;
 b=V7wooMXT91vDjIdMD7I0J1mPxlEu3F8+7JGTmTHeVfX1cz/JdZtfLCOq94jMI+wYz5
 xio+MlTBY0qKJ26f+vvsiScHPYD+FVOQjyRjUfeHW5SGD3AJDjBtsNnY7zkU/UxK/prj
 P/+1QjLOEslfjrNlMZlLA1Pndu2q9PO8IFiqJrir1X54TissLPvWxxtRliczXF6TbNEG
 /9rYVfc5MLfKdKXqRzBh9R7AH4JH5xSi7m4o/RO8GT/eZk0aZfDpTDPY//j3eIVngu5N
 vsJggDaPxPr629GH/2ZWO3fTISfhFnbH9awHC28fGExN/7gBVWfOKczXjs7v0pxWDyBu
 GpVw==
X-Gm-Message-State: AOAM530t6omX6qAZ4yk5lKdmwGqgAh4fTXmKdR15W34U7gDC1R9AYGaw
 w5bQlNyRgOg2MCfxh8SeiHlAbQYbocCigPaipWAmjQ==
X-Google-Smtp-Source: ABdhPJxOzOWvdmytbNa3BVIP0qM3IZFg/1c1m6StO2tWfQYWIO26jbmMbFpCBTml+0lK9VSVGualJJsU6ExeT7WiAMw=
X-Received: by 2002:a05:6402:50d2:: with SMTP id
 h18mr44109981edb.10.1622723282435; 
 Thu, 03 Jun 2021 05:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-4-shameerali.kolothum.thodi@huawei.com>
 <13c2499e-cc0c-d395-0d60-6c3437f206ac@nxp.com>
 <260859e85c854b90b513599f4febfbad@huawei.com>
 <df3ac090-118e-6ee4-80ee-798cc3760775@nxp.com>
In-Reply-To: <df3ac090-118e-6ee4-80ee-798cc3760775@nxp.com>
From: Jon Nettleton <jon@solid-run.com>
Date: Thu, 3 Jun 2021 14:27:26 +0200
Message-ID: <CABdtJHv2QBHNoWTyp51H-J_apc75imPj0FbrV70Tm8xuNjpiTA@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory
 regions
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
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

On Wed, May 26, 2021 at 7:11 PM Laurentiu Tudor <laurentiu.tudor@nxp.com> wrote:
>
>
>
> On 5/26/2021 7:36 PM, Shameerali Kolothum Thodi wrote:
> >
> >
> >> -----Original Message-----
> >> From: Laurentiu Tudor [mailto:laurentiu.tudor@nxp.com]
> >> Sent: 26 May 2021 08:53
> >> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> >> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> >> iommu@lists.linux-foundation.org
> >> Cc: jon@solid-run.com; Linuxarm <linuxarm@huawei.com>;
> >> steven.price@arm.com; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
> >> yangyicong <yangyicong@huawei.com>; Sami.Mujawar@arm.com;
> >> robin.murphy@arm.com; wanghuiqiang <wanghuiqiang@huawei.com>
> >> Subject: Re: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory
> >> regions
> >>
> >> Hi Shameer,
> >>
> >> On 5/24/2021 2:02 PM, Shameer Kolothum wrote:
> >>> Add a helper function that retrieves RMR memory descriptors
> >>> associated with a given IOMMU. This will be used by IOMMU
> >>> drivers to setup necessary mappings.
> >>>
> >>> Now that we have this, invoke it from the generic helper
> >>> interface.
> >>>
> >>> Signed-off-by: Shameer Kolothum
> >> <shameerali.kolothum.thodi@huawei.com>
> >>> ---
> >>>  drivers/acpi/arm64/iort.c | 50
> >> +++++++++++++++++++++++++++++++++++++++
> >>>  drivers/iommu/dma-iommu.c |  4 ++++
> >>>  include/linux/acpi_iort.h |  7 ++++++
> >>>  3 files changed, 61 insertions(+)
> >>>
> >>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> >>> index fea1ffaedf3b..01917caf58de 100644
> >>> --- a/drivers/acpi/arm64/iort.c
> >>> +++ b/drivers/acpi/arm64/iort.c
> >>> @@ -12,6 +12,7 @@
> >>>
> >>>  #include <linux/acpi_iort.h>
> >>>  #include <linux/bitfield.h>
> >>> +#include <linux/dma-iommu.h>
> >>>  #include <linux/iommu.h>
> >>>  #include <linux/kernel.h>
> >>>  #include <linux/list.h>
> >>> @@ -837,6 +838,53 @@ static inline int iort_add_device_replay(struct
> >> device *dev)
> >>>     return err;
> >>>  }
> >>>
> >>> +/**
> >>> + * iort_iommu_get_rmrs - Helper to retrieve RMR info associated with
> >> IOMMU
> >>> + * @iommu: fwnode for the IOMMU
> >>> + * @head: RMR list head to be populated
> >>> + *
> >>> + * Returns: 0 on success, <0 failure
> >>> + */
> >>> +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
> >>> +                   struct list_head *head)
> >>> +{
> >>> +   struct iort_rmr_entry *e;
> >>> +   struct acpi_iort_node *iommu;
> >>> +   int rmrs = 0;
> >>> +
> >>> +   iommu = iort_get_iort_node(iommu_fwnode);
> >>> +   if (!iommu || list_empty(&iort_rmr_list))
> >>> +           return -ENODEV;
> >>> +
> >>> +   list_for_each_entry(e, &iort_rmr_list, list) {
> >>> +           int prot = IOMMU_READ | IOMMU_WRITE | IOMMU_NOEXEC |
> >> IOMMU_MMIO;
> >>
> >> We have a case with an IP block that needs EXEC rights on its reserved
> >> memory, so could you please drop the IOMMU_NOEXEC flag?
> >
> > Ok, I think I can drop that one if there are no other concerns. I was not quite
> > sure what to include here in the first place as the IORT spec is not giving any
> > further details about the RMR regions(May be the flags field can be extended to
> > describe these details).
> >
>
> That would be great, given that some preliminary investigations on my
> side revealed that our IP block seems to be quite sensitive to memory
> attributes. I need to spend some more time on this but at first sight
> looks like it needs cacheable, normal memory (not mmio mapping).
>
> ---
> Thanks & Best Regards, Laurentiu

Laurentiu,

Is this regarding the mc-bin memory block or another IP?  I am currently
running this patchset with IOMMU_NOEXEC under ACPI without any problems.

If so maybe we can touch base off list and align on the implementation.

-Jon
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
