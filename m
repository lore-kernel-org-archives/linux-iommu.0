Return-Path: <SRS0=QBaT=OR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDEFC433EF
	for <iommu@archiver.kernel.org>; Mon, 27 Sep 2021 01:30:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDB3F60F91
	for <iommu@archiver.kernel.org>; Mon, 27 Sep 2021 01:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DDB3F60F91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9BEBF40142;
	Mon, 27 Sep 2021 01:30:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F1kOSABg3rN7; Mon, 27 Sep 2021 01:30:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0FFBE400BD;
	Mon, 27 Sep 2021 01:30:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C94A4C000F;
	Mon, 27 Sep 2021 01:30:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B962C000D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 01:30:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 855F680DDB
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 01:30:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aiEip7b7OwQ1 for <iommu@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 01:30:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B7CCB80DC5
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 01:30:19 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10119"; a="221182652"
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; d="scan'208";a="221182652"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2021 18:30:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; d="scan'208";a="654586978"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by orsmga005.jf.intel.com with ESMTP; 26 Sep 2021 18:30:18 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 26 Sep 2021 18:30:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Sun, 26 Sep 2021 18:30:18 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Sun, 26 Sep 2021 18:30:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8rwy9TG0Tts9sXSLSDMwWUr24Oae6j+7PUowjGw5PsopxhhaiAPMNSYX6eF5hLszwBs8idThFuK3kCflu/o8hphG3xata4VacC82CkTq4mKvLBV4FMEiDLKb6VrBfypPK29ZKST12be5c2/toAiSMfdmuNyIejpAu2QaYzFLq+pJJAlAU5mvSFW9tQL3wZJ9A0MujqM+TyNw3chEzmiS2rwVawt+6M3+1HnG0Khy7EaMtDy2N+/Wx5L3e8bYpLYIdm+ohCrIhxYnltU3uv/+bQPec9cB/VM1g1p0h2vgODoa8P3WDd6XvyiaOakkW7djxon/7GuGiGAyDPnKwSz8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Zj0pvQ7K+Qx6sFnbrOuSsY96ZuZjogdk8DaNVEdl+us=;
 b=awk102UIcvgqxLI9gucpgoeqJV8TRDb/uF4h7SXPdDv0o8fsYI+pRpfoVnr67mQeC0ha7BwDb3cmDt1DX89MuH8+TNOyjppOv/ZXGeVPzYPIxtvyvndETtarFsuZnhvQuYzPdyAyew3RGX3RZTCFeUIxgw8qvpgpDoAnwNuAOLgPl7+dT2fSXuZUJtBxmjNhg9rk2pF6kmfOyKU1m8mcbPET4ve84+pMPBht7P+K8xhftsnqiMmdbtBlIHJBTzy76wpppW2OMBnxldsGP+kb4BmEHEHXIWr9LPCy9A/LT5qH+2LVq4TCD1qQpRqtke3hIGb2CwziJPBgU+uvzTPcvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zj0pvQ7K+Qx6sFnbrOuSsY96ZuZjogdk8DaNVEdl+us=;
 b=NcBfFtEo7mqOeYGyHJghk/5eOYP4kSVHTd9C1YHWa2DVdUNrsTEE2muPf4XFld6Y4A7jWxm9IXhnTpDokfCEHJtBtQGxNbPgcbQNykG2r061P6zG73iw4m7CbO3v3lBfhgikn4jVITzhAitjj0WOMgkD4NuGFK8Elj09PxpPmiE=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR11MB4098.namprd11.prod.outlook.com (2603:10b6:405:7f::36)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Mon, 27 Sep
 2021 01:30:16 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 01:30:16 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH v2 2/3] iommu/vt-d: Check FL and SL capability sanity in
 scalable mode
Thread-Topic: [PATCH v2 2/3] iommu/vt-d: Check FL and SL capability sanity in
 scalable mode
Thread-Index: AQHXssyKRmq7SSPsJ0uVeb21B0HFDKu3ESWwgAAGWoA=
Date: Mon, 27 Sep 2021 01:30:15 +0000
Message-ID: <BN9PR11MB5433FD7DA0C372B22364C1D18CA79@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210926114535.923263-1-baolu.lu@linux.intel.com>
 <20210926114535.923263-3-baolu.lu@linux.intel.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e44eacd4-2462-4657-6df7-08d981565bfc
