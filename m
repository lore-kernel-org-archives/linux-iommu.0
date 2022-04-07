Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91134C433F5
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 08:05:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B7A260F74;
	Thu,  7 Apr 2022 08:05:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lX78tKV5M33E; Thu,  7 Apr 2022 08:05:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 37A77611BD;
	Thu,  7 Apr 2022 08:05:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1062DC001D;
	Thu,  7 Apr 2022 08:05:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5896C0012
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 08:05:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D311A41973
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 08:05:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jkhfLA_d1Z_5 for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 08:05:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A293E41865
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 08:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649318704; x=1680854704;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=D9JGUS2217J3O0Ey4tG4UcOET395d6QHwhZ99me0G0c=;
 b=Jhxt5zlwW60jQbuZidgGKmWSea9r1kyEMkcO+D2edJUet0rFbkGGggsC
 74iSTULhEsczTVmD7oMuI1FiZzCExdYUVUMsb4RPgz3tg9uXolc1EOVKY
 pjy2smjOInh/bz0mmPYn1YSagYbT7ks0yXQ9Ie9aMqQQ0A3xl/k5rFfte
 0yiSL3IM9JswriDEsBnYJ3D9Ce9raeV7cMwy49MCIvMsVsvPNykNED9UU
 zPilAQgbZ5O8Vyeg4chlVtIpk6VXIv2rpht51pZZN73eXWeXSpvx58168
 DDa2vY8FJQ9isS5a8himBjvvd/B6xK7M/ES/IRdIiRXkxeN97y7h/2VwY Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="243393372"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; d="scan'208";a="243393372"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2022 01:05:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; d="scan'208";a="851583360"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
 by fmsmga005.fm.intel.com with ESMTP; 07 Apr 2022 01:05:00 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 7 Apr 2022 01:05:00 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 7 Apr 2022 01:04:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 7 Apr 2022 01:04:59 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 7 Apr 2022 01:04:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlG2NYAioaHZL4rdjMRpa7nhgd9T2eJZVvu+egP87E/aT/qJKXCIRPngksvHWC/qzWgWMg/ixYX9wjxOBE7P2YmK718JEY7+qH1lWKDphMjKDwukbuQeuc+//LJT1guKkbCqVE5oxRcWgfe2ymCEhBTv1yJwPFNIn6qny7OkGjgQJdCZjXm2m1fjouyp4PU8wulzKyJ4W8mJ1MdP1jyZvqS6mpTnMzFKiFxfWb2QlRMZbmHZOGbxfAQVHKdq7DVy8JrTUEHob7FacE+PQJAB+G9dWlUln7JDC41RcgjLcq0SGNTTJI6YiPL7fuQOnOXRMIVmOoJzalqRurKMs3FuIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYqtqwR2MlrgS5xfuKZtZjUl+lVkOV0ojVrkSyuKZ1Q=;
 b=KWdkFdVYcqVuTmA49R2h7JEC53B1aT6rENl4CMT9qWU4HWJRNtNv8VslySkTdGrFtImOuuR+lKWglj4wXKKnlOk2EXeYkswG+TWu+44POQhv8KuxDewqDuo+RtekWz2nX5Wv1FTsEI6Su+UfTNMCLkoDBNHMmVrVtP0I6WgfSzPbQGkBh/CkPrpSEqER317aZflxtxfTrpq3/Gdd8mwyTnMyeeTuaBTt9oCJ9sxpFD9LdD1F0q7+Q7K1ekB77g7C3DDpvlJ+t6Cb24Ad/1AlLc+F+6Uu+XLy0y2dOV9z8BeCja13RkVjmx3RAgfjWXU0YoBzqYqpUGHbO13qcKUHPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB3436.namprd11.prod.outlook.com (2603:10b6:5:65::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 08:04:58 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%9]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 08:04:57 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>, Sven Peter
 <sven@svenpeter.dev>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, Yong Wu <yong.wu@mediatek.com>, "Jean-Philippe
 Brucker" <jean-philippe@linaro.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH 3/4] iommu: remove the put_resv_regions method
Thread-Topic: [PATCH 3/4] iommu: remove the put_resv_regions method
Thread-Index: AQHYSkh3EWNw7SIAPkGU6YDyek9V66zkFziQ
Date: Thu, 7 Apr 2022 08:04:57 +0000
Message-ID: <BN9PR11MB52765FCAC6935C14D8669B288CE69@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220407062608.711392-1-hch@lst.de>
 <20220407062608.711392-4-hch@lst.de>
