Return-Path: <SRS0=QBaT=OR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2E9C433F5
	for <iommu@archiver.kernel.org>; Mon, 27 Sep 2021 01:02:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 402BA60C40
	for <iommu@archiver.kernel.org>; Mon, 27 Sep 2021 01:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 402BA60C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0305E826F5;
	Mon, 27 Sep 2021 01:02:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FioJwUlAI7yg; Mon, 27 Sep 2021 01:02:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 892B78249B;
	Mon, 27 Sep 2021 01:02:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DA0EC000F;
	Mon, 27 Sep 2021 01:02:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 997FEC000D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 01:02:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7E2BF40377
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 01:02:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9-fYHWW8TkT4 for <iommu@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 01:02:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9E4EB40335
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 01:02:43 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10119"; a="221181001"
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; d="scan'208";a="221181001"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2021 18:02:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; d="scan'208";a="615587889"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by fmsmga001.fm.intel.com with ESMTP; 26 Sep 2021 18:02:42 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 26 Sep 2021 18:02:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Sun, 26 Sep 2021 18:02:41 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Sun, 26 Sep 2021 18:02:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmHk6Wm6j5qib98fiDxmlbf6eUgllvHJdMSmaBem5YyjEDaHZaVZrjLEAMK7aMwTo5mHrm9mef1+1GuJkAlMEDRSy092M+6yZgxUtpqapjy9sjWb93+mu5AXCetYVxCLA79ocG5h/QqaMI3npwSZ6Vypv1Kg36wJ05GfYWxvAxNvlXGs67uGIIdi7R5qe5eVANt66cF6/40h+BTopzV2jYUjb0vAUK5ggqaWH0yxv3RdlAFfdgglO44ryJITyQZKza+frt8foKUEFnE90YEpAceHlLx2GqzFQ5FwR35iaQz4GcSibc0LbzY1eu8pQU7C1brVZhTkSBwVL073VbHYzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=3XG79LU++m1qPUBHsw9T+s2Mpm5vohCIKxbxs5bPbBY=;
 b=KX0zN5n2SD7ZGRlrT2aqwOBaitXND6NgaxQxeeXjo15764Bl24wQnCxQ5NXBjYHFfzLSXg1pYFmXHRMznJ7nEk9ApEc61IhVbxZVVKSNT72w+ULaWY4k+Aaw69VQ3xlKegZ8S9En+8R3qjFRNaAzCmSrouyDWm27axiGKKntnhI6o/2LwjWXDC+r2VjHck4kUCWOfmbqCKuTRGz/P3TE86HKn+lC3phN6ABoTpLq3JYpjuBhWAZ03Of5wT119Ea+b8aGmlVnxYfV7GQ38Tv/OKf/BnoFuy/+ThWBk/16qCKN4g96yIz5Ez2NswM3pmyZfweEzkb1ceXEFpIfCnpSvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XG79LU++m1qPUBHsw9T+s2Mpm5vohCIKxbxs5bPbBY=;
 b=iOusUQPfBN+xJBW847ztSpHPiAifrcjso7i8TFxz71fRnlVHYZLR9y2k8Fyq+KPbls36yRuICUXf23eq1H/d6wrE3t+35fkBUKYgMAUFy3U2KqccFMW/Iy+Mfyl38Nt1r/ex2Th0+FOONbREjd+kPH3wT2seWUYsLD+ufrsvKZA=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN9PR11MB5420.namprd11.prod.outlook.com (2603:10b6:408:101::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Mon, 27 Sep
 2021 01:02:39 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 01:02:39 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH v2 1/3] iommu/vt-d: Remove duplicate identity domain flag
Thread-Topic: [PATCH v2 1/3] iommu/vt-d: Remove duplicate identity domain flag
Thread-Index: AQHXssyKNHKFF+SoUEuTrYz6UpswLau3EQxw
Date: Mon, 27 Sep 2021 01:02:38 +0000
Message-ID: <BN9PR11MB54339C8E99C6DE37CDF7CE588CA79@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210926114535.923263-1-baolu.lu@linux.intel.com>
 <20210926114535.923263-2-baolu.lu@linux.intel.com>
