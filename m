Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36546C433F5
	for <iommu@archiver.kernel.org>; Mon, 24 Jan 2022 09:48:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4D184090C;
	Mon, 24 Jan 2022 09:48:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HbBvo971AM0U; Mon, 24 Jan 2022 09:48:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A719D40301;
	Mon, 24 Jan 2022 09:48:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7EA7EC0031;
	Mon, 24 Jan 2022 09:48:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFBEEC002F
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 09:48:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B50A140162
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 09:48:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j8BbDqIIlIPw for <iommu@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 09:48:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B0A27400CB
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 09:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643017722; x=1674553722;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NbMmn9NUgiKzpIlU3MyFF1/uYNPF6yOmFeFtJuZ6Dps=;
 b=dbVt+BYHnEF1DQLMh033TnuKOKH5pBXPISEPnL57fSRfdgby9nGWKcB4
 fUano2izwozgLXiki0t23KEABHCPQjOyCmVxLURDshnQh9/HESMbcOG9L
 HPLHSHr4s54wWmiP13sZm9HOSgxO9T1u5O2eF5yjXI9nni71nyOdEn7tR
 cpRD31gTvsNP3mX6orvNDb9h+UXCDQB32qcnJQ23x5Ccv3q/QZVB7XOEL
 8/0hg0xAmHOlg/EpvkTn0/tWw8SmV+R/av0fgrJiitNK/CBY+60jFygbY
 jGR6sGJ/2mUkGLGNrmHaUdPRjO3fmvqW+7ueBICDUp7AtX9ztvoh5moJY Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="309329016"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; d="scan'208";a="309329016"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2022 01:48:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; d="scan'208";a="673572700"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by fmsmga001.fm.intel.com with ESMTP; 24 Jan 2022 01:48:40 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 24 Jan 2022 01:48:39 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 24 Jan 2022 01:48:39 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 24 Jan 2022 01:48:39 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 24 Jan 2022 01:48:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNI2a4WvZw4lsQdzI1V7QLoQPV/O4yGCw1cCjeTb5s9V5rl0ljb7v/SlczF2vbLSfjbcgfoHll35dPVUzIoi25UHHyIeU+uIoFtjtUntm0+718MKnHPswbajvHCGnPOOKHCI6aOlknYtwsJjxl/x+BMOf1BsFCCQFZq4PGd0wIMikddmsRb6rTGQfSBoLC3BpBrCfLOrPOwwtob8qOxYQxEt8TNCOfdy2Z4PQGnjxWEP2meGzPII8V4hyIaJDEVZSEz5tmazuA/VZPFpVVWjdhJXNhRfGwBile8bwui45DbrI8za3dXzie7BHUmgwETcT1qW01HMrjRD1az/2+eT5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lq7CeEpztcSmy+Wd3DNXlBcf69rLLpKcjEwB4FMMv4=;
 b=cdpneogYCgmnE/7bRoTusP067BRyBSczsdHm33DFQYiBI6c4DBQUB3J/CAnuXXA45pSzhM5U9ArIFJEAMtu6KTFODoFQK3p+VFP+s+eHsdbAvW/q45J/CqjPjplTHbE8+gm9ecViqwyj/uYsvVdC7pss88lqwmzZh/SGDQ1vjGezKW3tAYHm/8ref9Uxse47wgCsfSwn4QTMUeTXCDY23lRUoLLzWy8TpYQ54aAN+xxskdd7weMh0dtMBM9p3rrHg7rI+TT0jCfGk0vt37ZPjVAtkUSzC5SiVmxC2FZvEU4jh+6aUi6Nrnqp/zUCPLiFJO9YW1iExSJSRrdvfc3MMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB2668.namprd11.prod.outlook.com (2603:10b6:5:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Mon, 24 Jan
 2022 09:48:36 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e46b:a312:2f85:76dc]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e46b:a312:2f85:76dc%5]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 09:48:36 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 "Jason Gunthorpe" <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Ben Skeggs <bskeggs@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: RE: [PATCH 6/7] iommu: Use right way to retrieve iommu_ops
