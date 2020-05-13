Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EABCA90AF
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 09:15:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4144D20661
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 09:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marvell.com header.i=@marvell.com header.b="rw3Ds/p/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="Jh7pjoIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4144D20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1950584917;
	Wed, 13 May 2020 09:15:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4W_-pZcmGLRz; Wed, 13 May 2020 09:15:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 49A298462A;
	Wed, 13 May 2020 09:15:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C12FC0178;
	Wed, 13 May 2020 09:15:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1FADC016F;
 Wed, 13 May 2020 09:15:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E018E848FA;
 Wed, 13 May 2020 09:15:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PzY7Gw23lO-w; Wed, 13 May 2020 09:15:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CC70684837;
 Wed, 13 May 2020 09:15:31 +0000 (UTC)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04D9FPNZ014273; Wed, 13 May 2020 02:15:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=aJsecdOHsRTFfXb8rg+YFIDDFwa60NTtYu/llbyWMKU=;
 b=rw3Ds/p/3oDspkUgCNQ4Bs9UiJm+BS/pz2frfX6wQxmlpql4MmUlP4yr/NAtidj/QF/g
 taQ4vmnp4VDs1YuC3wDc6tRpmoQS72j+MjhVGACpuuaw/Sq+1hr1YpuvagF8gx7xz0Jp
 l65UHetzp51W8RK9XhJ7/RPRzLjSQlfvOAxjDFUv1Hdcp+sPUmL63Bd8BmLuTCC7nZ9S
 aWckeVIyPJFqd1VGko58D6fX/qLqzp15Iju336iTFIL0UCOGYNnO8VuxibNhf+in7POX
 DJyM5P3riYOuxKQ187Lttrpox4IdunYPIYlJg175J3SxGJkYu12aEXVJJk9yh3sMc3AY iQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
 by mx0a-0016f401.pphosted.com with ESMTP id 3100xabp89-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 13 May 2020 02:15:26 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 13 May 2020 02:15:24 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 13 May 2020 02:15:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 13 May 2020 02:15:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NohhfyI0gkyze34lE/svUe7dSyg74F3NSvHl5ani2Y5Uruj6AzAkVGNUhyfo1t70d5blyguZeFMVvaVlMLvfVzuKqCbyAn9C2g++DJXeWTb6k8eJzgw2+qzG/OjYHyr+JXQspy77/14QVs/QZHot3xbppcnN573qI6207J6UmdBk9GOiYDqf2zvQO2w7K+E0R1QId4AoQem7uWsiDHBLrUM/h+niX8+cQJnAAMYOQj5XeKpSdB8+c6doWdmbTa/XEvs4uMH/Ie/eidEiorNpHQDTPINoTqOwV787ZgHyYDeZBIX0uPIE07L6Bk4PGIk3AacA71/AVtPv/WlWQI3STA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJsecdOHsRTFfXb8rg+YFIDDFwa60NTtYu/llbyWMKU=;
 b=i0F7ZHK67AoVwfQbVFbW3O/l4AJb8h/Q2zPl0WEPenZKjqsFdiWMs6OsGoqKQmYpR5cjYbdRBihIIgT8QbzOAv/LE5hcDfWdfZlgez1FOPRrnM2shj1MPmBP348nvqcMSIPqUHIwhBRty7QLPkq6lyVNsW/iCbvfVk0smhXEdnNuqm4j5HxJeWtdlgYAeG4K8aws1QDY2TW8Ud0fRE2txraMOlGpxcmm8w1xN0MtcBcQ642LkFzyOl5DoTbexFMMKc2yn0tc+nk/ydWBjUNZuhtiRIw12VH0teeGrJ1Y/YJBq+aYFu13tVxJY1by3AM6u7nSlLXFjBlxEh+vOiNgFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJsecdOHsRTFfXb8rg+YFIDDFwa60NTtYu/llbyWMKU=;
 b=Jh7pjoIFh+QZhbyTpjbbdgJoOjedSqS4GRJcXfeyj5tt3WqlxO7wIu2pYHkaYEgwgCG7SumDfc8fPcWDZfLTfPTj49EuSPD//qffCP/1MzGIlY1YLYXOudbZvm7h7Hj2ifHQwJSKhURzvvI97/APt+LZQiWNHgQY8yXWKUfOSig=
