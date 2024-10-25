Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523A11CF7C9
	for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729844685; cv=fail; b=OhFOcjob0afc4GFZutq9yHRMYXYy7uxek+HhNVgskwIT60P7HRBJ20eK28UTUGSuvUrkwLUXD2A5O/unH8SyuSzq43GfqVBzMriaXIVkBOyvl5RJc6Zk56tzD4W8VQkHq6f4VfsRzEwALnFs/TH4PfsX9qgzVcO+Zd+W9jhzKNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729844685; c=relaxed/simple;
	bh=HoCT5BQLS4O49fi843Fd62Zo/BLFvYFvnXq3v8XL/sQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZujlgfYkxuP+jl5oTycR62qQQIFQMReVzEVsgJVofvQorE/vafc1aPmXnZ7g6pItVolDjc2O0q9dW/X6YxufflCrSsve4XpUondVnh1+iGcmorXAS/EicMVBdvRmHAgi/CU7ZsXEEACV/7eZJifdn9hHQGyDaojjDEmpv2ZG3X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EDh1vNPy; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EDh1vNPy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729844683; x=1761380683;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HoCT5BQLS4O49fi843Fd62Zo/BLFvYFvnXq3v8XL/sQ=;
  b=EDh1vNPyW1YG7i71AVFbhRadlfew4ToKemUUIaRsBx3bptk48tonRuKV
   LKrcgnNP7oOwyvlFrXceqcJfBwiMb5gQkFANA9mqk8JZ1PuJBERU/irJD
   5cEaEHvDNcSs8Ryl/qZVvKcDA4KzsBK4Cn07O1Kitv7xnC7emSm6n7q3W
   cw9bySmPieTdrjAtTeBxw5yQ+nevJRnAwiW6Q9vyhJiWRywX+NIJBrWnv
   JaAyCFoKDD2ZTgs/knBRrhxtKvWv/ydjDSe6s7zZ9MM1sMNoCe1g4GPpY
   ewiH4riiX0+j9Bg0ta9AmIC/H9vhdo9Hh+fbBo5r61AqXaVDs4067Z5Hd
   Q==;
