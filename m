Return-Path: <SRS0=HkIk=5M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60E2C43331
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 05:49:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97C4220663
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 05:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ukRjXpau";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="uFbVl2kC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C4220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 505B588607;
	Fri, 27 Mar 2020 05:49:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NYjNM1cJLzVD; Fri, 27 Mar 2020 05:49:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E0E2D88353;
	Fri, 27 Mar 2020 05:49:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A456AC18DA;
	Fri, 27 Mar 2020 05:49:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F947C0177;
 Fri, 27 Mar 2020 05:49:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 14F9289559;
 Fri, 27 Mar 2020 05:49:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p52ixWXiBv7a; Fri, 27 Mar 2020 05:49:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 09A5389539;
 Fri, 27 Mar 2020 05:49:02 +0000 (UTC)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02R5jEVi032430; Thu, 26 Mar 2020 22:48:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=gvpJQwbmPmKcfhKE1samdoxht4e5cQn4s8yXz/XoxvE=;
 b=ukRjXpauaW48LMaKPiWCX6AanVGLEJGB6694Tt3SC/v8zfaTWKUR+HDYrZxnn6fib9bP
 5/ltenSztAs+ZDvCtffFBP3LEX6xYVa0mqeuHXc5uR8rrBErDvTWXHaaVQAznSGWmA6H
 JQxDw6dQXxW/OhH5f1r8PzKPeKHimmE8zrcbsfTgr7+82PmnkQvM9SeWxRtYYx4NbnAS
 e9NxTXCJU1eVNsJl62haOAGKt3ybsMpRhb10InZSRfqGhXAE5N8QXx0+x67OhZAUDNj0
 0eUwlIixWkUMaQEfE548PorOLByK6nO7XxPbAOc30veVWISeZOI+afpE6OcW/4ozLj2K tA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
 by mx0b-0016f401.pphosted.com with ESMTP id 300bpcyqp1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2020 22:48:58 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 26 Mar 2020 22:48:56 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 26 Mar 2020 22:48:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 26 Mar 2020 22:48:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLpWHpjrjB6RXecyafoRnb5PjLGdML16MjNkn7zV1HMJbTJn9Mv1ENM3Ugwk8u7joQHGgEsKKjEhMVNB74rTbwPAMRWl2Te7U57hbxMROgZPiWHK9PUVo356dIUFVFTceELFQ07j1H5oZ6SCc77TA+2qTB00IPZuUp9b6CexKxLuRchFsrRcpkLK+3OvafEdJR1W7FlfMgHzPdQWv408Eu0yDGZQ3p3lQp94VQdQyYpcpcai8PdTVPuwcPvq8jjYj9jWTvGghSeL/Tz1LaRtZcp2h8eRNjotxA4itrezLIX5XI1F4zydSVs9GIkUC6lnC0y2zV6oHrkjcYQ2f/+yug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvpJQwbmPmKcfhKE1samdoxht4e5cQn4s8yXz/XoxvE=;
 b=og1z8qtkBgP4/h+GIptQD+xeesI51dnnrT9ULmyxeL7DT8R0xIu3/2XhqquBz1gqNUKgEgYqNI9HJxlYkhe/aIShl9OPGIzwUPs7gF9isdiARjghIYn879PjUnQ/JL3/oQGgG4ehUEDeCaUEukq7U6KeEUkqw0xB3w7EUFduproBGiKbNKFHQv3s47mBr2G+RHo6uxuahhnX+dtWjUVtTPJ9N9rEUhuSXQHH9jqodNmzb/QdEqAv4olPfIxfEOaKdH9XrePPFnnAQcXomfzcDel1II/g9vxxsazuR26VXt+W9wZeb19Hd9HGsq7W/iMeZm1Y2DdaIQ7adaHNWDttiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvpJQwbmPmKcfhKE1samdoxht4e5cQn4s8yXz/XoxvE=;
 b=uFbVl2kCPgbWGsT/dNHQdN8X/ZB0g97UuulX7mAYjzcwmMHqS4rC32JmBIrLSrTxC7P6976CLCL4AIGcy0frpwKg7ZWKdklBZtfJDfC8cf3vvo/5UWWezAkg+MXJGvwhUVjesaAURvVFlfXP6HZy9cVLHM4WJq9KHVVE8ZAFpKk=
