Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EBB3B7742
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 02:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783478401; cv=fail; b=Y7Gzi/3JyH4Ko2NDFSyhnxAnpPP10m7IBtJJT2RmTYs9ZZLSRmB0inEQuZoUhJFu1K29af8ODJwyp2H2yOyKzqVLfIQfLOI9i2S2sNGatnzi6xOjtzP4NxoMJv0AHT8Z0oyPhMIXdI/j5fKTanDynlVAd/DabtRHr95e9qoSI1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783478401; c=relaxed/simple;
	bh=MlEqeKLg83Ge1PNNofAYRsVf81CoI1MtHLRDdiDk7ZI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWAL//41qBq8uObkZOeBa5bjCRjNazmeTWl0PlUELAscnib8b4z0CqdK3YfRB9WR6xQrIo14bM5RHbwP690oJp49/2exNaGvZmJ0DI2bcpGuSpuAWOL46XIknqgN35dfrbXso0Lx+zhe8rvyBw2Me7lDwbFctAM7gbCtr+xfTdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CL7GQMiE; arc=fail smtp.client-ip=52.101.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CL7GQMiE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFP/easmDV8PmvxUv5VLB41lCGEELUXPvOU6kJPSLIDqKE6V6lzMCgGEhPcn2dEkdo86TZJe63i2WTjGhIF/dCSEmy2rHwZbJ01EgpBuH/DHG4CFR844Ytz/1SD0ICXn5QdB1u+1aPy5a7TapD9FXt37DMgidsD6qlBWP/lF8YDKnSPG61EtqAmtW2hoJX41fqRtotQB9Kf7+sxL03C9DFObgDK1F6ALJdTSuCMS61pTO3PBp0fKTz2DyXk6CfMs8kp2D5YGRoWIemt241UqqX51lvQg0jVZ9SvkafPwwjQ7AUfB0L/wDS7/6c3987UzHi6YzHjXF2otzEShOw8jqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlEqeKLg83Ge1PNNofAYRsVf81CoI1MtHLRDdiDk7ZI=;
 b=O5SNNOKbv6OI538zZF/NlfE6rjU0eqzea7mzP7QofIg8Ha/+SIfdlsFu+qKiQvGsiUSeaDPHBqXYcarzlggNxckeXAiAl+ndXhWWT5BBIwSj8glPR+5hqfZ63qrv0d+bU7XiSx1miRNCF2Nnp4TW3eLtHeY3wPzmu4zFlhG/MovOLRtEY8c6NDDf6+HEmqH+9WkiDMhmbWqmFWKmQA+3jaUXwgpxCZm/A5+BDJIsYnyjJlq/bv4S2AEUmKBzsNIAZARU0EH9JAlzOX9f9tXFIYE+YFaDSICr3gqSV18h6YUWGoTsDWby7cT4862jBNZDhC0ky15+N7uPsQlEaU8KDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlEqeKLg83Ge1PNNofAYRsVf81CoI1MtHLRDdiDk7ZI=;
 b=CL7GQMiEznCHZ1YCluevDvLIuJS82wXoz4yXXGEJ9tvuIR6EKEdv4sXv3xCVnu1bNFhgySSTbHvEvf9MPjaviYXXDh51hTR4In3CcI5Y9I4Fb003hlKJ8TdaBzclv0xn3+tgJ+rUYAfsj1nssXasvQ5VoN4wPW34xbEBn6eT+ls6dJA/gguc2+gU2XQw8H4BY2CUuWnNhs0EmYXUwYaTs8L97GYtOQt8kQvjBVCqFIr0QT0f1XDwECuWxI/fZYSM2VXTVMsZGZ2OuoV7XAKAjMeQ9NV3D+BRFEl+nXAmuziFWeRU3FPyqni04iFsvMuPM9NUNftXaZjQZzD8oVY41A==