X-CSE-ConnectionGUID: tnYzbeqhQKmBUGuXEhN9ig==
X-CSE-MsgGUID: m/wLvvbgTSWFgELQP50a+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29623097"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="29623097"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 01:24:42 -0700
X-CSE-ConnectionGUID: 2bx2+A6GRPC4dkpqnjfWjw==
X-CSE-MsgGUID: mlmHPT0bRLScGo1yXna6CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="118311670"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 01:24:42 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 01:24:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 01:24:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 01:24:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OyYXHj4Wh05HVSHJYNAFKvy6/QTeIWl/WfFHa/X5MC/1ga/1/l9pkEvWu/I98dtkN9qHcKUFzyqGNf5qY+s6fjip+dHKOIO4oqG/OJv1a9ve4vmZWUSMJi60qGonhqnlg4ktF2Io1tnZLrYvkj0pZsGrVvx1CdwfMfzYLXueL36CRNrUV6pHUUMFiYy5xfotlhIFhNLBU7+8pYp4VSC71r+WINQgfkyBvV3kp4qqcs1QkNNyb99KHRQVC/6PNGpBJs5GCTsddF05VAPJjgo7zpHRKHEVmCyMhN2iNJmY+dgWXG4WATpRSCBhFoZHqcgQr0zA9CqxZD7As+VHCH805g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1EsvOdxBj+wRzA4GQ5TvZ5W4c7BDZtDMHIio3Zp8CE=;
 b=J5+EZ5bTXDwsgY/0O1Ry8UWCm7YK7do/XjVVOmYU215Oc4DhTs9a1VTE1tPSf6IXi9fmkNzcRf92SEWaTnal0hc0f0KOvgtZnMfxTsnSWokeTxKGV8/Ow3K2O9yyAsEzIkkCP2jQnu8pk6OoYN0jonoEat8/eJvTwDSxzxxEAzGPAzbBSFRGYkvfFqQGDLWPJ/ZlJnD/yXVSAvzRB+Q3o4MtV+09JzUsabd0gJ8euDoAXt5hpmnIdDftgM20vWwG5ZwtBqI4zdKt0ViRSQCawPEv35FcAEkLIcaovA7qspqksb0eWYwoldhStezw+e/EWgJzG5iPzmeaxjMfJ5D2og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4754.namprd11.prod.outlook.com (2603:10b6:5:2ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 08:24:39 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 08:24:39 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>
Subject: RE: [PATCH v4 09/12] iommu/amd: Enhance amd_iommu_domain_alloc_user()
Thread-Topic: [PATCH v4 09/12] iommu/amd: Enhance
 amd_iommu_domain_alloc_user()
Thread-Index: AQHbJTin2scxCAuMekqo4etoufU9CbKUSJiAgALbhiA=
Date: Fri, 25 Oct 2024 08:24:39 +0000
Message-ID: <BN9PR11MB52767188519B3F9E9C709C598C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241023104207.5894-1-vasant.hegde@amd.com>
 <20241023104207.5894-10-vasant.hegde@amd.com>
 <20241023124603.GC13306@ziepe.ca>
In-Reply-To: <20241023124603.GC13306@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM6PR11MB4754:EE_
x-ms-office365-filtering-correlation-id: 8e5e7169-ad17-4d33-e2dd-08dcf4ce77fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?dUQ6RmL74Qk62e5a53bb49liW1Za1S2WbKtL5DzZypO2VvHPNG9qDpNWLB++?=
 =?us-ascii?Q?D/2jSzbumz0t0F90CPYYxax4hhf/AmZL5xVBuzokWfhwdKdkYZrI7e+Y5GzB?=
 =?us-ascii?Q?RLd2kqgqWW+C6+6gi5fwOYuN1uNCf0Wv0k6+fPjolojlqOBUPKwAr7IuZZLe?=
 =?us-ascii?Q?A59HG80ShyrOHnyNhdhBWvTqW9pwOoG2pk0G3NCtrZskimrsxalAptsfu3+R?=
 =?us-ascii?Q?N2mGTNF0LXXcDKRXLaaFzaZ+DMGoR23jAA58nxRHTvouDrfG62YX6Gl8NL08?=
 =?us-ascii?Q?j9zRY1Z0SzhNmszvTh/UpN+yq4V84ndnRaRz61drFv3hVbha/fBoI8w53s91?=
 =?us-ascii?Q?qdWKNE2zLO0GV1qbbyr5s7pII7s7HUovIrHD5XGaMHZxQcgJsEjaKNOg6RXr?=
 =?us-ascii?Q?Lj65TJCTcN72wOx4KYx476TDahIsyhc/PAhYWjKCZMrpivhUiR55P/jmDR14?=
 =?us-ascii?Q?87/dHoFLaU7rr7r1GmwLo8FmpTyfsf2w56JDL/GP7nAJry5Hyv9+yv+gGM8L?=
 =?us-ascii?Q?4RaE57x5qS4SYHUCxvsoyIg7jAiFKfourLQi0A5IEgyyuKlkvCg14rMuGofd?=
 =?us-ascii?Q?4bPEh2JKuvWoWUHLXkutej3svRQV9y1t6Katr90KOWHQtIkPI1S026KbzoIn?=
 =?us-ascii?Q?4TNjB1K/TJMMjHSsQGGhVTO6Sz986H9n1RPTA1/i5K2M9W/R9MQXtNWBbX8M?=
 =?us-ascii?Q?zYHtVUL77Bl5qohm7wdtBAcqW4aWXujjK3mKqZLYsuSVrHDYfIj78Kue1cQx?=
 =?us-ascii?Q?kQQDlnCPv5bUra1Cr0H8I+rK3gGZVei8DmSQNMfEU3cPsA17EG1o+27H+pp8?=
 =?us-ascii?Q?gbPddIwLKT8NreT9OZhSM3tQM7YnLSgsWPqzCuVfQPZcXirw74/WdsgI7m4G?=
 =?us-ascii?Q?lplr2hXFlLo+kSQXts8EPiKv0WiD7hBIQ0o07LO8THgAW5Enc00pG6o3eRC5?=
 =?us-ascii?Q?HLjRiY7ItpNF/B7lmwPg6h5RFZnGqTHDhBkj1G2J1sb8N1JmNy0quP7mB4cf?=
 =?us-ascii?Q?lKuuXBSNGs476F4ps8xh8oyhlhf/IpQexZfAYpHJT87bovvlSqmw1fiVdcv7?=
 =?us-ascii?Q?ISaRch6g7+E5mIckq83XkMt6hVI5pSn8NZFAeDZy3xbILGmwcebgmJTUuuPh?=
 =?us-ascii?Q?Z5Q0s7yFBcwocI34pGWfZkR0X6K960czPC78LZW9Jih1sw+1aHrwYQYH/2xd?=
 =?us-ascii?Q?DiwP1fi7MDBT/EEG6yiNvnCNvZWgfCKBCHh0/zsDdSVuiCLRTlFAfBsPnYNT?=
 =?us-ascii?Q?4T2OkJHc6NbGFaqxMwEYUk5yDtHFYSE29hYZ7eYQD+PWlpgS8Ggilmw7BeM5?=
 =?us-ascii?Q?FJNUGDzeYmtPqFlQPkA0Trq+uG8MeqbbAzpqcM9b40VS7w2T0r9JrgGpV9Td?=
 =?us-ascii?Q?DViKAFk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kGxg/zZo145HvLAKI792Cb7uRaN0mXSUVX55NH29z6kqRvuokHyXtGtgwZQ7?=
 =?us-ascii?Q?916KeMcZ7BR0N1bgp32pC/vdaSX+gty9+7KTn4lCrIvdJU9GSnChKYnGmXqu?=
 =?us-ascii?Q?IkToDaJZCOKGqjqVsCN4EmBdQPRG54gKxZ2olG7yabw1/MvrgxumrowhSA45?=
 =?us-ascii?Q?PTghzPgGbVoQ7Rga/o8rO5dF4ddaBGKXPj9Svj5KtZn89C9rYBrayVAyFo4O?=
 =?us-ascii?Q?xDKJEv6CSp05CoH3nhYm541EUxw/YAVXuLDlUpb1RvvDWjtn984NHmfrB6tc?=
 =?us-ascii?Q?X/Kk5/uvTWt1l5FhUuLmqaSVAS9V3z+DkphghuodP55r10/puHKWDk5nYjXM?=
 =?us-ascii?Q?GNzmhr+l6OdNULVUqyO2COH5O21PRqy3GZb5fv57irD5qmD2OiVkwjjrh4Ma?=
 =?us-ascii?Q?hcnXG65iWch6xNQkA6ZxRJTIPf4IuFNHA33iEaLnyNLcpgLEN+ed5NXPBwwD?=
 =?us-ascii?Q?A1FlmEppLbaM9WiScD1M2mY5g3AVPzqZJCvfnHb6y3BZOQ8eemQOxsi9yl+x?=
 =?us-ascii?Q?934b/YN0dnifEJ91rg4vqqSgrG94TKzQii8MRroqVgAIM7CCP3Bl/782RKKb?=
 =?us-ascii?Q?S74IgipwWdT1IqHtpTcMA2Ltr3/CvuGu0uWFVDQlo2ZdD4ltbcqNQKAlp+MQ?=
 =?us-ascii?Q?bE8j6sj/I/0KYSWlLFtCikIYVNmJ4jArULG37AJlUwRBPV7L4Wo1XixW8HLc?=
 =?us-ascii?Q?nTxG10TAQdz3o73JUcwlZg6KPpQyho7wM99lbtWcPyYqSHxkgxfmrvdVXJLU?=
 =?us-ascii?Q?vgdMOhgpissKgNO+JkWMLcB3p07A2L+Q5eHlnEAnC6F31Ludsb6vkWNt6K5E?=
 =?us-ascii?Q?TZZeenbiP9aOXMuzm409Ne/F1dF6t9/DqlQQeS+wumg9UsEDYHBPYVevT+p9?=
 =?us-ascii?Q?+4nWrJnTh4/lgHkxL2jjtmkbx+HqSSbYgv/xIxZx3sAYpMfLHUnYl4ZHwM0P?=
 =?us-ascii?Q?+d7ymUH6zNXf6GviXAJ3KGX4fkFhJZ6gPj22Rp70/Ys8iXEBHsCKseytwNjm?=
 =?us-ascii?Q?6HuXt1JfZIrffYSJ2BeVkKyaykaSPYSpZW8ukAv4WBds2lAxhDLXBp+yx+he?=
 =?us-ascii?Q?DSrLuXw2XaATmAWR7cjFBF/7iPFAz9sosZxh6WIRmbY98/HdsZJHQtfrffAI?=
 =?us-ascii?Q?rxNqmSZm/AdwffnOq6y8OEbzzz9BuaexlINySkp/okHviDYi9nApqKykIeqR?=
 =?us-ascii?Q?1BiWR3vpjuD2XNIuAK/vp7xgqkWQjBgOxmDxmUF6H3ytgz3oTGvlZ1lPpiRO?=
 =?us-ascii?Q?Z6jEAdIwaPBzdL1y+Cy29BihqLRLQeOeaPSTi91v5U44wuwuM/9c+U9qBQCD?=
 =?us-ascii?Q?l3O0sJb5oveXUMWMjhzLCT9csCf4edAr+dVa5nYFG8lpujtsyRStqsuiK9hU?=
 =?us-ascii?Q?//ilL0/EQZry1y0N/ghUnxEWZDbOIe/GoX59NygZ5lcSGxcGBF/jICDMvRUD?=
 =?us-ascii?Q?fsucP8+DyzGSQ10RQE4Zi131BJWb+ZvAvUH1g3/qLwSN8LJnUMte7YBDSYc3?=
 =?us-ascii?Q?bb6H6TraplISYDkBc6iAu/bVo0l/kDlPTetkZGNpfIM3WGjJa5cmD2EE6KMg?=
 =?us-ascii?Q?RNUxRqUMtqa5LnS/7Aa7etgY6+7SLS+FZZ4Y/2tD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5e7169-ad17-4d33-e2dd-08dcf4ce77fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 08:24:39.2820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kk5ltKT08nKXZP1iddSrJVmoXBlZOmuElcsXoSUm66abFjwK2fhkj1zulkLaOhZYDN2dtstn/AXAgYmVlKNYPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4754
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Wednesday, October 23, 2024 8:46 PM
>=20
> On Wed, Oct 23, 2024 at 10:42:04AM +0000, Vasant Hegde wrote:
> > Previous patch enhanced core layer to check device PASID capability and
> > pass right flags to ops->domain_alloc_user().
> >
> > Enhance amd_iommu_domain_alloc_user() to allocate domain with
> > appropriate page table based on flags parameter.
> >   - If flags is empty then allocate domain with default page table type=
.
> >     This will eventually replace ops->domain_alloc().
> >     For UNMANAGED domain, core will call this interface with flags=3D0.=
 So
> >     AMD driver will continue to allocate V1 page table.
> >
> >   - If IOMMU_HWPT_ALLOC_PASID flags is passed then allocate domain
> with v2
> >     page table.
> >
> > Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> > ---
> >  drivers/iommu/amd/iommu.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > index cb6a72564c23..cdc93c794eff 100644
> > --- a/drivers/iommu/amd/iommu.c
> > +++ b/drivers/iommu/amd/iommu.c
> > @@ -2403,10 +2403,26 @@ amd_iommu_domain_alloc_user(struct device
> *dev, u32 flags,
> >
> >  {
> >  	unsigned int type =3D IOMMU_DOMAIN_UNMANAGED;
> > +	const u32 supported_flags =3D
> IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
> > +
> 	IOMMU_HWPT_ALLOC_PASID;
> >
> > -	if ((flags & ~IOMMU_HWPT_ALLOC_DIRTY_TRACKING) || parent ||
> user_data)
> > +	if ((flags & ~supported_flags) || parent || user_data)
> >  		return ERR_PTR(-EOPNOTSUPP);
> >
> > +	/* Allocate domain with default page table */
> > +	if (!flags) {
> > +		return do_iommu_domain_alloc(IOMMU_DOMAIN_DMA,
> > +					     dev, 0, amd_iommu_pgtable);
> > +	}
> > +
> > +	/* Allocate domain with v2 page table if IOMMU supports PASID. */
> > +	if (flags & IOMMU_HWPT_ALLOC_PASID) {
> > +		if (!amd_iommu_pasid_supported())
> > +			return ERR_PTR(-EOPNOTSUPP);
> > +
> > +		return do_iommu_domain_alloc(type, dev, flags,
> AMD_IOMMU_V2);
> > +	}
> > +
> >  	return do_iommu_domain_alloc(type, dev, flags, AMD_IOMMU_V1);
>=20
> This should be more specific about what the dirty_tracking
> configuration needs:
>=20
> 	if (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING) {
> 		if (!amd_iommu_hd_support(iommu) ||
> 		    (flags & IOMMU_HWPT_ALLOC_PASID))
> 			return ERR_PTR(-EOPNOTSUPP);
> 		return do_iommu_domain_alloc(type, dev, flags,
> AMD_IOMMU_V1);
> 	}
>=20
> 	if (flags & IOMMU_HWPT_ALLOC_PASID) {
> 		if (!amd_iommu_pasid_supported())
> 			return ERR_PTR(-EOPNOTSUPP);
> 		return do_iommu_domain_alloc(type, dev, flags,
> AMD_IOMMU_V2);
> 	}
>=20
> 	/* If nothing specific is required use the kernel commandline default
> */
> 	return do_iommu_domain_alloc(IOMMU_DOMAIN_DMA, dev, 0,
> 				     amd_iommu_pgtable);
>=20

with that fix,

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
