Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808CB273D67
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425877; cv=fail; b=ul3BjtFABS+bLrwR0vmSLFLqYk3wSmK3ki72hKaTlQAOwvkvpaYE0E5rfF/Zjusp0ZIkAUG3YbQ/XkYjp0umP6bxJLWcdigAUFchDbt8WCNxN0yiSIprQqMSCljGVeVt2vyZlgv9a6It2ZkmmV/Lj7pGLkD4ItCGbVRDDSdy3uY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425877; c=relaxed/simple;
	bh=di3cY67Oy/EaalRGlWDjrwa0DT/8YLCm10jbW7N7yqo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESwzlv0o9QPBJoB1JM+v9xddq608xt2K3M5M3cGl/tpsFtN+rMVnHdbatj/Y7iBxsXVtuEJIEkdVvG1SOf832LwUYmxLMK80mVpZIsNDKQ26xYce8j1tw4i3f/drLpemDkT4Nt6Rc3xqUbm4ItTdmi3YAKqfyn812icJp5C8htU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UHFoIbFl; arc=fail smtp.client-ip=52.101.43.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UHFoIbFl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnttcXb5ilDTCVGmmwZ0l58ETFM61adAx6i7LuqURspWDnbS9udqKekk4pSHTILB57i6XtkZl+gS+/i8XN/2UIHIdAf70CGwBozMgtM03unk5FHrNWaNyxit/ISExGORglGFBlXQ9cnPBG2YsoV+UfmEL8Ooj6p3pCEeV6azJI7+NhIh3uP3dtWibR/IWoSK1JM+cNlFCyPI18qHBarZm2+fvuWIw3nUE8zyoNjQWmYh/UM35AkEU6RoTmA+XRZ3Pck2SHT68CHcXIA6KuhvTOdH/F+LSgVfl96hSStVPZGW1j71GDOKwFNq5bkkC1D1bj47mE+zkcINqcWxejhWXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=di3cY67Oy/EaalRGlWDjrwa0DT/8YLCm10jbW7N7yqo=;
 b=XSdmX9VXPohXLfTfot5LvX2gaI/m2wmxyZF9jSt2eA5HXpl/U7X/sbmYYnJTQ1aUaSFp/y4V+fHJ3GWx7onbWgprPtInE/JFBFObafeQNWsJES/1Pp+Ya7pSnY3qSYIXFgR9RQ2vfgH4rMcG4SGRZpke+eiMtckV8A6IdvPMnrUwHCFC/0/FjPEOyBH/yfU/vYorET9GGLMDOwjzg8LXJkpIld9StgDZiQmsCkPClzsVYGrPp+CNxt6Fwwoho2X5tQoJxRC32NTbPrJR1RMvD651Vby3E+oOaevtMefcl8K6iDAEPBJmcFiqNYDFI4E5nITtj/vdG6GTDAb2czI4Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=di3cY67Oy/EaalRGlWDjrwa0DT/8YLCm10jbW7N7yqo=;
 b=UHFoIbFl3MMJiY8JBD135Fc+UghcZdeD5k6OVJ7JcCi2jFVYojAtpNl7R7HcF0jnzhMYMrkFk8ZOIJ9VI6EXAsYrVrtiZ5M1eH7nVmy2vehkR4uztoxyBnoL6xMvWW2ifEbOpSmsOn3mXQB8SIEJK0Epwk8qF+LrkHi9S8uj4eyPSCvnIXJ2SFQ3L6binI61y4eRl+y1/dQbSZ5cO8xPOXy5h2U1slYu3TiWFeZox7c7eS6XyhEACRojrqVRxU8gI/UzcuJQWWxFwB59gRc/v+gmu7QVlK+y6/DodSe1nGhwbMi0EAJUtew/XTYHUDo/C1UKJAd1B3+ANqBCGPHfhw==
Received: from CH0PR03CA0275.namprd03.prod.outlook.com (2603:10b6:610:e6::10)
 by SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Thu, 2 Oct
 2025 17:24:30 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::f) by CH0PR03CA0275.outlook.office365.com
 (2603:10b6:610:e6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Thu,
 2 Oct 2025 17:24:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 17:24:29 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 2 Oct
 2025 10:24:17 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Oct
 2025 10:24:17 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Oct 2025 10:24:15 -0700
Date: Thu, 2 Oct 2025 10:24:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<jsnitsel@redhat.com>, <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH v2 07/12] iommu/amd: Make amd_iommu_completion_wait()
 non-static
