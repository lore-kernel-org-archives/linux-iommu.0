Return-Path: <SRS0=mUms=NC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06701C4338F
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 09:26:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83E2F60EBD
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 09:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 83E2F60EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49EE060850;
	Wed, 11 Aug 2021 09:26:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LbriTJ0XECk1; Wed, 11 Aug 2021 09:26:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2A30E60597;
	Wed, 11 Aug 2021 09:26:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E57C2C0010;
	Wed, 11 Aug 2021 09:26:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45B69C000E
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 09:26:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 26EAB60832
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 09:26:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qltjiLQk3ILF for <iommu@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 09:26:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 56DAC60597
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 09:26:11 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="215078669"
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; d="scan'208";a="215078669"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2021 02:26:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; d="scan'208";a="460686716"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by orsmga007.jf.intel.com with ESMTP; 11 Aug 2021 02:26:06 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 11 Aug 2021 02:26:06 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 11 Aug 2021 02:26:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 11 Aug 2021 02:26:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 11 Aug 2021 02:26:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivf6VzguRs8cxDMjYwywR1AyCs/pUQR4dMjwz11j65Wk6y0BJhm2LICUGwHK6RVBs8lLhzweoDm0cjQ6FdRYo2cPdBLe6ortFKQYAtcudUMIsW629yN7Vc/9ijzo4dwb6zm1DFlvkaHb+jSuNkQeOQxY1ku8dlP+rXLZN0yzlMZ0l5raWljddOkFIpWoTyeTlUYlL3d6OVksW+jKCDu8Iv+Kmvpgh5USZEb72Xo5DPsmA/qEjdzlCd+n9UpOWidXKKLzlM9AtBW99lbw83UFlNASaiC7f8ewom/gdeI+Ihw5a12VbFYISZHYG+mmnpz9MLR+geSnTTFROdXLiF58SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOQouPkp/RdrRYV2Lnd6WgKOYU2v5bGth5epdNLKc1k=;
 b=IUn4VBYcYWoMYpV5WAzMSopdkbU5yUYjN7LjCDXhI3K5E9occmmWOfMm37y9Be4nzT1MPyVWdycjBdA7DuKe7SGyVGpuZSgMFJ+sKB5pRzMC12MjGAKX6uj584O2Ab/67Q1oxRrNcfvgUl3wy44FbuBdDPRRWUa2KgcMpITyJILGJosn3TZjI3WG9b9BzCSBgFykVBX7GQ2dPFvPN4fRLxfkQwHnDVL7flrMcCKE7NBQaH6kYwh2EBrtaGehMHzHTMXnZzcj40g4/d0gj4PBsXaOgJkAPI53kCo+JknYLXY23maJJ90Y/PYm8E1Mzm2JOYYh7XvKT/tbKeWFf1YAZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOQouPkp/RdrRYV2Lnd6WgKOYU2v5bGth5epdNLKc1k=;
 b=IU+PdkIKrbtd+BIrDG232pPsB4GT7uYY5l6IV36HL9XDTx55h6fBDMev4ZSIASRfj7yvADf6bbA+y1JFcTFXFQ13UGuR5Mj1L0LONAXt/rOFnuZ9PSr2fjKYxDPEiQD0xJDZkBSg4C7pFPjdLl6vSVfWlKtj9QVM9F/hDFoQedI=
