Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA147E
	for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 07:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679643008; x=1711179008;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wRb/nT8qlkN8O5Zn4HVnNQcaTFkhWDKhbkMwS+b08R8=;
  b=Nb3o4o5L5ufpnBQ+Gyw4SVO7KmCYSzepLyKlLm4JOKuNA6L4VvyRDokr
   WKd0CTJCxpKzKcpjlGPamnqHRjU/rRQ5RInpMYOiReGPz/AVUCCbu8o01
   XrCtgIKSYSJFxYt41zs4+upRtwqkkf39p6kKkBUAOmIdbhg6imqsE6t2Y
   gvLpUoVN3AHt31Y4ydJ5z3kHMzaCD1Q2J0IBqn3oNFYt2dv0sAQHEflxV
   TYa6IsAp4TzNdQ66H6tLBFhCup119ERjFHdRWU7O52gYqy48CVeeBXunZ
   2seeRTVLc8F/JRQ41F/s8kpOyTrWTJD0cEjoqxW16Wng/Lf9W0OHg1zJn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="339744332"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="339744332"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 00:30:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="751786677"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="751786677"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 24 Mar 2023 00:30:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 00:30:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 00:30:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 24 Mar 2023 00:30:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 24 Mar 2023 00:30:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rf9Uy2mC7HgzqK/LupjWE5gPoIR2cd/k/t3h/V0rRZNbhcTPT1cERjpy/Z1T6/e+GCGmeY1KzNHZrRhKk5pvqpWhgmTLZzHyXu/SyCKvYqejjUGVulrRP7gwNGKA3C8eBif7b/is9VHI5hbOxA/TvQCIW4bqn44Km2pHZlX2cCUxSXRNRQa7tQ8kZbwQEeNBY1zl/6ThMq/0mc/WVwVGIuzseAS8fgjXfm6IIIZcOK2bLTI1szHwQ+c75//t55oA36Eq5X/g8xPP9iQq9pmMFH0GnkjSPiInMB5o1+NRojWs2weJ6gHCEkjU2pPCJmoJ4MVw0yojqgjh+/Cgu10izg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQFawfcTJ+WoLhZvvXUuPNKoVtETKjJUsKOaBJqfn18=;
 b=Yyfesyi0diAZ7fS0GQBxPtf/+7sZVjPoRtRX/c4GyhMuwhUHll8TkTS02rMCRv8HVdQz/bjryk72J9e9WU657LacwQrp6h25s4VRYOtSACFV0BE0mNYyrmzVQq960gM2eyZMfowxdowDcphI6PFXNB3qJr2IgIdEq23SkCZsPtn4cOYmFkr5ZIb8hbk9LGe162FuHhPd6eYflicnsdFjGXR8Nfdfpdsm4hFxhQRvMHjgiWFVp1Bsj5PBYiNGgjkY7B0y7UBTvnxDaYNBRsco8rx1OAMqtNxEjLVBbZ0XU30s0/gu1X1eaU47RzhsrWG9GIH/Y2ouYLkDS0M7sjNFNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB4892.namprd11.prod.outlook.com (2603:10b6:806:f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 07:29:59 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.039; Fri, 24 Mar 2023
 07:29:59 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Robin Murphy
	<robin.murphy@arm.com>, Will Deacon <will@kernel.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH 6/9] iommu: Fix iommu_probe_device() to attach the right
 domain
Thread-Topic: [PATCH 6/9] iommu: Fix iommu_probe_device() to attach the right
 domain
Thread-Index: AQHZXC7WUzsuUhBmakuB2HC1URwSfK8Jir/w
Date: Fri, 24 Mar 2023 07:29:59 +0000
Message-ID: <BN9PR11MB5276832381FC73EA5E8C05428C849@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
 <6-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <6-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB4892:EE_
