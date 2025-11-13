Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011017.outbound.protection.outlook.com [40.93.194.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119AD311C30
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 21:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763070755; cv=fail; b=fnNgqLFfY1MwQ/TbAh1Np4+59Ss9HnJx+ZVlWl8AarNXEufq8uLHY0uELW4CqxH+EvDTfbtlaep+W7c7U/PQVGMxkA/tL6MOrD/XN6KxiPQpgMrrqeZi9HdVl5+g6PUGQ9xVFBRFohWGl8q22+eEXIlA+Bu23o/pHFTivZscolo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763070755; c=relaxed/simple;
	bh=jwo3NeNzXvh2SkoVUHh3fZN5QX94fAvwvnhFRVjWd80=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGRv9OQU5Y5jwi3OzjE6NIK0LiEp9x521EvPjVUeTBR7TY8EKDX6sanhd+nr2Mo5vfTUWRSmJUdWwtwqIe8KYNxW7NAj+6BRpdNbcSYPpKB0bC2s5NonMDwJHR9rSuTeAhjDyOz1aNJ7hdrbc23KHtlWC3b2gkoWcSQvr1xqyjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CKK3+5KA; arc=fail smtp.client-ip=40.93.194.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CKK3+5KA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7lu51xI1gVxZkyLgGZvUJA/hxTrIKluN/uuWjqXq9iwquyXzC1t9dTIaWiF146FKXGIobd1ojZOjf0xXHqwoUUhNM8ex265q259aFD9QZ9w97S6n/Qya/LvpSTf9bwjgpMq5bMeRgGPF0BmBc8Uv+451lz87DY07CQHnyWJlWwcsileUl8kJAap5ZDhq0UtU9UqRArLAQIxvV8Bqt0J1yKOQlbXZs+YqXO7YXZBrOqSmNjR/f13TN3OmJZ2a8c75MqOd4GLfbF4Hq6LVJhshOUbC85jcHozyCbJBjh7HT/CZqPRh0E4ugx5mdBRxFvsGg3Oec8vhis6j96QZWpUTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zG7XvidscKVJmceberXnX89oPk+IR2/Phps3709d5A4=;
 b=TZG0rhoR9DhVM3IHB4qFo6MUbgVfkddZD4stkQ71+LiYEaCGaewv/DjRMwu5nDRs2X+wjiNQxhJ3A2BN3u15QrUKq2p4o5W0Z++YAQcT644QVMa5ewk+N+uyrRZjDNiH+7ZipVQl7BEziCLVxRUze9alHN2bzsDHIvqVOdzgPC9DpDWypibpxdt/o5gI3XYULPT3PDy0hqkCqjLbLEuX/ywhLQ+HvU3pI+7Baa40jgLVfN0VaNHDEy50RDjivc3h6MPR+RF75tdIVksWgObtPuyOkLIGUUEndMXTo+e6uzAgMPxSlygHStORtdbUDdSlvR2KFKCjUneZADlyDTUUJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zG7XvidscKVJmceberXnX89oPk+IR2/Phps3709d5A4=;
 b=CKK3+5KAQODNWO4UeEM+t5Ujw0J2uGMcEaDzkw5g6Qm5FMmF+J6kgzUEo0ReFEsroNYgHYAWkaVtpiWsMIAT5QZq8zdf8pZ1GBzCtAT7LAOy/oKaOlNZEdP54qNnHK8fBDuQb8Czdlcv1PFo5p7TN4f9hBE9WtsUn2/EM1FMM0esunZv7C8uDi3ItXU554XXCDsIBScibmwsORwvm6ioJ/lbyG1xCCdrWJWl+aRbqod3wBLeaSC8NrM7xybCFbP1PYUmeNhYhTSNr3uzAT+ACDx+pwlI02Zpq2HhToBZnD01kX7AvzwMtw6MEWxLrwyg2sXYSZNJDXVEgc16RQCXhQ==
Received: from MW4PR03CA0024.namprd03.prod.outlook.com (2603:10b6:303:8f::29)
 by LV8PR12MB9084.namprd12.prod.outlook.com (2603:10b6:408:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 21:52:21 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:303:8f:cafe::b3) by MW4PR03CA0024.outlook.office365.com
 (2603:10b6:303:8f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Thu,
 13 Nov 2025 21:52:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 21:52:20 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 13:52:05 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 13:52:05 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 13:52:04 -0800
Date: Thu, 13 Nov 2025 13:52:02 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<jsnitsel@redhat.com>, <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH v5 00/14] iommu/amd: Introduce Nested Translation support
Message-ID: <aRZTAgxpA8/7216A@Asurada-Nvidia>
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|LV8PR12MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1870ec-0e1e-46ba-6494-08de22feeb7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|7416014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zIRvHloY6y2hXyE/3y74CN6qRk89B/uGQo4xSi5FYX0Rk4rb+4xvvzuA3hsh?=
 =?us-ascii?Q?JazL+Mj8xvdARC0yT77SIl13Xfvxj3PlTad5o6SbeYw5GKCSqLwr6iPANG8b?=
 =?us-ascii?Q?ouAe5WVPITqhSliBSBt+r2clfo4I8N6sdl3qIdoXljy1RrW3sh7svRHyeAcQ?=
 =?us-ascii?Q?VNm2aa5Q9/iVVTZkDM9Oxu4dRvXZVRW/QYbH7LgKzGDR223LkwLPChBXQr4t?=
 =?us-ascii?Q?Oui6Er5qV3HYQNwchPGs9xFHu4JDmFBaejnLQO+AzTkIKfJ0Hb12w9je3gXb?=
 =?us-ascii?Q?vS6xwp9l9dAucS6erVCF0mjd3B6TLLmHmv8KSo+es2CY7vBSQ2YTFMXQX3wb?=
 =?us-ascii?Q?xg0jKAYJepWUQPKUtJdo7J29pk+LOVgfxyTyKPz7IjEbROBprgHn0WOVpJ56?=
 =?us-ascii?Q?mmmrRRDvbe9mmBhq79kAeLCNWE0ls69hanhLNFlgrM40EONtRsjFwIEBs0AO?=
 =?us-ascii?Q?3qRabiJyKfxBJqr2XwYUWCOv/GFQxNwp2hMtBXCVGBnJX/QXNadWqFklhR7l?=
 =?us-ascii?Q?3CTfUvnEK4jHdrWnuFKG53sznMs65Sj4zW+WFERaNjGmNfB7vUmGqh/Fw4R2?=
 =?us-ascii?Q?3Rgz99AxZK2mxfVlQbrkBKg/pakk15yW9cqxeIDm0uCM5BvL2m/pBAgZkloX?=
 =?us-ascii?Q?xlR2MTU5x7DWYiGDxYWJ3DnwgKh0mT6VfrFfCqEcQtB7zYsGK6rc/eY6aazO?=
 =?us-ascii?Q?JilmTUVDANsUrXL9ROWWsMCZYsrmYwzBKdQF/obWOEauphukPubwRVARfSTh?=
 =?us-ascii?Q?3EKulSGgwNlccoHVSKoSdVslhUvxGFM03PdRu9oPxcO+aMcFxjH+SRl7HmwD?=
 =?us-ascii?Q?bYjLQCHMinjGxrUYkOlcAXcOvsa1IaQ07XnwNY4jBFuHuFe57OLKSRvOCg54?=
 =?us-ascii?Q?UhmNuZIARIK8gJ0075X4qLAk9fUF11LFsSBJyRSITSlBxlwwE5hyUFpjOuro?=
 =?us-ascii?Q?iXN+8J606w5kcU0Ren912BH3IuDJRoZXKx0nhlaSpcI3rh7aO0w8GHOGQD3M?=
 =?us-ascii?Q?mk1p/oYKYNJqXXf5GQV5RY2PQJ6bArQ7bwsTRkP0kcyK/qTyYOtp771DYNMb?=
 =?us-ascii?Q?tP4S7j5Xhx3ArKe3pi3lZZJyKV8yAwpxanRFMGYu/CIFZiF3B8xi09aA7zT2?=
 =?us-ascii?Q?t38rBmfrrOP2ROjHJ1c0snA9EvupD7CIz9VsqrVdZUe+8ExNVl/S3iC2A+UX?=
 =?us-ascii?Q?s69zbRf/R0ZP0UzonpG/SBMlamS8sb8KEuLHIFk1zi1Sk7cjh2OqKgNKisGU?=
 =?us-ascii?Q?hsa1gcaKYiZ3482lHUv81mxQ7KVwaPB/wZyHu2CqeiqApb/V3tRh0h21pw0X?=
 =?us-ascii?Q?EADLcNU0HrhPF5hFSYPrvvMzdGKnePmkW7lGVYpzlquT5p87Zekbw5xpk4PZ?=
 =?us-ascii?Q?aqwe0ttw2CVS1/MFJCm1WeK6uElll0wl27GxfT+qF+F4BeiCm+m79MOvUhaN?=
 =?us-ascii?Q?TdjSnnir2/Yg1uB4QUQS3NhwclSvUymBqyVNLdjGMS+NxLjytr9TdMAug2Gd?=
 =?us-ascii?Q?WRvuc3vDwJigFzhl8uuUSNEzKp3APsoSaYpr4sIkWKROx34Orr1LeHNGHQix?=
 =?us-ascii?Q?Amll9MWsu6hhoXId8r4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(7416014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 21:52:20.0941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1870ec-0e1e-46ba-6494-08de22feeb7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9084

On Wed, Nov 12, 2025 at 06:24:52PM +0000, Suravee Suthikulpanit wrote:
> Note: This series is rebased on top of:
>  * Git repo: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git 
>    Branch: next
>    Commit: 91920a9d87f5 ("Merge branches 'arm/smmu/updates', 'arm/smmu/bindings',
>                           'mediatek', 'nvidia/tegra', 'amd/amd-vi' and 'core' 
>                           into next")
>  * [PATCH v5] iommu/amd: Add support for hw_info for iommu capability query
>    https://lore.kernel.org/linux-iommu/20250926141901.511313-1-suravee.suthikulpanit@amd.com/T/#u 

Nit: this patch doesn't apply cleanly on 91920a9d87f5 :-/

>  drivers/iommu/amd/Makefile          |   2 +-
>  drivers/iommu/amd/amd_iommu.h       |  36 ++++
>  drivers/iommu/amd/amd_iommu_types.h |  48 +++++-
>  drivers/iommu/amd/init.c            |   8 +
>  drivers/iommu/amd/iommu.c           | 221 +++++++++++++++---------
>  drivers/iommu/amd/iommufd.c         |  50 ++++++
>  drivers/iommu/amd/iommufd.h         |   5 +
>  drivers/iommu/amd/nested.c          | 259 ++++++++++++++++++++++++++++
>  include/uapi/linux/iommufd.h        |  11 ++

So, this seems to be a preparatory series for AMD vIOMMU, yet it
doesn't properly work since it's missing IOMMUFD_VIOMMU_TYPE_AMD
and the invalidation component (HW_QUEUE).

However, the series does declare IOMMU_HWPT_DATA_AMD_GUEST in the
uAPI header. I am afraid that might confuse user who might think
AMD now supports virtualization using the HWPT-based mode, like
Intel VT-d.

So, maybe we should either:
  - leave a note at IOMMU_HWPT_DATA_AMD_GUEST to declare it is
    incomplete yet, and remove later
  - keep IOMMU_HWPT_DATA_AMD_GUEST in an AMD driver header, and
    move to the uAPI header later

Jason?

Nicolin
