Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4397C4708F
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 08:38:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D69E6108D
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 08:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D69E6108D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DFB26077C;
	Tue,  1 Jun 2021 08:38:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id shaqXo3yhr_f; Tue,  1 Jun 2021 08:38:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F66560733;
	Tue,  1 Jun 2021 08:38:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64A69C000D;
	Tue,  1 Jun 2021 08:38:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A38EBC0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 08:38:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9191B83C2F
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 08:38:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rv7OQzbQJASK for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 08:38:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 247F382803
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 08:38:09 +0000 (UTC)
IronPort-SDR: 4v2xiPMgj7Mi2HixxdQsnprT1DSeyWY7FngQWWbTDDscQZq7n9cO5WxVLW4sKbR1BWkYXKMXw+
 800M79YjSZnw==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="203536988"
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; d="scan'208";a="203536988"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2021 01:38:08 -0700
IronPort-SDR: 9rp6pOGsIEs8ILyyrY7eJ9xFu2Nl6QFFV0mqWywHwKYYFnEOBQRhOXhIxmQXVnIBt/FHLTIwb8
 WXnLo9Pbci+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; d="scan'208";a="446877303"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
 by fmsmga008.fm.intel.com with ESMTP; 01 Jun 2021 01:38:07 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 1 Jun 2021 01:38:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 1 Jun 2021 01:38:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 1 Jun 2021 01:38:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wmu3/f6VPMcRJqWI564bg8xdihNeDoEtra1wd4rG05g8W+bLtkXLajo8RRATAM4QfafI8oc2ZZN9xWvzr1vaYl+G9mmj4v9DpJlJcpaNW1H1EHh+j2A/4nerwTJRw1kPNJZn+mkKYgKDsBM3mGlE1wEc9EJmYrPS0tOA1CAHr/coOum4hbaMTqBHh/BCmYxjH6ZMoO7ybXX9XQ9/+8GZ+0jiIE5PQS//M7Xu3MxqP0Mc4Mxt+WWwIDVKqjTxsBeCXxNEQzIAIlldx3kH68KEWeZ0kbRL2mnYUgmwsqnQGL3+CYtRW9DKfzyFayqdoC3HXT2tGLAql24aFg8AbzO7WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1s+XpvQfIJOaOHcOGr/hS/vtPq3/S4uaLmSyveQ52k=;
 b=GBO3SJ/p7ev+bWTcctYsxa6nKQcUC1CTq0yNE1yZy9rZ5Hgs8PFCeAqA0e25Uk6fvKbB35UDNSL5g8yToYsAcOypGTVAg2IUI4t0mWrXF/gGfUOYMg+w2QlrqGwqytHtbgOHx1Kv6qT0og3EnZZyOVFA+zGtheu7Hmz0SzkSDVdWNXZOq9/t5v6pAUtz2JcfSwkueVkq2qaXbT1rnhYuyTmKypzBBkum4TkwX0eNsSYhiNSC84bkYKkfJY4eS3+gr6v93dFJdOxIV1RzT8GF5TnaGtscDzGsz2uq3IXjT/ferwl3peSFfO/iQl5EZs3avCo5pGo6aIM9U4PJcL2vVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1s+XpvQfIJOaOHcOGr/hS/vtPq3/S4uaLmSyveQ52k=;
 b=E9+Hao1tIhJ0Tg29zZAz/OhvZhCLwydsHuL18+ykrLhlc4O5OY5A0U+eLMBo/HBskasdBSmu+GCwcBLNhQ8dO317pU2PKv5BmwDvsyw3MowJmZgb00lblyOPdAN64kRs0Y2Jc8sweu+0bJKtmtx4ae4BEEsZDbIYOuD/Qqeqk6o=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR11MB1837.namprd11.prod.outlook.com (2603:10b6:300:10f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 1 Jun
 2021 08:38:01 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1%12]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 08:38:01 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [RFC] /dev/ioasid uAPI proposal
