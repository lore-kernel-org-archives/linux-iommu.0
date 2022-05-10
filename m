Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C575C433F5
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 00:56:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D9B1A4019A;
	Tue, 10 May 2022 00:56:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M2RVi8vCn1QN; Tue, 10 May 2022 00:56:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8237B4002B;
	Tue, 10 May 2022 00:56:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B73FC0039;
	Tue, 10 May 2022 00:56:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F9B3C002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 00:56:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F9FB60AAA
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 00:56:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W3dd2sZ1Kplv for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 00:56:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E53FB60AA4
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 00:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652144191; x=1683680191;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mO6oNxRKoMmIMgC7eKdYxGy/D5GlgxWRFYSSzIhKF4A=;
 b=bA3juoudq1Y7keRbP43DkKuZF3466VCDImnsmWqtSIHUlxaX5C2GKqSP
 7aBR/ruwmxpZzybzOv4ROeUZV1mBxxT6wYrlobnmmrwd+/s16UIMFi5oy
 oDnM3tkgbraGLqJj9dGAZ+T3yDB9utFEUVszBsdC9a0fnBn8OqGiOqbDR
 Iyj53gjkgk2Oq/OJ5hPoQyVTs3/iz1NJGQxlQCOw0TBIkd/SVyzee1Zpa
 3Jodi5ON3a+am2qnhHJd67uKIkA6CDlQCaVgSvNzn1sfEMuOP8iBuVIRV
 6cIHTLCrKwEjZ589hOlOqSgB/CtlUUMSqcoO3AaraOagCLL7eQMMNlmze Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="268057715"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="268057715"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2022 17:56:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="593177915"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga008.jf.intel.com with ESMTP; 09 May 2022 17:56:26 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 9 May 2022 17:56:26 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 9 May 2022 17:56:26 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 9 May 2022 17:56:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 9 May 2022 17:56:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZFdc5jWIH/Xe+RsG7agqwVGidJJRbpU84UNAXLsuEaMGiqofzciq5lWFAyZ//863otCsEkZ5IvkgB+azhYpJvXk/b978tvN0CMgVkTYCenmpwVyXpzsprg1sSX/Wp8jvsD+RXkJiFX/KO1jfMv9GL+YRFCmiMa0aiDbCEDn6NoEjQucBuDdDdXKkoBQagTP/sKPGCsZhq+yOxfTuDbQiH8M2J56DDOGHqo0XRkm0eUZovwT9Iose5sJwOLQeY06+sSjdkB+fgNku72WuxMAZ2sczhiz/dBd+fDlREYJpFThBm5YkVfKHqx/K8I24msm5ERYuUcO0SeetWkj3r/Ohw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrnBOuUVUkUtSKvlhwsodTjyHPDT789v+vqllBniN7I=;
 b=ZRK21dZsOKTqIn7zzl2DIuMIuC11HI/IbE/6jlLrfclU844bVPCPWL9UwAcsKx7bi8uhMpdDCJwVWo/MTQTc3fGw5iGQ/Rjiy+L58XnhvMaCT+R3TXSgQHMq1qXKXdCl8zB6jPjFhbPqtHx4zdvIilHW3enIuRUirSvudzK5fUa8UUDUvvKmKXrzJZR//HbbGROdLhuhjT/mk/2O5Fq+3iA8xXa9UZHxzRUwxjlOm8SRXAQJLIwwo0/fJ0J8mkCAs+WranG2+8eVxRd4OBd6ObKj3OMDT7l7UJ2u/Qhp7TEE0fuCvW5D4F++uDnAqhCxXsiE8yFRSn+4fUImJ0/R3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL0PR11MB2946.namprd11.prod.outlook.com (2603:10b6:208:78::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 00:56:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 00:56:18 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>
Subject: RE: [PATCH v3] iommu: iommu_group_claim_dma_owner() must always
 assign a domain
Thread-Topic: [PATCH v3] iommu: iommu_group_claim_dma_owner() must always
 assign a domain
