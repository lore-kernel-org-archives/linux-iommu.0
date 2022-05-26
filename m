Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F10EC433FE
	for <iommu@archiver.kernel.org>; Thu, 26 May 2022 00:43:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 92FCB405DC;
	Thu, 26 May 2022 00:43:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UjO8kF1479kN; Thu, 26 May 2022 00:43:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5D2F240491;
	Thu, 26 May 2022 00:43:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03ACFC0039;
	Thu, 26 May 2022 00:43:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC3CCC002D
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 00:43:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BC8C0844DC
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 00:43:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v5vqFyL_yW0l for <iommu@lists.linux-foundation.org>;
 Thu, 26 May 2022 00:43:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0BE03844DA
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 00:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653525812; x=1685061812;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VrTwFF6BN4CRadRRh0AgpzO9T/RqTIUqsN9VuPAUbTI=;
 b=bQb8Jpj5rusHiQpHS8nLrmUvXZPrLLc0JyyXJAaJwo5eGYbtdMRvVRpY
 4JtKBVoK2CYP+JjNkBMnV4vgeJTYdDcYXvgXOwqOZMw65Xkl4Svjafbrr
 JsvBAOqbVkcMZW452bn9hsOdhWUVziLqv3xUojHPVJU4X6B9fbU9HVEKb
 nLzxbgchbcwebu2RrEg/pgcmpKi/LsBe3SG7GcRXnvYmKH9PtEDDRnFUQ
 SmtWbsgj7UpPWNdxxnjZ0BRNoZ7i7sNi/aDovSsujKa7kVzfaYDzvIwdx
 JxOVq/LZL6caRnlJukMS+DOzarx0l5KU5qsXz+0XTtQbYV05isvcKqGNs Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="337028755"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; d="scan'208";a="337028755"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2022 17:43:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; d="scan'208";a="746027454"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga005.jf.intel.com with ESMTP; 25 May 2022 17:43:29 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 25 May 2022 17:43:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 25 May 2022 17:43:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 25 May 2022 17:43:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVwl738V6suDYG4xdPq/OdWeG0PI0IhklLML4x5LYXEw8zVEZKTFCm48FoM1HRow3Wjx1CdkUar8yc3B1yhbkrsML+v/RZbt0h286lq2AH/Mldm7as652Qx6Gfuf3wZv1w0cQ4D/iPtkwz7rvTwWJFtx/DYJPv/9zV8GJUR+0zgudJ1gbmWoKCfkuANx6i/A9r6O5pOJOBGciFzWPvP8bsb90XCnucg2zdvEI3vNxdGD3gmS/+yJNa8Pl46BDdIx4aa5yJbnvlpEVhEj7wehQQd6BcHEpR04OhKG2jNrH437lXJIYcNhsF/7Q2BEfZgBEP/vn9AzB/aXY0DblSGHdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3D7b79Jt/zp3IhdtSdH+6D3deSKMwvLKwaEpWGiGncA=;
 b=NIAge4kueNPE9TYUGDbZJSK+RoJSaLV95z4NaQfeXpQchbWebZq2PD4FSDm+hPsyIQIW6gOnYV0Km2x01uGD6gN7Vt3ErV6vHgEECp0mBycE20HoVKeuL+myIZgbExDnh40pUo3d7N+tyN7Pd81LpJSLOaaAoIK2WrSDe5ui4vRePNiQc39NktEo5OrS8c3P5VKutSUYso53cN85Terb/FFWybnHTiKItiSKTQ+PTMuX/HldcZGci01jZXLowgHzGcHYCmkTKONZwcBigIsfFtb/yp5Xm539dq+3s7ZImbf8Uxv9/BOxX4fHaWm+GqkSjPRZlxzPHhsDsfQyMic4hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB6064.namprd11.prod.outlook.com (2603:10b6:8:77::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Thu, 26 May
 2022 00:43:25 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8%6]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 00:43:25 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Baolu Lu <baolu.lu@linux.intel.com>
Subject: RE: [PATCH 1/3] iommu: Add Visconti5 IOMMU driver
Thread-Topic: [PATCH 1/3] iommu: Add Visconti5 IOMMU driver
Thread-Index: AQHYb9dlYq51oY+aJ0myX9YPOfXraa0vIReAgADJMgCAAGENMA==
Date: Thu, 26 May 2022 00:43:25 +0000
Message-ID: <BN9PR11MB52769A5FE5B8291F7D47D5AE8CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220525013147.2215355-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20220525013147.2215355-2-nobuhiro1.iwamatsu@toshiba.co.jp>
 <63369db0-cf7f-aa53-bf9f-de2b0b2289ac@linux.intel.com>
 <20220525182644.GF1343366@nvidia.com>
