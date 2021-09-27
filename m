Return-Path: <SRS0=QBaT=OR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FC6C4332F
	for <iommu@archiver.kernel.org>; Mon, 27 Sep 2021 01:31:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E85160F9B
	for <iommu@archiver.kernel.org>; Mon, 27 Sep 2021 01:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9E85160F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6EFEC80E72;
	Mon, 27 Sep 2021 01:31:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RQCSlbqBdyzc; Mon, 27 Sep 2021 01:31:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5128880DE4;
	Mon, 27 Sep 2021 01:31:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CC83C000F;
	Mon, 27 Sep 2021 01:31:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED173C000D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 01:31:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC07E40232
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 01:31:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EnXSDPpGuAPw for <iommu@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 01:31:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E52174021C
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 01:31:53 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10119"; a="224441460"
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; d="scan'208";a="224441460"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2021 18:31:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; d="scan'208";a="477774833"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga007.fm.intel.com with ESMTP; 26 Sep 2021 18:31:53 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 26 Sep 2021 18:31:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Sun, 26 Sep 2021 18:31:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Sun, 26 Sep 2021 18:31:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJ+cG+nCmtSciKX2hr4tOodvVObJMOLgFZIMLFLvPEBSO29pPwTiFB5o0nEWMni1SKg8aAHs9Lz00WsOfWphoibDGwflKOS1G3qRmdrQiIv5l4j1iCWIMXeeqnzzVPdgVciGx1HNaj7sZhTUAITqKwSZr9MdxiCh/dDYJnCN5gWgdLM9AenD6mEQelMGGcxopU9YTPSkPHGkPeRjUwfAfQt1blUTysy+z3RhZVwRuGEvSH4C1HqE5HXSPVTQe1YtCVijma9yKnkihWopThdkRkuKg/EWsT8suTcyqS1Gif8aypnty5vJ9TjFX/Z8JgiRELzlb0ZSihNeUujVkdjgtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=qGeWLdFzZQ+jL/Jp3nMOQYqBS1VGgbcqv4MlmxZ3BMg=;
 b=S3NFrGJ2k03tkWAHoGangF+rtZOnqAEa0hZe98MJTqIgVz/Bx8ttENKRx2lqbj1m98AyJga0f/QR7l5u9rVoupUwpiPQU+MAK1x1yqUG6YsDVEWKEsNj7BJIfTLFpq2HwwXjZPICj4phZOVquwB/3q3b7T1YxZWhAeDK7zbpJEldmlMhkNIdzJBetBlp3rRctLkpZ+V4pYhmkNIyK2trBkT4B9+yCPO4i5PzYdaiQqzcvAVXvc8edJJdLzvUqMZ4UJT836l9UJIvyq4jF7CXmyoGj+8Pag/FI5+7CA53QGjN8nmrpH1rHsFk8HtEcRYiWkW7NWZWBDhxmm1v+EiIrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGeWLdFzZQ+jL/Jp3nMOQYqBS1VGgbcqv4MlmxZ3BMg=;
 b=aw6YOgfHlXag+CLwwxUjvtXUyc/m9fWi+YQuVJzghFZ2ne/y+Uzf0wSnGU9fkiYd+1fjZGreKGtFTLxRLsVoEHDd1U6qfSTD7qhObRSEYgPEMP6fiDMFdLWEReEn9a7Iffbsd9ZZW84uIY6ck/RCCvbB5FyFRANx6tJjoPetyHs=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN7PR11MB2849.namprd11.prod.outlook.com (2603:10b6:406:b5::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Mon, 27 Sep
 2021 01:31:50 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 01:31:50 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH v2 3/3] iommu/vt-d: Use second level for GPA->HPA
 translation
Thread-Topic: [PATCH v2 3/3] iommu/vt-d: Use second level for GPA->HPA
 translation
Thread-Index: AQHXssyOey/mXdHvYE6g6BR8nKbt86u3E+YA
Date: Mon, 27 Sep 2021 01:31:50 +0000
Message-ID: <BN9PR11MB5433D850D9131123354088628CA79@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210926114535.923263-1-baolu.lu@linux.intel.com>
 <20210926114535.923263-4-baolu.lu@linux.intel.com>
