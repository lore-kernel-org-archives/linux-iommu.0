Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F626EB4C
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716535330; cv=fail; b=bw7i5kqKdEWsJnMX0sIRaXCiDVNeGI9EHeDSornKuWg6dXi/iK2Vn1HOABVX/9ImDx9zlHO7jSc9doKw+NbaTw03h1jIUoH8jHyEQYGDWMj+7E5c8JLBVYdU3GbuTplHcYWYB75/VPj0MHJgR64mFGd4z5HeI9W88e97EmDwDuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716535330; c=relaxed/simple;
	bh=OIYkG/DOolJNzXxhKpYVlrWeXBpjev8rpP1MzbKip6g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lr9lybgA/ARZBFcjA+gGod1RDmmLluLepCm5e+Fut134uPqJE45TGjgGwXURBYDalx776xllMVEk/t44QFIQ14ion5DJEypWOslwzmyKWjZ5aeviNj9JI3MYD8TiN8P3UuuICMRGUsPF1PiTyufHIuqFlBdDmS2Esybg9NVi5kE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f86izjtT; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f86izjtT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716535329; x=1748071329;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OIYkG/DOolJNzXxhKpYVlrWeXBpjev8rpP1MzbKip6g=;
  b=f86izjtT1OjW4hvkf6D9Yn4DNrouxRAIwe9bhBu89iJf1qoYTlHeY+7b
   2Mz4bEuckKAS/dDlHeaLtnu/mMWXZzq/OOY3vmo8DvHfJudWCTNuLcOC2
   84J1IN82kdJgF+tmwLpFm1bGSSD3CB7hv3Spp+uT/HeqqnuxwEUodPknM
   FiOO1GN2QJdNps43443pMzZAPGrWO8yatOcCYYDPM2zCFcQLhIbFbZ5ke
   gTA9BmgvKD2tJuN+6RAZ4By0euZpSGfqAxbf7PDH4dPJkUx5ebLRLUlJp
   zRLTvynot1RTSsEllTHf9GTa4nAkX4KL4fUwdm0NgzmgLOiSpM/q4mJZo
   w==;
X-CSE-ConnectionGUID: lg1PNeN5RpS/XLF4msKkeg==
X-CSE-MsgGUID: DeJ8usQbRFuc1Z2OqNgUnw==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="24309537"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="24309537"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 00:22:08 -0700
X-CSE-ConnectionGUID: TjL0SlzSR5aqG9OuTak/pg==
X-CSE-MsgGUID: vm7hMdugTPi1bS5vksHtKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="57169173"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 May 2024 00:22:08 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 May 2024 00:22:07 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 May 2024 00:22:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 24 May 2024 00:22:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 May 2024 00:22:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YebkI7EHBtJaY4WbvA+zQjBkYl34/xAI69F0jC81p/oZ56YbJJjjzJfYZFKYNMr0Ucfe0r6GIYc6zcQSm9B67ETR1zoy6VGAJJHFRMb5u0HcoyxX6H6bBFZXZ6DAWrsUJnj+W1FJsBK31EZxQD+nZ+e0GmmSISkwr1emHBliNWuan3DP7xhtsMSv9C8kCDoumI4c2aZHqNJLej+jagYC4WK6xSGS91DB8CRKktAUm9iz/eSnTZAvR9lIBerZ5Epuy0itjMTOUVPS/AO2ToskeMOosVIYWWHwBfJhn0nkWkLP9W/e+ihQ90he9BAxv8MxEG0I442FZR/UI7OM36cW8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5WIM4yHelg9pu+dBY3lZsdaUqBRJ6cRoYjzVqSFs5w=;
 b=CSDt/oXEm+FxTZE5qReq0BlJxtsFGsZv6TsTq2zWQ8uHyUkb5W+epK23jj5Esp6FEYC4OjosrJG4mXv1+uGOd45meHE8oazbQA5/PDqt/1cz9J8fshNMUXFiLVZNNJTmw/s4c8rMNG45x8+dbMrOaHYzrQacbvxaqJyza63jtkkOADMKozYH9NP8PJpYP0CtO5jNk+Oa5tU2Q+Ye6zaXISVk5UUgmXDSesz/meCRFZV3laRxOE1/8QKoYETF8H4OgjCnWVsRWRNteYcdbtpIQtI7NBAoHmVA6Pz4WvQokDmAknluJxH4okObYmNImpDWYP62TU+0yu/MOC600JberQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN6PR11MB8244.namprd11.prod.outlook.com (2603:10b6:208:470::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Fri, 24 May
 2024 07:21:59 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 07:21:59 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>, "Dhaval.Giani@amd.com"
	<Dhaval.Giani@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH RFCv1 07/14] iommufd: Add viommu set/unset_dev_id ops
