Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8C9C433EF
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 02:49:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0461D8330B;
	Tue, 12 Apr 2022 02:49:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rFPrJGwz3cVu; Tue, 12 Apr 2022 02:49:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E832A8321B;
	Tue, 12 Apr 2022 02:49:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB483C0082;
	Tue, 12 Apr 2022 02:49:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53297C002F
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 02:49:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F995400EF
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 02:49:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8fWt9-OJmGv1 for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:49:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F1A0C40122
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 02:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649731759; x=1681267759;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=J0l4bGsyOmT3NAPxkPaVUUkUtunhh9XCUe5SzoPBrx8=;
 b=J+nP7S/drepz+iBogMF1YKivtMnE8BDUUvrFNLI/3t5w5lRVdmM1QL3v
 t3sCwwoTcAO/NvM7EYsy3dWudGv3Y5mfQ8gn7u3A/A716GNJ7rAuunFhe
 ZpYoEefydRtYM8vwH/wYiyDUwHltd2TtxoePmmIgKqxPXRWs+XRAiuz0S
 /UkTftNTJjnMIIFKJMsQki3eXxpX2pnv1J5FqAyt4yrLnAepNk8Hr3Ku2
 YKhTZe4x+hPNT3CPmCIcJDcRkIuHMFZhmiGUC4+Gz7HUCaQgffYO2DRob
 NUJ9THyg2VU0J45BpHBJ+ePQlxGCWioe/JyTJk1dRvfZ3SAWU6Giq4wjx A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="259858693"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; d="scan'208";a="259858693"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2022 19:49:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; d="scan'208";a="507359425"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga003.jf.intel.com with ESMTP; 11 Apr 2022 19:49:17 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Apr 2022 19:49:17 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Apr 2022 19:49:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 11 Apr 2022 19:49:17 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 11 Apr 2022 19:49:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwCqEhOEnabl3twXP0bKRJd2Wdfe8FI/rxjFRxfSSujMgKU/mFrR6+KuKSydlYbMzFk7WvdKO91PZY296WLeT8t9aVE8OZjkhOGHY+oAqgMFV97nU32GJ86FQcfAndOjxxxzFIpVi+ouPKfP11W/fjo1kVlVfFbaaDpwD1tbkAtfgv0CxlfBD7mY4TTH9fOGisNdO5bQPHwHl++xJ6WXMybqeQyE/BriDhVxt3+gZ0z5FuHz60gRnczc44zlFwXVNam4Uz4O5qL1Fv5CoQYk2aqMQ+wMfVeiLjofj3e7IUEajfNzoL6NFb8uK4iCYH5e4L5a5tfqxCoJCHS0hs2CXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0l4bGsyOmT3NAPxkPaVUUkUtunhh9XCUe5SzoPBrx8=;
 b=C5sp8aOkspvansvQgekgN6hD/RcgrziY7GCvNkB4+v2tzfAI3IGc86qXPj1UEA8f3fgp5uZXtO8spiefV0u31Lt4OAnSamYdInzQOwpyFvpXTL0aQMH2ZguaAq2sc1Kh7l2w9KSUn6BWp+wda//GSk4CkTcKmEWk+NZxL1nbjGRuBmrJlvgIZ8UyKerPZHUd1XXHbu5C/lIV4yz8fiksDXsHTnpX2GlEDP7T76OVGzVGL0w4YlHvR1t71BltHgSr29iK3tzHVhIjFljv0sC2Aw65gnL06/RShkUHSKdAWL502pub5For/GQ70FSS3UFScG5UfOk45i/twzbNKMN5GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW3PR11MB4537.namprd11.prod.outlook.com (2603:10b6:303:5d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 02:49:15 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%9]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 02:49:15 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH v2 0/4] Make the iommu driver no-snoop block feature
 consistent
Thread-Topic: [PATCH v2 0/4] Make the iommu driver no-snoop block feature
 consistent
