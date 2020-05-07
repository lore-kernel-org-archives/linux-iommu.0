Return-Path: <SRS0=32yV=6V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A037C38A24
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 11:25:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D259208CA
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 11:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marvell.com header.i=@marvell.com header.b="lCCF6lz6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="Jt2cxCWb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D259208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D0E7720448;
	Thu,  7 May 2020 11:25:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nojL3vYGJfw2; Thu,  7 May 2020 11:25:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0017B26316;
	Thu,  7 May 2020 11:25:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5F84C0890;
	Thu,  7 May 2020 11:25:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00FA8C07FF;
 Thu,  7 May 2020 11:25:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EEAF189398;
 Thu,  7 May 2020 11:25:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kL1hv0CjdLAL; Thu,  7 May 2020 11:25:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by hemlock.osuosl.org (Postfix) with ESMTPS id AAA2B89395;
 Thu,  7 May 2020 11:25:41 +0000 (UTC)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 047BLL0l009756; Thu, 7 May 2020 04:25:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=fU7PkqbSdezDm5c48vMS2SmN6B7FNmKGB72WXm19Elo=;
 b=lCCF6lz6hyanXVhtSQIS3fUQWzIrJUwUNcjqwB7+LBHZ9wTdxMI3tjTkMw0sJUcRDKhC
 vKxTVwCGkNhdN5i8UZF6k76dJjLnxxPq+9ERVSfZtsz3xUoMjOzv87VwNWieTnlAjci6
 FGfmv2Y8xVVNLFbpLp0qE3bQ06G6gILQq+QzHYZIsOwGhIjOFZJIQRdHwa47zi6V6sSb
 lQpGMMEJldD6xN1e5GhlfuKW4dBV2ZP7PFLXL3PkgwLHI22AzIhvzEnFHCx0Nd/3jjKR
 c7//qPKWnEapG6ptNtVZEOM3AIwQdbrQVfXPoUuCRUdm0KkWuI+eTUteiyWevbqQLSgd FQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
 by mx0b-0016f401.pphosted.com with ESMTP id 30urytwynb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 07 May 2020 04:25:37 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 7 May
 2020 04:25:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 7 May 2020 04:25:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mW8pe6Kzv6ORyo9Wbh91ezYg7MRba57h++VPlzrnbQZbWGdaJALHT/Y6IpkpbdOgmzW+e6lWqR5Kr6uJIlqEi1QNhv2hRBBtAAOyC2iSwJkYBav0m7XZZ1xtQmUdHhwucQQZhG6vwW32mO03m/NE0FuHD3ueyz1MjMKcg2uV0Vh/3NbWtZU1/gOKTwUWH4oIcG6lMk493pb/xk22t/ZfPFDgFzWHXclU1RowKOoi4bQXKs/3y9tyahNdD4dh8zJTHKDMTTkTBssEtmcTA0QIKEYlueUwW3SboNTc+5pbiy+Xbkzwr0WkHEsx7E37sguxmWSh4+/Q4IZ8Pe5YwVP4LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fU7PkqbSdezDm5c48vMS2SmN6B7FNmKGB72WXm19Elo=;
 b=Sfabu1LFK6yZtuc2RhF3paZlMEOT481gVN7pUzOqgyT29MiK6Nim1ABpNTsZhk3XvRwQ70bb/dLakmNuWghtE65AmW4+VRN/F/JxiN+cc2pYo7htKlE8caiUcY0BQidLokuppwNXA+6DTi+m8HD/yQ/0jbz0Z4DQZnhp/LapZvADwlgC64lr1H4cMavZJIo0NEK6pl7XwxEWxcpt7Uf1XujRhPwp2wYNWWsoOs1xY7Erxo1dbgoQaWaHOkAJKoKnrFCmwV5gw90pB1snWjaFQnxCtrULy7dERufqvcR7c2i6CPA9+KSzGL1bCoyJFWqKFadCA5KMWcwS0Q8alOO3Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fU7PkqbSdezDm5c48vMS2SmN6B7FNmKGB72WXm19Elo=;
 b=Jt2cxCWbWDtIo6oftUU2NJ6fzIUdnU3Zs7lfYdXKT3UsWnd2VMebtPSeGqSZiSIGpageGyVGB16yEMo/EvwjkAOzKDVQUJDwDHMX6VgbmJxbsC/bzIU6bSzPuF7hkRM1+VZkIeG+CyKRpRL7hi3iqYo/lgPXveE3IuqGUKIvwt0=
