Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110D43E47B
	for <iommu@lists.linux.dev>; Wed, 29 May 2024 02:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716951497; cv=fail; b=ICUf6aT3xdNZYBowSbnVdBNqD2PNnKVR/wu64v6l7Kg/AvLhYnIrF4cWxi1yJydUBSuDMvQr9zy/QRiVs+kglUiF3IL1oOY2B+flK1qRLcCrM//3qYuD0E5Xewm2ajwfslp2PctfBmAK/qo6+wmismT0FqsJ7gJxPxN2D3aX+9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716951497; c=relaxed/simple;
	bh=tUqVgA5rQdcjdnBXOQiiVYP/l0sx3bfi68ABJeF54Vo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sn7KxilIhMrDGJnggAe9vVDHOJ6f498SPwljmnka7/nN1iKgQmvcV9FlQavdgexgoMP2NxnlJN+49gxmjB/ulFu316LdQ5jyqC2rKzZjWqA+G76YLDBNXUJBSw79KcbIDW8yLEKbxEN4dAn2sChZRTaNTfughRx4Obtznm2WNy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T54z3M1H; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T54z3M1H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716951497; x=1748487497;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tUqVgA5rQdcjdnBXOQiiVYP/l0sx3bfi68ABJeF54Vo=;
  b=T54z3M1He6KWMvOkmE3buOmqIFVcBfvgX2x3RtvUAD2lUyp88l15WOOx
   hzf5qw8AU5xm0+kRhB4YQwFljUb5vbk4ERGzzln7/pBHwd4k3ZB3T2HWZ
   OAXt2zMadehiSXh/qVoS8+VokdshSViIAB0+L5ODlmTMBlMNyRV5vTj86
   RpNMks9BfLJb/FAINTYRoTI7hh5uAvZ5jdqmdgE4piLnsPkOtAiiIsu4s
   5/6g5TlB0ZSr64otQqmMQXJMCvgej60s29vWTBGorUx8enO/9N672maI5
   t+miOQp0c4XfE6stpYibdY/bPBTO7jzbeRXUmhrfwAvCgrjlhM1Q/uB8e
   A==;
X-CSE-ConnectionGUID: Wg9F658jT9mh3jGHo77W3g==
X-CSE-MsgGUID: VZu9U1W8RyaG3X0dypg1oA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="17123372"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="17123372"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 19:58:16 -0700
X-CSE-ConnectionGUID: TtEjXlBDS1ic0zI4FDmlYw==
X-CSE-MsgGUID: Q8NvO72cR1qN1q9zQpQ2Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="39708316"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 19:58:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 19:58:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 19:58:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 19:58:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 19:58:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H73ZUHqUguhxIEzNHvhrfrKTqxlq4aLJVu15cuvgH2ApmOqZh+WaZb9eAZSo/R/QSpW9ecFiv8MWAOt1OzjT+2lmcZ5EMX1zFWcpOeK3bGzTWYGgG+cVad6572gRmf2xKIInV+kgdLvonqAET6qRjw0H9fHQQT8SSbmwgMLKkq7LfpjK/Xmi3JZ9q8HFYMB/0Pc5r87hQxDCK81uzYnTifKg/Z1En/oqw0Lk/0Ag9785g525U6JHSO4Kfbt0jCZsJs4lfQ5QiAGTJzs4ReWu8y214WleIDXk2oIr+3bHw2svPBTm+qsxwZ3iYRDuVawmx9fi6dVoeUaphNJmDO3uPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKCkgoyf2DGVxWiUe5wm7exuVAx9b8ZV0yJ49qN2fxA=;
 b=XQtD2MCbKlE7YEu5BZ9rYur4urDFZJWnYvne/8uUdSuEaRyvNjiQtFggKLPXoOhJmqjjisy2RD2UC1hhkDvB46HrkL/bUUy7QoRSo57qd2M40i3KJsYdZKHUmt8RUc+niOUizSbpSXl9rLYxifcP605xYTVV8Yf7ZE7opRS2t/UJb8Jd8d4MHhmf2yl6KEpGBhFyqh5XlTtm7sHtHKKQyG2ZAcArCfqD7eOInUArLpie2oxazi0YC/zuQQ4F8nwv2PP1J2bPtMRNmSRiBJgfoucee/u+9V5Dz93SxLOamkCiiIy762GjzBeivDAGB52wuWeLj80wIVtaZOsQLgIuiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Wed, 29 May
 2024 02:58:11 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 02:58:11 +0000
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
Subject: RE: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Thread-Topic: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Thread-Index: AQHajVVl26WkVBqVE0qDV+tml8yTY7Gkmr6AgAGEQoCAABbGEIAAaX4AgAPpupCAAtXxAIAAbUsA
Date: Wed, 29 May 2024 02:58:11 +0000
Message-ID: <BN9PR11MB52762EA9B444DA71F551C3868CF22@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <c97a98a72ee3498c587e5898d6b899553ccd9b27.1712978212.git.nicolinc@nvidia.com>
 <BN9PR11MB5276A897A5386DFAC9A35F9D8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlAoN3s96HL7ROth@nvidia.com>
 <BN9PR11MB52762A0BC67B64D4171480C78CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240524131912.GT20229@nvidia.com>
 <BN9PR11MB5276BBD592021507C3A0EBB38CF02@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlY886FT3HHLC8Cf@nvidia.com>
