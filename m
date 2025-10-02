Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012027.outbound.protection.outlook.com [52.101.43.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E9A22655B
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425257; cv=fail; b=I4XVOVmWsZiNewAYWAdi3Z37IsVPsPo08JnV8mcYhe17S64ySHlfY4dB8yzdyaixvKmXFm/r4WD0sdIEfnMEHPuhPxmupKvhL3aCMIfIrPfknSKaXqV6T7SZ5sHZSshl0VvHnNZU2Pw1dmGqbp7q332ILix66F1plxD5veQmhcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425257; c=relaxed/simple;
	bh=hG6CeaqnTCZQ69G3//ZUTD619G+iREIoYWRO+4/uC48=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uqb0g3bxX6MuwFn3fhFJha3QxHmY5FKJQ0vkWVR6sz5j3SgdNtbyLev3pfWhZZ6zWKFuMCoGFsoPmh73ZNXD6aLD9p3B3EHwrqhzpjacehbFbq/7+9uheRnikQC59fQ7LQwor3fefoBKQhAnHEbijmVSEFQselnuXkZt/KcG7hE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dVD+Jkzs; arc=fail smtp.client-ip=52.101.43.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dVD+Jkzs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hf4j90I6ypksuuE7sTUlOttPDTSElSrgpGa+GDtW1x9A8yqKRdt1W+oe/hDPcpTbIGUDE5d0Z0ZOypeEzu09Xsy9or+uaOBtJvMfVkrHSCi7ToaCssV7ZM8OcoK3EHn/n/7ZmUrRLAFlV+bGuJCmMV2UGQsY3SlOkLOPIXn+G2l4IGRlwRhE2DE67ghyf30QZsNepqV5K36Z5ohNW7++5YQBEvojqCGGE5GSQcyMJT1ItVuXjVIhOo25UHLzMkccPP+AZd8hlaKUH5SsRpgCJn5Fe4jLtvWiFbfeYlkTakuW+oYgGq0DAO34jM7HKpyF9FbWNujpygdDDnGu/jiArA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfRPBBoNhOojo/5ZWTpzqILU49uksgdaJQ2pDpiyOrg=;
 b=MVqZSri0oSYtYTwfHhYKocDrvjLg6kou2rgeO+PnWT6L550Zf6F00GHTxHQT4wlV6H3HjYmHW89eAE8aGp3dpsBeHeh7GTDpafK4yl0O6GrweReTEG3WFAxxwtz0KK7wKP/SGCtQAyBuoE1h29kUmii74h4HBVTia4srEaKNPxnmrQ8ccLk3gFqRft765IXY295pdmt4gtxFqHHyOciFljw0A4oK73M119gzSkwCXDLKzdsrjcdNMfr9eQLfnhdDVN7IDA1BV6vuOrN2e+aIvJ4pvHvGhcqnasP0ca8KBObVXLHjOrTu8Emx6F8oaq15SoDcGAdHIHF6s+dmqKvRyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfRPBBoNhOojo/5ZWTpzqILU49uksgdaJQ2pDpiyOrg=;
 b=dVD+Jkzs0JVOiX60d15xoPY5M+aQO1DnIKEXII1SD0CmBsYM4bu9jFw6fd+sXmrTgC0R+muzoB6StoAd3w6dgZobN+kgNhqtTQX6vDkfQ9BslfeYq4ziMUDfDnKbCHK33mV4fOFOyjLpRX92uBY5GVSAFw9tawVYDy22Pnud+NKsCCy7ebM8TCDgqE1YMhf7m/Sls6TuNMYwx8xC6EPze5GhgI59axqDmPxoRcP380vIW03Y1VSrc8zvXBRIkDs1koqa0aixUksLoDctzpju0qDCHoRurqy+IjqkquH82zJL/sDvmWm5EKb/jZi0eu8TVmsAUMnYlj7g3D3046tHEA==
Received: from SA1PR04CA0003.namprd04.prod.outlook.com (2603:10b6:806:2ce::7)
 by PH0PR12MB8097.namprd12.prod.outlook.com (2603:10b6:510:295::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 2 Oct
 2025 17:14:12 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:2ce:cafe::62) by SA1PR04CA0003.outlook.office365.com
 (2603:10b6:806:2ce::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.16 via Frontend Transport; Thu,
 2 Oct 2025 17:14:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 17:14:12 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 2 Oct
 2025 10:13:55 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Oct
 2025 10:13:55 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Oct 2025 10:13:54 -0700
Date: Thu, 2 Oct 2025 10:13:53 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<jsnitsel@redhat.com>, <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH v2 03/12] iommu/amd: Make amd_iommu_pdom_id_free()
 non-static
Message-ID: <aN6y0Yrod+wuPdIN@Asurada-Nvidia>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
 <20251001060954.5030-4-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251001060954.5030-4-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|PH0PR12MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: 967440f2-2a4f-4720-66b0-08de01d71b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+0VYkQblT6FIugJZNORXi+dlkqUF2dm8sxyJvp0aOQ4xPsHuKSUiHRzyKpuo?=
 =?us-ascii?Q?vKG2Syxvwxl7fxRJLuJJX403C7dnkIN19wKuNjoWBpwJAE9VIJfC4syMjXcT?=
 =?us-ascii?Q?NCx1cxyQj1ZmYXzbuphhfDhWMZISVvWs5bLjgWdjonuOOk7A3C5ZZ0CvFG55?=
 =?us-ascii?Q?ptKFYzFqsOXLRfyuD2TvZJu9hFqu5yn7Gh8aZB+IXmixA77Y8r+vN6vNdems?=
 =?us-ascii?Q?h8ra+95N0uE0YP9Q6iMjG5kq/aEuFQJhjQfDUP4U0wQ10OA9baAopw7GlmjY?=
 =?us-ascii?Q?bSiN8Y74sXfGZzG3r3jyUe+Mvbu4tUsBopOc0OrEa2ppT75RnbAX/VURWKxf?=
 =?us-ascii?Q?/QhlWW6er6Zy8WyJM67hool9W5A5lpuDzW9gTppHUeyq26g+junAmfM/bQi0?=
 =?us-ascii?Q?XbGzZ/IPfv8bgaaG0qcYYTnNTZtfTAC0bKulTeAe50UehfWTayiI5f/PuueC?=
 =?us-ascii?Q?ihPPrBez7He6F6HEem5kfKh3eissMyF9rgznosmE+xdSyh6Seorwg0Ac1eD1?=
 =?us-ascii?Q?5/zXPV6W1k0O7+uJdj4Yv8rRHr9mXZfHNQDlDNiix2zglF+lnRUXGi3xePuu?=
 =?us-ascii?Q?KsNbtd475B32HArpqhNyUAn3Izxni1uZh/xYjCp62BWS0TNmItPX6FG7oaj6?=
 =?us-ascii?Q?57sYZ4YI9oWwUqIBx3R4wJBE2LPQ/7J2G87DixAy9cQH0FRDpqxrs0m4v2PY?=
 =?us-ascii?Q?AKiOt2WtMjPMbtEyH1DTITLlTLVm8+SpKkGyK9aBM7Arxly5EbWOHUqQDW5z?=
 =?us-ascii?Q?dIR3kMoe22g+d9ol+9BcK1bNsQRECyGOGL80YQfNjcjzGBMhF4oTAB65zesG?=
 =?us-ascii?Q?DCTOZrvV608iLN6/jbkNt/eZgRIfsAFsAXB5K9t8JsF6FEbOEOotWDs3ybtN?=
 =?us-ascii?Q?ApIwm1WameKdrn6WRlKEmewzo6uhNbghqIr4tVZwz256Ln8ffXqWhH7lZJ70?=
 =?us-ascii?Q?hFLpX6/aUGBw52IXnUiz4QDbJUCzGx02AZlgCZAmkqrwx08akg0KpBaEbrPm?=
 =?us-ascii?Q?aZERGe0vcFzRw+l4xbE6B3stbXIX29sxvJwydjKTJAHG2KrRGTfWK4/ZaV3p?=
 =?us-ascii?Q?TGEpiEYorYlLe5bYByF+vUSiS5hpgHakWWrop0miKKFD58L0EM8uGqewCsKd?=
 =?us-ascii?Q?1tWqHjQken6DX8BnthhfxvduOQLT1rFQ22q8qcMqUW9iorOn5v2jrIQGBifT?=
 =?us-ascii?Q?bbjInfwb8SahX9sPm7PP5DLZFtUYRRb+lWrtn1gJomeYgLN633yXpPG1Hl7W?=
 =?us-ascii?Q?8ywOHPJfjtx1pwwWoBS6i2pvkBXmB1hfCjTAhmbPcvnm3msgRWtMVlbRoxli?=
 =?us-ascii?Q?TqQZD7BXc8x3Zpky5RtSe6jAYqpMaH240uOVI+mtbJcHqxTbPWTcLU+yPfQU?=
 =?us-ascii?Q?fXs4xmTlMJERIltIEU/W/oM/t2t6qS+0FrD0lzYpRFZvhkcnm4qsk6w2PHUy?=
 =?us-ascii?Q?lsMgzBN0z91bKWbw/qE1qzBJCe1TThuxT+GR0gxFZ6etNAhNmOo7WdT1pI1t?=
 =?us-ascii?Q?of4saFV9jZZ+iSUBLaHK0Aq70Lq0GANh5Tdc5YM75zt8zUv5bisvN2xVEbcv?=
 =?us-ascii?Q?aSDm/DEvtp9G8r10oGI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 17:14:12.0071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 967440f2-2a4f-4720-66b0-08de01d71b56
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8097

On Wed, Oct 01, 2025 at 06:09:45AM +0000, Suravee Suthikulpanit wrote:
> To allow reuse in other files in subsequent patches.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