Thread-Index: AQHYY8CQUwDV1c8BeEm4xXLcaKyKqK0XSenQ
Date: Tue, 10 May 2022 00:56:18 +0000
Message-ID: <BN9PR11MB527648925787A39C9D15A97D8CC99@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-db7f0785022b+149-iommu_dma_block_jgg@nvidia.com>
In-Reply-To: <0-v3-db7f0785022b+149-iommu_dma_block_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1bfaeee-1d95-4320-2a6f-08da321fe4b1
x-ms-traffictypediagnostic: BL0PR11MB2946:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BL0PR11MB29464B2E9F62D98683E708618CC99@BL0PR11MB2946.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BusylYbBGUIyu3bVl+UpThM9cf1wpCaQVm0H6IY2MdA311WpN3KMUL6BMCbtlWf7POfrGhNrhRssNdfiY34wnJkIDtokuwm8GRxoP8Nrz9H9sOBoQUQs27oWUuO4VvEsOc6CxY97OxG8UK11nNfp82RZjyxUSy6u11ClcueKnut87jkBWeVZsnS6RsH/zchQYBJ5t/0Fla9OYxDpg4aIQFR131nYjRltQF61XnpHg98/OyQgzsaQagtYcfc+V+oL1GPlsEiHZ8BHTCuEUJaF/1+AMs3ZLusH4QOlMgSzcJDMo7mjGuA3U1YMM2dJm8doZiTldPBczmO8Iu+ajuNEiny/oe6PTktdYpkN+0FX/6VsWrHDBZQ1JA+QXlFzHbPMnrkdko3jkjPkF8/zd0SoS4bKdUjpN/DmEzWduTuFO+JBVWuhHjc29FdOOg/nxlJFYtRflpuO3WlgkPSjamohxGOv4ExOtdLtlknezJVD1h7hlUS/6qDpp1gdcEuwvOTdaFSgc1EFdyt+lS1hy8jd4waM1cKJL+9yXts0US3dqoaj5zxPIitr5ZyDg3q5Q7001eTP9VoxLfAdG63pGfbQCLus1nAjgbOUhi+RBvTF7SI69Cj6S7MHzJRfSiW5n4wxslL74entNn8sA/kHREp4z4lkUdNimU304LJtE8mNtWGuqN7jCvYyHnkhexRCJD+vajrsNAWYphTNqfSq/IEaVwTzTN4p5szAcq6A+zhp8zi3BiXgvFhNT57L/B1vZ8Abp5QRZQiMmDMlnCItUmnkHHJxytrEsD3Mk9PPFcMbMGqAs9BiC+Yq55KfGDKGVI1ytpC7+/G9SU1Axcz/w1e0Gw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(7696005)(9686003)(316002)(6506007)(33656002)(186003)(26005)(83380400001)(71200400001)(966005)(54906003)(508600001)(2906002)(8676002)(86362001)(8936002)(5660300002)(64756008)(4326008)(66446008)(66476007)(66946007)(66556008)(76116006)(122000001)(55016003)(52536014)(30864003)(38070700005)(82960400001)(38100700002)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BQDB+uheF+VOEGzKSYNr3/sOVWtaJkRjFkeSUKcHfWTTUxQr39fJVUKyz6tA?=
 =?us-ascii?Q?NH1AdWdUDk7BQEsD21EhXzU5zeR/BrOc2OuDTlZ1Ks35Ckr+4TboTlx5SpPX?=
 =?us-ascii?Q?Jt8XCHgefSU7z48svtdCjLwgkYnlEbwaF8H1GDmPItWXnfHTKJNqQ8LsMxQo?=
 =?us-ascii?Q?xdx7UJW06LwenPslQbboUWw/dGW26j8yyi3PQIenvUOTH+o0w+SAL6SGFh7z?=
 =?us-ascii?Q?BcqtGNRzZRKk62Hzzqs1jfVycsuNoNwP7trU/3yzg6wnHViB+GcNEnYgTWJs?=
 =?us-ascii?Q?XHX0negXiIyEBgJtvZf9G/lCTzp1JN8QMPHTt59Oq7CvXhWgwsVsL/JJq10D?=
 =?us-ascii?Q?z70mzMgePwRBTKLptjN7NaDqJONLqKdnphQPS80HmiowsfIwCum9mxX2FVB8?=
 =?us-ascii?Q?WHfam6un0xOmJiOmMbeeHgRAJMOY20HjWTYxXK3zjpM3dCarNfudGI38dNwj?=
 =?us-ascii?Q?BQX3GV97Ba6uWRw/br0ROfVVD6bVzWwpnO7KYsaQXVCNZcg/eHtW+AL2nfJl?=
 =?us-ascii?Q?HExLRI1oIJE4a/6mn0t4oW5k+sPa2zMHiV6FJMyiXHVxnBouEK8Wa1h+OglM?=
 =?us-ascii?Q?lw4gCG/y6t0/yJLHZRhFQD6QQsKFO0z2NzNBf1XEvAIEDKkY/6QBUnNV60Qh?=
 =?us-ascii?Q?/xOCdSPAwjokRLZoV9tadU5t/hcxsFJubmgc6+WstDddrHzaIZj3kYTe+M/3?=
 =?us-ascii?Q?YeWuPZjtcjRMUvoI6WDwqKs5vVzf+5t1XcyZBFcCIgM4iRtkysPPgvMtUHOI?=
 =?us-ascii?Q?OvWoEjzZ53ygvbPo0yUayvGxQBltfZd7dYDT7brn5XjvvkuA4DP7CpkihR+g?=
 =?us-ascii?Q?xCSgahnY1g38QV/pPB3TfUuqJFExAazefUOIR4Xl6EgEZOyoEeq6Y3aTygVC?=
 =?us-ascii?Q?kJCBQ4DHYM5nu8ME8WmUaOX4F7VaghfKd/dRAXow3OCZhqlgS7Voyed7jr87?=
 =?us-ascii?Q?plp3nE0Nu30OI7ASDlB5FX+rASMp0WB1hrvRIDIP2/owr1lMqR2ESKyBT8IM?=
 =?us-ascii?Q?cK3IQ1wLG6vnt1Ay3Pum5m6zfZMuo9PuLB+epFrrZrsejpnTw/cZgKbfHe4F?=
 =?us-ascii?Q?jGo33j1vsETWvYyO2eFUAWu+l95mDcR4LX5820iRqouVmsWVmkt2/hV/bd6C?=
 =?us-ascii?Q?efe/T0H8Yms3aGb0DLXkcjQREiyfijoHH2WYmxsfNmQjAsqioecArpxi4rv3?=
 =?us-ascii?Q?NTVqkHIkYVaf+0g9atRrNtjg2zC0efv52pLaZPTxxLFvE0RB6QGoJ0j5FJAe?=
 =?us-ascii?Q?poWTPJexRBOY4LDsg3EtwKe/on2Ox2eATJc/voaZ06Nhc0LD08gk07WFx2gg?=
 =?us-ascii?Q?O3lY6EihaR28d2AQpzwzNJCNuW3dBx89KStLtqEQ0le2wPac8J34EUdGRNtp?=
 =?us-ascii?Q?IuTS5fpc8MULcDAES3OhAZgrWfT0IfxE1ELacu1QzWz8nwpve1i/1PeUCY72?=
 =?us-ascii?Q?VAzyTQBj8MwVuvBxWf5rXvXAuaYreTwkzJqjrHnAGyOEbysg8DY9smseeICT?=
 =?us-ascii?Q?8E8aWlHaZut13dlq+X32E4hVKmpNBXEiM9NjsFuqrVWu4C8X2I/frqgyDPiG?=
 =?us-ascii?Q?UyLZYgBLr9aS8OUwBTObVP6FSxhMxe9hLwWJj8RBxvFCP6H7kug6Tn0DApp8?=
 =?us-ascii?Q?NoJ/LGs6gKH94DYtoWFnCp1BDjJ/AKyAKVoN2ZsOeOXgAd/JiIzSHtFU4K//?=
 =?us-ascii?Q?5jU5Rfy2IzhpSDabW/yn+8a52430bSgkoQ5cxSai2QhxI/iZAVvXWmNwcgfp?=
 =?us-ascii?Q?le74ZGOBXw=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1bfaeee-1d95-4320-2a6f-08da321fe4b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 00:56:18.7912 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pu3YEsxV+hNGDaRAX85+IWXQ86D6ef/Z9uYRemmx7m42Mjf1ABqBoSBqjRpPAkpUrJpblszAPOm3Bn2fvtNLQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB2946
