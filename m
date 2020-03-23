Return-Path: <SRS0=qkVD=5I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E915FC3F2CD
	for <iommu@archiver.kernel.org>; Mon, 23 Mar 2020 18:04:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B86FA2072D
	for <iommu@archiver.kernel.org>; Mon, 23 Mar 2020 18:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="pz12D+RJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="JF+mjSQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86FA2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9046F88415;
	Mon, 23 Mar 2020 18:04:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id upG+nlicN8dd; Mon, 23 Mar 2020 18:04:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C0C1F8816A;
	Mon, 23 Mar 2020 18:04:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1920C1AE2;
	Mon, 23 Mar 2020 18:04:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2AAC8C0177;
 Mon, 23 Mar 2020 18:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 174A822FF0;
 Mon, 23 Mar 2020 18:04:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MfkDEJcRP9jC; Mon, 23 Mar 2020 18:04:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by silver.osuosl.org (Postfix) with ESMTPS id 9AA0422816;
 Mon, 23 Mar 2020 18:04:47 +0000 (UTC)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02NHkKt0017533; Mon, 23 Mar 2020 11:04:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=EaG68GoTrZ86bclKpEnDp/ZK0WfTbWwutFJOLNpNWSg=;
 b=pz12D+RJgsQKy9jDv7hSghQKRF2M75K5nQaxOFXf71X1c4AkfS9q6AJSn3zZIASNliDA
 kM5nO8CgFF4N2E909+8rsDUbme8Kktfp8QbURzmXxvj4nw2ac/8ub41oVPdhZL92HYcO
 gsCoH+v8OLzIbu77m+PTbssgOOeqlr5X+r+cfry7JGglzEp/yNzoaCSDMESLyZDeeWfb
 xTIEtSOd4ttByAGC4G8dgECtKXe2pQqK8wDbcbNoacXUKGhm2j4Zrryq89nx4AoQSM5C
 vXTQI1v9GIhrJxJ1O2+zD2MLhFP8TCJv67XeKZYHmZTfOrp1t8xNx+BHgTnxP80hwu8d ow== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
 by mx0a-0016f401.pphosted.com with ESMTP id 2ywg9nffsd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2020 11:04:43 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 23 Mar 2020 11:04:42 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 23 Mar 2020 11:04:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 23 Mar 2020 11:04:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFIoivra6YRD6yGpyQM+RB+e8A7t90iN2clTfHukaK3tT9hXvj/DD+OUJeRmQI39ppnrJ++K7+4Q3LkwxZpg0EU8wdbGtJzkDSUoGoKtJrR3P4OgylTh/fQH8Po+X3WAH2lmA9M7hLyp2lOVjMFI9lhY5nJyVTrKxSjWrwnEu+wBoTHNTdlEI01x7NjxsGEF5IlJ79Ie/3Cmq0H5Iv1dwZTjW8ojdaRYDQJjoQG2fjfefVzdKqLvCvNiVb9jII3fnpmd4Y1zND38CpDCg2VHeXSJUlCgfOJ/xtqr1p3lRg+powgR7rL/ZKYQmXT4KK08C0esi83DzTK+czCQcROxQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaG68GoTrZ86bclKpEnDp/ZK0WfTbWwutFJOLNpNWSg=;
 b=l0EmNbNFLsq6tnQOA0q6bAg0qvwH063ojjAmFuingMPQvjKjmqkl70Btl9OhyL79IQre2n7sgGXDnIlcpJL6QYWgNyzkojH3XlO3mUD/JkiVCinQNFsNopPHvig3y7S6MMSDS71SNRC3fCYW++Wx2F7q5R7GHQsssq35jxkF4qx/XPqhxN+H6K5bNJEHVMGHn7FqwykGcDdAeDUllvKzmxJrrEvohUacVBWHSLGEvJ7TtiZWjhg9mAo7K29ru/lIdHkT7gCgwl1edfKSfKv4BzqaCLb9qxsXVQKO0XJRR/V8pdPB82i7pBC+ksGLVsaytcaRMITdGLM4b4ExC3rOzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaG68GoTrZ86bclKpEnDp/ZK0WfTbWwutFJOLNpNWSg=;
 b=JF+mjSQS39by0Nj9iyQ7LNU8z/guKbeaDJlR2YHdodzrsgMK9U8PTNv3MA10K5k5i1bnzO4ASHrrI9y4pANCWlnyHtL9OkTkjMtBntJI3YCWKm+tmBk9EIdUs4lr/mUmI9cUjdH7avwABdcBP0sJXOxQri59f6xVAfHN3fzqUmI=
