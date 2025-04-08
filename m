Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D9121767D
	for <iommu@lists.linux.dev>; Tue,  8 Apr 2025 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744097510; cv=fail; b=QX2aK9LhzEkS5bPC+QkvA95+2R2OWY4AiOZUezF7Ha0kg8NR1Aht5WjpaSnKHuuEQ3r7nydV4lk7/RwT9zNth1jtBX88Mo9Qc0ipDJHxMZJQLgHnKIobAfXDHZRsXaP4GuFr1MAF+S1B/Sf3a2akvBd8lTl290hjqezWKO3LKME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744097510; c=relaxed/simple;
	bh=oEv4zrJLHb2YjoTUXqoaS3VNSNoQ31BbQa/SD4MTetQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4zO9ARH2JoJ2kId831s6JW+Kvk6zzlaDOEPK5rloyYlJfPUiCcDJDKBHV/cxgThE8d2MaVPleC2UiZC/FdgYYPIVvXtFipHK95Y+Fg8qfRvGIt3ujFwCwS7T0AeWTPsegEzo3gebZtSFdu0S4g1qs5tuwJjl5c7DYd0umC4jNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uFOv24i2; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uFOv24i2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbjjmc8qfDnsRk2tSrp/2UQhnrS5bZlC71PKvp77iXUtn7XVS2aPUprlXcdmWE62/G+9U31xZsPG4SKoHca6iipnAbBM4+avQn5qyGdQFMsH6/s9utvGUVZ6dKetV9p73nbm6m583uD68cr2I61LpoMX3fHhvTjDcGa28SRo2xj9eatlg9aoJLNBUD9aNENLL2Nn4ejyhdJK8LVTUiS6ar4cLI2tloxlxfw1AddJYUj1sWtGxIiQyrKK+p/aqrGVaUHJc54rp9Y5FYsZ7935m5m8VaxYbfdAJOpbqgQvUrcJegpuQlNjm2tyB9REWMcF2sjmVK1Vl2ZITYAvQpv61A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sM2QCQfe3cHB2oR0TNvPY5wKjZgzT7GYPABkMcRilMk=;
 b=vSNEI06/qwWgqpFjyT/wbIZHC68fsWfUCkjGjWKkgRr7c6cy3lK4F8MxDREMnhMclVHdqtXmkpSpFphlKS//wZuDDc9RKpzEC+CrcD06wU3Z1jh9dFqipxAbgn2Xp2zuI0rQxzUk3SMRRfT4qhqHtb5X7Gp63T7qKMixJ12Av2SPslka8f5yQVn303yF+X7+OHP8Woil+kI1f9PJmIyUBgHJG99aYFipVXnW/9e8l2rkctaMJdhVhguXDOytsss+yUyUtKn5hz+IsAopUVZzqWtqh6P5FSdNHmBxz92Go8pAcEmdHqQG5wOwkfWsXPgr36zg3un3ES1i+/UmPD5/Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sM2QCQfe3cHB2oR0TNvPY5wKjZgzT7GYPABkMcRilMk=;
 b=uFOv24i2RqOGnNQPkTTCOAt+ysvPrT2Bou174HksCVd6fFuCt0hwkOSo/gJTjH6cyzT/Lnltz13U5nGp2h61U3jY/yqqDkK6ECFYgcBJqgFEwOxGIqc3Sh7MAJkNHJdwFuRwcqMQQMghpn+kxERSkOidvqVwz8Z0LPjR7PDYD9/bdfakuxvtRExmgPOBO6z9XsDg415YJ+Hw0joFfP3I4hIAsTH3JGRXyO47Q5iObQEc3bL6k2fZ3JFqj7ZDcR1vgJNbUzFNYfVLrsyV61L3QDxioh6PCk3btu4OmjZC2xaFhDKdz66Zx8Sd2QLHskHrovP1/RBUm1Gy5/1uyx8TEg==