Thread-Index: AQHYSpOFxZ/QKUg0ZEGhoQEsmfFbSqzkrbGAgAALHwCAAAU0gIAAEooAgADpbQCAABLzgIAFzXuQ
Date: Tue, 12 Apr 2022 02:49:15 +0000
Message-ID: <BN9PR11MB5276F807493E771DBAD3A28E8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
 <f5acf507-b4ef-b393-159c-05ca04feb43d@arm.com>
 <20220407174326.GR2120790@nvidia.com>
 <77482321-2e39-fc7c-09b6-e929a851a80f@arm.com>
 <20220407190824.GS2120790@nvidia.com>
 <BN9PR11MB527648540AA714E988AE92608CE99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <f904979d-35ee-e2b8-5fd3-325d956be0d7@arm.com>
In-Reply-To: <f904979d-35ee-e2b8-5fd3-325d956be0d7@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb493565-7525-44bc-2f24-08da1c2f0820
x-ms-traffictypediagnostic: MW3PR11MB4537:EE_
x-microsoft-antispam-prvs: <MW3PR11MB45371A0978C81CCC02697CCC8CED9@MW3PR11MB4537.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B84SkK7WXYIPVL5DizxKw+LcCDeiz4XRRP1i2vqdHILPi0DhOUdnzTOdDeUpGcH+Irxeq0jXDfaPJpGGH/wkCO693fB1SKS/BFvbolczYLVPa6YA4N+/MuZOC1ck0OSMcNImL2vCTrPDJZewCq2DuQUFimioESurPwuB6Qv9jzEeucD9abxbgWLG5TFWXNPto0wJArUhXK1gMPej0fgl4uvhJRKQXFLIg2wZOS1aeBzdkcPOa7KTC8kt9Rr2j1MHS5I+dK/hptoA/FrdAXJR53XWCoCdpzUHjxtD+vGMp0KzPwMmjPvUe9ApdoYo/h0fTSCLlHtyQiDruThu1f96pgZZbhxS+P5md5sB4nY8EcTJEW7FDzDQlKw0YXOuhoisZmNIrdjKNmqb/nHxlGi/2UPT/EmbEimLNQwnXJTfSGqHuJbmfemNUYMaHV4L2PYMZcOp4+/PlsZWhAC+Fp4jmK44/AnNlHFuz33/YDDgsA0VYs6ANSzDwLQzFwpj6j1EQ6JTlcfRXaZyNnEW524EXMX6qX0AUgkX048bKbDv9bPoGin7jG6uOb2C4lKm7x/kInmeg+E31fzUo7yn9keygw7+YZiaYGRA9j/VdUzYujMmGjXuZxVWuBLsOYtJJPqah6xzSdRkVELjjiymIbV0cuzBj7hDZsJEJb9toowZlV+P3bXquaMUW7bAosGLeYTRPW51z+4RgUCH3RFnZIIwVg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(9686003)(52536014)(38100700002)(38070700005)(8676002)(66556008)(66446008)(64756008)(66946007)(4326008)(66476007)(122000001)(8936002)(7696005)(53546011)(6506007)(5660300002)(76116006)(7416002)(82960400001)(86362001)(54906003)(55016003)(110136005)(316002)(186003)(26005)(33656002)(2906002)(71200400001)(508600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjdYTTZVVjRVUmNDVmVkZVd4cE1nUlFiVzlLSHBTK2FrL09JNzlxNi90K2ZB?=
 =?utf-8?B?MDUwZ1hnV2RZM2U4T29FQlFIYThYTjNMcGFoNHA2dVUrMzlGaTNQeHY0aWxU?=
 =?utf-8?B?U3VpZ090YTZ2NHpseXZIS3luVmhGb3FHQ0dBR1VKU3F3T3ZrYkVhVlVGQkF3?=
 =?utf-8?B?WU1NYVVlWW1YU3NYbFJhSDZKMHlHeHNKQWdMZmp2eCtST2VNUUpBYkFObDBC?=
 =?utf-8?B?L1Urazlwb1drSWRBL25McEVtWHMxeCtrSzNxdVZTZ3lrd3BrYWc1Yk8xbE9H?=
 =?utf-8?B?TWxTRG9hc3B3WllGdGY2SG9QTjVoeUpLS0Jmd1FIL2d1RUlEL0VnY3NZd1Zu?=
 =?utf-8?B?eTJGOENwaXBibkZ4RUlyNWN1SU1LZnIwTzcxdStZS2lhQkFqcFF2LzVBR1NS?=
 =?utf-8?B?bUpHRkprTUZHTm5GK3JOL0JwRVJwYXVhdWtvUDA3bE1UOWJtRFJiT2JsY3dH?=
 =?utf-8?B?clZZMDdQeGNsV3pCaXJzempwUHN1eWdFc1VPcjZPbndqNUJMR0p0UDMxWkhF?=
 =?utf-8?B?VkpDZzZNTGlGWXFYMGt1a0F5Z3RvWmp5R2JKSlNhYU5ocHlDWVJWU05BY1pY?=
 =?utf-8?B?VDMvNEFxZVBPU2tGY2ZDZ1JGWlpkajJmSVptMnVmb1B6RUoyOURKMHQyNnV2?=
 =?utf-8?B?Z1JqcEkrN0lHNGgzWG9CVXQvbGg5Rk5jR0JDTHd6b3hmYjZvdkp5THZDNDZw?=
 =?utf-8?B?YU92TVl2YTFleTRQRTZoRDBULzRqU3UyWE1IeS96Sm93RnI1T0wxOFJHWjRa?=
 =?utf-8?B?QmlRQ1VRbEhXZWZmNXV1NkYwVnh0aHFNVTFoeCt3NEg5U3NOeW5LWVBmb3Ju?=
 =?utf-8?B?RHJRQWxHSXZoZU9qNEVpeStXZnRFUDdjbWZzbHVMZVo5Y2lLZWR4eWxZZGpE?=
 =?utf-8?B?YU1GMStSK2s2YnJnYnBvYm1NV1l1MGFITWRnTC9Ldm50TjR4dFkyZWRYelhV?=
 =?utf-8?B?UEd0OEhBa0hnTzdFeEJpcUxPTExpK3czUDV5VWpyWFl1TXpPaGJPNGdCK3M0?=
 =?utf-8?B?L1V3aVljYzk1Z3c0TXZPR2kzemJRNjQxRk9ianBBTWF2T01pTEZhVXQ3Njl6?=
 =?utf-8?B?WFVBWS83ejd0OWZCWEcyYkw2MTh5cGZaUklQVUNOK25uVjZTRytGeXdCbk4v?=
 =?utf-8?B?d0xOUk8weUdJcVJ2NVBKT2xFV3kvYkpXNHhxS2VDN1ZaeS8yRGFMOTBkZTRl?=
 =?utf-8?B?UnFSbFBtcVpINThuQnBqR2ZRcDU0SWJ4M2hKVDRoS3RoL0R6RnFFcnhiOC9u?=
 =?utf-8?B?S3JUZGpiSVVYWVVQVmxNVkVabHFzVVBiZEdUN1JXM1hlWHoydlVkVUpBZDRy?=
 =?utf-8?B?WklFWVFrY3NwMkxDWlRrY3czRy9ZeFlMdmdHVmhtSC94YUVhdzBQMFE0dENO?=
 =?utf-8?B?VFBCNXg3QkdoaVVBTkhaS2ppeHlHdCs0VkMyeC9DZDZkUkN6cXVrVVkyU2Nk?=
 =?utf-8?B?alRWSlBaMFpNRmxxNzh3RjVHWXBMV2dZY25jYjU3V2RSNXpmZ1ZJWENjRm9J?=
 =?utf-8?B?dkkvOWN0ZWJnRzhxSkgxSzBncWwwU1NUUlFmYkFJdjJub2xPMUlGc1JtUE4x?=
 =?utf-8?B?SlBtNGxtSGUzT3dudkN2MFp0Lzlaa3AyeFdBaHZxZ0pNNjYxdTJXYjQveGYz?=
 =?utf-8?B?ZE16Q0llcy96MWZvdE5Ia015NkxZUERiUng2QTJpT1c3NVIzM1NrbDZuUzRV?=
 =?utf-8?B?cm9NYWpuajRoNzlVREZSVVRRUWdTZjIzZ2trblA0OEtkSFVjMXZMa3Z0UWs4?=
 =?utf-8?B?RGFxaGlDRTZnaXA0OE94RGYySHlHc2J2ZCtmNEJYaDdTeTZnV0Q3eFdXOVA1?=
 =?utf-8?B?emo4RGRZZFhrdnF6NGw1MHVsUlhDM3JpdENiemN0clpDSXlTalJJK2hmUVlv?=
 =?utf-8?B?RWl4Mi8vWWFTaVhNcG02QlVhRkkzMlZuSkdLZTErMmZUbW9HeGowWnpCT0lj?=
 =?utf-8?B?RWd3TEVaL0kwUjdMNy9SNEU1NEZsRGR3bUJpWVIxejF1OERFK3VxL1BvcWZQ?=
 =?utf-8?B?bzlGdkswVTZKSldMWUErc1Q4Tyt6Tk04Yis5V0ppMk1vYlQzVXpoMStmQTZX?=
 =?utf-8?B?d0tXbmlXaTRDTTRoeDNoL3puNXFlUUl4bFI0SGpJeUNGcHl0bEtxNWZtbUlD?=
 =?utf-8?B?Mm9ORWRSUnBGdmxoUUZnRnFUb0pQZ2ZUbDlwTVdyOXJyUXUrbVoxM2F0SUNI?=
 =?utf-8?B?MXZUZVN6aVVoMXhtMEJlVHNsb25vZEFFZ2JFMGlvSlRTWk1mVndzTkpkdWk5?=
 =?utf-8?B?ZFlmbGEwejFQYTBmckJTSU9TbG9JTHozeGtMcVVwNDNvZ2xwaUM2WFlNSHFy?=
 =?utf-8?B?dXBkSzFFeUs2TzdwWHd0ZUVNamxRKzFMWTZISEdNempjWGFWMmhBUT09?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb493565-7525-44bc-2f24-08da1c2f0820
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 02:49:15.0620 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9uUGgCXIomwtBQtPZIMszzC+ZdiQ2Nhg6qEuPchCxE4PPmOk9dVY7XmDPGQ/ijqLYaG3Gy8+uP7NwMutM0WRvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4537
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>, David
 Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>
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

> From: Robin Murphy <robin.murphy@arm.com>
> Sent: Friday, April 8, 2022 6:12 PM
> 
> On 2022-04-08 10:08, Tian, Kevin wrote:
> >> From: Jason Gunthorpe <jgg@nvidia.com>
> >> Sent: Friday, April 8, 2022 3:08 AM
> >> On Thu, Apr 07, 2022 at 07:02:03PM +0100, Robin Murphy wrote:
> >>> On 2022-04-07 18:43, Jason Gunthorpe wrote:
> >>>> On Thu, Apr 07, 2022 at 06:03:37PM +0100, Robin Murphy wrote:
> >>>>> At a glance, this all looks about the right shape to me now, thanks!
> >>>>
> >>>> Thanks!
> >>>>
> >>>>> Ideally I'd hope patch #4 could go straight to device_iommu_capable()
> >> from
> >>>>> my Thunderbolt series, but we can figure that out in a couple of weeks
> >> once
> >>>>
> >>>> Yes, this does helps that because now the only iommu_capable call is
> >>>> in a context where a device is available :)
> >>>
> >>> Derp, of course I have *two* VFIO patches waiting, the other one
> touching
> >>> the iommu_capable() calls (there's still IOMMU_CAP_INTR_REMAP,
> which,
> >> much
> >>> as I hate it and would love to boot all that stuff over to
> >>> drivers/irqchip,
> >>
> >> Oh me too...
> >>
> >>> it's not in my way so I'm leaving it be for now). I'll have to rebase that
> >>> anyway, so merging this as-is is absolutely fine!
> >>
> >> This might help your effort - after this series and this below there
> >> are no 'bus' users of iommu_capable left at all.
> >>
> >
> > Out of curiosity, while iommu_capable is being moved to a per-device
> > interface what about irq_domain_check_msi_remap() below (which
> > is also a global check)?
> 
> I suppose it could if anyone cared enough to make the effort - probably
> a case of resolving specific MSI domains for every device in the group,
> and potentially having to deal with hotplug later as well.
> Realistically, though, I wouldn't expect systems to have mixed
> capabilities in that regard (i.e. where the check would return false
> even though *some* domains support remapping), so there doesn't seem to
> be any pressing need to relax it.
> 

Yes, that makes sense if no such example so far.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