Thread-Topic: [RFC] /dev/ioasid uAPI proposal
Thread-Index: AddSzQ970oLnVHLeQca/ysPD8zMJZwBLsqGAALCWeVA=
Date: Tue, 1 Jun 2021 08:38:00 +0000
Message-ID: <MWHPR11MB1886A17F36CF744857C531148C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528195839.GO1002214@nvidia.com>
In-Reply-To: <20210528195839.GO1002214@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.142.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97a59c20-8036-4b93-4c88-08d924d890c5
x-ms-traffictypediagnostic: MWHPR11MB1837:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1837EE6279D8BF24DE21A7E78C3E9@MWHPR11MB1837.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +/mSFDpmGyNSZP8QRpp3cX4adfzDSuY1JNi4ag66SmJL/TrBDQOF7id/R1kSKfijfGX07Y2MDXGmDgr1f0y3BGLFsmhE4RqVzH+oJoGCqA75e6fsW8FS/jWjvMWrCkSizW1erCgScT//5WdqJbhCTlgYSL+QMQBF+2KTUPGJcUWWYdyDD6SIX7HEL0gcfxBPC9uObMAj53q6hPNk9gShoSjP0TY/49b9bUGr+P9TMWVvZsE+vBmddHDLFIvy8BG9Twa9Cdy/aBXH6ZCQxfx/KEN97o1pna9pp6L1u+1VG9aj0LQknV1lgn9JUz4DFQq4OWmey3I5cr8oXeN7kV2Dng2aGuMM2t8G0+3h1Xh1XdM03fsCfgsS2s5rv6mLhReoG8Agx12MXjHcCVuQ9ULhPBb806RXAFADdzD/45HKuBPY9V7t0FyvccfbklNeP0BwzUlnsaAaTeh5CcAmBeXvLuKW0xnmdlzsHNeFGsrqux1XCs/ZV48y2BHAXqhjBBFCaYBOaQMg75MPv15tCjb5X71T/BrtoECrOmw24nUxx5oPnbQHSyWwaJG+HxHU3ANxkKwciFZ9qxF276U9TdQIHQc973rlzIq/v0bFrFaTK3c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(136003)(396003)(376002)(346002)(39860400002)(6506007)(38100700002)(55016002)(33656002)(7416002)(5660300002)(71200400001)(9686003)(6916009)(7696005)(26005)(186003)(83380400001)(478600001)(122000001)(64756008)(30864003)(66446008)(76116006)(316002)(66946007)(8936002)(8676002)(2906002)(66556008)(66476007)(86362001)(54906003)(52536014)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?qu3J82PnHrSqrNSYjg6XMpnX3kGbYogZvfQ7ZKdXH94WxoLUNp/1+0XphYqV?=
 =?us-ascii?Q?Lx5E4DkG9zMTiMk21pVOOO3LOicYtBKXbujDYRZwierZxCuPFlV+Gh0Un2Qd?=
 =?us-ascii?Q?4VjowgZcV+Vzj+r7QfwSEWx0Ng5ryJkUaQOga0bnosGikIn/w5wVR66W8kmo?=
 =?us-ascii?Q?YQIqgWtTsvBAfXLNN2nVbomVvkE//NSc39fMpebgJAZeKiSI3dHzJ8WZIzcR?=
 =?us-ascii?Q?eCoQAJnnE+Lb5vToz7sMZGdwlfGRe3z7dRRgg1KY9fU1NziwhSOMYCH8kFnF?=
 =?us-ascii?Q?exh5TlfvY4eUGl17FRF4QSOuIAnS82JgKGgEhnJ6pM+5XNHm1esxHk0nxRoU?=
 =?us-ascii?Q?eNb7ca++A3yvCqPtjvPTtWyiFQ73jy6WarjiXcvRWvevmfykGA6Fl8YdM4og?=
 =?us-ascii?Q?8Ih3k0ARy9f6MZDybsKdBxzGVYOVcoQyrw1kPw35kvX20Q0kEIKtc/DqGJa2?=
 =?us-ascii?Q?GpFcMRp0gpSRzfXIlm2Y842paabdImD8x3c6EhcxvycBUfYQ8r+ZO7Q/mcRZ?=
 =?us-ascii?Q?q7nT9utJUiZfbbcWxsrrH93KtOim4D0lEVHYbsEUHHh8Re21d+5MRsDaS90P?=
 =?us-ascii?Q?JlNz0lVoA+XQP8/bRMDh7Efb0hcVDdvKDUG68mDO8XNllLd0SCFGRmNT9F3V?=
 =?us-ascii?Q?88aEitIdL+dbtSdfyDioHrV9mgr6zfoOQhrE0ri5T+cD+gU3st0e28UKIkds?=
 =?us-ascii?Q?j3Qn9Yp7yQJ4zDqCY+Uh4OHKHpLG0vyugv936wbxVRxe9XQuFN+OIcj0Svov?=
 =?us-ascii?Q?1BeJ2aOpUFSU2asecnIMc3QIp9Zh81aKauzOTnsmQlVxtaKW/mbudjqMCmh5?=
 =?us-ascii?Q?uxmXzsb3tv9J44S/0wxoISagViS5pLxjfdDLjTn0SZ9IpWH51rIQuKJP6TFK?=
 =?us-ascii?Q?8qC2OfeW4Etb98S2x7lQHKtufh+6n8Wlhbrvp1sKP9BK4ni8t8i/O9ID9YQy?=
 =?us-ascii?Q?9vJFHo2ab0pNIIBxduNY6PUizHdqhZYktdiwqx7ObplvQVRCjaqInQ6OXKKN?=
 =?us-ascii?Q?Z1YSVLk+4aZefiwcj+3EFUHYmNSWvJIrLAiAdymneRAWg0GkvGIYiPg9iRsm?=
 =?us-ascii?Q?HIbm15bvc6CdrHvfx57qjlYlj8gseGvwwss2iJS+r2Dk7GjLQx3uf6Hkge6l?=
 =?us-ascii?Q?k0DvQajs+A2RQb5cz26N2ARjKxSAp1hcuAO7hnx7XHxl7/DZsaSjXszR91fW?=
 =?us-ascii?Q?BavRx3yR/bJvrwr5oUYYb17bhkvqWHGmuhnKKUi1wjnzVMR4ljKLPyTt+6bm?=
 =?us-ascii?Q?zURkPoouCQ4ZgDPTqqMU38TEXe1pI4QcamZzJPDtDw+4918GPlRcJ4SIzgym?=
 =?us-ascii?Q?hpljbNg3SfRJ6XuE+EcIdbSz?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a59c20-8036-4b93-4c88-08d924d890c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 08:38:00.7452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C0znJX1JSXhvxOTN07h5xnAf1lE08d0bTCUReUuyNDTBsNt4YYcpPXGkjkiqK4skVvzDMSLMjkgeYwJ29eeWfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1837
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Alex Williamson
 \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Robin
 Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Gibson <david@gibson.dropbear.id.au>, "Jiang,
 Dave" <dave.jiang@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, May 29, 2021 3:59 AM
