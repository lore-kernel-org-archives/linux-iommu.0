Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99EAFC43334
	for <iommu@archiver.kernel.org>; Mon, 27 Jun 2022 07:22:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 21F0540BC5;
	Mon, 27 Jun 2022 07:22:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 21F0540BC5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g432pJ3J
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XJyLrVc8Y3IK; Mon, 27 Jun 2022 07:22:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D4B9940393;
	Mon, 27 Jun 2022 07:22:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D4B9940393
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EC90C0032;
	Mon, 27 Jun 2022 07:22:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13060C002D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 07:22:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D9C188282C
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 07:22:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D9C188282C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=g432pJ3J
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VaXOJ6_Ee0fY for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 07:22:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 112EB82846
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 112EB82846
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 07:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656314532; x=1687850532;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wm8lGawPGwKXVM5N3MtjWYUSxK6dJzCz0M7c5ZlGkag=;
 b=g432pJ3JEjcW7krHqtpFhjVaxaaz3N59qg2HNDuP9SfYtF/p56J3vbsm
 tgiTSVkWRgQX+Lv6J/57I8NYJdcAq0sqBGfhAy+pOSfJ6XBxCmMaF56QA
 J/WGujf4BAb1IU5F/cuw8xTaFPNmOd5r4VxQuQqExqvGSzFcbqBdq8rj8
 fMO6+ikf1oGeJFYoKXP0IuP7N3JGoekmp33QrnJOtsvjvXIVBJXg/bGxD
 7N6Z8KevwT3U3vQNjKYQg6Io5IA9ip5Si1aBhZATCjo9fbDlpSdybqdf0
 Swd8CPzsVWXz60wW7s0mNwMAs1IOWnykS5udI3Mu34Jj442DkEo5MSpq2 Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="278925951"
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; d="scan'208";a="278925951"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2022 00:22:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; d="scan'208";a="732205095"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
 by fmsmga001.fm.intel.com with ESMTP; 27 Jun 2022 00:22:10 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 00:22:09 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 00:22:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 27 Jun 2022 00:22:09 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 27 Jun 2022 00:22:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccfHqmhIAg+/kgFo3gykRNpImGcK/fJd1S3m9PTb77hhzr3yNllNZrOSfBmoXmfVTFwotpjshv481XJVRHbpTZ2mKWreGtiOMrg4J3l0SwUlin8R9jQjfMIplcIUsAGUcCBOAouOI5O0W+cr39qGpuWRhKh+gN4aT2woHlOkr3aUTgXHBvKw3PjSyrVulUtAo4O5W6wZnJo56nsYZeVWkl1oK+TNQ5b5sXfqSKv1Fo0/4bdDAxuNLFrZekISbQHHJMUPw1qFbXGZOki/yRj/xUq3X14RTxVJLJMJZfh5pkcr4bLMOd5uiGXlzltwLkQw+84rcNJ4cDQfdNyZjN7ROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wm8lGawPGwKXVM5N3MtjWYUSxK6dJzCz0M7c5ZlGkag=;
 b=S2gmfaFEggQHlQPbM8/WnowFGzJ0ywZ8L81f8yTlr1FSfUTpAs3oK0+kpcW9iQbVxXaWyIs9p8JVmjDXrNGyTdzGN4BRP5zSYcT0pEoDLSjXn662BYWDA7d1JHwT2PDxlbgjcbAPq3SaO0FH/7ETe7ndMb+Q+xQ5mQkcHHdGKavni0d1r24l1gnDCTSWFUJHQprCOkd1oCpg7r+NZo46NN7Zgi/HqSnBl+za5cRln0oKBWmSevwpJY6Hf/800Ynwm6jz7rXJb5K+D+Ka6R1MZTTLOh/DyTDxDDb2MeIfc0ExTEc2oyNuAltA2UkyMij76b1FOanq/lmVCr6pDAlt4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB3857.namprd11.prod.outlook.com (2603:10b6:405:79::39)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 07:22:07 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 07:22:07 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Robin Murphy <robin.murphy@arm.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>
