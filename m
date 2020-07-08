Return-Path: <SRS0=dlfR=AT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD1EC433E1
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 08:16:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D992520672
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 08:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="qj8SZsY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D992520672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8E99021553;
	Wed,  8 Jul 2020 08:16:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mWguti8W6NY9; Wed,  8 Jul 2020 08:16:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 76E952050A;
	Wed,  8 Jul 2020 08:16:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A0B8C077B;
	Wed,  8 Jul 2020 08:16:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B61C0C016F
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 08:16:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9F05888CB2
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 08:16:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a1uIrGhLFbwm for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jul 2020 08:16:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EE5BB88C9A
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 08:16:20 +0000 (UTC)
IronPort-SDR: R24N6yIqi0WamQ5gN0IVYX7u6IXLsRnGDwgXx8FLM7J2eV2WEEk6tfHdtpsG0x9jnYgN+uR1m8
 mJlWth3KWLsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="147764525"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; d="scan'208";a="147764525"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2020 01:16:20 -0700
IronPort-SDR: VOxPFpZecnODV5PmPmvsrTlMcCZzep/dLGUc6htzhU7Scb9yB0j1pHncKSZ9YYcdRbrh80iWgX
 1VX4CKOfqw2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; d="scan'208";a="457425564"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
 by orsmga005.jf.intel.com with ESMTP; 08 Jul 2020 01:16:20 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Jul 2020 01:16:19 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 8 Jul 2020 01:16:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8TCb8Op9CV5w1x4AOhCiFc4xYdthvIfag+zOOWy5xWdgCBbPipgrVdQg7kwONHDuJpv0d05bSs6GI7UyMWJkB35/OV/6xYBC+lwfzE8aUdzSRBSNeFfLEEocg/NJ7XVJEMp58PNiRp+GRH6z+7tfwxRiUDYZYzBMIfITq11mOor2DdqNaYLiTQ1p1EGoh7L4GR/Fd9EAPbW4AVtS22zPaO6Nx5na2IZVpjsLuJzAWI+Gv+MD0KYnqoyd15slmalg+ZLweMHMlZVFFfzEvdzLj7vUQbsYkvyF+bwvgADyqsiS7k0kZBLBpyir2Ae4wLNDxOZJ6fuVWMLuFq1LrJkxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6Nry6+SRCKI/axwqaHQBfa0yAKIqm8Q90S7YuunxII=;
 b=hYlYjfp0qjRugscqZDWEutDZs3Rp40WXbN34/h4xkOJtDtxRPD8Ata4VQ8VDM2SjA6YnfFuJEyOh1BryJidqn6EYydxRZonLJZrgXPhAamXEQOAIXOKredwqUwaIdDuwfQddRg1JRVSc7OuRPuEVMkv1lcfNRz87QO284Moq9jg3K5Vj+v0lMmgxx9/qRpQcm4w35JfXKl+/nERsiK5CmsR2Ui4/Pj6WXPG3S9D8OzddRc3Rer24sdJ0iTUPm6WvQpIz/SgJuO3U2Quw7SEf7XVsIBUPbJmhyMMGhUq43HBiVI3nfO5hzt0otw0ZtTSsjUsM5uN16cdevGQnYfOTvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6Nry6+SRCKI/axwqaHQBfa0yAKIqm8Q90S7YuunxII=;
 b=qj8SZsY7l++Jhdti5YIMfoK6fsmuqR3H4L7W9/DbuHobETFpBoje64n+MR+9JnKpitSDCp6Wo45W7ERe36SdVrlzsVH8z6Ygmt9TpCHqSXufRaoWVUSt5Hh548ygqs7kLOnpFd5QADPMsaAVvrHnCEJiwQnoLmfBY0gWa2hwMLk=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB4530.namprd11.prod.outlook.com (2603:10b6:5:2a4::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.22; Wed, 8 Jul 2020 08:16:16 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 08:16:16 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH v3 06/14] vfio/type1: Add VFIO_IOMMU_PASID_REQUEST
 (alloc/free)
Thread-Topic: [PATCH v3 06/14] vfio/type1: Add VFIO_IOMMU_PASID_REQUEST
 (alloc/free)
Thread-Index: AQHWSgRRzB2G/Oy5QEmxCHQWFS0FB6j02KQAgACUCyCAB/5SUA==
Date: Wed, 8 Jul 2020 08:16:16 +0000
Message-ID: <DM5PR11MB1435B159DA10C8301B89A6F0C3670@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1592988927-48009-1-git-send-email-yi.l.liu@intel.com>
 <1592988927-48009-7-git-send-email-yi.l.liu@intel.com>
 <20200702151832.048b44d1@x1.home>
 <CY4PR11MB1432DD97F44EB8AA5CCC87D8C36A0@CY4PR11MB1432.namprd11.prod.outlook.com>