> 
> On Thu, May 27, 2021 at 07:58:12AM +0000, Tian, Kevin wrote:
> >
> > 5. Use Cases and Flows
> >
> > Here assume VFIO will support a new model where every bound device
> > is explicitly listed under /dev/vfio thus a device fd can be acquired w/o
> > going through legacy container/group interface. For illustration purpose
> > those devices are just called dev[1...N]:
> >
> > 	device_fd[1...N] = open("/dev/vfio/devices/dev[1...N]", mode);
> >
> > As explained earlier, one IOASID fd is sufficient for all intended use cases:
> >
> > 	ioasid_fd = open("/dev/ioasid", mode);
> >
> > For simplicity below examples are all made for the virtualization story.
> > They are representative and could be easily adapted to a non-virtualization
> > scenario.
> 
> For others, I don't think this is *strictly* necessary, we can
> probably still get to the device_fd using the group_fd and fit in
> /dev/ioasid. It does make the rest of this more readable though.

Jason, want to confirm here. Per earlier discussion we remain an
impression that you want VFIO to be a pure device driver thus
container/group are used only for legacy application. From this
comment are you suggesting that VFIO can still keep container/
group concepts and user just deprecates the use of vfio iommu
uAPI (e.g. VFIO_SET_IOMMU) by using /dev/ioasid (which has
a simple policy that an IOASID will reject cmd if partially-attached 
group exists)?