In-Reply-To: <ZlY886FT3HHLC8Cf@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB5163:EE_
x-ms-office365-filtering-correlation-id: 027302bb-9e78-4b7a-ff15-08dc7f8b2d3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?ULSYMMDMIaBHGLFSVEwb1s13KhRnpF7usjNl6Nk1TFJyJ1iDSZqRQmSsFk7U?=
 =?us-ascii?Q?6HbGyOJJmxIP5gOlZ7yqz1qmEHZyp7xsqQYNS3mb5fHS5A28Zs0yKmU9KNJF?=
 =?us-ascii?Q?CanmAqzAp2azq8TVvYiGZNQfQPyKYoAdVmYtAGDOnSfxxRR5SnoZOtImTIiH?=
 =?us-ascii?Q?ojwCii+IkSjnuppozN9NRNrp+HBf1115khmVdFl3LgdyDtofxIRAQUL5gBQ/?=
 =?us-ascii?Q?dU4TvrCm9d0kD1nrwt7Y18Lnf2VdA3jN54Vm3AjeDeLLNHWujl3UfT0QiXUE?=
 =?us-ascii?Q?Xooz1CW/+AxchqDL8rSPqWnzZGtzRriNlfHWwIxwMsPoClx2poZqX41IiJDq?=
 =?us-ascii?Q?ZPL60AuF/lw877rq8ilc5vGOYO3+exlKhcaTv+ZB4iZoyTANpXpdpuW9glR/?=
 =?us-ascii?Q?EwIij1yjo3AmrX+no4RO7gJktEJ77B1iR0TYM613H0MxOp4w7J5GRLwle2/U?=
 =?us-ascii?Q?YYaD0v9T3/IPb70Zkxo72+AABl06WCnv9lw2JsmuRy29ckqkAbBDNiOq4Rze?=
 =?us-ascii?Q?T96G9jojtsy73sM+J0gRVkyCkXazqg4wCwS931E6/ga2V1h929UetGuBDxPD?=
 =?us-ascii?Q?6yyaOMKxj17XNM5mUDP0Xnpjhk7TTciZ3+o/zlOPUM3h8XPI443qeihwXULd?=
 =?us-ascii?Q?ffv8bqy+HWDraeIDh66xuiUJ0DHp3B/ia5DflBdhA3CFANGktD2YiFdFKGTc?=
 =?us-ascii?Q?TPDqppYEDQx4kt4ynmdkVmJttjiJq6NKLCtfmtPwBjQ38n68sq5oNuwL2Aw7?=
 =?us-ascii?Q?5uJtp66Pl/bakOA7OAChCG/ZSRuvonXAvLHoLNXqCMT4rTWYOHS+DO1m5mYn?=
 =?us-ascii?Q?pqYhukbl92tPlxOhXmZRusNulDLWxv+hp9ZtRS5TgqzeZ1E+ALbYZseFwvmt?=
 =?us-ascii?Q?n5pZKY1HMgZxleMsMUIGtQjiKht4UjDd41p6JoVOZoct6UU5qRiR7g6jDXzT?=
 =?us-ascii?Q?5eIZvXJ+MopRc4uFD1T3n61qkeI8duqUq2TS7wgi70dYiu1j7fPKtreN3A5F?=
 =?us-ascii?Q?esY1OfE+TUZXmBwB5C8X6Zv4n8bBC4go+NoD46sUXXKr1a5fiHHf2LBe3kvq?=
 =?us-ascii?Q?G4CAZTYKjMZdrW/sXrql7cgjzWRQdY+CiNmMfNAW8sK52e3ZJsKr/2aNL6m9?=
 =?us-ascii?Q?moDoO3G298mSjuxMc5D+d9edw4hJACj5+JKHL7b9K9iL8FXur6bUNg6Xg8AR?=
 =?us-ascii?Q?tBzS0dv/PLJ96c12i+bf55EIwtpWFSIPpfVGdty0VUHYzgpHuIgEmF/eLWfm?=
 =?us-ascii?Q?FhlqHUTXf5y+HBZXQP+WOhTzde0W7hc10hyYttyCqNQ2J8OY6rqWaluQv6nn?=
 =?us-ascii?Q?hRbXadTigjBPL8An9bg+CN9WhgzDCRS4WfcJ7oRvzrS3yg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RVYm1IehQnzZRF1Yijw1StnFS72sZ0/Y7QSUACCjdkTtf98Dw2meoXnIRcUn?=
 =?us-ascii?Q?hgjgsS4WYsWMVtimqlL388amhIRGm1m6L2Lt6KiXnTMQ3bgWhpNuVkSlQPKv?=
 =?us-ascii?Q?cLlnOCCQTgvJJIIKOvRDRbYz5UPoUqhp2DyPscnWv4AWiQ5qq4qGd2TRzvRZ?=
 =?us-ascii?Q?5nUXVvOoDc7R/zCEiCT5fq38imLjWVmRMP1qvaPzIowGmuMLHpQ2N1ORRECa?=
 =?us-ascii?Q?AuAMrwLPkWST/CU28RLtLkx2k/deL7DTIuIwXjQG1F2lTgaKVpzgaK9IHhgW?=
 =?us-ascii?Q?CfeAYtDOpM4tzmf9xWDgtVnLv5mffCtKf4gEf1EsYdMAo/QuH43tx4hDbxxu?=
 =?us-ascii?Q?UWAic1O4uCCWjSR2xAq4889rrtyIHhnDI9uEe5VSrML4AulN8LJ3hS6OMlIL?=
 =?us-ascii?Q?zwR5Bzh6WdIZZFj0JhDvgazVaOGrVLX8X2cPT0tBi6YIO2Q2vR1AkKt9162u?=
 =?us-ascii?Q?xK0ui1NdzQJF8SBWxI/DvOUUNZVwkJ+Njf7R7umSNIAapLfT9TOG5+V0nTfb?=
 =?us-ascii?Q?4biKEkZ0cK2+236ZzaBpJ09CvlGxG925Wwdwlhnuxz8AihSUZYI5kD42/hUc?=
 =?us-ascii?Q?G/YeOI0VHdjMCsRwnXp4ehegmE6nL/yOVkkIeKecyM/E0iOYODJ4qKhAkY25?=
 =?us-ascii?Q?mwTdVjJeelrwJqdWOeZhdF0X4QSk0QuDzIWv4Gd9/DoSR7MTBGizIMW6tKYl?=
 =?us-ascii?Q?s0dc+rs9bT9H7Iux51o3bmyfK8gYyapM+NMaRe5bx/O80cT3g33423IKWfHW?=
 =?us-ascii?Q?qOcKdWv5IqAEjjcHDQMHqFTLE4P7R5cQG+U0KZcENScurzDjOoY7PbScgQUm?=
 =?us-ascii?Q?JpqUtrwDc+cRYreSAw3e8icb44O4YrerB1ttzGii47zwR9WEcZfCWmWxaIMR?=
 =?us-ascii?Q?E/iNk7wd9+2MfzMW2PNOnfgXUJDJ0GwuT7O97TBSkBxy+cxmPKqa1vlUBzth?=
 =?us-ascii?Q?gSFBrOHGwGsrfXm30AwNBbO9ei82cjYRv8JGmJ65xEKzCmEsNwloQYCs4ULr?=
 =?us-ascii?Q?ubHf772JqoVgcvTS7MSMYEnmkRbvVPOslOyeSbUuy5dXiAxZ0A7Uf9/9OqjM?=
 =?us-ascii?Q?sskZzYT9PpfSWa8jtnkN1ugzaZrj5GNnXGR1nRcAeWvdenzrnSP2D038pzKk?=
 =?us-ascii?Q?S2BF139OHAX884hRHucdAnHm43U4IbuAiI6scaUDEXHsJnrf0EGfZghtf/Lb?=
 =?us-ascii?Q?DzfupMGBmGwbZsOPbeqwyctgdHIvO2c4KUFv4Jb4O3QHEFlL9qT1v9A4aHub?=
 =?us-ascii?Q?JebvAc0RamdoMIH0pMjwFNcfKFQ/VDufLs9QvYYgOdY8Vy/ynwxK2BKB3De5?=
 =?us-ascii?Q?+MWkineR7pNiOZAbIboOUUvJI/S/bnp30y1h04opZVSO/JplM9N2XTT6rUpv?=
 =?us-ascii?Q?v5BtmZKQc4DIIrdSt+419DbSmrmjTwUvQj807zC99guGCKDGHKAQP02RWeAq?=
 =?us-ascii?Q?kV6Sz3QXj0TfXKh82cC3hG3Ll+ZDpvQJi+ZH9gMpd8ObIMnB5sxgSW0BXtNF?=
 =?us-ascii?Q?eeMAUlr0J5+FBGFKI7uy6L6uD8PWsxQFeQ9S9KTYNcU2X4YD1uY2RokYom0A?=
 =?us-ascii?Q?NI9dM/GdP3+X1KbzGPpp7J3KBuyMBjxle62/aIe0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 027302bb-9e78-4b7a-ff15-08dc7f8b2d3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 02:58:11.6001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SYSW5gVTcnWSiBmY+a91AxCy4fK904Z0QD0sQQy1qplnoESOhyzP+7ywtZYJfC/wBi1/0HeDUFc90L0r6q2AqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5163
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, May 29, 2024 4:23 AM
>=20
> On Mon, May 27, 2024 at 01:08:43AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Friday, May 24, 2024 9:19 PM
> > >
> > > On Fri, May 24, 2024 at 07:13:23AM +0000, Tian, Kevin wrote:
> > > > I'm curious to learn the real reason of that design. Is it because =
you
> > > > want to do certain load-balance between viommu's or due to other
> > > > reasons in the kernel smmuv3 driver which e.g. cannot support a
> > > > viommu spanning multiple pSMMU?
> > >
> > > Yeah, there is no concept of support for a SMMUv3 instance where it's
> > > command Q's can only work on a subset of devices.
> > >
> > > My expectation was that VIOMMU would be 1:1 with physical iommu
> > > instances, I think AMD needs this too??
> > >
> >
> > Yes this part is clear now regarding to VCMDQ.
> >
> > But Nicoline said:
> >
> > "
> > One step back, even without VCMDQ feature, a multi-pSMMU setup
> > will have multiple viommus (with our latest design) being added
> > to a viommu list of a single vSMMU's. Yet, vSMMU in this case
> > always traps regular SMMU CMDQ, so it can do viommu selection
> > or even broadcast (if it has to).
> > "
> >
> > I don't think there is an arch limitation mandating that?
>=20
> What I mean is for regular vSMMU. Without VCMDQ, a regular vSMMU
> on a multi-pSMMU setup will look like (e.g. three devices behind
> different SMMUs):
> |<------ VMM ------->|<------ kernel ------>|
>        |-- viommu0 --|-- pSMMU0 --|
> vSMMU--|-- viommu1 --|-- pSMMU1 --|--s2_hwpt
>        |-- viommu2 --|-- pSMMU2 --|
>=20
> And device would attach to:
> |<---- guest ---->|<--- VMM --->|<- kernel ->|
>        |-- dev0 --|-- viommu0 --|-- pSMMU0 --|
> vSMMU--|-- dev1 --|-- viommu1 --|-- pSMMU1 --|
>        |-- dev2 --|-- viommu2 --|-- pSMMU2 --|
>=20
> When trapping a device cache invalidation: it is straightforward
> by deciphering the virtual device ID to pick the viommu that the
> device is attached to.

I understand how above works.

My question is why that option is chosen instead of going with 1:1
mapping between vSMMU and viommu i.e. letting the kernel to
figure out which pSMMU should be sent an invalidation cmd to, as
how VT-d is virtualized.

I want to know whether doing so is simply to be compatible with
what VCMDQ requires, or due to another untold reason.

>=20
> When doing iotlb invalidation, a command may or may not contain
> an ASID (a domain ID, and nested domain in this case):
> a) if a command doesn't have an ASID, VMM needs to broadcast the
>    command to all viommus (i.e. pSMMUs)
> b) if a command has an ASID, VMM needs to initially maintain an
>    S1 HWPT list by linking an ASID when adding an HWPT entry to
>    the list, by deciphering vSTE and its linked CD. Then it needs
>    to go through the S1 list with the ASID in the command, and to
>    find all corresponding HWPTs to issue/broadcast the command.
>=20
> Thanks
> Nicolin
