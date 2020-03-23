Return-Path: <SRS0=qkVD=5I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29012C3F2CD
	for <iommu@archiver.kernel.org>; Mon, 23 Mar 2020 17:54:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB71C20714
	for <iommu@archiver.kernel.org>; Mon, 23 Mar 2020 17:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MLXJz0dR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="ONB27yDh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB71C20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AEA7788300;
	Mon, 23 Mar 2020 17:54:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xk5IwuJ4gqWz; Mon, 23 Mar 2020 17:54:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5B82E882E4;
	Mon, 23 Mar 2020 17:54:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42FB5C1AE2;
	Mon, 23 Mar 2020 17:54:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B33E7C0177;
 Mon, 23 Mar 2020 17:25:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A08A48828F;
 Mon, 23 Mar 2020 17:25:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id toj7uBURyhn4; Mon, 23 Mar 2020 17:25:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7FF7986AE5;
 Mon, 23 Mar 2020 17:25:25 +0000 (UTC)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02NHFoX7017545; Mon, 23 Mar 2020 10:25:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=pwuuu9CspCvPWr8EzlZ0DotD/2crx2l0yQFJahSp6Bw=;
 b=MLXJz0dRXZnoSx0FLA8O60yXtOQ4OxcM470uNFynOpa54hXUoJvoFoBfXjsQW0mhxR0q
 is0IFrGkQfi9mSAIuQMwqPehNtN9uCftV25+/8mNsyBsS3uYZhUFeTru1s48yLmcZYBT
 wKLxqgybW/We6sMaTmgR8vu8Z2yykfJsINiLPtVTPQWQPeu1pX+M+/jHj3xMuhcNnsQd
 lB4836sNX3S7tFYaUR1OFXX+nOouFbZg2zJRyylU8SM7Kod5wMigyzkEzqRP6Nz+slaa
 OI6jiOkaYoSHGRz7J6ICgm6TVpM+/DBlwAoG9eL4BT7oGWmAlhWrL6rZAn7DOVoWwa2M pA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
 by mx0a-0016f401.pphosted.com with ESMTP id 2ywg9nfbax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2020 10:25:20 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 23 Mar
 2020 10:25:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 23 Mar 2020 10:25:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZUwFfm8yghlYMnV4LcDKZSzz8ZNlTTzmVOCLuozHsTOltu+COwDE9odGwSKChKeA3knGldWagwc8/SMdT3Gq1zcvfwqAteORk79+67O4wSo7QCTdhBGHzrzXC6OGgD9yPPtdscstVjWVpBTp2rSsR4+D9ODZkS4RFizWWa6dtYqL2+UDDK5BEi3svfqetfKljRMq+X/xpn5V4Ccy7UHtDKcATv5lXIEJo1GBxaBQBInSTsVDCLiwjTNyADL0Vmr6ZVNmX2cNqnpMjlKEkNywkIoeSc+qsSgLixqpjtFTiTsFjgHABRdUQ0xK7oDMhkP9ro5fAG/TMs7NtwUb09fiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwuuu9CspCvPWr8EzlZ0DotD/2crx2l0yQFJahSp6Bw=;
 b=FAihn4lIpBXYZoVGXk7Se3PPneyKeFupnWqVEPsfiKStgJGvxThHOkEImdMLm3QpsMmcqBkICw2XE97chI89WhWnhsPk9WLs+LQ0ztChEjYX1FCdIT39w8BSG5fo0EOztE/cEnBKlQpCd0yLqS9X/BuQjyiG5Jyp2/ehH2ZVUcjH2IZlSSR/0mNBenGKGkoSwSvraF9zOWp3NiYqsm0S+CxPfCfy6oujMExLiDnx8jh4o8xUZP+M3R1VR7H3JoCWikizmJYo1cNTvJ9aFm5mDWf6Ef/Dvj87p4+vqH1ZFaMeLztBEQPsGPgd5erNtMajeheIrMcCyoXn2EePCTSkwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwuuu9CspCvPWr8EzlZ0DotD/2crx2l0yQFJahSp6Bw=;
 b=ONB27yDh41k2SdYCjHEGrp0wStkxniO/rwdG1pfJLTEqGFdGurgfj06dz8xsUKtlJfLtq7ibLPcPhJptGt4skL0OxTYTbOGLFnGsXqIzd3jvV8f1g461PARaxMnY6raFUL8vfSw4zwNhlhNTfTdDERNPw4462v9IXfVElA2aDh8=