> 
> 
> > Three types of IOASIDs are considered:
> >
> > 	gpa_ioasid[1...N]: 	for GPA address space
> > 	giova_ioasid[1...N]:	for guest IOVA address space
> > 	gva_ioasid[1...N]:	for guest CPU VA address space
> >
> > At least one gpa_ioasid must always be created per guest, while the other
> > two are relevant as far as vIOMMU is concerned.
> >
> > Examples here apply to both pdev and mdev, if not explicitly marked out
> > (e.g. in section 5.5). VFIO device driver in the kernel will figure out the
> > associated routing information in the attaching operation.
> >
> > For illustration simplicity, IOASID_CHECK_EXTENSION and IOASID_GET_
> > INFO are skipped in these examples.
> >
> > 5.1. A simple example
> > ++++++++++++++++++
> >
> > Dev1 is assigned to the guest. One gpa_ioasid is created. The GPA address
> > space is managed through DMA mapping protocol:
> >
> > 	/* Bind device to IOASID fd */
> > 	device_fd = open("/dev/vfio/devices/dev1", mode);
> > 	ioasid_fd = open("/dev/ioasid", mode);
> > 	ioctl(device_fd, VFIO_BIND_IOASID_FD, ioasid_fd);
> >
> > 	/* Attach device to IOASID */
> > 	gpa_ioasid = ioctl(ioasid_fd, IOASID_ALLOC);
> > 	at_data = { .ioasid = gpa_ioasid};
> > 	ioctl(device_fd, VFIO_ATTACH_IOASID, &at_data);
> >
> > 	/* Setup GPA mapping */
> > 	dma_map = {
> > 		.ioasid	= gpa_ioasid;
> > 		.iova	= 0;		// GPA
> > 		.vaddr	= 0x40000000;	// HVA
> > 		.size	= 1GB;
> > 	};
> > 	ioctl(ioasid_fd, IOASID_DMA_MAP, &dma_map);
> >
> > If the guest is assigned with more than dev1, user follows above sequence
> > to attach other devices to the same gpa_ioasid i.e. sharing the GPA
> > address space cross all assigned devices.
> 
> eg
> 
>  	device2_fd = open("/dev/vfio/devices/dev1", mode);
>  	ioctl(device2_fd, VFIO_BIND_IOASID_FD, ioasid_fd);
>  	ioctl(device2_fd, VFIO_ATTACH_IOASID, &at_data);
> 
> Right?

Exactly, except a small typo ('dev1' -> 'dev2'). :)

> 
> >
> > 5.2. Multiple IOASIDs (no nesting)
> > ++++++++++++++++++++++++++++
> >
> > Dev1 and dev2 are assigned to the guest. vIOMMU is enabled. Initially
> > both devices are attached to gpa_ioasid. After boot the guest creates
> > an GIOVA address space (giova_ioasid) for dev2, leaving dev1 in pass
> > through mode (gpa_ioasid).
> >
> > Suppose IOASID nesting is not supported in this case. Qemu need to
> > generate shadow mappings in userspace for giova_ioasid (like how
> > VFIO works today).
> >
> > To avoid duplicated locked page accounting, it's recommended to pre-
> > register the virtual address range that will be used for DMA:
> >
> > 	device_fd1 = open("/dev/vfio/devices/dev1", mode);
> > 	device_fd2 = open("/dev/vfio/devices/dev2", mode);
> > 	ioasid_fd = open("/dev/ioasid", mode);
> > 	ioctl(device_fd1, VFIO_BIND_IOASID_FD, ioasid_fd);
> > 	ioctl(device_fd2, VFIO_BIND_IOASID_FD, ioasid_fd);
> >
> > 	/* pre-register the virtual address range for accounting */
> > 	mem_info = { .vaddr = 0x40000000; .size = 1GB };
> > 	ioctl(ioasid_fd, IOASID_REGISTER_MEMORY, &mem_info);
> >
> > 	/* Attach dev1 and dev2 to gpa_ioasid */
> > 	gpa_ioasid = ioctl(ioasid_fd, IOASID_ALLOC);
> > 	at_data = { .ioasid = gpa_ioasid};
> > 	ioctl(device_fd1, VFIO_ATTACH_IOASID, &at_data);
> > 	ioctl(device_fd2, VFIO_ATTACH_IOASID, &at_data);
> >
> > 	/* Setup GPA mapping */
> > 	dma_map = {
> > 		.ioasid	= gpa_ioasid;
> > 		.iova	= 0; 		// GPA
> > 		.vaddr	= 0x40000000;	// HVA
> > 		.size	= 1GB;
> > 	};
> > 	ioctl(ioasid_fd, IOASID_DMA_MAP, &dma_map);
> >
> > 	/* After boot, guest enables an GIOVA space for dev2 */
> > 	giova_ioasid = ioctl(ioasid_fd, IOASID_ALLOC);
> >
> > 	/* First detach dev2 from previous address space */
> > 	at_data = { .ioasid = gpa_ioasid};
> > 	ioctl(device_fd2, VFIO_DETACH_IOASID, &at_data);
> >
> > 	/* Then attach dev2 to the new address space */
> > 	at_data = { .ioasid = giova_ioasid};
> > 	ioctl(device_fd2, VFIO_ATTACH_IOASID, &at_data);
> >
> > 	/* Setup a shadow DMA mapping according to vIOMMU
> > 	  * GIOVA (0x2000) -> GPA (0x1000) -> HVA (0x40001000)
> > 	  */
> 
> Here "shadow DMA" means relay the guest's vIOMMU page tables to the HW
> IOMMU?

