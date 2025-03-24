Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8468525E476
	for <iommu@lists.linux.dev>; Mon, 24 Mar 2025 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825270; cv=fail; b=T3j6RiPDPvAjakRnbf0ejBgdMl1xh9Jcd1URtbu3txq/q2LEyvgD1Qv+v71m501i8tfVPbzm0cVaQznqP5My3do1+S2cpeE/Wroc0FwDBXzLcWrBQOWGIt0jNjnclgTCRwqqFMKGjlsI3FbolLrp5BwHQEkhFDrVJdZEOhc25Xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825270; c=relaxed/simple;
	bh=+99louDlIsSgxwM961wto5KwRNynxFYWA6HWgj5DVZM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHoAQFBpt1Qd9NLaASZuRyVjXFdE8C9NbgXlKiLqac5gQpuMuknXxmoG8q+RUMZOaeezKU6tyz6LBEgYNiqnNS6rtK5Vr5IsheKEkhYohvtW0HPe7BV6QlQUTzqpUMvFD1PRK5aWhqK+J9cFPFGemkCI3P1LsWrvD1Hy4Abr0s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=havEg1E0; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="havEg1E0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/BROZLCRzEQ0FOG6EO2UxkSjzlxykFNcguExjzK15vMdaAx2CFMYPoM35jDOBQwnsy6rWLnl8khVDqv+ykUGxtZ1xKKRjAUujYOePYqaKsMw7vWEaS9WGn+GkgbN3vFiM+aH7JTKcs4gerJO1G8cwa8SPbKQ491qEDAuiYQJ6f+9EhFG6rghuk3HwQztodVHCpxmsqh5/6cuW8MeI92tT974yaRI7grZZCwd/VEb98wSrFRDxTwi1kLAU+EqJuC5XxN8DF+fmZDrL6txEeZ+nhw77/ZLeSZEzZ9OBTkJ1TIGJBNA+dNx7DYdxQ1nv7ub+qrmMWXRu1D1/xEwxweRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BozJLyiZx3uCZDQtdqFsFsMYxTWjE3A44LSlnA+gwXg=;
 b=BMD4xstiTdgFcMKn6x/e+2Dye/XsUabZWkqO1GbbGle87wj2nYBakGeHaPwLgk+XsE61nL4rdcH/i50q5s2/99zWHXIx1/Kcd/UniEEVgfgSOqTOlP6JfU5Wg6JjujQwJ7N435m53kMFxZvnOKOexnUNBTtS9b+0etoSrle3H8XPz/1RioLWJCw9T11mBwrbKzFoHVOLjVNQCZmxBqgbNKfSb1uIAk/YstRosGHrhPL2s+R1B/g7zmhi7zSJOc9irtzUNelVj3xH/cQ1wHtUsMBsvGrUQ+d7O4f0OPIwgqBBVKekkAe+H75xzcRBtvjK/P7Ft4Kv26wSwSzdkA7zMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BozJLyiZx3uCZDQtdqFsFsMYxTWjE3A44LSlnA+gwXg=;
 b=havEg1E00bMxQkYNp8EbvcBLvNYZ50r4HnqeInEoxcPLPOu8O4WKWt83tuVl9SGnfgHgZxyfpSmFqh0sb9oEHolLLkYcSIrxXsdCYPdoPUzIjWSet0S1vo8fi6deYSghvAoN/W3YpWoOpVgSRMEOy3Z7cz1Srv7g0QyvL9qf7Y3/ONDdnyJysXSec5wKmcyl7l51nLi4zCoJHvbYWvkfZ08IEh9M40af0AOIDXD3zQb0Fp8nUSuMpvykpmph50jnUSD7jFu6wcETtrYcb4EJ+EWl8cay2XxMyxX9QCWPTOK/D1CLfJKa9lvmLrEFhygisiHnBLdn3Plo5aCTaMHVLQ==