Subject: RE: [PATCH v3 1/2] vfio/type1: Simplify bus_type determination
Thread-Topic: [PATCH v3 1/2] vfio/type1: Simplify bus_type determination
Thread-Index: AQHYh/MiOMv1UzvDHUeZR2Lv9Y48Tq1i3RxA
Date: Mon, 27 Jun 2022 07:22:07 +0000
Message-ID: <BN9PR11MB5276DDDEED386F6BCDACBAAE8CB99@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <194a12d3434d7b38f84fa96503c7664451c8c395.1656092606.git.robin.murphy@arm.com>
In-Reply-To: <194a12d3434d7b38f84fa96503c7664451c8c395.1656092606.git.robin.murphy@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7dc293c0-5ba7-43a4-8cb4-08da580dbe5d
x-ms-traffictypediagnostic: BN6PR11MB3857:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l/dwEkZSYMcIj4A+ZYHi3ig7iCXkqUYPyHzKPjt6RguijHeuh6W2zQCJd1szirrynrYHwuFObbbNbeuZKQZZ7xyDEThChWAA1tKb54l7lLiii4FVRhPeTTySgobK7VwTFi4QU1JriIcKStddwC9KlUEW9eozCMLVigvkYSKeI15L9d7S1w8gPVluxzDRzjlxsxqW8WlizEyCVrw4jP5f6e6zVTevMWCkcNO0tn7q35lM5h7qJBLkUOV5aDYgz34hNeMtvEVdhoINkXoU3ZU1agBKYbLxxY2sBPhzWr1LBjHBQFh3Or3AIyWa9n76s+IvCmp1IplJJwjJFJ7y/Q9u+yZ4dTS1vp3qRlJQbz8eMERyM+70m3Ov3k5WaUc98gWDieCk5VJHpmUKaQj8YVyHBcALdbfMQRMQBg223/1YrDJmOs26GNfOvNehqJge9KtpJXeZLn1qyl2/WW4XrMQEkwnBei0yFZdDyFC/UIGJ+XjMuHVvZG/DSuoU8WNSjeDH7E4qY9S70sbxHHzxyiosUBWZlLK4VgihhdX8p0m3fcm7K5NYqicDo8g/azvNQm4mCT4vQDT4Z6RKGKgPbbCtFZvzt1y8Yd9MPz9dPKWD6AQOYfYDfLlNj89nMPWG86ovlSwzxwY+xtrF56o223Apzno2foSUfZ0peqSKgoPDJkYKyknsXKo5ry3hYG+CLPzwlGOP56z67HTknjDnJpjIvsgNc6n9VcwCUnaQ2dUyHLlIGcVcQ6TAvo0ZLequEK9LHaZhqJaTINLMnqeOIQCxcZBmHKWqAH991NRsXqZsPJ8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(376002)(366004)(136003)(39860400002)(346002)(396003)(38100700002)(122000001)(186003)(55016003)(8936002)(316002)(5660300002)(54906003)(110136005)(83380400001)(26005)(9686003)(66946007)(82960400001)(86362001)(64756008)(66446008)(38070700005)(52536014)(66556008)(66476007)(478600001)(71200400001)(8676002)(4326008)(41300700001)(2906002)(76116006)(7696005)(33656002)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Og2L/RwuhF+NcTB65f2m4zEQmsEWUp2dhJ5+hHt0B+HsEaM0BkDO1uhmKFl2?=
 =?us-ascii?Q?0F7XGgnRmFCPCbiDzgsu9HxrIR6sZ+wiKvUQzKMNoOQQs4WYe5Au81EPtycv?=
 =?us-ascii?Q?4caDZxKmS/t7shUGWQUPzG4gULuf8wRdTWLVPWlJF/jFT+bHvKO8jNt+UpNr?=
 =?us-ascii?Q?OV6zkz7LAoc5mHRHOWs5dx+PWfCWFlQrCq7S76Lpov1DDaZWeNMAEJnLn20K?=
 =?us-ascii?Q?wwb76LZYA4oGeNHdYsB4fXFU449XZnaFyC+O55QqjmhkjEeHTfrXkxhwTxIs?=
 =?us-ascii?Q?RGkSNhNkoohSqUA0g2c448xvHtVwfh3FQVZLMABYAr3sXG6CIRMzz4s0Byzx?=
 =?us-ascii?Q?zpEFcVInjicy3FY766a/PUVTEXiuT99kGfbDmcH2TbgQ3Yf/9YdH8zX4/od4?=
 =?us-ascii?Q?p+vhtF3MfwL/fGG68iWim3JGrnQOGmf9T+Qk2OmwsC9PJKZN9UyHcksWZw2M?=
 =?us-ascii?Q?U/GZ72icfrsnM2tpWUqx0+tyVs9/GrvUXFUeT4yBd7eLmOk0EDBSy7EmjPcJ?=
 =?us-ascii?Q?6BzUcOgS3Ux69CvBiEHfREBfDf79uKgdCTvca7tuxJjb5fcNxb5phWOM+K4o?=
 =?us-ascii?Q?J6lDBTcmeDivklEi4cyiGCKEk8gW3hdxNdbnrvNyUekn+DZkYI6eB3cxNSSl?=
 =?us-ascii?Q?H+lbSxhJBUucOFP4GomlwcribKUgJzrTIhbaGLxZL0vPU6QOomwK2pYgoPKQ?=
 =?us-ascii?Q?dtrFIkvhO/ygf4J3xeqsJGv2JiASqn1720qfoB3hLglurPwGpk5K+yAfFLh+?=
 =?us-ascii?Q?21h93fQnFxiqGYxFlw/k6ExjTS1tkOGYxk9Dqx8bYtIb2Bd77qos7+9iLPfQ?=
 =?us-ascii?Q?rodt0ui8h891nog/bwHWx2dk9Ow6Vps2+/QSJhoKPmqsFeI2o3DaUY2Bv3Rr?=
 =?us-ascii?Q?gBMIY9bL4ywA1zv/hXB+I+F9R4MuBjtj1LWnuC/IzStcv5oy/xLxtZE1EjEe?=
 =?us-ascii?Q?duyyenOoEo2nR4swfc1pJasP/CVkjCPLEwkaOUnAdlvarl0ffPveVjIeZawx?=
 =?us-ascii?Q?899ycPjtD5k36zaiqt1/EPQi3Jdv8sRm3QGdDU+gyAKmTIQKaRhi6vmLqZwD?=
 =?us-ascii?Q?1gIkQ8st/wtFPit3GrHnd3aDxQ+bBRqAYKzeDD1l7ugX9pp7WpuGiFpcrzo8?=
 =?us-ascii?Q?lpSUM7FZHfhuOLKnCgsp/GsFUUJntcyimab48TXTiRjeJbVKEHU7K8OG24No?=
 =?us-ascii?Q?USzrQsyuqpOYXZ4dQgvHoIZXTE41Eov6DEdcaWSgKCydOdua6rTSo+U936/F?=
 =?us-ascii?Q?LjDZunTHBnbqgUTf4fmEiWNdy94CWog4X4O6Dvg+hZsshh3OY0Fh9/vyCWVp?=
 =?us-ascii?Q?9lRFawxWwH6JNXv20uaMe2QRyofBKofbQE8RaR5H1Xr6yTfaKndT6kHVl2zB?=
 =?us-ascii?Q?5kHRDW4Hz4vpt/7mVj8lnSOeb1ogjY/pOpfGxnsNlzFbihDka2TWSNM93HKV?=
 =?us-ascii?Q?abuBL/B0arNxMXpJDNxX+23opyr2zi4JUnPWxw0/wGEd0ox2Z7ohAlCBtvWf?=
 =?us-ascii?Q?zjIOogw5FHjXHirdDbqcKpXKKIvtGogo7MPk3WlubBipy2k/gKCCtxholO/A?=
 =?us-ascii?Q?DhF5hdwU5npPxHHaYS90552Jvgt8rabqQ8ND0Lty?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc293c0-5ba7-43a4-8cb4-08da580dbe5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 07:22:07.7342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yOHoQ80a6Q5sWmnfS2Ozv1QTcohC7ghErwsr0Lkts7o4uI4UeadU1VB9VYGEIAJwTFGWQrIxuv0lmYU2Qm6etA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3857
