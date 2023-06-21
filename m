Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5051FA9
	for <iommu@lists.linux.dev>; Wed, 21 Jun 2023 05:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687323699; x=1718859699;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=88I1aff8rm0C4A36ppU6u3EUaAlhcBWWmSPUxeNIX3I=;
  b=OKzRe+FQVkMltfADGSpQeHdaoSlkLMPD1RgyAiGtpIoVgDxHkY1wrAPS
   sV3mOo05NppxUV12tXt4eqg/EecVuOxcpoeOUm4lDQJn2SdP40EsLmI8t
   vaDtFomzExTylgRH6T81XYnKVBLpR0O3XIcejyMRQ0GwXombN4jZvbdfd
   PrEK5zupMxzbO0qomC7LrE2k9G71h3UU5B9VtvCy8oA+bLHiH0n7gx8/D
   aZJoPcKSWp2tDK5IJuwHMucqYGdXk8j1VRJzT2IaKH5IzxMJrMega1ic7
   7btpT57RiE5bHzZm047vA8egP9CyK87DUZ+5dNQU7ABHBuf6PiaDNz8SF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="360078891"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="360078891"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 22:01:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="779704945"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="779704945"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jun 2023 22:01:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 22:01:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 22:01:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 20 Jun 2023 22:01:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 20 Jun 2023 22:01:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAR7sHVB8JhdWhyXmBvN4/FH+SfHvYMlAiTRaxq1Q0gVFRJwK/q88Qyloix4gM4FiQg3tr9Hrjt3kNKhhaoAkAkbETxoRXHg5F5WAhkuUTkNwykwkkoe+PzJs1j5Nu6HcLflme3I5BuNvEwrSBaE/y4zpwy62gskw70f7jHspC5R2wtk170X/c4gbEdmJXrLBoNBq3zu6IWSjAskZorhsLifPB7jEGe3lcK8UNBf6OmmKSbsBwODJgb4+BRt/0y/hRc5M4XGwCvfo2twdzdATZ3tw3hlJ+RBHT/Qc8bOOiB/eKe1NbRKP8wVSl3S4FmtwyYeg2rT1xdJ5ZhWcjlsyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0/9QOtShSOZgJ66dZ0P4bTwRNFAXvVlMN7etll51Ds=;
 b=nXMFYVOmngv0257mX1B0u/JS0kX+FwoYKHh1+coz8RsdbanZp9ncm1ZMbiamJOvfXPgOZhGzDXM6GI59dpvS754BeCGMqvtlo7QB20dh4RBG3cPQM6lJzhhpDwZkUwDbkVnWBsCgRaa4HFxtH6lUHT+Z062qjWMgZ2gw9XG5VacWe7ZcaXGr70SAw/uIYSmENJLl8T+73Jx7pg3nskO+O5t/7ecaXyWCJmmFrBCeuxnuwYCTgnxd6HN4q6GBGpNEn1Na+f31UGYBMY8oLWNIGbRB+mFC1kN1fLaN/+KaFRRL/jFu34ML8OSeW0tuMQS2AGz0KWTQlPqMFswbFSo5og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB7308.namprd11.prod.outlook.com (2603:10b6:208:436::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 05:01:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 05:01:29 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Lixiao Yang <lixiao.yang@intel.com>, Matthew Rosato
	<mjrosato@linux.ibm.com>, Nicolin Chen <nicolinc@nvidia.com>,
	"syzbot+1ad12d16afca0e7d2dde@syzkaller.appspotmail.com"
	<syzbot+1ad12d16afca0e7d2dde@syzkaller.appspotmail.com>,
	"syzbot+6c8d756f238a75fc3eb8@syzkaller.appspotmail.com"
	<syzbot+6c8d756f238a75fc3eb8@syzkaller.appspotmail.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
Subject: RE: [PATCH rc v2 1/2] iommufd: Do not access the area pointer after
 unlocking
Thread-Topic: [PATCH rc v2 1/2] iommufd: Do not access the area pointer after
 unlocking
Thread-Index: AQHZo4EiQjWbqEjPrkiPmAw19pPoza+UsZrQ
Date: Wed, 21 Jun 2023 05:01:28 +0000
Message-ID: <BN9PR11MB527648F55F4F36A24B50E6778C5DA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-9a03761d445d+54-iommufd_syz2_jgg@nvidia.com>
 <1-v2-9a03761d445d+54-iommufd_syz2_jgg@nvidia.com>
In-Reply-To: <1-v2-9a03761d445d+54-iommufd_syz2_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB7308:EE_
x-ms-office365-filtering-correlation-id: 70ec9526-b0c4-458e-1dbc-08db721492d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jLseo7WnhhH6fecTHKiMyuZ8ab3vQ3SWUm86b9rWKJbU5whlFttxCdtkFpoTuKE0PYwEkSoXPySyVLB9Qi9wBd5ckFzOg5ayh8JIpDKa3DxodX5F6nFEGhrFLlLDGJaPyPAKdcFqygdTF6ipI2W5f1okjd855jY1kjNV0+iPnzon0f6gAbpp4qXW33YVPmf/FTfCn/NllvNbCwXG0Cy9vL6XFCfkLRs3YLW4S3TuG/hmqQ6othpboUVD5EAL8AcV5sIWMdojexyDBH61mHsqfCJABUWPV5Zo6JQMsInUz0jTgsso2ra2bBRuLbLdk56F4+3Nt92FQr6W9FOkcrPUG/0Ty0QJTzEN6v9ptkCTzBzvR1fIo1BIRwJWhJ9683vR/S2tAVcIgyaWXy0vxj7m5V8GcJJOy4nbAX3XHbtMyJC4tID3C08Wdek3hpgmwNjyirz3PiEdceivO1Ox80BoXoElpBJqbucXGd8lwkzsXsgxCi8nGeD1Vt0bQzRS0bSQYxU99D5INPePlNtxIPX4NkuEB11dmcaaEWKzhiwPpK4eh4/4k3nZMVDTw3FNE5PxMRBbn6HYoEXr/boY9FYC/INYO1ccBraucnlqnKfealtxFY68edM4R3Uclw7BfPpB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199021)(33656002)(52536014)(5660300002)(8676002)(41300700001)(86362001)(8936002)(66476007)(64756008)(38070700005)(66556008)(76116006)(38100700002)(66446008)(122000001)(4326008)(316002)(82960400001)(55016003)(66946007)(107886003)(6506007)(26005)(186003)(2906002)(9686003)(478600001)(83380400001)(110136005)(71200400001)(7696005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TDfsr5MtrqW0zBQx0YMx2s9LY1fW9VJ1LU3Eadf4GNXXdQvZ2BsQ2yLbatf5?=
 =?us-ascii?Q?O2fyWSh+ltgF7omY4oyai/pEOgjGIkzgfVosCjbRJFX2wBzC2Yuyrme8bbPf?=
 =?us-ascii?Q?Xx8rgANy1+2+6YX7+skFDInwJp6fStBqLUyc8nQe6QzHD2V8bUosW8ohRqGu?=
 =?us-ascii?Q?5hH91ibBDaNkBeL8OVMxctEe5Sb1fPiMgOlOFzJgyILKtgECCzKdjJQSLxYm?=
 =?us-ascii?Q?5rufrC4kh/Qs/NJodCrAvuMLsgjXMXUKnPHfdH0azF6CHQ2V2FhGIXnoKNzF?=
 =?us-ascii?Q?pUeRCqlv5XTwKrAwZZ+AF1YWLIaZrPUryRtpxm1j0xk68yyjn8tpBSFYmfUw?=
 =?us-ascii?Q?fdUV5s70iot7VgfRa3NLvWl7x0zTBy3TXKZGeJ1xQOPxN6nj9LHpgmgLL9b3?=
 =?us-ascii?Q?CYHzKzj9m3r+wk2GSyoq9bgpksE9gOHOvh8K8IKqmh8He2mlwG+wHwoRY5Dn?=
 =?us-ascii?Q?svTxhvu+6Ut/eVtDSoLJ165aCOo0up5jfYL3RtSNRthU+yQwV/nSRsN1uocH?=
 =?us-ascii?Q?mMObiUZzeU8kVZuU1tIBgnrakmamaLd1njvuDUgpvG61i8O8jx8WeEUyuYVC?=
 =?us-ascii?Q?BOIE3xbvWCHwuML4wryzyPEukcVLj5zlnRcHh+jCZW+WfSiddgv+PHf9h1B/?=
 =?us-ascii?Q?XRrKRXIqdjNqCDiH/+h9mkvCE+C5fEYw8q/gDaoAnlo2BQ75eE8+5oFLfFSr?=
 =?us-ascii?Q?vAx3rlUtecRYmwgGkaZnGtf1qxkzEeCC8GHKKGA5pUepSW38fCGDjQAYfRRO?=
 =?us-ascii?Q?ovhBkwDLm/bUMvGywzA2IcjUNZtA1xr1qaYZFQpAk2VoaHhnpmc63mQEnLu/?=
 =?us-ascii?Q?hVmpmKUOyvhIevUDZnpCgeBhZNwbdY2vM3oV1GYWxFKLnVS3gtQgQ5cukiUF?=
 =?us-ascii?Q?WVMSz5yRPrj1W3jgivMIEZnXTyVgzHq/WFdcRIikKxOrt+b45ogrUJz53SfO?=
 =?us-ascii?Q?B7YJMUDI3fiewNqZFLqYfr79FdYDAv+66f65UVq9gATrVl2F1bNozCNLDUCg?=
 =?us-ascii?Q?ViNRCirJ8EbZI3qtvStKpB54yrf2oxejdMLlmq3WOPLsbL/7vswxtTrnTfhp?=
 =?us-ascii?Q?y/wu9AKbDtdx5oD8tzQW9In9IKqcKO2Mlexh545HHG3bBx4TBaFqQ2BWKYVP?=
 =?us-ascii?Q?4F9ykUMVB8ms3fRDIZx96EEySekBGw23Lk178Q3uLexwNu3mBO7Xdt11pVd9?=
 =?us-ascii?Q?xXZK5n6atia9gDe76bzduJ5KvcqESDKYjuS5zx2fXY9FzfjsNMqiWeVy9N4c?=
 =?us-ascii?Q?Gb4nSswtaR+s4kkW7lw0FoUylNgTD4clXPeSfrEVVwXlZuY0qtWJR8VM0fmT?=
 =?us-ascii?Q?+ml0zp4qdMRGyJMgFd9U3ebiJlhgObCs2coLrOxqJN/z0oJuGQkCZYCi2jw4?=
 =?us-ascii?Q?vsfs6SrG+wVi9Q7nqSmQfR5Yz7/MYWTHvOvuqAHaZKQ+F8dnlbjHu1JkMTyB?=
 =?us-ascii?Q?KQDhnIwfQH9drS4K2Kc/plgkWfbqVCkTT8Pvdakvw2MXZixhxuWhd4pcQQBD?=
 =?us-ascii?Q?SbKTG/0VYdD2nde+7vR4z03ssUIWfjH28DQ2mu4wkmRqIcR4AxIdVJlIpb7R?=
 =?us-ascii?Q?Q9uEr1grjfWEb5K+mCWe9tIhnoFJdyfCnBsXMVd6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ec9526-b0c4-458e-1dbc-08db721492d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 05:01:29.1438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4vzVWXGiPwz0etSAF2mKIknNEun+DjagTUEKdMbg98JdIxobZy8G6mXD0rraPDYZRkZRLN2EAXYssrYmT5jr3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7308
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, June 20, 2023 10:11 PM
>=20
> @@ -484,19 +485,26 @@ static int iopt_unmap_iova_range(struct
> io_pagetable *iopt, unsigned long start,
>  			goto out_unlock_iova;
>  		}
>=20
> +		if (area_first !=3D start)
> +			tries =3D 0;
> +
>  		/*
>  		 * num_accesses writers must hold the iova_rwsem too, so
> we can
>  		 * safely read it under the write side of the iovam_rwsem
>  		 * without the pages->mutex.
>  		 */
>  		if (area->num_accesses) {
> +			size_t length =3D iopt_area_length(area);
> +
>  			start =3D area_first;
>  			area->prevent_access =3D true;
>  			up_write(&iopt->iova_rwsem);
>  			up_read(&iopt->domains_rwsem);
> -			iommufd_access_notify_unmap(iopt, area_first,
> -						    iopt_area_length(area));
> -			if (WARN_ON(READ_ONCE(area->num_accesses)))
> +
> +			iommufd_access_notify_unmap(iopt, area_first,
> length);
> +			/* Something is not responding to unmap requests.
> */
> +			tries++;

At this point what about a concurrent thread triggering freeing of the
area pointer and then adding a new area at the exactly same offset
and the new area is also attached by an access?

If it's allowed and repeatedly occurred, then the counter may overflow
too given the new 'area_first' is equal to 'start' in that theoretical case=
...

> +			if (WARN_ON(tries > 100))
>  				return -EDEADLOCK;
>  			goto again;
>  		}
> --
> 2.40.1

