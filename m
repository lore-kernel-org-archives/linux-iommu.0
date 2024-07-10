Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6272B9C6
	for <iommu@lists.linux.dev>; Wed, 10 Jul 2024 09:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720604779; cv=fail; b=rU4uWG9xmOAwSUdC/DnTbT05bquuiKZOlYE+h2iCCONsAA37pSSFgPjEBQRJdZ3gTl8GL6NpUudC0dyi9UeSHPGSiPwr5sHNEUR5JGFRiG+5/0MKZUAeCYnmjRvez2fE17ZUSiWtEYS0NvjL4/ts3QVoombyM3VlUbw7eI0xPF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720604779; c=relaxed/simple;
	bh=8Gxk5u8v86xf6vWVmTNGN9aq150LDiu8AkVIST/9epk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s0pUMonvrQHfKAzMDiLU+b0eboPmNFiXLcymnBz9LfeQpgUCI8gByLwvEVuPMOYp+GVpX4WmFK0i1AykhYIxuUcEUL6Vwrk0DbM4X66/PeykFAj1VjFtZ849jTFj4639lFFBHpNgyjHwatSlAZH5bhlE0BPP1MD1R1g/+OQsIpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BhbqMbWr; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BhbqMbWr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720604777; x=1752140777;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8Gxk5u8v86xf6vWVmTNGN9aq150LDiu8AkVIST/9epk=;
  b=BhbqMbWrp2SIRikmlcAg7pc7MlRs015+ZDKSVsYhXOxbjvwjPDEi2ltK
   0qg29NuBS2Gd4nlOPjaCSjomy2ZHj5c+l8W567regjNU2Z+ARONXXZ3mh
   kAn6yE/N6MuckInB8QyIazUo/0wxvlhqpeed4A3ELPv0u3DPGyinzRS5K
   YjL8YlprBD3gZyBCxqy6GDWkZegjf7cTWQdCTw0U/N0QkjFwO+AgXqQHx
   od1muiK4OEp6+ntLMaf3ZY0sjAxCqSZF8dBZoBQkM5w+eL+CkzxjcMjkq
   9oOUrh8VsE9HEt3MANolc7QFcjZiew4lhRzaZ20ImE22LjiA5z6UucazA
   A==;
