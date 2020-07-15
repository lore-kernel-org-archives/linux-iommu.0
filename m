Return-Path: <SRS0=xM8W=A2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F38AC433EA
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 01:23:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 072BB2072D
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 01:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="LOW5XRox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072BB2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C712389DA5;
	Wed, 15 Jul 2020 01:23:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B-CF6T0Pt-FY; Wed, 15 Jul 2020 01:23:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 51D1A89D93;
	Wed, 15 Jul 2020 01:23:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F469C0891;
	Wed, 15 Jul 2020 01:23:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2503C0733
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 01:23:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E0E5989807
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 01:23:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TYJ8+IGKBnoY for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jul 2020 01:23:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8132689591
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 01:23:30 +0000 (UTC)
IronPort-SDR: kmqry/XpJ3RkV3PRWwI7BylAnDPf4sfbsfzJNjdfHI9KIrS1wqJH4874Ab3J5Mqs42yIzAx74b
 oyfo/mZgrVRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="233915783"
X-IronPort-AV: E=Sophos;i="5.75,353,1589266800"; d="scan'208";a="233915783"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 18:23:30 -0700
IronPort-SDR: iFUhZb4c999lAp81Ts1oFd03zXzh39TO404nynZjfs5BueweB/d609tE2flxyFGE4DQf+xqfW8
 YEnKJmH0nLtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,353,1589266800"; d="scan'208";a="390645501"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
 by fmsmga001.fm.intel.com with ESMTP; 14 Jul 2020 18:23:29 -0700
Received: from orsmsx152.amr.corp.intel.com (10.22.226.39) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Jul 2020 18:23:29 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX152.amr.corp.intel.com (10.22.226.39) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Jul 2020 18:23:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Jul 2020 18:23:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlV9b4fd4UEk8I5HNZ/QpYdZc55nWXKko1GjaXxNlndDBzmJm666xmadyZbx6EWlRkvdWS2z2kEh0E42qm9+pvO1c+29rEWX90gXQs/iou3k5XalLvmTvTfYFz/KpBRYo7KOS1MEac+qhglsN5SzFATFc9xyf4h+9fy9GvtoTHOFcQ2twzpA7MPM1LROaO5f8TQTXhvUlwfhor+xFktrJqPXcShXetrAxb4pGilouKovg1zQIUjoF9aarw5mUQk8qdKhUOUtEK0PgRKKPquE37SL2QakUr+WqJWbTH9TCcRVlyxxHsx280Mq4NDqt/P0gT3imXWMRquhr5lb+E6Lpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgeON+F+HITzyTjk8SwWvCe3hfV2261krmoOXN/zPeg=;
 b=PERL1rJ8+js1Xh4lmjALE0zfyyGjzH2jWGVDcSgJ/+c8Pfpys5QhJFCndtLjeE7KSmarpvoSqXXgWTLcFkNw8ownhytNGvhUP635ffF073Q8XG1YTkZJBN0N+2tqS9jTR61xxiI6MjfZxFYNeIgIBx/d+BmObFNI9nZajKsE7fWDIaFzKkKrL+SYoaX+YMAcgRN08kMI4sRX8SJpp9QX7YyaGRgmCBgWPsvuaEF3H02I5y1v4USMEo6aFDVkviq+JsqNQtaJWbKOhVtJGj7EtVUTccR3tq0HyqGpQPD/qqWlLu9cBlHlqfJ8KsjqVRxKc4ECFc2XVj4UBq4O7h2+TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgeON+F+HITzyTjk8SwWvCe3hfV2261krmoOXN/zPeg=;
 b=LOW5XRoxgP/uNuBe4NVsAmIn3SkUhZFKyrALtez+umXAzDd8DBQEBt6U8/JGFMhJoFIDiMJW+wZDtSHVuAPTjpP8IF3x4pGltC94przRnWxGN93/xG0iI98vlj9FWkCacdbghPUAK+H3ZjCCQypC8ZFCjZoOWx1pa/mYUWJ0GtI=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR11MB1568.namprd11.prod.outlook.com (2603:10b6:301:f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Wed, 15 Jul
 2020 01:23:26 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb%5]) with mapi id 15.20.3195.018; Wed, 15 Jul 2020
 01:23:26 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>, Christoph Hellwig <hch@infradead.org>
Subject: RE: [PATCH v3 4/4] vfio/type1: Use iommu_aux_at(de)tach_group() APIs
Thread-Topic: [PATCH v3 4/4] vfio/type1: Use iommu_aux_at(de)tach_group() APIs
Thread-Index: AQHWWaRWAT4ieRfuc06ojNA63fOJkqkGvU8AgACHTgCAAI6hAIAABegA
Date: Wed, 15 Jul 2020 01:23:26 +0000
Message-ID: <MWHPR11MB1645BB5C265C520EEA005B078C7E0@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <20200714055703.5510-1-baolu.lu@linux.intel.com>
 <20200714055703.5510-5-baolu.lu@linux.intel.com>
 <20200714082514.GA30622@infradead.org>
 <20200714092930.4b61b77c@jacob-builder>
 <ac4507d5-a5fc-d078-9bfc-f9e9fd1244e7@linux.intel.com>