Received: from CH0PR04CA0016.namprd04.prod.outlook.com (2603:10b6:610:76::21)
 by DS0PR12MB8562.namprd12.prod.outlook.com (2603:10b6:8:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 02:39:53 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::60) by CH0PR04CA0016.outlook.office365.com
 (2603:10b6:610:76::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 02:39:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 02:39:53 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 19:39:34 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 19:39:34 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 7 Jul 2026 19:39:33 -0700
Date: Tue, 7 Jul 2026 19:39:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>, <yi.l.liu@intel.com>,
	<kevin.tian@intel.com>, <vasant.hegde@amd.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <sairaj.k@amd.com>, <jay.chen@amd.com>,
	<wvw@google.com>, <wnliu@google.com>, <dantuluris@google.com>,
	<chriscli@google.com>, <kpsingh@google.com>
Subject: Re: [PATCH 1/2] iommufd: add hw_queue_init for guest-address queue
 setup
Message-ID: <ak24Y5CKa0U91dBC@Asurada-Nvidia>
References: <20260708015628.255088-1-suravee.suthikulpanit@amd.com>
 <20260708015628.255088-2-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260708015628.255088-2-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|DS0PR12MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: d622e861-b3c3-4561-62e8-08dedc9a30b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|7416014|22082099003|18002099003|5023799004|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	QM+BcRbkSjGmx+y8j1vu6bxMAbjbqxVCagSL/rNal9jL1xQRyVonCRRRA1DMLQM9MX5MW260Yie6V5IIuF/1WxJBu5I4qFHkFkbwcnLYkvCkm027M199ZhTJWrfqVsOWGLMAIJFqk1OKPUYt4c0vcSUZg+RUPY+Rcs3RX5tDjR84Ry91Ua/G8jJhlnB5IrZ7hBwsysInYqvl//HQ5XqGm54Tyd8voQa/ZQD1jrO+d5J1Ui65rWoj2ECFgRcfc0u4cFgzOzqnyvizrfW61GeUyD+V0Sc7pI8NF3DD5Jq4gz0kdJmaP2O5ieIjLb9BWl0YfneBux/0moFzivAxa3p/CEgWxIiuOaBt/Onrqfe+Lka4GGbo8EAOTQksBLKhMXvEUa1UTvljysseADuVYOUgIRHr+NhuhsHb0BwHcRR4Bpc3nfvaVLPt1A15Oj3ZwkNFFxXYvY/2jCE07/P8g5c0zUaYwgoLkv5aereN+OhkGUzsvNt1LyXSLGL2BESDE/RS5jkOspieJQBKHDlvBjHAVq2J2mjkYm1DjwRFcDxHUjiGPOMtpstP43mzhWxcncQxFO4dJIA5LAN80koU0aIZKQC14n/1Q8tFlyTwoLDOIMq8stFgrqxmNy2O1vLBhVLeGwjIfhGkxJUZ3IyyPTw7HsF1BhAqaC2kaGQR7/RxcXwpJ0TNinWUoVhT5fOb/VOybxM9FiK9NVgo37qPQax5nA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(5023799004)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zrfRebMyJZucT6VCys/xXZzVsuEvHHfSoKgKWVeDlaoc5tD/6zm+qqQx5dzofvFJTuVIQcl0zyjvbpiSUk1EwgvqAquHfmGuFsPXuVslLtqIKGH6vVTzyOtUk+mYWyVyHG1iayk5ufbD+lK5IG8JVHeYVyUCm3U6WqU+g4bt9sfmMCwJzvImJAITBgV01SMrhoSdEJNztp9jVZ5gRGUFl2hvnfNXR1RDvSj2rGyl5g+Ucsw6BbbkP/gm9yLz9afDuC52McC67VKJXwlMbaCq8rUyjwNjf689ruPiOzueK2OaG1Ybu5KRKa+jl1yKjlA7ZHn6t8eoA7wmaOik02ThJY4REMBDeOKFedom1e5EDOBQzykKIQ6tKoUNyN0pus3aAZcr/gOerW/9q6QLhlCmfo/pZoAR/pIP3PLYzZShHLVWylGpxbCpBnwuImGpLvVJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 02:39:53.1636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d622e861-b3c3-4561-62e8-08dedc9a30b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8562

On Wed, Jul 08, 2026 at 01:56:27AM +0000, Suravee Suthikulpanit wrote:
> Factor HW queue allocation into _iommufd_hw_queue_init()

Why do we need this factor? There is only one call site. Nothing
really benefits from this _iommufd_hw_queue_init(). Can we unwrap
it and keep everything in one function?

It could be a smaller patch, as I recall I suggested previously..

Nicolin