Received: from MWHPR1801MB1966.namprd18.prod.outlook.com
 (2603:10b6:301:66::20) by MWHPR1801MB1982.namprd18.prod.outlook.com
 (2603:10b6:301:6a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Mon, 23 Mar
 2020 18:04:38 +0000
Received: from MWHPR1801MB1966.namprd18.prod.outlook.com
 ([fe80::b417:ff60:caba:11a1]) by MWHPR1801MB1966.namprd18.prod.outlook.com
 ([fe80::b417:ff60:caba:11a1%7]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 18:04:37 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: RE: [EXT] Re: [PATCH RFC] iommu/virtio: Use page size bitmap
 supported by endpoint
Thread-Topic: [EXT] Re: [PATCH RFC] iommu/virtio: Use page size bitmap
 supported by endpoint
Thread-Index: AQHWAO7SMAB4CeQ2NEaJipaUHJZ5FahV8a+AgACHMYA=
Date: Mon, 23 Mar 2020 18:04:37 +0000
Message-ID: <MWHPR1801MB1966865A8DE5AB8FFFAEC85FE3F00@MWHPR1801MB1966.namprd18.prod.outlook.com>
References: <20200323084108.1721-1-bbhushan2@marvell.com>
 <20200323095943.GA2038940@myrica>
In-Reply-To: <20200323095943.GA2038940@myrica>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [171.61.75.28]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfb23737-0dc3-4874-9bb4-08d7cf54a6cd
x-ms-traffictypediagnostic: MWHPR1801MB1982:
x-microsoft-antispam-prvs: <MWHPR1801MB1982BFAB767A5031D64479BAE3F00@MWHPR1801MB1982.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(199004)(81166006)(76116006)(478600001)(81156014)(4326008)(316002)(2906002)(5660300002)(7696005)(8676002)(8936002)(66946007)(6506007)(53546011)(52536014)(66446008)(66556008)(86362001)(66476007)(64756008)(9686003)(71200400001)(55016002)(186003)(33656002)(26005)(54906003)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR1801MB1982;
 H:MWHPR1801MB1966.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e21Jck94Ob1luJCqTVuFnX5EKeEsoDMtKZwn+PqKS6rPCtyjlx/ktDY2PThCBbeF0GkutawDwOV+mCK6Mf+ON2qIx/LNzpPzGLeJxYmum7niJjB/SnEGEwwa+31nTd7300TEeRfN1a/NWWBAXFbCq7kcc5/ZXKGQMtlb6BALBTFq/2wj7/FHDYwdgZmRIoQYHf8X7OGROb3NAXj/ppZuX4lh0XeY7PoJ06t8x3Vu61PbdZKlJUCwNxbgOekUu8zGRHYWCrITgX4XpN6BsqtwmyWSTosF+Gcz4t3hPxdPiUUEqcWHKhNA3d2iYIdoaU/27XG1chUu75KEgQM5tPMm47X04pkFpyjyJ0kfwo/wpY1ipZXn+K6I10a0FEE83ZN3pDRVnvGAEhg1i16bth31olLZ+/u5Fpdpmo6YUFOx0DtlsIIVH+imi7I18DrQDPri
x-ms-exchange-antispam-messagedata: OrXf72ybyTVXItNCndc08cKYLU7dHA4Y3b+zQydRoT2ZNZ/mfi2Z2B+fTILtrKXytDeWNcdjfhyDkKf8rrG9j8QvrW7yeBn2B5skch+J0rgddzQWBj/RiY1PpzJKxz976CRZ6IWtktzuMizRwNNJxw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb23737-0dc3-4874-9bb4-08d7cf54a6cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 18:04:37.6660 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fg6GcSYxuC+gSDSBEfFDOYMXEILA6caVMoN7eMjlYrJP1opXoxQgNTgofuwS8bDFHePKlWnrPFEOrLUiWpqHlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1801MB1982
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-23_07:2020-03-23,
 2020-03-23 signatures=0
Cc: "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>
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

Hi Jean,

> -----Original Message-----
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Sent: Monday, March 23, 2020 3:30 PM
> To: Bharat Bhushan <bbhushan2@marvell.com>
> Cc: joro@8bytes.org; mst@redhat.com; jasowang@redhat.com;
> virtualization@lists.linux-foundation.org; iommu@lists.linux-foundation.org;
> eric.auger@redhat.com
> Subject: [EXT] Re: [PATCH RFC] iommu/virtio: Use page size bitmap supported by
> endpoint
> 
> External Email
> 
> ----------------------------------------------------------------------
> Hi Bharat,
> 
> Please add the IOMMU list on your next posting
> 
> On Mon, Mar 23, 2020 at 02:11:08PM +0530, Bharat Bhushan wrote:
> > Different endpoint can support different page size, probe endpoint if
> > it supports specific page size otherwise use global page sizes.
> >
> > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > ---
> >  drivers/iommu/virtio-iommu.c      | 24 ++++++++++++++++++++----
> >  include/uapi/linux/virtio_iommu.h |  6 ++++++
> >  2 files changed, 26 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iommu/virtio-iommu.c
> > b/drivers/iommu/virtio-iommu.c index cce329d71fba..e69347ca4ee6 100644
> > --- a/drivers/iommu/virtio-iommu.c
> > +++ b/drivers/iommu/virtio-iommu.c
> > @@ -78,6 +78,7 @@ struct viommu_endpoint {
> >  	struct viommu_dev		*viommu;
> >  	struct viommu_domain		*vdomain;
> >  	struct list_head		resv_regions;
> > +	u64				pgsize_bitmap;
> >  };
> >
> >  struct viommu_request {
> > @@ -415,6 +416,14 @@ static int viommu_replay_mappings(struct
> viommu_domain *vdomain)
> >  	return ret;
> >  }
> >
> > +static int viommu_set_pgsize_bitmap(struct viommu_endpoint *vdev,
> > +				    struct virtio_iommu_probe_pgsize_mask *mask)
> > +
> > +{
> > +	vdev->pgsize_bitmap = mask->pgsize_bitmap;
> 
> We need to read this through le64_to_cpu(). Also check that the length of the field
> provided by the device is >= sizeof(mask) (like
> viommu_add_resv_mem() does)
> 
> > +	return 0;
> > +}
> > +
> >  static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
> >  			       struct virtio_iommu_probe_resv_mem *mem,
> >  			       size_t len)
> > @@ -494,11 +503,13 @@ static int viommu_probe_endpoint(struct viommu_dev
> *viommu, struct device *dev)
> >  	while (type != VIRTIO_IOMMU_PROBE_T_NONE &&
> >  	       cur < viommu->probe_size) {
> >  		len = le16_to_cpu(prop->length) + sizeof(*prop);
> > -
> >  		switch (type) {
> >  		case VIRTIO_IOMMU_PROBE_T_RESV_MEM:
> >  			ret = viommu_add_resv_mem(vdev, (void *)prop, len);
> >  			break;
> > +		case VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK:
> > +			ret = viommu_set_pgsize_bitmap(vdev, (void *)prop);
> > +			break;
> >  		default:
> >  			dev_err(dev, "unknown viommu prop 0x%x\n", type);
> >  		}
> > @@ -607,16 +618,21 @@ static struct iommu_domain
> *viommu_domain_alloc(unsigned type)
> >  	return &vdomain->domain;
> >  }
> >
> > -static int viommu_domain_finalise(struct viommu_dev *viommu,
> > +static int viommu_domain_finalise(struct viommu_endpoint *vdev,
> >  				  struct iommu_domain *domain)
> >  {
> >  	int ret;
> >  	struct viommu_domain *vdomain = to_viommu_domain(domain);
> > +	struct viommu_dev *viommu = vdev->viommu;
> >
> >  	vdomain->viommu		= viommu;
> >  	vdomain->map_flags	= viommu->map_flags;
> >
> > -	domain->pgsize_bitmap	= viommu->pgsize_bitmap;
> > +	if (vdev->pgsize_bitmap)
> > +		domain->pgsize_bitmap = vdev->pgsize_bitmap;
> > +	else
> > +		domain->pgsize_bitmap	= viommu->pgsize_bitmap;
> > +
> 
> nit: it could be nicer to initialize vdev->pgsize_bitmap in add_device(),

To what size we should initialize in add_device, PAGE_SIZE?

Thanks
-Bharat

> override it
> in probe_endpoint(), and just copy it here.
> 
> >  	domain->geometry	= viommu->geometry;
> >
> >  	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain, @@
> > -657,7 +673,7 @@ static int viommu_attach_dev(struct iommu_domain
> *domain, struct device *dev)
> >  		 * Properly initialize the domain now that we know which viommu
> >  		 * owns it.
> >  		 */
> > -		ret = viommu_domain_finalise(vdev->viommu, domain);
> > +		ret = viommu_domain_finalise(vdev, domain);
> 
> Attaching additional endpoints with different masks to the domain should return
> an error
> 
> >  	} else if (vdomain->viommu != vdev->viommu) {
> >  		dev_err(dev, "cannot attach to foreign vIOMMU\n");
> >  		ret = -EXDEV;
> > diff --git a/include/uapi/linux/virtio_iommu.h
> > b/include/uapi/linux/virtio_iommu.h
> > index 237e36a280cb..aff3db0ef54b 100644
> > --- a/include/uapi/linux/virtio_iommu.h
> > +++ b/include/uapi/linux/virtio_iommu.h
> > @@ -111,6 +111,7 @@ struct virtio_iommu_req_unmap {
> >
> >  #define VIRTIO_IOMMU_PROBE_T_NONE		0
> >  #define VIRTIO_IOMMU_PROBE_T_RESV_MEM		1
> > +#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK	2
> >
> >  #define VIRTIO_IOMMU_PROBE_T_MASK		0xfff
> >
> > @@ -119,6 +120,11 @@ struct virtio_iommu_probe_property {
> >  	__le16					length;
> >  };
> >
> > +struct virtio_iommu_probe_pgsize_mask {
> > +	struct virtio_iommu_probe_property	head;
> 
> Compilers will introduce 4 bytes of padding here, to align the next field.
> We need to make them explicit by adding a 4-bytes 'reserved' field.
> 
> > +	uint64_t				pgsize_bitmap;
> 
> __le64
> 
> Thanks,
> Jean
> 
> > +};
> > +
> >  #define VIRTIO_IOMMU_RESV_MEM_T_RESERVED	0
> >  #define VIRTIO_IOMMU_RESV_MEM_T_MSI		1
> >
> > --
> > 2.17.1
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