x-ms-office365-filtering-correlation-id: 6a29003e-5909-4bcd-5228-08db2c3992f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fyVNopXtBEiahtGYQmFIbNwk5riOsXj0isDh09EUtfwI/2MsJeNO6BBh1VRtbssDIeCJVuBEBwGLseO4Mm5y1v5IkHa/RXjWVOkxWqdb6vyTfp6ThCAbZMggb8bu2noEhG/Vk3Bj7C7zFSTk9z2YTds4Di9TTzOU/IjiblVoEk8nyUnp6AC7pSG+YgoWkMmZCq3HM+g4pAmDKa31dArr+D+Uq18GvxCKdeL6PrBipmdjjlXQdQuWlXE3AdIJD2UENt3Tfc+Va4nxjiCqfbO7MyPYfvjAi56u3CpwvCTiJplUMPI7CnsKAN0Kda8rQDdfPYXINTqg3eeVdh8upva4CpfimZO+GDSvHRRdA4hf8pQSOQaiUuzBcmnaAWDd1kAffKi1UC7YHsvGCW+H1jENjTmpioYeBw5Y0xLnBdezwgzqC0hyIwHI6c2mXztnguYbN17usE/mgrs7lvAXgbn5+ZDhfwcBYq9zT/5fuqLDBzFhlVxNm1blxuIFDbr+k+KC/AiVRj8ex2yEe4WHu3fohubV2tuQpagVEGY5MA3pH+lue6J63NMwExgvgOuXhB/oxV87E7EGCv6gjp8HScjnmu/yBEag0mkyJSt/C52dx9TzNeHeWN9W30HuKcYtSU7AAO+hszxVwEg8rC1ggj37VJchmEjN0f9auq9BJKF7LyqFbUP8WXizAC2MlbvFNtkAeCMJdKZsIPE/A2K2TgB4pg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199018)(5660300002)(122000001)(2906002)(4744005)(41300700001)(82960400001)(52536014)(8936002)(55016003)(38070700005)(86362001)(33656002)(38100700002)(478600001)(7696005)(71200400001)(26005)(9686003)(186003)(110136005)(76116006)(6506007)(66946007)(8676002)(4326008)(64756008)(66476007)(66446008)(66556008)(54906003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nGrdSZixL4hXFHCdQnKyr/9otXjZW/cht9S7ZIyfU7Ms8p+OHMTFqPahB4zW?=
 =?us-ascii?Q?eOvJOa5+4YDalEmtu4TT4e2gx82+It8BR/6q07M5s5XwEQA2zPTt2Sxc+cGf?=
 =?us-ascii?Q?aYLzcatbmVnNb/n9mt7r407MUh0yQAPysj6iQdRHHaVxs9VCYVUoXwDV0G1I?=
 =?us-ascii?Q?5Z4HPICg41Vw32wqm2CI33/itvaKwJ5ruzDnZshJstsQS/29S787wJWVhooU?=
 =?us-ascii?Q?WnK4JVZOOSw0r2wQDNLC/lv6mpvfOqpqpTx/09tqSgq5a937CFnmCZ5zs6vW?=
 =?us-ascii?Q?/n/UYzzMCq3srVER7avNyzI8XrelqSlND4Pkx7SF4GlLUjBTUNFye6LIf3Ki?=
 =?us-ascii?Q?p6DzuR7ewBx0HeGgW9uOSXKuDdbqGzme40J5fX02B78Fa/GYSfzJKUig0fj+?=
 =?us-ascii?Q?3kUjSLFiUv0Yv2gxris+11t/lup2IFqVNYTMmZHhB1zPmWnK2zBLB+p65EMk?=
 =?us-ascii?Q?3J+AH8BPRkTpfWuuELeeof8tjbJ3p9APs5w4VYtBva2c9LCFzxiES2vPiJn/?=
 =?us-ascii?Q?RtndoubWtnG5Rcpq22ZMv9I66ObLkuWvwN4FlK7/i/pb1TvL3KDwzOIt9zt7?=
 =?us-ascii?Q?XQtSNG+08R5rNHaagjFxCXFPvcWMDgJ8KQa4wbUP3B1/f9kAWFdqx2mvDMHW?=
 =?us-ascii?Q?+xoukH3sjV1vU5HynkWPpzf07lJGIwV7NKWUY2N5zwjZLtaos6S68FJoBLZv?=
 =?us-ascii?Q?9kBDbpN7ev8F7KMsNMN2bddBDnML03CmXIukCp8LS3UP6aYyPL6ziqu8B7LI?=
 =?us-ascii?Q?3M32F4dBguZ6M1614cO4NrdxmPmIIGZiw/9L7jgrbA6/pOV1J8LZRlW5JaCA?=
 =?us-ascii?Q?J9NeCnGGL8zcqIMgv3uuO0+hjnL1mO1n/kNW8bCgNn6fDwL+iW9Uhfxi7Hqq?=
 =?us-ascii?Q?O8WqMo1rxXwjUU6TZU+AOHsijJfdH0sHge/I/Cp/z8BqnQUdHIf2vp1zEd7c?=
 =?us-ascii?Q?6r2/F+vWoLdZsYn9NQu4UcFHOkFKA8HcKAMMqOh2MSK7Pyk/BMd02NGOE9Lq?=
 =?us-ascii?Q?zjgc8LvoXjTIR/B2LSMDN/kZXA9hxErytauguc4DHSWG3NAaJDltYcCi/Q1f?=
 =?us-ascii?Q?IxdbX3v72tggjb+1pQLLpATuwLOC6XOLriXRVk5WvyhEUMdeOEgXFHyTMXxz?=
 =?us-ascii?Q?9skhsu3tRl0/cidFydYpbooqzYsNRJdAXNOR2DbT9m0xgjlIDYosRt+NEE7W?=
 =?us-ascii?Q?N4j4EOj2j0jnKiWQDaKxi9TEYGWu4ZlGzZTHAckmtjuz4Ewob+CQ6a9ktg9q?=
 =?us-ascii?Q?azbSCSGvEZxUrVSex2cpNIzWqPZUBsqPrQIYbegjIY1Qev6fsPonJWsqHJgO?=
 =?us-ascii?Q?DJBuQFH1wLnXeqHFHyheRDOdtvmwfth9IVkrrPk05ji1HhJaDRFTbkp0c6wb?=
 =?us-ascii?Q?Tlo7LYhwsffesfW8MsjCyYNdke2oYyRlBNd1km7ubIld2eOWX6X/hW+HXVIE?=
 =?us-ascii?Q?+81DWbi8QvHke/yk7pQfWZPQzs1kvE3gPURmy3W+VtBtgxckIh1sgnvUwVp4?=
 =?us-ascii?Q?9Kl69kGq+Enb4NMgVjGM0XeMmTGyvqxMUP8bogAvub/0uMBXtCi21y0dayp7?=
 =?us-ascii?Q?dRbVMuctwg43h6IjKgHk7v4s3BwTIrslTIZvi69Z?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a29003e-5909-4bcd-5228-08db2c3992f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 07:29:59.2857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /chDDGduPBKIHydtgz71n++fH9YIIHUUusg1au5cBLu2WQjycNyFszHBX9n0yhiPlbhj2vNoVgWM3OsdVYyVEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4892
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, March 22, 2023 3:53 AM
>=20
> -	/*
> -	 * If device joined an existing group which has been claimed, don't
> -	 * attach the default domain.
> -	 */
> -	if (group->default_domain && !group->owner) {
> +	if (group->domain) {
>  		ret =3D iommu_group_do_dma_first_attach(group, dev);

emm this duplicates with the attach in iommu_group_add_device().

It sounds cleaner to remove it from iommu_group_add_device() and just
do attach consistently in bus_iommu_probe() and iommu_probe_device().