In-Reply-To: <ac4507d5-a5fc-d078-9bfc-f9e9fd1244e7@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.193]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f016d9d3-12dc-4263-33f4-08d8285dac90
x-ms-traffictypediagnostic: MWHPR11MB1568:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB15682969129D9E93C37855138C7E0@MWHPR11MB1568.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o/X7g5h4Wmq88MkL2WR513T5j5T/KOytcMtjSJU3gQymSGCfjooYE31THmCTimYbzO93jJUtggRCpEwdmMo2gQf1b6UKKEefqzFhKL3k1TAlTEBR+9a4KQ4fZt6M9oitps8rqhYkpHbIdXdedffMQHm4gDtRrRzev7CsdtNcp4ZNb3nwXaNyywQQPSv6UdiKCfetunHWD7yYj9IPVp8dE1N7DXYYou1COGj3DJ5a7iqx3YRRyBmlFgkN1B9fT2mor6N/j4yPDKGuZ/W6NgLwi0UZgbB5R7ZQ0hzBWmG8SwDMqOxGbX12UEwulEADBTl3Td3sxywJAJ5WptvW0R/jsD14+K1+vDt5s00fBpuz2DbKaTCRBTE7R8fCUM5e+WKfY87fO4v5p55tvWfoLAPg/w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(33656002)(86362001)(76116006)(66946007)(71200400001)(966005)(54906003)(7416002)(7696005)(52536014)(478600001)(316002)(66446008)(64756008)(66476007)(110136005)(66556008)(5660300002)(26005)(8676002)(8936002)(6506007)(4326008)(53546011)(9686003)(186003)(2906002)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 7DNuMYcq1clwzXW0J1c6EMH8bVEKL4Ndr9yEVEqVUbfVYkRavcl7aYgeDgcG0VO6b+iGW3QiYiAWq1BWE+Wc+Nb5zUh4yANI1JCeNHHySNOh3CLXI07M1WJFnl3DeZt3Ge2VGnt8IvMLIKyl86NEZsceqrbxHaXHwpGeQz5W4Re4kDk89eQQ7BPRumbakr0DSYYQfK6aBTv16X3Jaf6KvHnMLOjnjgsQVnvBRNsECUQkYeZ7yQYBgzKiF52Az9CLYLQC2ZC5dDG8BkFkrIKAAo4FEsieKrfRBHn5Il5zXVtptrOQKNSCprJIPvg5eg9tluxAwn5QlhGHLeLFylJDYiKpuByjMroXqTh1cNcX4NnabEIXe9F8JlC+wYJazqILKmspkt9SzEpp87t6x9d2k7V9kV8Z8CsBV64OVxlAEzcbOoiAyuV4vx4srl3k705rkp3d4OC6PqG7kf4SgZUuzMYpYBFukKsDl6ruzYsBd/N1Fq4i1V/XwjOxfO2l+uiM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f016d9d3-12dc-4263-33f4-08d8285dac90
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2020 01:23:26.4706 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M79tBxCNnOLifIYv818t19gTPFzRSpOs9isrdQGSgT6wTAiZmYYM6BsuIILG5wmm8qL915/8OvYx2FoRy071sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1568
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>
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

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, July 15, 2020 9:00 AM
> 
> Hi Christoph and Jacob,
> 
> On 7/15/20 12:29 AM, Jacob Pan wrote:
> > On Tue, 14 Jul 2020 09:25:14 +0100
> > Christoph Hellwig<hch@infradead.org>  wrote:
> >
> >> On Tue, Jul 14, 2020 at 01:57:03PM +0800, Lu Baolu wrote:
> >>> Replace iommu_aux_at(de)tach_device() with
> >>> iommu_aux_at(de)tach_group(). It also saves the
> >>> IOMMU_DEV_FEAT_AUX-capable physcail device in the vfio_group data
> >>> structure so that it could be reused in other places.
> >> This removes the last user of iommu_aux_attach_device and
> >> iommu_aux_detach_device, which can be removed now.
> > it is still used in patch 2/4 inside iommu_aux_attach_group(), right?
> >
> 
> There is a need to use this interface. For example, an aux-domain is
> attached to a subset of a physical device and used in the kernel. In
> this usage scenario, there's no need to use vfio/mdev. The device driver
> could just allocate an aux-domain and call iommu_aux_attach_device() to
> setup the iommu.
> 

and here is one example usage for adding per-instance pagetables for drm/msm:
https://lore.kernel.org/lkml/20200626200414.14382-5-jcrouse@codeaurora.org/

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
