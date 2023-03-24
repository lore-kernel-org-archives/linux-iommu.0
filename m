Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F747E
	for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 07:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679642379; x=1711178379;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eoNkke/tJYdrX3xXUNisg+ukJz2sdef0fg8RBBLCLMQ=;
  b=WuBv/Ck1njUXMwz+FQ2Ylc4uWZjwSLtQIg6glVu1oDKw9N6LOP9RQWNY
   cvA+jDATcsnP6Nc4ADnEG5amrO7byiePFLk784tdf3j6Yprv2sYskRpfR
   LaLwDjuzyEhgzispSX+PFv9DeSti7MmyDQXVSFyCUyskjJwziV8RfQeKR
   IsEkax+eZUOiYL/Sz1lonLXtyMzHRmi2tPwWN8c7t6tBOV8k8nuVCh9so
   gPrFqpiARkqQySn7/62qNcw/7Xo/FrmWr3jGKNFuEVyDae3VB3AnHeT1B
   TKbGb5p9IF9Y2dgGKX9scYWFd/mGnF96NS+LKbqheNYLlwMHqOkldtNGP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="337222113"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="337222113"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 00:19:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="715117217"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="715117217"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 24 Mar 2023 00:19:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 00:19:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 00:19:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 24 Mar 2023 00:19:37 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 24 Mar 2023 00:19:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEGfCLs97G8dtHyYU49dzUOMwzXyGX2YRW/ekF5xITJIDmKodeVVtivHOVIKgypXC/qtQxJzLRiXeY3tBjETnTP+Oo96Zg0vCwj/4Lr57yoVWQ9F6n3u7dSkozJ08Nigu1iqRSJg2XDi8b1RL7aMIFjqRWqHYNkGn5G4Sm1TZnwxhtZPHXIuqz/VXpebqblXkOlnVr80gxWM1RTB40YwSTcJ5jL4S96SK2AlhiDp/czZfnsDNcxz5mys/KblDLmwIgY2qw5tkCBhQjbCGtoLixh9e2fJJipoPEfdmemgec8c5rTxo8IAZ9ISWedStrlYLs8WJfwz3H91u+ry6FiOJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoNkke/tJYdrX3xXUNisg+ukJz2sdef0fg8RBBLCLMQ=;
 b=ZVy6IgewGt6oBo8zBfDOTNXR1xixh14Y5xMtcWoy9z23SdxLkreQ71tolcoWjSDj0lwI3QskCdtOu5WpVss1wh0WqGxUL6E78JzmSLLW6x3f6AP/b6naK37RGd5rJHObJU3NTu86gc3HYPAhkcYXDW7gbo2iFmz+s86AKntrM8cgFq5w7ntPJZiLvguBZ48+w7LMfmAySvWewaPUUxQyUBZd9hsKNVBs1UoNU4E5Leh2/kGWf1db/flmuxnGsONTxYq8dj+xpgtjOidyK1+oPxQNIUsIhkIhp1AqjubrKcmqIGI/gGvBTOoHHonU+CAL8/YWeMrvTPNecRh8LxEBpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8317.namprd11.prod.outlook.com (2603:10b6:806:38d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 07:19:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.039; Fri, 24 Mar 2023
 07:19:35 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Robin Murphy
	<robin.murphy@arm.com>, Will Deacon <will@kernel.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH 3/9] iommu: Use __iommu_group_set_domain() in
 iommu_change_dev_def_domain()
Thread-Topic: [PATCH 3/9] iommu: Use __iommu_group_set_domain() in
 iommu_change_dev_def_domain()
Thread-Index: AQHZXC7ZC4GnRR8V1UWENjNpwAN++K8JiUoA
Date: Fri, 24 Mar 2023 07:19:35 +0000
Message-ID: <BN9PR11MB52769E3DD95D30D1B97E3C9C8C849@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
 <3-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <3-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8317:EE_
