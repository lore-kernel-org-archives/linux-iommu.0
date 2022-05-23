Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C8CC433F5
	for <iommu@archiver.kernel.org>; Mon, 23 May 2022 07:55:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48804418A5;
	Mon, 23 May 2022 07:55:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OgSTXvmj8JYI; Mon, 23 May 2022 07:55:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9B76641883;
	Mon, 23 May 2022 07:55:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DF36C0032;
	Mon, 23 May 2022 07:55:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20512C002D
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 07:55:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ED93A405C6
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 07:55:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p37RsP2_AT0S for <iommu@lists.linux-foundation.org>;
 Mon, 23 May 2022 07:55:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 91870405B2
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 07:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653292513; x=1684828513;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sl6/9JLUHTFJB+ti4PlENudXA/E1AmkbR7NoHaodVzs=;
 b=caMftU8NsJ8hVa/wgo4As+6SH909xWuocZW5qIbUEk8gLW4MO8FFCP8i
 zV+TDb2aV73FLefZJ+0IrYijh3MliqvVh3DClQ3vaD/xydI6BSxAXR5QW
 gMXcU8+vxG4fajLSmZu1Cg8ikd/uze4QCJDjBJYWdyODvlkZYZUQyOR3/
 LrTk2F0Xi/rN8DuR+rmZjhC1upt98dJTRwN/N1KBiN+9u0UtqTXlfPVW/
 rwxJwilLKeouik9aKxV+ZZOa80ybsM+IN6WDYxrDWtP3/7XqghlhSC49D
 ms4pGLbfrApRyj9Qiu3yVhJntyoLSGWKT4HheFH24zT2JMTAmziKVTsPM w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="336199400"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; d="scan'208";a="336199400"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2022 00:55:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; d="scan'208";a="663313840"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
 by FMSMGA003.fm.intel.com with ESMTP; 23 May 2022 00:55:10 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 23 May 2022 00:55:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 23 May 2022 00:55:09 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 23 May 2022 00:55:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaSkl4ZTjFNUKSM5a5qKjw8Lb3ecotqtFSDsXBM8ntpXIODgmEjfFhQVTCgqXVcrYQrBMDSgfSVmUGFTjlHpU1yLK2pz73tLgb83KkG0JxR0Sw00iOXie5VRH/JFm8ndOTIc1rdjs2AMA+6pHk9hBRF82L49oswLdZQ0m8HjaJKUNpOaic154fRW483W6zIA0rosxWYOvECzevyUzbLmbefmTNJ9FfK+YoOZQlwCs+dKwJqngZEMpENjDlHhpIYWA9aGnNzxvA3aY789oEoKqmD8MEz18D8tEVeX88IuUVB28wcCT2PknA+X/idykziMBb3ioDwDLl0f5ZqM+2j1Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGgM54O4wWvAciivwpAF9r0vnhZaW1Lo6WSkDbkqLpY=;
 b=K+OsCZIFjRALL8rED/L9iW0znZFtZx1T2pQDW8VO8pK3wFTUcMVObnS4clt8mmwbVzF8xRyIaCWlOuFwG+i918lwShepBk/g0XNjk7OdzGxt7WQctWw4LuRIBfO++k99M6I1liMLgsJb8rpXyNqgrgldV7UH3wbfB6ejqnxjwXyCxXGB1I5+SZhzSt4hb7bW6v7X2AENQLiYucm3Gq44hDQPCm0Xpykmjr/wa3GI9GRoSkxyw7VMB6b41yq0FkZCLdZZiIwV3NaFXH7wnj3/g01z/5/SFh8NZtB7EUxbAOo3oSFYHjQZENiwwETFkRLVGaD5yilY8sSFP+3EeFXtEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Mon, 23 May
 2022 07:55:02 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 07:55:01 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML
 <linux-kernel@vger.kernel.org>, "dmaengine@vger.kernel.org"
 <dmaengine@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse
 <dwmw2@infradead.org>, Jean-Philippe Brucker <jean-philippe@linaro.com>, "Lu
 Baolu" <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, "vkoul@kernel.org" <vkoul@kernel.org>, 
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "will@kernel.org"
 <will@kernel.org>
