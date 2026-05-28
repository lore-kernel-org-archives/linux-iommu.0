Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5E6409623
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 18:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993533; cv=fail; b=WNYPFYhiucEAk85YvlYUUveJQOT4oU1R3M1pI7lR/eWumpxD+e+P34ZndFGqEVcjj92DXemrQHCevZuibWfhHe1vDIHYFTzi4cppBSHaAp8SJVApcn1hnzHR9a96C6H6ZdDKmkMTtT8Wkxjhm5HrxcRcPQVqt/B47ivXMn4JhvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993533; c=relaxed/simple;
	bh=XUHtoWfSI0zBklKJWLh8UzwNbItjMgYdnGATNMy/D/I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ij91IAiWbu8Q4DJbTag75czLNEO//0P4xHT5FkjA3+YzskNL57zcfO0yAeQEisG4gUZwuakYavWRBZ1JPPZAah4cNjA/bnRVL2eu4zByFqOsN6VTPV8gb5H7VQY/5TmzJl/mL9DuKoM1enQ64YGqqEVCreCm1qAr+3BTbiQ8ySc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Us4BWpBJ; arc=fail smtp.client-ip=52.101.43.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Us4BWpBJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbaVlUZtfPy7ekReSB+0nZbnBoLfNIRG/tBiWfqAuTZmAvJPmKKIuVQaC8zLwXuqnaQ7qCe7DPhe93hH/QQ82csqNxBMW8CkLPJqGrHeHVNktop0jlz4ht/w4pnaulicL9iB8MnVRhhhafI86TIjezw8AYuwbHhbw5kjEYC+X6HhlyDgSIoSXCUdUblV9GBUD5gl5QTJNF1TNGeeCWhsPq+4wuzO0GIZ9WgztpZGgW6qe1ihd4u0Q5NuewwBsVsyxzTt+xlVuwVGzL70yJQlNNSeGQVf6Tofj/dXi4FzwGyzskLEGLorDCBM4EkF+qqo7OD7/VHEEKyaAHKYFnDAZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMljIo8meyPcMmKVwt54BK7LsJAnI+U7TUyTujs8i+o=;
 b=MYVvekuViecSJYV2M2T2JZQwJlQS4Nm0EIxhqbPeD79uxiZznv16YSS4b9fN4wVe9BQ17LHkaBEswneWZF4SIIN63QJjKeAGKD5Q9P1dKSJ6bKUA885MUs/pa94l8VCYyPLH6cMKEk6WQNOwu4dKN1zPMe3USfZB5W5KnrsCneNHw+3fcxnnPxjg2B6OfWu+KCvzKZHFlfhZ2yIZxU9gJjz2ZhC1OmwjjNBrWf/xTnVTq3leGlH9NJDF8nhKlwBOK34QCMVBDxiccBT38d4PNIo55EhrGQ8E0yE5cfx1SIlUPG3J0r8Nv6RqmcjA3bat/Wrmu2+n1tXexDBB5SF5gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMljIo8meyPcMmKVwt54BK7LsJAnI+U7TUyTujs8i+o=;
 b=Us4BWpBJBpTBhGFFgFFu83XWqEe7VA6DwNkJox4s2f4qUDADVXahPNp9vSJ1POF5Z1drSYJoKfcofp7rYIag27fuf/+Ti8cQPIVZuzcXUCAdx9o/pWjz3eC1R9TINy396JKx8fvTELCZTxfmBZNN+qHUhhyb2ugmqbFbbc04d4nXSaMVZf5bHwD3FahbYNToGXLvR99zjEm28EKOgaP/6WO70SZIFqpNxO+cKIgu7Y9Nrm9kx10r1TzvUe8ZBMBeKhzPutLIizBz62LnhWUfb9Etl5K7is1e3syvKjSqrG0yks+46eD+mO6gkbUJFiVwKgGSG9PbPzbXMQI0wyRscA==