X-OriginatorOrg: intel.com
Cc: Qian Cai <quic_qiancai@quicinc.com>, "Rodel, Jorg" <jroedel@suse.de>,
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, May 10, 2022 12:19 AM
> 
> Once the group enters 'owned' mode it can never be assigned back to the
> default_domain or to a NULL domain. It must always be actively assigned to
> a current domain. If the caller hasn't provided a domain then the core
> must provide an explicit DMA blocking domain that has no DMA map.
> 
> Lazily create a group-global blocking DMA domain when
> iommu_group_claim_dma_owner is first called and immediately assign the
> group to it. This ensures that DMA is immediately fully isolated on all
> IOMMU drivers.
> 
> If the user attaches/detaches while owned then detach will set the group
> back to the blocking domain.
> 
> Slightly reorganize the call chains so that
> __iommu_group_set_core_domain() is the function that removes any caller
> configured domain and sets the domains back a core owned domain with an
> appropriate lifetime.
> 
> __iommu_group_set_domain() is the worker function that can change the
> domain assigned to a group to any target domain, including NULL.
> 
> Add comments clarifying how the NULL vs detach_dev vs default_domain
> works
> based on Robin's remarks.
> 
> This fixes an oops with VFIO and SMMUv3 because VFIO will call
> iommu_detach_group() and then immediately iommu_domain_free(), but
> SMMUv3 has no way to know that the domain it is holding a pointer to
> has been freed. Now the iommu_detach_group() will assign the blocking
> domain and SMMUv3 will no longer hold a stale domain reference.
> 
> Fixes: 1ea2a07a532b ("iommu: Add DMA ownership management
> interfaces")
> Reported-by: Qian Cai <quic_qiancai@quicinc.com>
> Tested-by: Baolu Lu <baolu.lu@linux.intel.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Co-developed-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

> --
> 
> Just minor polishing as discussed
> 
> v3:
>  - Change names to __iommu_group_set_domain() /
>    __iommu_group_set_core_domain()
>  - Clarify comments
>  - Call __iommu_group_set_domain() directly in
>    iommu_group_release_dma_owner() since we know it is always selecting
>    the default_domain
> v2: https://lore.kernel.org/r/0-v2-f62259511ac0+6-
> iommu_dma_block_jgg@nvidia.com
>  - Remove redundant detach_dev ops check in __iommu_detach_device and
>    make the added WARN_ON fail instead
>  - Check for blocking_domain in __iommu_attach_group() so VFIO can
>    actually attach a new group
>  - Update comments and spelling
>  - Fix missed change to new_domain in iommu_group_do_detach_device()
> v1: https://lore.kernel.org/r/0-v1-6e9d2d0a759d+11b-
> iommu_dma_block_jgg@nvidia.com
> 
> ---
>  drivers/iommu/iommu.c | 127 ++++++++++++++++++++++++++++++------------
>  1 file changed, 91 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0c42ece2585406..0b22e51e90f416 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -44,6 +44,7 @@ struct iommu_group {
>  	char *name;
>  	int id;
>  	struct iommu_domain *default_domain;
> +	struct iommu_domain *blocking_domain;
>  	struct iommu_domain *domain;
>  	struct list_head entry;
>  	unsigned int owner_cnt;
> @@ -82,8 +83,8 @@ static int __iommu_attach_device(struct
> iommu_domain *domain,
>  				 struct device *dev);
>  static int __iommu_attach_group(struct iommu_domain *domain,
>  				struct iommu_group *group);
> -static void __iommu_detach_group(struct iommu_domain *domain,
> -				 struct iommu_group *group);
> +static int __iommu_group_set_domain(struct iommu_group *group,
> +				    struct iommu_domain *new_domain);
>  static int iommu_create_device_direct_mappings(struct iommu_group
> *group,
>  					       struct device *dev);
>  static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
> @@ -596,6 +597,8 @@ static void iommu_group_release(struct kobject
> *kobj)
> 
>  	if (group->default_domain)
>  		iommu_domain_free(group->default_domain);
> +	if (group->blocking_domain)
> +		iommu_domain_free(group->blocking_domain);
> 
>  	kfree(group->name);
>  	kfree(group);
> @@ -1907,6 +1910,24 @@ void iommu_domain_free(struct iommu_domain
> *domain)
>  }
>  EXPORT_SYMBOL_GPL(iommu_domain_free);
> 
> +/*
> + * Put the group's domain back to the appropriate core-owned domain -
> either the
> + * standard kernel-mode DMA configuration or an all-DMA-blocked domain.
> + */
> +static void __iommu_group_set_core_domain(struct iommu_group *group)
> +{
> +	struct iommu_domain *new_domain;
> +	int ret;
> +
> +	if (group->owner)
> +		new_domain = group->blocking_domain;
> +	else
> +		new_domain = group->default_domain;
> +
> +	ret = __iommu_group_set_domain(group, new_domain);
> +	WARN(ret, "iommu driver failed to attach the default/blocking
> domain");
> +}
> +
>  static int __iommu_attach_device(struct iommu_domain *domain,
>  				 struct device *dev)
>  {
> @@ -1963,9 +1984,6 @@ static void __iommu_detach_device(struct
> iommu_domain *domain,
>  	if (iommu_is_attach_deferred(dev))
>  		return;
> 
> -	if (unlikely(domain->ops->detach_dev == NULL))
> -		return;
> -
>  	domain->ops->detach_dev(domain, dev);
>  	trace_detach_device_from_domain(dev);
>  }
> @@ -1979,12 +1997,10 @@ void iommu_detach_device(struct
> iommu_domain *domain, struct device *dev)
>  		return;
> 
>  	mutex_lock(&group->mutex);
> -	if (iommu_group_device_count(group) != 1) {
> -		WARN_ON(1);
> +	if (WARN_ON(domain != group->domain) ||
> +	    WARN_ON(iommu_group_device_count(group) != 1))
>  		goto out_unlock;
> -	}
> -
> -	__iommu_detach_group(domain, group);
> +	__iommu_group_set_core_domain(group);
> 
>  out_unlock:
>  	mutex_unlock(&group->mutex);
> @@ -2040,7 +2056,8 @@ static int __iommu_attach_group(struct
> iommu_domain *domain,
>  {
>  	int ret;
> 
> -	if (group->domain && group->domain != group->default_domain)
> +	if (group->domain && group->domain != group->default_domain &&
> +	    group->domain != group->blocking_domain)
>  		return -EBUSY;
> 
>  	ret = __iommu_group_for_each_dev(group, domain,
> @@ -2072,38 +2089,49 @@ static int
> iommu_group_do_detach_device(struct device *dev, void *data)
>  	return 0;
>  }
> 
> -static void __iommu_detach_group(struct iommu_domain *domain,
> -				 struct iommu_group *group)
> +static int __iommu_group_set_domain(struct iommu_group *group,
> +				    struct iommu_domain *new_domain)
>  {
>  	int ret;
> 
> +	if (group->domain == new_domain)
> +		return 0;
> +
>  	/*
> -	 * If the group has been claimed already, do not re-attach the default
> -	 * domain.
> +	 * New drivers should support default domains and so the
> detach_dev() op
> +	 * will never be called. Otherwise the NULL domain represents some
> +	 * platform specific behavior.
>  	 */
> -	if (!group->default_domain || group->owner) {
> -		__iommu_group_for_each_dev(group, domain,
> +	if (!new_domain) {
> +		if (WARN_ON(!group->domain->ops->detach_dev))
> +			return -EINVAL;
> +		__iommu_group_for_each_dev(group, group->domain,
>  					   iommu_group_do_detach_device);
>  		group->domain = NULL;
> -		return;
> +		return 0;
>  	}
> 
> -	if (group->domain == group->default_domain)
> -		return;
> -
> -	/* Detach by re-attaching to the default domain */
> -	ret = __iommu_group_for_each_dev(group, group->default_domain,
> +	/*
> +	 * Changing the domain is done by calling attach_dev() on the new
> +	 * domain. This switch does not have to be atomic and DMA can be
> +	 * discarded during the transition. DMA must only be able to access
> +	 * either new_domain or group->domain, never something else.
> +	 *
> +	 * Note that this is called in error unwind paths, attaching to a
> +	 * domain that has already been attached cannot fail.
> +	 */
> +	ret = __iommu_group_for_each_dev(group, new_domain,
>  					 iommu_group_do_attach_device);
> -	if (ret != 0)
> -		WARN_ON(1);
> -	else
> -		group->domain = group->default_domain;
> +	if (ret)
> +		return ret;
> +	group->domain = new_domain;
> +	return 0;
>  }
> 
>  void iommu_detach_group(struct iommu_domain *domain, struct
> iommu_group *group)
>  {
>  	mutex_lock(&group->mutex);
> -	__iommu_detach_group(domain, group);
> +	__iommu_group_set_core_domain(group);
>  	mutex_unlock(&group->mutex);
>  }
>  EXPORT_SYMBOL_GPL(iommu_detach_group);
> @@ -3088,6 +3116,29 @@ void
> iommu_device_unuse_default_domain(struct device *dev)
>  	iommu_group_put(group);
>  }
> 
> +static int __iommu_group_alloc_blocking_domain(struct iommu_group
> *group)
> +{
> +	struct group_device *dev =
> +		list_first_entry(&group->devices, struct group_device, list);
> +
> +	if (group->blocking_domain)
> +		return 0;
> +
> +	group->blocking_domain =
> +		__iommu_domain_alloc(dev->dev->bus,
> IOMMU_DOMAIN_BLOCKED);
> +	if (!group->blocking_domain) {
> +		/*
> +		 * For drivers that do not yet understand
> IOMMU_DOMAIN_BLOCKED
> +		 * create an empty domain instead.
> +		 */
> +		group->blocking_domain = __iommu_domain_alloc(
> +			dev->dev->bus, IOMMU_DOMAIN_UNMANAGED);
> +		if (!group->blocking_domain)
> +			return -EINVAL;
> +	}
> +	return 0;
> +}
> +
>  /**
>   * iommu_group_claim_dma_owner() - Set DMA ownership of a group
>   * @group: The group.
> @@ -3111,9 +3162,14 @@ int iommu_group_claim_dma_owner(struct
> iommu_group *group, void *owner)
>  			goto unlock_out;
>  		}
> 
> +		ret = __iommu_group_alloc_blocking_domain(group);
> +		if (ret)
> +			goto unlock_out;
> +
> +		ret = __iommu_group_set_domain(group, group-
> >blocking_domain);
> +		if (ret)
> +			goto unlock_out;
>  		group->owner = owner;
> -		if (group->domain)
> -			__iommu_detach_group(group->domain, group);
>  	}
> 
>  	group->owner_cnt++;
> @@ -3132,18 +3188,17 @@
> EXPORT_SYMBOL_GPL(iommu_group_claim_dma_owner);
>   */
>  void iommu_group_release_dma_owner(struct iommu_group *group)
>  {
> +	int ret;
> +
>  	mutex_lock(&group->mutex);
>  	if (WARN_ON(!group->owner_cnt || !group->owner))
>  		goto unlock_out;
> 
>  	group->owner_cnt = 0;
> -	/*
> -	 * The UNMANAGED domain should be detached before all USER
> -	 * owners have been released.
> -	 */
> -	if (!WARN_ON(group->domain) && group->default_domain)
> -		__iommu_attach_group(group->default_domain, group);
>  	group->owner = NULL;
> +	ret = __iommu_group_set_domain(group, group->default_domain);
> +	WARN(ret, "iommu driver failed to attach the default domain");
> +
>  unlock_out:
>  	mutex_unlock(&group->mutex);
>  }
> 
> base-commit: da844db4722bdd333142b40f0e414e2aedc2a4c0
> --
> 2.36.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
