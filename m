Return-Path: <SRS0=EbOf=VF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0460AC48BE7
	for <iommu@archiver.kernel.org>; Mon,  8 Jul 2019 07:05:02 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3CB920844
	for <iommu@archiver.kernel.org>; Mon,  8 Jul 2019 07:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CB920844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 761CE217C;
	Mon,  8 Jul 2019 07:05:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8031A2151
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Jul 2019 06:59:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B0473827
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Jul 2019 06:59:51 +0000 (UTC)
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.108])
	by Forcepoint Email with ESMTP id 2CD05F0471F05A2FC7B9;
	Mon,  8 Jul 2019 07:59:49 +0100 (IST)
Received: from LHREML524-MBS.china.huawei.com ([169.254.2.154]) by
	lhreml703-cah.china.huawei.com ([10.201.108.44]) with mapi id
	14.03.0415.000; Mon, 8 Jul 2019 07:59:40 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Auger Eric <eric.auger@redhat.com>, Alex Williamson
	<alex.williamson@redhat.com>
Subject: RE: [PATCH v7 2/6] vfio/type1: Check reserve region conflict and
	update iova list
Thread-Topic: [PATCH v7 2/6] vfio/type1: Check reserve region conflict and
	update iova list
Thread-Index: AQHVLDHlfv32Tq6P8k2BSud+nbtQFqa5VEOAgAEf3kCAAXe2AIAEcOwg
Date: Mon, 8 Jul 2019 06:59:39 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83F2E198C@lhreml524-mbs.china.huawei.com>
References: <20190626151248.11776-1-shameerali.kolothum.thodi@huawei.com>
	<20190626151248.11776-3-shameerali.kolothum.thodi@huawei.com>
	<20190703143427.2d63c15f@x1.home>
	<5FC3163CFD30C246ABAA99954A238FA83F2DDB68@lhreml524-mbs.china.huawei.com>
	<d70c59ec-e837-7697-acb1-c2b5027570ee@redhat.com>
In-Reply-To: <d70c59ec-e837-7697-acb1-c2b5027570ee@redhat.com>
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

Hi Eric

> -----Original Message-----
> From: Auger Eric [mailto:eric.auger@redhat.com]
> Sent: 05 July 2019 13:10
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> Alex Williamson <alex.williamson@redhat.com>
> Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> iommu@lists.linux-foundation.org; Linuxarm <linuxarm@huawei.com>; John
> Garry <john.garry@huawei.com>; xuwei (O) <xuwei5@huawei.com>;
> kevin.tian@intel.com
> Subject: Re: [PATCH v7 2/6] vfio/type1: Check reserve region conflict and
> update iova list
> 
> Hi Shameer,
> 
> On 7/4/19 2:51 PM, Shameerali Kolothum Thodi wrote:
> >
> >
> >> -----Original Message-----
> >> From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org] On
> >> Behalf Of Alex Williamson
> >> Sent: 03 July 2019 21:34
> >> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> >> Cc: eric.auger@redhat.com; pmorel@linux.vnet.ibm.com;
> >> kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> >> iommu@lists.linux-foundation.org; Linuxarm <linuxarm@huawei.com>;
> John
> >> Garry <john.garry@huawei.com>; xuwei (O) <xuwei5@huawei.com>;
> >> kevin.tian@intel.com
> >> Subject: Re: [PATCH v7 2/6] vfio/type1: Check reserve region conflict and
> >> update iova list
> >>
> >> On Wed, 26 Jun 2019 16:12:44 +0100
> >> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
> >>
> >>> This retrieves the reserved regions associated with dev group and
> >>> checks for conflicts with any existing dma mappings. Also update
> >>> the iova list excluding the reserved regions.
> >>>
> >>> Reserved regions with type IOMMU_RESV_DIRECT_RELAXABLE are
> >>> excluded from above checks as they are considered as directly
> >>> mapped regions which are known to be relaxable.
> >>>
> >>> Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi@huawei.com>
> >>> ---
> >>>  drivers/vfio/vfio_iommu_type1.c | 96
> >> +++++++++++++++++++++++++++++++++
> >>>  1 file changed, 96 insertions(+)
> >>>
> >>> diff --git a/drivers/vfio/vfio_iommu_type1.c
> >> b/drivers/vfio/vfio_iommu_type1.c
> >>> index 970d1ec06aed..b6bfdfa16c33 100644
> >>> --- a/drivers/vfio/vfio_iommu_type1.c
> >>> +++ b/drivers/vfio/vfio_iommu_type1.c
> >>> @@ -1559,6 +1641,7 @@ static int vfio_iommu_type1_attach_group(void
> >> *iommu_data,
> >>>  	phys_addr_t resv_msi_base;
> >>>  	struct iommu_domain_geometry geo;
> >>>  	LIST_HEAD(iova_copy);
> >>> +	LIST_HEAD(group_resv_regions);
> >>>
> >>>  	mutex_lock(&iommu->lock);
> >>>
> >>> @@ -1644,6 +1727,13 @@ static int
> vfio_iommu_type1_attach_group(void
> >> *iommu_data,
> >>>  		goto out_detach;
> >>>  	}
> >>>
> >>> +	iommu_get_group_resv_regions(iommu_group,
> &group_resv_regions);
> >>
> >> This can fail and should have an error case.  I assume we'd fail the
> >> group attach on failure.  Thanks,
> >
> > Right. I will add the check. Do you think we should do the same in
> vfio_iommu_has_sw_msi()
> > as well? (In fact, it looks like iommu_get_group_resv_regions() ret is not
> checked anywhere in
> > kernel).
> 
> I think the can be the topic of another series. I just noticed that in
> iommu_insert_resv_region(), which is recursive in case ot merge, I
> failed to propagate returned value or recursive calls. This also needs
> to be fixed. I volunteer to work on those changes if you prefer. Just
> let me know.

Ok. Please go ahead.

Thanks,
Shameer

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