X-CSE-ConnectionGUID: FXBHXiAwSmqF4lYV/zHkjw==
X-CSE-MsgGUID: eyjjowR2QyOhUFp0GaMDmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="21785299"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="21785299"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 02:45:44 -0700
X-CSE-ConnectionGUID: KCLO/RZERPGhnJRDhCUBJw==
X-CSE-MsgGUID: es7DqfeDTy2K4FxWw+fYHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="53333276"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jul 2024 02:45:43 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 02:45:43 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 02:45:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 10 Jul 2024 02:45:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Jul 2024 02:45:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7v9EG1o8Scu2br8JeDzvhTpHT7togv7TWYJFLq/IZgXi+os8x40fm7eLVpZdT4Odo3L8vV5w+c7d7nLy3toHK6TX/xFrNkKVozC8wNfF2NFC53cRl2QhPQQnx+pEwcWXg3weT7OWrc7LgzvlvQx/F7stAn4UTqOIU0nHOF52Abm7r0HNuDlBbxRfAcb2lfaJVq6OBKjR2MuoPVEn4ljE+NZvJdoeWwsfh52jt18eNcCXkDPIt30o/DaEPVQ0Dldc0C8lepuE2N0GoCXJz0P9iF/fkwNkRbxX+8J96vEmFEqiipXM9sAQqvGfmFiU195yUE1o+WPexs+uRAKtbq4lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJFGqhuBN9Sp5otApZKWf2e1AYtf5IrMwNsJ9vb5xLY=;
 b=CEwGm1jUWRnygVZBwXFPeuf2ResXfj1H1XFsS/jP+udhTzVprnXFecPlYpDOEJ8B/4bEUFS3clMmikyjpNuSf5kzHqtizReXzSU1ZsbopcuNAHQkJB6QJYNh3L0jAc3t9apWlxRMHjCxEu+O8z4xvRsG9uecBWe2RNJJdGEQ8T1WIpZFZpRbcrKOf8WL3LojK3tKkYOOnSGGKahTDPc1EgDsee1aT1V8MAPG1lYx2qPaWX4CuTElr3TpWrgUReYjQGYjS2rO5o5VpC7WYvF+xRqA82PHAVQdcaBzB9RPhx5gRhzZUyGd9TXBPGxuvGuFSM0gs5OoCvPn3X/aLbPM4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4566.namprd11.prod.outlook.com (2603:10b6:208:24e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 09:45:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 09:45:35 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	"Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] iommufd: Remove IOMMUFD_PAGE_RESP_FAILURE
Thread-Topic: [PATCH 1/3] iommufd: Remove IOMMUFD_PAGE_RESP_FAILURE
Thread-Index: AQHa0qRS7kBbdeC9/ESgbe0iJcEnvbHvtjbg
Date: Wed, 10 Jul 2024 09:45:35 +0000
Message-ID: <BN9PR11MB5276DF9FD2A752CBDAE522938CA42@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240710083341.44617-1-baolu.lu@linux.intel.com>
 <20240710083341.44617-2-baolu.lu@linux.intel.com>
In-Reply-To: <20240710083341.44617-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN2PR11MB4566:EE_
x-ms-office365-filtering-correlation-id: 8266a832-e459-47ad-8d82-08dca0c50c49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Il3aUPfB2kEZoGr3ZjsSk8dYkZoUoiEf39LQisIP5v41/IDJuhsPmuyzW2se?=
 =?us-ascii?Q?ti6PDYuOdCgg6gWDUgdHqMU1HdRFt1bD3YYw6AEjke4LhEEPikne0iqwcA84?=
 =?us-ascii?Q?Z26mhHy+RF4Yn51ELp24xJVtMpw6+itSjVmXW1pOe/NK9oOrGPdJhbVDK0iJ?=
 =?us-ascii?Q?Vms+zDCYpVE7eMGNvQh9gxqE1fM+lypYL9WwvuqcBJtYg2tU7ypm9+eaThlE?=
 =?us-ascii?Q?MRD8D6VeQDpb3f1MFF6/WZK+jpNyESTOxTCtKAqdkgHfRaz451VIVQ749jCX?=
 =?us-ascii?Q?uuonVJUTQr1BzBIfNHvC7K28BRNy3sg2bRRcfa534z6kfV05qQ5OTzH1CdLy?=
 =?us-ascii?Q?aEqmInaBry5DYhgiQX8ybp1acZq8LyepxkL0RvXRRtZmCv2JLSo4NIXBhPea?=
 =?us-ascii?Q?kmz54al767c79t/wDNxON19Bl7mH5MYO9y9RfhBnMPIRAoVHbIChkCBMPPxr?=
 =?us-ascii?Q?UzO7n2fIQL47L/N7MlmCLicycRQTRdo9+vn9OaJ2hnM8M7tSwI8zyI+TTdpQ?=
 =?us-ascii?Q?QTfTJyXTh5TEVQHfeJ3MUWwtFjGf6YNZAPP4LWLjADlK+8BPL/7kM3aZ7Ret?=
 =?us-ascii?Q?D/c8q61Wk1+vB2oPVtLI1o5qemoefdQJEU+R6wvU+w8xmXLa0VHJItSJbjcR?=
 =?us-ascii?Q?OaQlqhpAh3ecyxYBXaWO5W/5eEJB6K+p1uBVRXzNJ/UsjEexVYe5QvjgqlxP?=
 =?us-ascii?Q?6n2tx82mMkx1mX+b7dBc7w1WF8x247Lzy01ORO6Sm3BQMIvUsBvJ+ezA+/9F?=
 =?us-ascii?Q?Vpkq/skyfHBdfW3HYDChhtkcu4aqwZHGahB69rO4R7b4ZzIUKYmjMzF7eCdt?=
 =?us-ascii?Q?XDvRB2/Cy9TcrWR413DAU2tZtHlPucEiRE0kGzqYgLhYnVHGwKGgVSlaIugk?=
 =?us-ascii?Q?zFNHA8basI5kTi2xxEJitgO4+DYejuXS+HvszE/DHn/hTK7tx80D8ZGUIQ9d?=
 =?us-ascii?Q?bOenCLTYzCGH7T4S0N1ARiwBSRUqZ37D5I5fWEnQ+uB4ZNzhKiWpgPItOuap?=
 =?us-ascii?Q?Dkwi7evpg/4esXjVapzmwxofb8GuQ1WGoF+bmZPUYShf5k4ZfekCEVn21gGt?=
 =?us-ascii?Q?Au7OLH7ShFWXtxlmsgULXMatyfyXtMeTzqTgiRwiw6Ar3j8arPDdRPDkBMwu?=
 =?us-ascii?Q?vrt1IirThjhvsFI1HzOIZX+gUHSqYiblKyAMM86knFHUiXMFpvWVPQ4e5pTz?=
 =?us-ascii?Q?dr9PRw4iYZN0DIXPDHHcS4DZbUh4ExwQ6HiuWxyFXcGY0of3SggAEIQ9v3WB?=
 =?us-ascii?Q?ZgPD2tWtoUf93Ao54b6MGTSaPWeR1JVWIdsqmhKKbYTqhrk0S6IvMmHdyn8u?=
 =?us-ascii?Q?bLbt4H5/T7djYNiE4z9c3BLa6ibSqat2HF0xCdQW8zoXmG6Bvlh9l9IPu85d?=
 =?us-ascii?Q?ZtX86hjFblH+xyVdzXx8hJGWa85a3UGGzQQsXFJ9P8PlCrfh2Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?earIBDK+G9MDcgNMEsmkW13g411RQN4doQcUrK6GkfkLTvCrDUmsrbB3pqgt?=
 =?us-ascii?Q?HFDUooYCj4tPgUj5difsGy9otZW7+bdhPeTb60AQUv6I3CNLbgmKIn38AdHS?=
 =?us-ascii?Q?AMpLnCHDxA4rrZs8ACpnF51oOrMq2GFkFn1XjBMZulBNtcbMWvXt55s46yTH?=
 =?us-ascii?Q?kyjouDI6p/Ushwy36ZXErS4xQIV5frz4W1CGN/vmL2SClKODFCkMiazhemSD?=
 =?us-ascii?Q?X0M+Pvq8OVpA6sj3/6RHdg5pbTXPMFDvRIZ/uHRLgrP+1vvHuq0ODIppLkEy?=
 =?us-ascii?Q?aY6zy/mQdtzjumgzugvshYEFC7tIvtqCfps88vqFN3evWl03VQXWmSVz2bQ7?=
 =?us-ascii?Q?uk538Cnl540ie1VooKxjycT4YEz7TLTJVB4fBYLe84j8nG63/zmEo8Q45/kw?=
 =?us-ascii?Q?icJTwzD0+Wkf0lGjd0XFgOS3dktJGaxIXCBZL6baaNPUnsnYzJ3xn98hIfhf?=
 =?us-ascii?Q?wM+Ne7/uqO5R2MwduV54iky4bgXjCyjTItGNmF+hoiKnchWYOs5xZlQLeerR?=
 =?us-ascii?Q?s9ADg+2osH+2yLw+StESOcHlTD6R2C1+5G6jK2IVrS1hRc2cr5twp+eCYMQ8?=
 =?us-ascii?Q?mSTJf4H/c0kKHgZ0M/tlcTlX/a46WTT+GeduMFaY+0BNCbzAMe/9olMufhTQ?=
 =?us-ascii?Q?SpbZJC7KEfdZICm/ZuW+EcdQyfHPuacPS86/H9qF5on/Pn5b1sjHY+GIaMfe?=
 =?us-ascii?Q?6i0S9mPjKBL5WfGYBo9ekeaQv1RpDNZBrkg4d3qsGB6oZn7Moq9KP5uX5MYQ?=
 =?us-ascii?Q?PtSSWVEHv2UM71yZmxvgQsTOL0LCZ88zPHdYu56aK/leMtF15tZMy09/BMTM?=
 =?us-ascii?Q?+rIGT+S7twU92rSfY4xMDtCuTrJLb2iO1DYnH0R6MagtsbxKQm+Lrc+Vm0NV?=
 =?us-ascii?Q?N8ESvCs53Kg3WDT285RwaLFGojYvySu3MARdYxZRq0fHOJef4hTibT1ADOGj?=
 =?us-ascii?Q?nwN0Duxg9EYuStid9tJxvLWHFkqGSBcRrfSPwAuAGjafmFgrAuX7JwdeLvlL?=
 =?us-ascii?Q?Col0wqABLPlrpU1fgKK+MIyDjMeQ0lP2iKL56LvLi5174auXwVmHj59QZUC/?=
 =?us-ascii?Q?3gCZFhpPKIuWKa4GxxY2GlRdFE9Nw492bnWdscMXkY1TcTeppLcH1NZUf6Or?=
 =?us-ascii?Q?2DJ6uVFJp32BmlhE+ClXg2rcNuhXec451I3dfKF41kk04KedJ0xrRBjfgcMd?=
 =?us-ascii?Q?0FoByeMEYeKO8+LszvZbAFyIgXp4JbjA/MbezKJ9Hx/kqRvk9XsIugIrdnF1?=
 =?us-ascii?Q?LeTNd+/Y9sAijrgRhdbHBzaKVIW6PJI6cxfm1OmZTfCeA1jlgcYOu8HV4lLJ?=
 =?us-ascii?Q?bcLPMl9+Fpvmaz0XBWJOsKwZRkNejsIgW1+I7dpm6pFlkkhHIicuSBB0QK1b?=
 =?us-ascii?Q?9GBTuhD6evTwOCB1oa46233+zQmldjBe9Pixe5VpQwuZuqvLrp50UsgDhn2p?=
 =?us-ascii?Q?NVG6hzLwE7pQOxzdgfUBPr4dS5hYYoYJtK94hROs5MLY3x1aqjs6RTKOOYsq?=
 =?us-ascii?Q?SkNnCzhsI3+JPH183dWhU/gKzCWFeGFi/WWZzoGGP0+LiV4/7rF04nizEouf?=
 =?us-ascii?Q?VgbXxlEV5clEo1ksQe0WyoPUIXqtLdgrKlg/b7ta?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8266a832-e459-47ad-8d82-08dca0c50c49
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 09:45:35.4409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XPSTyIf8KeaAvrri+D9AmxqpPO54GhUG6EomIywnHfMe8FkNWOkguK6f6IGqE5afmhwbhQEz3SbgnL6MYbjbwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4566
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, July 10, 2024 4:34 PM
>=20
> The response code of IOMMUFD_PAGE_RESP_FAILURE was defined to be
> equivalent to the "Response Failure" in PCI spec, section 10.4.2.1.
> This response code indicates that one or more pages within the
> associated request group have encountered or caused an unrecoverable
> error. Therefore, this response disables the PRI at the function.
>=20
> Modern I/O virtualization technologies, like SR-IOV, share PRI among
> the assignable device units. Therefore, a response failure on one unit
> might cause I/O failure on other units.
>=20
> Remove this response code so that user space can only respond with
> SUCCESS or INVALID. The VMM is recommended to emulate a failure
> response
> as a PRI reset, or PRI disable and changing to a non-PRI domain.
>=20
> Fixes: c714f15860fc ("iommufd: Add fault and response message definitions=
")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/uapi/linux/iommufd.h | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index ede2b464a761..e31385b75d0b 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -765,14 +765,10 @@ struct iommu_hwpt_pgfault {
>   * @IOMMUFD_PAGE_RESP_INVALID: Could not handle this fault, don't retry
> the
>   *                             access. This is the "Invalid Request" in =
PCI
>   *                             10.4.2.1.
> - * @IOMMUFD_PAGE_RESP_FAILURE: General error. Drop all subsequent
> faults from
> - *                             this device if possible. This is the "Res=
ponse
> - *                             Failure" in PCI 10.4.2.1.
>   */
>  enum iommufd_page_response_code {
>  	IOMMUFD_PAGE_RESP_SUCCESS =3D 0,
>  	IOMMUFD_PAGE_RESP_INVALID,
> -	IOMMUFD_PAGE_RESP_FAILURE,
>  };
>=20

It's probably good to add some words here for why FAILURE is
not allowed.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
