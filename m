Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE56C433EF
	for <iommu@archiver.kernel.org>; Tue, 24 May 2022 09:39:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A09AA83F56;
	Tue, 24 May 2022 09:39:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f8mjospi1fTK; Tue, 24 May 2022 09:39:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 679F6825CA;
	Tue, 24 May 2022 09:39:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 418CBC0039;
	Tue, 24 May 2022 09:39:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DAA9C002D
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 09:39:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 57F4582ADD
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 09:39:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fI9JetoCGCvg for <iommu@lists.linux-foundation.org>;
 Tue, 24 May 2022 09:39:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6858F825CA
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 09:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653385196; x=1684921196;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4na9WtV0l2lW//G+Gb3JX+dx7P4t8DqcMh+zg7NA6kk=;
 b=A3rT97D9PpOpHKPQXqcGVQHOmilNXHtrp6n8EHKV85g6Sd8K+ZD1Lvq7
 Pb15JGypqQna0b/2jhuQw2cMFF8bZxFQO/ags7JH/SquAsZvfKe3QN+MH
 PS5nb+Zhbq2baD7x8FUnkm14dI0iA5w0xiKLJaZbmDJkOXrNEmOZTT1nz
 ZolDGCeM23mYmsmdpuo2IRL4zwPfVDC20oMjJ6l2BpA4XbhTqwrMySwyz
 ZnOn0tVH4vLaUc8IcET4RgZV2J6o0lpQBrEh1WL6nvR+mlkUVdBiWJsR8
 O5ZqzATrtOHx5ZuRp+xl8HAD5ssy4DiysYJQey4RJvH3rk7zBSYns9QDS A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="334129496"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; d="scan'208";a="334129496"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2022 02:39:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; d="scan'208";a="629808809"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by fmsmga008.fm.intel.com with ESMTP; 24 May 2022 02:39:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 24 May 2022 02:39:54 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 24 May 2022 02:39:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 24 May 2022 02:39:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 24 May 2022 02:39:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtI7/m/iR5WxD/9tzddFtAVLxnSQgXaH2QdgCxcOPOdZkVnOY6d2UE3eR5EVW+gpR7urvdkw72+BxyL/rDCrb3RHwMWPLj0N9eGNhsj+KJi2dQ9kapm/c2yYA0GyFIkCoJ9kubexiKbNhnJUSA9DXjuym55vX4IZIyg++N3RbLj3xtWr02D7zQaptT4jq/QdFf32qZXwaonNUrJ4DGUOab3Oc7ODcHxaTljouF0oKjZeeMpYdy6r30QhfQQ0bhTPkl4a7sHbWuMvmJH0e27n+gN3VOVSehO4XizeziJEWFhMLlIf2cD/hiCQmmo1i95fO70Jo0FFkH9eTo4Vq6WJPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwW6Q/7hWCouVlVtzj+7tXj2V+oaVuMvkhVRBRwu23Y=;
 b=FTBcpjb05ti6ICvxC97zmmkzCfZRPw8KuXMaNsf0K4ZXcfVenOr2+tlD228Dh3JwXtldCxxkzHduIXOvgxOZDjxwgTHZsT6zK02nRUb98zql2Dm/92ewBGhPAYPmwQG31zF7Is0dtADl5mtjz5xTG3VgBtr35vxeTUdWJpIb3ONMoMa7BN5AZ1n4EcgzLDriQqOWuQak3CzmP8i5H67/X5xaZpfCSp/TDn0A7vVcjQjTUU+OY8Od9u5on64vXC7o9rjPpcxz52BuZ+V6j860B2MElg85d7tXe5oiZHiK6gVFjnDIn5kSztKUSzETyz0LlRV1FuMTx0DD/LMi4mJ5IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB4034.namprd11.prod.outlook.com (2603:10b6:405:7d::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Tue, 24 May
 2022 09:39:52 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 09:39:52 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 "Jason Gunthorpe" <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.com>, "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul
 <vkoul@kernel.org>
Subject: RE: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Thread-Topic: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Thread-Index: AQHYa1GAWzo4qdZhTU6Id4ueE7eQ+K0tyd1Q
Date: Tue, 24 May 2022 09:39:52 +0000
Message-ID: <BN9PR11MB5276982C37DFF0FEFC45BDD68CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
In-Reply-To: <20220519072047.2996983-4-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bf7f6bf-2949-4e06-68b4-08da3d695a44
x-ms-traffictypediagnostic: BN6PR11MB4034:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB40348838270D8A681343DEF18CD79@BN6PR11MB4034.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lFEYcWJVevMriMB+dN3cRMCQtlWBhTJAsEoRY2Ll5QCevfPvDVU0yqcMKNJD4us83wPwtSkrgR9Ps9Oi0Nzo4aUkn8fDtJ23zYY5tQAusTD4FzoBK0eNARmW+CgyWORw/vtI/7oqGI8DdEVOuiZUI0CQkmbUWJ5ywxUpVre0BTalzMQMGTacmmiTH0WL99+OT9x6CDNK2jbNGpjkniPPsy9U8JLvFJ53qIJ5ZAD6kpmZYxm07+R/XjQA/iOWfZd+oIpp/V3XP0pTz6TsYpucvukHeSL6EpV1HLaJh1AT+lPtOReekqKGgd33pgDqnyTZHuqIYpq3F0O3f+x+p/I+8ehVVomNWMupgqJ0chUL5rId/GnU606m5d0MPR2QwFYve5OvSGzltKLP/FRQyJlKhwZEpTaDe9Fd4ZdQK0+2ZoNzXnwLSPi16gyjJJn3h/nselYbZZCXCShUFH18Lq/qYIy8ZrYkdzNMVob+srK3xtST+PHIrTrVKTeOF8pnr4k2y5XrJ4pr3AO3OUIzkFph9G5dnJAI0gwYFuZc5Qn8r3a0tfhVPowgnsIAbhbshEAIwTDFK6RaZZ2vTw0HYIMhXIsaEvNuzinZfd451Wcp+3SxF/z4Fj3EyeCoMZeBEYBnk28oGYGZvR5gkR4k9zj8HMhNVNArfHHiYQe1ubg4q+xhGTYdScnsHdEfR5U9zWOtKhyrCSjXBkqZROOrK1X4iDajwrUYu9epiWXQk1k22h0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(82960400001)(5660300002)(921005)(122000001)(316002)(9686003)(66476007)(38100700002)(54906003)(66556008)(64756008)(4326008)(66446008)(186003)(33656002)(8676002)(71200400001)(66946007)(86362001)(83380400001)(26005)(7416002)(6506007)(38070700005)(8936002)(55016003)(7696005)(52536014)(508600001)(2906002)(110136005)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bgKQcsn0ExbUG+I1XKp45x9gMSrnUmpSF5ZdEpfUC1+Do51/Jw3wO3JanZFD?=
 =?us-ascii?Q?nUdPRXSXf9expaNSxPiGGf+nRoirA1zltjzyHqdoK90FlT7kdTd0RW++y6yr?=
 =?us-ascii?Q?2vW9t09Wwsi0b1YxTUvjDH/3fOTxYuVHedxjC9eDfZzG6kQL+8MCy6OYj/cN?=
 =?us-ascii?Q?0V4gaLP9WM7xpZWPjBPsL/Vds2e3EdcskeaSWpyYIgAnmbam0gCUHiwVd8aO?=
 =?us-ascii?Q?d3s+3Rf7rmcDbadb0FlNScdlVmnDzUm0wlxP6zeErQ0RI5lfpIvi/V0D2r18?=
 =?us-ascii?Q?RDLgxQITSdkt5dVtgdI9NGNw7p+CgoMd9k3hb8TqtYwqj6uTuQKX/SeVzAl0?=
 =?us-ascii?Q?i8h6aEDoKiB/eON5RU8Rv14oPdS+vRiVuwGLrPlwyLTQdnUFKCR51B2Xf9AS?=
 =?us-ascii?Q?YAxsV3id8m26IffqmXoA2KQraCkIOM0IQRWnQqenP/gS3aat0SiVo+KzS1jA?=
 =?us-ascii?Q?ewTQe0XqiztZGsnHpPghIqGigpcW1CCz7IbLwXmcqjohj2KfjCepzX2jvCSl?=
 =?us-ascii?Q?lhD22orb+rtRkaFAUMqXz0iw3On8LPg8rjq4VdgFEehkg8BYPZZviS8E01DV?=
 =?us-ascii?Q?mLS5nddQ43dMkg9XA9ZxIbkz4p21k3lMfOYPb9pk7pZKHaEAohxoLrokUqOq?=
 =?us-ascii?Q?Zyne2/+pRWuQkwVxcgFvtGdLhY4uzyZVeHQdpRYptPNIyq8e8OLUxq6i5GZz?=
 =?us-ascii?Q?dXmVF7jWiBVvLAMkMbuqcDHNXDfGrV9IbL1cD6Yj/qFt4S4bX/SyUEG9mxi+?=
 =?us-ascii?Q?faU/jHLWM8ZMxAU/eV/eyMY9Twygffhv6Zp3P7DvBp9kha4Pr9/GqMj+B9t0?=
 =?us-ascii?Q?CEixMX96jsbyGDTM5UnHZ4I0OR54NqRIKy9dsNYi6bJH3Lo99PId8u+SHlp0?=
 =?us-ascii?Q?n28FyHrMdrlTZKBuqP5PIH9kC/VhWiTtpsSQTmzwg8Q8igwKqRtkaWDjp0f1?=
 =?us-ascii?Q?1FHyKcklkBSLpGn+C3aYfXKMh7x+LTVH5Sac+5+5R/F5wHzQ1tngZjsdk5Qg?=
 =?us-ascii?Q?UT0Jnm7of5ZVN894hnaQkHINIxDASFjxO2gJ58WgROuuGhT5sN8+UwNJzE6P?=
 =?us-ascii?Q?O1PYQtgvNV361FPZksNjpnB/JZUKB4TNh9r6PoONw6PgYOCreP5mHfxg7ARS?=
 =?us-ascii?Q?RbvHcmdnQCtlUWGghr5JHPBnR4vw2UD5bMfyDesE3YJooBbuxW1Znn88t2vm?=
 =?us-ascii?Q?XqC6SeSTFcHktJqxsdwYhoBtQB3KjwldINQEEH/iyAkxb+F+Yx0PoGSVSwzw?=
 =?us-ascii?Q?f1fioh63mh+adO2gJUyHO+6h53H5CGBsq22yRIwRGk3T+BakmIGq+DCoFiqt?=
 =?us-ascii?Q?Q7ri8koDmNtTNi2zzBrcwiwHTvN1chQzYi8xQAQcVt9Kem5NEGkdxG3SqN1O?=
 =?us-ascii?Q?+XQvpbZnxcOOqGZULtirAI0TvvIozR2evGCMagfoXlvD3nYRs4w6nYUswSrE?=
 =?us-ascii?Q?DTLixxbROa6rm1cjQcty1pQgWvm+J2BMewvEu/5Re7b6jz9rrj9HotvcPTIF?=
 =?us-ascii?Q?rCez2IdSQ4BQyMowyyqa8uYPLQ515RBVfAYTaZVbrle6wNdB3uZTWvkQh20F?=
 =?us-ascii?Q?6AImpMK7aq5GBRP2AECarFlUtj9W7OVrIFSUDzg5qeRyr6voe3ZQjqB3e9+Q?=
 =?us-ascii?Q?SmM+cGNv+kCB3Z9ePcvRuBc8Yi1Lxed+RqZ5ak5HabUNjHw593ZSKOEDoOjO?=
 =?us-ascii?Q?YsNWbpRDAQlRa9jv3yiVH9dCpLZdKffeYsOUEmDGXjUHO8TFISeBLZ/uwRcF?=
 =?us-ascii?Q?prjgeDjIpw=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf7f6bf-2949-4e06-68b4-08da3d695a44
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 09:39:52.1171 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8lOD7iOmQr7c09d5Fh975a47Ikfp+Ye7DZGYIlHzyMdEy9NadJu6GyoYl5W2G1yCdH6A/xZWWNxKdlx/VscR8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4034
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>
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
> Sent: Thursday, May 19, 2022 3:21 PM
> 
> The iommu_sva_domain represents a hardware pagetable that the IOMMU
> hardware could use for SVA translation. This adds some infrastructure
> to support SVA domain in the iommu common layer. It includes:
> 
> - Add a new struct iommu_sva_domain and new IOMMU_DOMAIN_SVA
> domain
>   type.
> - Add a new domain ops pointer in iommu_ops. The IOMMU drivers that
>   support SVA should provide the callbacks.
> - Add helpers to allocate and free an SVA domain.
> - Add helpers to set an SVA domain to a device and the reverse
>   operation.
> 
> Some buses, like PCI, route packets without considering the PASID value.
> Thus a DMA target address with PASID might be treated as P2P if the
> address falls into the MMIO BAR of other devices in the group. To make
> things simple, the attach/detach interfaces only apply to devices
> belonging to the singleton groups, and the singleton is immutable in
> fabric i.e. not affected by hotplug.
> 
> The iommu_set/block_device_pasid() can be used for other purposes,
> such as kernel DMA with pasid, mediation device, etc. Hence, it is put
> in the iommu.c.

usually we have 'set/clear' pair or 'allow/block'. Having 'set' paired
with 'block' doesn't read very clearly.

> +static bool device_group_immutable_singleton(struct device *dev)
> +{
> +	struct iommu_group *group = iommu_group_get(dev);

what about passing group as the parameter since the caller will
get the group again right after calling this function? In that case
the function could be renamed as:

	iommu_group_immutable_singleton()

or be shorter:

	iommu_group_fixed_singleton()

> +	int count;
> +
> +	if (!group)
> +		return false;
> +
> +	mutex_lock(&group->mutex);
> +	count = iommu_group_device_count(group);
> +	mutex_unlock(&group->mutex);
> +	iommu_group_put(group);
> +
> +	if (count != 1)
> +		return false;

For non-pci devices above doesn't check anything against immutable.
Please add some comment to explain why doing so is correct.

> +
> +	/*
> +	 * The PCI device could be considered to be fully isolated if all
> +	 * devices on the path from the device to the host-PCI bridge are
> +	 * protected from peer-to-peer DMA by ACS.
> +	 */
> +	if (dev_is_pci(dev))
> +		return pci_acs_path_enabled(to_pci_dev(dev), NULL,
> +					    REQ_ACS_FLAGS);
> +
> +	return true;
> +}
> +
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
