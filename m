Return-Path: <SRS0=3QBT=L5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41566C07E98
	for <iommu@archiver.kernel.org>; Mon,  5 Jul 2021 09:10:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E49A361222
	for <iommu@archiver.kernel.org>; Mon,  5 Jul 2021 09:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49A361222
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EA6760699;
	Mon,  5 Jul 2021 09:10:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y4NNm6UKu9aG; Mon,  5 Jul 2021 09:10:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3A5CB600C6;
	Mon,  5 Jul 2021 09:10:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18EC4C001A;
	Mon,  5 Jul 2021 09:10:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3126C000E
 for <iommu@lists.linux-foundation.org>; Mon,  5 Jul 2021 09:10:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF4FB40486
 for <iommu@lists.linux-foundation.org>; Mon,  5 Jul 2021 09:10:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e9IwIDPAVgGA for <iommu@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 09:10:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 99F444046A
 for <iommu@lists.linux-foundation.org>; Mon,  5 Jul 2021 09:10:29 +0000 (UTC)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GJKZC5CjKz783B;
 Mon,  5 Jul 2021 17:06:59 +0800 (CST)
Received: from dggpemm500003.china.huawei.com (7.185.36.56) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 5 Jul 2021 17:10:06 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm500003.china.huawei.com (7.185.36.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 5 Jul 2021 17:10:04 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2176.012; Mon, 5 Jul 2021 10:10:02 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Jon Nettleton <jon@solid-run.com>, Robin Murphy <robin.murphy@arm.com>
Subject: RE: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory
 regions
Thread-Topic: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory
 regions
Thread-Index: AQHXUIxzNCstxTr9F0iaZEElN6n+2KsTbWwAgAAl39CAF9T/AIAHNQ4AgAG6w9A=
Date: Mon, 5 Jul 2021 09:10:02 +0000
Message-ID: <c93639053db74891bc73606b7a36b476@huawei.com>
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-4-shameerali.kolothum.thodi@huawei.com>
 <9e788789-c1c2-10f1-d99c-93cfa6ea3348@arm.com>
 <3206cd67962242a69fb83adac892e34c@huawei.com>
 <CABdtJHuKT2WfsR+hrPkpXkhyvzKumrc=KNhgeo9P01=tfWfg2w@mail.gmail.com>
 <CABdtJHuz9e9H15gUCBKBRongt-Yqy=aHGsnjzM3cGpEhZ7ZFng@mail.gmail.com>
In-Reply-To: <CABdtJHuz9e9H15gUCBKBRongt-Yqy=aHGsnjzM3cGpEhZ7ZFng@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.83.49]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: Linuxarm <linuxarm@huawei.com>,
 "steven.price@arm.com" <steven.price@arm.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 wanghuiqiang <wanghuiqiang@huawei.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 yangyicong <yangyicong@huawei.com>,
 "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
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



