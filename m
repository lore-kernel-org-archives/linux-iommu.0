Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013045.outbound.protection.outlook.com [40.107.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD42632F748
	for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625051; cv=fail; b=hMO3zEk/bN1VG57XgIPoKN4u87+T38P6/9P+VNjTpCf0mI2F+qKo4hnocYwIFVcV9hJOzwkN337qGPt8rWs6MNwPtRhIxuqtikP4B39R2qcOAe5fwHSOEeau40KnykJaeKKYFURN4dUfuQ/l2aU3D+xJls/fNJ5okY3dPbsfphM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625051; c=relaxed/simple;
	bh=2Oe8siKN38KUW/K3fkIB4HnalW9CEMn9ROPxqE8Dru0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KJBzTViqycxloRb8idTZ6bVGT+Dw2+7yGtJLio547hjQQevVTvi1Q/7e2TiEb6Ne9d8a8BuegOgwMtgZu0CMbPTRHpSnIccNJFQu9kWSlbZVUTjyt+BjOBzXkCjPzozMbqLa4buF9QVU2FZ88tGZWfSu558WDG1ubPYRjEBxb0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=egI32I2M; arc=fail smtp.client-ip=40.107.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="egI32I2M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DolMbEK+GIvqjKPFRqCgxTx/cUYd1PZa4jIv03VudA1M5Y3XdGCJi/e+Qdd7gk1/bD8iRu/eURMJFJ0GUjI6l0TO9hCaeId2FOWalvF6mi41cjme69GTXlFXGS4tcLrqehPxZc3BSXJX3td6rp2YD83gmaPCj3M3DrtXC7VnMe7XNZDERyC4eZm3qlxdIrXCwtYGgdzqEinJwoHjVXBmtiICWB7VRu8W4tKx9X2JSsOowIMmR7hL6x1EklViMcNWEiimG8TOScN7/t91VJIL5vOcLUX7itAraKw0mgPaLbV11UiBMDFVQTsb+508P/X3vFHz3KiaQEhybcWQlm+n5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdCrpZYc8TEqqK+DdWwfH3ISDo7OB+SGVfYyEtfhydM=;
 b=RC35zQTDN/piG/50NDqSV3tUgHCd77RUnXZjyJF740uoK76lnZgv6n0CH6L/bzDJFcHSJsFhQWMX38F2jgme8fbf37OBDarPSy0qfwKnoadSsAZSPbSDEKcS9l7hMWjsw0HsS0nz+bF2xcQldoPdtge4PVeP7SOjDtFeXzJJAlrSv5Su8VVJT/lXfU3cPNa7JqzBtHp4KJDER9VSIpRr4O1P0ASWfbDPYO9sE2Yhu8VabRHk4gjXuITZLVxtvxicvb8Ot4kTkBzHU3Er+CIABMvFEnbCrnRjK3s6iw2ik3mpHNE6aEO9lbR8SZ0dB3J1w3LK9iH3RRn5SM2w6NtlBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdCrpZYc8TEqqK+DdWwfH3ISDo7OB+SGVfYyEtfhydM=;
 b=egI32I2MBfmM8SmwMeUKZ5lHQxBd8KYLvfqLSKbCDFhelX2adOmqYp/DT5SDxiRcoEjYqjkYTJP9g3GA6/OZCHJ/26RWlWCkYfVP0rOYFF+y+C2IqhwwYB6DNs/vpl2NrYGQRDE8s0+uu41XDumg0kSEbxv70UqhB91xbKNUdD0rOmJvQDLTyODQecmGuKAhzFvStJK4goqAzOf/igU4b8ss+6Q4lEo2Il42rTP2jQm0P0skkb1B4y6vtTyZSQzfXeH24qPhympo0BxLp9cSE9UPVFNJnHWIkZp81LK+ZMkdwwaYOuVj3xuHwh9cPuLYwjGsoFG+0l94bAIWn40xEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB7182.namprd12.prod.outlook.com (2603:10b6:510:229::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 27 Mar
 2026 15:24:02 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 15:24:02 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: patches@lists.linux.dev
Subject: [PATCH 0/5] Improve the invalidation path in AMD
Date: Fri, 27 Mar 2026 12:23:54 -0300
Message-ID: <0-v1-a7b77c25974e+115bf-iommupt_inv_amd_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0037.prod.exchangelabs.com
 (2603:10b6:208:25::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 862c0f9f-1c7c-4f93-e811-08de8c14df8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	C4bKFgX371ZhQWRYAVTm/6zEqtQL+6jUMzva831dKbhVUM85iGfoy2cITHKksno+oANrrRwG5x2m4/AjPIMg0Lwfea1E07jbie29r6MuVUIB/Q65VqveU6lxk3CXNdPfpAY/ZSFO4VBCU6cBOQeZyZmLPcj1lmXKHNU16Le11AhLnUjAnyjpNuZfCEh0ImyOmVT2KfNc3pgXWRzf4YxXNTYII5KZo8wp7aDdaJBSlelJqnmn1JMzgDMTY5X5e29jbKcy2KJ+a1NIbwapXrK4SJFbyWSV0i5zag4UK/W3QCfaBzIjGKT8qQoKeb+ip91yUlZqKsUKySWbyZyibwsmQqPgx+Ffr79fJsw8sWOdWd1tUs9hm2D5Hz2XzdDQR1UufOxhfYaQC95lB46gKsOzpbugs7zolLmzCH0+cFr/NJjlduOSDp5kktIgML6jmn4QkcRQayOflzrMeorVfv1e7o7Niz3EVakSZ0h1ODbmXmEKmNbWjoMztqJI3h3dVl8B9x591JN/ZxoqWeXAtVGwizTt/27Yyrg3KUs4fU6hBICGZVxreYciMQzJg8z095XdaSF4OlQIhcGTqtR4nFD4klw4Bvrnd9kLRx6ZTnNnOytYEv2EAZ+6pFcjR9Yux3f432ucaiggFIJNNoLQk5grbPbNAs6uQ9g1B1bV79KOLUh8HEN8Cl7xUQBVH5ApV4Ko1iuDR+5FSuVMbC5YXmozbZ2Rd87SLEp9DmZoQB59bMU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hQEc7KgkjkQ2dKoc/73ml3t9pfVUyCFnF3tXM47JWaoospNaI3UFqGenFW74?=
 =?us-ascii?Q?ZQfosXJAQCs4t/0pA/SDc8pU8OQYDJE9/kTgaPix6f0lTkhteW5oT4TzUYJA?=
 =?us-ascii?Q?QHEvKjomDOD7GWMQggjc9ZA/k1zYVGan/fmxR0aRg7Mk4HMR0jvHiviwnKIZ?=
 =?us-ascii?Q?Joh4BffC1PClB5dYac21X6hu733YmaE+3RPpQmHTnmUGMpPGLQ43rO+gmXbS?=
 =?us-ascii?Q?Tk7J0eD7m/fsDfvcunobeawc/3BS2bz2r/hnJQBMlCUrT7FzqCEwhnje2p9f?=
 =?us-ascii?Q?feD/hz3gQQRg3J2kjA+YAQBjBs0xJe5t/DqtnIzEFOcWFAowS0LnteIg7AUt?=
 =?us-ascii?Q?NN65w0J8LkvvkYetYQMMY6UZVXF3UJD/FUC54SlX08Au7w/MIzLEYrL/l6NM?=
 =?us-ascii?Q?E4hAY0z5i+TmZ2l0tsXYXvo1s3MtuzNustAEaD1fi3m2bO4G/nxvjjuom7nS?=
 =?us-ascii?Q?NboFyn+30/gJOvDa6ObFNA1e7bYL+L9fxgaOhNea+yr4UF6lxPZAxIOkMzhb?=
 =?us-ascii?Q?fVSnoBM3mzEHyyzRkhlxbFEckxVmnXbffpevGNWalTirY9w5Tn0Ez5K3OAJq?=
 =?us-ascii?Q?wFhwajPchfaFeXMxH19UUwakR5EyGWHHGZwifQxL13850wsWD1+2IT/syYUR?=
 =?us-ascii?Q?BJulYdm2bdBqqfk4TOvTnuwZAWduOLnWRlUTB7pogotwpFyBwqfTrPmOsUAc?=
 =?us-ascii?Q?sI+VHGo5WIF7+i9YStBiLSxiinFHnpf1IF08JeLhRxHgZaVRgKbzkyDQwUAu?=
 =?us-ascii?Q?8sXsbYUsNxQ/dInPHMD/ms8Dfp6+hTLqyq8UZxwSPrG43MSL/GLZS1uCU7Fm?=
 =?us-ascii?Q?YW+2UbqwATNLfTBoGcBkLj6Ki4S3EtTuFw0uVaFgDQMEAzZiQgdEE9pRvtu+?=
 =?us-ascii?Q?PaA7JdG7Ea0gxzZ0ZiG/G3FoqUFNGQhGXPPcKNCuP/arKivAooe5WRZpAckZ?=
 =?us-ascii?Q?nXM8aPRt6oLYvZOUdbH3bAfNhNkDzPIuXn4Cq1WwndKKCWhtfqzaZLp6MY0X?=
 =?us-ascii?Q?3wFTKF7EbF+79yNChzvXvo3W1TS8857ij5PkSuJnlRqWcUYPHNnRhV7mu+1/?=
 =?us-ascii?Q?qGc+1TWJ+GpEE4sLJOSpJzwe+MBUytZR+YQ7xprgcgbg3JT8EXWz3hz9RZUt?=
 =?us-ascii?Q?/5xOi+om17MxbiIDrADvUBcBIMLWL+hp11diSAmzh0Kv40vnbA1xXfPz+XWL?=
 =?us-ascii?Q?pgUvmSCDC+hGlT0h5svhW5D3jf2SB0BmEEHTbI0LXRzziv/tUmk7T4RI2CtM?=
 =?us-ascii?Q?cDYCTfLSdfa2TvH/l//qWspECrvviYHIzt7ibFBxzDfeNuPlQhhikvV/NxTO?=
 =?us-ascii?Q?onLNuTMCTXAh1OTn8JXksVYhzKtIHp/QF6p4nrgNA+zWhrDnNW9mYU2fddjP?=
 =?us-ascii?Q?wzkaInDb2FGdpEVj9HEV3G/ag+GMHwqgyZ0eZIV1cYfTERYaO4pPRZyWbhAl?=
 =?us-ascii?Q?DufehWjhZL7yNENGIu35hMUgo1PGcH1oNbEQhusrB8yOsF4MKirhxNS3h1MI?=
 =?us-ascii?Q?tNGZLIRjbAN/L3y70/hYqtooi9crcsdBZp+5nIjPKA3hiElPjgISTB547mfR?=
 =?us-ascii?Q?tksvHed4YaG5eQx+UCEG20ucJ/YMqJHvbZd0m38Cc0haThWPrUmvBnoFZ2go?=
 =?us-ascii?Q?/rQyczlPExv5Bn6OoC/dmK8bn8nLXfEhGumyFE6fQ2dwlMmnALYz0VoXnWMi?=
 =?us-ascii?Q?JqVFQNyKg5D1Bju5HQt6n0ZOf5nRZcM9LOzfj54+bNrT8aAr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 862c0f9f-1c7c-4f93-e811-08de8c14df8d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 15:24:01.3315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QpMMZROqLColbeeI43zB4HT7UHtdy+iXkGXKqze60s0Jms1PrZD5kgEOSW+bkfgE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7182

Auditing this path reveals some unnecessary complexity and some
confusion around end/size/last and types that may cause issues at the
ULONG_MAX limit.

First, fix up the call chains so that the gather start/last is
retained faithfully throughout. This avoids converting to a
start/size, and avoids various type conversions along this path. Fix
everything so the theoretical cases like start=0 last=U64_MAX work
correctly.

Simplify all the calculations for alignment/etc to use trivial bit
maths instead of the complicated versions. These are all intended to
be no functional change.

Finally, add support for PDE=0, deriving it from the gather. PDE=0
allows the HW to avoid scanning the page directory cache and
supporting it should improve performance.

Jason Gunthorpe (5):
  iommu/amd: Simplify build_inv_address()
  iommu/amd: Pass last in through to build_inv_address()
  iommu/amd: Have amd_iommu_domain_flush_pages() use last
  iommu/amd: Make CMD_INV_IOMMU_ALL_PAGES_ADDRESS match the spec
  iommu/amd: Control INVALIDATE_IOMMU_PAGES PDE from the gather

 drivers/iommu/amd/amd_iommu.h       |   4 +-
 drivers/iommu/amd/amd_iommu_types.h |   2 +-
 drivers/iommu/amd/iommu.c           | 175 +++++++++++++---------------
 drivers/iommu/amd/pasid.c           |   2 +-
 4 files changed, 87 insertions(+), 96 deletions(-)


base-commit: 6c8f61b36b7efec0f8bc284142f998d30f0a28ba
-- 
2.43.0

