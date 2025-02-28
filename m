Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6AF26E966
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740752986; cv=fail; b=hvu9PSuuv/d/YmGkrjYySgP0hVMSXqESENLIw3UKmGk82fO39G2BhmsoMBh0+xttZfv5euC4kl9Mc/y3L3bL9SHYna5wzeznquzrWE/FNjtpFuuyjVNa8doFcIUBX6JIdMcRS5W/PDF+C+RdZS+Qq5kqNUVlTm4kyD1mf0LirG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740752986; c=relaxed/simple;
	bh=LUggvxPBSB7mPrrx9Gu1qOgo9QrEDm8x67fNfzkwW4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=iud1ApsBvec0IG8vsDu2JUqfPQmOsktTf5dXVIVgdCseTwy8uiGonUmbM2C2kZSrEctpCxWoZL80jRDKuAXkcmyeQYQhqKTVX8qorBzqQndQf4175S8DxP/inDc/vn+Yb1WIFhGFui+9zewaoYD53XeVE3oC1hQz85+0HsdjuL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DWzlc8sT; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DWzlc8sT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/TjKzkFZHDiCa+oXpbS50q6rkCp4Ms5cRcx6oza44kuzrrcHIEndQOyKurjEWbALuNb1nXcRkznSf4w8Is++4wRXkxpvo7TT03LIspbrWEiXfmBm/WxNb7Pkd7UJR00DYo9kAszvC8Ex2vkRp+IEjXKk0iJr22zVDdhNzTyX23aCTYVJgoQzG0eweUViWpiHBTOJm3WJVnEFI9yfUJo+A9WlyiNMQVj6LhQ4GHG1YV3vGN0ztDb00Zrh+pvOthGGGQCrr4omPD8/CR/+Z1YyluzFrw7WaRrALmwrFeRXFuz29GtW+WcNp0q1LbE28uNWbELsUc88dNSCXaRpb1etA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llu60gG0wj+5LScUmn5V8tMraVGEwIubUFExy4WTPQg=;
 b=V25+AOjn/B+rVXm9hF757VZmcuI4H+Nkdr1cgJe/J7K2BKenqmBj4KD7UzfE16lKDRWA1U6TgcCt2cEqFa5fwix4HmKMICBm4iqLmRE9lj4mCgswaivLlBGI7zS2evPdNc2Dym4Mw+TWexOu5pOs/KueAjk+yxJrDGgZgbOAoQTsl2gsOLOxc34EfmGVA+N6rloR2MyU4W8g9ZcoNnVhiquzTBGqoaQUclAwtAB44ZmpREuentyOu0M2KBtaW8gjydwvfJBNGP4Fr7sZHwsA8QvUVqiPlXdVAIMauOhS0P5pr1dyjmRKWmLq4fC+lL0S0lPrsb4mxD+nehWcGW+5dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llu60gG0wj+5LScUmn5V8tMraVGEwIubUFExy4WTPQg=;
 b=DWzlc8sT9+hDCc/hWV/IHWG014WIpASZYpx+DWQYAnDyuQ6tU5pGSSQeCPLoyBP8E9JSzgV2JGpwUCQL87qBzC0/JCWS8dmmhObMK6u0MND4t5f4luDBB1PGYcwRaM/IAxcu0QboQV3aonfi5G9lbq/43DslKeHVhy21oCQD+Hiizx8S30ympEwEn+804L0TPfXjxPKQb0/peXwLqSxpTAQuhVpcngkSnTK/9kC9S2CxXjQ4EqbcRPLI7pKUlDasbPzahCyZXdE9yZ/ygXb3qiJ0nwCe6D3BIhQBNE+wjIrbC7XDsrRMjmE8ouK/6qqrF5L5RSm+M4mhy2mSVWfIaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB6978.namprd12.prod.outlook.com (2603:10b6:510:1b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 14:29:35 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 14:29:34 +0000
Date: Fri, 28 Feb 2025 10:29:33 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>
Subject: [GIT PULL] Please pull IOMMUFD shared branch
Message-ID: <20250228142933.GA105053@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C26tNqLcCvyGW+35"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR01CA0063.prod.exchangelabs.com (2603:10b6:208:23f::32)
 To CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d326a13-1fae-40b8-a36e-08dd58045295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AU5JMnmlsCAZLZO9s26q1+qYG8mckZ1AkHD+C9LiI3vmI29ZbA5Ma6fFzscL?=
 =?us-ascii?Q?eF8crcp2Clu7GQII8T6nek7jK4PtJGHkxs5z9iquCT/5VTHCTPsELg4bm5qv?=
 =?us-ascii?Q?N+bjHsDyES6EqseuALhRQX+BeJSJ4dw5NYH5zprsLRXgfxuJ+1nEqKo+Adgy?=
 =?us-ascii?Q?marh2gzHjQXcwLFajcYPmkOTSkC0/t6e76dudASxlez/sJ0evtBKPLfH0Rwc?=
 =?us-ascii?Q?3VCvAyoj/nWrrJ9y/jJOLFfrVo/JW97tuODxUnniSXNNjQwDQX9m/Sz/dbYD?=
 =?us-ascii?Q?flM+yxF6Jx/Zf/UaxGqpDKJqf/66UJYBNlhk2kOC71Tm4Pzhm13QUUuUGQlH?=
 =?us-ascii?Q?3X9GGqfXkpbY+YMLFeNnx+7rzQDV18z4NN8c1zoMQM+PK3dbaA7Wxy3zcXqq?=
 =?us-ascii?Q?q6PNlvXdAf4GPN66qiIKfJjWNC5vATUHi4QXTS5l5h9/C92/xof1jxbVDZBl?=
 =?us-ascii?Q?JjgRnp5fVyuQHHOp9s8O2ZlYqVy1HksEh7SfYukKkTzpXqePeSe9ldQi0og0?=
 =?us-ascii?Q?hT6oaptn9BgNwoupbye2JXgLKTETO5F89bu80ZPJo0sYKivlesxObwX5gG+b?=
 =?us-ascii?Q?7503vVctV1WAKO8KRrC199eS7mlGk/7K2lWKbZzhZNJ7+ctYQvOe9V9RRSR3?=
 =?us-ascii?Q?Jlg4QaZr6zKSQEoIVQitbITQ4A6Su4guTkQirYa/pNAZgOucA4apNF6ckiQ8?=
 =?us-ascii?Q?jBu3+FbbMwjCX8IEySaCgnP2F5celQnCOWOXnf5OGsYmGy/CG+QRFxKqdz/e?=
 =?us-ascii?Q?DeFCurJWBlh3ty0AglFIyhb6ZiX3670tI/cc5fiM3WkEUE5mg5mkpFy2KZd7?=
 =?us-ascii?Q?HZtGqmHxiYmm/S/GuqhQxIQy8a2FrK8miViM6eTCLQAAbU2BiTLZB9YhSSzI?=
 =?us-ascii?Q?D6OYSEWCf9tGfWc6AF3epFJcThJ//doV8X++QfmBa0aaP8t2FuD5PCkwhY+w?=
 =?us-ascii?Q?TcuXi1epAyd8j65wAnH0Bek1Ces1XMh9J8LhRVItnlGYIf9ZI0nnd/ZZg67k?=
 =?us-ascii?Q?gKqbHyJdRovCvn7ZKbvYGKZPVectpFRuJxuHt8BT3lTqOGv6os737JL8yZnD?=
 =?us-ascii?Q?ZGQsucF7oTEbROYS6OWORhDdoadaJHBI0tcJCyamoroPnm0dSPPKMPqUykHc?=
 =?us-ascii?Q?Ei+XpLsTQqfoF/6imOruScXCJdfbirO1DjSGnbwDTArOEObwaRe+46+/E5fC?=
 =?us-ascii?Q?dhMzqwkLldagT4UfgeCVT/bLzqTMmr2tanoZEt4LGWFt+BsSp2lPmm9zQsb1?=
 =?us-ascii?Q?zLzu9f1xZJMmfqEQzpMNuCFX8Wab6BGQ7lpL7Sq6VBvVOJ/ut4TdtfHruhrq?=
 =?us-ascii?Q?5fVW1lo7CMtI6CINIc0+0u+0bZp6oBL4lqGN8osclShWxY2kpNPxMqyQb3tX?=
 =?us-ascii?Q?1sgrjnIAyCdAHI0kkQWHR0N0psaE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PQrQVuXuGjvugj1NxbUSghmMvcZt1ajvZZ5GnUXbE82jjoK047ZmO3FNcnU4?=
 =?us-ascii?Q?lIwt3Gs1nskSAKo8Bucl64c1+uQod9VRSNMpP5ocISkzTnPzdB8z0wlK96j8?=
 =?us-ascii?Q?36Sd3m3EqdOVrxv8CIUn2Dha7UQUlh+D2SDwagohf965AuNBlttLFkmoqwWo?=
 =?us-ascii?Q?xGEKLMEfZXGRle3x2jJyTclfKcDtyHa+xttcq6ZwJKcgETIO+DGlr08GeZiY?=
 =?us-ascii?Q?ZDYHdWmPuG9gDhsqNjilR0qbb61/o1oxgrqkQBN//JWMnSZg+z5Oe4ep6CuS?=
 =?us-ascii?Q?qdvimh0XtwW1dsIGp0GN6GHZuzf03OiOEjqD/EuIjp3ATejk5XxWZNyRM2r/?=
 =?us-ascii?Q?3dWGx5RGnTi8/XhyuSr7DYTgOhrGV6Ue2kaTbUAASQ3fUXL+XwTFrXW4Hpuy?=
 =?us-ascii?Q?mEItJpte4dD8o5bs0H2Ig7C+BPd+N7KI96ugJvoyKogvBsjSaLbiXxWUAjFo?=
 =?us-ascii?Q?/AzD02H2SBofyO26YrbiltG7bRvOlqDaT5Wte2VlBqUgHE3A8ITLp1D787c4?=
 =?us-ascii?Q?Ro/+PwW1dlqFCCLNRleveNWiOMjtRBwe/yc2MSooE5tdYauAUxUomHfNeeQ+?=
 =?us-ascii?Q?YhivtqZkovegHwQFD/XMarv9xY4Uq5eJavWYJWh5HzTmboaPXrKQAeLd3KGn?=
 =?us-ascii?Q?mAzb3SdeCbz790pRNaYLp+G+U+CYPMAb+LqF6GZ6gGENSgjlzX4+LTIpWxwj?=
 =?us-ascii?Q?quVAilJsR0NgrPhFYwo7vxoz51xUWT9CiO16Uyw7Vy6dEHOCNhqju/OktwRU?=
 =?us-ascii?Q?TOfwdS7AR7qNZvOkbH2mThQ4KLaYzom7omYbu64dAA3aqiIEVPkR0Ir4R8M5?=
 =?us-ascii?Q?XwDKdNbSYrM4IGbAkwC6U3gYZDjCyOMtA9Of89P9ZmDq8VdLqAX9jfN2Qlxb?=
 =?us-ascii?Q?RDbezUf0pWqu1/IHI+fouMei/M3Irml/ZZ5os8Lte+SxqnFPu6wVqAGZPfkb?=
 =?us-ascii?Q?hlOdW6jr0EDMQrBbQgqqowtrr4FEwRfqX6REKHBk1ijLASYuDDsZA7zdIK0d?=
 =?us-ascii?Q?v4DicAGnVh0mSOIcPmZe65ZlLpcu06KtJ3bHJrVeAh+sQuZ89ckER3BN0TRo?=
 =?us-ascii?Q?2LgKO+zWt8Ba1Vr9HKune7KiTngl1O3ZTwb7AMS3gfSzhmNrDROu+fvIpd/y?=
 =?us-ascii?Q?hYHaST4yq0zrZOI66Kd/glhqRjh0JLmWbj3z4lUxDSr9uCH3loFzt9MSJZ0W?=
 =?us-ascii?Q?0Y+3jbVDkMNPB6efv2VUu99IbwDfsopWtxov3DFvekzGD0cLtIiT92d6d7Yo?=
 =?us-ascii?Q?022OEBisZk1PrDfaEsFT2kkaor3kLs0EdvxguVxXQKflko89NF1bO2jD/RY5?=
 =?us-ascii?Q?WYDtWDSWZjAaft0NNKTTbT22KzbEtAo39Hu9G+DiXat2Plob9cnomcyS0vyx?=
 =?us-ascii?Q?BBRkHGBEMFbk0AOVnW3DuQIIewWrdYz1HsbjVwEvmSSYDPRNm1QNdN3c7EaW?=
 =?us-ascii?Q?/L0bJQmcXPhhW/vtbSv3VrRwU6/AJxsatGvpsGU3seWhFAqUxZVGO1Lcbxcg?=
 =?us-ascii?Q?w0Y3N1EK6uE2/iUL/1UddA4VZsoY9xu6mGmS3Z8XJwDkN+ovYqGHQJ2tXk3t?=
 =?us-ascii?Q?ppkvRjbtto/GNwosT1c=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d326a13-1fae-40b8-a36e-08dd58045295
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 14:29:34.7028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fqtqu2L6aMMlr0FR7DLNRXIWrDJq8x4IqkhU1Js1mbUY0xkl/r/Nhich22DpMeVd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6978

--C26tNqLcCvyGW+35
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Joerg,

As discussed here is the shared branch with the three series.

Thanks,
Jason

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-joerg

for you to fetch changes up to 5e9f822c9c683ae884fa5e71df41d1647b2876c6:

  iommu: Swap the order of setting group->pasid_array and calling attach op of iommu drivers (2025-02-28 10:07:14 -0400)

----------------------------------------------------------------
iommu shared branch with iommufd

The three dependent series on a shared branch:

- Change the iommufd fault handle into an always present hwpt handle in
  the domain

- Give iommufd its own SW_MSI implementation along with some IRQ layer
  rework

- Improvements to the handle attach API

----------------------------------------------------------------
Jason Gunthorpe (5):
      genirq/msi: Store the IOMMU IOVA directly in msi_desc instead of iommu_cookie
      genirq/msi: Refactor iommu_dma_compose_msi_msg()
      iommu: Make iommu_dma_prepare_msi() into a generic operation
      irqchip: Have CONFIG_IRQ_MSI_IOMMU be selected by irqchips that need it
      iommufd: Implement sw_msi support natively

Nicolin Chen (3):
      iommufd: Make attach_handle generic than fault specific
      iommufd/fault: Remove iommufd_fault_domain_attach/detach/replace_dev()
      iommu: Turn fault_data to iommufd private pointer

Yi Liu (4):
      iommu: Make @handle mandatory in iommu_{attach|replace}_group_handle()
      iommu: Drop iommu_group_replace_domain()
      iommu: Store either domain or handle in group->pasid_array
      iommu: Swap the order of setting group->pasid_array and calling attach op of iommu drivers

 drivers/iommu/Kconfig                   |   1 -
 drivers/iommu/dma-iommu.c               |  65 +++-----
 drivers/iommu/iommu-priv.h              |   3 -
 drivers/iommu/iommu.c                   | 164 +++++++++++++-------
 drivers/iommu/iommufd/device.c          | 266 +++++++++++++++++++++++++++++---
 drivers/iommu/iommufd/fault.c           | 130 +---------------
 drivers/iommu/iommufd/hw_pagetable.c    |   5 +-
 drivers/iommu/iommufd/iommufd_private.h |  64 ++++----
 drivers/iommu/iommufd/main.c            |   9 ++
 drivers/irqchip/Kconfig                 |   4 +
 drivers/irqchip/irq-gic-v2m.c           |   5 +-
 drivers/irqchip/irq-gic-v3-its.c        |  13 +-
 drivers/irqchip/irq-gic-v3-mbi.c        |  12 +-
 drivers/irqchip/irq-ls-scfg-msi.c       |   5 +-
 include/linux/iommu.h                   |  56 ++++---
 include/linux/msi.h                     |  55 ++++---
 kernel/irq/Kconfig                      |   1 +
 17 files changed, 501 insertions(+), 357 deletions(-)

--C26tNqLcCvyGW+35
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZ8HISwAKCRCFwuHvBreF
YV/fAQDGROBdidDme3LkQXgn2JKQJz2tQ+JWGqH8B9yIOKv+0QD/RCLDvQwebcc5
0CyTMJsQu2DUcGGzRwIfaYd+bLxjlQc=
=00ki
-----END PGP SIGNATURE-----

--C26tNqLcCvyGW+35--