> -----Original Message-----
> From: Jon Nettleton [mailto:jon@solid-run.com]
> Sent: 04 July 2021 08:39
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: Robin Murphy <robin.murphy@arm.com>;
> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> iommu@lists.linux-foundation.org; Linuxarm <linuxarm@huawei.com>;
> steven.price@arm.com; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
> yangyicong <yangyicong@huawei.com>; Sami.Mujawar@arm.com;
> wanghuiqiang <wanghuiqiang@huawei.com>
> Subject: Re: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory
> regions
> 
> On Tue, Jun 29, 2021 at 7:34 PM Jon Nettleton <jon@solid-run.com> wrote:
> >
> > On Mon, Jun 14, 2021 at 2:49 PM Shameerali Kolothum Thodi
> > <shameerali.kolothum.thodi@huawei.com> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Robin Murphy [mailto:robin.murphy@arm.com]
> > > > Sent: 14 June 2021 12:23
> > > > To: Shameerali Kolothum Thodi
> > > > <shameerali.kolothum.thodi@huawei.com>;
> > > > linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> > > > iommu@lists.linux-foundation.org
> > > > Cc: jon@solid-run.com; Linuxarm <linuxarm@huawei.com>;
> > > > steven.price@arm.com; Guohanjun (Hanjun Guo)
> > > > <guohanjun@huawei.com>; yangyicong <yangyicong@huawei.com>;
> > > > Sami.Mujawar@arm.com; wanghuiqiang <wanghuiqiang@huawei.com>
> > > > Subject: Re: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve
> > > > RMR memory regions
> > > >
> > > > On 2021-05-24 12:02, Shameer Kolothum wrote:
> > > > > Add a helper function that retrieves RMR memory descriptors
> > > > > associated with a given IOMMU. This will be used by IOMMU
> > > > > drivers to setup necessary mappings.
> > > > >
> > > > > Now that we have this, invoke it from the generic helper
> > > > > interface.
> > > > >
> > > > > Signed-off-by: Shameer Kolothum
> > > > <shameerali.kolothum.thodi@huawei.com>
> > > > > ---
> > > > >   drivers/acpi/arm64/iort.c | 50
> > > > +++++++++++++++++++++++++++++++++++++++
> > > > >   drivers/iommu/dma-iommu.c |  4 ++++
> > > > >   include/linux/acpi_iort.h |  7 ++++++
> > > > >   3 files changed, 61 insertions(+)
> > > > >
> > > > > diff --git a/drivers/acpi/arm64/iort.c
> > > > > b/drivers/acpi/arm64/iort.c index fea1ffaedf3b..01917caf58de
> > > > > 100644
> > > > > --- a/drivers/acpi/arm64/iort.c
> > > > > +++ b/drivers/acpi/arm64/iort.c
> > > > > @@ -12,6 +12,7 @@
> > > > >
> > > > >   #include <linux/acpi_iort.h>
> > > > >   #include <linux/bitfield.h>
> > > > > +#include <linux/dma-iommu.h>
> > > > >   #include <linux/iommu.h>
> > > > >   #include <linux/kernel.h>
> > > > >   #include <linux/list.h>
> > > > > @@ -837,6 +838,53 @@ static inline int
> > > > > iort_add_device_replay(struct
> > > > device *dev)
> > > > >     return err;
> > > > >   }
> > > > >
> > > > > +/**
> > > > > + * iort_iommu_get_rmrs - Helper to retrieve RMR info associated
> > > > > +with
> > > > IOMMU
> > > > > + * @iommu: fwnode for the IOMMU
> > > > > + * @head: RMR list head to be populated
> > > > > + *
> > > > > + * Returns: 0 on success, <0 failure  */ int
> > > > > +iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
> > > > > +                   struct list_head *head) {
> > > > > +   struct iort_rmr_entry *e;
> > > > > +   struct acpi_iort_node *iommu;
> > > > > +   int rmrs = 0;
> > > > > +
> > > > > +   iommu = iort_get_iort_node(iommu_fwnode);
> > > > > +   if (!iommu || list_empty(&iort_rmr_list))
> > > > > +           return -ENODEV;
> > > > > +
> > > > > +   list_for_each_entry(e, &iort_rmr_list, list) {
> > > > > +           int prot = IOMMU_READ | IOMMU_WRITE |
> IOMMU_NOEXEC |
> > > > IOMMU_MMIO;
> > > > > +           struct iommu_resv_region *region;
> > > > > +           enum iommu_resv_type type;
> > > > > +           struct acpi_iort_rmr_desc *rmr_desc;
> > > > > +
> > > > > +           if (e->smmu != iommu)
> > > > > +                   continue;
> > > > > +
> > > > > +           rmr_desc = e->rmr_desc;
> > > > > +           if (e->flags & IOMMU_RMR_REMAP_PERMITTED)
> > > > > +                   type = IOMMU_RESV_DIRECT_RELAXABLE;
> > > > > +           else
> > > > > +                   type = IOMMU_RESV_DIRECT;
> > > >
> >
> > I have been looking at this a bit more and looking at the history of
> > RMR_REMAP_PERMITTED.  Based on the history I have found it seems to
> me
> > like this would be the better options for prot.
> >
> > @@ -840,7 +840,7 @@ int iort_iommu_get_rmrs(struct fwnode_handle
> *iommu_fwnode,
> >                 return -ENODEV;
> >
> >         list_for_each_entry(e, &iort_rmr_list, list) {
> > -               int prot = IOMMU_READ | IOMMU_WRITE |
> IOMMU_NOEXEC | IOMMU_MMIO;
> > +               int prot = IOMMU_READ | IOMMU_WRITE;
> >                 struct iommu_resv_region *region;
> >                 enum iommu_resv_type type;
> >                 struct acpi_iort_rmr_desc *rmr_desc; @@ -849,10
> > +849,13 @@ int iort_iommu_get_rmrs(struct fwnode_handle
> *iommu_fwnode,
> >                         continue;
> >
> >                 rmr_desc = e->rmr_desc;
> > -               if (e->flags & IOMMU_RMR_REMAP_PERMITTED)
> > +               if (e->flags & IOMMU_RMR_REMAP_PERMITTED) {
> >                         type = IOMMU_RESV_DIRECT_RELAXABLE;
> > -               else
> > +                       prot |= IOMMU_CACHE;
> > +               } else {
> >                         type = IOMMU_RESV_DIRECT;
> > +                       prot |= IOMMU_MMIO;
> > +               }
> >
> >                 region =
> iommu_alloc_resv_region(rmr_desc->base_address,
> >                                                  rmr_desc->length,
> >
> > any input on this?  My reasoning is that IOMMU_RESV_DIRECT is
> > specifically referenced for things like MSI doorbell and in all the
> > examples needs IOMMU_MMIO, while REMAP_PERMITTED seems to be used
> for
> > allocated system memory that is then used for device specific reserved
> > regions which commits say would be like a GPU or USB device.

I am Ok to make those changes but not sure we can make the above assumptions
based on the way it is currently used. 

Hi Robin,

Any thoughts?

Thanks,
Shameer

> >
> > -Jon
> >
> > > > Wasn't the idea that we can do all this during the initial parsing, i.e.
> > > > we don't even have iort_rmr_entry, we store them as
> > > > iommu_resv_regions and simply kmemdup() or whatever at this point?
> > >
> > >
> > > Hmm... Not yet. I removed struct iommu_rmr() from v4. But yes, it
> > > looks like we can get rid of iort_rmr_entry as well. Will give it a go in next.
> > >
> > > Thanks,
> > > Shameer
> > >
> > > > Robin.
> > > >
> > > > > +
> > > > > +           region =
> iommu_alloc_resv_region(rmr_desc->base_address,
> > > > > +                                            rmr_desc->length,
> > > > > +                                            prot, type);
> > > > > +           if (region) {
> > > > > +                   region->fw_data.rmr.flags = e->flags;
> > > > > +                   region->fw_data.rmr.sid = e->sid;
> > > > > +                   list_add_tail(&region->list, head);
> > > > > +                   rmrs++;
> > > > > +           }
> > > > > +   }
> > > > > +
> > > > > +   return (rmrs == 0) ? -ENODEV : 0; }
> > > > > +
> > > > >   /**
> > > > >    * iort_iommu_msi_get_resv_regions - Reserved region driver helper
> > > > >    * @dev: Device from iommu_get_resv_regions() @@ -1108,6
> > > > > +1156,8 @@ int iort_iommu_msi_get_resv_regions(struct
> > > > device *dev, struct list_head *head)
> > > > >   const struct iommu_ops *iort_iommu_configure_id(struct device
> *dev,
> > > > >                                             const u32
> *input_id)
> > > > >   { return NULL; }
> > > > > +int iort_iommu_get_rmrs(struct fwnode_handle *fwnode, struct
> > > > > +list_head
> > > > *head)
> > > > > +{ return -ENODEV; }
> > > > >   #endif
> > > > >
> > > > >   static int nc_dma_get_range(struct device *dev, u64 *size)
> > > > > diff --git a/drivers/iommu/dma-iommu.c
> > > > > b/drivers/iommu/dma-iommu.c index 229ec65d98be..f893d460cfa4
> > > > > 100644
> > > > > --- a/drivers/iommu/dma-iommu.c
> > > > > +++ b/drivers/iommu/dma-iommu.c
> > > > > @@ -185,6 +185,9 @@ EXPORT_SYMBOL(iommu_put_dma_cookie);
> > > > >   int iommu_dma_get_rmrs(struct fwnode_handle *iommu_fwnode,
> > > > >                    struct list_head *list)
> > > > >   {
> > > > > +   if (!is_of_node(iommu_fwnode))
> > > > > +           return iort_iommu_get_rmrs(iommu_fwnode, list);
> > > > > +
> > > > >     return -EINVAL;
> > > > >   }
> > > > >   EXPORT_SYMBOL(iommu_dma_get_rmrs);
> > > > > @@ -200,6 +203,7 @@ EXPORT_SYMBOL(iommu_dma_get_rmrs);
> > > > >   void iommu_dma_put_rmrs(struct fwnode_handle *iommu_fwnode,
> > > > >                     struct list_head *list)
> > > > >   {
> > > > > +   generic_iommu_put_resv_regions(iommu_fwnode->dev, list);
> > > > >   }
> > > > >   EXPORT_SYMBOL(iommu_dma_put_rmrs);
> > > > >
> > > > > diff --git a/include/linux/acpi_iort.h
> > > > > b/include/linux/acpi_iort.h index 1a12baa58e40..e8c45fa59531
> > > > > 100644
> > > > > --- a/include/linux/acpi_iort.h
> > > > > +++ b/include/linux/acpi_iort.h
> > > > > @@ -39,6 +39,8 @@ const struct iommu_ops
> > > > *iort_iommu_configure_id(struct device *dev,
> > > > >                                             const u32 *id_in);
> > > > >   int iort_iommu_msi_get_resv_regions(struct device *dev, struct
> > > > > list_head
> > > > *head);
> > > > >   phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
> > > > > +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
> > > > > +                   struct list_head *list);
> > > > >   #else
> > > > >   static inline void acpi_iort_init(void) { }
> > > > >   static inline u32 iort_msi_map_id(struct device *dev, u32 id)
> > > > > @@ -59,6 +61,11 @@ int iort_iommu_msi_get_resv_regions(struct
> > > > > device
> > > > *dev, struct list_head *head)
> > > > >
> > > > >   static inline phys_addr_t acpi_iort_dma_get_max_cpu_address(void)
> > > > >   { return PHYS_ADDR_MAX; }
> > > > > +
> > > > > +static inline
> > > > > +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
> > > > > +                   struct list_head *list) { return -ENODEV; }
> > > > >   #endif
> > > > >
> > > > >   #endif /* __ACPI_IORT_H__ */
> > > > >
> 
> Ping.  Any comments on this?
> 
> -Jon
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
