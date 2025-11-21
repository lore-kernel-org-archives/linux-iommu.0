Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010021.outbound.protection.outlook.com [40.93.198.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CABD2E88BD
	for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 09:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763716349; cv=fail; b=hlZdOkwqcnKIuHXdQPA3hgKDb+hvFtf82ZR/zlQlkDKYAQb1QWjOPC5ofPxhVzW8xT8x/ta9T0VcBhJ/8+IW0IicW6oKYp9ULg2PJN7mgLiVJAmkto8pZt2w8QKr0VpxJn+vhg5apz0fuvtFSUz4+BBuERux0Gq+CvxEIoKRbpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763716349; c=relaxed/simple;
	bh=QI69VCjnNZwpYJxwgjIK1QQxynuG6hLAUhC/QnvNqBA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o+a1WhR/8fqrR9zFKoAz8PT6SHozVo0YjmtbBdz9Xh+vOvsA1SwvBbglvIo2OPP5tga0Y42oB3Fi/ovjlBk4kVYyq6FShQP0Sm8vT113Zy+UkOGhyAWbhz+ZrOLCFaridbK7qtlpAAcNYQiAnSwFuWL2Lf0WfS3NY65PJjTUu8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JZPjfHVM; arc=fail smtp.client-ip=40.93.198.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JZPjfHVM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCXwW1f/IV2hCzTE8F1EhefiJ+yY48FEypt3BbyN2x9U4Iayxpwf2XB6WlBODd3CLoVGSGowAsJ/EHIAAqCKKn5HT7uOPyY4/sUUx7Cnsr7KNnN5cU/a7Sw44aZle7yFYLrfE+VOZw34t6kzQ5+tcDczKPh0XTKy/TtvJFcmM/fdVN2uP6SDf2VY/XKuUGeKupTn93/pOVP3DktJCKZepFctdZxWPLOnoWgUcQ+9UeGOgpB/CJrvDfN1vGCD7faXKIm7Hhr4ZPNrmiZHW4TGTjllBUsOBQCGgPXRxvvX/Y+yPlGbMyJdOA1e02EWhzOrQslIHHSHReBCweuVCWL2Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPGp0BBlw4yuhYHvz/BYqAjJsBbxg3DjiJAibE9uZT0=;
 b=DaABf8beG/qecK5LtcM/ZjFHuqm7xBMStFMDLeM2XBVJv5DC7apaUl9MywS694QtJfEdmgFUHHmYAZqKZ3JA9gZtpS2XSPL+QikDJHzXTEQtroLxdCpaOOaVIMNdAoTCnEjn8RsMr27HIONfSQPj1J8+rCId74UqCNCZiG4DAlcww14b0tfeurCu9p+49ozb3iQ4eFebsC/6YoH8KZhgfljkApy4//uOnfV5QXief3c6xNMir+eUZFsOIrnox1mXhyVh2gnjiubwtK/tgpmpV2GZGqDqOCvfapNWwd9wsZ+nZqgE7/InXmaK5+49h5bvHXnnyvYF9APoIEa7FmnPWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPGp0BBlw4yuhYHvz/BYqAjJsBbxg3DjiJAibE9uZT0=;
 b=JZPjfHVM+XBU+kzUHdbKwxmskf3Xat3YwTy6eMVgBj2Faalsi0+4Ho/bvkqfLMV7uz7805BEPUW8ZTZLv3+s8NTpLjdev4uzZcflXy8IClpuG7ErDBTVDTOZc63ZUxDNozcWU7I0NZ7Mw1fASUbnX5ZN2X504NY8ZuyktwUUuoA=
Received: from SJ0PR05CA0064.namprd05.prod.outlook.com (2603:10b6:a03:332::9)
 by PH7PR12MB7236.namprd12.prod.outlook.com (2603:10b6:510:207::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.12; Fri, 21 Nov
 2025 09:12:21 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::87) by SJ0PR05CA0064.outlook.office365.com
 (2603:10b6:a03:332::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Fri,
 21 Nov 2025 09:12:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 09:12:20 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 21 Nov
 2025 01:12:17 -0800
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<vasant.hegde@amd.com>, <robin.murphy@arm.com>, <ashish.kalra@amd.com>,
	<will@kernel.org>, <jgg@nvidia.com>, Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH v2 0/2] amd/iommu: Preserve domain ids inside the kdump kernel
Date: Fri, 21 Nov 2025 14:41:14 +0530
Message-ID: <20251121091116.25663-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|PH7PR12MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: e8dbd472-7c88-40ad-9eba-08de28de13a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4d38MxzPVL62S317fQaMadXjyrifo0bfPkeWHdHh9P3VeNRmmMVgkPU1UCWP?=
 =?us-ascii?Q?ArjwsgM08LBCV3oswpIn4h+rDcf+vwTuCBe3dns5+RdT9+VX9fbnFhnAFniI?=
 =?us-ascii?Q?mncMG2HlaTYXtO06xZKzFB5Tqdfm5+d0ygaWwfvDY0Vw85ecwyb6XAiuqNnB?=
 =?us-ascii?Q?IxOBXBuLNI0yPMIyGXOFzNp81NbCxgqCdgb2zCo+iMYQGrGfRZDJHEuhrV5n?=
 =?us-ascii?Q?xGsxh/2vehM1tZlUs0PgjsdVN9fClS88yTWbUmigf8AWk2vavDUdLxCF3e0H?=
 =?us-ascii?Q?z655SgOlVREUkPiyztxsFEdl5lVX8UuNUNEKDNmZJmqVuK5SThcT8Hslb7+I?=
 =?us-ascii?Q?gE7i/wbQiyF8tjLHD1Z0BzX5fz9SEuXfEPzxdQ9l4PZp1bhNnyJd7ju5Sh/P?=
 =?us-ascii?Q?uyWJmiwzq5bTOVGwc95dfCzfdMG3cEtTiMtuX6aVTmokPsa+fwbgNc4ovD1v?=
 =?us-ascii?Q?G/S3WvYbzcQZD61RvUfEfbHuuAoOmpD2TgLMLbXMTt/0GvzGSpwotHD6qdTx?=
 =?us-ascii?Q?1IIcftH/0Du99kruuYwPmJAlQBhUCFwrVjeBkEsuS4WbMtNzTJrznbo++i8W?=
 =?us-ascii?Q?Ym2lfGrma8DtBowa1QkURCYlUEySDzabJN+y+O3CWjp+Rc4UpjNUnmUSHtNZ?=
 =?us-ascii?Q?YVhYTvfp+2/a6eyH2xs40eNJzcg46MNl3HcvA1ksUZ+qFmp9xh5YZf1JHEmh?=
 =?us-ascii?Q?9GksadLp4GAKSDO13yBdohgzzcZH3aKj57L/H2m2f1GPLv6AVb1o7fb2+1fC?=
 =?us-ascii?Q?i3bCy6uIp+zcV5BfgwfuQhk/r1wVTv8qfufUVG38l8TEs0y97FxxpoMDnzT8?=
 =?us-ascii?Q?+hbeQBijjTujpywQ/AVuN4ZQPgcI0eixOBzn31S54D13/kIdApxzppdE0L/h?=
 =?us-ascii?Q?w+5fEnXrtFJLC6bDidYpm8sLheMIK6edTyLkhC9jmiknlyoCo4FuCssrP2UP?=
 =?us-ascii?Q?q3qXgG8CNxendidzcOeSm9Z7BO5hYJO90S9b8R7+0brCB8ogbcWDey9PufCR?=
 =?us-ascii?Q?ZcyhDzOyjMJ0ody8AWOlIfLpkgMdoaT6uvcSAbcT2srjZ8P4IffMyM1yIxjU?=
 =?us-ascii?Q?BBBfW1RSFisOMQFgNUU1U24OftKM9gK3Db/x6dGcvAn7jMvYfJzhIF2ooglr?=
 =?us-ascii?Q?KrN0JIiOrJhf4GoRnBCbTqUbY5mo9+yBrxPnaidjmS9qdd7taeGLSKa8kpVh?=
 =?us-ascii?Q?dD//qFPWfMwKCwOvHtkzpRPkbwnC2iykmmjcNr0/XkYq3rHzf8AvF+sBu9WJ?=
 =?us-ascii?Q?QFQ9G9DJ3G6VVo/IOm+Ot3jTT3t2jYoP1YcgBV1QuGqU2/E4swwnqi/WJKK8?=
 =?us-ascii?Q?1Eslo7BsSPJ0+oZ/rTdEUDIJpV61qBwX8wiIgEZZwqlX20aInDtLlkFFv2S1?=
 =?us-ascii?Q?1rAgPyDjXFZAQfgRYUtY/fGg27NTfg3dwxYkRCt1Ezf7lrcmk8pJg1EQ9f1I?=
 =?us-ascii?Q?r9Sg84u+ug+1T1vYo3CiRT9twKP9BTWefl2AI7MFlsKiIAzvGP3hc6Kgb4wl?=
 =?us-ascii?Q?jEd0nmCUBujhrLswydM3M0zY8oBepxdOwQtZb/4+PMs2MGQO5bfsVerRh6s3?=
 =?us-ascii?Q?UEavqkp5KFWi3sxIh5s=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 09:12:20.9125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8dbd472-7c88-40ad-9eba-08de28de13a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7236

Patch 1: Reserves the Domain IDs allocated by the host kernel while reusing its
	 device table inside kdump kernel
Patch 2: Cleanup around pdom allocation

-------------------------------------------------------------------------------

Changes since v1:
https://lore.kernel.org/all/20251114104442.23296-1-sarunkod@amd.com/
P1:
  - Use FIELD_GET to read the DTE fields [Ankit]
  - Use GFP_KERNEL instead of GFP_ATOMIC [Jason]
  - Remove print on ENOMEM [Jason]

P2:
  - Use u32 instead of int [Jason]
  - pass gfp flags as argument to 'amd_iommu_pdom_id_reserve' [Jason]

-------------------------------------------------------------------------------

Base Commit: 91920a9d87f5192c56ba5bf3e133aeb3576b705d (iommu-next)

-------------------------------------------------------------------------------

Fixes: 38e5f33ee359 ("iommu/amd: Reuse device table for kdump")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>

Sairaj Kodilkar (2):
  amd/iommu: Preserve domain ids inside the kdump kernel
  amd/iommu: Make protection domain ID functions non-static

 drivers/iommu/amd/amd_iommu.h |  5 +++++
 drivers/iommu/amd/init.c      | 24 +++++++++++++++++++++---
 drivers/iommu/amd/iommu.c     | 27 ++++++++++++++++++---------
 3 files changed, 44 insertions(+), 12 deletions(-)

-- 
2.34.1

