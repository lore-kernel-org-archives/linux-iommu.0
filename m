Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2D03A6EE3
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 06:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381655; cv=fail; b=AoTa2Rj91ZfLY+y4Pj2yWCWmuM+MxwSrINQHi+yEWPUzJImqT7TUgFQo8WJ6pR5LCRH0z95QxI3kjLl+e1DgEgxCKwVBO3awEtWvoAuTw8i3n0ifX7ywCjXerS1Rd2mUEQq5gheRMbYztiYAJxpegLRhu0sZRX97kItpk50o9EA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381655; c=relaxed/simple;
	bh=N1zr68Mu/mU2BHofpiHvXeYXcwY3zoq9Z+v45WE5IpI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpSV/EVLY+Mtppsah8TkcaldFQGxK61+PEDmn88Aw5gI5MHsuLXJbNqsgXGHWRTtyXbQB6keJIcvBdA6r2dex33BVs30RGWl6T0Qa92ORjy8C1Hp6L+iTOYiVhywdlneE6lMIzw1r6/8ovXFKWPNurQMcBKp6BYiZ1t8su4cRkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Oxv1IHIE; arc=fail smtp.client-ip=52.101.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oxv1IHIE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=McJRapWolL12TbgVZkORbLMfoKQBaxXH2kmurBKkU0DEUrs8rzbqAjH3JNMuZ8CSy4/wCf0Gwv2RMPt8swUWcB6WlGJxnKxVaCgg34IgwbGZLPGXwDQ2tiz2siebp01ZEx/r8IxtmfZtPLoxTpPxDE5GNIjYHfm4tVNNGAM0FlOE3SC2UqPFzXnzIQsQgvKDdLkzIU26RqqNmjd4Adil8YG1LrccqeeaPRFrI2RXCEobKxDAOz9WYUnUVsXWLm9xkKLy5iYwcB7PWRFzlsN6h9/wrkvqIA8rNQpYKZuNbJ6MqU47fsRriJdYWLv0wQJk8/tulpYSq1S55NsyVUefeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWsoqaXogcJzHjpSn0ijDMHF2kz7Q8SKMNXb9noTTjs=;
 b=LmZAH0NvZiEG38Xf+4yxpbVCHXnZp6HwzSmLtflIZWMZeFV7gKYgXvExubDZIe8mWIEEKKXL8kN1v0pJf4YekO56wat/jToOfadQmkTQgITp93AaaXzlux0PrjUff1qecINuvtz62i0xvyKtA9d9QJSQVsbttdS1EXSaRjCslKhMH2hMamDNakSSyMvWITt06g3Tgj8s9+8/KoLDDjyBJli3Afox4XFWB9aQr4EzRAyyTCrFAwjHHsGuf0NBkVoV2NAnvuhYpCTW0UvZGeEIGPvPDzXnOX/TiIzC4JDsTNP6XY0IITNz+YFFv/peIp5E7z1bXr/MNVFkqnNbvFLXwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWsoqaXogcJzHjpSn0ijDMHF2kz7Q8SKMNXb9noTTjs=;
 b=Oxv1IHIEe5Qx41eTaoTBEAzNvBC74qozWKfM8rBeyrxaggOZQboexnR/mEI/+vvFQ52vFQLs3q04XSU8p+anDdTsmVSW8n2F8Gr4U9Z6j5dFmGHWQwH8lzpVfiYDhzgtw5SIImXpV8JrcUAEFhnU+pqCT7xBjafaXhJS503u2AndpueUmPUP1Z2Zhp382laDqD1iL6+UrfH53N8LHKrpQxU3P8onIxtoK5n+D4iaWpcau7pMO4bng4H1XKeWIKF6J5SOtApkLkxc3DBTkZOLwYQFBkKz9ByY8/Pay9vJMd6xnGRnNV7SfWdHjqdeeH/oVIXlkxjIM3krzDotYKxF0g==
Received: from MW4PR03CA0059.namprd03.prod.outlook.com (2603:10b6:303:8e::34)
 by PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Tue, 2 Jun 2026
 06:27:27 +0000
