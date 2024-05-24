Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E08749C
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 02:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716517292; cv=fail; b=sP5qEESSBu3rguQ64bbXGinANkdLkzJLClIYbzfdBmMfd81fjWsqC4QgygG9sNdqyC09F1cBAIF4quC7RrtUcIKffGRjvMbu+0oYHkAI9Aqn6aXF2jhHy5CMarj3DJl330KVBQMYISgbaVZFUcHH4bDbuxc34twdvMjuShGewlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716517292; c=relaxed/simple;
	bh=wmF8BoNQ1WOyWDDEk0x8LGXAHqhsQq2ZMnZXao4HXqg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xctqus0AFjg4BDuWOU23mQ3G9U84cb5v8cJ6Bq9FsYevN748vbXtwxXRl+gcgZRFmN2+EFoGl4ZIIOTeFSsLCbtO+DmQZq8xYLwHwxtH+JSIGTt7NbLFT8oUGDVZnbDf6akyOIg2BjPM4MoLKVehcTElbU1oxbxTmDK06/VjlVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y2A1dszO; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2A1dszO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716517290; x=1748053290;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wmF8BoNQ1WOyWDDEk0x8LGXAHqhsQq2ZMnZXao4HXqg=;
  b=Y2A1dszOzcFbMUElwGtZGklz0tbhPjM0rTHTxroqCFxL+wbdBW1K9FaL
   IiL5V//12xTp/ZUUjI3tmoZuvdG2vG0FfkYH0slp1d9LreNg3jyUfZTJZ
   P7CNGsIASjHunA+QgIMpw629wp1wHiHtgv9C9NnMANR8RHeCruXhcs5BG
   c+PpuW+tlTXrQR/Ech8TL4n2HVfqMDgBtn0t94+N1x8AGF/IKRxebtbmg
   TWokB9yiaDs66CQ+AKoqBGARZtnTLp4Uc1pLCvvYUR/UfqtHAFSEZvVcj
   NZgjYh6KIRpAO73LO6nBFA3BMFC7ffA4KM/LqXm/cOA675LI+ZFpzg8Uz
   w==;