x-ms-office365-filtering-correlation-id: 3b94ef34-5739-4ec1-d6ac-08db2c381f42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LdWUQdevvJn0wTR+KSIiN9H0WTJ7ovdLbJguQT+ZEZ/2SOlq3eXI0eQ4sI44/rTI/WcjhzFH/m92BuNoegRFmr1STjUUXiRBUuXPK3lKAg6vzfzUk/meklphhOdgumlYaYZZuFBZn/NERbDuBLReIxTM0OU9b7y63V1wQsakGlqX8ZIv1BlUtx2zXj/f9cqsCJYRiCdJX5jwMlgu5PZtxyBrrN3GziWn29NU0LntMqAa4PCQunQV3QSPRtCsBaWSibUu2t3ahmdzblCzpMzql7V4t/2D+Hfyr70F/T8QKBEL/HbB6l8SxnVc36CqsVLtDa63QZ9KyRCOHZ77cAUOoTcF/+RFYyiJS4Fp9ovNiYIw4TaxoYQ9YV4qNCujNad2uV53tmcmma2UO38Gsh26KnAI3lDa0Vps9pUWT7krqhmOxTLFTeb8gMcF6GYy5HKoSvO4WWxJR2sRawM3k0pEAoDtpK+XuTYxtJ2DjBcGI+uKhSneEV+tf8CxBD9JzGDWO3R9d4/Kb48vSKT/caGjBtwSzQ8Ot7zOlF0U+tR8XfoBv2rWqQEyv5n3FJo8TJPcuubaGIjgOBEV32AhYVR5insY3Hghhs/ndupllGfwWfRN470bIA4Ykq+HTdK8pUoBpt47omcmUdVh2kCtsGnvxhE7tVHTk/B5VWwtHOno1cJ4myVq0MOLgiy2iIvdihLqK+upTDSd6b2vKOJZPUAIEuNIxps1hRdBdD3i1mtgkak=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199018)(33656002)(52536014)(8936002)(122000001)(41300700001)(66556008)(4326008)(66946007)(64756008)(66446008)(8676002)(66476007)(76116006)(316002)(478600001)(71200400001)(7696005)(54906003)(110136005)(966005)(4744005)(2906002)(5660300002)(82960400001)(86362001)(38070700005)(55016003)(186003)(38100700002)(6506007)(26005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/G5va+tUt/EKK3lYnVqUqDOjMC1Q7tig6HREJgJjrwjCZQebg9vFZJqTaKY2?=
 =?us-ascii?Q?wiHhX9I9vRyxDxQMeOnAfKYnah11gj+4PRuamQ6aA53X5amrmlGHNr+4TzZG?=
 =?us-ascii?Q?obhrLWWQoPb/4q7Mvdu5hR17iSWkc53Uqt+cOOgOH3IFbBbjJ9cHG8U4+Rsl?=
 =?us-ascii?Q?/9xOOhQJ0Zl3ozPiG24mYUzbOFSgdiZPmkbh/JG/RXWlqMFRiPXwzOpcDZ6M?=
 =?us-ascii?Q?3bt4MnnjSwGJMjx/+x5RZuFtsPQUYhFw9Jz/E1izocbeQURhE3lspvklIYfb?=
 =?us-ascii?Q?QxMKWGRWgPX4du1/rByIrJijH/ubs4Wx7t1TQuvqq8xpBjEu+DJqG+6an+w8?=
 =?us-ascii?Q?/TacLNh/9W2Dvd4+zsvBPQ9OgKi8D0PrBmPA3o85vZ0qVP97ad8IT3ml9Tyu?=
 =?us-ascii?Q?m1GW2kcbfluB/YXiYQoDuHmx5ip+fVomjgtCLNxwLmLvbkb2bpQ0M5wrNzXC?=
 =?us-ascii?Q?SmbXTNm3SZbdr4lRRQc4tR1JrxRHq63m8vr+PQwvX4IIFlXCbLCUhJA0X8IR?=
 =?us-ascii?Q?rD88j6oFjh+N+dR+js4biZ39qe/GbiK8XUpZqUcK05xZ+N0+1Ulr12ovZzam?=
 =?us-ascii?Q?V6xOHzISBgWMBFhZHLW1ToTWbXvsIz8kk0P9fVoLKogyCLN+vF5ZUbRoVzBh?=
 =?us-ascii?Q?+z5dm/+zlNnogcRmXc0QbLUzAF5AK6vfJTBzknOUzUfhS4lYLC+m4y4t31h1?=
 =?us-ascii?Q?8jVDRnCl14b/HxdxWH9isfvOTVV/OcqA48/ZuPYMa0w28JKW82zn554eZ1Ql?=
 =?us-ascii?Q?XSdb3YzNZCVLdtwBISgzvC9VIG+rhVpL+FI636AWraD5oTBDbEhcfE7MhJwk?=
 =?us-ascii?Q?MW+jgnx/HhQyOJqLPezjAcONcR3LaDBuSNTV4lx+oTJFUw4KPYVk8k/cJuWU?=
 =?us-ascii?Q?60JIaXOgyCPVtXdH8FhkjsWqNNPFEWZRC694Oy7PlfkFwWYvPxbnETCTYrIF?=
 =?us-ascii?Q?VoTJhVMpCVdBEP8/fsWCWozcvlDM8ophgmF/qHJ9ejcdRtHdbWMpNGvdkwz/?=
 =?us-ascii?Q?0A2cWbGwGGVZJm5raztdYin5O3WR60/5mVdvP8fXejJD6H1B1PydvSpnPBzo?=
 =?us-ascii?Q?YgFxIsNDfwcZVwjULNzilDx9lBucizYJ7sxHc8k8VjEmpmWmd4cKIK28f2Lw?=
 =?us-ascii?Q?vR8EwN0DLH55TMh45puLwAP0H22xcs+Dd4tPUIzJb0XOV0tK4V5kP0c0pPjT?=
 =?us-ascii?Q?FIst/LO1oeMuj+oxgPAwh0OTfH9tky4hZyBVGoR0y/Jxdp/uOSRW9nHE+0+f?=
 =?us-ascii?Q?u9zHVZRn1+od9VLgVAieqb2dg9zE5/KdR5s1wYIm5Wqx2gcQv1alsPVadcns?=
 =?us-ascii?Q?5pE8px4zpqAHOjGIuQ+/6yQaIqadAvlnEos9IqnmkYu9uL2eWTIMN4/SDnBK?=
 =?us-ascii?Q?PsBIX2xKgod6mPH/Mt4lu/+HnqDO/xd6ibF6fiaEUDQUyHgFDRUU0Z317J/Y?=
 =?us-ascii?Q?W/LYQ3JV87ymjC/IefEkfCHyFHyBLO8Bgw7O3Tg26A/RKnv/Jd7Y6kPzkW8T?=
 =?us-ascii?Q?q5xX+OqoRMb7KujCkmMEEMTjQGuer7OHgjkwHebU9sE0OGylSNacIw53v4jC?=
 =?us-ascii?Q?AFugpsU73SzXahoSjSIBZnpSGkqJPlc+YjPHmgxB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b94ef34-5739-4ec1-d6ac-08db2c381f42
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 07:19:35.6853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nyI8/JSW2l0fnzOU9EQvvuHd5/XwtMpvpPC4PQQaH36u7xOUMIg+ojrqskYCTUyV4BT1SXOjt1f9dKS0fNon5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8317
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, March 22, 2023 3:53 AM
>=20
> This is missing re-attach error handling if the attach fails, use the
> common code.
>=20
> The ugly "group->domain =3D prev_domain" will be cleaned in a later patch=
.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Joerg just picked Baolu's series [1]. this should be rebased atop.

[1] https://lore.kernel.org/linux-iommu/20230322064956.263419-1-baolu.lu@li=
nux.intel.com/#t
