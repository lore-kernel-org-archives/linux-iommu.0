Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCBBD52B
	for <iommu@lists.linux.dev>; Fri, 20 Oct 2023 07:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2ZsZ3Ig"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697788667; x=1729324667;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vI1Qj+JANlQ4UsCO1pH45mMgflGagOWGrtgxoC1xskA=;
  b=g2ZsZ3Ig7+NQQSBxwbVwKSrx9ShaaY1+zXJ+BvKsK+YXqGnjLvk6dzoT
   JWZ4r0vtl8Z5ZzeM90Jy+oJU+/rCa86v6XwQ66y2lk4pJT+H4n04n16rK
   PDOVYVUStj5CipoTBZevTS9cpUuAIBLs7+kHJaqAOgcYQrW9I44POiDXS
   zWe1tPhdKU2G8NTFvI30GRCnreassqwfAtRndvYvW0cQEPfVJHMM6OdMd
   cCQSUK1iNq0bwodLH3Zuv480HW4258ATs5Swa6LlpkvqDFkE5JgQluqkH
   fN0C5vNfYmww6rLa1ciXYkVgoiQjQFz+29LbIjqYCj9p65xCqifzczMPr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="5059484"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="5059484"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 00:57:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="1004524015"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="1004524015"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 00:57:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 00:57:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 00:57:42 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 00:57:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8SG2Ws3KmesrJKsExdpf97EBvqDlt/GOsnrS4i3AdTP+ew3re1ObnbZa0n+Zz/LMuaCNgMlf2oqAiT5fmazm2jxH6+iKGwoBr0ToB84Fx1qHLcsYviNIjP3P6m1ice3Nh2A5+zWbAHAKaBgS5ps6M29N4Sfr8poi+sS4IBBrK9jGtNPriNxXcTK9FLby9RuAWve6PnDBt1FOcTum58nhqNScChLXtIgxtwpESx7TXVXillH63DjXVF64Dyw6jVZmdpGc3fzuAT4zH4wbDn1nfhphYjlEZmWFxWR1/hQGMoKVE59FDQ1jR/kT5hPEeWJmsKRMjJMh3zsXxNzAKF8Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vI1Qj+JANlQ4UsCO1pH45mMgflGagOWGrtgxoC1xskA=;
 b=DHCD77qgyHivT3zhmk0AOG2hJFWxHC9mxgnnsdTXuRlSDQ4fdCtHJYB7AyKKOB+NYaLZn7OiBl/VBtyKpud8uLjwvbZEN/XcpdYzHtuOrq2TjrPMTZgmAqRtyQrNBDecmKo0pKEFnz68rBvKZzkz7Ra+lofJTToiaRgLuFSbmh+O5JxEx5TAxeEwcYL6tJleIWyUYeAT3ZoR51ctLRe6+LJ9w6McT55UWnsETA15wz+H1deMZT4+Ji1mjfcwHTeXAUBzE5xjkkyDAvA0AiscmpX3Ktf4hZgGsNCOW3bW3rzLp6NNym1mCub9C/RycFLincEcmlykW51LNs1QbqjpAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL1PR11MB5285.namprd11.prod.outlook.com (2603:10b6:208:309::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 07:57:39 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4%3]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 07:57:39 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Martins, Joao" <joao.m.martins@oracle.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@nvidia.com>, Shameerali Kolothum Thodi
	<shameerali.kolothum.thodi@huawei.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Nicolin
 Chen" <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Martins, Joao"
	<joao.m.martins@oracle.com>
Subject: RE: [PATCH v4 13/18] iommufd/selftest: Expand mock_domain with
 dev_flags
Thread-Topic: [PATCH v4 13/18] iommufd/selftest: Expand mock_domain with
 dev_flags
Thread-Index: AQHaAgG8GAKvCeGJMkmnZxUnAXCJQ7BSUhMg
Date: Fri, 20 Oct 2023 07:57:39 +0000
Message-ID: <BN9PR11MB527664A3D067DCA92B1D07FA8CDBA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231018202715.69734-1-joao.m.martins@oracle.com>
 <20231018202715.69734-14-joao.m.martins@oracle.com>