Received: from SN6PR16CA0041.namprd16.prod.outlook.com (2603:10b6:805:ca::18)
 by IA1PR12MB8221.namprd12.prod.outlook.com (2603:10b6:208:3f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 14:07:44 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:805:ca:cafe::24) by SN6PR16CA0041.outlook.office365.com
 (2603:10b6:805:ca::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 14:07:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 14:07:44 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Mar
 2025 07:07:34 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Mar 2025 07:07:33 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 24 Mar 2025 07:07:27 -0700
Date: Mon, 24 Mar 2025 07:07:20 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>
Subject: Re: [PATCH 2/2] iommufd: Balance veventq->num_events inc/dec
Message-ID: <Z+FnGDS4jxQuNi59@nvidia.com>
References: <20250324120034.5940-1-yi.l.liu@intel.com>
 <20250324120034.5940-3-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250324120034.5940-3-yi.l.liu@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|IA1PR12MB8221:EE_
X-MS-Office365-Filtering-Correlation-Id: 3854d6e4-3079-4ecb-fff3-08dd6add3fe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0gammeV6Lea+n9GV8oF6Go8BAyzIeCzCpij1EgRiltJBukzCzLU9xH0WN+cW?=
 =?us-ascii?Q?CXvW+S21vOsNZKIEqR1nz4Kmqb5YO7h/a7zUsM1Q/Gk38lK/kDpjDJh51ADT?=
 =?us-ascii?Q?lQBGcYbpa+nPq3UjAiiaqcKdcKeXfT7foh5Fk0Dm2qtELqcpBG4bbE0eVzcg?=
 =?us-ascii?Q?3LZic2bN4BZCXDID5xndiicWXiZmTX8NPAzjz01ZeWkyBf0IOmKtSEjZ3Tim?=
 =?us-ascii?Q?Ro8Bk3u3u6TYgaHjdvZ6UWKpmnROhUCk6nD+g5Q9CZP2o4nKH15pYo7u4qI0?=
 =?us-ascii?Q?Vu56iniJK3swxPidO4uwfeEo/g/QR5awFo+K5Y0Lb9z1n9SVCJUOrGKRSvmr?=
 =?us-ascii?Q?MWG94UmKJeDnr/WZbgthWA+Aofxw75+bJn3mEC5SDQoxnl9KXr6TN+NoqO3F?=
 =?us-ascii?Q?PfKxeeMRUUBinNLiGHcAZjBe0ihq0+2ISaV4pto2T8MFJDVMaMHdUdvVarry?=
 =?us-ascii?Q?SrZWo22vtKsJUqoxa3swm3NnLnJqeU3m/P8XgDTV4ky5kSLSGEwR6Jw0540N?=
 =?us-ascii?Q?/s0gcUFS6NE+PmznXPKJMIQuT0ra3UWnimom0Aee3K7465Hhh/N4lNvQ9w5R?=
 =?us-ascii?Q?wMFUH3UbKZ2lvfcGJK9nSDmduK0/NN/jQUcfDsrC5pMEBXp+n8iw4kVSgBt+?=
 =?us-ascii?Q?uSwPCqOrkZly/kzWGBMfnjUkz1KjheaO4++H7ILf27t0qodhuxuz0T1kDEjS?=
 =?us-ascii?Q?SBLSUdyb0r4O0r55qKPkF8XW6oJch9r446bU+0oMPfQV0K6lc6+a1r8qqqo4?=
 =?us-ascii?Q?RZ+5gNKxqvyy1KglU/BIwzh9+QO6LfmyT4VIkohe484wxWbSENVzA6q8HBI8?=
 =?us-ascii?Q?10X4BHZy1s5Wip4rzzRmqrig+n3lCG9oLmJKFA3hekORnHCq1iOwqii3HBvM?=
 =?us-ascii?Q?31ZSMEsGbGKr0whgYnbkBeCozUwHMEATEySU6Xv+ONlE9KZr6jZIEIY0ZAuF?=
 =?us-ascii?Q?TV64c9zQrcaHr7MUPMHbOXF9Usn201VH9A23QNMVTfO1XHE+X63QSqgjKYuL?=
 =?us-ascii?Q?932hs9FXuJYlJFRofUJoNUlAFOr/MBmHQElAhhUuc9bA937omtj+SqWC7jnU?=
 =?us-ascii?Q?OTkHfr2PaQuNoTW0ZSgX+TK2u1rlnbRMsF1Lc0nsZuIymc1X8l1U+tXr/Hpw?=
 =?us-ascii?Q?A5qxQyW9xarDMR+fHQ7c+2kPYkzFhOEtUlFEURWUyr2Bh+XKZM3yqmYJ2i3L?=
 =?us-ascii?Q?JCr+lWyPv/UxAj3Qppn89pY6k/9E+x+ZoObTcy1pKxP23JVIZ/Y+m9iMCfqZ?=
 =?us-ascii?Q?ACWJMfxaf9z6ZbLUAf9FuH5YubUkYMC31hfgedtZZMldLdTGiRCUpy4/hTyC?=
 =?us-ascii?Q?I7TFVt+hJ39kOo9C3xkiZgPPRm+XC8P7DuahX1PeVFCHtY+RusCgp6fezmpS?=
 =?us-ascii?Q?txoUpf+RF0CqD3n59NuIN29jmThG1jlGMdP8eyh46M/iWElpQHUg5jQ36not?=
 =?us-ascii?Q?YzzV4ZTFoVVoITEdbtcCl3X90l6rXFUVoGE9lG+KWCLfMlkqsAH4AZHrXc/A?=
 =?us-ascii?Q?jrM90FHm5tWoGrU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 14:07:44.7386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3854d6e4-3079-4ecb-fff3-08dd6add3fe2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8221

On Mon, Mar 24, 2025 at 05:00:34AM -0700, Yi Liu wrote:
> iommufd_veventq_fops_read() decrements veventq->num_events when a vevent
> is read out. However, the report path ony increments veventq->num_events
> for normal events. To be balanced, make the read path decrement num_events
> only for normal vevents.
> 
> Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>

Thanks!