Received: from CO1PEPF00012E7F.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::53) by MW4PR03CA0059.outlook.office365.com
 (2603:10b6:303:8e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Tue, 2
 Jun 2026 06:27:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF00012E7F.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 06:27:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 23:27:17 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 1 Jun 2026 23:27:17 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Jun 2026 23:27:16 -0700
Date: Mon, 1 Jun 2026 23:27:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <joro@8bytes.org>, <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v1 0/7] iommufd: Fix bugs in eventq fops_read paths
Message-ID: <ah53w7NLyxoOO6PU@Asurada-Nvidia>
References: <cover.1780343944.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1780343944.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7F:EE_|PH0PR12MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 5888aff8-f5f9-4ec3-4a51-08dec0700401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|13003099007|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	aPRceF7ScxuZpQ9BawVElHwWF2mZhpEK+CZjGaIfusQuRnTi7NUvQbH9ddC425OfsNDATo0P0ctyKHtUeK8nTnxCCDU/JaDYEUwhIuKrsI3JRvnaXkVRBxl4rDPGTPZZTZo42D2dlpDrBXbN/DeLff2mC57JOMjyl0nBtzU8OhIbs9OfgWeYxVEy+cQCQkLK72CGjUq1IB7BR8L0WUbiDkdP+jb+AiTlRWFColuxlSBYyi8vc8/tHzSv4MElECMxIrRAnAq3dLMmBvasWRLxMa55tAPvpfU0zLaHHjlSUOdyyYnn4B8BOhOaMxigtZhwytb/ncxeIEySDQqWQv6KZbGHoCyrG1hPR7hunGMtEKYj3p7yfeECZo+/2H3iKQzm7whqIBshZ7TOLDEBhh5Mz+KbqZVA2vnC+MR/6DrYrG1QoZrQMmgdhbIAXDgqKMR+wG6qL3BJjNhWhNy27GYaLCgressmu7pq3a3y+tOBby4Ss8CymDJNGsulRCCsjzmc+y0wN3QWrLYKPVp1/i6Nx1AlEma+ACl137v07D/7+GMGP3bClon/H/jlO5hRfrHT+TiQtqI2EvuQ8zn4KQnPLAlCm/1MKXmX+s/QtYP79++9iDhupeiH231sTwiW1Nq8u/a5fBpc/dYjPzubq1IFhbMnOkZVJ23JSwWCTe4IHJmSMqCYvcSEhjKWN6oUQNSxm1LheMxYOlI1nCKdx6A6GpA9DtG7BmHQl4PyIZQsA5g=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(13003099007)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ntCwbW3f0D0kBkEKW9GqJ4qcug30QMCeWHJ6Sr/gLOnMAlnNa3pD2m7e58BwbGWed+z70bLc3KO2Il55jphMmDCPuvM5br+QVe8jZ/K2nqWEDy1gag23NM54yGUcbTkKKqDCAlJNE0oVD8u9JSSbYgraDVoOdGci5ceSZeRMFZ4Am5WrTV1D0Ihxpj2T4rwdmwwJvO8l5NCZVnDo5Oh9LPuFGJQOjVkM+zraEMyu4jecNoLLUSUDefzy9iAusA2We2aKgsizE5lsdaU6Umg0aa4a7LJNrT8FGrEbGU79B894lO4hmyR+bnxReQzQqdsD6fIGWTGEnUbebqJf7sv2t7i0gRITa417AIJtbuW2qijOPcLs2Y6W9MsuZFJcWaLgGkoHs5gl1h8eTz5eEjUzCDHn3bYNkz5w/1KSYO3V2gr1x8/5R2069qV3OBDPTDcS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 06:27:26.8193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5888aff8-f5f9-4ec3-4a51-08dec0700401
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E7F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7982

On Mon, Jun 01, 2026 at 01:42:31PM -0700, Nicolin Chen wrote:
> Bugs were found in iommufd_veventq/fault_fops_read(), where userspace may:
>  - Receive a corrupted byte stream after a partial copy_to_user
>  - Spin in a poll/read loop when reading with an undersized buffer
>  - Miss notifications when the kernel cannot allocate a lost-events copy
>  - Receive duplicate faults with stale cookies after a mid-group failure
>  - Cause the kernel to retry the same failed copy_to_user indefinitely
> 
> Fix them, then add selftest coverage for the vEVENTQ count validation.
> 
> This is on github:
> https://github.com/nicolinc/iommufd/commits/fix_eventq_read_bugs-v1
> 
> Rebased on Jason's for-next tree with the veventq_depth series applied.
[...]
> base-commit: f25989c19028e8bf81e26e1133a99e3436c3afc2

I realized that I sent this too fast, before Jason's for-next tree
is available in linux-next. So maybe this is why Sashiko failed to
review.

FWIW, I've done a local Sashiko review, which came out clean. But,
maybe we can respin a v2 once it collects some comments and tags.

Thanks
Nicolin