In-Reply-To: <20220407062608.711392-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.401.20
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddbcfa26-8881-45eb-2928-08da186d4eae
x-ms-traffictypediagnostic: DM6PR11MB3436:EE_
x-microsoft-antispam-prvs: <DM6PR11MB3436F06194F271D6896C15418CE69@DM6PR11MB3436.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vvm20dfL4h7W608hUzuNp30qN+8TUT3rXZWsAa3SWHJrFDHfdvsFwOjswRR6DtWb6NxyRgheGPL0uwyVVAvK8PO1/cVplYbk+LDkBrMTstsRvgXETaj6PIX60FCih7HSAXepfS12+yHBFPP55GZbCHDCsxIRPKyH9mLoXay1Wqzl29IoHzHg5fhtTv7EYm/nFwM02TUxtpOAufeNxs2sArIiFteAWorKP5LNjS/hQetxtpP+Sb8Eg4qV4rLgwIkHvy8PoI6zwFgTlagmsBSD5gbzYrp2mDzOdcU3TTo2jvVp1OpAV2U2YP8d7RRqKnoDDxty0yUC32vztFiY9sOhqOuGmXcQ0tTN1VSPpNBrm0uynAKQNStJImcl7l/a6ySw5g77mH4hTMK+XwBzIuwICgkRaLIsfD0HC8shZwBPjOmijIvMRPerGf2gT2vwAHv+FjRAxXnNXo8n3Ox4kYlR7WZlXK/NsfxzPsstp1JgrtSyLn4RPYveBGKxVEZXcyXhCP3798Ht7z3mCLquMSCE7oXQyJIX+FSPwNXW57cYG9VLobMbsTfpROiQashm9ztW6ULwYcA/5mg1+Boq40FYLE/6a1qdRtSPWKlL7j2G687icO1353QGwQyw0fyVhUM2oxKo9L/gaS5mzPzaPP1a55wiw+4kbWkhIhPjWIHdFq8ZQAhtzP/WdwNl8oyH/W/hN8+csOdOKAddUNYNplv6LA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(82960400001)(6506007)(7696005)(38100700002)(76116006)(110136005)(2906002)(71200400001)(316002)(122000001)(66556008)(38070700005)(8676002)(64756008)(66446008)(66476007)(66946007)(5660300002)(8936002)(86362001)(52536014)(9686003)(26005)(186003)(33656002)(508600001)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B6X904lj7iMbM/UjQ8EoSh6+Z8OjahMNAPs0et0GsIBG4k6sZw386xrK3y5r?=
 =?us-ascii?Q?0g7Hq/ZdmxJCIqDY1YQcug+VVpg0pFbFk1PLHwwX1Vu6zbvxtT/HMJ/YXJLE?=
 =?us-ascii?Q?P1cVT6V+3Z6SEtRWfZ0/QPZeC31ZKgOJdnV7M70sW4HaDnV+dnoLMRD3yjFv?=
 =?us-ascii?Q?LLbmJrPE/n0k+HLHH/mxwShcFNDJil+KEniLRT4gxPGUt7Ta6amcSnX1VE5/?=
 =?us-ascii?Q?eYuwyAZGhiVroG+NNVJCLrY2P7lL2tuckFuzU3Wwz+w70jHImMKYJLBFXbiM?=
 =?us-ascii?Q?ViR8zEH6S6WKR7M5WBu+JhpTKUsHVvMQONv9g4htRv5MFZ3Cz6XoJs1ybVSs?=
 =?us-ascii?Q?u3fxahTu1lURNEfp82vADQA7iTuH5hnSvrp1OvVliRhCtChx7z1pU4jHydkL?=
 =?us-ascii?Q?KTsU8QQqqBvO8TWNg97z8+KCs8hvlsMl84ZR+psZOOLzc/lrP5JVLoWDXeqR?=
 =?us-ascii?Q?hjgIDnM2LQ8LXr55V8//JE9g0ciS9QMNAXgSNmQuosIpVgY+ftWBkA00ms3P?=
 =?us-ascii?Q?ED726RYnbO5EaTUozvOe3ObKJwF5/2I45TseOSSeduS99HquqzlskdICvkBx?=
 =?us-ascii?Q?lkN0Srf3OSXPq7wYhMX/1EmYzHuOCNeeoI5y39jTolbI64hKGGBAnV1sBkz3?=
 =?us-ascii?Q?Q3+v6BvHjn5dFixNbJWmHerkVAfToWUeQWkbta8QDRMjo/3d65d6FARxJqtw?=
 =?us-ascii?Q?4hwUubrTDJBa04z93S50n6KL3hKcia6HS0dceGr3i9/eNMaRbJXVXgn/oayf?=
 =?us-ascii?Q?VZoX/5my15qIbfzh2Cpf3gAOTZ6PzXJXXgFPg98VD5RuS7Xlv2imXYLF/WMF?=
 =?us-ascii?Q?N2JC/y7Qjn3c/pRkf2cMDaLhvoB+8sHtL0c+3BSsZs77zG0NIK7AXk281vRs?=
 =?us-ascii?Q?AMcFjsASr462Jwz7UuD2/C8QhflIZDb16wHDMKf8W5Hz/r4EwHCSrFxehALB?=
 =?us-ascii?Q?uM1zC4gLVjZ5fgXQfGODBTkskxYY4YXS9pXKTlO+TF83UbQOsSmtYIOF0hOW?=
 =?us-ascii?Q?oMbkhLOdLiJhPq6ZBy7sobYS8eV8N4vMB3fiLr/xb88hR9bP6RVCqDZ/igd7?=
 =?us-ascii?Q?buz5v0575fXzswaCL5k5phT/HL4sz+5M3YaTrwDLakvZgzt5w/NDKt/G5vh1?=
 =?us-ascii?Q?SK/gIrpXVXLsybsyleZu7oTy9mPvl70WEQPX/OfFdBiw/8e5jaTfx0P2Oqik?=
 =?us-ascii?Q?MUkZvQQfa1Il5gUBLiWlhXaoCQkyXQIwDNj/+wU1mm6hA6B6FrPVLNzMIGOG?=
 =?us-ascii?Q?0TnVLehILBV2crIK8HSd4euJQEuft9HImv2wwEhy/imLMq8utPim4NNRAgwn?=
 =?us-ascii?Q?f9fJdug/QDw1A9qOu2JH74QjgYsAJCtE6yptOcA5psfGz2Y+tecD7h4zby05?=
 =?us-ascii?Q?mm9E0S1EAgfu0cIeUTJyc7Hr/LzANZTJ6EvzlJkyoZxJwzGPE9gyn6hza2ib?=
 =?us-ascii?Q?SRAn1uh1P+2S36hMZdmEJAOWEgVJqUjK6W6dTA/wMFXgGUtV8pBYcmJSd4hY?=
 =?us-ascii?Q?LvHUerOBsjYO+JGTZPa5r7camr1wukDQhjJ8T+iYSSMSd7i8y/hz4CbJcYJO?=
 =?us-ascii?Q?9zFww6FtoBR/Wz+AKOMLFyk09LqPctLHHxbqrdRCDn+yL95fM4aVvVWKMoqb?=
 =?us-ascii?Q?pfpNkAGvCHvarw7qtk/0KESoKNnkRWl+u0ET/OC72ZwtCrNbqlV2SyY3aah6?=
 =?us-ascii?Q?8RsKrcWNG1M69RJZvSB2vq7ECVrIFtNKV//ZvGD/cGt+CEek952Kdicv2GqY?=
 =?us-ascii?Q?+cYb3PYqmw=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbcfa26-8881-45eb-2928-08da186d4eae
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 08:04:57.5478 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZgZ//ZPHR6m3ZPJOakHQLf5Dl7Z3xoPWw8DKY8T2WsnofBs2+44/jdnKqqRx0it3ikgX793GpHK8u0VWF95/GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3436
X-OriginatorOrg: intel.com
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

> From: Christoph Hellwig
> Sent: Thursday, April 7, 2022 2:26 PM
> 
> All drivers that implement get_resv_regions just use
> generic_put_resv_regions to implement the put side.  Remove the
> indirections and document the allocations constraints.
> 

Looks no document after removal:

>  void iommu_put_resv_regions(struct device *dev, struct list_head *list)
> -{
> -	const struct iommu_ops *ops = dev_iommu_ops(dev);
> -
> -	if (ops->put_resv_regions)
> -		ops->put_resv_regions(dev, list);
> -}
> -
> -/**
> - * generic_iommu_put_resv_regions - Reserved region driver helper
> - * @dev: device for which to free reserved regions
> - * @list: reserved region list for device
> - *
> - * IOMMU drivers can use this to implement their .put_resv_regions()
> callback
> - * for simple reservations. Memory allocated for each reserved region will
> be
> - * freed. If an IOMMU driver allocates additional resources per region, it is
> - * going to have to implement a custom callback.
> - */
> -void generic_iommu_put_resv_regions(struct device *dev, struct list_head
> *list)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
