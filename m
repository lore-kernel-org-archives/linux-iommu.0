Return-Path: <SRS0=1ePL=L4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8EBC07E95
	for <iommu@archiver.kernel.org>; Sun,  4 Jul 2021 07:39:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BE136135D
	for <iommu@archiver.kernel.org>; Sun,  4 Jul 2021 07:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE136135D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D1B883BDD;
	Sun,  4 Jul 2021 07:39:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VTwSOME-eQMG; Sun,  4 Jul 2021 07:39:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BF38083B60;
	Sun,  4 Jul 2021 07:39:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92503C0010;
	Sun,  4 Jul 2021 07:39:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55980C000E
 for <iommu@lists.linux-foundation.org>; Sun,  4 Jul 2021 07:39:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2F6AF400CF
 for <iommu@lists.linux-foundation.org>; Sun,  4 Jul 2021 07:39:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=solid-run-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TzLgLQ9MfXNF for <iommu@lists.linux-foundation.org>;
 Sun,  4 Jul 2021 07:39:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9C78B400A8
 for <iommu@lists.linux-foundation.org>; Sun,  4 Jul 2021 07:39:16 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id l2so36904edt.1
 for <iommu@lists.linux-foundation.org>; Sun, 04 Jul 2021 00:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZQQunou8Q0jU/ZTZKKb+xKzAPXywIUcNSDrbg6Hzbc4=;
 b=UjBVv2491CcHTIl2ATdhgmoHRqENOKjD/s9fEr6BmjS4hjsG4DmtJLUUPKHihIsA1C
 vxtr/6HuL6/4Nwd7tZ6FaRtkeGZ8TyICt0/UicK2lshtPi3Z21FHBhfO+UuYaD83Lfio
 O3Or/CAdIZ9Fv8K70hyrHATAE0523OYgM6b+OqRN79RPLpRuBEMRThRK4vlmYgxeVFd0
 wBZ4gDmL/ro2+BNzVV6kGD7FSznlVvb3UnLb5Nz4LokDKDki8xGm5kJmcuUu5NUtdnaD
 EsZtbAXMJNYlFF57C5T1MekwwOJci97v2N8Rt9n0wN8ev8LUmkNvXw2wRyiJ3WCaPGYB
 OxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZQQunou8Q0jU/ZTZKKb+xKzAPXywIUcNSDrbg6Hzbc4=;
 b=AmWwkka96052IkupO3rr8AtHFhellKW72R1TGkxDTX60Pe9RurlAUpizWa+aZhJHD/
 Y08ISjpr+xE5HOdTvSHvTrYv1s4w2UeXb2eYM2E17yFhZkLqLT3WwgLQQ0xZxaxp5u7v
 eKYD35jTJXRh0WX0yxLuIv8g+IypeKpC0y+C0Wz2Lq+a8SgxyY7SXcq//yc9W/+BCx7f
 DrV+SHn7ka7To1o/g/JKCiETKSYt6bQy3YKjQiYrGoe1DWMHDbG0I/ceiPZZoeYzDNt6
 +jvozSJZ5YwENlwTkTVp0bgbl0CSld0CBCj2NcB+JTLgy++C6T7mYJ3DChmxDGah0lFx
 JxnQ==
X-Gm-Message-State: AOAM530ZjO1mm9cx77EbyoDH1En6YIxHswSHxTDxW0zyA9/v6luWZbkE
 M89V7OMcGsX8KJqvuAdVhqvvGg8i5E8XJG9u7XDhZg==
X-Google-Smtp-Source: ABdhPJwalleSo2mpNse89qa/sYo5DJP09VqLJNHOKmmanvivMJEtn8Shbt4ycDGarig9R7C/Qg8RJQrvPd1p3TVh4tg=
X-Received: by 2002:a05:6402:50d4:: with SMTP id
 h20mr9147653edb.361.1625384354669; 
 Sun, 04 Jul 2021 00:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-4-shameerali.kolothum.thodi@huawei.com>
 <9e788789-c1c2-10f1-d99c-93cfa6ea3348@arm.com>
 <3206cd67962242a69fb83adac892e34c@huawei.com>
 <CABdtJHuKT2WfsR+hrPkpXkhyvzKumrc=KNhgeo9P01=tfWfg2w@mail.gmail.com>
In-Reply-To: <CABdtJHuKT2WfsR+hrPkpXkhyvzKumrc=KNhgeo9P01=tfWfg2w@mail.gmail.com>
From: Jon Nettleton <jon@solid-run.com>
Date: Sun, 4 Jul 2021 09:38:38 +0200
Message-ID: <CABdtJHuz9e9H15gUCBKBRongt-Yqy=aHGsnjzM3cGpEhZ7ZFng@mail.gmail.com>
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
 Robin Murphy <robin.murphy@arm.com>,
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