Received: from MWHPR1801MB1966.namprd18.prod.outlook.com
 (2603:10b6:301:66::20) by MWHPR1801MB1901.namprd18.prod.outlook.com
 (2603:10b6:301:61::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.30; Thu, 7 May
 2020 11:24:33 +0000
Received: from MWHPR1801MB1966.namprd18.prod.outlook.com
 ([fe80::6028:eab:73:829d]) by MWHPR1801MB1966.namprd18.prod.outlook.com
 ([fe80::6028:eab:73:829d%3]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 11:24:33 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [EXT] Re: [PATCH v5] iommu/virtio: Use page size bitmap supported
 by endpoint
Thread-Topic: [EXT] Re: [PATCH v5] iommu/virtio: Use page size bitmap
 supported by endpoint
Thread-Index: AQHWIr/tb/HaX8dazk+c9DNGI+wgB6iaM2OAgAC462A=
Date: Thu, 7 May 2020 11:24:29 +0000
Message-ID: <MWHPR1801MB19669FA26D44E1C31DF89BDBE3A50@MWHPR1801MB1966.namprd18.prod.outlook.com>
References: <20200505093004.1935-1-bbhushan2@marvell.com>
 <20200505200659-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200505200659-mutt-send-email-mst@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [122.179.57.224]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4397964d-17c9-48e3-e852-08d7f27937b8
x-ms-traffictypediagnostic: MWHPR1801MB1901:
x-microsoft-antispam-prvs: <MWHPR1801MB1901C1F5DFC409359172A9BEE3A50@MWHPR1801MB1901.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 03965EFC76
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gYaimAs1vOvTFKomosXu3yby8k8EPnuR3qxsUhvRq1MTkmcjwHcVoEcT24k4eCnHcuBjWXDTlh7Oz8fjsLTJq2el810S9QayzZuq6yEO834xHARuD01WM5eHaL/cHIHd/FwH1CkOYn1u8QiS8r/qg98pBz0g3ObWL8fD+HoYe9lQBf21l1rXGFjSTDeoGgjFHkIcAfNOrN0JKFeja3PtEo9fJgozH9D0FSNQw9vPM2NFe7YyxA1gukdpvLzuc08GEmSpyC1zjEoe4KU6kbeRz+kO/ShyFOB+I+6k/sECDvTQPigNvFLe1Jnmh0yjaF1spfkfTfvTj+Av6SJE7dIoOWLOA61LUs7yRoayuA4MNhLPCkqbQCCye94qZ9OZpl6gXCxl1fzHMcpV72w4tyHbHRmuZQqpljC03LZ4CoDj/BwflgNl9KRmIP/skbc3l277LbYGrxCW/e4BKulBIXxCVuGr9XGtOYCGu9UsMYSDon4flfYWRdLcV2gesSsfQNGszBhL5DDocnVy0iDiTsYgIO/lO7//jgjDLzy2t2l0UGJg/R7o36ew2RZnX/uWeUe/hqyjZm0pFpEv2TLALXOhv9tUEsWT4vTt/DCs2l7PPSE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1801MB1966.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(33430700001)(64756008)(6916009)(55016002)(7696005)(66556008)(66476007)(316002)(5660300002)(6666004)(54906003)(26005)(186003)(966005)(33440700001)(8936002)(8676002)(66446008)(71200400001)(2906002)(9686003)(83310400001)(83280400001)(52536014)(76116006)(83290400001)(83300400001)(83320400001)(4326008)(53546011)(86362001)(6506007)(66946007)(478600001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: kcfUp9dNmu/24/kJKutrSqF8chGEGrPzpuQ2sFYhr+TLFUJnJgQDY2afQLFevgasrD3kMjhXJx85+mMnRIByamhTNHhVKng/7yvi1S6d9k0tYnsTlBOhY8g6D/6h2hi1U9Bu0TNd17asrfRf5Ys/ItYuIfh4rCCbPrV9v1pK27QdIbatkulVI2QQz5e7Vl2kEvjt2AuxzXUdOjnODS0CCxFvTPOdzR4Zr66MzWoP/Nujyyd9L62xm4QDztjLwfoeuKUKPNZGIvSPtvDdzCemUDKz9GHaX+cregjsZ+gVb4EjDo25mQ23DNKN9O49T0TDbMpGASLYU2Gd4oeKpCS7AQdaOVCozdg6YyCQP8ul+rjHtt43g8gstT7vcOdsxFJZm0G0mSGxVImkD470yFFLV6BcVThGUYn+mlEYJIe/znmyI4/HA2L28EQDdCgdiaDhRqBID4PqQ0e4AmNNUtPBgaktj9NlmFi+uolSh5NPKmEz0jFzLyM/rwEsUxL049irv3wtR9hbHc9m7bkl4zFoXt4lbae3/IVEAEyYfQ8mQWXrnAT+Hd3p8JUTu/3FOF1c+2D7PTCP9e6TFhW8R5osHvrIC1vFYyG0leIbkvoMIowLaFGWN2Fhsh2mKvZtAun91JpjTxTC8sxQ0GycA97+uJO3ZpF0FDIZXd2hHJgHijnMz8gRkjup1JwxS0GcTNTc5Ge36yOw7YtONqsycWyhrw0g9CD+zKvWuMn3+a7ILX02qOo0tXfqZ1WQjt1SBwnbq00vaNl7U99u4LM5aYvI8IuNo2pMbht3x75H/b/1feY=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4397964d-17c9-48e3-e852-08d7f27937b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2020 11:24:29.4498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T6ZQ7GAqLa6xeUpEu+miBky1UciJf58aP8163UvUuiVTO0GPgnc845hPeWSCiS6ijYbiyNAnSqjAW9vdM37gLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1801MB1901
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-07_06:2020-05-07,
 2020-05-07 signatures=0
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

Yes, Will change here and other places as well

> 
> > +		return -EINVAL;
> 
> OK but note that guest will then just proceed to ignore the property. Is that really
> OK? Wouldn't host want to know?


Guest need to be in sync with device, so yes seems like guest need to tell device which page-size-mask it is using.

Corresponding spec change patch (https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg06214.html)

Would like Jean/Eric to comment here as well.

> 
> 
> > +
> > +	vdev->pgsize_bitmap = pgsize_bitmap;
> 
> what if bitmap is 0? Is that a valid size? I see a bunch of BUG_ON with that value ...

As per spec proposed device is supposed to set at-least one bit.
Will add a bug_on her.
Should we add bug_on or switch to global config page-size mask if this is zero (notify device which page-size-mask it is using).

> 
> I also see a bunch of code like e.g. this:
> 
>         pg_size = 1UL << __ffs(pgsize_bitmap);
> 
> which probably won't DTRT on a 32 bit guest if the bitmap has bits set in the high
> word.
> 

My thought is that in that case viommu_domain_finalise() will fail, do not proceed.

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

Is not it too to change the existing domain properties, for devices already attached to domain? New devices must match to domain page-size.

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

Jean already send patch for same
https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg06214.html

Do we need to do anything additional?

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

Ok,

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