Thread-Topic: [PATCH 6/7] iommu: Use right way to retrieve iommu_ops
Thread-Index: AQHYEPHSpa6rqOl4/k+RfGCHsL5bBqxx7PnQ
Date: Mon, 24 Jan 2022 09:48:36 +0000
Message-ID: <BN9PR11MB52761ADE7D2696DDF0388A6F8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-7-baolu.lu@linux.intel.com>
In-Reply-To: <20220124071103.2097118-7-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9cb83a5-2b54-472c-0142-08d9df1eb15c
x-ms-traffictypediagnostic: DM6PR11MB2668:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB266810BB4D20FCD16833F3AA8C5E9@DM6PR11MB2668.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: szJwK9h6ruQ66XS5vLbTl8jkn4USw74CtTThhs7e+WPao6HqW4dk/esQ+EqVKwI3NU9z1zxruomdVFwhDFVQVEnAuntItyVuCLNqm4Zcy42cL7gq/3UCbF0YQyM0c/DxZg2Pi0yNkSHvGlqWc6INtGdITiFT7+R6EFG0xwTrBn9xtiVKgXMQNs5Mbyi0ZKVD7Q66C3AIzXHDijRTGwVbwgaMBmUOY79a80nd0v/M8ypP0VW0ywDKJ9UrRxowTyKPimeMwB0CzXodoVEwaMH6UnpqyL1d63igW62bfR5OijMigOZWZR5abxvxBwoJgxRvlAmqs3GjBkUZot7jDEY4B1o6MTqj4eJPr5wx6otYmJQ8OcQwq+G/J1OT4uIGaDwlveSEmK9XAstetAyh2bfhXe3hak/Hx8/tpILWU4n3cwBoiQRlcek4OQmmLKmg8fa6slbixaUP+1jQgHknsSTp5/1fKRTpBwvEUvxa6QpjeeU+II2W18TD7xR6z3jsy4M55KUkC3hseNL6iQP7caAcZ3DDbBhJuN/w9WE0ON804gb9WA8wFOvygY5E+7DMpCshoannUv0Br/7GcJFF6bhva0XWUm+J4BIGCPgX3RlscZpv3733/z7LAa7nU6hnsUOA1MJo0hBMZE0B5f5dznn4MQEYJKFDqtAd1kANqjcJiv2eN5Llt5tus0TaFbTfDPI59sTi1Qln6s/BKZ8ooDgY84Gh15BEMsqQMJlppAWmZUY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(66476007)(66556008)(9686003)(38100700002)(122000001)(64756008)(76116006)(54906003)(38070700005)(316002)(66446008)(55016003)(5660300002)(186003)(26005)(8676002)(33656002)(2906002)(86362001)(7416002)(6506007)(7696005)(110136005)(4744005)(8936002)(508600001)(71200400001)(52536014)(66946007)(4326008)(82960400001)(43043002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7Q1QN125YiXbm7cGwiSivjxKcbyVw204M5R2xBO3N+uEtzsgY/W7ShGCbg4q?=
 =?us-ascii?Q?z9yE8RXq42OpRTbcltecrf/ZDaHl2Lkbg/TzZejy559btrcZSGtid6NAKAdC?=
 =?us-ascii?Q?+iopPhEk67AkL7rCTEF6ycb5OFtJ76LumiVBUHKDfD9Ki3vgm6RR0KKevIOE?=
 =?us-ascii?Q?aOzEd+F5oHgse0spX7aRgOmR588lWET6Hhwi7oU39DpTN0WYbyXGgr7mFoAe?=
 =?us-ascii?Q?9dTCXjlo31oe1s8ZhDzLmC1tj5blwHXq0bvUMkjwxN6fXhyZsdUyiC/DxwSJ?=
 =?us-ascii?Q?Wfs2/TDoD0zMuJbb47/mvhIok/0PJgtC9dFJcmWMePr5lP9XK9fZAC2Vsyf5?=
 =?us-ascii?Q?tWTISaWxpHvO8eONljNWmLRK3Um3gYqK/0d/LLTLzQLrb20fk8AUiy05a3Le?=
 =?us-ascii?Q?TC3QigTswFoOaISH5ZQwOA3nGtNGnFSphAx+OGswdTACCOxHXsHjnCQP7uk4?=
 =?us-ascii?Q?jsL/N6u0MOr6t26ePiT2QYuWv/EIdeNQWPEJ/aEy/O+fVyHWotCDivoN7u95?=
 =?us-ascii?Q?UmTP+uzfptyg1hpZnNPvkjT0l7VfwmAIJN09mVLU+eNEkI7eZ7VijKc6TEh6?=
 =?us-ascii?Q?DV16eD4f0KRGwubBihFnYLxfWjuVS7DEBusl10sOYYSWSMBxGYSPc9W2rOi9?=
 =?us-ascii?Q?IAKFTw/9FLzysok67XcPdw3F7JBEmxI/Nxjb7+k7dH9xW8FrmmM1MQ6aAh4f?=
 =?us-ascii?Q?aalYcoz/OGRbGFnDGSsOaHfkeg2zXgNOK6lpIeEgrHRTNcWUzJPY4/EctRQn?=
 =?us-ascii?Q?aXktDpu2EiX2z0w4blUSYL9m0MPoLx/4PlhDBzSuWk+53C3zKfMOb5rmOyBQ?=
 =?us-ascii?Q?Q23yxYlyrGKLS/mI2RhRfI4flRvTH3KKKldzL/zZNNPGzSuF6H8V0ELgl9sp?=
 =?us-ascii?Q?cNM5N/NT5N1sdKQI6QxuaxTXEur1ixjyQ1D5LekJ9gTcmoNWXTdKcDzYWgO5?=
 =?us-ascii?Q?rA+NB5tEBgLr8nzYzoUjY6GXA2qbFQQoIpBYrLle440R+uV96ENZwMKdBGnf?=
 =?us-ascii?Q?z0IZ/JoBDha6jjt0CGOfoLK6xisGKB3TqNLQ37sitUOLzOaVwXhFZ7Hs2tNV?=
 =?us-ascii?Q?1uD1QjkP1WljI6ODiGfrcIECsbct4hSSgGlIATkT5eq2BmQzpguxacT6OEmU?=
 =?us-ascii?Q?Y4BC8cO1OoiFVDh+naVngA65PuH4b99CjqUqs/kR/1APPLyYlOjjG3F5esT2?=
 =?us-ascii?Q?DcSRWlVq4gLyKDGrNgZ46rfkIQImolNbCcvIlPGw//B+MvldfgrPTV1HLw0P?=
 =?us-ascii?Q?3U3OsmDWyxW+CoyrOG9TkwJo3T2KnuzTTKGbH7iCAeza0GS+VeXwBZGd6Ci2?=
 =?us-ascii?Q?9nNHVuCIQp9u2IGrDjKIIY6+m2jdUqtJlDcRByndYTlsnOcsZDARuipg6BZs?=
 =?us-ascii?Q?AEwmOHTp/uKY+hiIG9iSq3g0nd7EjrjOCFI79ujdCfpJU6SyJ+JgCmeGHFrH?=
 =?us-ascii?Q?AdtS7VBQsD5ODJiAc+5EjUEnUP9RDDh0kSdxej1byGWV6WX0l32ZSLGIE7FF?=
 =?us-ascii?Q?D1FwBlHPe+gsEpEzuR6ifWud+xx9lpncUt2m6wR/QiVIhXpeWKl9BKQMnupF?=
 =?us-ascii?Q?bUUkWfvXZB95AfvNiyGqyH9xdlqsLxhsaKvqK3+K1syx9+cDa94buzrZLObC?=
 =?us-ascii?Q?OBqeVFUBfpMB3Tk4tq4zzp4=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9cb83a5-2b54-472c-0142-08d9df1eb15c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 09:48:36.6689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W2ogPlIb/x2DFmIjymZHlcRtVH96EoCqFeZZNbkzHRHlLNpcqezorLabz/DB6qiNeiESa9luZurdAwM/GuYw6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2668
X-OriginatorOrg: intel.com
Cc: David Airlie <airlied@linux.ie>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>
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
> Sent: Monday, January 24, 2022 3:11 PM
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index aa5486243892..111b3e9c79bb 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -385,6 +385,14 @@ static inline void iommu_iotlb_gather_init(struct
> iommu_iotlb_gather *gather)
>  	};
>  }
> 
> +static inline const struct iommu_ops *dev_iommu_ops_get(struct device
> *dev)

dev_get_iommu_ops or just dev_iommu_ops?

> +{
> +	if (dev && dev->iommu && dev->iommu->iommu_dev)
> +		return dev->iommu->iommu_dev->ops;
> +
> +	return NULL;
> +}
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