On Tue, Jun 29, 2021 at 7:34 PM Jon Nettleton <jon@solid-run.com> wrote:
>
> On Mon, Jun 14, 2021 at 2:49 PM Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com> wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Robin Murphy [mailto:robin.murphy@arm.com]
> > > Sent: 14 June 2021 12:23
> > > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> > > linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> > > iommu@lists.linux-foundation.org
> > > Cc: jon@solid-run.com; Linuxarm <linuxarm@huawei.com>;
> > > steven.price@arm.com; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
> > > yangyicong <yangyicong@huawei.com>; Sami.Mujawar@arm.com;
> > > wanghuiqiang <wanghuiqiang@huawei.com>
> > > Subject: Re: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory
> > > regions
> > >
> > > On 2021-05-24 12:02, Shameer Kolothum wrote:
> > > > Add a helper function that retrieves RMR memory descriptors
> > > > associated with a given IOMMU. This will be used by IOMMU
> > > > drivers to setup necessary mappings.
> > > >
> > > > Now that we have this, invoke it from the generic helper
> > > > interface.
> > > >
> > > > Signed-off-by: Shameer Kolothum
> > > <shameerali.kolothum.thodi@huawei.com>
> > > > ---
> > > >   drivers/acpi/arm64/iort.c | 50
> > > +++++++++++++++++++++++++++++++++++++++
> > > >   drivers/iommu/dma-iommu.c |  4 ++++
> > > >   include/linux/acpi_iort.h |  7 ++++++
> > > >   3 files changed, 61 insertions(+)
> > > >
> > > > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > > > index fea1ffaedf3b..01917caf58de 100644
> > > > --- a/drivers/acpi/arm64/iort.c
> > > > +++ b/drivers/acpi/arm64/iort.c
> > > > @@ -12,6 +12,7 @@
> > > >
> > > >   #include <linux/acpi_iort.h>
> > > >   #include <linux/bitfield.h>
> > > > +#include <linux/dma-iommu.h>
> > > >   #include <linux/iommu.h>
> > > >   #include <linux/kernel.h>
> > > >   #include <linux/list.h>
> > > > @@ -837,6 +838,53 @@ static inline int iort_add_device_replay(struct
> > > device *dev)
> > > >     return err;
> > > >   }
> > > >
> > > > +/**
> > > > + * iort_iommu_get_rmrs - Helper to retrieve RMR info associated with
> > > IOMMU
> > > > + * @iommu: fwnode for the IOMMU
> > > > + * @head: RMR list head to be populated
> > > > + *
> > > > + * Returns: 0 on success, <0 failure
> > > > + */
> > > > +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
> > > > +                   struct list_head *head)
> > > > +{
> > > > +   struct iort_rmr_entry *e;
> > > > +   struct acpi_iort_node *iommu;
> > > > +   int rmrs = 0;
> > > > +
> > > > +   iommu = iort_get_iort_node(iommu_fwnode);
> > > > +   if (!iommu || list_empty(&iort_rmr_list))
> > > > +           return -ENODEV;
> > > > +
> > > > +   list_for_each_entry(e, &iort_rmr_list, list) {
> > > > +           int prot = IOMMU_READ | IOMMU_WRITE | IOMMU_NOEXEC |
> > > IOMMU_MMIO;
> > > > +           struct iommu_resv_region *region;
> > > > +           enum iommu_resv_type type;
> > > > +           struct acpi_iort_rmr_desc *rmr_desc;
> > > > +
> > > > +           if (e->smmu != iommu)
> > > > +                   continue;
> > > > +
> > > > +           rmr_desc = e->rmr_desc;
> > > > +           if (e->flags & IOMMU_RMR_REMAP_PERMITTED)
> > > > +                   type = IOMMU_RESV_DIRECT_RELAXABLE;
> > > > +           else
> > > > +                   type = IOMMU_RESV_DIRECT;
> > >
>
> I have been looking at this a bit more and looking at the history of
> RMR_REMAP_PERMITTED.  Based on the history I have found it
> seems to me like this would be the better options for prot.
>
> @@ -840,7 +840,7 @@ int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
>                 return -ENODEV;
>
>         list_for_each_entry(e, &iort_rmr_list, list) {
> -               int prot = IOMMU_READ | IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> +               int prot = IOMMU_READ | IOMMU_WRITE;
>                 struct iommu_resv_region *region;
>                 enum iommu_resv_type type;
>                 struct acpi_iort_rmr_desc *rmr_desc;
> @@ -849,10 +849,13 @@ int iort_iommu_get_rmrs(struct fwnode_handle
> *iommu_fwnode,
>                         continue;
>
>                 rmr_desc = e->rmr_desc;
> -               if (e->flags & IOMMU_RMR_REMAP_PERMITTED)
> +               if (e->flags & IOMMU_RMR_REMAP_PERMITTED) {
>                         type = IOMMU_RESV_DIRECT_RELAXABLE;
> -               else
> +                       prot |= IOMMU_CACHE;
> +               } else {
>                         type = IOMMU_RESV_DIRECT;
> +                       prot |= IOMMU_MMIO;
> +               }
>
>                 region = iommu_alloc_resv_region(rmr_desc->base_address,
>                                                  rmr_desc->length,
>
> any input on this?  My reasoning is that IOMMU_RESV_DIRECT is specifically
> referenced for things like MSI doorbell and in all the examples needs
> IOMMU_MMIO, while REMAP_PERMITTED seems to be used for allocated
> system memory that is then used for device specific reserved regions which
> commits say would be like a GPU or USB device.
>
> -Jon
>
> > > Wasn't the idea that we can do all this during the initial parsing, i.e.
> > > we don't even have iort_rmr_entry, we store them as iommu_resv_regions
> > > and simply kmemdup() or whatever at this point?
> >
> >
> > Hmm... Not yet. I removed struct iommu_rmr() from v4. But yes, it looks like
> > we can get rid of iort_rmr_entry as well. Will give it a go in next.
> >
> > Thanks,
> > Shameer
> >
> > > Robin.
> > >
> > > > +
> > > > +           region = iommu_alloc_resv_region(rmr_desc->base_address,
> > > > +                                            rmr_desc->length,
> > > > +                                            prot, type);
> > > > +           if (region) {
> > > > +                   region->fw_data.rmr.flags = e->flags;
> > > > +                   region->fw_data.rmr.sid = e->sid;
> > > > +                   list_add_tail(&region->list, head);
> > > > +                   rmrs++;
> > > > +           }
> > > > +   }
> > > > +
> > > > +   return (rmrs == 0) ? -ENODEV : 0;
> > > > +}
> > > > +
> > > >   /**
> > > >    * iort_iommu_msi_get_resv_regions - Reserved region driver helper
> > > >    * @dev: Device from iommu_get_resv_regions()
> > > > @@ -1108,6 +1156,8 @@ int iort_iommu_msi_get_resv_regions(struct
> > > device *dev, struct list_head *head)
> > > >   const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
> > > >                                             const u32 *input_id)
> > > >   { return NULL; }
> > > > +int iort_iommu_get_rmrs(struct fwnode_handle *fwnode, struct list_head
> > > *head)
> > > > +{ return -ENODEV; }
> > > >   #endif
> > > >
> > > >   static int nc_dma_get_range(struct device *dev, u64 *size)
> > > > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > > > index 229ec65d98be..f893d460cfa4 100644
> > > > --- a/drivers/iommu/dma-iommu.c
> > > > +++ b/drivers/iommu/dma-iommu.c
> > > > @@ -185,6 +185,9 @@ EXPORT_SYMBOL(iommu_put_dma_cookie);
> > > >   int iommu_dma_get_rmrs(struct fwnode_handle *iommu_fwnode,
> > > >                    struct list_head *list)
> > > >   {
> > > > +   if (!is_of_node(iommu_fwnode))
> > > > +           return iort_iommu_get_rmrs(iommu_fwnode, list);
> > > > +
> > > >     return -EINVAL;
> > > >   }
> > > >   EXPORT_SYMBOL(iommu_dma_get_rmrs);
> > > > @@ -200,6 +203,7 @@ EXPORT_SYMBOL(iommu_dma_get_rmrs);
> > > >   void iommu_dma_put_rmrs(struct fwnode_handle *iommu_fwnode,
> > > >                     struct list_head *list)
> > > >   {
> > > > +   generic_iommu_put_resv_regions(iommu_fwnode->dev, list);
> > > >   }
> > > >   EXPORT_SYMBOL(iommu_dma_put_rmrs);
> > > >
> > > > diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> > > > index 1a12baa58e40..e8c45fa59531 100644
> > > > --- a/include/linux/acpi_iort.h
> > > > +++ b/include/linux/acpi_iort.h
> > > > @@ -39,6 +39,8 @@ const struct iommu_ops
> > > *iort_iommu_configure_id(struct device *dev,
> > > >                                             const u32 *id_in);
> > > >   int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head
> > > *head);
> > > >   phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
> > > > +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
> > > > +                   struct list_head *list);
> > > >   #else
> > > >   static inline void acpi_iort_init(void) { }
> > > >   static inline u32 iort_msi_map_id(struct device *dev, u32 id)
> > > > @@ -59,6 +61,11 @@ int iort_iommu_msi_get_resv_regions(struct device
> > > *dev, struct list_head *head)
> > > >
> > > >   static inline phys_addr_t acpi_iort_dma_get_max_cpu_address(void)
> > > >   { return PHYS_ADDR_MAX; }
> > > > +
> > > > +static inline
> > > > +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
> > > > +                   struct list_head *list)
> > > > +{ return -ENODEV; }
> > > >   #endif
> > > >
> > > >   #endif /* __ACPI_IORT_H__ */
> > > >

Ping.  Any comments on this?

-Jon
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