Received: from DM6PR07CA0079.namprd07.prod.outlook.com (2603:10b6:5:337::12)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Thu, 28 May
 2026 18:38:43 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::72) by DM6PR07CA0079.outlook.office365.com
 (2603:10b6:5:337::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 18:38:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 18:38:43 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 11:38:26 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 28 May 2026 11:38:25 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 28 May 2026 11:38:25 -0700
Date: Thu, 28 May 2026 11:38:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Ashish Mhetre <amhetre@nvidia.com>
CC: Robin Murphy <robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 1/2] iommu/arm-smmu-v3: Detect Tegra264 erratum
Message-ID: <ahiLoHUzuHHSw51d@Asurada-Nvidia>
References: <20260528101617.4068249-1-amhetre@nvidia.com>
 <20260528101617.4068249-2-amhetre@nvidia.com>
 <f25b769a-d89f-46c6-a3d2-9fa35882b848@arm.com>
 <c9390279-24d9-46d4-a644-797395c2eb2c@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c9390279-24d9-46d4-a644-797395c2eb2c@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 51236ac2-552b-4384-607f-08debce85864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	E/Cxm3JyKQh4WRPVlDgsYRup1mtGrq0iy98BZkqG6bsGwrPdW0Hq0DwblozwJSPVFueBepkXzEauwS5RboqxWgUW+GE0ug3IyL2l2+wFs/cG5IQXY47KaLBAqi0sewpk6/rekOvSCzJf7JnzvbuPIwRBSeSI0SbUuLSr/nfhAV780YXkMrF706DdC+vZGcuU2vwMyMPsQpFjruUVZj0ZHj5prKAHEyoyECr4uzSVIfT1z0kaCRoESzbJKzy+2lLUQDIZEBrzIJYNOSDD/UFAz2zOnczZcW0m/NRv8oG6RWf6uC8L7HyGUzH76+ZLvulvbgrtEzaUicxdvFnPyHRSfaauENINvIo70PSU01SgvEyzwsI7M4qtk9A9WboFdd4GqtUOtiAqKmp86BzeUZNBGxiV1poFsOOTyPt5up0ZpYYS8CzAdaIehBaGzMAbr+/5ZjOh4zDRschfI1er7DLGCNWsOLA6v/1MZxGEAmrgUCT76OV2Hwh75iV+1wrUvReCRQBlPuuY7Xduxkodc5Wod9Ld5HRKKltTGJLPwaLtvOkov9K+13jQP0VpUi5H6HSVNgirmv+u9xWL2zkONhF9KYQNpe+S7/7d87wpHqslKWIHJ3PN38eRM7rmCw9KiqBMzNhYNjrmHV1lTgYZz9o7rl9A8se3B0m9IKwfeF/zvLpIZwnm97QdkmGDaGc5eqExyWOr0n5CWh5r8BKDUxb7NyDaTkIc6nasokX17kG3zyE=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jDnJdJO2viJ8vptYUaF5XYQ0D8E/zQti+b5HIvuf+ZCcCktN/7cegHQo7qQi/+tar4t9y+be6M9cI+3QpR/8TCcIioZoQZ4VBi/RHRCNLWXvEb8ctVYwWGBRGTkKFPj+0YlB4E/Rpfb3Lza7IsR32cbXT0K6Oh+AE7oW0lqZ9qU8RsH3EIgSyojDM3teMULh8gqSiPN6VcMqO9liM5ZE69f3HNJjKrlDMGP9jiRmUy8CXHLgMdbguJ5jtdscvcQOCMekTy+sHNLTZxmskFT/5M1jBOTqniHINdUkH5DSd84st65QOzFyksCoQWmtbE4woKKjo+/TjUifZT7RaU7XN4GiSFlmyNzDqEJ7TcI1vOq9z5s/OqB5/iYjD+A1K69/5OLOQwaQnq9NBnKj11Fa0X+oQGtCekC/XMmN6MO7d+nuL0yweTYyVjWJb7krskPk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:38:43.3176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51236ac2-552b-4384-607f-08debce85864
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974

On Thu, May 28, 2026 at 09:36:34PM +0530, Ashish Mhetre wrote:
> On 5/28/2026 4:04 PM, Robin Murphy wrote:
> > On 2026-05-28 11:16 am, Ashish Mhetre wrote:
> > > Tegra264 SMMU is affected by erratum where a TLB entry can survive an
> > > invalidation that races with concurrent traffic targeting the same
> > > entry. The hardware-recommended software workaround is to issue every
> > > CFGI/TLBI command (each followed by CMD_SYNC) twice. The second issue is
> > > guaranteed to evict the entry. ATC_INV is not affected and must not be
> > > doubled.
> > > 
> > > Add the ARM_SMMU_OPT_TLBI_TWICE option and set it on instances matching
> > > the existing "nvidia,tegra264-smmu" compatible. No callers consume the
> > > option yet, next patch wires the workaround into the CMDQ issue paths.
> > 
> > Can you not detect this implementation from IIDR like for our other
> > workarounds? Otherwise what about ACPI?
> 
> Neither IDR nor IIDR flags this Tegra264-specific bug. We cannot
> detect it from any HW register, so we have to rely on the Tegra264
> device tree.
> Regarding ACPI, the bug is in Tegra264 only, and Tegra264 is
> device-tree-only. It doesn't support ACPI/IORT as of now.

Let's add a note in the commit message.

Nicolin