In-Reply-To: <20210926114535.923263-4-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4bc4d5e5-ccb8-4f7a-2911-08d981569457
x-ms-traffictypediagnostic: BN7PR11MB2849:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR11MB28495EBDA35292956745A3B88CA79@BN7PR11MB2849.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 51X0zKNNCfT+AZCTNv8mKnHxlnbhvFRxf4yyIliBGbTpTEmi4icqA0INYJXHAD1KgkC+YAni422yfezezlMww9/v4/VCvJQ9Q6LHFLY1+cc8YfHsvrTytzn79sYMISRpc6TcdaYML64Na4jJSNE3MX6ihCiTq/4uH6wCOnrWaEZq8mxIitiOy2Zpxm8zNDrRzyGABg4bBZu94hP5euAD/8OmjX+3hlpurzWuBCklGaLvYUEqq59lbbX5vAf4Byds0zbV49lhQ0Ag4XYFntcG5x8R3Q1stFoM6AZ4rWXwDo6PmJhRKPa8T7ExLzOnHAzLv0S8D2ylBuouyvAI536++6VdQnhPPrhKQ5Hqfjb85P7I6WhCcBvx8IQ+k5H7Do73CQStwUkQZ81ZKMdyeesVx4UlWp2JGS6kYvM2nyv7qgMSeRVCTL1QVx7vrPi5FGn8b99bBjv581gkK4ajcmFSZ7K7tjD6dnYybEX6sWGyNnH4r6rp2FEnIw88F0sdtuwHCW/yfvKWRPzhcG8fTuL2fQQoJ86EZLBCUa5NjiYEY9hQRBXyCu31LACeZ6E3A4BACK1PmQHYRUh4E2orEnCn1oPM5gEbemyXC3IPeBjAXRZhW3KcT1m5v4mez+Dhw9zJTVicazi8BHfXPlRIP1DkyIbrRUV/HU40Af9aSL8caItpD5GXspP5Di60lyPxIVeRWx5nyC8i1KB+ikYVUtxG4Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(33656002)(76116006)(86362001)(8676002)(66476007)(110136005)(6506007)(55016002)(2906002)(66556008)(316002)(4326008)(52536014)(66446008)(71200400001)(38070700005)(26005)(9686003)(508600001)(38100700002)(64756008)(54906003)(122000001)(7696005)(66946007)(186003)(83380400001)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2mQgHsusrylzz5bfDAgmbbbnxIV4xxKzmjyZQsZJr+NwK1/ksqQobtr974ow?=
 =?us-ascii?Q?H4N/4+Wlp2f7MVmHqUqdcvWmawI4ckvSwFxfDxLRHS16afo9N4YPOo8kjvqg?=
 =?us-ascii?Q?EDMzz3kvrKal8+Qzk0geHv8pQardeVMz5GkOtR+dEX+A3vbwM8h0+cZjSt6v?=
 =?us-ascii?Q?tE6YsE7rX30ccRpRhtgRXxM4w1q4+g5UuZM1pm2URYALFIPu7YdErGOb72ph?=
 =?us-ascii?Q?hMq4axrhIBfQoBedh5XQJUwzKPtkfzTOVc3jmFl5CxjaO3fnGWyPNP6KxUlY?=
 =?us-ascii?Q?l+PTWfOtV8pooLlUVuj6um1kACd6kaRrHqxRiKPbZ9PDsROHlXf58F2uleDH?=
 =?us-ascii?Q?MIBLUnrEoxwuoUB4xs1CQsqckf4muFP5ONCURTdMin7kIGTRGi7dYP9YyVeL?=
 =?us-ascii?Q?qvxFJm6V04dBRuesdeNS5mphXMzWgfcPQz8mGH1WtKWmV2ILlodUtHV/SG9p?=
 =?us-ascii?Q?1is0ZQe/KFvtBTgedMKRIzHmzStGjK6dyKKYUwrIA6LjFvkkkC53SNmcM+0W?=
 =?us-ascii?Q?bNn04HU2JQN1bkwh98F67+dlNhoY48xqGFR9KwReou6GUGW8Cso3aX3xxTMo?=
 =?us-ascii?Q?pRFfWtsBup+8WRVuD8R+Tb3ijBqptDNnulUaQrncj4yy8t1+Iq7OJMIsLTUu?=
 =?us-ascii?Q?7TuqnOFkfKB8LouXD9dDJayzUGv/bTKIGhXZGg85Y2oP1xsgO8UzoEsp4ic3?=
 =?us-ascii?Q?nWwWUvLAm5wuKjllvO5L7tjiJDJnxQ0OYwh2zxroHj+jvWmvYDgKycCW8KW0?=
 =?us-ascii?Q?c6sMMfCcDLVRto7S8a9Co/yHhUUQGUL8PeGZSlVm8FS6Syvvcj2lQACqdnal?=
 =?us-ascii?Q?bSOL6JRxQ+FxfuLumFhQfWPuPd8WVTCotI6gTS2M5n2VzNhK2VpTksSPzYly?=
 =?us-ascii?Q?Avti+4/6TsSoPA4rFM1WKbBiRfg0St1lGsbA0HbNhEtr3bvPA2rrp+H/dQ8F?=
 =?us-ascii?Q?l8ipsFL6mBm6oW33sJ3cc5yKWXOrOJM+W4kVtQe4BDd7ZC32Buat0RfdLRww?=
 =?us-ascii?Q?LbSIKGvY6ZmOJBMBNiMki2WFFov98S21NdqTdrg9sHoiA4oMgxC8G2PiznqX?=
 =?us-ascii?Q?Ze/B19XXke2bLtLIFaiEJWHJIErfljZ3MG/w+r+fKGQnXH38U0XS9pkdTJSM?=
 =?us-ascii?Q?q4gr7dvb6NZsaErxGYJe9pOQHI+BjwULiAfRDDbgvothVKg+EbYk1XxoQP2L?=
 =?us-ascii?Q?XoJGmihCJ8NLMkBJ4I854iWVLCHOL1RvmDv5sDhhTXSkBi8eRzkonzpIlaIe?=
 =?us-ascii?Q?9/Fnbc6BsJ3Q1LSTnMhybSBl/YrbxOGZ0nGRD2xbxosVI0851rVg33hTAbA3?=
 =?us-ascii?Q?kfy83RCvKxgskUsYMOx5dHKN?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc4d5e5-ccb8-4f7a-2911-08d981569457
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 01:31:50.4700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qihSLxXjdwTOcdFUBprTIdWC/gXsOkc7teO9ZmKdUcrA8Ad3z5iV8Xa2CPrnwi1u079LWNOTfDosrHcYFtRB4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2849
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
> The IOMMU VT-d implementation uses the first level for GPA->HPA
> translation
> by default. Although both the first level and the second level could handle
> the DMA translation, they're different in some way. For example, the second
> level translation has separate controls for the Access/Dirty page tracking.
> With the first level translation, there's no such control. On the other
> hand, the second level translation has the page-level control for forcing
> snoop, but the first level only has global control with pasid granularity.
> 
> This uses the second level for GPA->HPA translation so that we can provide
> a consistent hardware interface for use cases like dirty page tracking for
> live migration.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index dc2030d014e0..426630261614 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1991,9 +1991,15 @@ static void free_dmar_iommu(struct intel_iommu
> *iommu)
>   * Check and return whether first level is used by default for
>   * DMA translation.
>   */
> -static bool first_level_by_default(void)
> +static bool first_level_by_default(unsigned int type)
>  {
> -	return scalable_mode_support() && intel_cap_flts_sanity();

/* Only SL is available in legacy mode */

> +	if (!scalable_mode_support())
> +		return false;
> +

/* if only level (either FL or SL) is available, just use it */

> +	if (intel_cap_flts_sanity() ^ intel_cap_slts_sanity())
> +		return intel_cap_flts_sanity();
> +

/* if both levels are available, decide it based on domain type */

> +	return type != IOMMU_DOMAIN_UNMANAGED;
>  }

with above comments added:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

> 
>  static struct dmar_domain *alloc_domain(unsigned int type)
> @@ -2006,7 +2012,7 @@ static struct dmar_domain
> *alloc_domain(unsigned int type)
> 
>  	memset(domain, 0, sizeof(*domain));
>  	domain->nid = NUMA_NO_NODE;
> -	if (first_level_by_default())
> +	if (first_level_by_default(type))
>  		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
>  	domain->has_iotlb_device = false;
>  	INIT_LIST_HEAD(&domain->devices);
> --
> 2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