x-ms-traffictypediagnostic: BN6PR11MB4098:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB4098530CD4AFCC3180F17E0E8CA79@BN6PR11MB4098.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:608;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lAKPH6DDlJIr1K1oAWfite4xgG6e2fDTfgnkz5IXWxJPe3UWUys9j5wds5EvPySfX5O5mfEJQmGDO4Oa9HIrpWsIpha74146drGbZJ6nnRInG8weINaa3YYDGBNWFEYgV90H5yKM/ySvvO96ygNdUV+7h0PfnH3D9AuYPLGTmlooXP9xJqq1ErGCyzAnTb5Et432m00uqx0ZN4B24IfxLjTZUvKtPowFyBMsEk89PyR+9Q7SFddAnecbkgs4gxH0gj99HBqu0uDR6stzAvcYpIK4X/RrB77WuufHBPlIsPV5VXUXNzYnC9E7mf+UvWaTEQPWCmxVWXe63kGPdKHN+4vs+uKx7y0XxPLXizTZHRDsGkoMq1kLhMyhQ7CiTba3VSGsiB50bY/mwhDCbtQ+VkXZYqKvhr/Hi5q92yQwRCBqSZn1dpuMIMSiBKDXulv/o23DelMbzeaU0J5CXmmT0hFMd6QvhdYGSO+Q9aVtQLTDnSrjx1gbGXthLpW6WMTC+YHy+6MtzA7PIJIu75VlmDkbCjfW1d+C5+yLujb6eGtm3ug3WPSrEGY18MVRZXYhGMCMouDVbCimyescjvj9mjkec9fdEdeXgMpgOq9QB9e2mJVjyPHZAA6SDKCSEgt1zgkFlBN7urUKRJHiVUsvvVzgo6e4/p2o/6lGHyFpHFxwRsQmjrPEoA5D/k3s5V6CxoIQY8cqnf2STpqe72CkuQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(33656002)(186003)(38070700005)(5660300002)(52536014)(55016002)(8676002)(7696005)(66476007)(66556008)(64756008)(508600001)(316002)(71200400001)(122000001)(66446008)(2906002)(66946007)(6506007)(86362001)(76116006)(4326008)(9686003)(26005)(110136005)(38100700002)(54906003)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cWY6/IuqLX4Hr0TIy+HALO9HPeHtdGWD8B9Per8hGoDkfy4YTDrxsnkLyvkr?=
 =?us-ascii?Q?W/njF0M4bg1pkPpZRwYuiX7zHCylvp+8lZs7y2deSlYSjt6xst5geDI29Gqi?=
 =?us-ascii?Q?AXt/0rXyBwxMEd7XGUNOTddsfokrNS8ld6Z7/gTbRcfmAAhj27u7hjKdQaRo?=
 =?us-ascii?Q?+M21LS2i4zDonB0J/0pn91uSZQ3fv4s7RNH7JAMJUwnEbh10YhI/qWQ9oDDQ?=
 =?us-ascii?Q?Kc0iYT13MSkyknT/rjRM4z8oReZo6mpisnGRRb4J9ZRleVZQxbT+Y3BewSse?=
 =?us-ascii?Q?s36ktM0/lbcoe6YRYaIjLz2FwDpkyU3PqxhcVfffCIEc+6JB1/LPtCtXybab?=
 =?us-ascii?Q?c7W6ZFgD9UKCP6tZ0lVm8+Kz5zfE4hyIBYJeityq//xkHFCyxWWKbQ926Utg?=
 =?us-ascii?Q?435KCWWqyYmRw0R0+ZyWIL6T1K2Nw+6NOgE4GA8QpBZkEta18QI8Kn2iJYxI?=
 =?us-ascii?Q?6wWfEjH6PMas1Uw4jzz4JvW/Fc5D4a5pC5JVIILW9SmTvYQLq8ounbYz/QsP?=
 =?us-ascii?Q?DsKATp1Yh+4kvCgISclbwe7r80DOkq4FOTn2C2gfUKeHGm+CXshu1Paa7+AT?=
 =?us-ascii?Q?ijEcuBQG8rhbyGABb5yM4MsCDv5Drcmo0IKFlfSkr0SJE6/nSxFmodflb5+5?=
 =?us-ascii?Q?HDgi74AGiJbhOEhRUk9YY+Ly5f/NpXHMtT0AOa/GUhs5MF95m4qv2vU/z1JH?=
 =?us-ascii?Q?Tk281vppochb+fTmadBngibS0jLd4jILixJebtIMvR0YQDeTRe1oTSfAKjNi?=
 =?us-ascii?Q?j/BUgFoxG6a7Dmn102IDQ4EHvmsgPCFrCdYW6Da5L8sRn5ryGxsrQ7miSpAi?=
 =?us-ascii?Q?Hrgvtqdb8ZPSvedVMHz0+H/QAPRM1TmT6L/vTooBJzDfI3D6gjUaIYhUTdvF?=
 =?us-ascii?Q?BEzH2BNj7vkV8XY+2usTe/x7rmW+GT9EtNRTpn71qSaibTFDdsiGG1Q3wWlc?=
 =?us-ascii?Q?Q9rsuEV5CV/cfWnmznpCGTNdnE5TnlSMH2iG0/1vivuRosu9ikaRiyaIg5LB?=
 =?us-ascii?Q?CJF+B8XfEVwYWcglhqkMIxqZNBVIOjlRifzL95k5S/oOoYdC7z/Jeq0trAod?=
 =?us-ascii?Q?fNuvNg02Mm2pUBtVu1JQDh8t2ckyJJ0mOD+/u5AmShs3zXmRUl7ukvdiMf0Z?=
 =?us-ascii?Q?D3Z2pSZ87H1y96PxrcGX8/9vR+PL28Y3pw7L0YqGjEY1ZbGJcxq7f9I9gMr2?=
 =?us-ascii?Q?B9h/sRWaNchR1qV4hKC46zTSTKhamcXhhSet6St10FNK5AdxpBfBIc0+S4mD?=
 =?us-ascii?Q?NPM7dwiytYH1k2nMJk/sM9el0+Q9fzyjOIjEKuUKsDQpG40PEtycV+BTMtax?=
 =?us-ascii?Q?vg2cWnFDGpSkwZ0CWf/W5F3g?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44eacd4-2462-4657-6df7-08d981565bfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 01:30:15.9200 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AAVQfyinGGAmuDFUncP3zMqzCoKnUSlHoo3TzB+cRfJzPb1GfoP/HX11hp0tVDe2X2wUsE4eyHlXOfRD5Zvi+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4098
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

