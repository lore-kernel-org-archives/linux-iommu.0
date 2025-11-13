Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010025.outbound.protection.outlook.com [52.101.61.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A20E242D6B
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763061738; cv=fail; b=gw3j8/Q8gqHRmnRgQyGQDbi3zo7owJFc6wro3GHPlep2z/k3W0Uph5GKO5MokSg2jrHraga6E+3ZsTDYV84zdYitHd6LhzPeUGzTXn4SGCGh0kVPq2E9xy7YFjEtO6SWpnVB5IA/9ULlqdHZ11NAzVaJ8QiXxTUYdiJf9E4dLgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763061738; c=relaxed/simple;
	bh=97omzppxpopFDUhalQkEK1GfjL1JrJ3YDVzmBzUq6G0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnd1orNZAoL/WcPXIPfA8oUlS/mD+c4JPh7aasEAzqfNm6NE/cPgYGWlJt6sBPsFxLwaPzzYkOR+TOUGtLrZqUP1E5j9oCKRNX2/M3vXjn8LverckVaNmYwpBiafwLJgzdgg81EMzCgllfmvrZgY9xF3yT/gEdB+a3zalUAqWG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VZKfFy6d; arc=fail smtp.client-ip=52.101.61.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VZKfFy6d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CNEbM/jrFa/7GJf77lqqWM41IPRgld3/BtYttwRhS9r5JFAe0vv4q9qYN7gDTvvX1e039i14Hxr7RKkws+hgQqrgwTDbLgd0MrRR5p7NvTUxmDSEDBnv1pq4MsRCbBT8LnuAjwyWyxjcdft7S2Dtxv5IicGSwt5KXAFlgQUEJnC0NLayM33WGm40Ry5PwhJdMKI7Q+xYTXbzC2o1Qcl+ceiNjvt10wtPoC+Z1foYRcxIYvNe5kzz8USWUwj6Fpf4BGtaSomkk193F6aB36yKwn2MrHsh/LF7nimo/u6jNzzjUxTrIa8o5OWTGYjAcc9PBWY2FENPEh0qVbhBGwFrgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTctyapHouFdHMSKirKZG2nRlshuG8oozbigpm1B9GE=;
 b=OdRE4ANpk9rQcel2RGgNrlzshd1Tx3zWLhHMz6vj+R01BBFDWiKxrRTt5JUGfoL/G5ABx1wGMoSU9HUXY8+48S1XQjJxx5y+PyMDm8OLb0bmqqM/V0xuDbInuP0tY9JeD+/RwxJ/+bCXfOXi6/CNEOx+oqImkL095JT09HDwC2F801h5seCNCbwnH6+PKzjMvdatuJcrGm0dNNBztgza2hU5gf15f5EZ54BSRUOSl3TPIN3hPSLzdXegiSfPhZuuTmn6w4Kol5jZQbt6pl2MHu7ckjdKHu8EioFInoRtwJ7fBpt2uC7eT2L+UrSZfiuS7pJltPCT2TAexqAPWEV7PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTctyapHouFdHMSKirKZG2nRlshuG8oozbigpm1B9GE=;
 b=VZKfFy6dskLMtEHHnK+wT1KvsZvi1OklqCZ6aJ5jj1/v4mdTAfSH908Fm4mpDuPcSFUs1nBzhU+fE+m6sJIFXdPDPii7I/qK1PM/x4+JZvhHayIKGHescaAlFZCblncRsBPLns39c/MD13wcb7H3h8E/Vej5tuB1Bpj4QxyoX1jN9TjMCgWcxHlzLweoQTCiH1SOHZ2JbInYeC5vM16MKpz0EMSY34+K9fOfX6e9IZZtWHckOvxIZsK2pdPyhm+XV53WWFjr0RhsTzsDhtmjM8JGlUIC7Om1WEZXFcxOiWiUFQnlCvHnwlq0Lb64k5vnoswcMXTB7Va3lHtQhC1N0Q==
Received: from BN0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:408:e6::16)
 by IA0PR12MB8982.namprd12.prod.outlook.com (2603:10b6:208:481::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 19:22:12 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:408:e6:cafe::a6) by BN0PR03CA0011.outlook.office365.com
 (2603:10b6:408:e6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Thu,
 13 Nov 2025 19:22:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 19:22:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 11:21:49 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 11:21:48 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 11:21:47 -0800
Date: Thu, 13 Nov 2025 11:21:46 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<jsnitsel@redhat.com>, <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH v5 09/14] iommu/amd: Introduce struct amd_iommu_viommu
Message-ID: <aRYvyj8s9xjS0tAK@Asurada-Nvidia>
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
 <20251112182506.7165-10-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251112182506.7165-10-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|IA0PR12MB8982:EE_