X-OriginatorOrg: intel.com
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "jgg@nvidia.com" <jgg@nvidia.com>
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

> From: Robin Murphy
> Sent: Saturday, June 25, 2022 1:52 AM
> 
> Since IOMMU groups are mandatory for drivers to support, it stands to
> reason that any device which has been successfully added to a group
> must be on a bus supported by that IOMMU driver, and therefore a domain
> viable for any device in the group must be viable for all devices in
> the group. This already has to be the case for the IOMMU API's internal
> default domain, for instance. Thus even if the group contains devices on
> different buses, that can only mean that the IOMMU driver actually
> supports such an odd topology, and so without loss of generality we can
> expect the bus type of any device in a group to be suitable for IOMMU
> API calls.
> 
> Furthermore, scrutiny reveals a lack of protection for the bus being
> removed while vfio_iommu_type1_attach_group() is using it; the reference
> that VFIO holds on the iommu_group ensures that data remains valid, but
> does not prevent the group's membership changing underfoot.
> 
> We can address both concerns by recycling vfio_bus_type() into some
> superficially similar logic to indirect the IOMMU API calls themselves.
> Each call is thus protected from races by the IOMMU group's own locking,
> and we no longer need to hold group-derived pointers beyond that scope.
> It also gives us an easy path for the IOMMU API's migration of bus-based
> interfaces to device-based, of which we can already take the first step
> with device_iommu_capable(). As with domains, any capability must in
> practice be consistent for devices in a given group - and after all it's
> still the same capability which was expected to be consistent across an
> entire bus! - so there's no need for any complicated validation.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v3: Complete rewrite yet again, and finally it doesn't feel like we're
> stretching any abstraction boundaries the wrong way, and the diffstat
> looks right too. I did think about embedding IOMMU_CAP_INTR_REMAP
> directly in the callback, but decided I like the consistency of minimal
> generic wrappers. And yes, if the capability isn't supported then it
> does end up getting tested for the whole group, but meh, it's harmless.
> 

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
