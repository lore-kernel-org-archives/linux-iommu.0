Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D2FC433EF
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 12:31:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 615D4405CB;
	Thu,  9 Dec 2021 12:31:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id icU2muHJ6yUI; Thu,  9 Dec 2021 12:31:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D53C8405C7;
	Thu,  9 Dec 2021 12:31:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 624CFC0012;
	Thu,  9 Dec 2021 12:31:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 815FCC0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 12:31:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5BD4641BE4
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 12:31:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com header.b="BRZDT50u";
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
 header.b="pSZWcSyA"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8oNy82iqM3fd for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 12:31:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8FEF341BE3
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 12:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1639053069; x=1670589069;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BfZHvelC2EcY/I8Pw4YsrpW/AoyjDziBZOjn+4Z5leU=;
 b=BRZDT50uJAne4Ehw6fmZeBNvFMcxFRazpJJe+RInTGob9PZht5Dzr6Wv
 2RNThAigiqXkX39e0n0oI4rlnFdI7G8BlPKDjHmEzl2f/o4j9T1RUpNC9
 YGci3LeGh+QkXYGItCTol3QDjJ6DQdVzM2QnuU8vb1yj5+NExdKEaR1aK
 qu3ttYgBdvXPKLGIOrTN9qEoGwRCpadjQwfAPkuMQttUDZITrA+9/SxR7
 p0wIxq4o22l60kkYftVLd2AON+WCEN/PoIvxM/ZkmQrpqg3zUvix4wCG0
 IU0Sxgql46J6wn/UZlEewfUa6Yw2LqTzzonHj6U070JM/ic3lNxQ9+MXS A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="298877653"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; d="scan'208";a="298877653"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2021 04:31:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; d="scan'208";a="752489893"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga005.fm.intel.com with ESMTP; 09 Dec 2021 04:31:08 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 04:31:08 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 04:31:07 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 9 Dec 2021 04:31:07 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 9 Dec 2021 04:31:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbwHKE60pOvBzpKkjTu9dycdXehlaSq0sqdDEiI+youEynlfkTdQOQ9nLPus1R2NCIIo4myajY/2N+4D5yIiLRkDhFVICxYaBVTxYS3jROvJlDw0xIeIFse19rLbcIIPE26/+OBcto5sf2oxkiED2G+eBWip9RqWWgOu+kOh+UwSj+b7TZENNnJGEJXHMgw0BTA79Ow01r+h5IskJEubD4/OMpW3vRxmxMPdZeLr5uGTHz+IjCl1yCjSsNnmGqLOOvPomsRIJoGGi0/KUP5OAWAuPzOFEKYcoI84ID7+VFyDK6uHsYFY0Hv3nu+qsXRdYJ/DkdAK6YyRWM+ig1T/HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRJ4BjgOA2w8/QLDE0sI0cvWAu+qB6YlsXYS7r9lJw4=;
 b=Q7qgoFR3t1KroijMoyIXdRY5Oz1mWULrU+a8xmFk7RgmBhIQgnJ1p+0xfwNBs6jIympehayRBNJjt54jzH3iVqLIbRDF2evvILNJ1qTKYc5oi29r/R9PGtKulj752lXLy2WAt+EnJOmL2y/hAaolX1XEMvy8mmZzLl/ro15LtDWK0JpR0deChy3mMWe55TiAn1vLFaQheupwVATW3dtHrY8U12snsYWu3vJG9YM462Vk7wmg9PZvHeNyxdvTLNHFI8+ezw+pAWHU95Glsm7Un6bN3QqeE6vCHCPXxInCMvMFpCUliRl+vtSwZiE1e+lMdsMeFPPcqUXdJe/PqcHQ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRJ4BjgOA2w8/QLDE0sI0cvWAu+qB6YlsXYS7r9lJw4=;
 b=pSZWcSyA9g3QN3/SewB5YZMdBT9LW/xfjlNpSyT7a1f9d49I/utuWlVFjvuWl8YryF6YrgWPyHHo7jcneoQqvwavRTfb0wJdQuD28ybgpj/u4d7UmF/BYGH2gofMmlDlg/GSxtVxvU0LeCG91AnMmy5n4R0fyJriXXcmA/Hyc/Y=
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN9PR11MB5225.namprd11.prod.outlook.com (2603:10b6:408:132::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 12:31:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4755.016; Thu, 9 Dec 2021
 12:31:05 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, "Jiang, Dave"
 <dave.jiang@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Thread-Topic: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Thread-Index: AQHX4y1VNaiO68omHEet2J9DWrVARKwa1YEAgAAp0QCAABreAIAAIi2AgAE8MoCAAAd1gIAACyoAgAAPcQCAADDDAIAAp1uAgABn9QCAACTxgIAAAdGAgAAbd4CAAA94gIAABpSAgAt9SoCAADlJAIAAPbeA
Date: Thu, 9 Dec 2021 12:31:05 +0000
Message-ID: <BN9PR11MB527661C48959F977AC3594438C709@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com> <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com> <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com> <87o861banv.ffs@tglx>
 <20211201001748.GF4670@nvidia.com> <87mtlkaauo.ffs@tglx>
 <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com> <87pmqg88xq.ffs@tglx>
 <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com> <87k0go8432.ffs@tglx>
 <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com> <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx>
In-Reply-To: <87sfv2yy19.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d9ee7df-7739-44f6-17d1-08d9bb0fc552
x-ms-traffictypediagnostic: BN9PR11MB5225:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN9PR11MB5225CEBF159EA437CBE8077A8C709@BN9PR11MB5225.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2f3vYV16NT+9F9FMfeY3CKcItDP1NBSrmOQHFkNrrKaFr6PWUsZZ0u41KxlQ8FImwpvLVjy441FAbaeVs3CUC/rgs9YlECBAQQHXWwaI6NAPH7/GtBTxVoSJ37tTQwrOw3cfFXGuYXusfJI5Rq2q5KJ5TRqGRMIPhfeJ3Q2t2qImUD81/4/pFH4RktiNqEweZUlIOtTYYQdohCIHC4LGkysKIuec0W8OWOG2sAkqZYwWwo838WbtsVnm1XOT8dOqOO92BPFOfPoGeOtNeapGG+QIa4qhhz+kaU7bqFm6LtWuwzMuv3m4otorFtr4QSnZRhBYqgzZpEddcSy5Z61lKk7sAc2dyu60HBNt1j3JWtNwkIabBM0Fvijll0IaSYfmsgRtj4LMCOWAjL+e8eek1Th+rO0AZZFHk1F7NxPsZgj+izKWHsDVpnBU0BhAnZlyJyVbcIeM9DWfOXiyOXjPfE5k3lIFY7pHAgx1lhh7i4hfbgZqiFumheQk4tHhj3qpcXugpvZ/Af4Xl7IjrmDjIWVUqvDVX3G8f5xme+J0GyQQyMaH1D+9odVaoU5mW+BXwLwfMEBtNmc4mXgq/arsWkWKPjXsjpucZ0apEbLlncqJCiebTHAT0IhTTQj8xkKhwWjcxWcVw5NBA/WZ/rGjWt4CmCWtx5IM1886uybp7JyaGRG8ckXzA3Nu3K+Kg2QbhGpmX7AI2RXN0bH62fq2Qw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(508600001)(8936002)(66556008)(86362001)(66476007)(54906003)(8676002)(2906002)(66446008)(64756008)(66946007)(71200400001)(38070700005)(7696005)(83380400001)(76116006)(7416002)(110136005)(186003)(6506007)(5660300002)(82960400001)(55016003)(26005)(52536014)(38100700002)(316002)(33656002)(9686003)(4326008)(122000001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kD8YDDAyEnbo1xE8TgMDgy2NNf10AQCr75wHI79Vmhft1gJM9IO5YTatQ6zx?=
 =?us-ascii?Q?Lf9HoSs1NVeA8Uon+W9CclGY84rh4a73oU0HzTnCo1RsD9j7XDMN2jcmu9+3?=
 =?us-ascii?Q?FcBcRj6BJXE5iACNlsnvFwa0Lm6dGSK/pK3n14K1FwnTG2zwTnG/1/s9uDzG?=
 =?us-ascii?Q?GM+ebwUnO6IooDZ4zVSt4w6Tu7l141WjKEnWIQKPbAYi+BDHKgB5u7gaGx8L?=
 =?us-ascii?Q?z3xEdhOvvbaa8CmD+c8mINZhAziMzDikFP82gbk6dPMT2cP+m5C4N0fR2Iwn?=
 =?us-ascii?Q?tVazETEl8bAR8fQpws5Sa1BWA7l0QGfD2W3umZbM9//ybj/fFKS3DBuGOY7s?=
 =?us-ascii?Q?/pJ2+iDaR5ulHFXqZc5D97j4+bDnkQCTBsIQKlXUNp00j0nJkRTtvbtag/M1?=
 =?us-ascii?Q?hb8wwmk330qfjnC6SFvjx92OK8mjyr/W+oZ271h0Z8wGf9+V6x1bBspfRcLK?=
 =?us-ascii?Q?+d3WEjcLYzaK59EisyllsNDHASsQBGrGhRiWMmT8Yz+fzfbFr1/SqVLyTaGO?=
 =?us-ascii?Q?m+Zr0cuJSgWx9jDZ0BcJ5pAZuboni9Tct96un4kwSizS5Vrh3v05DAPwN+gp?=
 =?us-ascii?Q?UyeCZGQ4Cpd0TJW+XDt/rQYajoxkoyk7q368lAVi5MfNGPLB9IcSvG3aJ/Gj?=
 =?us-ascii?Q?Wo3vkabH35OVrZqbvVIr+EAaqIlx2vu33MUq3tSfCx3ExoHVI6g6/2vVd1Oq?=
 =?us-ascii?Q?uWWT82jkQ9zXV6t/R56kvh38QgkZA2Jknhn5q/Yo0ZjAbIBgTVFDw47Bmbkv?=
 =?us-ascii?Q?1KPUY6lW1heaeFYVjAUS/X38snlXAaq1PY1V/FItU8ra6F2p0RqM2sEqWtWw?=
 =?us-ascii?Q?B60tVj8TRT/Mi/jq5JtKFjGRrBY6CNEXXYsHbXtOnm4E8wFFRpt5hJvuuldf?=
 =?us-ascii?Q?rxrGDaSjZlxl3eHvYuafP6frwWvW9rraVxUdUVUy+NUQvk+O4tQIE98lBxii?=
 =?us-ascii?Q?I4eNYm2t2tMtNVTVFlzOGq3T5bOT/DN0XeeXbFTWLjTMXZ3cRCxpzbWvMAve?=
 =?us-ascii?Q?NBJDdQt6evXRmJn8VVR6twr3xJwkvQa9+ae5NXxaWNUMoISHPMJW9tih1Fcu?=
 =?us-ascii?Q?HAoUoGEhPpEa9Zy9HqoZEovqHmMB2qP6FIgrHmmzgqKXlbFS8EWd0Hk8wlIQ?=
 =?us-ascii?Q?evf/NlHqKSH1BnDQ1qP0Hq49sB3SUovfB7pVlIP+ZRiS/lNMrevgqiOxszme?=
 =?us-ascii?Q?UfXhA8pmKpn6xafzPMuwqGoI/Jy4cE+KiDON0OBWgAfnxYXm2a99CtvNpawB?=
 =?us-ascii?Q?r36rk+bPTALwXd2/ClmpOU0K3+SVa88ptrlr5wUsWvFtnQYzPi+MAUGuih2x?=
 =?us-ascii?Q?ufkcCylyathIQzhZC/Ye3UBbd9WfSciEzRqGDDLFpWgULDNDTZLYWZtAAc3T?=
 =?us-ascii?Q?otVGFDh83cQ26fGHtZhnymEW99zS4x4n4ERpRuGQMsZc74r2m2SUyss8KVFH?=
 =?us-ascii?Q?p4AXtaFxR51YirkU88sa+ih86tk1l8FgYSLcfS0Hq9YWr5gm4crT9hV7CviS?=
 =?us-ascii?Q?vyZ7hAsN5IURawVz6ZkvxrbxyoPOZSIK/ihkLJWqMUkaREwcm55FTVlGJIvp?=
 =?us-ascii?Q?A0HItxy6Nrwc1Ct09j8c9jOnH+UiDsWpGCvnzIXQQ9bWlPI2cS6aUgJNjSDv?=
 =?us-ascii?Q?SmOOB7fjN207xyEKLF/0x0E=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9ee7df-7739-44f6-17d1-08d9bb0fc552
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 12:31:05.7836 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /u+GxY5vDMTz68HmzxMEcv1CTr3jIsj8YkASHaMLY8r1oX0T14dp5og9RqphwlKwHjUQkcHpjO6GWdAVfCRzvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5225
X-OriginatorOrg: intel.com
Cc: Allen Hubbe <allenbh@gmail.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, "Raj, Ashok" <ashok.raj@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marc
 Zygnier <maz@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <jroedel@suse.de>,
 Bjorn Helgaas <helgaas@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
 Logan Gunthorpe <logang@deltatee.com>, "Dey, Megha" <megha.dey@intel.com>
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

> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Thursday, December 9, 2021 4:37 PM
> 
> On Thu, Dec 09 2021 at 05:23, Kevin Tian wrote:
> >> From: Thomas Gleixner <tglx@linutronix.de>
> >> I don't see anything wrong with that. A subdevice is it's own entity and
> >> VFIO can chose the most conveniant representation of it to the guest
> >> obviously.
> >>
> >> How that is backed on the host does not really matter. You can expose
> >> MSI-X to the guest with a INTx backing as well.
> >>
> >
> > Agree with this point. How the interrupts are represented to the guest
> > is orthogonal to how the backend resource is allocated. Physically MSI-X
> > and IMS can be enabled simultaneously on an IDXD device. Once
> > dynamic allocation is allowed for both, either one can be allocated for
> > a subdevice (with only difference on supported #subdevices).
> >
> > When an interrupt resource is exposed to the guest with the same type
> > (e.g. MSI-on-MSI or IMS-on-IMS), it can be also passed through to the
> > guest as long as a hypercall machinery is in place to get addr/data pair
> > from the host (as you suggested earlier).
> 
> As I pointed out in the conclusion of this thread, IMS is only going to
> be supported with interrupt remapping in place on both host and guest.

I still need to read the last few mails but thanks for pointing it out now.

> 
> As these devices are requiring a vIOMMU on the guest anyway (PASID, User
> IO page tables), the required hypercalls are part of the vIOMMU/IR
> implementation. If you look at it from the irqdomain hierarchy view:
> 
>                          |- PCI-MSI
>   VECTOR -- [v]IOMMU/IR -|- PCI-MSI-X
>                          |- PCI-IMS
> 
> So host and guest use just the same representation which makes a ton of
> sense.
> 
> There are two places where this matters:
> 
>   1) The activate() callback of the IR domain
> 
>   2) The irq_set_affinity() callback of the irqchip associated with the
>      IR domain
> 
> Both callbacks are allowed to fail and the error code is handed back to
> the originating call site.
> 
> If you look at the above hierarchy view then MSI/MSI-X/IMS are all
> treated in exactly the same way. It all becomes the common case.
> 
> No?
> 

Yes, I think above makes sense. 

For a new guest OS which supports this enlightened hierarchy the same
machinery works for all type of interrupt storages and we have a
failure path from host to guest in case of host-side resource shortage.
And no trap is required on guest access to the interrupt storage.

A legacy guest OS which doesn't support the enlightened hierarchy
can only use MSI/MSI-X which is still trapped. But with vector 
reallocation support from your work the situation already improves 
a lot than current awkward way in VFIO (free all previous vectors 
and then re-allocate).

Overall I think this is a good modeling.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
