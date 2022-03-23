Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95869C433EF
	for <iommu@archiver.kernel.org>; Wed, 23 Mar 2022 15:55:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 43BC584A2E;
	Wed, 23 Mar 2022 15:55:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KoIx1ZlRyKD8; Wed, 23 Mar 2022 15:55:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 221DC84A30;
	Wed, 23 Mar 2022 15:55:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED5A4C001A;
	Wed, 23 Mar 2022 15:55:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B75E2C000B
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 15:55:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 94CC740C93
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 15:55:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qvlx8hSrafzh for <iommu@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 15:55:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E9469400FD
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 15:55:48 +0000 (UTC)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KNtDw4bpYzCr6Q;
 Wed, 23 Mar 2022 23:53:36 +0800 (CST)
Received: from dggpemm100002.china.huawei.com (7.185.36.179) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Mar 2022 23:55:43 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm100002.china.huawei.com (7.185.36.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Mar 2022 23:55:42 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.021; Wed, 23 Mar 2022 15:55:40 +0000
To: Robin Murphy <robin.murphy@arm.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v8 02/11] iommu: Introduce a union to struct
 iommu_resv_region
Thread-Topic: [PATCH v8 02/11] iommu: Introduce a union to struct
 iommu_resv_region
Thread-Index: AQHYJzn4JzDYsNDAv0udQS6OoRGEcqzL5oEAgAFnZ1A=
Date: Wed, 23 Mar 2022 15:55:40 +0000
Message-ID: <07bb59d690e84edfa62d7c844612b526@huawei.com>
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
 <20220221154344.2126-3-shameerali.kolothum.thodi@huawei.com>
 <5cf2c21b-6974-b2f9-140d-382985cf3095@arm.com>
In-Reply-To: <5cf2c21b-6974-b2f9-140d-382985cf3095@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.178]
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
From: Shameerali Kolothum Thodi via iommu <iommu@lists.linux-foundation.org>
Reply-To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy@arm.com]
> Sent: 22 March 2022 18:27
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> iommu@lists.linux-foundation.org
> Cc: Linuxarm <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com;
> joro@8bytes.org; will@kernel.org; wanghuiqiang
> <wanghuiqiang@huawei.com>; Guohanjun (Hanjun Guo)
> <guohanjun@huawei.com>; steven.price@arm.com; Sami.Mujawar@arm.com;
> jon@solid-run.com; eric.auger@redhat.com; yangyicong
> <yangyicong@huawei.com>
> Subject: Re: [PATCH v8 02/11] iommu: Introduce a union to struct
> iommu_resv_region
> 
> On 2022-02-21 15:43, Shameer Kolothum wrote:
> > A union is introduced to struct iommu_resv_region to hold
> > any firmware specific data. This is in preparation to add
> > support for IORT RMR reserve regions and the union now holds
> > the RMR specific information.
> >
> > Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi@huawei.com>
> > ---
> >   include/linux/iommu.h | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> >
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index de0c57a567c8..b06952a75f95 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -126,6 +126,11 @@ enum iommu_resv_type {
> >   	IOMMU_RESV_SW_MSI,
> >   };
> >
> > +struct iommu_iort_rmr_data {
> > +	u32 *sids;	/* Stream Ids associated with IORT RMR entry */
> 
> Please make this const.
> 
> Further nit: capitalisation of "IDs" in the comment, otherwise I might
> worry about the possibility of Stream Egos too :P

True :). Will do that.

Thanks,
Shameer 

> 
> > +	u32 num_sids;
> > +};
> > +
> >   /**
> >    * struct iommu_resv_region - descriptor for a reserved memory region
> >    * @list: Linked list pointers
> > @@ -133,6 +138,7 @@ enum iommu_resv_type {
> >    * @length: Length of the region in bytes
> >    * @prot: IOMMU Protection flags (READ/WRITE/...)
> >    * @type: Type of the reserved region
> > + * @fw_data: FW specific reserved region data
> 
> Nit: we've got plenty of room to spell out "Firmware-specific", and it
> never hurts to make documentation as easy to read as possible.
> 
> Thanks,
> Robin.
> 
> >    */
> >   struct iommu_resv_region {
> >   	struct list_head	list;
> > @@ -140,6 +146,9 @@ struct iommu_resv_region {
> >   	size_t			length;
> >   	int			prot;
> >   	enum iommu_resv_type	type;
> > +	union {
> > +		struct iommu_iort_rmr_data rmr;
> > +	} fw_data;
> >   };
> >
> >   /**
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
