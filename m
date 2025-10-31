Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FEF1E834B
	for <iommu@lists.linux.dev>; Fri, 31 Oct 2025 12:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914953; cv=fail; b=jtsNk9IQEHYh5k9jNJqi8jWXFM75YjmkieYMvZITOywXQ2Gp54WPop/TgnfIFYAHXb+bF7dKamf75QwYxhTM9R6zojnD/mq2mxuJLvGIQoPuoAaBxrFRo0Eg4tl3+Roc2Qq8rtA6rjsWjcKu7ZnIckw3WiAyUfmuHkTvzyffsNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914953; c=relaxed/simple;
	bh=i0YLAgigED5sLhqdfmXQPq5tOo8cnQvoiljzBVu1JXI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WkqXPUtHStjF6gM+Stu90Kh0f4tgG6DL8Hwlsdv/3IUxo/I6hw4gjbkiF573CVZC4Q7iESKmU+NpIpU09Zle5q919qnOBMRCPfSDf+G3JZdx7Z2H/8qpVWgbGX5VVwYmm7vj1f5DcMO6hT/8+DWrYubbRUXfNIDgqW98PalLxXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dijh0k1J; arc=fail smtp.client-ip=52.101.85.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dijh0k1J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPPsnPxucI34B3JDrrceorZEvHCO6htyxQ4j508BT35DJgxrlrvDnaZLiFbgcveFMS8zxDvzA9Uo4N+UrJu9gYNygRXkg/hy07jiiUJ1PZS1+QPHiacIwmpxF4dei6i6tVx3o0I4jmA6MN2UubksuSGeKxExP38pirtxftGBtKo3geMKlB2VQ1wamaEQwQdHpb7YnZojUnuXsJRCt2/peuTJmf+TrkuVcAxqgKAo3UPjWLF0vXARQQcF0QO70fjfGFKmlp3oSjmuEG12PBeEOZBa6CT6QlLXT/DOTkEZ51fDMJ7t5fGztL66StfDychELuITQm5eGt+IaJHvvlKKtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0YLAgigED5sLhqdfmXQPq5tOo8cnQvoiljzBVu1JXI=;
 b=XwFBG/DTv7g7yPIyBr96smlfhmyjWgrJEiNqOThyTTZIMU/ucNiVSv/6sfH6/R1ZqSkLm08tKOSTgPZ/Y/aQUCrw6YK+/fQkmq2n/d1laQ7h25uUyK+e8/sjdu+AFQqPS8LA9thuBrFfJQtZCjy6suEvPMM0I0A9ZZJHiJ+a+r87gsbcYIuxWxCMUlcvKgdj5v4f0XYJAOSWL8ygDtfteKOCiAjeJSa5fmwiYkDa0rLNB9oqWS11nxQlpaLP7r8rjkNb4lPBbwsxiso0ta3tLGsanfQaVoZzcsn6eYvHwuWMRqrZJqVWYYfU6wkRQtP7iA4Ea1tScQnvHieDU53D0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0YLAgigED5sLhqdfmXQPq5tOo8cnQvoiljzBVu1JXI=;
 b=Dijh0k1JQOBcZvnjkJCzdpQLjC1I8F7guFdVXMt/n7iBlco9Uxon8tpxBLv7IZjpivI8GpSSpJuJutUWGLgP20AguW9n/MWso0IACC3QUpyDtCyifObGVkU3z+JDowyESk+N/LQJVrEuHH6n9ks9RdSqyMOIFvkQlPSmT/xu+Q+9CPoVILcze6k0QA1YZznN3pRymAqaL0iBRBuZqx5De9ajq3uzi3rDTXEpFKop5XOEsanljbkw51iaPArb0F+JZn+DOkoLYyFpjYAllTxp+Y9PckqbqvDp99Qms0E+SAPyeLdZ20s4OxytNJRm/VT8MBOjLVuMJRR02zXOW2mYmQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SN7PR12MB6714.namprd12.prod.outlook.com (2603:10b6:806:272::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 12:49:07 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 12:49:07 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
	"praan@google.com" <praan@google.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iommu/arm-smmu-v3-iommufd: Allow attaching nested domain
 for GBPA cases
Thread-Topic: [PATCH] iommu/arm-smmu-v3-iommufd: Allow attaching nested domain
 for GBPA cases
Thread-Index: AQHcRJuRPY75xir+QkydjZehTN8yTbTcP5/A
Date: Fri, 31 Oct 2025 12:49:07 +0000
Message-ID:
 <CH3PR12MB75480D5FB0B0027AAAA48CD5ABF8A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251024040551.1711281-1-nicolinc@nvidia.com>
In-Reply-To: <20251024040551.1711281-1-nicolinc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SN7PR12MB6714:EE_
x-ms-office365-filtering-correlation-id: a9de9aa3-2d31-45b8-4094-08de187be162
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KLWUbiuaqO2/o/Bq/qbWNjXtNCqDEEW5jaD9WPNwaH+3FTvHnXeXPQbsG/DA?=
 =?us-ascii?Q?XV+LiBPdZM/jh9ZiBtidayS40GzgLkSF5GGIRNSvla2mQop6sBaLkGcvVKkv?=
 =?us-ascii?Q?spuKmKMOlhKua0IdoKKlyw/12klsD7313S65TQBb5Wh4UU1Bfzkh6qoNPHhM?=
 =?us-ascii?Q?kvk8+MBsMma9cfbsRZ+JsiKWr0oJA5kNuyYqNK4bGpWJZ7tzKPDZNwWs6YW0?=
 =?us-ascii?Q?yUiuGIrrTbRmKJlNHXNQEqO7r+mI/xPGNL41q+hq5vu5jldM/zUywEtbu8/D?=
 =?us-ascii?Q?d7PnnLwc4CsFU8lf1zeyURBMhjfzOus6sXADBZkCITem4D4GG7DWN+PazMVD?=
 =?us-ascii?Q?+PBIuIrbj5EBk3UVUw8mykQ52WUL4BQ0x/6AdXeDLKVHF88Jt6ZlUx/3Mg0U?=
 =?us-ascii?Q?3HToaDRqmH3YZTxSu0pAI/3qBEz1WxtqFZXURhEPOPX/HZ+Z3TmkfVb1ykNc?=
 =?us-ascii?Q?T9xHVNs3i2I3vzRHhx8hqCqo/4iCqHUVaUp3k5LxBMrv4TvGGg8Xz1/IsTK7?=
 =?us-ascii?Q?28aARarJpNcBp6Kb6MFkrks2I0+Ht5NsbFa42QxLlPaath3PtbfSzhhEbP5U?=
 =?us-ascii?Q?kNzGX0r7yVb9j4oWm35G3XuCrEp87H2I65gdkQEuuA8mKSfwusg1OX6w6TdI?=
 =?us-ascii?Q?/Eyb++zEzgdWJ6RN8xZ7FZwd+DmTSWTmi47M66uzJ1EQ6FZimcgeM93HxGeb?=
 =?us-ascii?Q?HQBDfdoKyCUe+ZSYFteBWP7l+ZHF41njMeoFrR7c2cLL1g7H0XCKuEt8NtKU?=
 =?us-ascii?Q?nusMPRUneCArp0ZJHeuatetzGOWtziRmOp/EJ8pZvz+S4v0RPdWW6QCEZjPU?=
 =?us-ascii?Q?FT0RekWEpKfFMuXas2KPFisiq43uDMpysZUBIecmFivu9Mqru7P3MhbjAJRJ?=
 =?us-ascii?Q?Zv3tijcXMR2Xpi4IZ7y8p5cpqEzl0HpqmdE8120l92+yF/t5KEMuJc5UHoan?=
 =?us-ascii?Q?e8X1m65yK4tB3VMvFTmitKmYWuArcIHWQcBID+bFRsUxBVMsZUxHLGOJwi12?=
 =?us-ascii?Q?fWuBCGKOgG9jUV2sCvt3uzSmy5NQ++RL/OJR/SVd7UE0u9GpVYWRRvFBtoWt?=
 =?us-ascii?Q?g3qvNA5jY677MpG/LQJH1spSfhnqe1mNkFhc10W5jbB+7uDXf4MvTsrqSPCN?=
 =?us-ascii?Q?4pUL9Iz4o+r0c8OoG8ReDft8f7Sd5S4nAN8UgRvDy668ALraqP+MYlqaZfnb?=
 =?us-ascii?Q?BQFd9WzlQid+rnFb/ajpT8s9C3O0FzqQw8GwEwbpl5IVaim7nKqczcQlyrjN?=
 =?us-ascii?Q?Uf9vzZ8seA1FQsmuuQ4YZ5MKVqW1UDG2BcNvu/yIAsicjdOl87wCBvTS4+3+?=
 =?us-ascii?Q?hnd0kW/OU6hkAWZGaMW2heNSYxI5wd6nRdL3X6jmr95kz8C4r0vmZZNqbmOv?=
 =?us-ascii?Q?suwSJyFKNJhDSz4QTkxsiUlk6t6evFnvhm48jVIEFzB3SSDHoebo4/tDt3FF?=
 =?us-ascii?Q?M/X8xDYyBMaROVrFyjCa+Yk1LoL/Oo5BCsmADohW3IVo3+ra54J7oZpPkw/x?=
 =?us-ascii?Q?vljg0HxdRpMhsACyvMubC7dywtEV+OUoRoly?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FbAYCChcMVSRh+gkWQKrjJA4YLV5uzwiR3zUmfl6dsqFqVTZeVRj0S3eOYCx?=
 =?us-ascii?Q?IpK6nytA3TiHieIoDOIto/hiar+1cTU5RKYLbJy7W8W4Xe8vUuxczAf4vxi9?=
 =?us-ascii?Q?0wK9iJU4g2YW9WCOHOnIbRwyIqVFk+OcXpXVNOMnY/Cxdin8mZOFiqmxGGXc?=
 =?us-ascii?Q?2V/4t8bLrsDt++HEwrHnQK44pH9AfTJZzSSkRzMHsss/rJBZn/8R0xIL4/w6?=
 =?us-ascii?Q?V7KUDIFXhNu31IRraTdRayaPyfPpmM0xNYpwZrP0a9rr+oUEjrJxvgI9ItGc?=
 =?us-ascii?Q?+7npGB8i55BzsL+TE9I4ZEEEdC/8068ilRJsDFfW/nLrkRBeiL8i8qbwdc4U?=
 =?us-ascii?Q?+KmFlys9cKvyNrS91WAb5VDHfokdEqLHD0rYcRngYWva4Voebu26McFy0tcU?=
 =?us-ascii?Q?WrTQCqfotktFJCJrCXNBbb+ganDmg1fiK/+PSpDza+5ZNlZEGakX51hILkNB?=
 =?us-ascii?Q?4t8o2+TGiVP7xFOY/UprfF8PemrU8R5dT1Wzhbr0JgO3Hu+Av7fvYOet5ymY?=
 =?us-ascii?Q?L155ozREWerqMU6TjrhMK0bLUFF+YpTXtcZznAXrzCOLoo8wmGx4Y7gM1mQB?=
 =?us-ascii?Q?qXbQhDDb5xxVNvP91zk/ggGP1+8Xoe0jJjyAkEMQqOjk9xaBYOOE5CIL+maH?=
 =?us-ascii?Q?F1NEK5XO6Ej2nECBcXw1l4RR4SPhBJCD2oGiO7YBWtCvKzeO/8yEkAFdenYG?=
 =?us-ascii?Q?OX5aqYJFMhDpI2c1qBrtBcnzQd/W/pt3+7Vmp52xpbv65gRg5XwfdlRQz1eG?=
 =?us-ascii?Q?dVvyL0wEWEu74NmpFiL7Sl1120z4R+tS69np47wXCtCabbC79JXny59DJBep?=
 =?us-ascii?Q?Cgu9iFcAbE5eXRxZriLFzFrAol/wOLpjMcdAcL75MylCGtevxO0m+LE+V0t0?=
 =?us-ascii?Q?exw7SrduazQ0ENaCkpXIZ2CLw+mXN4bbVI3KM5NjwqW7Sl22CPNPX1lW/hC0?=
 =?us-ascii?Q?iAA2Oj/9/IAgJfKnbMTh4IjPSroMyzTll1LXlpJ55r+GwdRzsVd6vemjTNE5?=
 =?us-ascii?Q?Rc3qmETYzSJF43Cvb1b3TOAGcN/Fnd36y5VBEBPoodzw4P5pF8G8EmnvCGw0?=
 =?us-ascii?Q?4W4SH1zvsQgbw4qf/t8iRoQ/MywZoIzh/3OD616PL77kj3NbLxxgtJ2xRrIE?=
 =?us-ascii?Q?ONJ5zaeCbSVXfsJhomeco0RQQtvZ8bsJv6O/kRRT66iC9tQaaBGq4Y1CK0Ik?=
 =?us-ascii?Q?ZLOYV25WFoybAzOKld4gej7s2+HO/zPZIRE8WgUXD5zEQSwYy0AxCAY+ZZ9F?=
 =?us-ascii?Q?tnBobqFmyAaSnbnO3TKYJMKvbz+zb74dp+3P4SJkies9DTHldGfDofo/ZCfD?=
 =?us-ascii?Q?W+PJixMfvxOSrEYobzZhuM1z8+H7L7AE5gnPPfWpvo4blAzXbux16cK1UYaz?=
 =?us-ascii?Q?sgWMD1hUTD7goiPFgVR/Kl5udMsCEm+bz9WoxiolmKKlJCNspSdL5SZMqlQ0?=
 =?us-ascii?Q?nXV83nKKCY1uX/QcWn9n7mNEdMxh6EXdtMzLtgEgRjctJapb/NOsNMWHSAlx?=
 =?us-ascii?Q?jKsrA2sPuNFCte0IjWDELRuyf+9Vu/rnZHNZs0iAPQcNfN0srpPXi9kgXOqT?=
 =?us-ascii?Q?rt7bKMHYAHVvUxKnTG2AocSbiJ9ES79OzGWQlFc5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9de9aa3-2d31-45b8-4094-08de187be162
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 12:49:07.4461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YqD3V4XQabhsZpdcqQqjF+uDi8kWVCPFCQmJ41VI4BkbUvSkGTKRdIRxcVGiZiQnPG769Q3KQFh7uh6WtpVRpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6714



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 24 October 2025 05:06
> To: Jason Gunthorpe <jgg@nvidia.com>; will@kernel.org
> Cc: robin.murphy@arm.com; joro@8bytes.org; kevin.tian@intel.com;
> praan@google.com; linux-arm-kernel@lists.infradead.org;
> iommu@lists.linux.dev; linux-kernel@vger.kernel.org; Shameer Kolothum
> <skolothumtho@nvidia.com>
> Subject: [PATCH] iommu/arm-smmu-v3-iommufd: Allow attaching nested
> domain for GBPA cases
>=20
> A vDEVICE has been a hard requirement for attaching a nested domain to th=
e
> device. This makes sense when installing a guest STE, since a vSID must b=
e
> present and given to the kernel during the vDEVICE allocation.
>=20
> But, when CR0.SMMUEN is disabled, VM doesn't really need a vSID to
> program
> the vSMMU behavior as GBPA will take effect, in which case the vSTE in th=
e
> nested domain could have carried the bypass or abort configuration in GBP=
A
> register. Thus, having such a hard requirement doesn't work well for GBPA=
.
>=20
> Add an additional condition in arm_smmu_attach_prepare_vmaster(), to
> allow
> a bypass or abort vSTE working for a GBPA setup. And do not forget to ski=
p
> vsid=3D0 when reporting vevents, since the guest SMMU in this setup will =
not
> report event anyway.
>=20
> Update the uAPI doc accordingly.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Looks good to me. Also tested with Qemu SMMuv3 accel v5 series
here,
https://lore.kernel.org/qemu-devel/20251031105005.24618-1-skolothumtho@nvid=
ia.com/

Tested-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer
