Return-Path: <SRS0=DKTI=FZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C822C433E0
	for <iommu@archiver.kernel.org>; Mon, 21 Dec 2020 03:17:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A548722D02
	for <iommu@archiver.kernel.org>; Mon, 21 Dec 2020 03:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A548722D02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 463BA2E3E5;
	Mon, 21 Dec 2020 03:17:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LT48Sd75FZu7; Mon, 21 Dec 2020 03:17:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5115C20768;
	Mon, 21 Dec 2020 03:17:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4776AC1787;
	Mon, 21 Dec 2020 03:17:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1EB87C0893
 for <iommu@lists.linux-foundation.org>; Mon, 21 Dec 2020 01:43:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 02A2F2048E
 for <iommu@lists.linux-foundation.org>; Mon, 21 Dec 2020 01:43:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WK64gxkAKo0N for <iommu@lists.linux-foundation.org>;
 Mon, 21 Dec 2020 01:43:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by silver.osuosl.org (Postfix) with ESMTPS id 1F9C020489
 for <iommu@lists.linux-foundation.org>; Mon, 21 Dec 2020 01:43:44 +0000 (UTC)
IronPort-SDR: AjXw1bQTu90sqmBfbaNKvyiD7ffqikvEfJTmjdstvKebH7VpNDiuaAl3B5YDPb006LTOafs6Nt
 f7ufllEhMowA==
X-IronPort-AV: E=McAfee;i="6000,8403,9841"; a="163391868"
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; d="scan'208";a="163391868"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Dec 2020 17:43:43 -0800
IronPort-SDR: F2gsnOzQNeodgYOSX3JdpvbEE3BBmXW62rdIzKiD8fHzXqoIbX5j5xRONQxWwv+IC0V8DByJZf
 ieRBu1BQiaOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; d="scan'208";a="342234717"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga008.fm.intel.com with ESMTP; 20 Dec 2020 17:43:42 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 20 Dec 2020 17:43:42 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 20 Dec 2020 17:43:42 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.56) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 20 Dec 2020 17:43:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmFYh7qJdWCa/hVNRJrqZcumqhCZTvVPwDmGbeq87qRV0WMAE2EIB/41ngJz5QHNuKcJR26KY5E/m+1dvDs9dblx4I/npyCmDkG9lODZlIpzieWh/xNnxNq1zZkcGSD9JerXjPIuP0aeBbng1xdhuTP3MkkXcKMfAFLjE8wyXN7Tq5KVgym29AK6dnjLW51nPySw1Z/m8umtN7aT2JW3X2Yi1q3PBnYZxt4ZG1hBi3ouiOZUZRzHgFAnrwYY0yOGgooE861iQBrhjnQ948+uUlQ7b77Mzc9NkiSGZa2k2egfU5N1D2mcYLdEHASzRi+xtVdamoebcgQLvmK6Llkz8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfKl1KNrMYG8cVCIYoKsvXT32Rz1ENuHYM/Gp2eyg6E=;
 b=TOo7+uhDZjI8IrDS5xN9MCrOQHxUV40+eYd0BA/w8TmgiBgyCI3lP2RlNZYyH02wMopTI5G+mKjnRGvw59XYdxfeq3x8B6mnasAZdzuSsR+Dbb8Ph8syLIiB8QxqNjVmgWSEn5oeppJpgTuAc7Bh6HG9qw7PCJWdTqMWdhA8cWsvKx2Z7QLr11HcUPz4RDbB3Epz4mqW3GGXGq1VtFqYUyjSWuSO0StqWHU3zdqAmG/K3lth8XWOSTlrK7MYPh5khmCsKOUXJfCMvfD2+VOegnDsVHOnyKjqo+2ZkUcB82HnuumGW1IvM5kKQYsljZLL2QvWyQnMYRHzBGAuMB3GxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfKl1KNrMYG8cVCIYoKsvXT32Rz1ENuHYM/Gp2eyg6E=;
 b=modKi7EWIKT+lEdLlms14Se1ZfOuwpwKkOvkVMqWDzPhI2EB8TjD+BD9f9NWA2MhXs11bAqnycASYKbnJUf5yGAkrYfcr08txzfoaOmAQ5hfTb2X99PgH/E2ZopQ/gVCVm0DeUx8nLrB3s1MnWgSvw/J4TlNRs2LTV3K3y5C7wo=
Received: from DM6PR11MB2745.namprd11.prod.outlook.com (2603:10b6:5:c7::31) by
 DM6PR11MB3612.namprd11.prod.outlook.com (2603:10b6:5:13b::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.25; Mon, 21 Dec 2020 01:43:40 +0000
Received: from DM6PR11MB2745.namprd11.prod.outlook.com
 ([fe80::5f6:e837:1cf7:55ea]) by DM6PR11MB2745.namprd11.prod.outlook.com
 ([fe80::5f6:e837:1cf7:55ea%5]) with mapi id 15.20.3676.025; Mon, 21 Dec 2020
 01:43:40 +0000
From: "Guo, Kaijie" <kaijie.guo@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Zeng, Xin" <xin.zeng@intel.com>, 
 "will@kernel.org" <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH 1/3] iommu/vt-d: Move intel_iommu info from struct
 intel_svm to struct intel_svm_dev
Thread-Topic: [PATCH 1/3] iommu/vt-d: Move intel_iommu info from struct
 intel_svm to struct intel_svm_dev
Thread-Index: AQHW1ZqFNDg7NHC2Ykmhw3s0PwH9JKn9+yyAgALOokA=
Date: Mon, 21 Dec 2020 01:43:39 +0000
Message-ID: <DM6PR11MB274554562E9C49530AB07F1999C00@DM6PR11MB2745.namprd11.prod.outlook.com>
References: <20201220000352.183523-1-yi.l.liu@intel.com>
 <20201220000352.183523-2-yi.l.liu@intel.com>
 <e0761970-3151-ac82-51c4-94cdd2a43ce4@linux.intel.com>
In-Reply-To: <e0761970-3151-ac82-51c4-94cdd2a43ce4@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [61.129.101.28]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a84d0d60-b5fb-4d9f-c707-08d8a551d7a5
x-ms-traffictypediagnostic: DM6PR11MB3612:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB36120099F4F20802457E0FE999C00@DM6PR11MB3612.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: grkB01C+XD/JNr697wEwes0pIzrECZv6uuvLKHUjk92SlICmlcnEtEg544lCv85Pdnaja6f7D8Ofq33tFtImH7HGpneZwCevM9rYnmyFrmwVDS0vqrIKtE1/VGe2vXa1+VsNjAc5imFqzq0b4MfXMflkZqf0GgLey1oGMWrw8Mut6MxqkiLqW17Tg58bsQz3+26mEgihY4oo9wqEQh3GYJuIakc6GensMSrfS3KQeZsnnbqobyi10diRGn8leLlRWoZZ5kgFow52ub7O/D9o/HEufdg82S5mUnmWd5dtxVsRI6eWYMUmzbquIKvn5+tsKmXi/pozxWQ6lVlrTuFFNl59qKD/h9qVlEz/2MFLpmE3q7v9K0nxOsXtSN0hKCm/NW7JbCdiXjGlb17bqzFNog==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR11MB2745.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(66476007)(316002)(33656002)(66946007)(4326008)(8676002)(76116006)(7696005)(64756008)(66556008)(8936002)(71200400001)(110136005)(186003)(54906003)(52536014)(2906002)(55016002)(6506007)(53546011)(26005)(66446008)(9686003)(83380400001)(5660300002)(478600001)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?bmhodUZpVjZUQmpwejNWc3hFS1pWZmdXMTcrcDNPUHhUcGx2MFNyZVBtTE9K?=
 =?utf-8?B?WnN3bDcxVHFuQWZvUyt1cC9NTmZUS3J1NWtMZkE5TUpqY3RDUlpTRGRKTklF?=
 =?utf-8?B?NnhDZWNuTW1KZGhFcktzZTl6aVpXdC9ONTdEOU9CTnh6ZS9RNmFVTDBxM2tL?=
 =?utf-8?B?U0dlVEpiSkxXQ2ZGNnVUOXE2MzBDOTdBWnpwVlc1Q3ZVNG5xeUV5OW1GZkJn?=
 =?utf-8?B?MUxXVXJQM2w3TUxjbUdSS3hmVlBBQW1nRzNhdEhRZTZxV0FXVi83NnNrSkEx?=
 =?utf-8?B?b0R6OEhoNUJrRTh1MGhVMThFb252RGNySStJVTErdG9xZWFyMVZVU3BVL1Jo?=
 =?utf-8?B?QUlsOWtCUHdqT0xNSWd1dHpjalBWWUc5ZXYvaHVzd0NoRklVMnQ2L0RwYmc4?=
 =?utf-8?B?NjlXNWo3ZFliZWJlTFZ6WmF5RkpicStzdk82U2tnSDBXOVdYTHhObzJzNS92?=
 =?utf-8?B?Y040VWM4NmxqeTJvdzdZcFQ2SWtXcWRuVXY5aWJFTnh1RFJTV0hZT28zdWtr?=
 =?utf-8?B?T04yaGlManJDQ01NYmhhNDBlMDBsUnFYbkZyMTRFWCtlMkplWENUK1VIckEx?=
 =?utf-8?B?UDgwVzduUnNhVkRjRDBvb2RYajdSM3Q1RVRXbjgxSWVSOUladnVqYkJ0UW9C?=
 =?utf-8?B?ZmdUeTNXd29aRHpCUlYzWllLZEl1S2hHZ1BQWk43WUZ0eHJBZjE5czJWNkx4?=
 =?utf-8?B?c1pUSkpwblhHak9sN2VacXRZYzN5eW4wQmM0aWJyQ0xNUDlJWUVweDdEVDhF?=
 =?utf-8?B?aWJPWHM3NFdsMVRPUXN3YitEc0Z3VmJqcWozbFF5S3Mzd2RYZ0pxcWVoTEtV?=
 =?utf-8?B?ZENCWWxNSDNlWVpWcHZ5NUM3L2JFcTVraHNTSmpXd3B4NGNNMnRkWUhGNkJO?=
 =?utf-8?B?Mk5PeHAzMGFJcXhKTTRQYWVSMmtwZUhuZURPQ0FCaktIVG1KZDJDUERsK0Jh?=
 =?utf-8?B?RUo1azF0Y3RnWXBNUm8wMFhBajd1NXZFWHVaa3ZhbzJsVWxMQjIxbGdIWmls?=
 =?utf-8?B?Sng4KzhCQUpMSHVWeWVQRHpGdW9jU0RkZFVVQ1d4MW9MaWxhNVp6UDY1ODVG?=
 =?utf-8?B?cG9CRXBDek0yb2t6RXYrNnlxTlVaaTBhWjhWY1NUeUd6MXkzVS9oZTJ3dUZv?=
 =?utf-8?B?Q0tySU51QVN2QVhpTFZzV1U4ZmFMdTl3dEczUWFDMzFmdFc4eUhPUWN2MFNx?=
 =?utf-8?B?ZVViNjBVQWtKVDhMZGJMRzFyUGpyRk90T0QzYmhVTGp2eW9GbkZ1T0NzNStS?=
 =?utf-8?B?NGp4bjZ2amthWi9DMVEyemVEZmVoZDFXM3VOclhEVzNvbFMxejNpMGpmSEx0?=
 =?utf-8?Q?0ePIZTfCIaQOw=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2745.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a84d0d60-b5fb-4d9f-c707-08d8a551d7a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2020 01:43:39.8117 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k2/8r0CCrDpV3DJwxxWEGm9FlSJ9kfD66OvCq94hPUW2049dZ7w98D5RrmaJd4ppv27p89yQGPqhySB+19zZqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3612
X-OriginatorOrg: intel.com
X-Mailman-Approved-At: Mon, 21 Dec 2020 03:17:22 +0000
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
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

Hi Baolu,

I have verified on 5.9.13 this fix can resolve the error "DMAR: DRHD: handling fault status reg 40".

Regards,
Kaijie

-----Original Message-----
From: Lu Baolu <baolu.lu@linux.intel.com> 
Sent: Saturday, December 19, 2020 2:50 PM
To: Liu, Yi L <yi.l.liu@intel.com>; Pan, Jacob jun <jacob.jun.pan@intel.com>; Zeng, Xin <xin.zeng@intel.com>; Guo, Kaijie <kaijie.guo@intel.com>; will@kernel.org; joro@8bytes.org
Cc: baolu.lu@linux.intel.com; Tian, Kevin <kevin.tian@intel.com>; Tian, Jun J <jun.j.tian@intel.com>; Raj, Ashok <ashok.raj@intel.com>; iommu@lists.linux-foundation.org; Jacob Pan <jacob.jun.pan@linux.intel.com>; David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 1/3] iommu/vt-d: Move intel_iommu info from struct intel_svm to struct intel_svm_dev

Hi,

On 2020/12/20 8:03, Liu Yi L wrote:
> Current struct intel_svm has a field to record the struct intel_iommu 
> pointer for a PASID bind. And struct intel_svm will be shared by all 
> the devices bind to the same process. The devices may be behind 
> different DMAR units. As the iommu driver code uses the intel_iommu 
> pointer stored in intel_svm struct to do cache invalidations, it may 
> only flush the cache on a single DMAR unit, for others, the cache invalidation is missed.
> 
> As intel_svm struct already has a device list, this patch just moves 
> the intel_iommu pointer to be a field of intel_svm_dev struct.
> 
> Fixes: 2f26e0a9c986 ("iommu/vt-d: Add basic SVM PASID support")
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Raj Ashok <ashok.raj@intel.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Reported-by: Guo Kaijie <Kaijie.Guo@intel.com>
> Reported-by: Xin Zeng <xin.zeng@intel.com>

Kaijie or Xin, can you please confirm whether this fix work for you?

Best regards,
baolu

> Signed-off-by: Guo Kaijie <Kaijie.Guo@intel.com>
> Signed-off-by: Xin Zeng <xin.zeng@intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/svm.c   | 9 +++++----
>   include/linux/intel-iommu.h | 2 +-
>   2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c 
> index 3242ebd0bca3..4a10c9ff368c 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -142,7 +142,7 @@ static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_d
>   	}
>   	desc.qw2 = 0;
>   	desc.qw3 = 0;
> -	qi_submit_sync(svm->iommu, &desc, 1, 0);
> +	qi_submit_sync(sdev->iommu, &desc, 1, 0);
>   
>   	if (sdev->dev_iotlb) {
>   		desc.qw0 = QI_DEV_EIOTLB_PASID(svm->pasid) | @@ -166,7 +166,7 @@ 
> static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_d
>   		}
>   		desc.qw2 = 0;
>   		desc.qw3 = 0;
> -		qi_submit_sync(svm->iommu, &desc, 1, 0);
> +		qi_submit_sync(sdev->iommu, &desc, 1, 0);
>   	}
>   }
>   
> @@ -211,7 +211,7 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>   	 */
>   	rcu_read_lock();
>   	list_for_each_entry_rcu(sdev, &svm->devs, list)
> -		intel_pasid_tear_down_entry(svm->iommu, sdev->dev,
> +		intel_pasid_tear_down_entry(sdev->iommu, sdev->dev,
>   					    svm->pasid, true);
>   	rcu_read_unlock();
>   
> @@ -363,6 +363,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>   	}
>   	sdev->dev = dev;
>   	sdev->sid = PCI_DEVID(info->bus, info->devfn);
> +	sdev->iommu = iommu;
>   
>   	/* Only count users if device has aux domains */
>   	if (iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX)) @@ -546,6 
> +547,7 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
>   		goto out;
>   	}
>   	sdev->dev = dev;
> +	sdev->iommu = iommu;
>   
>   	ret = intel_iommu_enable_pasid(iommu, dev);
>   	if (ret) {
> @@ -575,7 +577,6 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
>   			kfree(sdev);
>   			goto out;
>   		}
> -		svm->iommu = iommu;
>   
>   		if (pasid_max > intel_pasid_max_id)
>   			pasid_max = intel_pasid_max_id;
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h 
> index d956987ed032..94522685a0d9 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -758,6 +758,7 @@ struct intel_svm_dev {
>   	struct list_head list;
>   	struct rcu_head rcu;
>   	struct device *dev;
> +	struct intel_iommu *iommu;
>   	struct svm_dev_ops *ops;
>   	struct iommu_sva sva;
>   	u32 pasid;
> @@ -771,7 +772,6 @@ struct intel_svm {
>   	struct mmu_notifier notifier;
>   	struct mm_struct *mm;
>   
> -	struct intel_iommu *iommu;
>   	unsigned int flags;
>   	u32 pasid;
>   	int gpasid; /* In case that guest PASID is different from host 
> PASID */
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
