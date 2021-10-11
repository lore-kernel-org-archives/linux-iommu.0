Return-Path: <SRS0=5Hhm=O7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083C5C433F5
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 05:47:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F6860F57
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 05:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A2F6860F57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6808C606E9;
	Mon, 11 Oct 2021 05:47:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XRr7fg4MtseW; Mon, 11 Oct 2021 05:47:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 22E33605FD;
	Mon, 11 Oct 2021 05:47:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04D75C0011;
	Mon, 11 Oct 2021 05:47:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1E6DC000D
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 05:47:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C2909606E9
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 05:47:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Odpzbc-jSvwI for <iommu@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 05:47:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 37FEB605FD
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 05:47:31 +0000 (UTC)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HSSPd6HWWzbn0Z;
 Mon, 11 Oct 2021 13:43:01 +0800 (CST)
Received: from dggema774-chm.china.huawei.com (10.1.198.216) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 13:47:28 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggema774-chm.china.huawei.com (10.1.198.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Mon, 11 Oct 2021 13:47:26 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.008; Mon, 11 Oct 2021 06:47:24 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Jon Nettleton <jon@solid-run.com>, Robin Murphy <robin.murphy@arm.com>
Subject: RE: [PATCH v7 1/9] iommu: Introduce a union to struct
 iommu_resv_region
Thread-Topic: [PATCH v7 1/9] iommu: Introduce a union to struct
 iommu_resv_region
Thread-Index: AQHXidEdw4nQ2pDnVEWq+ST9RUOUTKvJV6SAgAE56YCAAyElcA==
Date: Mon, 11 Oct 2021 05:47:24 +0000
Message-ID: <9df40b8f09f6488382f25f419519a2fa@huawei.com>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-2-shameerali.kolothum.thodi@huawei.com>
 <a1eddd80-4a26-4809-e681-f338d9998a24@arm.com>
 <CABdtJHtB7apg809UkrmDHQvtL012FqA_0+4_pL9NVD-mVm42YA@mail.gmail.com>
In-Reply-To: <CABdtJHtB7apg809UkrmDHQvtL012FqA_0+4_pL9NVD-mVm42YA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.25.32]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: Linuxarm <linuxarm@huawei.com>, Steven
 Price <steven.price@arm.com>, ACPI Devel
 Maling List <linux-acpi@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 wanghuiqiang <wanghuiqiang@huawei.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 yangyicong <yangyicong@huawei.com>, Sami Mujawar <Sami.Mujawar@arm.com>,
 Will Deacon <will@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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
> Sent: 09 October 2021 07:58
> To: Robin Murphy <robin.murphy@arm.com>
> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> linux-arm-kernel <linux-arm-kernel@lists.infradead.org>; ACPI Devel Maling
> List <linux-acpi@vger.kernel.org>; Linux IOMMU
> <iommu@lists.linux-foundation.org>; Linuxarm <linuxarm@huawei.com>;
> Steven Price <steven.price@arm.com>; Guohanjun (Hanjun Guo)
> <guohanjun@huawei.com>; yangyicong <yangyicong@huawei.com>; Sami
> Mujawar <Sami.Mujawar@arm.com>; Will Deacon <will@kernel.org>;
> wanghuiqiang <wanghuiqiang@huawei.com>
> Subject: Re: [PATCH v7 1/9] iommu: Introduce a union to struct
> iommu_resv_region
> 
> On Fri, Oct 8, 2021 at 2:14 PM Robin Murphy <robin.murphy@arm.com>
> wrote:
> >
> > On 2021-08-05 09:07, Shameer Kolothum wrote:
> > > A union is introduced to struct iommu_resv_region to hold any
> > > firmware specific data. This is in preparation to add support for
> > > IORT RMR reserve regions and the union now holds the RMR specific
> > > information.
> > >
> > > Signed-off-by: Shameer Kolothum
> > > <shameerali.kolothum.thodi@huawei.com>
> > > ---
> > >   include/linux/iommu.h | 11 +++++++++++
> > >   1 file changed, 11 insertions(+)
> > >
> > > diff --git a/include/linux/iommu.h b/include/linux/iommu.h index
> > > 32d448050bf7..bd0e4641c569 100644
> > > --- a/include/linux/iommu.h
> > > +++ b/include/linux/iommu.h
> > > @@ -114,6 +114,13 @@ enum iommu_resv_type {
> > >       IOMMU_RESV_SW_MSI,
> > >   };
> > >
> > > +struct iommu_iort_rmr_data {
> > > +#define IOMMU_RMR_REMAP_PERMITTED    (1 << 0)
> > > +     u32 flags;
> > > +     u32 sid;        /* Stream Id associated with RMR entry */
> > > +     void *smmu;     /* Associated IORT SMMU node pointer */
> > > +};
> >
> > Do we really need to duplicate all this data? AFAICS we could just
> > save the acpi_iort_rmr pointer in the iommu_resv_region (with a
> > forward declaration here if necessary) and defer parsing its actual
> > mappings until the point where we can directly consume the results.
> 
> From earlier discussions on this patchset, the original goal was also for
> device-tree mechanisms to be able to hook into this code to support similar
> RMR's and SMMU initialization, just not through the ACPI / IORT path.

Yes. IIRC, there were some earlier attempts to have DT support for reserved regions
and there was a suggestion to provide generic interfaces so that when DT solution
comes up it is easier to add the support.

Thanks,
Shameer

> >
> > Robin.
> >
> > > +
> > >   /**
> > >    * struct iommu_resv_region - descriptor for a reserved memory region
> > >    * @list: Linked list pointers
> > > @@ -121,6 +128,7 @@ enum iommu_resv_type {
> > >    * @length: Length of the region in bytes
> > >    * @prot: IOMMU Protection flags (READ/WRITE/...)
> > >    * @type: Type of the reserved region
> > > + * @rmr: ACPI IORT RMR specific data
> > >    */
> > >   struct iommu_resv_region {
> > >       struct list_head        list;
> > > @@ -128,6 +136,9 @@ struct iommu_resv_region {
> > >       size_t                  length;
> > >       int                     prot;
> > >       enum iommu_resv_type    type;
> > > +     union {
> > > +             struct iommu_iort_rmr_data rmr;
> > > +     } fw_data;
> > >   };
> > >
> > >   /**
> > >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