Received: from MWHPR1801MB1966.namprd18.prod.outlook.com
 (2603:10b6:301:66::20) by MWHPR1801MB1966.namprd18.prod.outlook.com
 (2603:10b6:301:66::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Wed, 13 May
 2020 09:15:22 +0000
Received: from MWHPR1801MB1966.namprd18.prod.outlook.com
 ([fe80::6028:eab:73:829d]) by MWHPR1801MB1966.namprd18.prod.outlook.com
 ([fe80::6028:eab:73:829d%3]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 09:15:22 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [EXT] Re: [PATCH v5] iommu/virtio: Use page size bitmap supported
 by endpoint
Thread-Topic: [EXT] Re: [PATCH v5] iommu/virtio: Use page size bitmap
 supported by endpoint
Thread-Index: AQHWIr/tb/HaX8dazk+c9DNGI+wgB6iaM2OAgAuUpfA=
Date: Wed, 13 May 2020 09:15:22 +0000
Message-ID: <MWHPR1801MB1966A23A0298654CA6965FB9E3BF0@MWHPR1801MB1966.namprd18.prod.outlook.com>
References: <20200505093004.1935-1-bbhushan2@marvell.com>
 <20200505200659-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200505200659-mutt-send-email-mst@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [122.171.54.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d10298e7-bbb5-4f6d-7ce3-08d7f71e2a3c
x-ms-traffictypediagnostic: MWHPR1801MB1966:
x-microsoft-antispam-prvs: <MWHPR1801MB1966DF6CC94C9660B9A6335DE3BF0@MWHPR1801MB1966.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0402872DA1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MNZ58kUla3ZYzgU8GtibXeKnHSfKB7uXheHBrp6etQFvTL0HMRvfDeJDrakK5DXD7Qu2stOuxb/NMyzgVVXBxLhkr/tc8kSNHO5C7Ys+t2ZXcaE6IDDZPxMH3iZPpXtKJVaH2JhYaYIrVOAWUXd8LNGcekH1jwhYtar0uOvb1ExCrfXUr9+CmMFca+e7ohjWNxH0b9CE76y4T9kQMYCB058JdwMBwOGO6/DWbM7PxlxcimZXEZmIZ0iottDCwBc8+OZagU4GuxjZQRYzfbT4Ec94wJZ3o39VDimqkoO0FaRNL2QB81oTqcov86UtS/mbAlzXWXMAJVvpdpcm07ceDJI1pjlHCCJrNz2ZiegolcYVxl0U+Cga2BEZeJpVOH90eC69A2Sa+stwctBpas/uHUMJBxXhIEYRz9YFhi4gshKD+2+LAWxnFhPnUjT+C1yGiRa0mtCnktUmdhs/N73w4FYvZaTdotV0xob2h4DcJQDTjWpEKQk63a5L9Gxrcbxj6sYLPMMMV4xWaxvlzCmTIw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1801MB1966.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(346002)(376002)(39850400004)(136003)(33430700001)(186003)(33440700001)(33656002)(6916009)(26005)(5660300002)(8676002)(4326008)(6506007)(8936002)(316002)(54906003)(7696005)(66476007)(66556008)(76116006)(86362001)(66446008)(71200400001)(64756008)(9686003)(53546011)(66946007)(52536014)(55016002)(478600001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: oLItNNym5/HLAfbyrCppeBQu9coTsEKWGLB4lnS+6GAsYKwnBUzuRnUa4uzmb9pIbhO2wXrBut4nLzkmVLNiOQtwRycv8IlMlYyCHUI8cN3ju8aNWeOkAjzUkFUuMq0N25w5cpkZYAd5lZ++hNn5ZNSo4Dt8HldvmwXK55TgIHK9zKoKedqkQ8COnuYBtspS5O/BHqf1N2P6R+gSE8QTIftfAiexbDoYfoO8lXLUfq6gks19TywR3PZWqQhPYoNKbJdicZpk65co4AQMRVa/4ENc/ST0PUO+8qgjmocnsOZrtV4T+E/q+6NZMGTPqw3E6qZ61RGuQprS6DIkcghTDI+5dNJf9jIf9KW2ZS8KHf7s4Q3wB8hIBy7n1OwHpVXlVnDDp9RISpy+jBLSLhOtA/szAhuyNLCgL9JByWqoKfjU+6/5zZvi07AiBfs0Gc4ES7XU7hgzY/fEasMoDk255lbu4Spcwj3crdtEFdFz4jM=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d10298e7-bbb5-4f6d-7ce3-08d7f71e2a3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 09:15:22.4631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y/mRBvUehN3ulxx/QFJiQWF1pVMfZtUwqwdoNDTX+KYdXeOILh6pvsli/SWJ7NSn6Zpl01uRULd4DGxnhPhVrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1801MB1966
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-13_03:2020-05-11,
 2020-05-13 signatures=0
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
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
> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, May 6, 2020 5:53 AM
> To: Bharat Bhushan <bbhushan2@marvell.com>
> Cc: jean-philippe@linaro.org; joro@8bytes.org; jasowang@redhat.com;
> virtualization@lists.linux-foundation.org; iommu@lists.linux-foundation.org;
> linux-kernel@vger.kernel.org; eric.auger.pro@gmail.com; eric.auger@redhat.com
> Subject: [EXT] Re: [PATCH v5] iommu/virtio: Use page size bitmap supported by
> endpoint
> 
> External Email
> 
> ----------------------------------------------------------------------
> On Tue, May 05, 2020 at 03:00:04PM +0530, Bharat Bhushan wrote:
> > Different endpoint can support different page size, probe endpoint if
> > it supports specific page size otherwise use global page sizes.
> >
> > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > ---
> > v4->v5:
> >  - Rebase to Linux v5.7-rc4
> >
> > v3->v4:
> >  - Fix whitespace error
> >
> > v2->v3:
> >  - Fixed error return for incompatible endpoint
> >  - __u64 changed to __le64 in header file
> >
> >  drivers/iommu/virtio-iommu.c      | 48 ++++++++++++++++++++++++++++---
> >  include/uapi/linux/virtio_iommu.h |  7 +++++
> >  2 files changed, 51 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iommu/virtio-iommu.c
> > b/drivers/iommu/virtio-iommu.c index d5cac4f46ca5..9513d2ab819e 100644
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
> > @@ -415,6 +416,19 @@ static int viommu_replay_mappings(struct
> viommu_domain *vdomain)
> >  	return ret;
> >  }
> >
> > +static int viommu_set_pgsize_bitmap(struct viommu_endpoint *vdev,
> > +				    struct virtio_iommu_probe_pgsize_mask *mask,
> > +				    size_t len)
> > +{
> > +	u64 pgsize_bitmap = le64_to_cpu(mask->pgsize_bitmap);
> > +
> > +	if (len < sizeof(*mask))
> 
> This is too late to validate length, you have dereferenced it already.
> do it before the read pls.
> 
> > +		return -EINVAL;
> 
> OK but note that guest will then just proceed to ignore the property. Is that really
> OK? Wouldn't host want to know?
> 
> 
> > +
> > +	vdev->pgsize_bitmap = pgsize_bitmap;
> 
> what if bitmap is 0? Is that a valid size? I see a bunch of BUG_ON with that value ...
> 
> I also see a bunch of code like e.g. this:
> 
>         pg_size = 1UL << __ffs(pgsize_bitmap);
> 
> which probably won't DTRT on a 32 bit guest if the bitmap has bits set in the high
> word.
> 
> 
> 
> > +	return 0;
> > +}
> > +
> >  static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
> >  			       struct virtio_iommu_probe_resv_mem *mem,
> >  			       size_t len)
> > @@ -499,6 +513,9 @@ static int viommu_probe_endpoint(struct viommu_dev
> *viommu, struct device *dev)
> >  		case VIRTIO_IOMMU_PROBE_T_RESV_MEM:
> >  			ret = viommu_add_resv_mem(vdev, (void *)prop, len);
> >  			break;
> > +		case VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK:
> > +			ret = viommu_set_pgsize_bitmap(vdev, (void *)prop, len);
> > +			break;
> >  		default:
> >  			dev_err(dev, "unknown viommu prop 0x%x\n", type);
> >  		}
> > @@ -630,7 +647,7 @@ static int viommu_domain_finalise(struct
> > viommu_endpoint *vdev,
> >
> >  	vdomain->id		= (unsigned int)ret;
> >
> > -	domain->pgsize_bitmap	= viommu->pgsize_bitmap;
> > +	domain->pgsize_bitmap	= vdev->pgsize_bitmap;
> >  	domain->geometry	= viommu->geometry;
> >
> >  	vdomain->map_flags	= viommu->map_flags;
> > @@ -654,6 +671,29 @@ static void viommu_domain_free(struct iommu_domain
> *domain)
> >  	kfree(vdomain);
> >  }
> >
> > +/*
> > + * Check whether the endpoint's capabilities are compatible with
> > +other
> > + * endpoints in the domain. Report any inconsistency.
> > + */
> > +static bool viommu_endpoint_is_compatible(struct viommu_endpoint *vdev,
> > +					  struct viommu_domain *vdomain) {
> > +	struct device *dev = vdev->dev;
> > +
> > +	if (vdomain->viommu != vdev->viommu) {
> > +		dev_err(dev, "cannot attach to foreign vIOMMU\n");
> > +		return false;
> > +	}
> > +
> > +	if (vdomain->domain.pgsize_bitmap != vdev->pgsize_bitmap) {
> > +		dev_err(dev, "incompatible domain bitmap 0x%lx != 0x%llx\n",
> > +			vdomain->domain.pgsize_bitmap, vdev->pgsize_bitmap);
> > +		return false;
> > +	}
> 
> I'm confused by this. So let's assume host supports pages sizes of 4k, 2M, 1G. It
> signals this in the properties. Nice.
> Now domain supports 4k, 2M and that's all. Why is that a problem?
> Just don't use 1G ...
> 
> 
> > +
> > +	return true;
> > +}
> > +
> >  static int viommu_attach_dev(struct iommu_domain *domain, struct
> > device *dev)  {
> >  	int i;
> > @@ -670,9 +710,8 @@ static int viommu_attach_dev(struct iommu_domain
> *domain, struct device *dev)
> >  		 * owns it.
> >  		 */
> >  		ret = viommu_domain_finalise(vdev, domain);
> > -	} else if (vdomain->viommu != vdev->viommu) {
> > -		dev_err(dev, "cannot attach to foreign vIOMMU\n");
> > -		ret = -EXDEV;
> > +	} else if (!viommu_endpoint_is_compatible(vdev, vdomain)) {
> > +		ret = -EINVAL;
> >  	}
> >  	mutex_unlock(&vdomain->mutex);
> >
> > @@ -886,6 +925,7 @@ static int viommu_add_device(struct device *dev)
> >
> >  	vdev->dev = dev;
> >  	vdev->viommu = viommu;
> > +	vdev->pgsize_bitmap = viommu->pgsize_bitmap;
> >  	INIT_LIST_HEAD(&vdev->resv_regions);
> >  	dev_iommu_priv_set(dev, vdev);
> >
> > diff --git a/include/uapi/linux/virtio_iommu.h
> > b/include/uapi/linux/virtio_iommu.h
> > index 48e3c29223b5..2cced7accc99 100644
> > --- a/include/uapi/linux/virtio_iommu.h
> > +++ b/include/uapi/linux/virtio_iommu.h
> 
> As any virtio UAPI change, you need to copy virtio TC at some point before this is
> merged ...
> 
> > @@ -111,6 +111,7 @@ struct virtio_iommu_req_unmap {
> >
> >  #define VIRTIO_IOMMU_PROBE_T_NONE		0
> >  #define VIRTIO_IOMMU_PROBE_T_RESV_MEM		1
> > +#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK	2
> >
> >  #define VIRTIO_IOMMU_PROBE_T_MASK		0xfff
> >
> 
> Does host need to know that guest will ignore the page size mask?
> Maybe we need a feature bit.
> 
> > @@ -119,6 +120,12 @@ struct virtio_iommu_probe_property {
> >  	__le16					length;
> >  };
> >
> > +struct virtio_iommu_probe_pgsize_mask {
> > +	struct virtio_iommu_probe_property	head;
> > +	__u8					reserved[4];
> > +	__le64					pgsize_bitmap;
> > +};
> > +
> 
> This is UAPI. Document the format of pgsize_bitmap please.

I do not see uapi documentation in "Documentation" folder of other data struct in this file, am I missing something?

Thanks
-Bharat

> 
> 
> >  #define VIRTIO_IOMMU_RESV_MEM_T_RESERVED	0
> >  #define VIRTIO_IOMMU_RESV_MEM_T_MSI		1
> >
> > --
> > 2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