In-Reply-To: <20220525182644.GF1343366@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba35116d-780d-4577-1542-08da3eb0be90
x-ms-traffictypediagnostic: DS7PR11MB6064:EE_
x-microsoft-antispam-prvs: <DS7PR11MB606402A1BC8E252F28E3EC468CD99@DS7PR11MB6064.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hg6pMYYyrG1iG8HawkJdUtPr0e66SDlw/3tKzbcd11BKwEVeibEFCRzLqT+dlITOSkRiSew8KLQ99Sg+S1OOs7/9Z2k2AmeKZRYg9nazwXRnAVJOy85T6mW3bn8CH4A7zgL4y4g6z0Z19GCN9x2SOci08Z+L0Q5sgexigKf+lCPOkv/rG2wth9Rh0Zg/ld2NRyPBMWedb7mfkz2vKhRgulNvxSZ4o/l2GMPc1pfycr7h3WYKL72jBd6woUOkc8X4fvOY8A4hDjERmZFm2UWSbvzaNdD2/DhayfLsmb0L701oH5Bdwh4HnX4cgjEnTCYnMyp+9nYaqGnw79e+Enxcu4S35ADmzXdGst9JUAdSCQFvgunac4A6TMLGXLpPywvg7wvSWNJD+jgEcgcOk9fXpp9HoVgQmnktWShQBxSHrtsYuI1koZTOZHXBnfab+dcVh6tur/6Q02cfWTdmGxze/yXYHiOpl5srSfFiGTEOC9LoEwsx+Kd9Gklj4JAEyEWZlNhQPiuldwcrCvodUT3s4YuPEX0JJHbJdBSDBeCEPVF7sNSuK1hjk6Dd0TmiDrsjGw8QQtbSJlrR9IvcsDX1is2Ekkdoxjo5OyNUZJTV1ggoB9+R8VRm6sl90dq+c8G+HUNMvscWS12Jd1qiTgsl8W6lVS16QKsh8ftB/d/N+fwqCVGnpoBth4GFrxfglccPwIDlfdM0IjwglZ6qqLPmqw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(110136005)(38070700005)(2906002)(86362001)(5660300002)(55016003)(82960400001)(316002)(38100700002)(8936002)(6506007)(122000001)(26005)(53546011)(71200400001)(7696005)(508600001)(54906003)(83380400001)(9686003)(186003)(66446008)(66476007)(52536014)(76116006)(66556008)(4326008)(66946007)(8676002)(64756008)(33656002)(7416002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jBJFVBGqKWqn1klbI58xmWXrUOFNNHdXlFW+UgEdir6/7rlImLuW25Z9jeDM?=
 =?us-ascii?Q?XA4M3VHY2AVRdCNQebO2FEtQVhqzVEQZ16AkOYyP0/58P4Ha75ANQ06EtOJB?=
 =?us-ascii?Q?4YsgqtDWi7hAwOGutlVpXJjXmLxYXtRaE9Jgf1DRjY0ex4EL541edobp6ynD?=
 =?us-ascii?Q?5vELHD5O76oRUhpt29y64F3wPDVBB9v77VkoW4qPQWRVrD8WmXxK+/s9fxys?=
 =?us-ascii?Q?MlAQyZ3RnVi4LnarAo9cyihpuyfgxWM6/HtmZS5xpJ7gyNhF7QiLJvoLU3YO?=
 =?us-ascii?Q?uywUb/HZzuxo2LJ3YBSoEHp4PD+9B7ywbW2D0PWssHj65tpcACZUzroEWtX/?=
 =?us-ascii?Q?bDDPcbtfczRXc9LhozA71rMI2MC5oZV+1UYFiT8YK1a7Yt9GptSKC9fpWAL5?=
 =?us-ascii?Q?cp6mvHsv9KpQcX0TZmWmksxfno5JUDFAxkIANYOEMb9Cr27XEhWzTFJl0IM/?=
 =?us-ascii?Q?fY8fvZTJ4xOpeV6GMZRPsBlrlWRXoqjuW7ack5IS0YxhxkVz7abxWMX9/IYY?=
 =?us-ascii?Q?gnonTSz79vQRky6Aod/ptyjBAgFg3Jt3VC4YetOgTHwI9zXIvEXAVY4vFAAu?=
 =?us-ascii?Q?n6A9cqTK6ihV+jL00DqMfTXKeuGj2b5WjNVJEMDZQkPimMgOlZ/UUcH9jEpa?=
 =?us-ascii?Q?WaY5e5IOcBDnPKcycLU9XRm7D1h4m0kG4isOrrKZeEDXBtD/T4+uy6TghPTm?=
 =?us-ascii?Q?RW5JE2iBb+eTNRhbbl3WtOd7tzdCPFCzQnoCS4Zwxe8agEF4X2KKBpTCgAjG?=
 =?us-ascii?Q?R2DlqaMMfvFgp8tUx11iRrAIUA0Rns/vzmW5vK52+KSgNpHrlw5px6oCxTPV?=
 =?us-ascii?Q?b2IUBw39jDQ+DCm2jaO/bod/snz+DkBdRyY5y/Sc6+2N4XAy3FUx12myfOom?=
 =?us-ascii?Q?5yv7eFbKyopd7ryxdc7A9q4S8kQNF7vdE35su/4KSq0CPGS0R4FQidm+QN1Z?=
 =?us-ascii?Q?qGj62c/5yayKHD4kqQtnLNhVEUB4NxLe3rSThiA+loNE8R+GQSWACv02zWMZ?=
 =?us-ascii?Q?mKJVtP4jxrBm2NqA8bwICJqKJhFYumfl18Sle5of3O2ZDWY4Nvvu8tRP1H4U?=
 =?us-ascii?Q?RN5gLPqbK4Xw2MSC/dZOHye09hcQENhkiA3M0bo8Kllswt8vkybVJhXv0WOk?=
 =?us-ascii?Q?LUlwWPXil0WtqpprchFhhNrwtIT0Htjzb8imFEO5BEbANqRefB7amd8hVV0s?=
 =?us-ascii?Q?zfE6NXFV6Cl8PUnqTAW+pbTEC+3vxU1/lQSM7AWsVU+v5GiHGlNF656jG43m?=
 =?us-ascii?Q?0d1KDAbqXdVkG0L0xYmR5z8btADIOnZOHNcsJllG5CwMWXSA0IzYyp8KMoSd?=
 =?us-ascii?Q?cs0GZFKgnVFZmE4tSNEVcCJxac1aK5a/pVbEZD5i1rSXrqXEtkmhx5K6Nhj9?=
 =?us-ascii?Q?1dqAvJrP5+I/WPtqlBSwq7bc0i4lak4UW3RT8wyIk5TOINE6MHdAFVCcxqQa?=
 =?us-ascii?Q?liGtN0Kpa8s5/NmYur3zaaR3fiYD746zxYakpSauryJTmUQ24uQTLOApP23S?=
 =?us-ascii?Q?G2EwpyJub6SAKk5RvktjkWGL41Y0ayKI9YvCg4NcYm/LhHtTvAdFgxKC4UKJ?=
 =?us-ascii?Q?1+AU5M2xx8afp3XWiZ4InXg2xrHWCkAZP708aKV1pIzx6a/jOAzhi+gP7CCZ?=
 =?us-ascii?Q?SXZ2wSLKuyoDQy3k8EqHHkdduMf6ZL8qA5pkmoJ2dQsAeY1eU3QLSwn3N63z?=
 =?us-ascii?Q?Xxjcutb9l05Ii6mn7zJEZUayMrEgrDMrrzCTfwxLIJCmKnF6aCvaoilxe/hb?=
 =?us-ascii?Q?hj6KdDcimQ=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba35116d-780d-4577-1542-08da3eb0be90
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2022 00:43:25.8157 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jIURNZbro/TO7JYnw9VgA+FxV0kp3Bv2GM11QlMUUkM/hVo8qu0vWb7kd1Kzj5blqmY/yuz4am8G9IisiYV5aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6064
X-OriginatorOrg: intel.com
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Rob
 Herring <robh+dt@kernel.org>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 "yuji2.ishikawa@toshiba.co.jp" <yuji2.ishikawa@toshiba.co.jp>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

> From: Jason Gunthorpe
> Sent: Thursday, May 26, 2022 2:27 AM
> 
> On Wed, May 25, 2022 at 02:26:37PM +0800, Baolu Lu wrote:
> > On 2022/5/25 09:31, Nobuhiro Iwamatsu wrote:
> > > +static const struct iommu_ops visconti_atu_ops = {
> > > +	.domain_alloc = visconti_atu_domain_alloc,
> > > +	.probe_device = visconti_atu_probe_device,
> > > +	.release_device = visconti_atu_release_device,
> > > +	.device_group = generic_device_group,
> > > +	.of_xlate = visconti_atu_of_xlate,
> > > +	.pgsize_bitmap = ATU_IOMMU_PGSIZE_BITMAP,
> > > +	.default_domain_ops = &(const struct iommu_domain_ops) {
> > > +		.attach_dev = visconti_atu_attach_device,
> > > +		.detach_dev = visconti_atu_detach_device,
> >
> > The detach_dev callback is about to be deprecated. The new drivers
> > should implement the default domain and blocking domain instead.
> 
> Yes please, new drivers need to use default_domains.
> 
> It is very strange that visconti_atu_detach_device() does nothing.  It
> is not required that a domain is fully unmapped before being
> destructed, I think detach should set ATU_AT_EN to 0.

Looks the atu is shared by all devices behind and can only serve one
I/O address space. The atu registers only keep information about
iova ranges without any device notation. That is probably the reason 
why both attach/detach() don't touch hardware.

iiuc then this suggests there should be only one iommu group per atu,
instead of using generic_device_group() to create one group per
device.

> 
> What behavior does the HW have when ATU_AT_ENTRY_EN == 0? If DMA is

I guess it's a blocking behavior since that register tracks which iova range
register is valid. 

> rejected then this driver should have a IOMMU_DOMAIN_BLOCKING and
> return that from ops->def_domain_type().

BLOCKING should not be used as a default domain type for DMA API
which needs either a DMA or IDENTITY type.

> 
> Attaching a the blocking domain should set ATU_AT_ENTRY_EN = 0

Agree

> 
> Also, if I surmise how this works properly, it is not following the
> iommu API to halt all DMA during map/unmap operations. Should at least
> document this and explain why it is OK..
> 
> I'm feeling like these "special" drivers need some kind of handshake
> with their only users because they don't work with things like VFIO..
> 
> Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