Subject: RE: [PATCH v4 2/6] iommu: Add a helper to do PASID lookup from domain
Thread-Topic: [PATCH v4 2/6] iommu: Add a helper to do PASID lookup from domain
Thread-Index: AQHYauORUoINsxb/TUyuLPLPKASxAK0sHSGA
Date: Mon, 23 May 2022 07:55:01 +0000
Message-ID: <BN9PR11MB52761FDB9388AFAA530544248CD49@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-3-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20220518182120.1136715-3-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9ba1a10-19b1-4491-4f1a-08da3c918a89
x-ms-traffictypediagnostic: MW3PR11MB4684:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MW3PR11MB4684CE82D626FF153858C7D58CD49@MW3PR11MB4684.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3dDbggtWZds7WUGdl0Ug1MFNo47XvAMSoLqqP9pctiuteiOqpY5FU4/7fQwzMDi5z6evlCJhMPQxmJyrI3w8RSPqjXJRvgFwGoqeMNzWEvu5O+L3DoH2iraQVqQ3ZUhLRUK/VVrnaAl4K0rCkqnqqOiwtHHk4OCZVJIqNMW1hh/uXS3d5GxI6p4GdAdaAcjxUgNnB0sBpKXJZxe1kGJgH5xUjHrqZAroBs8FgPYmIJ6ULL1bfQc9KdyTt2tCn6Y8r1+Rh05cW6cMvvR6Ru7+0W6ZN8kQpZSuVpnMX/2oZfmiyEtJ/WqDzqDDDCLzkKCamK5IX2u38kYhKvPN27CUoxgEaZUvuBVrSuhPmWXA1CVvtGHse8EUK8mcNRF4AL0OxXpEwtMEtD5RC7Dua3OT4rzKSmtjm52ookBnBntV1EOSkZkSxIx6ig0V9hxjLK+f7/WoqRAY3HYiqJPzu004/uWj736zATrtjTneYuNKokMfKjJI8fMXCOJp4VnQclJiChA1IiYuWiJzp2GYp9qQzYVvia5dQPJshpXdwRa60xJJ0QKaGUWqDq3rCfA1ZvASR9IkrFb0D7znnDmNVaIoMvv8T5HnUmTHp2UONa3JhJQFFQVxT74Id2h0zMLdhgdALelUNv/+JcIFzCqB4U8C2xC8gLsnu857OnZfoKm7XHld5mVZveFGakyQ9KGKp4q3t7bAKMQIGtF6/wO47ijawC8CKLAdcBWBV7TtGIFULaU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(508600001)(71200400001)(316002)(9686003)(110136005)(54906003)(55016003)(33656002)(2906002)(7696005)(6506007)(186003)(26005)(86362001)(66446008)(8676002)(4326008)(64756008)(82960400001)(5660300002)(8936002)(38100700002)(66476007)(83380400001)(122000001)(921005)(66946007)(66556008)(38070700005)(52536014)(7416002)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LGcZe//3lp9epTlZB+0iBHaG7n1SpBIOvz5fb2C8RFIe9JK2+bjSu1oCXIo8?=
 =?us-ascii?Q?yyLs79fTg3Gg0VGEK26ZHJoeW4d4p0zXwruDLYM4ZpdgxH7yN5m3gniVK7tx?=
 =?us-ascii?Q?AdsBl7oHr9M0KfbfNuLVAJdrzLMejC8KR4eVEvST9Bg62r7cDT9q0NV0thJ1?=
 =?us-ascii?Q?2f3Pb0rmMzWr2UfY8ZjfpeBfJ3vFwsRL+T+X2WCUrk+/SsFBcw5eJD+6wWru?=
 =?us-ascii?Q?qVN/wjFu5Idb0IAuKPHn3/x8IqIWGRKWDw1nHnS/SdTzUKDYdM43h3Tn/Muo?=
 =?us-ascii?Q?jXRUOW0ssLGXxuaKziyNfSLe65XdoY/Dgfmd/T0j4sDCMDu1yxVzokvFe6QI?=
 =?us-ascii?Q?yma5fgxR2bw/tdZWy/4kog9fevZW+t8nlNJOS2EypXKWe/Wih+mN5537jCMt?=
 =?us-ascii?Q?ATje4I8pSin+Ah66RIGpf0zXnhkkb7dmYyPk8GcRNblSfwRdIbQ/LBtc/vlt?=
 =?us-ascii?Q?On/dqP0cNfr9sS6shymOunL/Svhu0LkS6HB8IPRXZPNrgXHqmc62xBYgksdH?=
 =?us-ascii?Q?XMgkLqt4prc8OtpOXH5HIS/JmVl3lTmAPnHpGJe5fz4kB6Ic0JVoL23Sg6V2?=
 =?us-ascii?Q?TZnjPVKmvQa5sxLSYqoCIO+qOkZ2kZk7mSDA8p6X5Iu6V5/XMnmO0krvtzAy?=
 =?us-ascii?Q?DlbUAXS9YiZD48SALEGu3inkRTXtaGxOJAhJu5veGLgw092ZX2g+xy+txKCA?=
 =?us-ascii?Q?UMLOR4CyC2hvdPbnuwnQQdt+7hHpl97/4aPsitqk0OfFhJk6H5WzPhxaJTRJ?=
 =?us-ascii?Q?ZZAYAcm+aE9G5d3oeltw6j+b1W+6CBV+IFQDS1j2868B/GRV/AZS+rZRiePN?=
 =?us-ascii?Q?Ppp8lIZ/0HAS+HWSqyp8gVo0iT8HFubhU22R7ZOUbFkROBkk2GYnWI4CPxzw?=
 =?us-ascii?Q?n4pskd4i1Y9doX7ihhvimNV/4HFPJa2IQCjTLPYXMEPbeFcoaRBr6IaPVlzp?=
 =?us-ascii?Q?ErQFxOc/OF90CotdWovQ7ksXiw46nkX0wBBnPA/IOBFd+lLaF6VQ++L6B7i1?=
 =?us-ascii?Q?B3IOrgMdRBu36XAOopif/vHGMmq4MUsIcosYA0yNSyovDeuDlYwv6G01p366?=
 =?us-ascii?Q?GjjlPs78cyRlNcKkxgdDeCsvKMkflQciMERGVCAIJfaNs6GDxwH05vT8bo9w?=
 =?us-ascii?Q?td1XSeJkwdk6xANrWAXcPMP9PEnmBQZqUA3VBFw5BwBCDtsRBaCzq4GsmC4h?=
 =?us-ascii?Q?s2I1hjNa+nP6E00/U6Z1cQa4OQxyoOkIWs+uqbh1+XlM6npK5ZF6f7OMVBR+?=
 =?us-ascii?Q?PINynCqtiUoCV2KaH/obj7mdHTmpStjBBJzPEzEUKZX6bXMCjjhg+h+MLvg1?=
 =?us-ascii?Q?aaVKAEW+fCyvm86ge6yuajyeRQkRqJG9hz41JYOB6aIvFt/1Tcyn2PTKxzK4?=
 =?us-ascii?Q?SuR6D+rqF5R/itWlR5SAHPOv/qwLqJewkDfGB9vf0Hg6j11WwCFsy5nxnlTQ?=
 =?us-ascii?Q?pRULELGpm481xKaKRT49kKUiFkB0ExTP3x8qE+Ebggm+O0i/hU6c4y5iLXti?=
 =?us-ascii?Q?jtZkbycqLAr4YRlNiwnn8NA5i8gMp+9a5oh1BhdHyxO3FexKrg/2D1PrXK+i?=
 =?us-ascii?Q?qfBvkaYSEbbG1jkr4vZbiYoTtZj2ShzS/CvYxsDz08/RxNq/uJBD1PVKARwd?=
 =?us-ascii?Q?DaLAQLMAgAZKxi9kU+zD4OlMT1osMP8YYx+FpVGey8ib0dU4kSJT4cWeNHv2?=
 =?us-ascii?Q?PquP8dUJO5wtHRrqkpO4ZCt+vdDhJqTeR/bJpXwuSclTnKlozqMDDhgyCUEZ?=
 =?us-ascii?Q?bpPUg86dtw=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ba1a10-19b1-4491-4f1a-08da3c918a89
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 07:55:01.7901 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SLVt25K+OC/wMFygT3paD3fEAN++ApJwn2K48rj+3FnjaguiAMVfgaWAxn6pVSA5g0EGhH8b54aG6dF+z9p7EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4684
X-OriginatorOrg: intel.com
Cc: "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>
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

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Thursday, May 19, 2022 2:21 AM
> 
> IOMMU group maintains a PASID array which stores the associated IOMMU
> domains. This patch introduces a helper function to do domain to PASID
> look up. It will be used by TLB flush and device-PASID attach verification.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 22 ++++++++++++++++++++++
>  include/linux/iommu.h |  6 +++++-
>  2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 00d0262a1fe9..22f44833db64 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3199,3 +3199,25 @@ struct iommu_domain
> *iommu_get_domain_for_iopf(struct device *dev,
> 
>  	return domain;
>  }
> +
> +ioasid_t iommu_get_pasid_from_domain(struct device *dev, struct
> iommu_domain *domain)
> +{
> +	struct iommu_domain *tdomain;
> +	struct iommu_group *group;
> +	unsigned long index;
> +	ioasid_t pasid = INVALID_IOASID;
> +
> +	group = iommu_group_get(dev);
> +	if (!group)
> +		return pasid;
> +
> +	xa_for_each(&group->pasid_array, index, tdomain) {
> +		if (domain == tdomain) {
> +			pasid = index;
> +			break;
> +		}
> +	}

Don't we need to acquire the group lock here?

Btw the intention of this function is a bit confusing. Patch01 already
stores the pasid under domain hence it's redundant to get it 
indirectly from xarray index. You could simply introduce a flag bit
(e.g. dma_pasid_enabled) in device_domain_info and then directly
use domain->dma_pasid once the flag is true.

> +	iommu_group_put(group);
> +
> +	return pasid;
> +}
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 36ad007084cc..c0440a4be699 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -694,7 +694,7 @@ void iommu_detach_device_pasid(struct
> iommu_domain *domain,
>  			       struct device *dev, ioasid_t pasid);
>  struct iommu_domain *
>  iommu_get_domain_for_iopf(struct device *dev, ioasid_t pasid);
> -
> +ioasid_t iommu_get_pasid_from_domain(struct device *dev, struct
> iommu_domain *domain);
>  #else /* CONFIG_IOMMU_API */
> 
>  struct iommu_ops {};
> @@ -1070,6 +1070,10 @@ iommu_get_domain_for_iopf(struct device *dev,
> ioasid_t pasid)
>  {
>  	return NULL;
>  }
> +static ioasid_t iommu_get_pasid_from_domain(struct device *dev, struct
> iommu_domain *domain)
> +{
> +	return INVALID_IOASID;
> +}
>  #endif /* CONFIG_IOMMU_API */
> 
>  #ifdef CONFIG_IOMMU_SVA
> --
> 2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