In-Reply-To: <20210926114535.923263-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ba8c8dc-6788-40c4-656a-08d981528065
x-ms-traffictypediagnostic: BN9PR11MB5420:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR11MB5420F7B1C2EC51B7B5FB66198CA79@BN9PR11MB5420.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CtCjUBAfPBs1Ajtw24cuCSHM8rC65A/d8/uKPW5dGzmMtIgc7otn8c3Z7Ld13jEOpYk5QI5yvCRYNqLVv+yJKpY8Q+i2gnWdJKKfI8aAmDhjiKNUHVEAEGLJLlh/y5b+z9FIOvHv9vSoaDgD59IZrJ7J96Q/435ivRVwAtJyrG0mWSf2YfrGaFc24vytrQ5gv9ZoR97Po/h1LDLtgZZi4I/KTMg23TvNlLCw7crxKYs/a/MUF7eKoydVTTN/sthrj9v70OFkEnkG3PhObguPgMf/Pk2bCj9LpCixPzuaVy7LtcVXVzzeOBMi7XtLjpsjaArbPKt9Hz9ipMJlOQ/yCGRLF19LJIYTTQIcEJIInJUa/XrTEs5IzQDkW6OqJrtxVRwHCLdySAy0O98uSS0iXlcjP/+U3+bVrdfwizhongi9MHKJyCt0xLL0cNWMbvP0Tbn8eXW/ANoj2YOttesJ3um7w/hKU1xCWhObmMYOBTxAIMSk3bz/ADZSuWhIlXbxM4czxIbv15W7AkDsRQbug1AM2ahEMsAo8rl5DGzQEeyYLrnB0W6qgp+aDTVDn9zuZUbrEqZcaADNDOAseZMxaScZeikbS97trQwMDAsj75dRfPvMtrQ8BGgi2nNQUZsKHZD+b9PB0h/mXoIPwN4nVdpTp7Ykhm3DL1JEia7gHhTsf5ggznxDBdFnHhX72BO/TUklEEvSHwZ9UaIIAda8nQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66446008)(66476007)(66556008)(64756008)(38100700002)(66946007)(9686003)(33656002)(38070700005)(55016002)(2906002)(5660300002)(7696005)(122000001)(52536014)(508600001)(26005)(186003)(110136005)(8676002)(8936002)(86362001)(71200400001)(83380400001)(4326008)(76116006)(54906003)(316002)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J3cMXrFq7tAZRl/woxCwojrazth4Wfqr/w9Knp4NbZ3ePGq7jqrDNdNIEnFM?=
 =?us-ascii?Q?0PmuVL8qL/ujS2+Wo9CWSZxbpaJMmtMDMqTw4arB/hCHY0WEabbBmXvvSuGS?=
 =?us-ascii?Q?SHn8VycLp7DenLQsGikx5pueUIobUKGIGdRsC1wbheLlmHJF4XT3teBe2Zj5?=
 =?us-ascii?Q?/f6ImSVhYLH8fWEGkcQ/sLsKspMNzaORYA8n3Tx6Exo7b8pxuEG2kzr/fu+8?=
 =?us-ascii?Q?jqvHVV719jDugENJKo5iuJN/IqTYfqEFPJMf+9mWtoUgnEPoXBMc+mNBr2bc?=
 =?us-ascii?Q?ABwICDPJ4TMRItT3n/MRmBFVBWDRRMiedTZY0ryjXJTZitXPkO/Cmqo59VJL?=
 =?us-ascii?Q?MxtOcImzzQRBh4Vzs2BxSwmqJWtf1M4DORr+HZZ+jDKXGVRJEpkppPOcOzsp?=
 =?us-ascii?Q?Z2sAsTU1gfO39rvOU0DC44Ex8FTS7djyRTNRuLms/3jTlo7wbOH6jE2yqiiv?=
 =?us-ascii?Q?vT0SJ1yjiEtJU+7/flRwTDopeRxY/yvbo7zpOMkMGe5WXAF+M2mjxG/BegU1?=
 =?us-ascii?Q?Eejjk3/7vAxPh/UK+NsymHIol/Gym5KiN2Ie9FzncobYnjJxocjfe8Xwsguh?=
 =?us-ascii?Q?HIAqzvlD46YnENoVkesU5AOrBFrxMs22vanHmERvqsXC3njm0OBr2XYqKFnz?=
 =?us-ascii?Q?KQkHtLlos/fvcO19SDhNFutoLV7uso8fXLH7kkUZm18ZlV39nuEISQYxMrvl?=
 =?us-ascii?Q?O1xwJHhs7lce7wvsHle9XdQfQLU21C1fx5IlUHfXaKEBy3ThoD4/EnGf17FS?=
 =?us-ascii?Q?7iYSqhw0LlCSRTD+AjxE6t1aPo/+KzNlJOOSAlrRyCZWoRTuYgRJZQG6eTNI?=
 =?us-ascii?Q?XXUsDP4AigdkXmHTtCcQRHEyZtNAxpjFO7X6nH7V45jMIOiF25xQ1bJA2b2i?=
 =?us-ascii?Q?0dsRBYSORjkiIe4vKYVkFPvwBOjXGZ85BoFnpmzdNWxSZ3RLs1x1xVXb49ww?=
 =?us-ascii?Q?7o8+N2meJ6JXHLzMGfezMmuWDDWaieq5nPQEmQaq1OkOOJWnD+4ZiWQh/UYG?=
 =?us-ascii?Q?g/OB5WBPfnN6YSq3rzSUFhsUClIGq7XzQNJhGNrmb/3OEU5DifPvP5/pjcNg?=
 =?us-ascii?Q?DK+bG5T7hYBgSHm7JJNcRd4V3b4194upXqg07w5okxdBvYJhYEjyHSxahqrB?=
 =?us-ascii?Q?ro0JNnNSyPN2yuYuPD/oIKQwvqu4Q4cHj5orhv208r9VeaG8xa9h6680DjbG?=
 =?us-ascii?Q?+H1NSZPHfvhYxSvSsiwmTk0ALNKRr1N9fQqsFDkTODQgAVUrTfrp2zjRkhq5?=
 =?us-ascii?Q?QGwYe01RgBcezXGNfzXRWZ9egzKyDf/xoe2cBRrQVAIBWRPo0IyAIxBci/s5?=
 =?us-ascii?Q?5rVvDOmewK4QvC0Eat9GSgrF?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba8c8dc-6788-40c4-656a-08d981528065
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 01:02:39.0090 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6AV19qAS4tKglTTIETIMbKmMoIYruHjiKkMd5Fyl3yBenbfKX/1sd51icxv9QE5tzdziJ/nyfND+y8tUejY3cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5420
X-OriginatorOrg: intel.com
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Raj,
 Ashok" <ashok.raj@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
