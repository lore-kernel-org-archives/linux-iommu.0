Return-Path: <SRS0=EbOf=VF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10269C48BE7
	for <iommu@archiver.kernel.org>; Mon,  8 Jul 2019 07:19:28 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE85320665
	for <iommu@archiver.kernel.org>; Mon,  8 Jul 2019 07:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE85320665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8A0282183;
	Mon,  8 Jul 2019 07:19:27 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EB40D2182
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Jul 2019 07:11:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 19968196
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Jul 2019 07:11:00 +0000 (UTC)
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.108])
	by Forcepoint Email with ESMTP id 8199DD30215B82A241FA;
	Mon,  8 Jul 2019 08:10:58 +0100 (IST)
Received: from LHREML524-MBS.china.huawei.com ([169.254.2.154]) by
	lhreml701-cah.china.huawei.com ([10.201.108.42]) with mapi id
	14.03.0415.000; Mon, 8 Jul 2019 08:10:51 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>
Subject: RE: [PATCH v7 3/6] vfio/type1: Update iova list on detach
Thread-Topic: [PATCH v7 3/6] vfio/type1: Update iova list on detach
Thread-Index: AQHVLDHlzsp7WZ6o0k2WlwGboVZ1gKa/QQsAgAEeOtA=
Date: Mon, 8 Jul 2019 07:10:51 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83F2E19CB@lhreml524-mbs.china.huawei.com>
References: <20190626151248.11776-1-shameerali.kolothum.thodi@huawei.com>
	<20190626151248.11776-4-shameerali.kolothum.thodi@huawei.com>
	<3bab52b1-da0f-10fe-34e4-889c74e3caad@redhat.com>
In-Reply-To: <3bab52b1-da0f-10fe-34e4-889c74e3caad@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.206.221]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "kevin.tian@intel.com" <kevin.tian@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linuxarm <linuxarm@huawei.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"xuwei \(O\)" <xuwei5@huawei.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Eric,

> -----Original Message-----
> From: Auger Eric [mailto:eric.auger@redhat.com]
> Sent: 07 July 2019 16:03
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> alex.williamson@redhat.com; pmorel@linux.vnet.ibm.com
> Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> iommu@lists.linux-foundation.org; Linuxarm <linuxarm@huawei.com>; John
> Garry <john.garry@huawei.com>; xuwei (O) <xuwei5@huawei.com>;
> kevin.tian@intel.com
> Subject: Re: [PATCH v7 3/6] vfio/type1: Update iova list on detach
> 
> Hi Shameer,
> 
> On 6/26/19 5:12 PM, Shameer Kolothum wrote:
> > Get a copy of iova list on _group_detach and try to update the list.
> > On success replace the current one with the copy. Leave the list as
> > it is if update fails.
> >
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > ---
> >  drivers/vfio/vfio_iommu_type1.c | 91
> +++++++++++++++++++++++++++++++++
> >  1 file changed, 91 insertions(+)
> >
> > diff --git a/drivers/vfio/vfio_iommu_type1.c
> b/drivers/vfio/vfio_iommu_type1.c
> > index b6bfdfa16c33..e872fb3a0f39 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -1873,12 +1873,88 @@ static void vfio_sanity_check_pfn_list(struct
> vfio_iommu *iommu)
> >  	WARN_ON(iommu->notifier.head);
> >  }
> >
> > +/*
> > + * Called when a domain is removed in detach. It is possible that
> > + * the removed domain decided the iova aperture window. Modify the
> > + * iova aperture with the smallest window among existing domains.
> > + */
> > +static void vfio_iommu_aper_expand(struct vfio_iommu *iommu,
> > +				   struct list_head *iova_copy)
> Maybe you could just remove iova_copy for the args and return start,
> size. See comment below.
> > +{
> > +	struct vfio_domain *domain;
> > +	struct iommu_domain_geometry geo;
> > +	struct vfio_iova *node;
> > +	dma_addr_t start = 0;
> > +	dma_addr_t end = (dma_addr_t)~0;
> > +
> > +	list_for_each_entry(domain, &iommu->domain_list, next) {
> > +		iommu_domain_get_attr(domain->domain,
> DOMAIN_ATTR_GEOMETRY,
> > +				      &geo);
> > +		if (geo.aperture_start > start)
> > +			start = geo.aperture_start;
> > +		if (geo.aperture_end < end)
> > +			end = geo.aperture_end;
> > +	}
> > +
> > +	/* Modify aperture limits. The new aper is either same or bigger */
> > +	node = list_first_entry(iova_copy, struct vfio_iova, list);
> > +	node->start = start;
> > +	node = list_last_entry(iova_copy, struct vfio_iova, list);
> > +	node->end = end;
> > +}
> > +
> > +/*
> > + * Called when a group is detached. The reserved regions for that
> > + * group can be part of valid iova now. But since reserved regions
> > + * may be duplicated among groups, populate the iova valid regions
> > + * list again.
> > + */
> > +static int vfio_iommu_resv_refresh(struct vfio_iommu *iommu,
> > +				   struct list_head *iova_copy)
> > +{
> > +	struct vfio_domain *d;
> > +	struct vfio_group *g;
> > +	struct vfio_iova *node;
> > +	dma_addr_t start, end;
> > +	LIST_HEAD(resv_regions);
> > +	int ret;
> > +
> > +	list_for_each_entry(d, &iommu->domain_list, next) {
> > +		list_for_each_entry(g, &d->group_list, next)
> > +			iommu_get_group_resv_regions(g->iommu_group,
> > +						     &resv_regions);
> > +	}
> > +
> > +	if (list_empty(&resv_regions))
> > +		return 0;
> vfio_iommu_aper_expand() just extended the start/end of first & last
> node respectively.  In case the iova_copy() featured excluded resv
> regions before and now you don't have any anymore, the previous holes
> will stay if I don't miss anything?

Good catch!. Yes, I think there is a problem here.

> 
> You may unconditionally recompute start/end, free the copy,
> aper_resize() with new start/end and exclude resv regions again?

Ok. I will fix this in next revision.

Cheers,
Shameer
 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