X-CSE-ConnectionGUID: wxAbDfAkQQy+bnmSVOeC4g==
X-CSE-MsgGUID: eLQ8Q0nWTWC+aYTu/cVNiw==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="12725564"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="12725564"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 19:21:29 -0700
X-CSE-ConnectionGUID: yDNiZHo1R2G4kTQRrvpivQ==
X-CSE-MsgGUID: PiEXV6t+TdC8Mh4b+ZWQtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="38279223"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 May 2024 19:21:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 19:21:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 19:21:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 19:21:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 19:21:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LazB5YK73oKxQzS4DIMUrXyTUHZwlezunvF1ttZI+BW6PW6domKNVARVZ40fhO7HGrKg3RMGiduS7EgNAzPFHiR+zzvxF8xPuG+3H/ncPzL25Semi1ax96ZChW+0SAOf6RS/4fKFatcYFnJtiCwo04SUPm9mQXf6XQYnAGpMIpTNYp1kDUdXvWlNpVVmip0zI+tatZL8sX9K2kX1MJ6wbPMx13gWrOGgPVn+0D6uAWXJvrTdEf00n0O1+wp65CYqipMuLuTEdq7p57tFu8h983DjP+uoOE81MyZeYEmHvY3up226fV1yVNCFTykNI2R5NCIglcyzvsLaJ811KC3jnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmF8BoNQ1WOyWDDEk0x8LGXAHqhsQq2ZMnZXao4HXqg=;
 b=EBwE+GPNelYtfN9pBRtiBZdSd1t8ASAohcybuWN7JEomqTdy9mCiZ9dg2e8JeNUFLfcgCb2tKowxyl9n7cqxLB6sopfV27XuWj7Q/+EOjuVulGuwhG7xeZW8lgnyHPS3NwxCTbrhZamHmrfLl6+taWo6ERmXhWXQILi4xUa+Wun7a/T2trKg6BG+evxKtobab2r6UKJD4Erg7RRhYugtvZFKf8xF6t9mdaXfjsoUgHGDkwXUgIw/SpJxNVA+SwXKLDn09P17T0JcxhicQjQ0Fkk2XczenNDImwf+XzpUab6672IWqpU+vPb2EFWhmV50x9IT/zRGUhVPM2KV0JdpRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB8346.namprd11.prod.outlook.com (2603:10b6:a03:536::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 24 May
 2024 02:21:23 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 02:21:23 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
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
Thread-Index: AQHajVVq/X0HjqCDvU+a/LkdwhCQ/LGT28sAgADojoCAAk6vgIAAqT2AgAqBYwCAAlS+oIAAlxIAgAC8r8A=
Date: Fri, 24 May 2024 02:21:23 +0000
Message-ID: <BN9PR11MB5276A896D215E1FA61DECDC38CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <6e57d7b5aa1705bdd547b1cd2aca93d3bf70dfa4.1712978212.git.nicolinc@nvidia.com>
 <ZkDWXnPW7CaX5TtA@nvidia.com> <ZkGZc5dvLigXcWib@nvidia.com>
 <ZkOI8ztR1mUMJ8oe@nvidia.com> <ZkQW6/OAQ8MzN6Go@nvidia.com>
 <20240521182448.GN20229@nvidia.com>
 <BN9PR11MB5276EEC2A1DDA9C92F96737C8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240523150120.GO20229@nvidia.com>
In-Reply-To: <20240523150120.GO20229@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB8346:EE_
x-ms-office365-filtering-correlation-id: 5555c7b2-b66c-4fd2-1a44-08dc7b9834ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?sOabENv5udDbV6YKJSGOIdTYwJqlwFhqYjL5KaXp3iUqyBRHE6HgI+OPfa87?=
 =?us-ascii?Q?eO6KSFM0chS2hOk3jKRaE8fCA20w++o22H/u6AfhYJA5J9uQMP/By/Lc2AOB?=
 =?us-ascii?Q?Ac2zJ5mtKOFPUeUEjH2hYH1uFjWGScQzRgHIvt5ToPQ8XuHb2V6tOa/aZPhl?=
 =?us-ascii?Q?xJ61jOhUxUrEuTRVUMXv/rUzpUIRxlUKYupSTJsbhOnDs3ot5RskiLdMm7tS?=
 =?us-ascii?Q?VTRTgOzGuHuptzbRSfcQ1UBcq29BWtf0y8bANJwFW7sJR4NSRaL3EzfH0Zh+?=
 =?us-ascii?Q?U1w6LkFp9T+PXpyCX3ttHEUNHmvn8Wi49wNewQU6Fo5j8YfAuL0kjqjL0LoV?=
 =?us-ascii?Q?JyDRdqET9OQT7uRUFIM3tBkYcK9/nv+bYeFTkwQYU0TNFYPy1hXWqO8sCtw5?=
 =?us-ascii?Q?0iiezAK/kFWdDg+S9F8yc3a9oDlrrmAxhZZ25NyL5Nt6FdkrFjK8lo0ebBX6?=
 =?us-ascii?Q?kKXARzF/PpdxC9FyO23fOwZKpqQJKLeVtG6BXrwtZrgXZ5rUR5TULeaYdOQK?=
 =?us-ascii?Q?gsl1RD5HmZhW4CZ5F8dMqlOKVFfIifJcSnJyJoUqD5MDDUsipS5MoPdT8wzb?=
 =?us-ascii?Q?A4vF4rxFAntfyvrNjtBUe8miBoWAFjylqwiW0ta35o42xNdnnMy8nf8myIyK?=
 =?us-ascii?Q?iZ7B3bVpWnOL+9/g9qe1qKW+pAaOEvaVTrTmz8sFd62DNEbG7xO4FAE2xHl/?=
 =?us-ascii?Q?2LVMp3I8JMPPyDcA+8fzi3m2e2PGd1I5w0Bfgi7LQK+KraPahidrb6UNGWL5?=
 =?us-ascii?Q?r6vIBLQQEDsQUBR77IAn2lHxhlnHG0r7paBW02XNft/S6bjKwqAlJ4vHE+QB?=
 =?us-ascii?Q?5rtNFtxb0ATATZRcxFYuD39dLyHr356b2IVZdQmXUL1AKm8GCHO2GWS8b6Hu?=
 =?us-ascii?Q?4/nqY84u+EwiXYBXxbgr4SqVBKCGTt6t1KigfUgt0Ns1StpBKNc+t9JVRg/9?=
 =?us-ascii?Q?bsq6+85sX+eAKO8yLMq7OLcNDoF8lApfCMRbc56NSjvze1Rhwiv5omDtQK9p?=
 =?us-ascii?Q?3V41OaX8HVIW5muOa7jvE3M5kl+/sjkkUC+ivKevnJHV8dmcjzezT3PAIUKk?=
 =?us-ascii?Q?j9GV3I0YMIiuKvXsjXqzbTeIbEJhjb+hM0ZloQ1D6upiTv60C6+GIhzZEBnT?=
 =?us-ascii?Q?NlIP1SYbsk+FhwftmptcrHqUHVP69lfm94dyRbC9JjmM0BydacB+0TdhkDa/?=
 =?us-ascii?Q?NjrHuPVKo+ALyaU5smC7WJJNW+dR/My1V8NSeRPksfYa7/oBXVO1cnZBzJVI?=
 =?us-ascii?Q?7oag4/QpS6jccZurexMppcLdjZm6yT11/xLq7FGDUqvWmeA4tYJPP88IGQDR?=
 =?us-ascii?Q?MuiRmSnstibvdiFqmDMjTjUhJl1/ee0sFWTR/FnZnEytNA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S/SMlzcWs/AIC4E6JvUvzEXyiNO4cpSoflqOm3ev3osAon+b4m6wrD+1s7eF?=
 =?us-ascii?Q?cuA1vkLUSIR40eWVLtI2WT2cErTCEIz7gLirugIRdDXAEtPFqvHPaXG0xTuU?=
 =?us-ascii?Q?yjD1cq6WNdl+AApHzJ4W60PN5EhG7NAjL6AOoucVupVr8K/ZuxAnnRVC9265?=
 =?us-ascii?Q?gfnXibrLDJUpStig4Dc8A1+ieAaA3lHBkZiV6lu6uJgdcNUhkUO91AOpmz0i?=
 =?us-ascii?Q?gsksIpfHkdkVH+3y0pDDC8BFnM770f6+LRD8FNoqwrulteHf0AQ55oOpE6VK?=
 =?us-ascii?Q?LTtww9SLGy3ERDvmNAtfmDaIh5BKxb22Sw1IV41yEOfI6+Zn6BfBjgTa8CdJ?=
 =?us-ascii?Q?9t579AwuTl8DR/+sW+l/WDHolz5GNGaLPCU1y+re6eRPwtEqFbacmSsBoJVy?=
 =?us-ascii?Q?QwAZL6A2BUsNBoLCJBUvCezuIdiwPgh6APN+FhRu0W8d2wyMIzfAtw87k49T?=
 =?us-ascii?Q?qscsjZPsJrDrZOio/ZxnLW+YbT89Txmpf6myYe2JMlEAYPgIhuJpZIsSFcd4?=
 =?us-ascii?Q?9FSQHMrBYRZrazslGIiy+tOo16dnUvxThcjvVU3JcvAuzNphi6v/zENyfRRf?=
 =?us-ascii?Q?TyqNR6rriIw8LtV84p2GDKrwiQkim9vK9x28eGYuuXdsGX6rI4/mSKXsa/gJ?=
 =?us-ascii?Q?E2h34CtQjtFOQe2BDg5S8w6vZvwvBWURhl9XEt3dJK2Rr9iyVdleAKz2mdj9?=
 =?us-ascii?Q?9ahGisCpIKt9+IHllzrXw0A7WY3jLaIpp3ZK4mVXHKFj0j3oqDPyru0Vi6qS?=
 =?us-ascii?Q?fMc2YGx2uGMHXpWK2DEu3BdogLTFNJo/Ted6DV0jrnpz+/fWvCuz6FE+lX/h?=
 =?us-ascii?Q?07rTfMRQvbildgAMVjwt/c2IJsuxOoO+RabFJsrGErRJsRPHkmV2l8BLRkmG?=
 =?us-ascii?Q?PmiqbyrDLXGuD1Pk89mCDiKQiGY+bepblYQsHv6LEYkWu0Ph6VMJDTRoKlo4?=
 =?us-ascii?Q?nu5vFWilt5I7gTCNzxuDmLX5qN6YGCWyc8F2omJqIrUKyciCS7pg1+0tV4rP?=
 =?us-ascii?Q?3oDGAATL0eqBm90HCYCKdwEtQ8Nf09f6OZHm5prCVLNa//Cr6xmyQTx+mjB6?=
 =?us-ascii?Q?K8+DuIpxLh3P2Q12EunwO7xhZnpJ7U4P4nQP4ebVzESqdCV+snCW8au5WdI3?=
 =?us-ascii?Q?MEXsEKO0o7kn29n9jrFxqcrXfoxgp8QZaFDzUqjr8kseVRctCE2Cx4eDUDyd?=
 =?us-ascii?Q?FFJQpKmGFrPn+rpJvUHO71FzXNL8f2IBYBFnh0vzvxZSjOrZC73SEyRm87P9?=
 =?us-ascii?Q?kJbxTAxG6jiT1RuAIsnYiuONNevrNlmTS1651700QB4spYdSwr0o1i2NFdgb?=
 =?us-ascii?Q?ZKivYFtBzNtZzZBJgc4cWCRx9OL7AabSrwvcmlNHrRoE/2pCLdNGNlogmhNn?=
 =?us-ascii?Q?tZa0V8SniqR0WFXmuPKJLynSMY1PLJzYMfcgD8VVOw0HLTTTH5UrOeG05kmC?=
 =?us-ascii?Q?4zGsjeg5qBXEwlGJLLwhtAj6y5OdbIVJBTFPb54lfjgbNkaB5/JOiBp4VmIq?=
 =?us-ascii?Q?IMtVeB0Rr3lef4xR92gitMRfG49kc+QPqmW+RAfqkGxjuhDpVfszzDYKfOhE?=
 =?us-ascii?Q?uR38FcCGqrN0s6qaxfa0jF9DUmSLgQgFI5fP9Vqq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5555c7b2-b66c-4fd2-1a44-08dc7b9834ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 02:21:23.4118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KAwMh9sBuBv+XPZbKPdW3Lt8m56/mnFILv5A4yHOwmmlwuM6MxdO7mFjwtHocys20qwPggbW8biMVdr1accW3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8346
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, May 23, 2024 11:01 PM
>=20
> On Thu, May 23, 2024 at 06:19:59AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Wednesday, May 22, 2024 2:25 AM
> > >
> > > On Tue, May 14, 2024 at 06:59:07PM -0700, Nicolin Chen wrote:
> > > > So, you want a proxy S1 domain for a device to attach, in case
> > > > of a stage-2 only setup, because an S2 domain will no longer has
> > > > a VMID, since it's shared among viommus. In the SMMU driver case,
> > > > an arm_smmu_domain won't have an smmu pointer, so a device can't
> > > > attach to an S2 domain but always an nested S1 domain, right?
> > >
> > > That seems like a simple solution to the VMID lifetime, but it means
> > > the kernel has to decode more types of vSTE.
> > >
> >
> > why does ATC invalidation need to know about VMID?
>=20
> ATC invalidation always requires a vRID to pRID translation and the
> VIOMMU will hold that translation.
>=20
> On vCMDQ HW and on AMD HW the vRID to pRID translation is pushed into
> HW, and vCMDQ requires the VMID to do that.
>=20

At a quick glance VMID and vRID->pRID translation are both configurations
of a vintf.

My impression was that vintf->vmid is added to guest cmd when it's
about iotlb invalidation.

then vintf->sid_slots is walked when handling a guest cmd for ATC
invalidation.

I'm not sure why the latter one requires a valid VMID to do the walking
except it's a implementation choice made by vCMDQ?