> Sent: Sunday, September 26, 2021 7:46 PM
> 
> The iommu_domain data structure already has the "type" field to keep the
> type of a domain. It's unnecessary to have the
> DOMAIN_FLAG_STATIC_IDENTITY
> flag in the vt-d implementation. This cleans it up with no functionality
> change.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

> ---
>  include/linux/intel-iommu.h | 3 ---
>  drivers/iommu/intel/iommu.c | 9 ++++-----
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 4bff70c26416..c24bdf5a9285 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -517,9 +517,6 @@ struct context_entry {
>  	u64 hi;
>  };
> 
> -/* si_domain contains mulitple devices */
> -#define DOMAIN_FLAG_STATIC_IDENTITY		BIT(0)
> -
>  /*
>   * When VT-d works in the scalable mode, it allows DMA translation to
>   * happen through either first level or second level page table. This
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index b0076f54f5f4..dc2030d014e0 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -528,7 +528,7 @@ static inline void free_devinfo_mem(void *vaddr)
> 
>  static inline int domain_type_is_si(struct dmar_domain *domain)
>  {
> -	return domain->flags & DOMAIN_FLAG_STATIC_IDENTITY;
> +	return domain->domain.type == IOMMU_DOMAIN_IDENTITY;
>  }
> 
>  static inline bool domain_use_first_level(struct dmar_domain *domain)
> @@ -1996,7 +1996,7 @@ static bool first_level_by_default(void)
>  	return scalable_mode_support() && intel_cap_flts_sanity();
>  }
> 
> -static struct dmar_domain *alloc_domain(int flags)
> +static struct dmar_domain *alloc_domain(unsigned int type)
>  {
>  	struct dmar_domain *domain;
> 
> @@ -2006,7 +2006,6 @@ static struct dmar_domain *alloc_domain(int flags)
> 
>  	memset(domain, 0, sizeof(*domain));
>  	domain->nid = NUMA_NO_NODE;
> -	domain->flags = flags;
>  	if (first_level_by_default())
>  		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
>  	domain->has_iotlb_device = false;
> @@ -2830,7 +2829,7 @@ static int __init si_domain_init(int hw)
>  	struct device *dev;
>  	int i, nid, ret;
> 
> -	si_domain = alloc_domain(DOMAIN_FLAG_STATIC_IDENTITY);
> +	si_domain = alloc_domain(IOMMU_DOMAIN_IDENTITY);
>  	if (!si_domain)
>  		return -EFAULT;
> 
> @@ -4639,7 +4638,7 @@ static struct iommu_domain
> *intel_iommu_domain_alloc(unsigned type)
>  	case IOMMU_DOMAIN_DMA:
>  	case IOMMU_DOMAIN_DMA_FQ:
>  	case IOMMU_DOMAIN_UNMANAGED:
> -		dmar_domain = alloc_domain(0);
> +		dmar_domain = alloc_domain(type);
>  		if (!dmar_domain) {
>  			pr_err("Can't allocate dmar_domain\n");
>  			return NULL;
> --
> 2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