Received: from MWHPR1801MB1966.namprd18.prod.outlook.com
 (2603:10b6:301:66::20) by MWHPR1801MB2029.namprd18.prod.outlook.com
 (2603:10b6:301:63::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Fri, 27 Mar
 2020 05:48:53 +0000
Received: from MWHPR1801MB1966.namprd18.prod.outlook.com
 ([fe80::b417:ff60:caba:11a1]) by MWHPR1801MB1966.namprd18.prod.outlook.com
 ([fe80::b417:ff60:caba:11a1%7]) with mapi id 15.20.2856.019; Fri, 27 Mar 2020
 05:48:53 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: Auger Eric <eric.auger@redhat.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [EXT] Re: [PATCH v2 3/3] iommu/virtio: Reject IOMMU page granule
 larger than PAGE_SIZE
Thread-Topic: [EXT] Re: [PATCH v2 3/3] iommu/virtio: Reject IOMMU page granule
 larger than PAGE_SIZE
Thread-Index: AQHWA5XO+2nsdB0stUCaFxCNOMUFZqhb7w+A
Date: Fri, 27 Mar 2020 05:48:52 +0000
Message-ID: <MWHPR1801MB19666FB2B5F81924E565FA89E3CC0@MWHPR1801MB1966.namprd18.prod.outlook.com>
References: <20200326093558.2641019-1-jean-philippe@linaro.org>
 <20200326093558.2641019-4-jean-philippe@linaro.org>
 <04ed8a3e-5602-1a5f-1fa3-ac517fede0b1@redhat.com>
In-Reply-To: <04ed8a3e-5602-1a5f-1fa3-ac517fede0b1@redhat.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.182.231.48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f77e97ef-8816-4e5b-5a1a-08d7d212881a
x-ms-traffictypediagnostic: MWHPR1801MB2029:
x-microsoft-antispam-prvs: <MWHPR1801MB20293D51AACB56883604C4A1E3CC0@MWHPR1801MB2029.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(66476007)(81156014)(5660300002)(81166006)(66946007)(66556008)(478600001)(8936002)(71200400001)(66446008)(6506007)(2906002)(64756008)(33656002)(7696005)(53546011)(52536014)(76116006)(4326008)(186003)(26005)(86362001)(54906003)(8676002)(316002)(9686003)(110136005)(55016002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR1801MB2029;
 H:MWHPR1801MB1966.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fkZe21LSquN34srnWQehGo7fbck98XCHS16r0sUXDkpXxxkwelLH8uSe2nSajtALs0fIgNa895JKUz+o9OSUYNGhlPVq0yiYnLhz4+oRek/Nx13C5q/PsAI69tQ6PmZ5RUczSFkXECXXTJYCJjJypSQXpWOVv0Y6lyWLyIaKgeqk0zmASgMu6pGP4+MsvqCj/z+8Tx4ZdEDPHNwIWSkAextL/ZFLypyHS/ykidfHiBy7Nj2MMho989oQFhiiEShx3t2FSYixyJ45JefvrKnOZvEERRc+WYyeoxnk6mr+CGmxmhbFDmXMO5MIvN+sSqHLW9uNPKHmy/WE8fFMqycJC9F7QD7qXtqqgjbnfDqSGOMqUvRWe9PCj1TWAhqUmBSzbNd8skxuYibNDXdW1pQlhH4ADhj15usBNuw4Gb9q5FNW44X0MN0w5iP7D86pgQbu
x-ms-exchange-antispam-messagedata: syFdNv6ZgIK3Wf5hJBmPTHVmJUFNond4rB/WiYQUmj17/pSvNBdeAKT3OdVYtLhSmMQUXKn94K96Z4mnI72rmeG0yaQ49A+J0mHMXTEsq65Vw+Bcx97Kyp7jyhEZbMXNReGsA/pnxbc7n/+QxSeHsQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f77e97ef-8816-4e5b-5a1a-08d7d212881a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 05:48:52.9268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cEQqgNqVJH9Qi3Rizmww0YIKfuxZRfUDcCoxx5J/sCIfwdUIXOlZGr2oPg9YP6EniMrTGdrwlv/kz3MdtbMWlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1801MB2029
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-26_14:2020-03-26,
 2020-03-26 signatures=0
Cc: "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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
> From: Auger Eric <eric.auger@redhat.com>
> Sent: Thursday, March 26, 2020 11:11 PM
> To: Jean-Philippe Brucker <jean-philippe@linaro.org>; iommu@lists.linux-
> foundation.org
> Cc: virtualization@lists.linux-foundation.org; joro@8bytes.org; mst@redhat.com;
> jasowang@redhat.com; Bharat Bhushan <bbhushan2@marvell.com>
> Subject: [EXT] Re: [PATCH v2 3/3] iommu/virtio: Reject IOMMU page granule larger
> than PAGE_SIZE
> 
> External Email
> 
> ----------------------------------------------------------------------
> Hi Jean,
> 
> On 3/26/20 10:35 AM, Jean-Philippe Brucker wrote:
> > We don't currently support IOMMUs with a page granule larger than the
> > system page size. The IOVA allocator has a BUG_ON() in this case, and
> > VFIO has a WARN_ON().
> >
> > Removing these obstacles ranges doesn't seem possible without major
> > changes to the DMA API and VFIO. Some callers of iommu_map(), for
> > example, want to map multiple page-aligned regions adjacent to each
> > others for scatter-gather purposes. Even in simple DMA API uses, a
> > call to dma_map_page() would let the endpoint access neighbouring
> > memory. And VFIO users cannot ensure that their virtual address buffer
> > is physically contiguous at the IOMMU granule.
> >
> > Rather than triggering the IOVA BUG_ON() on mismatched page sizes,
> > abort the vdomain finalise() with an error message. We could simply
> > abort the viommu probe(), but an upcoming extension to virtio-iommu
> > will allow setting different page masks for each endpoint.
> >
> > Reported-by: Bharat Bhushan <bbhushan2@marvell.com>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Eric Auger <bbhushan2@marvell.com>

Thanks
-Bharat

> 
> Thanks
> 
> Eric
> > ---
> > v1->v2: Move to vdomain_finalise(), improve commit message
> > ---
> >  drivers/iommu/virtio-iommu.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/virtio-iommu.c
> > b/drivers/iommu/virtio-iommu.c index 5eed75cd121f..750f69c49b95 100644
> > --- a/drivers/iommu/virtio-iommu.c
> > +++ b/drivers/iommu/virtio-iommu.c
> > @@ -607,12 +607,22 @@ static struct iommu_domain
> *viommu_domain_alloc(unsigned type)
> >  	return &vdomain->domain;
> >  }
> >
> > -static int viommu_domain_finalise(struct viommu_dev *viommu,
> > +static int viommu_domain_finalise(struct viommu_endpoint *vdev,
> >  				  struct iommu_domain *domain)
> >  {
> >  	int ret;
> > +	unsigned long viommu_page_size;
> > +	struct viommu_dev *viommu = vdev->viommu;
> >  	struct viommu_domain *vdomain = to_viommu_domain(domain);
> >
> > +	viommu_page_size = 1UL << __ffs(viommu->pgsize_bitmap);
> > +	if (viommu_page_size > PAGE_SIZE) {
> > +		dev_err(vdev->dev,
> > +			"granule 0x%lx larger than system page size 0x%lx\n",
> > +			viommu_page_size, PAGE_SIZE);
> > +		return -EINVAL;
> > +	}
> > +
> >  	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain,
> >  			      viommu->last_domain, GFP_KERNEL);
> >  	if (ret < 0)
> > @@ -659,7 +669,7 @@ static int viommu_attach_dev(struct iommu_domain
> *domain, struct device *dev)
> >  		 * Properly initialize the domain now that we know which viommu
> >  		 * owns it.
> >  		 */
> > -		ret = viommu_domain_finalise(vdev->viommu, domain);
> > +		ret = viommu_domain_finalise(vdev, domain);
> >  	} else if (vdomain->viommu != vdev->viommu) {
> >  		dev_err(dev, "cannot attach to foreign vIOMMU\n");
> >  		ret = -EXDEV;
> >

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
