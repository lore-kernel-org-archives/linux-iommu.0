Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E8EC433F5
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 10:56:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 52CBB40359;
	Thu,  5 May 2022 10:56:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zhN5NEcD_Fqk; Thu,  5 May 2022 10:56:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E54F94014A;
	Thu,  5 May 2022 10:56:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7A75C0039;
	Thu,  5 May 2022 10:56:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C358EC002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 10:56:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A4617812A0
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 10:56:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qxlx64p3j9l9 for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 10:56:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F0B6280DCC
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 10:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651748193; x=1683284193;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Q1DENICo36Vgk57xX8bvfV6pvJRokLg3rNQRrpwVqto=;
 b=ED6QjcBtTH6h18dlNvUa/m05TzD+EBI/K7jYIn9S+O4xXuLT8Md3/TEE
 IjfZcZkH1gN8AUIltBhlG7ydB3Q7f1pShG2BNhvwSnVBj3zcYyNDQF+Jx
 RtLKrXiJNobO8YZiJ64sKirMIKCAXHRIsafhE5MomUjV6olA4BJz1Z0/P
 /R8gAznZF9HKiXHgddcYov6TPnaxisRAl+IZBKr5uqgYxpkeM5cVYCDF8
 Lpdvmhj12ciOLbn6StE9gPAOBTAPYym4tZh3Ig48MahM0GDUEWUW4zzBl
 y7PcanOAITeDS7N6m62ScaogGRobef/uvAW1Jt35PiabnL+BqJS3Udop+ Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="266913944"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; d="scan'208";a="266913944"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 03:56:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; d="scan'208";a="537285339"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga006.jf.intel.com with ESMTP; 05 May 2022 03:56:32 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 5 May 2022 03:56:31 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 5 May 2022 03:56:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 5 May 2022 03:56:31 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 5 May 2022 03:56:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brqaFHa9pvA4+N+IJMp+Ypjmoxn37okIf2kzNjEWrqA9h8UOk7C1JeGh5U7uc7obN7yxQYeMKZ2/kedAuuzcPm2PIdrvnaIGeI7Mm/5W+5Q4Os12382JR+IFmc0hnkaeLxDGTGVL54U9l2uHvyjkQbdzIT6COpltfsB3eTB25sgu0dHgupnCrBV2NAdPwd3koWG8oeBLDPzCzht1jw83LXBTuhBRh/rShAG1qEDHyy49HAgnc1SAyGAn20e2WtAVQDoMFCI71Ytg5YSTAD93ix9DlX1gNTKbVZUaeJXUbsqpC8qgqrNPd/bivFULfy3HseYLh8d61jm8PwvVEy98cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htCR+BFvhKarACrOfuvf3SiaC/3Ab+Zq8tlBXWCQGCs=;
 b=eNAfSRTCENKsaSDlkj2WrHvALZ/72PeZS/xE2hvjYJxsZSrIT9IAYFuSrlHNT1gZtjXUhpYJX+g6dVFEVPx2g0JrK7vyyNNLMsISIw1bZjDfmtISChuHcU9uDIdLzjoTf/Pl9s33JMTTh9JeoQs1s+iKO2d3NqBQDDxbaGwUl+g5MkYMjUlLf+KgSW2tx1kQoa/njoAX7lwiYBnNSH/B8U6SuLRKwA7t4Nk9bB65Ev3f3DYb1BseGXQDAsvEaGlVrLE416EvrBPdaMLTR7ttZY7KreXk7Vtv93LzQnMO/z4PrtgJJB0AjiOf/DAg7B7r0tntg2RogIzWSZzSXuiu5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB5036.namprd11.prod.outlook.com (2603:10b6:806:114::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Thu, 5 May
 2022 10:56:28 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 10:56:28 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>
Subject: RE: [PATCH v2] iommu: iommu_group_claim_dma_owner() must always
 assign a domain
Thread-Topic: [PATCH v2] iommu: iommu_group_claim_dma_owner() must always
 assign a domain
Thread-Index: AQHYX+ptl9sLL9PiIEu4Iv7dSwQ2Ya0QGJJA
Date: Thu, 5 May 2022 10:56:28 +0000
Message-ID: <BN9PR11MB5276504B448C715527AD5F3F8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-f62259511ac0+6-iommu_dma_block_jgg@nvidia.com>
In-Reply-To: <0-v2-f62259511ac0+6-iommu_dma_block_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d671fa9-67ff-4025-429c-08da2e85e848
x-ms-traffictypediagnostic: SA2PR11MB5036:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SA2PR11MB5036F67D43D3496F00C7A4798CC29@SA2PR11MB5036.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q9dtIOZr0cUQYCn8JhnOgf/CA24+IvIA7dTmSxqOYfmVg67jjGGfVGYHdCEgQs5XLvrmlq9CkYZ61UX+iKfbxcddgIlylJEvER7imEjpy9lI3lVOXutgp7dV/2mVCS0GHL6TWSiC9eUXPQyv6YijTtTnrjaRIylSacF8uh8gET6BXBNZC1b/yWkfMmaFKNkf5UePmDV+RB9WKUgk4XVnkgL+ElbztNQf5Gq2InarseDNjs2KIBytZT5cChEdbU8RTkhpXgAued148+UNiHhlQrhYK2/v+6FJJMaYzyplWEOBLA28Qcw5DGQp/tEw9ZXf+MSHz8mp/OUWLncuoezxrognEKiOLfmOzTu8jsVi62kNxtV36n5xUD3/wd1jw6YCFQgfBw2j50wAYIcazGndCeSWgT4i0JDSB0uyAFWDkyZXATHYJlFk5GtCVYGzqChY1QEa9t0QKIN3RFDbD+L+r8SO2Qmr7r4/uAt160Q42tPslyjPveOZzqm6zItpGZ1KZdqolavOLy7oWQBfKKI+a4lbdOC2vPA7RQYb89JExwyTl9enfUm4dTrjKYaNUQUqexkmlKE8hJfJPj/BAKhBow7GV+rDdAhlUrnsEDetglCmRih4JKLOEFEysAt6cLC4fPJV1UAY6fYBxwf7NRLnFqyUgOqLQVTFnSRHoNk1NUtYkFtQfYhAAqBTTNeM6XDTF26WCJ2iy7T7oQnUUWKn3vthAqzBWnaLD07BkpTiTCeQM7uk9sNxDDvh1fklxTzy/aWhSuX67Y3hBQ1mtJIfrgPUgJzNhqXuvwosEvaijJs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(33656002)(4326008)(8676002)(6506007)(8936002)(7696005)(52536014)(71200400001)(64756008)(2906002)(66446008)(38100700002)(38070700005)(9686003)(26005)(122000001)(66946007)(76116006)(66476007)(82960400001)(66556008)(186003)(316002)(5660300002)(55016003)(110136005)(54906003)(508600001)(83380400001)(966005)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mgww+JcfTF2sg9OrlSic1snzTobg1AHe6NmAuu4T5mPObBTz1SnZxuwN3xVv?=
 =?us-ascii?Q?fSCkSAY913l0jkmLtASsGxftitniylnq32H+hI0alQaVtRGqzq42DeGxNS2+?=
 =?us-ascii?Q?8jHxL8wmO07+bBVaUwfJPAIB9TxmheYgh2fTAChIOTvvePI9qgkuZT+P98xc?=
 =?us-ascii?Q?JOZTPYSDZhS5NLV/NxH6VVLPrAALSyCwZDb0LDSY0+8ug69iGJCP6Tp7CHft?=
 =?us-ascii?Q?FG0ifCfA7sJEn5g7V60evaeqU+cGpZEum3Gn3lt50PW8WpHnAC4Jijv80eS8?=
 =?us-ascii?Q?VgOkUK5IXnYjfIWQWBVbbyq5cAJkLC5lCA0VbA/lhOY1EAfV7svbvUpTQDQr?=
 =?us-ascii?Q?gyc6wLOf5C/XDK4y6bQAyb9JxUs0rN4bxMF6vnoJpdaGNI751jBD/q+y/atX?=
 =?us-ascii?Q?TxSnv3RN+P1U0EzE5S22bZ7tnVac9EeVbjT1R8bdzNmRIQ/XClGFKZu6ljgE?=
 =?us-ascii?Q?Xt89Ji/DKmXZs2n40zaLrmUhW2/29uAElEU8GXDtLxAXc00rTpVwx/f6PEXl?=
 =?us-ascii?Q?t6GGGmSo4ntnyj4lqqusLCd0rwYKI14NxIEF8fuoLTlyRGXFO44gOgRrnkqh?=
 =?us-ascii?Q?kjw8F1wGwn85XasFUj8R/ZCUJZB7plwXccK00gBA9QgAZisF6oWO0EbgnVI+?=
 =?us-ascii?Q?XcOSCamfWGXpZwVQ9CXb1WhVqvbKEd5H0V09lXpv95TP+KbNVQIPQfg87l3d?=
 =?us-ascii?Q?BRi9QGrxvGiI+mGuod4xu2fnjYJNSaSl9Bew5lH8+0Sk6STuJNcZPZs2h1SA?=
 =?us-ascii?Q?ABpZaGpJwkCHoofA/nDTEyFeDlb19xV6jZhmZx1ygJGtXtJn4bccYqi5SpQA?=
 =?us-ascii?Q?g10mliOcQw74hRkQ/UDki6s3HqH8tC5MHbU0m8DqyhyjxKzXwoEXQoQbXYnT?=
 =?us-ascii?Q?s33CtfuzOyc96awNvzoiEY6a35frvZ27wl/fxXF1rbhJt1ggpoGNdxRKDMgL?=
 =?us-ascii?Q?Q/fmGQTRdFpNyR1WK0U1ZgvUIgm2L6aZ+cCCIPtofRPLYaljL932DtVKrSek?=
 =?us-ascii?Q?nUae1z9ssKKK4X/zONSQ5auUhT1AXbufNwZQa71esu1TJOuam+fCfBuySzqr?=
 =?us-ascii?Q?GlVmeibzvhbLFRouYd3oTJ4n5+nEhReUGXb+sA/2fyS5H/KI8b6tsihv8fxD?=
 =?us-ascii?Q?HXHFsdJJ2KvjwJR5w9RXbdodfy036oNgrifk1FJP7Ls2fD0tvitk8OShc8qs?=
 =?us-ascii?Q?JctS1Wy+2D2rgS+/InUgT5GKVIdh2sLT6NKDdTl++daCuPqt4QOjb1AIzZZK?=
 =?us-ascii?Q?d60HQOoBO62GYf5QlnJyN78yKBeUeYGAoVECt4NvBmapO1Ub7XjHhlBgeHlF?=
 =?us-ascii?Q?i+ymiDgt8pFFFzzoukzM/mV5QYkCZzzmBUxrVnIbMvMjNxA7YtDTwAEfKP6P?=
 =?us-ascii?Q?p+8DBYr+O480eGT5b1Uyw77bVb/bm98Ov9fwDFD2XZ2HLr4d0ifUFt7lJQIO?=
 =?us-ascii?Q?gqpgkF8fXUfOY7JsVVO/dpc/HUY4taKkqXic2AHqJD7n2VfrS4pksZ0edgbF?=
 =?us-ascii?Q?sw2VzijO7wfv67JpsuWAXZwVnKMXkyn9PtU2JJgiP0cama9USnhgejkI+wkN?=
 =?us-ascii?Q?uP1zv4p26a+wg5RsDdiEBKJoiY3XIR3zW3veiXXoV3wl/wii4LORtmqS/D8r?=
 =?us-ascii?Q?dTYhhaf9F6O4phbV0d0nWdQgrjB21C1pPd5diawMyJK4fbDIC5To1ykCTlLa?=
 =?us-ascii?Q?Q1dGtEayQQIoaU3t/WQCyLTEK7zstcGpr1VJ6KLfiU21W2XRBVSk0E0sROYI?=
 =?us-ascii?Q?J9A58xLymA=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d671fa9-67ff-4025-429c-08da2e85e848
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 10:56:28.8611 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q3efnurB/nV+sWVuObr/0AD+0wMHXW/6WM12SVNOJguRhJU8FSK09BC7p66/Otffsbg5r/p41DoK9kskphpm7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5036
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
> Sent: Thursday, May 5, 2022 3:09 AM
> 
> Once the group enters 'owned' mode it can never be assigned back to the
> default_domain or to a NULL domain. It must always be actively assigned to

worth pointing out that a NULL domain is not always translated to DMA
blocked on all platforms. That was a wrong assumption before this patch.

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
> __iommu_group_attach_core_domain() is the function that removes any
> caller
> configured domain and sets the domains back a core owned domain with an
> appropriate lifetime.
> 
> __iommu_group_attach_domain() is the worker function that can change the
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

Overall I like what this patch does. Just some nits below.

> 
> Fixes: 1ea2a07a532b ("iommu: Add DMA ownership management
> interfaces")
> Reported-by: Qian Cai <quic_qiancai@quicinc.com>
> Tested-by: Baolu Lu <baolu.lu@linux.intel.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Co-developed-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 122 ++++++++++++++++++++++++++++++------------
>  1 file changed, 87 insertions(+), 35 deletions(-)
> 
> Joerg, this should address the issue, Nicolin reproduced the original issue
> and verified this fix on ARM SMMUv3.
> 
> v2:
>  - Remove redundant detach_dev ops check in __iommu_detach_device and
>    make the added WARN_ON fail instead
>  - Check for blocking_domain in __iommu_attach_group() so VFIO can
>    actually attach a new group
>  - Update comments and spelling
>  - Fix missed change to new_domain in iommu_group_do_detach_device()
> v1: https://lore.kernel.org/r/0-v1-6e9d2d0a759d+11b-
> iommu_dma_block_jgg@nvidia.com
> 
> Thanks,
> Jason
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0c42ece2585406..c1bdec807ea381 100644
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
> @@ -82,8 +83,7 @@ static int __iommu_attach_device(struct
> iommu_domain *domain,
>  				 struct device *dev);
>  static int __iommu_attach_group(struct iommu_domain *domain,
>  				struct iommu_group *group);
> -static void __iommu_detach_group(struct iommu_domain *domain,
> -				 struct iommu_group *group);
> +static void __iommu_group_attach_core_domain(struct iommu_group
> *group);
>  static int iommu_create_device_direct_mappings(struct iommu_group
> *group,
>  					       struct device *dev);
>  static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
> @@ -596,6 +596,8 @@ static void iommu_group_release(struct kobject
> *kobj)
> 
>  	if (group->default_domain)
>  		iommu_domain_free(group->default_domain);
> +	if (group->blocking_domain)
> +		iommu_domain_free(group->blocking_domain);
> 
>  	kfree(group->name);
>  	kfree(group);
> @@ -1963,9 +1965,6 @@ static void __iommu_detach_device(struct
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
> @@ -1979,12 +1978,10 @@ void iommu_detach_device(struct
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
> +	__iommu_group_attach_core_domain(group);
> 
>  out_unlock:
>  	mutex_unlock(&group->mutex);
> @@ -2040,7 +2037,8 @@ static int __iommu_attach_group(struct
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

Suppose this can be also replaced by __iommu_group_attach_domain()? 

> @@ -2072,38 +2070,68 @@ static int
> iommu_group_do_detach_device(struct device *dev, void *data)
>  	return 0;
>  }
> 
> -static void __iommu_detach_group(struct iommu_domain *domain,
> -				 struct iommu_group *group)
> +static int __iommu_group_attach_domain(struct iommu_group *group,
> +				       struct iommu_domain *new_domain)
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
> +	 * will never be called. Otherwise the NULL domain indicates the
> +	 * translation for the group should be set so it will work with the

translation should be 'blocked'?

> +	 * platform DMA ops.

I didn't get the meaning of the last sentence.

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
> +	 * Changing the domain is done by calling attach on the new domain.
> +	 * Drivers should implement this so that DMA is always translated by

what does 'this' mean?

> +	 * either the new, old, or a blocking domain. DMA should never

isn't the blocking domain passed in as the new domain?

> become
> +	 * untranslated.
> +	 *
> +	 * Note that this is called in error unwind paths, attaching to a
> +	 * domain that has already been attached cannot fail.

this is called in the normal path. Where does error unwind happen?

> +	 */
> +	ret = __iommu_group_for_each_dev(group, new_domain,
>  					 iommu_group_do_attach_device);
> -	if (ret != 0)
> -		WARN_ON(1);
> +	if (ret)
> +		return ret;
> +	group->domain = new_domain;
> +	return 0;
> +}
> +
> +/*
> + * Put the group's domain back to the appropriate core-owned domain -
> either the
> + * standard kernel-mode DMA configuration or an all-DMA-blocked domain.
> + */
> +static void __iommu_group_attach_core_domain(struct iommu_group
> *group)
> +{
> +	struct iommu_domain *new_domain;
> +	int ret;
> +
> +	if (group->owner)
> +		new_domain = group->blocking_domain;
>  	else
> -		group->domain = group->default_domain;
> +		new_domain = group->default_domain;
> +
> +	ret = __iommu_group_attach_domain(group, new_domain);
> +	WARN(ret, "iommu driver failed to attach the default/blocking
> domain");
>  }
> 
>  void iommu_detach_group(struct iommu_domain *domain, struct
> iommu_group *group)
>  {
>  	mutex_lock(&group->mutex);
> -	__iommu_detach_group(domain, group);
> +	__iommu_group_attach_core_domain(group);
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
> @@ -3111,9 +3162,15 @@ int iommu_group_claim_dma_owner(struct
> iommu_group *group, void *owner)
>  			goto unlock_out;
>  		}
> 
> +		ret = __iommu_group_alloc_blocking_domain(group);
> +		if (ret)
> +			goto unlock_out;
> +
> +		ret = __iommu_group_attach_domain(group,
> +						  group->blocking_domain);
> +		if (ret)
> +			goto unlock_out;
>  		group->owner = owner;

Here can use __iommu_group_attach_core_domain() if calling it after
setting group->owner.

> -		if (group->domain)
> -			__iommu_detach_group(group->domain, group);
>  	}
> 
>  	group->owner_cnt++;
> @@ -3137,13 +3194,8 @@ void iommu_group_release_dma_owner(struct
> iommu_group *group)
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
> +	__iommu_group_attach_core_domain(group);
>  unlock_out:
>  	mutex_unlock(&group->mutex);
>  }
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