Received: from MWHPR1801MB1966.namprd18.prod.outlook.com
 (2603:10b6:301:66::20) by MWHSPR01MB348.namprd18.prod.outlook.com
 (2603:10b6:301:47::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Mon, 23 Mar
 2020 17:25:17 +0000
Received: from MWHPR1801MB1966.namprd18.prod.outlook.com
 ([fe80::b417:ff60:caba:11a1]) by MWHPR1801MB1966.namprd18.prod.outlook.com
 ([fe80::b417:ff60:caba:11a1%7]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 17:25:17 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: RE: [EXT] Re: [PATCH RFC] iommu/virtio: Use page size bitmap
 supported by endpoint
Thread-Topic: [EXT] Re: [PATCH RFC] iommu/virtio: Use page size bitmap
 supported by endpoint
Thread-Index: AQHWAO7SMAB4CeQ2NEaJipaUHJZ5FahV8a+AgAB7VSA=
Date: Mon, 23 Mar 2020 17:25:17 +0000
Message-ID: <MWHPR1801MB196689B3880CD9316942A2B8E3F00@MWHPR1801MB1966.namprd18.prod.outlook.com>
References: <20200323084108.1721-1-bbhushan2@marvell.com>
 <20200323095943.GA2038940@myrica>
In-Reply-To: <20200323095943.GA2038940@myrica>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [171.61.75.28]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20a3019a-68eb-47f6-3fb6-08d7cf4f27ec
x-ms-traffictypediagnostic: MWHSPR01MB348:
x-microsoft-antispam-prvs: <MWHSPR01MB3488A2F547B356F8B8FAB80E3F00@MWHSPR01MB348.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(199004)(186003)(26005)(6506007)(53546011)(478600001)(66476007)(5660300002)(66446008)(64756008)(66556008)(76116006)(52536014)(33656002)(66946007)(71200400001)(81156014)(8936002)(8676002)(81166006)(6916009)(2906002)(54906003)(86362001)(55016002)(316002)(4326008)(7696005)(9686003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHSPR01MB348;
 H:MWHPR1801MB1966.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: heBHXusgGr3zf9D44uX3Ury25HfPot2W9YVHByfRXioVkgp16XnEMtVVkNbc9LTa3OV/3xtlFA26s/H8GeX12H32yvNO1JMPXiFn+qikJTOrSC1j+TVCAlumT+0vTQn0+h913mdZmwKxFpFREn67R5tSzeBv96rUdhKZLrMUUNS37qky3sRolaDw3s+8/zYxYDfGgWO5zHnbwTNnOHAAyy6i5bkHF1Q+w0r0d2Qx8YFFlAxgmjo4nPUh2qLpIQikZ1Ba+ZeuE3apfDlASN81TsAvov2Xl9BPS39xs48SZBYzQz4pbmRfgFgLUeQm4w3svmxF2hfH80GQVXOPJQ3zpwlH1KLKMze8u7fvkNVTegBNlstaBT92EKyF8O2RereN8i8i1hzFoy9gOgywCJ2ZpzMzq2NU23Rr5PlpUKVDr/t2g2asxuYXShRPN/NteyWm
x-ms-exchange-antispam-messagedata: uEoZMag4fJmOd4NaWWHGXxlkgjtmpwoTLgihU+/4TJ6SvhMXuVvBfbFu2q1aSgTsu6Zy3K+LitxZ5VJ9/rS7vkd819Hne1HPnTACyGyDx/rHpAm3b1Sp5mbBK85oP8ocXbLx1Fb03i4/cSTc56tt0Q==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a3019a-68eb-47f6-3fb6-08d7cf4f27ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 17:25:17.3965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RULQJ15afCrQ/jsR40HGvR55JQ/x7Gx0l5BnrBeL3coc4xrXpv72wQY0eVCA/U/JiEbBh1AWUvffvOeQz/hlCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB348
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-23_07:2020-03-23,
 2020-03-23 signatures=0
X-Mailman-Approved-At: Mon, 23 Mar 2020 17:54:41 +0000
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

iommu@lists.linux-foundation.org is there, any other mailing list we need to add?

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

Will take care of all the comments in next verions

Thank
-Bharat

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
> nit: it could be nicer to initialize vdev->pgsize_bitmap in add_device(), override it
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