> From: Tian, Kevin
> Sent: Monday, September 27, 2021 9:12 AM
> 
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > Sent: Sunday, September 26, 2021 7:46 PM
> >
> > An iommu domain could be allocated and mapped before it's attached to
> > any
> > device. This requires that in scalable mode, when the domain is allocated,
> > the format (FL or SL) of the page table must be determined. In order to
> > achieve this, the platform should support consistent SL or FL capabilities
> > on all IOMMU's. This adds a check for this and aborts IOMMU probing if it
> > doesn't meet this requirement.
> 
> Is this a must? Looks the requirement comes from how the current code
> is implemented. It sets DOMAIN_FLAG_USE_FIRST_LEVEL flag in
> alloc_domain. But actually the pgtable is not allocated until the 1st device
> is attached. If this understanding is correct, you can also postpone the flag
> setting until pgtable is actually allocated.

Baolu explained to me that RMRR regions are mapped before device
attach. So this check is necessary

> 
> of course how to handle inconsistent IOMMU capabilities is another
> orthogonal problem. Addressing it should not be only applied to SL/FL
> difference. especially this patch doesn't check consistency. it just
> checks that an IOMMU must support either SL or FL which doesn't
> match the commit msg here.

and the overall inconsistency check mechanism is already in place. 
and the logic here just extends it to cover SL/FL. Given that,

Reviewed-by: Kevin Tian <kevin.tian@intel.com>


> 
> >
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > ---
> >  drivers/iommu/intel/cap_audit.h |  1 +
> >  drivers/iommu/intel/cap_audit.c | 13 +++++++++++++
> >  2 files changed, 14 insertions(+)
> >
> > diff --git a/drivers/iommu/intel/cap_audit.h
> > b/drivers/iommu/intel/cap_audit.h
> > index 74cfccae0e81..d07b75938961 100644
> > --- a/drivers/iommu/intel/cap_audit.h
> > +++ b/drivers/iommu/intel/cap_audit.h
> > @@ -111,6 +111,7 @@ bool intel_cap_smts_sanity(void);
> >  bool intel_cap_pasid_sanity(void);
> >  bool intel_cap_nest_sanity(void);
> >  bool intel_cap_flts_sanity(void);
> > +bool intel_cap_slts_sanity(void);
> >
> >  static inline bool scalable_mode_support(void)
> >  {
> > diff --git a/drivers/iommu/intel/cap_audit.c
> > b/drivers/iommu/intel/cap_audit.c
> > index b12e421a2f1a..040e4ae0e42b 100644
> > --- a/drivers/iommu/intel/cap_audit.c
> > +++ b/drivers/iommu/intel/cap_audit.c
> > @@ -163,6 +163,14 @@ static int cap_audit_static(struct intel_iommu
> > *iommu, enum cap_audit_type type)
> >  			check_irq_capabilities(iommu, i);
> >  	}
> >
> > +	/*
> > +	 * If the system is sane to support scalable mode, either SL or FL
> > +	 * should be sane.
> > +	 */
> > +	if (intel_cap_smts_sanity() &&
> > +	    !intel_cap_flts_sanity() && !intel_cap_slts_sanity())
> > +		return -EFAULT;
> > +
> >  out:
> >  	rcu_read_unlock();
> >  	return 0;
> > @@ -203,3 +211,8 @@ bool intel_cap_flts_sanity(void)
> >  {
> >  	return ecap_flts(intel_iommu_ecap_sanity);
> >  }
> > +
> > +bool intel_cap_slts_sanity(void)
> > +{
> > +	return ecap_slts(intel_iommu_ecap_sanity);
> > +}
> > --
> > 2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
