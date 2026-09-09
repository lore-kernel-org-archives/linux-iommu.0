Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011059.outbound.protection.outlook.com [52.101.57.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D1D5632B4
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971037; cv=fail; b=dlYIoI+0QQuav+zpPyShXSxcM+SSLTWyZkHvquppUBLYxukAPpbDp27BBBCq1dAYD3WHU9Yt+8hdcnF3sSDa7ipxv7bZ0gATbPMYVY89RzPWCuk6aHY8Gvyo4La67JPn4YVWxZhtzYSY4ikIXQU1AEg+M+CCjnyexKDo9ugAPWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971037; c=relaxed/simple;
	bh=m+CvUWocctQff26MO0ph9b56cq9jkKmMdbvtSQQy6jU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 Content-Type:MIME-Version; b=A3tFu1fiedxmuYHUAXsFIKuE+JObGFRG5rqTSg4PS5gFYW1ujx26xqCwWhIPhGx2sJu9t0SINqsNgbMw/BhJ9H2bCHIrVxDAWNILZBQnbboJQt8GVZc31/WpbLoX2JSax2uCVqa5GqT1KiXZ8wym2O9VgYkSv9b4LEPqsE0HeC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fFeoI87q; arc=fail smtp.client-ip=52.101.57.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fFeoI87q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNhP0ijQmRjC68G84mNo18fE/0G/yzOIcH0zbiRFb8OBOe8lGyrqH64sro0Djn3X2CS4HF992o7ixLqsjo7rncO2alRMwX+dBkYNzHhQNGvrMgbgNb4Y8sNxFTjCMHdPBX6aRJXbEIB5YxPkr8fmdF56mN4NApyqNUmuDGetyVlfVWuqf2j5osmrpUI4h1F644vfxvD+8rggwYXvazyE0zVhS5L7jWGLOW1gVaoIL+4E7VL+aSN1Ccz5gDlJbFBTcqfYffzemy+EbcjMECo4oBhcakRCc25lAuIAIF+jwZ/aPwLkPEZ/ghS3r9t8YDNWpWD+fHWnd9gQadkq6WsD+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6Kj3Pmo7DEX8km+a+ZD54uq3OxZjTCSOsjjU2njMZU=;
 b=p1Tol+ocCRufmIN+iq9zeH+iv6EMjdHdbODyKMU0lp5NJwdASo0ZGtJI0W2g3CsvLsLgILIuvJebAEW/YmN+6FJk7vbcc8OGBrUVTg65/ear0XADt3K3einxakYr/2Mx01cWR1Erq8ychcgUkeiNTL0nqKUdHQyO91unVBgp17mYLdlRVUPJeyFKQ5i36yc3cX55gIy9sMnG7yiELPXeVtDrC6gg2XL/jn8P/6HSL8DiRXmQ0t9YQ5415VZoq6WNFNmryL7PVqU7rjFh6XAsFsMkPbnwvq5whGbebRvwEbUiKZg5Y4AOeeNPokYCTyWIhbjILaUclUeNlCslBcePIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6Kj3Pmo7DEX8km+a+ZD54uq3OxZjTCSOsjjU2njMZU=;
 b=fFeoI87qiik3p+x6J5EbQab8Ns3rX2GpIvjTfTEw46b2SLsEtWOrT18iobKCIVbOja5vg8nXLXWbPUUTL+bMdjd4cEnlzEU+RUdqh44yDVDcSHPgRR1zpnj7goU4piw5YR7lVgMJ8fRBzcQW1M2MVt3+ZQgMt4p6y5juF9xuSkz5C0/6XOwrAgYQYsf9mlwjfJMnMY9pzQ5/4ZKg52r8aBeNcq6NCfZYjcoxCsMEwz4PMaoWgDgctUHozG3YOuBVf5NR5gKDKZbYXX4BcEZxUMBfz4WiBxUcR5Oc4qZZ2YxPeth+CKxN6yqDdGWTGzOAPd4vRspZwzrTPSBOzPMgmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS1PR12MB999188.namprd12.prod.outlook.com (2603:10b6:8:495::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 9 Sep
 2026 16:23:50 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 16:23:50 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, 
 Qinyun Tan <qinyuntan@linux.alibaba.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 yeeli <seven.yi.lee@gmail.com>, Xunlei Pang <xlpang@linux.alibaba.com>, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260902085414.549830-1-qinyuntan@linux.alibaba.com>
References: <20260902085414.549830-1-qinyuntan@linux.alibaba.com>
Subject: Re: [PATCH] iommufd/selftest: Return dmabuf fd from
 IOMMU_TEST_OP_DMABUF_GET again
Message-Id: <178897101778.4136580.4406767534752203628.b4-ty@b4>
Date: Wed, 09 Sep 2026 13:23:37 -0300
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BN9PR03CA0682.namprd03.prod.outlook.com
 (2603:10b6:408:10e::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS1PR12MB999188:EE_
X-MS-Office365-Filtering-Correlation-Id: 933b3544-5837-4977-3d5d-08df0e8ebb38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hzmQlvqqCFmbSW2WgcoTC49z+tUyWnNG6gxlaYG59DT8DUe60+IKTSLC/3xe5+pU+F3GEyol7+tlJUoqOg7fa8tKEdNOaiNiPGNWjoWnuMRVQgT8keEsKwKu7hdC8y5z3iCCFFZnkWcmkoYhfEtyt3srHES/PPEOZcLjZ1+KB7voyoljnWlz0ka7cWtQODn5ZjTcQDMdFSTtgHi74XIQ0QX6XbSMry3zrC1TMVf1Uhvh6y0mZ+td82OMSfPNbCrwT1rsS6ea8aCXn5c2QsVj7LGkTU99M3d8JHGHwA/itQE+f/iEqRo2QrUH1acpluzaNC0ch4tWMRKxDdJPSMdse+rXCNhqdtWTK+E3kM8Ru1Szk0si1i1VirtFAlZQuLKqa2buc1DiVhnU51PC5EdwVnpXpmU9+8kghRxFoUu4bNDpJLMnL+OArjwb5mD7ofkAt0oJ98KZwDWMcXhN4iM5/Jr8RODwIWG/BIb9zvIe10tGqykIcaS9spue2wsOPl1RDHEQqJuztJ7+N8pkTBJ0spTWnwSz/zIGPi61gZvrEQaG/YyRJuEpK7gtluI+qeJFigvHYNUsvpGibVT4R7fjXpZg92DGhf9otU+nxeexXoUyrzHe8S9G4cgsnBZWfcWF6kx6H4MAqVnx2jt0xH3RR7u4uY7il2I1yssnA4qwz4A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M09lT2I2WDJpS3hWc2pWMEt0Z0xqc1k4UUtQS0p4eG0rMkUxZm8xbVVBaEl5?=
 =?utf-8?B?L3E4Vlp2Z2xPdmtOWTJYUXVoVmNidi9aWjN1cHdlUjZKcVovTndBdGVDb1lp?=
 =?utf-8?B?OWlTUWcwYmVxaXk0K3dJdi9iMkRlQit5elNSVUJ2MUVWSUY2WWN1NHdneUFC?=
 =?utf-8?B?Wm5PdW02RHE3SFRacFI3WmQ0V255SW5CUEhoVHdYMytLUWI0RXV5eUgveDla?=
 =?utf-8?B?TFN5SXl5emRqcFErdGpCd3lDSXpjeDhqZ0I1OGlka1c4SVVsOHhuY0REUWUv?=
 =?utf-8?B?TC9WOW1QclRlRklYQjlIa25OVlRqVzV6aHlMSkJhbWJ4bEhGdDdaSThXZGFL?=
 =?utf-8?B?SXFkL2FYdjBUTi9wRVVrdXUzUG9TTjY5M3gxTUVTTnZranNpRERIcFM3TnU4?=
 =?utf-8?B?RUdHbWlwbnFsY21obzMrZDdKd04zMFpkeDVTVU93YitTMFVqVEo5UDMrcXdN?=
 =?utf-8?B?MHd6b1BqaXhoTDhZTE1xOTJYVi9SWUVicC9CZ0NjT0pWZ3piWFJnU0pOVEJo?=
 =?utf-8?B?bDkvUytxQ3VTSWF4SW0xRmFNd1ZrUU1vYVZuQmNCZnp3alJhUXNQR1BESGJv?=
 =?utf-8?B?UTJ3Z1ZaeDJwczlOSUxFaDdid0VSTFpMODcrRTZJemxWV0NSVU1wanJOWlF4?=
 =?utf-8?B?czdPcjlZN3hndFdLTXBxbVEydEZVYXN6R09UeUhKSTlTTE5wcWk3WjNrQm5R?=
 =?utf-8?B?c1hIS1VEa2hGQlhlcjErc0NPUEFZWldmdStxUzFWYVFsRE9iUmo3OE5jYW5D?=
 =?utf-8?B?S0NpL21oa3lpMm5SZU41U2JsWHZxcFVJRzVRL1FyM1g0QzA5QTVSMWY4VVBL?=
 =?utf-8?B?a2o2Vk1zMUs3QitGSXdSRWd2L3ZXZ09LaCtmVGlUTkdNSzdxNmVVKy84cDdQ?=
 =?utf-8?B?VC9RNFRzZWw4MXJ4MGlYUGhBSGxZNnpOaXc1YnFRbGpHNnZMN0hjSk9Bdnph?=
 =?utf-8?B?UU9kOXNBSldDOHpqZ1N6SkM5bzErbzZTY2t0KzBCcEhOWE1aWEVta3ljRW83?=
 =?utf-8?B?dC9acllEM01qYkl4MXRId0JCMnYxNEc1UzR0c0VlL0c2akI1YUdQblFVRlZm?=
 =?utf-8?B?SkFSUlZZL1dxRFlVZnJwNVRlcWtYOHU1SzJjUXNmaytnMlA4WmxLYXhlbWhv?=
 =?utf-8?B?TGQrUVdyd1lzcCt5K2hkNDhYbis3aFcvcnU5SzB2RkpoMUlIVGZDUmIvRzZk?=
 =?utf-8?B?eFpaYVpYSG5zRGorUERzcWZSc205cnUzZ3dkbm05cForNnVqUWoxKzhzdTRw?=
 =?utf-8?B?Qm1OQ2ViZ1hHRWVCOTlSbjFHWnVySUI0ZU5JcTFjV0dpZmtVbUp2ZklUY29I?=
 =?utf-8?B?bVhFdjU5eUtlcU9HY2FOc0M5S3k2VXdQKy9GWUgrTTYxYkpLMEhvd2swdk04?=
 =?utf-8?B?bWN2ai9GMEVvYVZrcDE3NmdEcTBTcVA0bGZSRzF2NDFISG01UVJWOHFmelpv?=
 =?utf-8?B?bzI4MTVGeUJhbEtQMmZIL1I4N0xkY01rWEtEeUZwblZ2SG55SW42cEFYajBp?=
 =?utf-8?B?Z1ZlL2U1M2Z3ZkdYY2lWb1BzeEFzTDBWczVLT0lhZnhNNFhBSEszcm0zWVls?=
 =?utf-8?B?MldMUDVxNjhnYm5YcHZpanBuQVZYb3ZDQkpPaWcxYzBtMVNRQWxWQTkxNjlD?=
 =?utf-8?B?SGw1Q3JSeTBmKy9JMnNhWEdYeVRCTEwxQWt2eC9GMk0yTmg5NGJ0Qk11K0FI?=
 =?utf-8?B?dXMvaXBYV2wrRFA1N1VocmRpYVVFWkpLSGRjbnR2U3pLNlFQWHFtV3NRa0hI?=
 =?utf-8?B?QnNHRWEwTFJxMGtYU0hPdHdNTHV6L2FuYWlRVE5BRXh2MmZsVDF5MGpITzBw?=
 =?utf-8?B?Ui90Q2pza28zQ1NUUWFGb2NSQS9rWFJVV1FnNi94bFlCeTVGWnZnMG5NRURx?=
 =?utf-8?B?cTQ4ZlJzNElXdjhWblk3cWJDQ0hMbWJPZ25HZjZwZ0hSMnZMRnh1OWlSemVu?=
 =?utf-8?B?Q1NOVnhnZEljRzZnWk1nQndSMlpRZWJOWUFKUmZ2RG1YSyt1VE1hV0p0TFhW?=
 =?utf-8?B?MXl6d3lCclZmYmdLeEI1NWV5R0VTT0lGc3Frdk90SUc1Vm5SZUdnc1hUU3ZZ?=
 =?utf-8?B?aXp2L0JRT3pqczdxR0Z2SXlZTmsxS3VzZmpHekx6R0xTc3VuSkNSdUwxa2lK?=
 =?utf-8?B?ZkN1bXFmZzNvVUpDb1d2QjhWR3dxbzRTU0ZCcmVUVTRzdU5SUzR0SWhZRGtz?=
 =?utf-8?B?WHdrSG83WVd0MEJhVDlvdE96dUVoQUtRcEI0KzJpZ3ZzT3U3NiswaGxPT2VQ?=
 =?utf-8?B?R3RSbHBGcnVFc2NwQUNOdFdmU052TGZJSjdBV0JJYnJvSHh0ZllNYmR5VWp2?=
 =?utf-8?Q?rSCDsheaDyuMuWKsc5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 933b3544-5837-4977-3d5d-08df0e8ebb38
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 16:23:50.0926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJuNa3BAjvEiHd15C9n5jjwf9sTjANTrS2gBKoRMSOoixzSuW+E9+yCGhdj3MAES
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR12MB999188


On Wed, 02 Sep 2026 16:54:14 +0800, Qinyun Tan wrote:
> iommufd/selftest: Return dmabuf fd from IOMMU_TEST_OP_DMABUF_GET again

Applied, thanks!

[1/1] iommufd/selftest: Return dmabuf fd from IOMMU_TEST_OP_DMABUF_GET again
      commit: 1d56f4d6db3d2b2c93017a80c4f9c4cfffa9d193

Best regards,
-- 
Jason