In-Reply-To: <20231018202715.69734-14-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL1PR11MB5285:EE_
x-ms-office365-filtering-correlation-id: 1d3997f5-b141-464d-ac89-08dbd1423b06
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xkvxpgGkKCRsr96UUw76C/zyAOOUtk+iYI1j4HzTEDqY4NCswk1kcHAOdtYWl+0jn4W6qcZe3iaOcJHE3vxofgcV2EDz2PVIaRFMA2cEnEKafoz0fZGA/JRWaoLCKXFweOs1utHlg2I5mYoe4WNwOVicpdQ20xjO4KxGvCMn5al+NIR6T8OBZz01/XqPOsqlhZ2hIo8aGxTgJIy0VsJqZmS26U6LmNllNk2VGK9r8j1YnX9uArK9haAVEdv7nOGadjyCRCc97XvOnZbrVPUvp326LqAj4fRrBmxKZJVub4KWTUDQYpdTO6SqHRah1lBjG4pbQwDVnAHw5+Xdi6nVK4ybdZRbvoeYPoaPunGnos7P/ujz0PK/04XWdd73+yrM+Y988RVHrzJ4QwM1scp496J7hmu46YxKoDsgQQ9ti6IjYOEvL65TWx/Jl7sdOfasTzw/5fLgLqu7eW48lH4spP0ZKclIFujbnFf/+xGxR9KCMhryj7oQ7wO+3caSU68BrOLPpCXA000+7dEVE6l2dR+ASBRIds2GL0ByAxuoL4dYgt3025P29kSWxQbpPZTdwW42q3RXBD/8CrncaV0uS5x5d9d47Bgfy3EQQeZ8Vcj8Um85o0LgutCok1t30aF3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(136003)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(33656002)(38070700009)(55016003)(316002)(64756008)(66946007)(110136005)(66556008)(66476007)(76116006)(54906003)(66446008)(86362001)(38100700002)(82960400001)(122000001)(26005)(9686003)(71200400001)(6506007)(7696005)(2906002)(4744005)(478600001)(41300700001)(8936002)(5660300002)(7416002)(4326008)(8676002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?shSqJWG9GHlsQG1CfpHGqo0VvI6kr3rVtnIp0YyMsw8rqq5juqPImLcZP3Ua?=
 =?us-ascii?Q?CcFVzdSRYSXSZZqam3cqBzbRXBVIbUTw7Ua/82m2X2DlaX1BnyWb/DF+Tp12?=
 =?us-ascii?Q?Ev44uEjoJEXUvri0z+v5CKqT4azr2VpjmNV2FmtfJZX3TkePRR2NHisfrNBT?=
 =?us-ascii?Q?S6T9BH7yfg9vTrhLGBIohI3Bb/AUNwOZg0N4AgVXu0N+ww+KKO5fRaOlVlxt?=
 =?us-ascii?Q?9QweMyoOvapB/FzlmWO7ocIYNpPxpzSDUKbL8MmPAYjAvpJ3fA0emcVUWFPC?=
 =?us-ascii?Q?9Rw9LtMxTT2RJA7IC0EDPn4taXgXVICHFoXtWj2AoJQZoXtY2yle/6BjNX3J?=
 =?us-ascii?Q?mdeemMy9dNXv5Gr+XNRFrRWoHT/brTK7Fiqnb9bWDuV5uhBNIjQA5YPXe04d?=
 =?us-ascii?Q?F1t1czTYoAzkJ57VBBObvB3VsPNNR31juBWNwVLxsC3x1YDu9LrlOQzzcwK1?=
 =?us-ascii?Q?EADMNhbo7wau+5LBQX6LUdOld5lQKQEOYCacZMEFnoxOBlYu1bs6hhSWovRj?=
 =?us-ascii?Q?CpJiywlcp0pSL/1rOX4WnJLvjBiy50VwoQLtnlF3XwzIT1GjmJDVUfW1ni80?=
 =?us-ascii?Q?ujuQEK6bG49CrOpUMLcNIrg1WQjXozDc70CFmGkPrjwWh1RAv120EnOfUA+z?=
 =?us-ascii?Q?CHdN8S3mfESoqIHPE6W6MhRu++S81xjLpe38ho+BxN1H7C81uQO6HLVOmKU3?=
 =?us-ascii?Q?B4VjotH2MXmmfoIiRbYFRC+aTwoQqbKlWHt19rE0oupc14s8onDHXaKNbQWN?=
 =?us-ascii?Q?9bEfm4cHCx2q8mhx07Lj1oPI1WdXFR/Wj80O7ekxG6dJO/YCTFvTy73JbJBe?=
 =?us-ascii?Q?vP6k0+W7YvXvStnZL+wX45R0X9rqzIQo14iS8W8aDC5jTdXzIwjBerkIJXOQ?=
 =?us-ascii?Q?NYOZPJsjeEGOfOu23W35+nCS2BxPFMe1zLQigNKTBvF9vefbrC/PztxAwGmn?=
 =?us-ascii?Q?6atpaZrC7PLF1b5/kgrf9rnEcO603d1nLSw03y/x2V2cXJi9uPLXtUqauD9p?=
 =?us-ascii?Q?tCJbA28nYr+2/NP1+yzljWJjLYX6Z6b3yFs+jjUav+D5tdsVxUNBk4OQwQFW?=
 =?us-ascii?Q?UkxUtn1/kjXZRlSNT0HxG/97hlC4oZ6heo4tbCxMJkojNc7ifYmjNdRVkGCL?=
 =?us-ascii?Q?eonbnVixm29Q4bR51iXwx6A/Y/TeD0sd14L75luQTMZRqckLnDFp1NCOKVeX?=
 =?us-ascii?Q?KLi6OKlUM0L0BKDqPKq6vaSByVfPSg1BxrebLjWLd7sXTehNye63LaRqIO7j?=
 =?us-ascii?Q?6DAPWujqAj6fIQYgmgDdjp5ts4f1c2WrB2wllT75nZQluEG3NA3HHaxAYuFd?=
 =?us-ascii?Q?A9Gh2yAnyx7cs9ufJuuvKk/uIFot2SiM22gQ1qYMhEu5I4gO0HFH4mjt6a9z?=
 =?us-ascii?Q?uTFPPXfABajlblXY+ZDYxRODRHQQnsC2RF9muvg5nwtdLQjGSL4ztH6aqCWK?=
 =?us-ascii?Q?rtjZ6uK7qmMQJte3XF9n22A71WxUjpqDShY+b/XWzfW43ngr/atiOIBNMeBG?=
 =?us-ascii?Q?/6IEwYPpaKkQ/zGDKa3AweGAtG36NWYPbfeooU9TaZQM06sjLdo6hUmwjEQs?=
 =?us-ascii?Q?6dNjo9p1MFNJH3oXOKsFh2TPV4TCwOuoz2peYbi/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3997f5-b141-464d-ac89-08dbd1423b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 07:57:39.1319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QTELN69fp0qdppZsMK0U+Ex0iw8/7jnzy68sf7S996qT5uLYx8J0sx6XiTv5pE9bODWAn+kHUIbS8WcPcj0eaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5285
X-OriginatorOrg: intel.com

> From: Joao Martins <joao.m.martins@oracle.com>
> Sent: Thursday, October 19, 2023 4:27 AM
>=20
> Expand mock_domain test to be able to manipulate the device capabilities.
> This allows testing with mockdev without dirty tracking support advertise=
d
> and thus make sure enforce_dirty test does the expected.
>=20
> To avoid breaking IOMMUFD_TEST UABI replicate the mock_domain struct
> and
> thus add an input dev_flags at the end.
>=20
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
