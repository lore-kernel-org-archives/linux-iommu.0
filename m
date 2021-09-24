Return-Path: <SRS0=LkSb=OO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFE0C433EF
	for <iommu@archiver.kernel.org>; Fri, 24 Sep 2021 03:16:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E13DD603E9
	for <iommu@archiver.kernel.org>; Fri, 24 Sep 2021 03:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E13DD603E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A877F4017D;
	Fri, 24 Sep 2021 03:16:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id siLOl3EnD8Mr; Fri, 24 Sep 2021 03:16:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1EE4940195;
	Fri, 24 Sep 2021 03:16:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00828C0011;
	Fri, 24 Sep 2021 03:16:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5822EC000D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 03:16:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 40EAA406EF
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 03:16:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mAfZmAS244Sc for <iommu@lists.linux-foundation.org>;
 Fri, 24 Sep 2021 03:16:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DB90F406EE
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 03:16:29 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="309547862"
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; d="scan'208";a="309547862"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2021 20:16:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; d="scan'208";a="475064076"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
 by orsmga007.jf.intel.com with ESMTP; 23 Sep 2021 20:16:28 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 23 Sep 2021 20:16:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 23 Sep 2021 20:16:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 23 Sep 2021 20:16:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ev4tj8Geg6oCXCOcRaA3H10YqgHHSG965+P0U5FvpfiuVcZdKoz4VMWKj33MzXJUT16AovzA2Y5u0BwMqjoOeNg+zURdx7ZX1eKICtdjd7a8Wr2uy6AA/to8tgeulZ+OK08l/LNmtGz0fTQ5ccXchGZsYN+PNKBgMahhdUtRfZuglKLDg39xX2ea2qa3/WsT6lYtw6kT4sclu4ZchHgca1enXdSgXDrRbSw+MZ1w9vzq0lInAdyxMXppCEA0lYDopq43Mcb9w7mQi31J0nXRLuvoBUoE04mQMDa5XgnawES/NAV/io6Aru0IMLDnvLuoPiVTWof89lhCocM7CMCQcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=gzusgcPVvAImnluZpjyOni2VC89k3s7OMZ6yDnhyIyA=;
 b=h2IKpU/Be6/G8WGRTzRaFP7+sgBsSxbkdlSxhDTiAnILmau2mxILMtc258gK6/BkHwAvD0gwn3nEV+kD36HxNte2ddTyJkDTIOrR357KLt1QOKdyTIUv7FdH6R5sv1Q4wMwoG4ylRElwjitINzpMpzqwxPM3qO3lRNYpwGdLyaI/y3EsVP/zTai1nVR8vUvUE2ZeNlE/cYd779dnEIay/E4VFC0e2eu3xBqhcVXN87Pm5zuOshsqdhKg+vns4G2aRTiJMQSRDJlD00DzARoCTkNDgZmm89M7c13tp2slhjwiFkApnnGt9UMEs8vz7pjc7jo/+Vh4md5qAyaH5TWbIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzusgcPVvAImnluZpjyOni2VC89k3s7OMZ6yDnhyIyA=;
 b=Kyxtd6knUezL81uUJzskuWWX2uX6pu3SfeNHGO4FGFdlx+2z2kLeYNOKqOqLvWOOvgAkZczgqIQEWIfxCS1FMzQu8RuQIMeb08iITUv0BLkySSTaDVBzw2Q7cERWVeDYCv7mJ+qvndmbul/jaThQiRNGCjPRhax5XezpVGccNh8=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN7PR11MB2691.namprd11.prod.outlook.com (2603:10b6:406:b3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 03:16:00 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 03:16:00 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Use second level for GPA->HPA translation
Thread-Topic: [PATCH 1/1] iommu/vt-d: Use second level for GPA->HPA translation
Thread-Index: AQHXsOyCAYyPfoq/mkGWmB+Da+Ps0quygFqA
Date: Fri, 24 Sep 2021 03:16:00 +0000
Message-ID: <BN9PR11MB54338F4F946F5E9BD3D4D5388CA49@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210924022931.780963-1-baolu.lu@linux.intel.com>
In-Reply-To: <20210924022931.780963-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c47e03d-1bb9-427b-0899-08d97f09a28d
x-ms-traffictypediagnostic: BN7PR11MB2691:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR11MB2691B3FDCEC7D62FC60E03578CA49@BN7PR11MB2691.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:174;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XxWaxoUae+u+NNgFIgVJSxCo8AIM9MV68EbC3GLOSCRPz4FfprVIw9Cx1ARlYc0nSmTrZdqXsJ6KJ+v587hGA+YG9wPfFgHLOt5oukoH8Zv7HlCfD9kod1w46f7Iu3K4bM6oXV4v9fCzt2WR2OfuBXCRZTItDbR1Pqe+jr1Vk0piq5+dFVCs9d0s6/X9zmi/P+o2DL+8v5y/nuwc4L5JZoLfTc/nGQQ8Mw4bcgC7YBvfOB+REKzO53dR8IauaodB6hWypGyJMPwzy0nybpcMdt6xQgHHINy0T/a2M4l/OCo6NWNtaI52SrZq20eVmYX8mRbXd6Q3WU9jLxGBxGMWJI0pEASJiEFalvfxSb9R/l4UOIjUcBtb00NEEizyt2VplPLMS2xuoWogjOEq7hldsLHFbG5muwaGW9Rev4iTLxHmyTGfqOmIKqsKHY3KYUZltDnsN+Ciw+igJPwhIOqn7UvvG+HabslCt5hOXnjezV9ccyxLVsLEuNVsx8ZR+mVWuxORheeOKjn9Wzh4kMI78LoCX16Wwq7X7ZwCMUwCenaTXUagETfSMbpU77kUwc8aji6pwiJ7AXxEXnPHM92ydO3oZ3gOW6p0v28g29RQSm6dh8JVWkk6IvKDoSMl1WioPmFFyLhoYKvdcWqKZBtufiK4w1KZU4b81fZLS7L8rFnmSjysKpV3daUWVSEyEEMJY0G5kKXtr1aulkNkXNIo3A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(64756008)(66446008)(66476007)(8676002)(71200400001)(66556008)(66946007)(110136005)(54906003)(76116006)(4326008)(6506007)(83380400001)(38100700002)(186003)(38070700005)(2906002)(55016002)(52536014)(86362001)(8936002)(33656002)(122000001)(7696005)(5660300002)(508600001)(26005)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KhyOGuh+XU2JqITmWCXSDtpiOTsyeahGC3lOab9MCNBoBdvH5ja8HoDVdznp?=
 =?us-ascii?Q?NLzNicOpfy6+6N/AjxVHwTUrfqKYdcGUg4kn7ncFOKw1oSzrBQI8t4JOdVuR?=
 =?us-ascii?Q?yQNMzG3y3mZwpmOqEWbdJ/KLftT/9j3veHvjI0UXRasm4kVKIuKtxJ4P/4E2?=
 =?us-ascii?Q?KiooZMceDkqjEm5lm923F+xuNqw8+dfwMiX6Epnvskiq4r+g5KYRzH/Mr3Q8?=
 =?us-ascii?Q?LYEyE+jgK0laYBJKBCG0/AJHVq9AKwqbG1hawL/3iJzVhphHqcgf36G+8nJq?=
 =?us-ascii?Q?7t42zVAiyEuZ821YHi5rtwO82w9oR1gVeXzNwPfxy8D7fOJngEeiQEgITouu?=
 =?us-ascii?Q?Fq2HQHyj6e+Oou+MYKNaRTww8NhJmLO972DG6YppVmUjWMdOHm09irRh/91N?=
 =?us-ascii?Q?pAUmqbC0xbE3nnQqMDE94MVvU0vxfABMDk9DJDdE00LKnaA3NLXNlBpB+7TX?=
 =?us-ascii?Q?iB3kEnH3K9j9024bcYJ6DQ0a0nvXfWv825k9qwFeW0eltvCogvMOszXWZA5b?=
 =?us-ascii?Q?msqZrPi3J48eqZioUt9dXV/wwqToUfWO3y9s+bovnFth8+AEdxd+ch2jDvHV?=
 =?us-ascii?Q?HWC/93PvEPOe5NgqO5FCytjRdkucCFNC9Gerk8GAeCr8mazMJWjPeisRG45a?=
 =?us-ascii?Q?EMKuRs44rPdO/pgE+QuKq0Bcp0XELMsqD/lkPJ5CZBOwj6bZvf/d4DlDa7zV?=
 =?us-ascii?Q?1ni1BvJC/cWMA+1Ul9qBEDHeNWL3c03MxS6AKOeUwkTGvHj5WeOyxzDLK7Ft?=
 =?us-ascii?Q?J+EjsTEcq9oc622oRkVFEmrAEGqI3fu1e0jF+P55EONNLXES2cnBAQnzbC8Q?=
 =?us-ascii?Q?M2cdMKgPW4FmjXJA3ARIPo1WcnbCwOwBRzuqph9mwWXEk1KZKZmZ6qCZHy6c?=
 =?us-ascii?Q?R+EjNRb+S5u4NMMSmL+HByEQwvbeQxWdfwiIS6tNdQzjvqyDXI3zgcge3h2P?=
 =?us-ascii?Q?wCnXKdi/tHRlHIqA0kxhV+tD9T9y4GIhoxkQ6QFJ0wVa1zj6gRsnIOxTy8xr?=
 =?us-ascii?Q?klRWY9hNNUZ3L5cpLhMJMV/DN1ZZcL/EFs9pZhhCnoY8Qr00s4i+R2sNtmxn?=
 =?us-ascii?Q?0J1C68uDTjF+fowhDfy1JwyOJkKzKZ06ol+anZKjRs+cp/T6zuO7n5xT5g60?=
 =?us-ascii?Q?whodnILI8w+F/jw8pzrYesF1SOa1cnDOovfFHbOSzu/2V1AU3zfDX+SQFeWR?=
 =?us-ascii?Q?he93bDnzEbwywV9VWbhzBNg38AoZNvIxOhfwQnaNihvINEUD1S16rgJilZ1p?=
 =?us-ascii?Q?Enge7umsJEOcTbpMzWDteFTyRBr3tm7/7bJ55zvvVmC1BVLaroiBGAKSxtBM?=
 =?us-ascii?Q?N1u/cum2ogqRB2v7bhQDTGXt?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c47e03d-1bb9-427b-0899-08d97f09a28d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 03:16:00.6717 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5FYWVUB0sqml/ldH4ssL0dSGf6nV+GowcfzKk6mfl5OM95Uv9kqbXOYXanN76C2xEJCRNoTEZPWg2ulm1FxFgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2691
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
> Sent: Friday, September 24, 2021 10:30 AM
> 
> The IOMMU VT-d implementation uses the first level for GPA->HPA
> translation
> by default. Although both the first level and the second level could handle
> the DMA translation, they are different in some way. For example, the
> second
> level translation has separate controls for the Access/Dirty page tracking
> and the page-level forcing snoop. With first level translation, there're
> no such controls. This uses the second level for GPA->HPA translation so

first-level has no page-granular snoop control, but has a global control
in pasid entry.

> that it could provide a consistent hardware interface for use cases like
> dirty page tracking during the VM live migration.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/intel-iommu.h |  7 ++-----
>  drivers/iommu/intel/iommu.c | 21 +++++++++++++--------
>  2 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 05a65eb155f7..a5fb20702201 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -517,22 +517,19 @@ struct context_entry {
>  	u64 hi;
>  };
> 
> -/* si_domain contains mulitple devices */
> -#define DOMAIN_FLAG_STATIC_IDENTITY		BIT(0)

this is a separate cleanup. better mention it in the commit msg or
put in another patch.

> -
>  /*
>   * When VT-d works in the scalable mode, it allows DMA translation to
>   * happen through either first level or second level page table. This
>   * bit marks that the DMA translation for the domain goes through the
>   * first level page table, otherwise, it goes through the second level.
>   */
> -#define DOMAIN_FLAG_USE_FIRST_LEVEL		BIT(1)
> +#define DOMAIN_FLAG_USE_FIRST_LEVEL		BIT(0)
> 
>  /*
>   * Domain represents a virtual machine which demands iommu nested
>   * translation mode support.
>   */
> -#define DOMAIN_FLAG_NESTING_MODE		BIT(2)
> +#define DOMAIN_FLAG_NESTING_MODE		BIT(1)
> 
>  struct dmar_domain {
>  	int	nid;			/* node id */
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index d75f59ae28e6..c814fea0522e 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -522,7 +522,7 @@ static inline void free_devinfo_mem(void *vaddr)
> 
>  static inline int domain_type_is_si(struct dmar_domain *domain)
>  {
> -	return domain->flags & DOMAIN_FLAG_STATIC_IDENTITY;
> +	return domain->domain.type == IOMMU_DOMAIN_IDENTITY;
>  }
> 
>  static inline bool domain_use_first_level(struct dmar_domain *domain)
> @@ -1874,12 +1874,18 @@ static void free_dmar_iommu(struct
> intel_iommu *iommu)
>   * Check and return whether first level is used by default for
>   * DMA translation.
>   */
> -static bool first_level_by_default(void)
> +static bool first_level_by_default(unsigned int type)
>  {
> -	return scalable_mode_support() && intel_cap_flts_sanity();
> +	if (type == IOMMU_DOMAIN_UNMANAGED)
> +		return false;
> +

I think the order is not correct. what about 2nd level is even not
present?


> +	if (!scalable_mode_support() || !intel_cap_flts_sanity())
> +		return false;
> +
> +	return true;
>  }
> 
> -static struct dmar_domain *alloc_domain(int flags)
> +static struct dmar_domain *alloc_domain(unsigned int type)
>  {
>  	struct dmar_domain *domain;
> 
> @@ -1889,8 +1895,7 @@ static struct dmar_domain *alloc_domain(int flags)
> 
>  	memset(domain, 0, sizeof(*domain));
>  	domain->nid = NUMA_NO_NODE;
> -	domain->flags = flags;
> -	if (first_level_by_default())
> +	if (first_level_by_default(type))
>  		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
>  	domain->has_iotlb_device = false;
>  	INIT_LIST_HEAD(&domain->devices);
> @@ -2708,7 +2713,7 @@ static int __init si_domain_init(int hw)
>  	struct device *dev;
>  	int i, nid, ret;
> 
> -	si_domain = alloc_domain(DOMAIN_FLAG_STATIC_IDENTITY);
> +	si_domain = alloc_domain(IOMMU_DOMAIN_IDENTITY);
>  	if (!si_domain)
>  		return -EFAULT;
> 
> @@ -4517,7 +4522,7 @@ static struct iommu_domain
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