Thread-Topic: [PATCH RFCv1 07/14] iommufd: Add viommu set/unset_dev_id ops
Thread-Index: AQHajVVq/X0HjqCDvU+a/LkdwhCQ/LGT28sAgADojoCAAk6vgIAAqT2AgAqBYwCAAlS+oIAAlxIAgAC8r8CAABODgIAAIBrQgAAKLoCAABVEkA==
Date: Fri, 24 May 2024 07:21:59 +0000
Message-ID: <BN9PR11MB52765A6F6044EEF52F74230C8CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <ZkDWXnPW7CaX5TtA@nvidia.com> <ZkGZc5dvLigXcWib@nvidia.com>
 <ZkOI8ztR1mUMJ8oe@nvidia.com> <ZkQW6/OAQ8MzN6Go@nvidia.com>
 <20240521182448.GN20229@nvidia.com>
 <BN9PR11MB5276EEC2A1DDA9C92F96737C8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240523150120.GO20229@nvidia.com>
 <BN9PR11MB5276A896D215E1FA61DECDC38CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlAI5d6ktg7yncLE@nvidia.com>
 <BN9PR11MB5276422CE4B77D262CD292208CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlAsXatxsopbz738@nvidia.com>
In-Reply-To: <ZlAsXatxsopbz738@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN6PR11MB8244:EE_
x-ms-office365-filtering-correlation-id: 6aef91ee-3add-4f99-946e-08dc7bc23357
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?ovE5+xXKmZ8/eVGuHA1Wf10MtYK6hZB5k4DgLdvIOorAtuAGYbKw+02HJ1kZ?=
 =?us-ascii?Q?2PbiIeSvNHS+wHYD06UYq5/syb79En0nOwHAL66rQhK84qiGjCwBT//V32it?=
 =?us-ascii?Q?CBybb9tQCbJ182XucL+lN8aplzb2GSJl2eDLMaDIGufDb8mGifguWPnKqwWm?=
 =?us-ascii?Q?WJSP2/+xjmheJPZjyHcxNuU0F4FB8MowsCztgr8hiseQc24mwN0Zq8MOVepN?=
 =?us-ascii?Q?aorGJjHM+QGK3ac5e8IaforIG1PNZwKU6DZKR7H5EQPo6Fz/Jaqb5WSVQ5gK?=
 =?us-ascii?Q?3UPlIjjUpHGia9NBiqDZH2pyl4o0eNZCCBzhBJEDe4nrvxRuDOUeaiNSAUvX?=
 =?us-ascii?Q?ul9rEIFuKYK8LmW2wiAV/SQA1RJfI8F1km5tDtF1a9Yr2ykaZ2eUqMX8kunG?=
 =?us-ascii?Q?NLH+z8KNthJe7Hpq3Vktt6oqOcj5Qi0TCpiL6eAlxBCiSp9ceDDJzU+XNYx5?=
 =?us-ascii?Q?sVUm+4YuiOjAEZF9ID8EBCEGg8AXwpY2nZ5a16dumcvRH8PPqQ27ybUgYOdM?=
 =?us-ascii?Q?0ovGUsp65ILr7rJsOgfLzTgCgQ4ZQGl141thdGSBf13oH09R5HpryMgPztSB?=
 =?us-ascii?Q?G1B3npxOjxOT2l1N47XvtEAsJFO9RW30adGKczCPO9FWMrgKx8p+LLoIZdLr?=
 =?us-ascii?Q?04h1ZvQyTtADb/8TBU85TFW20L0u2UWSjPNJ3ws6vbhBuNzSY8TcIAedKirl?=
 =?us-ascii?Q?g/1BH659XOwKVk7RrfjfCk/q3biIyhcautc+5tMdRSk1Pc24awGaZXYAyFTO?=
 =?us-ascii?Q?2Fd3CI2FF0tsMR3nU1g7+XIovoxYSXHC+0dqabDe/u3XbjsEA3+vwfK4H9kh?=
 =?us-ascii?Q?qCIMVZiG1L5e7CBw2rPjLSH6naATSLmc/N4dh5GcP8SVLVcg85QUr0x+OczY?=
 =?us-ascii?Q?lwB5hFkTSPGXCB2bRFOT7ET7w73kMGaeA4iGc4ky1bS3AIBTgxUu7aWRX6wC?=
 =?us-ascii?Q?Ark87Zip9LtoiM4z1jIuSduPgFdB8FWu+aToyWWqDdirGT/WgOvcGIES7myZ?=
 =?us-ascii?Q?e4mUSivHcaUNK/zh82n8zC6qKfuducHz0nU/hWNHigHRnukhZFhoWTz48GJg?=
 =?us-ascii?Q?05AgN9BIKE+h/DwUWllPiAqpGoZ7sC/eZuuCZddebaUGV44JkxP8Kgd/UbOf?=
 =?us-ascii?Q?O7xWduPSfS+sPVx7GRAt+lFH/26QXs3pu1DsCtFw9HUyMzIxB2Ri7A0vpnUP?=
 =?us-ascii?Q?h4nEoRhRRO6ejk2S1DoymiVGslmrR8pqjY5zrzoHWlZobnlG4Bo6nPLwxgqq?=
 =?us-ascii?Q?6Pu/kUtflFqOYav++6fLHOJwox7JPpR7iCBWo4aTThFZ4mx9uu6QNtHFPNZh?=
 =?us-ascii?Q?RuuchQULfmRdt3YMILiaCmn94vEzfLo60+/4MR5fkm6Stw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yo56DjWewzU/bKAj9vieKzp7UVsNETRXXg4yHjzP9r3IrwNaoZEXYDiYLUkd?=
 =?us-ascii?Q?H3+JH02pmKtyliaCGOOeBnS3o7S8YB6SeFxZHc6dK+J2rhyE+hs7g8NoEJ1e?=
 =?us-ascii?Q?cFqcwV7DZ8znFPDvreXzgtCUgU7L9IqRaRRtDhvN++YpMx4p2ElU358XJO4U?=
 =?us-ascii?Q?PTnzDkn+FzSKKBdHiY6hGRBGhngRJLEEs6Kbr7N/cNEef6dMEH/bmQSVhsWx?=
 =?us-ascii?Q?nYNYWP6KMr7eYUKxWFC3Cz2/sRKMcuACuk8QRlUesRFiiYbN/MmSUJXRU9YP?=
 =?us-ascii?Q?L4GvhgMBThojTRC4bxL08YhV/iHhKpE6mKnNDu8MTC41VlMFSIGnAWZVM/QX?=
 =?us-ascii?Q?ZYMYjkQ8A9n8B1kR2XS+aH/Cs4y+HJko+YKyRlwfO2oong/e+TUCVCuJQoGr?=
 =?us-ascii?Q?g5yrZEN3NfJhdf9Q+915NeGpS4OTJmE9fywQuH3O7cxWNoGnL0hd953cYVkN?=
 =?us-ascii?Q?eHO1cMN4fHI/1JXAHde8CeYzSTXtBNDjzoDoa8KJBvxqHpse6V5VA8OBER2U?=
 =?us-ascii?Q?GOqczEuDIyg9v7ShRxjZ+zLUb6NAoRsKD1eIe9S7wMem3E/yYeFXOSsHaVuF?=
 =?us-ascii?Q?dlaWUxYeGjjchfD5sqyZZ04DZAgDP9Y/Za/+vo8BV3wEU2RJg8AhRZXf5QuY?=
 =?us-ascii?Q?Kx4BxkwCoByzMKeNpXZQNMJ3Hj2H/h6HSMoa4hXBoUixJtFNIS9Ros9ijgGW?=
 =?us-ascii?Q?ZdbrwQkn9ZJhTItgj6SIpMkiV7u68iPkFhizMXABEKTqcNqGCWmaUvqWZpMn?=
 =?us-ascii?Q?oTc+uxu1nF5iJxBmshkOUCISVLWhHKW91ojEYsvYUwPAH0YcyrZW2cRgz7/G?=
 =?us-ascii?Q?VAsD+t0G/k2XXLfPMbK1N3KKpDJVNMrLXSJl3WUZxsJZiS2simrhN9Ubfit9?=
 =?us-ascii?Q?0I8vheqNwA8vmdc5bsQNgpaNvVrmBxexEdxgs8i7YHDla0i+Vf8CZ49pRbci?=
 =?us-ascii?Q?3jqTR1rqdxApqvD/VAfrkwaiuu4zXht4ocMvRe7YL2j7wLfYoNzYofLeUlwx?=
 =?us-ascii?Q?MHFM8Mat1qHfY5+fet8iCcmsHLvxC/UhZ1e8NsKnQwnpao3Cc+m3tujPPzkz?=
 =?us-ascii?Q?mIZqCluWBJFFaKqsVs9WojI2xkwe442ot6/Kf31C3At+Pk2h/l+ZUlzNz2MS?=
 =?us-ascii?Q?wxYbeUqwgM0npFZizF5s0J/MZP//dIjHRfVkDnhgfGKwy07mxF7IJCGZ0ML2?=
 =?us-ascii?Q?LQ2dnD9xP0/cXQqiTEBYYwYXO8IWh9KKW7N5igceStNWk08ufKd4Z+qaY6Ce?=
 =?us-ascii?Q?9Ldds3LDbqmTXEDHZ+R9K2NLBvwoZEUCBjNT3AMm1s/kD+qVX2ZPYYUJTB0U?=
 =?us-ascii?Q?Rvyb7YK5eqxVAfHfIgdRWYopbeVU+N0WCpXK28K22I8AdTOzB2FLQj5VUm40?=
 =?us-ascii?Q?B4WSZHFWZGIhRAsN9a+a+WU2OF+x2ezOKuaM7oBKry/RctFW+MeFiUgWybqD?=
 =?us-ascii?Q?SqA799M+wosDenGnc9ao1AydUwewttBN2CTcFir3xjXNpR5KLDGyT2/RVDEy?=
 =?us-ascii?Q?9DSt9cFrwyWSRwtMjC8ZPXv8po6JBdJX1TjWU3wNypuuB5wBpQQH2s3E0oWo?=
 =?us-ascii?Q?oP/Tq74qEjoUXc2pEfaMKT290E46lhqHCfa/2x/+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aef91ee-3add-4f99-946e-08dc7bc23357
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 07:21:59.4404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5S602G2wqxHSuRgwY3mGcZ1F5vFgOiP49ZnNE8C1O3fqHRxXD++4c6Q3sVP1kR21rViYPfS8bkPzArpUJPPECg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8244
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, May 24, 2024 1:58 PM
>=20
> On Fri, May 24, 2024 at 05:24:11AM +0000, Tian, Kevin wrote:
> > > > > > > On Tue, May 14, 2024 at 06:59:07PM -0700, Nicolin Chen wrote:
> > > > > > > > So, you want a proxy S1 domain for a device to attach, in c=
ase
> > > > > > > > of a stage-2 only setup, because an S2 domain will no longe=
r has
> > > > > > > > a VMID, since it's shared among viommus. In the SMMU driver
> case,
> > > > > > > > an arm_smmu_domain won't have an smmu pointer, so a device
> > > can't
> > > > > > > > attach to an S2 domain but always an nested S1 domain, righ=
t?
> > > > > > >
> > > > > > > That seems like a simple solution to the VMID lifetime, but i=
t
> means
> > > > > > > the kernel has to decode more types of vSTE.
>=20
> > > And the narrative at the top was trying to describe the links:
> > >   [ device ] =3D> [ proxy identity S1 ] =3D> [ viommu [ shared S2 ] ]
> > > v.s.
> > >   [ device ] =3D> [ non-shareable S2 ]
> > >
> > > So the first case can take advantage of VIOMMU_INVALIDATE v.s.
> > > the second case requires a DEV_INVALIDATE.
> >
> > and one side-effect in the first case is to save one VMID for
> > non-shareable S2 hence improves iotlb efficiency.
>=20
> Hmm, how is that?
>=20
> VMID is currently stored in an S2 domain, actually. The viommu
> is a VMID holder to potentially decouple VMID from S2 domain,
> because VMID is per SMMU instance while S2 domain is shareable:
>    [ dev0 ] =3D> [ S1 dom0 ] =3D> [ viommu0 (VMID0) [ shared S2 ] ]
>    [ dev1 ] =3D> [ S1 dom1 ] =3D> [ viommu1 (VMID1) [ shared S2 ] ]

My point was based on Jason's example about 3 VMIDs:

   hwpt_alloc(deva, nesting_parent=3Dtrue) =3D shared_s2
   viommu_alloc(deva, shared_s2) =3D viommu1
   viommu_alloc(devb, shared_s2) =3D viommu2
   hwpt_alloc(deva, viommu1, vste) =3D deva_vste
   hwpt_alloc(devb, viommu2, vste) =3D devb_vste
   attach(deva, deva_vste)
   attach(devb, devb_vste)
   attach(devc, shared_s2)

for devc it could be:
   hwpt_alloc(deva, viommu1, vproxy_s1) =3D devc_proxys1
   attach(devc, devc_proxys1)

then devc will reuse VMID of viommu1 and we save one VMID.

Does that not work so we need create another viommu to hold the
proxy identity s1 then still need a 3rd VMID?
