Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADBBC433EF
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 02:52:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C3C68138F;
	Tue, 10 May 2022 02:52:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OFNr7g4OAh3q; Tue, 10 May 2022 02:52:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 17A0E8138E;
	Tue, 10 May 2022 02:52:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC6B9C0039;
	Tue, 10 May 2022 02:52:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 743A6C002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 02:52:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 695F8403CC
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 02:52:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Rtc5Eth9Igz for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 02:52:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 518B5403CA
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 02:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652151142; x=1683687142;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ktczw7NjHomaWOqMkUUABx73kin5UtasTmxYr0E+qO4=;
 b=ISlAOgI7/To69azs2ZWfcGJGby5M98ri8Cr9+MOw+SE1HJyiQ0qA2cLp
 wz8OgYeUHSgG9GKguk4FF7dICVPREy9psYW6sfZ+7NoPufEgQLsLj0Ucb
 ufDzVX1uypZ/fk8ohCa0B12u+7M0XjfhuGsnnHa6UYaZpgO/21CKnpdz8
 2DRHfTmYHSf4q/aUE0qG9nyVpIRMggrZmh0aP35kaAF/+U1mn5KskRZ45
 l4Kgu+h8hU61E9GMzpa4u/MtbgAnCySrbrg5tF7wo7lIgCeiuvFcacpBR
 b7AFm5qahwq6BMAwvdgNxps5XliJ/5cMLKDdJjgsFc/fzmf8X3MIFkJwS w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="329835714"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="329835714"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2022 19:52:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="519529183"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
 by orsmga003.jf.intel.com with ESMTP; 09 May 2022 19:52:19 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 9 May 2022 19:52:19 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 9 May 2022 19:52:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 9 May 2022 19:52:18 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 9 May 2022 19:52:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7vBuX8mAvXJocJbIpacCPj7TrY5OTaQXqT8MSWJtgGpwChptv67kgykwRtLyR+lzIFVC3dj8vgj7Jcv0YxzbBQlUY12MCzJmUHj5/bEoFcva5il990d5tg9DhSjuTHRywlRQH+axJ/BlBxL29lhQM/L1LCcvFyXfQaPwIeSRbZG6qeaJYC0oCe8oTECcGFPaxXN1iwQV4Q5ulbe25RxFz4FiatKicY1IfCMIxiuDIKsb+7DEkO4FNCEwPSpAg5+VlOuFzfzppgolJeGLowCfSlCIuicFPGux3X+sijoIpm1lsqJ7Vhp7dc3hcEKtN/Vm0QPiH6imQ+tWUjjPLv+Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ok0maPu+A/nCaUObYRiiRelYZDCRISlcAwmXL9MKvP0=;
 b=JPWVxwT1h73a4QfdWSKQTnAv1IToO1zw9Y50BZ6DHi3HKz0za4gNeGxxqVe+e0j0K2dhWcTqXnMswaB/+TOB4qFx+EwmlHoj5hZSABWmJMPctQ5kf9uL++vB7n2KfKCHxzS7r1xS53w9vvSQDCLR/bKBt/7OQwC5WmhxgGMjjYWbqk8dMtDZIJEL9NXr2ETs8gg5oSG28RFdjDB0NqmBlUkCq0te37hReK1lA9Lz0Scxk84E7SNZEnfCITA0RuEqguLpRRPRt5RmlFNsXHOrkajBpP2QDTcsILAcVUr41G2ztbDJQWlGcrSIc6OyKjUVBqUlyNxb1CUNtl5+r/rJPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4446.namprd11.prod.outlook.com (2603:10b6:208:17a::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 02:52:15 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 02:52:15 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
Subject: RE: [PATCH] iommu: Reorganize __iommu_attach_group()
Thread-Topic: [PATCH] iommu: Reorganize __iommu_attach_group()
Thread-Index: AQHYYJusplp8455nTEigm2v8aR71HK0RkZqAgABFf4CAADi1gIAAE7kAgAVJGCA=
Date: Tue, 10 May 2022 02:52:15 +0000
Message-ID: <BN9PR11MB5276C1F29A3D1B0BD9F2FAD28CC99@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-9bdc3d71e81c+494-iommu_attach_group_jgg@nvidia.com>
 <94ced5af-820d-8fe7-4bb1-3d552a45b80c@arm.com>
 <20220506132113.GB522325@nvidia.com>
 <9b19440a-9cee-2f3b-8ab4-1316dffa33fb@arm.com>
 <20220506175446.GF49344@nvidia.com>
In-Reply-To: <20220506175446.GF49344@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.401.20
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ac0c278-0afe-467b-b9b8-08da3230174a
x-ms-traffictypediagnostic: MN2PR11MB4446:EE_
x-microsoft-antispam-prvs: <MN2PR11MB44468F33AD9B122352B310D28CC99@MN2PR11MB4446.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3BhytSaLtOjTCoh7/rLesLRKgL5oRta5DGlTnCGutrWFkjjULKfmcAGy+FHPpHYyKS4a3/bU6zkqWgJ+CezbWeYR+6iN1+wOCZbHGptvihxcS0KYZodBSUrW4qGml1pURJ5tIpd7TBU9SgEoREabWJqaAbXHGAV1AFKdozg4rKSyjUXZIjUXC0vGgXa4DDgb16USGGdSA8ye2sUhHlNfCzvO9ydDMc5YKmzi4Ox2bQIirfXumR5Gsrzj3z9fnNG9saUvf+1wQcEE7dDR8652vhzFJVY3NQa8pneCUv5t028H7CdSt2XxmSzYXIH0+h/qNceZpRaLQ2aGZfjeLK88nAZJ5CdhqGpLcQF1LZECU3NN0y7HFwNxEnLNoDCctYAGvzy8sDPCQ0dtFQVtc9ZucDMHP8rbmlvNicHnOIqaYOYO72hgi1HHNz/BwVQNVahD4y21R9rUDUzPWQpZs4eQ6s3mAsgmvafY+4YlK/xdNi6iCT93GpUnplLSiGl78Q2cD84kpwSLwulWmLQsi56tM4RIQ//kQiKF0Qoq6n+zYc6l9iSQZLRYXwBlqLdp1IE+CgV7ujgHJZSokeanBs50NMz+YavxnINuVuTL5Cjws+1Gx60ivlwfzJp4O0pCurH2FxEQQoBhvSvaJksRn5JyN8TZvw6yXZhmz+XiTzyFUFab+C8cLidErv3zbd2UWm15tXbdw1A16nF8C6oX/zoARw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(71200400001)(66446008)(64756008)(6506007)(2906002)(76116006)(9686003)(8676002)(7696005)(4326008)(33656002)(86362001)(5660300002)(66556008)(66476007)(26005)(66946007)(8936002)(508600001)(52536014)(55016003)(38100700002)(38070700005)(122000001)(110136005)(316002)(54906003)(82960400001)(186003)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zGHVsqjyOJVHoAudw+moQyl079VQfs0nxdfvnnp4ZqYzEGG5OX0EjPbs+HZE?=
 =?us-ascii?Q?5eT1jO7eJY3xGXkevfLLp1wnMb0G9woQo+uVaofzQMU4YObGp9Ao0bNaH+to?=
 =?us-ascii?Q?LQOvmTSV2PaHJRL3UobxohhleNVMVUHFc9+MM7DBcCm8TAe7+MrA94+nO+OI?=
 =?us-ascii?Q?z3D5P6UcCtMUXLMrpjkN0OOJeXBdSheRSWHoagkiXhYeEaXmOWEfF2NgV7jE?=
 =?us-ascii?Q?IWaZNszf19B9zXpE22O9HUHhy57kbJUS89zyH7Cap2/TWBPkgsKJzp5WCeKg?=
 =?us-ascii?Q?eVJOr1+hu5AGl3SAEidyucZCrVXwecDBIbLGMpbk1V3xdv9lqKhy0esvVU43?=
 =?us-ascii?Q?XoEVeXBeyvSpOuax6L8ftvDY+poUpcQ7AD7bwDDcnTUZterk9TGdwJVrSPLE?=
 =?us-ascii?Q?y4CE1siSzZom68A0/05BStziGieSEMkrEToAcOLbNFB/yKIbfLWXTzPsNg0Z?=
 =?us-ascii?Q?QOs7MohDcRxWRa6dRF3ToIi43LB9XSCEvKvSc25+L6JlzZvrzBd/tEhWg3SM?=
 =?us-ascii?Q?MkjYfu4wWYvHhkEKfVM5OJok8BpeNB6JOPvNqvmtBzSggczKpdtKdGk17ccN?=
 =?us-ascii?Q?KgzGHJci+Gsy/ZCigqqNYJNv1MtLT/i/8xe1f7UVvKweLOlOvUxxud8aNhwY?=
 =?us-ascii?Q?nOUV20CNDvq4haJOMOWjTPi8lfTu4DEWy2pfSw/SX26qan7eEzzgbaE73ebH?=
 =?us-ascii?Q?CAII2LYnLY6og+ZplMayn0H42Wc7kgIxTnLHGmgAVri/AkNJaqkn3mBUlEAi?=
 =?us-ascii?Q?6dtKDOvfVJUrCluxHMAqvgUuM7H2XznS+Mzz+SdomRrZGX7b1JlRhuFfmvJp?=
 =?us-ascii?Q?ZeZ+dkvuKC2kcxScOvUzB6whSvMQnlN7B1QjYSDybrMqdIozFH7ylX/nRCsy?=
 =?us-ascii?Q?D6DtOEgkH5DyO6jNAW5k/KdndyhoA196L0QZVaHCOL/Qu/3HV4cmM/cA4+N2?=
 =?us-ascii?Q?etbqHW8zBoTR8+qpftsN4tZ3EZ5Wa1ixjIQEOoiOGerzgRIEScqnzCsGyquq?=
 =?us-ascii?Q?bmXXz3g10rs0HWzikUwRuCKTuOw/+96pf2xS1Y3pMVJh3m6LZ58IAAX8rsXO?=
 =?us-ascii?Q?axGY3WCQvVyYkWspXUzvzHw7WeuGEe9QRaESFlD21fvz7fxbrByzf7vnQeUS?=
 =?us-ascii?Q?dNLiHv+nTtZoUhMtyfO524ijMDLoJDGBn6D6yNRPdIhPLcIe0CITh2mH/h33?=
 =?us-ascii?Q?S1Ul/MXPSFLoHJ81vQmD7/4h9eK9iJwaOd/qFwPNcs8mt71wTjscJyLEzSPc?=
 =?us-ascii?Q?s/0DHAsmTN/Uxr5L/Cn63E3G7UyZTGvLstNTPz6Jm/R0CTiAX3b/4Fl+ZCS8?=
 =?us-ascii?Q?T0iXKVPk5UYLpqG5i3hkEGvFa3kPzxeP/EavBuP41HDLUqRWz6ngpVrJ5zSt?=
 =?us-ascii?Q?rf6e7vpo5pye0O+UARVRhDKP4KIhR4esIlsub4XoUgChbXNqln5bBu1ZSwDg?=
 =?us-ascii?Q?Jf07r3obEx2Tes4pXcu6IhSdLxBhvuTKudQ+U6gw+G6d5JnprV/ODgw/zZov?=
 =?us-ascii?Q?TqZePMVYqsqIpd0APK+PLaga0DLrqDAzWiweRWikud3VpCs5i2Foyrt1jU5I?=
 =?us-ascii?Q?enO7GFTnMVsqWI0DjFrWuCMjXBjK6luXQSX54K+n0Ho4lEJ8jIRdglIXjeQY?=
 =?us-ascii?Q?c7jlqNRcIFSi6wVlgAdQfBHLDOuCME8Tk96oco/WsgrH5wKh9V/27BmKtBVo?=
 =?us-ascii?Q?f7AK9sRgDWLU0ZaLItOfSNxkhphQsgUuvjDS7p86QJJwCP3ySAqNE3+4P5Iw?=
 =?us-ascii?Q?BREz3BdnqQ=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac0c278-0afe-467b-b9b8-08da3230174a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 02:52:15.6470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vd4MNBfG4Ea0pLN61r6x9vVW4wfMRY6yKH9UfU+9MT2ATzpgUfKtdor1XGz/8dgUOzBp7xJJxg+CEBNRBJlhfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4446
X-OriginatorOrg: intel.com
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Will Deacon <will@kernel.org>
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
> Sent: Saturday, May 7, 2022 1:55 AM
> 
> On Fri, May 06, 2022 at 05:44:11PM +0100, Robin Murphy wrote:
> >
> > So if it *is* a domain then I can call NULL->attach_dev() and...? ;)
> 
> You can call iommu_group_set_domain(group, NULL) and it will work.
> 
> As I said, it must have this symmetry:
> 
>  __iommu_group_attach_core_domain()
>  assert(__iommu_group_is_core_domain())
> 
> This is why I choose the name, because it is a clear pairing with
> __iommu_group_attach_core_domain().
> 
> How about __iommu_group_is_core_domain_attached() ? Solves the
> grammer
> issue

Or just __iommu_group_is_core_managed() to avoid the confusion
on whether NULL domain is considered as 'attached'? 'core managed'
can cover NULL domain as a policy in iommu core.

Alternatively we can also keep current name but moving the NULL domain
check out, i.e.:

assert(!group->domain || __iommu_group_is_core_domain(group));

This actually better pairs with __iommu_group_attach_core_domain()
as the latter is clearly defined for non-NULL domains:

+/*
+ * Put the group's domain back to the appropriate core-owned domain - either the
+ * standard kernel-mode DMA configuration or an all-DMA-blocked domain.
+ */
+static void __iommu_group_set_core_domain(struct iommu_group *group)

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
