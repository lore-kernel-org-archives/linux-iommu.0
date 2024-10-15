Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C535220EB
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 08:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981083; cv=fail; b=nfMPECJPxQ1BO9pf7txWsMqJRJRY0zSQnOIW8qNuyac6vFstmds2bzubOaCyzhsTPupparCi+2lpd4GeAtzNan7HTCp+O9dqm3MDU9S73w9l1fc9IRBpU6nG9O7T6OrB1jHE+/Xm39bnNzcRYKw3Zw8reiuB0De5bKACBE/EUec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981083; c=relaxed/simple;
	bh=MVw9ZTqGo9JA8Xy75VKzY/TzWbxqkBiXtmWMojC2wts=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I92hfqieN4fBa/OFltdwRByQ1CwAgnjxrMsM2O5SQryT1zMIX/4DLfaBVkBzePmh+eOWFnyRqhDWBbst4zet9lQU31uexXLThLcY6/fmM7L7K122RsK0WzK3jNeWlt8g3TT6QAaD2v7LuSQqFoJq3/luLZHG3ku+yT/DGEr7xZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KOlh1VaT; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KOlh1VaT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728981082; x=1760517082;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MVw9ZTqGo9JA8Xy75VKzY/TzWbxqkBiXtmWMojC2wts=;
  b=KOlh1VaT8ijFqZXXnKvWfJS8wkT93oQAuPEYqMnx7/HPtCnTtnrp3kVL
   mCEDy63pW6AncqZHWS+vDI8sV26A0+ZlcKJXyI8DXAP4EYtWFYywRJePo
   FmjVQbeaNQJ3xHM5zNGQWDw7XU9c2roXjmtjAR9wNOOgQMinU4FaEDVy0
   v5FGik3FlymOfDs4USbrbuyxeuz2iIAwsaFbW7A6SPEkJOzkJVDCfPx72
   v3d+SlsEeHf3lCrDkFyOpNteNOB3o4AuC/ojvilY51OxNYxlc37QK1z7O
   dwUQT4tvz2y8B0trk9DHW3YWgunSjaV7F06pBCsEGQKJcIe9howMAWlqN
   g==;