Message-ID: <aN61PjjnSGE9VpqV@Asurada-Nvidia>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
 <20251001060954.5030-8-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251001060954.5030-8-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|SA3PR12MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 60d6407b-b3d5-44a4-9376-08de01d88b8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VfV+yqkBe9tJdvcf8+fiGU34PZcS98LkZ7QGuUJngrY5eWnxcMkIaxybjed5?=
 =?us-ascii?Q?nBe1T0M6bJ1E5povw94WjJ7MA2Di+IvW8TaaEpfmysm1EaHwNR9talFcU1av?=
 =?us-ascii?Q?Kla/tmgXLsuyBJ8yxqtm/zC0eCsLNbnZX/a5vIBFqCV2npOnX3FxAH4OrPeH?=
 =?us-ascii?Q?IJxAost8PxBIB3D7uKdVKxL9+OnmcR7Nb41B23i41Cs4BUR4eAree5FJJ81w?=
 =?us-ascii?Q?0b9s+yaQlC6KF+n6K/7eduvTjEOCC7mrWHdDBmITTtLzu4UyKXfCTOHNwx7z?=
 =?us-ascii?Q?H4COp5J4/6z9vIMjEmK4bj2XuiPHyvp/+hbiryE8vhVva8PQC/mvU6csQB4W?=
 =?us-ascii?Q?T0bNqgACqaMDA2zTmNoe8cyyS6AmV82aq9JBq7RHT8mn3P0u8LsDVmTGUZiH?=
 =?us-ascii?Q?0sh00Lc9p3OaPUuoNR4+Q92DFoLhAKx62ygSB5YyVgIY/kLjuTaVfR0z5L+7?=
 =?us-ascii?Q?k9WHwUskAWPn2NxJjxqmwV4fKa942EZ8lBaciPB3emMYqYAUrYoZ5FvRtA+j?=
 =?us-ascii?Q?3Gp+lRQx4MWMSwGPhrdooqUfxCH9Jy0QsTJsVsV6mHN0G+j78AhwOPytScuZ?=
 =?us-ascii?Q?Hr5ZWIFUwYLboc1+BVkeBIXY26AglFK8tSmRuzlKxFlp8uiHbEShtT9xYS/U?=
 =?us-ascii?Q?0bJDTQM+8UKUBc+rCOkt89rBsiVrg65yTdY+6h0hyi6X5CkwhrYhUCqMAlJX?=
 =?us-ascii?Q?S+rHt7hAMzTlnH6t7c6+RngqZPlaWeQAlOSfic+qYUDFbaNPIy5B2ta4BDxX?=
 =?us-ascii?Q?O3AeSE9Ur18f2yuNPirQk8HXkez/12Eo9cJLBShos+fXSrzb7PYVKil9zxbp?=
 =?us-ascii?Q?hWJnb9tOjxiRP5lMTbFCzwv8+Lx9l0JB65Cf10YWeTSFrAkfCYfaqt639pVI?=
 =?us-ascii?Q?K7SjY2qPcmQ6CUbEO1hGs6jvxBDMuwbIv/xIa2TTtqWxKp7Zp9HoM005Eofr?=
 =?us-ascii?Q?nxokIo9Zy76uknf7khPHIZ67KkifhYPSCuiy7sWcUzzwcWy7ktaIOoMw7Vu7?=
 =?us-ascii?Q?df4ATf7Zgn5i6W3nnD4e220vEY5o3gHhsL1Uki4Ag2mlHKjZjIuf+DruQxmr?=
 =?us-ascii?Q?BFA4rLBNOlzyioHwdAHtJuTx47Wwo3ZJfUymDzUXeTgrOtzTdKNxebGH5yvz?=
 =?us-ascii?Q?fsAXdv1GFu8W4f03ZJJHaC2HZHq8Shx5zi19AqmFXg0nLyACAbD69ETRRpoQ?=
 =?us-ascii?Q?bTET/nKYRoVZNkOIcgsmZ71ycTB/xQZkzOe9tw1Ph1bqe7JJ3lvXBBLj1Zf/?=
 =?us-ascii?Q?fX4BjCyVpuwjnhJt7OlgwLoqQb/O8OrZldqCGxrKwhVr4e+beV33CO1IftcK?=
 =?us-ascii?Q?lgrkCGGOtQGI8JH8swd6f+YHgHDV8Avy0rkJ4qxzYxNaNf5fE+zCurc2Z42q?=
 =?us-ascii?Q?NZ2KOufKHkm/e29JC0geMpKfqcnFxIH5GPAwvnt8wbgTyuxRTZw+ZRyBLWWz?=
 =?us-ascii?Q?o7o3WoH3/SNhLVSw++ypX9Tgqmq1xYIwWaBon6q+P+Y3CxNYaFMOX5nGbgaZ?=
 =?us-ascii?Q?utcOgd7h2chbiBXdbCQqQPn0XN3fUcZKbac0g+sCM8hLCNSKVVRpUr9W5vgP?=
 =?us-ascii?Q?Ywf88o7IkkBWu57dfYE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 17:24:29.7416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d6407b-b3d5-44a4-9376-08de01d88b8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952

On Wed, Oct 01, 2025 at 06:09:49AM +0000, Suravee Suthikulpanit wrote:
> To allow reuse in other files in subsequent patches

Nit: all these patches should probably drop "in subsequent patches"
because they will eventually be commits v.s. patches after getting
applied. Instead, we could just say:

This will be reused in a new iommufd.c file for nested translation.

> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