'shadow' means the merged mapping: GIOVA(0x2000) -> HVA (0x40001000)

> 
> > 	dma_map = {
> > 		.ioasid	= giova_ioasid;
> > 		.iova	= 0x2000; 	// GIOVA
> > 		.vaddr	= 0x40001000;	// HVA
> 
> eg HVA came from reading the guest's page tables and finding it wanted
> GPA 0x1000 mapped to IOVA 0x2000?

yes

> 
> 
> > 5.3. IOASID nesting (software)
> > +++++++++++++++++++++++++
> >
> > Same usage scenario as 5.2, with software-based IOASID nesting
> > available. In this mode it is the kernel instead of user to create the
> > shadow mapping.
> >
> > The flow before guest boots is same as 5.2, except one point. Because
> > giova_ioasid is nested on gpa_ioasid, locked accounting is only
> > conducted for gpa_ioasid. So it's not necessary to pre-register virtual
> > memory.
> >
> > To save space we only list the steps after boots (i.e. both dev1/dev2
> > have been attached to gpa_ioasid before guest boots):
> >
> > 	/* After boots */
> > 	/* Make GIOVA space nested on GPA space */
> > 	giova_ioasid = ioctl(ioasid_fd, IOASID_CREATE_NESTING,
> > 				gpa_ioasid);
> >
> > 	/* Attach dev2 to the new address space (child)
> > 	  * Note dev2 is still attached to gpa_ioasid (parent)
> > 	  */
> > 	at_data = { .ioasid = giova_ioasid};
> > 	ioctl(device_fd2, VFIO_ATTACH_IOASID, &at_data);
> >
> > 	/* Setup a GIOVA->GPA mapping for giova_ioasid, which will be
> > 	  * merged by the kernel with GPA->HVA mapping of gpa_ioasid
> > 	  * to form a shadow mapping.
> > 	  */
> > 	dma_map = {
> > 		.ioasid	= giova_ioasid;
> > 		.iova	= 0x2000;	// GIOVA
> > 		.vaddr	= 0x1000;	// GPA
> > 		.size	= 4KB;
> > 	};
> > 	ioctl(ioasid_fd, IOASID_DMA_MAP, &dma_map);
> 
> And in this version the kernel reaches into the parent IOASID's page
> tables to translate 0x1000 to 0x40001000 to physical page? So we
> basically remove the qemu process address space entirely from this
> translation. It does seem convenient

yes.

> 
> > 5.4. IOASID nesting (hardware)
> > +++++++++++++++++++++++++
> >
> > Same usage scenario as 5.2, with hardware-based IOASID nesting
> > available. In this mode the pgtable binding protocol is used to
> > bind the guest IOVA page table with the IOMMU:
> >
> > 	/* After boots */
> > 	/* Make GIOVA space nested on GPA space */
> > 	giova_ioasid = ioctl(ioasid_fd, IOASID_CREATE_NESTING,
> > 				gpa_ioasid);
> >
> > 	/* Attach dev2 to the new address space (child)
> > 	  * Note dev2 is still attached to gpa_ioasid (parent)
> > 	  */
> > 	at_data = { .ioasid = giova_ioasid};
> > 	ioctl(device_fd2, VFIO_ATTACH_IOASID, &at_data);
> >
> > 	/* Bind guest I/O page table  */
> > 	bind_data = {
> > 		.ioasid	= giova_ioasid;
> > 		.addr	= giova_pgtable;
> > 		// and format information
> > 	};
> > 	ioctl(ioasid_fd, IOASID_BIND_PGTABLE, &bind_data);
> 
> I really think you need to use consistent language. Things that
> allocate a new IOASID should be calle IOASID_ALLOC_IOASID. If multiple
> IOCTLs are needed then it is IOASID_ALLOC_IOASID_PGTABLE, etc.
> alloc/create/bind is too confusing.
> 
> > 5.5. Guest SVA (vSVA)
> > ++++++++++++++++++
> >
> > After boots the guest further create a GVA address spaces (gpasid1) on
> > dev1. Dev2 is not affected (still attached to giova_ioasid).
> >
> > As explained in section 4, user should avoid expose ENQCMD on both
> > pdev and mdev.
> >
> > The sequence applies to all device types (being pdev or mdev), except
> > one additional step to call KVM for ENQCMD-capable mdev:
> >
> > 	/* After boots */
> > 	/* Make GVA space nested on GPA space */
> > 	gva_ioasid = ioctl(ioasid_fd, IOASID_CREATE_NESTING,
> > 				gpa_ioasid);
> >
> > 	/* Attach dev1 to the new address space and specify vPASID */
> > 	at_data = {
> > 		.ioasid		= gva_ioasid;
> > 		.flag 		= IOASID_ATTACH_USER_PASID;
> > 		.user_pasid	= gpasid1;
> > 	};
> > 	ioctl(device_fd1, VFIO_ATTACH_IOASID, &at_data);
> 
> Still a little unsure why the vPASID is here not on the gva_ioasid. Is
> there any scenario where we want different vpasid's for the same
> IOASID? I guess it is OK like this. Hum.

Yes, it's completely sane that the guest links a I/O page table to 
different vpasids on dev1 and dev2. The IOMMU doesn't mandate
that when multiple devices share an I/O page table they must use
the same PASID#. 

> 
> > 	/* if dev1 is ENQCMD-capable mdev, update CPU PASID
> > 	  * translation structure through KVM
> > 	  */
> > 	pa_data = {
> > 		.ioasid_fd	= ioasid_fd;
> > 		.ioasid		= gva_ioasid;
> > 		.guest_pasid	= gpasid1;
> > 	};
> > 	ioctl(kvm_fd, KVM_MAP_PASID, &pa_data);
> 
> Make sense
> 
> > 	/* Bind guest I/O page table  */
> > 	bind_data = {
> > 		.ioasid	= gva_ioasid;
> > 		.addr	= gva_pgtable1;
> > 		// and format information
> > 	};
> > 	ioctl(ioasid_fd, IOASID_BIND_PGTABLE, &bind_data);
> 
> Again I do wonder if this should just be part of alloc_ioasid. Is
> there any reason to split these things? The only advantage to the
> split is the device is known, but the device shouldn't impact
> anything..

I summarized this as open#4 in another mail for focused discussion.

> 
> > 5.6. I/O page fault
> > +++++++++++++++
> >
> > (uAPI is TBD. Here is just about the high-level flow from host IOMMU driver
> > to guest IOMMU driver and backwards).
> >
> > -   Host IOMMU driver receives a page request with raw fault_data {rid,
> >     pasid, addr};
> >
> > -   Host IOMMU driver identifies the faulting I/O page table according to
> >     information registered by IOASID fault handler;
> >
> > -   IOASID fault handler is called with raw fault_data (rid, pasid, addr),
> which
> >     is saved in ioasid_data->fault_data (used for response);
> >
> > -   IOASID fault handler generates an user fault_data (ioasid, addr), links it
> >     to the shared ring buffer and triggers eventfd to userspace;
> 
> Here rid should be translated to a labeled device and return the
> device label from VFIO_BIND_IOASID_FD. Depending on how the device
> bound the label might match to a rid or to a rid,pasid

Yes, I acknowledged this input from you and Jean about page fault and 
bind_pasid_table. I summarized it as open#3 in another mail.

thus following is skipped...

Thanks
Kevin

> 
> > -   Upon received event, Qemu needs to find the virtual routing information
> >     (v_rid + v_pasid) of the device attached to the faulting ioasid. If there are
> >     multiple, pick a random one. This should be fine since the purpose is to
> >     fix the I/O page table on the guest;
> 
> The device label should fix this
> 
> > -   Qemu finds the pending fault event, converts virtual completion data
> >     into (ioasid, response_code), and then calls a /dev/ioasid ioctl to
> >     complete the pending fault;
> >
> > -   /dev/ioasid finds out the pending fault data {rid, pasid, addr} saved in
> >     ioasid_data->fault_data, and then calls iommu api to complete it with
> >     {rid, pasid, response_code};
> 
> So resuming a fault on an ioasid will resume all devices pending on
> the fault?
> 
> > 5.7. BIND_PASID_TABLE
> > ++++++++++++++++++++
> >
> > PASID table is put in the GPA space on some platform, thus must be
> updated
> > by the guest. It is treated as another user page table to be bound with the
> > IOMMU.
> >
> > As explained earlier, the user still needs to explicitly bind every user I/O
> > page table to the kernel so the same pgtable binding protocol (bind, cache
> > invalidate and fault handling) is unified cross platforms.
> >
> > vIOMMUs may include a caching mode (or paravirtualized way) which,
> once
> > enabled, requires the guest to invalidate PASID cache for any change on the
> > PASID table. This allows Qemu to track the lifespan of guest I/O page tables.
> >
> > In case of missing such capability, Qemu could enable write-protection on
> > the guest PASID table to achieve the same effect.
> >
> > 	/* After boots */
> > 	/* Make vPASID space nested on GPA space */
> > 	pasidtbl_ioasid = ioctl(ioasid_fd, IOASID_CREATE_NESTING,
> > 				gpa_ioasid);
> >
> > 	/* Attach dev1 to pasidtbl_ioasid */
> > 	at_data = { .ioasid = pasidtbl_ioasid};
> > 	ioctl(device_fd1, VFIO_ATTACH_IOASID, &at_data);
> >
> > 	/* Bind PASID table */
> > 	bind_data = {
> > 		.ioasid	= pasidtbl_ioasid;
> > 		.addr	= gpa_pasid_table;
> > 		// and format information
> > 	};
> > 	ioctl(ioasid_fd, IOASID_BIND_PASID_TABLE, &bind_data);
> >
> > 	/* vIOMMU detects a new GVA I/O space created */
> > 	gva_ioasid = ioctl(ioasid_fd, IOASID_CREATE_NESTING,
> > 				gpa_ioasid);
> >
> > 	/* Attach dev1 to the new address space, with gpasid1 */
> > 	at_data = {
> > 		.ioasid		= gva_ioasid;
> > 		.flag 		= IOASID_ATTACH_USER_PASID;
> > 		.user_pasid	= gpasid1;
> > 	};
> > 	ioctl(device_fd1, VFIO_ATTACH_IOASID, &at_data);
> >
> > 	/* Bind guest I/O page table. Because SET_PASID_TABLE has been
> > 	  * used, the kernel will not update the PASID table. Instead, just
> > 	  * track the bound I/O page table for handling invalidation and
> > 	  * I/O page faults.
> > 	  */
> > 	bind_data = {
> > 		.ioasid	= gva_ioasid;
> > 		.addr	= gva_pgtable1;
> > 		// and format information
> > 	};
> > 	ioctl(ioasid_fd, IOASID_BIND_PGTABLE, &bind_data);
> 
> I still don't quite get the benifit from doing this.
> 
> The idea to create an all PASID IOASID seems to work better with less
> fuss on HW that is directly parsing the guest's PASID table.
> 
> Cache invalidate seems easy enough to support
> 
> Fault handling needs to return the (ioasid, device_label, pasid) when
> working with this kind of ioasid.
> 
> It is true that it does create an additional flow qemu has to
> implement, but it does directly mirror the HW.
> 
> Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