X-MS-Office365-Filtering-Correlation-Id: 69953acb-fe6c-4575-8f9b-08de22e9f263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NV+Io89Rcf+F+mDIXARE6aQWxRY1Du98l6Yk6B3pV7k43mv1qf9s/pSCrvfR?=
 =?us-ascii?Q?oqugfdmFdU2PHvS8ax2utJ4UQEGt09GkcKiW81hcds2KHvC+TWhqnJ9hsgkx?=
 =?us-ascii?Q?feNObdroTIJh+Lt22zQ5ZnnbfuSjPkYjr7+xu4EO1sJe6cu8Z3c//28c2WXq?=
 =?us-ascii?Q?qCRGYKrxXyjsObjFD8om076wyfIVKS+RWMzsIx0xQzlooDuGstr9bOs6OzQc?=
 =?us-ascii?Q?uysDDB3YDbYE8hIc/IOaQdTRENuu4C7Qn5hdHo3LphQf0at+I5q223jlX7tX?=
 =?us-ascii?Q?vV1iKgPRZx0srjkV1ItPkkQfjKuGZYF7MCKPfPL6uE+6xfHE4GCsHHIy4yfg?=
 =?us-ascii?Q?hCgMNdArParTb5lJcvDZ2BA+l8R1YPC2LZaO9OzhBe5cvZQgqsLVgXNK2Zi+?=
 =?us-ascii?Q?8mdV0+uhCcnORxkKyNPqWhjy9NUBlhysJ6H8W3e5Xroirf39oURSG4PJoncu?=
 =?us-ascii?Q?vqSz/0aQQW9t9rkpO2Ram5GiyRXaBgi7XAgREbIdyDXJYELuaC541QQeJjMj?=
 =?us-ascii?Q?4z+u+63S54XXRwvs96RGmJxD0eI26lSYBmZWI1nPWSF6uQpbvgP3GjokQeIg?=
 =?us-ascii?Q?vkIzMmMFmQDxw06Bg4Rdp3kP1EfIGNxAVR6UNuDk+gzc+JYM+Rc5m3QxyBDU?=
 =?us-ascii?Q?hNStMWbC5EWhUbwOgFFSYh1E9zkvpLMcDoVEUCxdS3abFjMcn5sKHbOlI4OG?=
 =?us-ascii?Q?mxg1jZPR1mHgK9i3Mgv3XJ5S/Zm9XNW62MWdnPTIQUtNLCKhDoUt7Ygn30q1?=
 =?us-ascii?Q?oz2L7AavMuDhYkL6BkLk46ZhHWEnHfx/aM4/ugSjcMZ1acLXLA6JJHKjIxdx?=
 =?us-ascii?Q?KZ7Mfdf1CjT7k67fbGRCofm73CfbPCVXGuHbX0zeUeC86F05n6+plRn4d7Ui?=
 =?us-ascii?Q?cS8apbNDY4BkzgmQGZD5eYBOGecxfqaTDNTbMpqmbE8h78bNYF2kdMK9/p7P?=
 =?us-ascii?Q?A5Wui/xM4bB5+zprODp5lPyFJb/34H+/yschHqXPNWvXf84TK2eVQJbYqIIK?=
 =?us-ascii?Q?6bsB8rKvPXf722Jdf9evKF240kZH9/S+SlCXQpMhsI8JkZNgOGBtQbgmAOlg?=
 =?us-ascii?Q?enPwHK7IftlH++Y/KWNzjF/66xJW/GTdauAj/CEtBsaQAIOEXNf593kXjp9Q?=
 =?us-ascii?Q?GSBEpC8//iyl+9Y4PkFe8+ky21wYwA6IZXp6kh/PV1ptxqcwsUACOBiJBciD?=
 =?us-ascii?Q?mP6CagsF0E13Mxm8VhdP8IfdlFtqgFXBWHAD98R6IvVGP1wqB7pIjvigYONP?=
 =?us-ascii?Q?atnP/7JCTJt+8Wga1ktcKYIwhLsEk7+sxyOVZqEmoOwaK9OobjFGtUy/FBHJ?=
 =?us-ascii?Q?aSWTYtO0I6Law6wqwEgUYhAEZPQyWgTH3ymCR4kh31IDYO4nivo9Ol6lfJvU?=
 =?us-ascii?Q?hYTA2DAn5qGC0nRjgVkp6uNb1ijFplUvmJPUSYClQAKoGGHVA1OawZYwI9GQ?=
 =?us-ascii?Q?vOoFC7JvAHxgLQL6DysFUexBZ8/oaieY4aZ0k3/Rqm/0ktoVDQS8BegYlwXH?=
 =?us-ascii?Q?IBKQ/tzMzv5kAy6ePxC5npUNLZTrKTb/fRgwOcJiRm6mrzNLABS8BF3SLmSD?=
 =?us-ascii?Q?PQMY0+7BilaMmD74R0E=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 19:22:12.0698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69953acb-fe6c-4575-8f9b-08de22e9f263
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8982

On Wed, Nov 12, 2025 at 06:25:01PM +0000, Suravee Suthikulpanit wrote:
> Which stores reference to nested parent domain assigned during the call to
> struct iommu_ops.viommu_init(). Information in the nest parent is needed
> when setting up the nested translation.
> 
> Note that the viommu initialization will be introduced in subsequent
> commit.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

I think I have given my Reviewed-by tag in v4:
https://lore.kernel.org/linux-iommu/aPmUD3U764IPo%2Fet@Asurada-Nvidia/

Anyway,

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