X-CSE-ConnectionGUID: IJFtK6RMQ8CFvt3T7o5zsg==
X-CSE-MsgGUID: oYtre3ahR+yJbtW6R2P4zA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39481028"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39481028"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 01:31:21 -0700
X-CSE-ConnectionGUID: r7zlaLbWSCWDDv2n3WZ3YA==
X-CSE-MsgGUID: lEPfDke/QDuW9GrA04w7EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="78259793"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 01:31:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 01:31:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 01:31:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 01:31:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 01:31:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mlaHh7AvxvLbisXZLnYEWY0Wja4uNZ8AlhttZBvnFBORNNMS3RjBSSh9GKjpIA7a2+JoqgFb/ovCLaOkcTxjsUAvbbB8JSlSggQxOSkEsSikuqTA6qZzJUCN2IV9VTC/SWDaVW5ICDTj7A+8u9FyHthkjfnOzYTxqHTBtY8u4A26YmMNxjjYMlz4uuMiOzqgs2OV79tJZyz30pQBs0Og3e9aIU+c7vkVVNuGEErfqVlhfa/ixT/5ectd6oDo6OZ1dHlINqqAS/9YeOqWI4ThNJ2IuhEVRNHgAa1/Wn+ovBXrDtpe+w6VxTmc/eOhGCHSiGBjBe7CL/Q2yP+j7n7SCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dbyD2lbefhPmYr5pqVu5vw1zTPh7PIbmAOEjNjhJeI=;
 b=XBU8gmfdeg91YXDIJQ35tqxVSzuUEkRgMdtXxS1tqI1D6RWOEk0nAnO5JVzGI7slDLPkyZx5VPKwpEmhiySq5hvGAjVTlaHGFcy92RKN5w9kSGfFLPRw4QwF+s+r2XEL9Up5R6BMZxjdmhe32fgTpnqovgJfjQ8pThjUburwqg1i4KQQdh2AfSZaGUcRqqEY+O7dAPpgCw6pX9d/zU/WUfkc/FGpeaK1dfoZ1Cp8ElppGcdSGHs+VVv8HV/oGQ9t4E0fMlPXZXWofL8Em1YGr9oJMhox8mtQ5R31YZ7PTugnJox1GpXiigTuH0Ga6LdJO3BGlk9dq1FRIS/YsdWlYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB8115.namprd11.prod.outlook.com (2603:10b6:8:12a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 08:31:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 08:31:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Vasant Hegde <vasant.hegde@amd.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>
Subject: RE: [PATCH v2 3/8] iommu: Add new flag to explictly request PASID
 capable domain
Thread-Topic: [PATCH v2 3/8] iommu: Add new flag to explictly request PASID
 capable domain
Thread-Index: AQHbBDRXs3J9asrkRk2g/D3qvQuctLKHr8Eg
Date: Tue, 15 Oct 2024 08:31:17 +0000
Message-ID: <BN9PR11MB5276C9733586A65F1F38F5B68C452@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-4-vasant.hegde@amd.com>
In-Reply-To: <20240911101911.6269-4-vasant.hegde@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB8115:EE_
x-ms-office365-filtering-correlation-id: bd66fdb1-acf7-4c3d-f792-08dcecf3bd34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?PS8dW144BmLkDD1Pn8H/uWpKXnsCEI9R8o1wmyTzWtV5AU1peJQy/NGwxtNJ?=
 =?us-ascii?Q?v5fiGvSJGNkMpzraCRwLcxe8cemYEFXfCKhMlmqRNy8MW4gHAET23cHrQa2y?=
 =?us-ascii?Q?L+/qSqzznoWJi8JN4NCAAiSaDUQPpqL5nVOy06hUrnU13zaUdVRr2Bzovuo2?=
 =?us-ascii?Q?kcHFHjkun+zYmtpnNBy+pbnJVMduYZ8nYgMWcwDDKq6HkcjNnz/sIr6TyWmg?=
 =?us-ascii?Q?71Cltn4EGdrOZ7s5jiXAVF3YP4DJipMBdTpJL/q28308z9cdRtohL7fupt6z?=
 =?us-ascii?Q?jGj9BQNSm/wtHOqKEZHe49aSaO+ZUVvJKQuhipxQQLmu8jEFE/xCRj+zo5QV?=
 =?us-ascii?Q?RMz8OKlC5UC912L39cXMJ1ZE49zdOHfYjbWFoDzXCdUpq54jThRiBeeTNgsW?=
 =?us-ascii?Q?umu9ZO6I+60GQ4H8QQvv48PYxDBPkxSkO9LSvnS6H2wd+e4xXQyT8pLe6enL?=
 =?us-ascii?Q?84MPUPmH/PkFHNYWbZVq6QFhawh7tlZ1juenAftXPu90tiUpD9ZRffUSLTdo?=
 =?us-ascii?Q?4o5V5qf0OoqzB1E1UPavCB3wyKzRZMKdTBrSVrzejzoUQB+JQzx9bX4MZ0iZ?=
 =?us-ascii?Q?/vKsvhLzG9xKllGz8BN2pNgULT9EmFhQmkjD0v48d8d7W0pvmcCDSbcpJeyB?=
 =?us-ascii?Q?eCNEeHp7FddZHRnhudefw9nUaAG3smNOz5Y7mEImhPlE9t4IjnNOoSOTPmyl?=
 =?us-ascii?Q?2R2n+cpjWyJKoU/CvLZT9+0PNcAxuMahjIvPmBLdKVhgXMopIEkjE2Czfq7D?=
 =?us-ascii?Q?v95Lvg4agIdipaLiKPXDpXJAiEpJJTqJRG7Fb2cRzjUsPzu+VPD2z5NwjKhz?=
 =?us-ascii?Q?xGPVE3yQKY4A1UpLYYnL13pf1voXEQ4V4XVtw+HVSRE+Nhwy9d+rZ//xSrs7?=
 =?us-ascii?Q?Jc0DKHrxL9Xk5iV3mfkOnIr+rf/NKCH7miBZ7b29E8pT5xcu0Fr46ZTPnVR4?=
 =?us-ascii?Q?BOHkZM7ikx1rlCe93NzsfSRGS/WBmzQpPj1wrnqEUlLtzb1TfoaxvK/v46Jv?=
 =?us-ascii?Q?8I0ywAoVbfCY5U/sHDj2vwZZ7PBbvsrOlUKAVOCX961gqogsD5OOXswNooNo?=
 =?us-ascii?Q?j5OwGDUuSB/sdJUckdKbyCUvLYWcHAeslrayxp08p2JnroInOJq7ZxK2/M7v?=
 =?us-ascii?Q?4PmpQ6HDrHBDMlYOGMVGKk79JB5uXs658hUXDI+FbNXSXN1/H850Q8MXGZEc?=
 =?us-ascii?Q?Gc1dH5cLyRavqHhipFfDzGsklf/nt7iLHND8AGPv/qPMPOV9n3X5k56XMRuM?=
 =?us-ascii?Q?U+bsCmRTaFPTIa2qxJhd6MAXxCEtXw4AzeOc7wHOPfV3FCiaUCkbKD5qw4Ht?=
 =?us-ascii?Q?kfeiY7G18h0Z9HjckmoQlvVnfID/xdKRjzjiln2hMbll/Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZNq63jb4dbrKRF9czeL12a7DqNDsjGV3YAOAIA9meB/Qa+IzfbBM0up9Jtho?=
 =?us-ascii?Q?++6WkCGRlGH/Ibo4QxATsB6G9OfbRYBxkktnT9mZ7RWAAbEsMYETURbJjfzz?=
 =?us-ascii?Q?yvd6+rChaMUOHOYOeWxI0rK/lYwLgX1oWAKX6miDjymTWOpGdx4lPmuiwnMs?=
 =?us-ascii?Q?dnI0C2zALSDqAfxy1ei6jenkf66BXE5IUoMWSwbdWOsfXK5Hv/uPWNVXze0r?=
 =?us-ascii?Q?vxDrCXW1KF8B/bPAMYJIwsMrzL0CBPb7Cf2h4bNNiaO9k41Q5Fx8YL7GfqkJ?=
 =?us-ascii?Q?zaQ/wY1525//pEQn9fu//EkliIstTX5FVpPGMNJ61grf0BNAlFFL7rVugbKa?=
 =?us-ascii?Q?HU7CIkDYgdg089+sqCO++EEHcbJy8toEObzs44R1Mw2dV6KBWaX0OKs2BKjR?=
 =?us-ascii?Q?dzD2QD2jX7ocEpXEzo7BAx4nc8w/vrIOno4KctIRS3hJbtDFgE20nyiciNM2?=
 =?us-ascii?Q?pVKQfWt2eMM0qaw/6lHLk90F3XSD4GIv1tHUzE4ioL8JigCySIwiWq76vfaA?=
 =?us-ascii?Q?woLNK4q6Ggrp3X7uZkej5n5b1lWu8huCUnTrtJTQwaWC1IJD2rCG7OFrcdRA?=
 =?us-ascii?Q?D01GNmWaFbBMmvaflsPaMBrn+zaeHhGJ0GlugqGD1AJHmiOKRIOXnyygH2WX?=
 =?us-ascii?Q?TNL/iyiFRA5xgZNF/LkSQo+iACoQJGdkqFrJYGug1N+ChkSjBx6zEu0FxMl4?=
 =?us-ascii?Q?Ecy/HGGRMT9gDe9/v8EsLB7ubOSYwyh0LyydAsZOMdaaL1+b5giEtH5pyUBj?=
 =?us-ascii?Q?y9IWCZsveJEsoUqCeXwEfQ7zl+5szlJ7FFPrKUBj6+MTzO9Clhz1k292OpBp?=
 =?us-ascii?Q?RD1kr+g4q8vTJM79tlMIyMb3hIHRBjYhenGMk6E11Qs46xNb7dFwLSCyg7At?=
 =?us-ascii?Q?og+W7hDxq9TMOsmnKOjHo7xUHA/V9Um51Edqw1+hr9UmpxrWcHuSdmyy1lOh?=
 =?us-ascii?Q?bQ1TtULxXLRYcAMGKlH2MlmNiFmYXK9K5PErL0CDYxag/uP3ayFVwo8LFOmf?=
 =?us-ascii?Q?4mPH9ZSZRtcoK0iGzG5+DDfnEfFQXIkn1YiAJErAm30/jhQlWD/97dcEWuGR?=
 =?us-ascii?Q?xdAw752PwRO9V4faSP4dwKUHw+6vSO2OoIsZZSU23jMQGJy7HTaMSV48+ZXq?=
 =?us-ascii?Q?z/+3WVphZPae5JueEKqhctRYRLursnhYQ22QYefcNKnTW7dz/NpcAjBSEqGg?=
 =?us-ascii?Q?oOd7yTbiHnru3tpPVrpEChtqb98sY3AVvKP0q40nGju+Yl66u125+SsaN6r7?=
 =?us-ascii?Q?Ngv0xmPOsqHsoB/mWbwvNzZp+GqtMbsAG9tx4Gnyk0Zrs8xH1xII13cDIZ+3?=
 =?us-ascii?Q?5zTGdWD1aNQPCY2ze64uUTa0efTKpLqtpY7efet4VccVvUEs/5pQdkKoAFVW?=
 =?us-ascii?Q?O7XUFLIBwKoCRjlBtb0dId/QLlsrRM2Ch69Vb6LBmWlQgdFd11Y+axAmZlFQ?=
 =?us-ascii?Q?Ak2i0gG2i1M+0nTix3aFyPwsOni4/syJ+g3tQA3T1gkzRfifuoFWizRWWtj6?=
 =?us-ascii?Q?1xJ67ISQGEliYMXfV1Mh0dU/9Z5T2IrhTFKcUxvFaGfD1FyF1D2wVZVrcV4g?=
 =?us-ascii?Q?M9X/ynAT40FoYMxhpbeqaExMqAIC7yBlHA+n6iap?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bd66fdb1-acf7-4c3d-f792-08dcecf3bd34
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 08:31:17.5205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4hyXlDTEpf1BbyB7sNjxIHRDL627pmgjId9uIXUUVxlvvgV3k3OjxHJnBRftaHgeekKb+CgfAlz5DmH2hW1vFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8115
X-OriginatorOrg: intel.com

> From: Vasant Hegde <vasant.hegde@amd.com>
> Sent: Wednesday, September 11, 2024 6:19 PM
>=20
> @@ -359,11 +359,17 @@ struct iommu_vfio_ioas {
>   *                                   enforced on device attachment
>   * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt allocation
> data is
>   *                             valid.
> + * @IOMMU_HWPT_ALLOC_PASID: Requests a domain that can be used
> with PASID. The
> + *                          domain can be attached to any PASID on the d=
evice.
> + *                          Any domain attached to the non-PASID part of=
 the
> + *                          device must also be flaged, otherwise attach=
ing a
> + *                          PASID will blocked.
>   */

The last part is not very clear. Probably you meant that even if a domain
is intended to attach to RID first, it should set the flag if it may be att=
ached
to PASID later?

Otherwise,

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
