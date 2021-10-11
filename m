Return-Path: <SRS0=5Hhm=O7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816ABC433EF
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 05:51:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25F1E60F6E
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 05:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 25F1E60F6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4436605FD;
	Mon, 11 Oct 2021 05:51:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E50PBgdlPYhY; Mon, 11 Oct 2021 05:51:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A85CE606E9;
	Mon, 11 Oct 2021 05:51:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D204C0011;
	Mon, 11 Oct 2021 05:51:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1365AC000D
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 05:51:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D97774026A
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 05:51:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lQBVGSFDFZfC for <iommu@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 05:51:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 68CB740124
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 05:51:17 +0000 (UTC)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HSSYs6qM1z8tXc;
 Mon, 11 Oct 2021 13:50:09 +0800 (CST)
Received: from dggema721-chm.china.huawei.com (10.3.20.85) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 13:51:14 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggema721-chm.china.huawei.com (10.3.20.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Mon, 11 Oct 2021 13:51:12 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.008; Mon, 11 Oct 2021 06:51:11 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v7 3/9] iommu/dma: Introduce generic helper to retrieve
 RMR info
Thread-Topic: [PATCH v7 3/9] iommu/dma: Introduce generic helper to retrieve
 RMR info
Thread-Index: AQHXidEodx2BBVDhGUqCqzqCM6RTq6vJZXAAgAROiyA=
Date: Mon, 11 Oct 2021 05:51:11 +0000
Message-ID: <183c95d412df42c9b9a1ef6123832916@huawei.com>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-4-shameerali.kolothum.thodi@huawei.com>
 <53208fa4-576c-f590-334a-6d1ce8170031@arm.com>
In-Reply-To: <53208fa4-576c-f590-334a-6d1ce8170031@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.25.32]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "jon@solid-run.com" <jon@solid-run.com>, Linuxarm <linuxarm@huawei.com>,
 "steven.price@arm.com" <steven.price@arm.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 yangyicong <yangyicong@huawei.com>,
 "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
 "will@kernel.org" <will@kernel.org>, wanghuiqiang <wanghuiqiang@huawei.com>
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
> From: Robin Murphy [mailto:robin.murphy@arm.com]
> Sent: 08 October 2021 14:04
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> iommu@lists.linux-foundation.org
> Cc: Linuxarm <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com;
> joro@8bytes.org; will@kernel.org; wanghuiqiang
> <wanghuiqiang@huawei.com>; Guohanjun (Hanjun Guo)
> <guohanjun@huawei.com>; steven.price@arm.com; Sami.Mujawar@arm.com;
> jon@solid-run.com; eric.auger@redhat.com; yangyicong
> <yangyicong@huawei.com>
> Subject: Re: [PATCH v7 3/9] iommu/dma: Introduce generic helper to retrieve
> RMR info
> 
> On 2021-08-05 09:07, Shameer Kolothum wrote:
> > Reserved Memory Regions(RMR) associated with an IOMMU can be
> > described through ACPI IORT tables in systems with devices
> > that require a unity mapping or bypass for those
> > regions.
> >
> > Introduce a generic interface so that IOMMU drivers can retrieve
> > and set up necessary mappings.
> >
> > Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi@huawei.com>
> > ---
> >   drivers/iommu/dma-iommu.c | 29 +++++++++++++++++++++++++++++
> >   include/linux/dma-iommu.h | 13 +++++++++++++
> >   2 files changed, 42 insertions(+)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 98ba927aee1a..2fa2445e9070 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -174,6 +174,35 @@ void iommu_put_dma_cookie(struct
> iommu_domain *domain)
> >   }
> >   EXPORT_SYMBOL(iommu_put_dma_cookie);
> >
> > +/**
> > + *
> > + * iommu_dma_get_rmrs - Retrieve Reserved Memory Regions(RMRs)
> associated
> > + *                      with a given IOMMU
> > + * @iommu_fwnode: fwnode associated with IOMMU
> > + * @list: RMR list to be populated
> > + *
> > + */
> > +int iommu_dma_get_rmrs(struct fwnode_handle *iommu_fwnode,
> > +		       struct list_head *list)
> > +{
> > +	return -EINVAL;
> > +}
> > +EXPORT_SYMBOL(iommu_dma_get_rmrs);
> > +
> > +/**
> > + *
> > + * iommu_dma_put_rmrs - Release Reserved Memory Regions(RMRs)
> associated
> > + *                      with a given IOMMU
> > + * @iommu_fwnode: fwnode associated with IOMMU
> > + * @list: RMR list
> > + *
> > + */
> > +void iommu_dma_put_rmrs(struct fwnode_handle *iommu_fwnode,
> > +			struct list_head *list)
> > +{
> > +}
> > +EXPORT_SYMBOL(iommu_dma_put_rmrs);
> 
> Unless there's something special you expect to need to do here, can we
> just uphold the prevailing expectation that resv_regions are kmalloc()ed
> and can be freed directly by the generic function?

Right. I think we can do that. 

> 
> > +
> >   /**
> >    * iommu_dma_get_resv_regions - Reserved region driver helper
> >    * @dev: Device from iommu_get_resv_regions()
> > diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> > index 758ca4694257..3b7b2d096c6e 100644
> > --- a/include/linux/dma-iommu.h
> > +++ b/include/linux/dma-iommu.h
> > @@ -42,12 +42,16 @@ void iommu_dma_free_cpu_cached_iovas(unsigned
> int cpu,
> >
> >   extern bool iommu_dma_forcedac;
> >
> > +int iommu_dma_get_rmrs(struct fwnode_handle *iommu, struct list_head
> *list);
> > +void iommu_dma_put_rmrs(struct fwnode_handle *iommu, struct list_head
> *list);
> > +
> >   #else /* CONFIG_IOMMU_DMA */
> >
> >   struct iommu_domain;
> >   struct msi_desc;
> >   struct msi_msg;
> >   struct device;
> > +struct fwnode_handle;
> >
> >   static inline void iommu_setup_dma_ops(struct device *dev, u64
> dma_base,
> >   				       u64 dma_limit)
> > @@ -83,5 +87,14 @@ static inline void
> iommu_dma_get_resv_regions(struct device *dev, struct list_he
> >   {
> >   }
> >
> > +static int iommu_dma_get_rmrs(struct fwnode_handle *iommu, struct
> list_head *list)
> > +{
> > +	return -ENODEV;
> 
> Hmm, if this needs to be stubbed at all then returning an error seems
> like probably the wrong thing to do. I guess it's for 32-bit builds of
> arm-smmu? It is not an error if the firmware describes no RMRs because
> there are no RMRs, so it hardly deserves to be an error if there are no
> RMRs simply because the firmware isn't ACPI.

Yes, definitely not an error return. I will change that.

Thanks,
Shameer

> 
> Robin.
> 
> > +}
> > +
> > +static void iommu_dma_put_rmrs(struct fwnode_handle *iommu, struct
> list_head *list)
> > +{
> > +}
> > +
> >   #endif	/* CONFIG_IOMMU_DMA */
> >   #endif	/* __DMA_IOMMU_H */
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