Received: from PH0PR07CA0024.namprd07.prod.outlook.com (2603:10b6:510:5::29)
 by CY8PR12MB8298.namprd12.prod.outlook.com (2603:10b6:930:7c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 8 Apr
 2025 07:31:47 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:510:5:cafe::8e) by PH0PR07CA0024.outlook.office365.com
 (2603:10b6:510:5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.33 via Frontend Transport; Tue,
 8 Apr 2025 07:31:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 07:31:46 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Apr 2025
 00:31:29 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 8 Apr
 2025 00:31:29 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 8 Apr 2025 00:31:26 -0700
Date: Tue, 8 Apr 2025 00:31:23 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <jgg@ziepe.ca>, <jsnitsel@redhat.com>,
	<praan@google.com>, <kevin.tian@intel.com>, <ddutile@redhat.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add missing S2FWB feature detection
Message-ID: <Z/TQywPiu7Wmtz7S@nvidia.com>
References: <20250408033351.1012411-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250408033351.1012411-1-aneesh.kumar@kernel.org>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|CY8PR12MB8298:EE_
X-MS-Office365-Filtering-Correlation-Id: c32932a4-a73a-4fea-b5a1-08dd766f6b3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+ckhLn5WdjZS6tMGxUmSPtlyPEiuN37sTA8H48Vg38QnQ7Wp1cT6ElgPSkhf?=
 =?us-ascii?Q?QOKSxaHAL4SRjw2KP4EHkj+I3G/35JN/31qd9OiVoCE5VFVm0eJFcEHX2KpA?=
 =?us-ascii?Q?GK03bUdHpMcSsBgSo4FVj1G+YpbOx8w0P7Uw1XKo8CCb4IgxcT0Yf7M0y4hl?=
 =?us-ascii?Q?Fvr9zZUEWi8yb1helUNP9iJ1e80Rk7xWZmnndlbgZgZtH5mGkgxyTzpVCMDk?=
 =?us-ascii?Q?coR+O/TlnR6KP4ONH/6073HJvEaIlzwExD9Ium/OKZDE0a1wh/HHWCGYDCA1?=
 =?us-ascii?Q?3fsoPiFEx6UNo/lrV/xEYqd4etKcTrlH+Pt9/mGRaKuVlNgTpCPhbiEaQJq7?=
 =?us-ascii?Q?rUVYucxKhJMtcTo9k5l8VBI30ihOWpW9Df6Tog3gjqVWWs12BsHE7wJy2ubk?=
 =?us-ascii?Q?oi69IYAgy54Yu1T9jSGc1dd1VKtgfvGo2VcplC3j9n2EKqWHrGIJ+DGX558v?=
 =?us-ascii?Q?qBJu/lXU/Hwvr8b5OqcDnG2xMGmzYyQ6dCbaP7ylOUdlmjem5Oj1Tk/IlG3D?=
 =?us-ascii?Q?ViZ7sDEF0fz8lYZLnD9v/bAqf1Wc4IHSyn4dRK+GcazLjh7AtR2lubc/dp7T?=
 =?us-ascii?Q?tsVSqC68BdWLsPDckgXqwL0JYPz3E8byygiUMcP14fwYTZJeAZ6ydLChexjs?=
 =?us-ascii?Q?RtmCfkr8VJmpPwCeNlTBiu2IdFRCirvQucKhUZYUvSxhLWv9CD/tTV2ka82i?=
 =?us-ascii?Q?1qhiXiHfmCXAiFHTU8JrE2oxdah3BVxEtCjT0BCB9RRBfTZHejWpoTAJQEsH?=
 =?us-ascii?Q?/88Q+ZeJvsOYMDq0zHD1+y8EplqolQWATG8tl6oonXXC/0WnAO5WHX5B4a3K?=
 =?us-ascii?Q?3CxoHy1d8WSFxBHMV1UKvgdjfnbfCNgibkPgkdArA5I3SM3APW57lPtc7eR8?=
 =?us-ascii?Q?rPE5pGwvOzgxqygRuU8He0pWwtoV+K9HHyi1FjZ5u/Chw8w4BdnuRnD5wS0V?=
 =?us-ascii?Q?oZCh/fKxv68YwMkKl6nX+FKwEsm5uM0SWFzCWFtN9H4wl70ILulBglAwQ4A/?=
 =?us-ascii?Q?yAl6tLijZ9zZqIUgICdD3Ubixp6MLmJ1NPH238iTJQ/Kr9C4O775TM4yNZg+?=
 =?us-ascii?Q?mrMAUePdyJnf68p5nKvYouWnABIok7W9J1HuB+mfhRB2B5YN3cOVP2QrpaI1?=
 =?us-ascii?Q?G/bWnHhp9HESfTZ6Ov8EfKaG9fI+SfS2FtWPaSRn/I7b/D1o/Sn0mMzW0dQ3?=
 =?us-ascii?Q?qiM5Jmg5AZsckpwFCkOdzXURz9Z2kvIGv970jTVMkNf8/FHO/avhWB/abGvz?=
 =?us-ascii?Q?+ihMG4UqAZAzu8yP698BggDweoCf13P8DwCr+/v/wj8T456GTvT3KIaMYFl1?=
 =?us-ascii?Q?W/S5MzZXTrBar0lgkCLv1WilEavjyOvXXmXkIOuQy6iVUoFo2XQzAfiYK8QZ?=
 =?us-ascii?Q?zVv6iB5upAHxVc42wk74sbERVkv3++y6r8UuWJ0O3E1LaMXs+KpoBQlf9Tte?=
 =?us-ascii?Q?eX0T51rCg4wfV/B1ypvsc1uOZ45hd67/baeYdQLxOpVBi2XwNiZgvIUrMCJu?=
 =?us-ascii?Q?tn2vPnen0orRJY4WxRv9lgA17AgLk3Zx4WXs?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 07:31:46.8623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c32932a4-a73a-4fea-b5a1-08dd766f6b3a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8298

On Tue, Apr 08, 2025 at 09:03:51AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Commit 67e4fe398513 ("iommu/arm-smmu-v3: Use S2FWB for NESTED domains")
> introduced S2FWB usage but omitted the corresponding feature detection.
> As a result, vIOMMU allocation fails on FVP in arm_vsmmu_alloc(), due to
> the following check:
> 
> 	if (!arm_smmu_master_canwbs(master) &&
> 	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
> 		return ERR_PTR(-EOPNOTSUPP);
> 
> This patch adds the missing detection logic to prevent allocation
> failure when S2FWB is supported.
> 
> Fixes: 67e4fe398513 ("iommu/arm-smmu-v3: Use S2FWB for NESTED domains")
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