In-Reply-To: <CY4PR11MB1432DD97F44EB8AA5CCC87D8C36A0@CY4PR11MB1432.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [117.169.230.114]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f06eebfa-debf-4717-9171-08d823172fc5
x-ms-traffictypediagnostic: DM6PR11MB4530:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB45307D5943DC4E8731669848C3670@DM6PR11MB4530.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 04583CED1A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4+7wPGAQFN3y78CP7ohUGmuvyegZZT+Die47qLeK9+Xe0sGheVSEgZvcRSYysYIoXrXOF4ImTNSz1enYtTLUmy24tQzpx43qR+79eD4SDXVxO6NjlB2vqFv/j+6LOxZVbFKfvialrXMyhk6zWK71rj1Z3sz8ohbySvUzbuR5nJwQv57JVHbICpmWZ0X+Bumjw7ClJeR+nw6XvjiofZ1M8rss2YRzzPeDiLQI8pQxtA+spMOQnQajaD+1H+PjXERiV31eDcqfJS5nZyEDaunrOVIY+MlSW4YIXioKfCwCfaUcCoLQ1Bo8Qp7FKyi8rRY3/5NZOW5IdUQjEI5JiC+g3Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(54906003)(5660300002)(33656002)(71200400001)(478600001)(8676002)(8936002)(316002)(4326008)(110136005)(2906002)(64756008)(66946007)(76116006)(7416002)(52536014)(66556008)(66476007)(9686003)(66446008)(55016002)(26005)(186003)(7696005)(6506007)(83380400001)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: wRXYgayFvHl/lKg+/H8F5jwaFzVKXKyF7s1PPKSjGEGRayJSrYoIuYJrRPDf7ViuVnlR3qUpqaLzqKkNiCEWDBd+6OieNcIPl6K3DXOSXfTHf1T9TvGQbi6V46dDeO7pMat72NK5+qNHpCjeXmLMWyA70tyKLwh836znSf+kamDoRg9EvboWfEIui8oQXcZmwT/eJTJF3DO9Qhs9hFCZMgu53mvDpsNnbVQnB6YqGcTZeDnJoFBI6ehl+82sQu1QBa4CmA6k97LMJBG7BlzeHIyew+zhuSh1PUEdviSk1wuT54M/BxF/OtbHrCeakCyGt2cH/dtWUHyf7kvdnGPTAXFJ5FJ5NZIJe65MK3SQxv36oFxE8UPjuNY5B38y5GXcpQVTkPg3/tzxUWhqiF03bw6tre9wix3VQicg3wIAz5OjTsgRTUz6W4HCcqJw7S2MbMxHMVkcOl1/GuoNWaRREyd0yBJofAmx/xgMb7z5mN9kCdzBefpbf8mZhS2WHsto
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f06eebfa-debf-4717-9171-08d823172fc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 08:16:16.4162 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GOaSJsFJ/6HLRQ/h8ftFqClN/w7i1q3OMscTnERqHAwbpCN5BcdJT00Z9F3Oh3pMz1F0KwbTxQd+Vt+kYPxRog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4530
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>
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

Hi Alex,

> From: Liu, Yi L < yi.l.liu@intel.com>
> Sent: Friday, July 3, 2020 2:28 PM
> 
> Hi Alex,
> 
> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Friday, July 3, 2020 5:19 AM
> >
> > On Wed, 24 Jun 2020 01:55:19 -0700
> > Liu Yi L <yi.l.liu@intel.com> wrote:
> >
> > > This patch allows user space to request PASID allocation/free, e.g.
> > > when serving the request from the guest.
> > >
> > > PASIDs that are not freed by userspace are automatically freed when
> > > the IOASID set is destroyed when process exits.
[...]
> > > +static int vfio_iommu_type1_pasid_request(struct vfio_iommu *iommu,
> > > +					  unsigned long arg)
> > > +{
> > > +	struct vfio_iommu_type1_pasid_request req;
> > > +	unsigned long minsz;
> > > +
> > > +	minsz = offsetofend(struct vfio_iommu_type1_pasid_request, range);
> > > +
> > > +	if (copy_from_user(&req, (void __user *)arg, minsz))
> > > +		return -EFAULT;
> > > +
> > > +	if (req.argsz < minsz || (req.flags & ~VFIO_PASID_REQUEST_MASK))
> > > +		return -EINVAL;
> > > +
> > > +	if (req.range.min > req.range.max)
> >
> > Is it exploitable that a user can spin the kernel for a long time in
> > the case of a free by calling this with [0, MAX_UINT] regardless of their actual
> allocations?
> 
> IOASID can ensure that user can only free the PASIDs allocated to the user. but
> it's true, kernel needs to loop all the PASIDs within the range provided by user. it
> may take a long time. is there anything we can do? one thing may limit the range
> provided by user?

thought about it more, we have per-VM pasid quota (say 1000), so even if
user passed down [0, MAX_UNIT], kernel will only loop the 1000 pasids at
most. do you think we still need to do something on it?

Regards,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