Received: from PH0PR11MB4824.namprd11.prod.outlook.com (2603:10b6:510:38::13)
 by PH0PR11MB5128.namprd11.prod.outlook.com (2603:10b6:510:39::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Wed, 11 Aug
 2021 09:26:03 +0000
Received: from PH0PR11MB4824.namprd11.prod.outlook.com
 ([fe80::6167:48e3:2224:34f0]) by PH0PR11MB4824.namprd11.prod.outlook.com
 ([fe80::6167:48e3:2224:34f0%3]) with mapi id 15.20.4394.026; Wed, 11 Aug 2021
 09:26:03 +0000
From: "Mi, Dapeng1" <dapeng1.mi@intel.com>
To: David Stevens <stevensd@chromium.org>, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Subject: RE: [PATCH v3 5/5] dma-iommu: account for min_align_mask
Thread-Topic: [PATCH v3 5/5] dma-iommu: account for min_align_mask
Thread-Index: AQHXjlrYm0R+OxTpa0yaHYd4ePRmHatuBj8A
Date: Wed, 11 Aug 2021 09:26:02 +0000
Message-ID: <PH0PR11MB48249799E5C66534F9C37D8BCDF89@PH0PR11MB4824.namprd11.prod.outlook.com>
References: <20210811024247.1144246-1-stevensd@google.com>
 <20210811024247.1144246-6-stevensd@google.com>
In-Reply-To: <20210811024247.1144246-6-stevensd@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8c631df-7eb1-4070-3abc-08d95caa09fd
x-ms-traffictypediagnostic: PH0PR11MB5128:
x-microsoft-antispam-prvs: <PH0PR11MB5128C756E9B09552B24BB53BCDF89@PH0PR11MB5128.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cdv9sKNdbE9IwyL7qUcRAnN3ceyIKSTHGGckbllMPr5K9mzP9riuuQ/yBfH5GFbyxbOlZHCWTk/dDHVb3CLbJWYGw8plL9bvlYgwVMt8Tky7S2uEe5Eqlln1avfA1B/UhJlIrm2hD6793y7vHTXfTqBfpjR1Xu7T7bmq9QtV0QIFprAjtQj8wPhXioz/jBFCHc1eDvne1AyXZxdp4qsPxqQ8xf4yPy31lGP2FJHNlJEianvx/az3vm+WrcE2VcFBO1jQhCdB0q7y/dcI1aM0YUzPLZjlFCrkuTAqBpEcXzods0nVSYjXeOwuktX7JKAfve+hcmfYolQW4kQrscp2M7H3O/VQpUyfkDriQE3dZflkNAuwgvgrvXESR6L/o3NgPFBZ1nHRBzsxF3nuXz3d3B/9x+od037PLiRkmSd3OGKlWx40hv8+maDCo6M3mA6s/ENONXYIGdyP7dL/6ZYJYfnBvjhuf8H3RTPyE4BrExACIAT+HveYgnHr7B5uckzT+5hNBZq3SDeqit32ce8wPaBoYcyh30uBNgmotWoKsBZWOrLo8p7eEH5iA6iGqzyl1dCcNwcfpNKweugENZasAb93uVOGhXYb4a5jzyPERnM8bJhzDp6BXInChRVoVgWTMmkT8vMm7+6Z+lkczI7JTOPrG8vyPVHIX9JMaJd6i+UWkFKOdm+S1vJyYfwwX/3MQrAr1RjjI9HpAr4Hi1sVAA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4824.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(316002)(15650500001)(7696005)(33656002)(186003)(4326008)(2906002)(38070700005)(26005)(5660300002)(8676002)(52536014)(66946007)(53546011)(71200400001)(38100700002)(64756008)(66556008)(55016002)(66446008)(86362001)(76116006)(66476007)(6506007)(122000001)(9686003)(478600001)(8936002)(110136005)(83380400001)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?06mi3O1SkTnNYmjpqGzbyZXIq1MDJ3aSeyCmjYvHli1GkLyM4bwCWDTFoKBM?=
 =?us-ascii?Q?ueErWltGxMA5rtS87tpRBBLCNJmppcS437Bbs9J5r418rBktm9TPXbN84dtB?=
 =?us-ascii?Q?NZTcEM0SAdPx/G4s2MltcvkN9Y+7nv41VvDfc1FIxJ47aMm15VUjAxtdTLHH?=
 =?us-ascii?Q?JjOgb06cryn2w92f42tzpLjPQFRTM1fnsOZXtRux7F8EN8zbk6rpkou8Io7P?=
 =?us-ascii?Q?wG0Xm0wafJV5Obln5jJFL2hq6xwAH+JaZftNGHZn8IRYuxnTbM3fj0QWKrUN?=
 =?us-ascii?Q?o6HqSd4BurpB6tzRn9IeYgLWrLD1kn0Xdjep+iEzDfBMhXAg52DcvwKwrfc9?=
 =?us-ascii?Q?L6YBsdoKyBvgI1u8Iwwjqw6L3ZOIrKZaJcJXK7eFoAjdpRaLoLMRUtRV5akQ?=
 =?us-ascii?Q?I/Kwq6lxZb+AL5r9phVPQ/6FsL8nt5Xg8oAnkGNtUyBAgopvmArgtcTVK0k2?=
 =?us-ascii?Q?riEw4IBTv4GpczmtGVU74Qc1ZWfnWnscDW7V5hVYVfaYPCyEcvKTdmVpEUHU?=
 =?us-ascii?Q?DxCC0UagnHExWCYoBPG77u7LvOmKgBYrDnFnd6VdPEwcpKtVvBzRbZRGDJar?=
 =?us-ascii?Q?MJN+dp4NZ/itewFteV3iPKLnh9Tp12gvrhoz6yVoTTJAhk/vSPgrcm9v9hhC?=
 =?us-ascii?Q?RQQbKY0bLHVfPuyMXGO2nDN96o6Bq7MGrB2cvOprluQT+4JVHv3IxtSUACPe?=
 =?us-ascii?Q?phci3ypK56VYP9VwV9L5vu/pgBPLqot1bhG8/1xep3WT7jQC05Aw5kou46lz?=
 =?us-ascii?Q?cAos5+ST5GmmmM3Iv33X/rvOoP+mfuvv37lNhv7/TGSu/neeOZDqB+NdvgoD?=
 =?us-ascii?Q?luGXuiyBlWL/zE2nLLcpgtJuO8Rb66c1+ECbVP9M+vocyJukMfQl+0ip3/l7?=
 =?us-ascii?Q?RLz1C6/xSdpdrTZNP85yMeErsThhGTCCp8S7/J+5Wvxdagwa1PrTO2Ya7w85?=
 =?us-ascii?Q?x8+cKeYTnWIm9qWvjgz5IvA1iu06oqaq54feFM7eN1LoqCNCrMm4hNcHWqED?=
 =?us-ascii?Q?2ELDn/vxlEGHF91sKhwvYZ8ujcVNh12XxnmFAMuZmk7ORES0xGRuYfjmGywK?=
 =?us-ascii?Q?Mhl1afLB/dJSX3+QU8SbQnlXC17OmrCJZcQp47FnJyZvdi6qPVJ8+1eIkmCC?=
 =?us-ascii?Q?nfDgjqPMfgLa9pPk6FoC3o+PMi4QEjAOOjXj7Zfm4XnwrmQJlMg1RMm8P8m4?=
 =?us-ascii?Q?PA3jBHp6PT5OfwgLP1Z5tT9ZoWU5kn7E76SZE+K3lQXxi+oy3srgr5PoyaEO?=
 =?us-ascii?Q?zs6lbMQ05RPYTTHy3KUQhlSGxuVt/JS6jxKPc1Z2qBFwtmGMcYvh7OOa4RJn?=
 =?us-ascii?Q?g+a28ToelK5gjsyPLEzFUGHW?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c631df-7eb1-4070-3abc-08d95caa09fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 09:26:02.9988 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yqWcG0VQO5lv5xOw7XQQnPq5+yHKicoVc4Rt8c9tVfqIaIDWeBSIWk4dcwGCnnzDc9t24HfIYWAKOAlgrgLWXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5128
X-OriginatorOrg: intel.com
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Tom Murphy <murphyt7@tcd.ie>
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

> -----Original Message-----
> From: iommu <iommu-bounces@lists.linux-foundation.org> On Behalf Of
> David Stevens
> Sent: Wednesday, August 11, 2021 10:43 AM
> To: Robin Murphy <robin.murphy@arm.com>; Will Deacon <will@kernel.org>
> Cc: linux-kernel@vger.kernel.org; Tom Murphy <murphyt7@tcd.ie>;
> iommu@lists.linux-foundation.org; David Stevens <stevensd@chromium.org>
> Subject: [PATCH v3 5/5] dma-iommu: account for min_align_mask
> 
> From: David Stevens <stevensd@chromium.org>
> 
> For devices which set min_align_mask, swiotlb preserves the offset of the
> original physical address within that mask. Since __iommu_dma_map
> accounts for non-aligned addresses, passing a non-aligned swiotlb address
> with the swiotlb aligned size results in the offset being accounted for twice in
> the size passed to iommu_map_atomic. The extra page exposed to DMA is
> also not cleaned up by __iommu_dma_unmap, since tht at function unmaps
> with the correct size. This causes mapping failures if the iova gets reused,
> due to collisions in the iommu page tables.
> 
> To fix this, pass the original size to __iommu_dma_map, since that function
> already handles alignment.
> 
> Additionally, when swiotlb returns non-aligned addresses, there is padding at
> the start of the bounce buffer that needs to be cleared.
> 
> Fixes: 1f221a0d0dbf ("swiotlb: respect min_align_mask")
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>  drivers/iommu/dma-iommu.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 89b689bf801f..ffa7e8ef5db4 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -549,9 +549,8 @@ static dma_addr_t
> __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
>  	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>  	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>  	struct iova_domain *iovad = &cookie->iovad;
> -	size_t aligned_size = org_size;
> -	void *padding_start;
> -	size_t padding_size;
> +	void *tlb_start;
> +	size_t aligned_size, iova_off, mapping_end_off;
>  	dma_addr_t iova;
> 
>  	/*
> @@ -566,24 +565,26 @@ static dma_addr_t
> __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
>  		if (phys == DMA_MAPPING_ERROR)
>  			return DMA_MAPPING_ERROR;
> 
> -		/* Cleanup the padding area. */
> -		padding_start = phys_to_virt(phys);
> -		padding_size = aligned_size;
> +		iova_off = iova_offset(iovad, phys);
> +		tlb_start = phys_to_virt(phys - iova_off);
> 
> +		/* Cleanup the padding area. */
>  		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
>  		    (dir == DMA_TO_DEVICE ||
>  		     dir == DMA_BIDIRECTIONAL)) {
> -			padding_start += org_size;
> -			padding_size -= org_size;
> +			mapping_end_off = iova_off + org_size;
> +			memset(tlb_start, 0, iova_off);
> +			memset(tlb_start + mapping_end_off, 0,
> +			       aligned_size - mapping_end_off);
> +		} else {
> +			memset(tlb_start, 0, aligned_size);
>  		}

Nice fix. It's better move the "cleanup ..." comment into if case which looks more accurate.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
