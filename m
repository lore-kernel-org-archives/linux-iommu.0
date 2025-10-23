Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013021.outbound.protection.outlook.com [40.107.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF5D2A1BF
	for <iommu@lists.linux.dev>; Thu, 23 Oct 2025 02:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761186318; cv=fail; b=eT1ZDQgoPbTaRR4EnyzEV8OK0fUyuqHSexzwNZDBkeIp0rEBykpsH/q7zX5qCNhwrN/26sngikKEBIvrZ9e0G7rsqeKMrw2/bnEZgulYE71oeyfrWDQG5Z/lprrpmbpMOs0V0ZaDL0qxoIrzQroRYc+5X9T4b4ULqIqujtvSonI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761186318; c=relaxed/simple;
	bh=caeHAAyl2PhGOFk+7m57xd7NlruVjL2q3UCyT9QfNGo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oD0yqVAVfCZko8+IpUUA9I6ZMuh1q2fECuGeCQE31XJ55JZOfzUEUGw0XgpxCZBHr1F20zqchnuJ58OcmuSklsMaX9DOGUAsUUnPcfjUTGVUNQ/zHbpgY5aCZdGK0z2dJe9EwtWv/GybRWcSfqP+AcufGDLk17HQgUfR9vHZHCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B0a/QwnQ; arc=fail smtp.client-ip=40.107.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B0a/QwnQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uf5cO4dgeVQt5HJlLTZx7JXq2wyw6Kc0XmMA2+1YpkZYXO9TuQI4R9r8cVp/UkJwnL9koEy8DGYXQ5Y7KPsJfdx7rGAIrNqAVUvmCRgcNA0mNlNA0Q3o8TJx9VP2tdEd2kbNPnVPqz2ShoZHwJy/Dv3B8arC/tYmWgI0IVoGBtiGzaiP9Q0E83vYEA0PEsQuuM/IVHm0b8/02ElXnHws4HVe3ovlXQUog6ljWnk3VQdxBild5if/es73uRGM29oA/dhW5lZemb44+3fCmTcw4o2wZfvdRRas5G94RkeoE8UJ9LYmzaX4ZuTy+mW94f6FmHzfQ4WMbVuNYH0j19uzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//z2/Di1aigM/OEp5UzT95jL25WFdsQD0IdRxRCSVoA=;
 b=ZmOoEVxoYNS4qUkkeE/rcDBcJZvygAJVHHC07IIKNQnh/Hl4kGjJ6eIE+LLUIWOiKQYoeqDpzne2+qW3pMMMmy0G7xzl4D/0++0QU5KYPyRYv8h3BjziUrZJfolmweQX9jOqbNTkA30ObX7EV3mGKugrC5bdLwKsgUUuix8pNppOH7k6fjDS/0AlJbbyIqaQB88uAYzlWWJYiNZEwUHmGjrtysBuIjuiwzKJt9sD4vs6raY+Jhpl0KTI2DqYxbjTO4OZv+GPYRn6uQatQgKhv715nb8YFvT90NPTtQ2tj6+ycEWbqdJshTgVlKL2M1T95Y5aIv89fwAXVgKbjtnQxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//z2/Di1aigM/OEp5UzT95jL25WFdsQD0IdRxRCSVoA=;
 b=B0a/QwnQKIXO3GeZJwUAiFOjK6Go4/1qLGlQ4onQP+vThzVoSRbTEH0hUKXnofqAfT7YsbTTS2a2eWdQqx1EUMNUaWWuTsU1dESQOIf06jct9wY6A18rmO7Nlc955/j/BiSX43Lg/ZQlDpubq1wJWOmfDn5g99LCC3LzvG05oDs2IUyb4pMq1TlzXiRV5QK+bETa0CWwYcKZC/04zFovoXLZEetg1hwdh8/3lgUJigAtUFuhj4EuXVKup71g7fXAivgr3hLCrSn8EO0uAoHhLY2KjInG+oQ/+E2kEV/QLWkz21BHxKY2fIUxlXJCgQNMuVY+KL8GQWYcCx9fJZ+8qw==
Received: from BN0PR04CA0091.namprd04.prod.outlook.com (2603:10b6:408:ec::6)
 by CH2PR12MB4104.namprd12.prod.outlook.com (2603:10b6:610:a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 02:25:12 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:ec:cafe::f0) by BN0PR04CA0091.outlook.office365.com
 (2603:10b6:408:ec::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Thu,
 23 Oct 2025 02:25:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 02:25:12 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 22 Oct
 2025 19:25:00 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 19:25:00 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Oct 2025 19:24:59 -0700
Date: Wed, 22 Oct 2025 19:24:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<jsnitsel@redhat.com>, <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH v4 09/16] iommu/amd: Always enable GCR3TRPMode when
 supported.
Message-ID: <aPmR+RqvGf0yTPNL@Asurada-Nvidia>
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
 <20251021014324.5837-10-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251021014324.5837-10-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|CH2PR12MB4104:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b1edf1-ec4b-40cd-998f-08de11db651b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rPd+EprUwdQFZv7SZOSirh5szjwk1weyxzLBP7/Lli1RDYSZk5pkKHWicKB2?=
 =?us-ascii?Q?SRyso31YvGdFWqJLnxwnsZhZtYYgUobdH/DyF8FZCumu8lo+sjHREa5lkkdG?=
 =?us-ascii?Q?AcTtjgy76E3WiTsZRb6BOesFV8bXV6fAnlpol3RPkc9SMaDWVPzaiVfpuqTs?=
 =?us-ascii?Q?ZnY5jp5VXDuysesYRmX53697glxDBBBS8OxYPO/4qJgXSbndKq5v2hhLiThu?=
 =?us-ascii?Q?ZtRBVCfbaV0OYTQStFXdLLnMWraBl3ytVF34pt8d93IYRyi7NN+6dA13cj70?=
 =?us-ascii?Q?sfMS00lvsFGwYjnyN2ibDd/ui166BDpUl9ZN2GOH4UB+1b0f0BBsTsKYds/8?=
 =?us-ascii?Q?7PKDc1rvH5vnSm7dgVATfBjBXGUyMOzJFEiri5u55dE1MiAJ6ilIMxGv2luy?=
 =?us-ascii?Q?irAso86IoH4nnj/CuEaFm43XDKrHJB7DnCbWdJVMkcAsMAR5Xbb8VWtv0otK?=
 =?us-ascii?Q?kDnp2huwAekzs0SupL9tra2xM9EGl/U3Mr/8XCJhZQfTWbbTVJstMQU2njjV?=
 =?us-ascii?Q?1L79/vw9G2g3M0n5BuMb2EA81c1cZ1L5eSvdbcD6C6ly2gjsbM20BhtQJlq6?=
 =?us-ascii?Q?e1/PS5n21CexR5Eb4m3c188gby047JgG0lfmzMyd83WVjSpeDS1UU3G6Qg8K?=
 =?us-ascii?Q?2+kd05Yn5LkKsbyr1iHbotRCCUZ2fQLBqccdR0PS7txUbwAcmmjWKPQIH30g?=
 =?us-ascii?Q?Q6qQZYkMeNBEx3NKTYzv2Qlmc5TV4MeZ+FIptL0t62vAZrbR+tqF3XillNI0?=
 =?us-ascii?Q?DWt8hPiHG/obI5t/k+f6m2YfnH8ESbCeFInxLF+Qgu43l1ZexvJ1IFBgcKVE?=
 =?us-ascii?Q?rjNyK0dksiPn22acHuVwpJOn6hI/UF+jtsJHQXPWVFtkdgThm+op2TuLPHVj?=
 =?us-ascii?Q?GNO1QJF6zeiAghZ53fYSQgdkw26XxK8pz0DyjNGReO/tGxTAl8WZFixQ7Nbg?=
 =?us-ascii?Q?LTbvU5gmNfTKKMoVGlH+te/Ox/Ztb/wG7VqKbRmt8MVkN020oaNfFRyKZnOK?=
 =?us-ascii?Q?mDjwZMGneNEsErOSjSNNBz/T2KjvYOVM2nJ4VA14PmBXoNeKv9tPn+KFrajB?=
 =?us-ascii?Q?1MTYIS8dMlIV/+J2Uq5i6+StlMS9HZyNg0D7VH1P/JiL6YLqXTdAz4ksiSH2?=
 =?us-ascii?Q?5EhgW7RORFigEpcScxNMRBIPV7qYVkLkWCfwk2d0RxpoZgbvZAq+3RWFGCt8?=
 =?us-ascii?Q?sEZAhzAPu0jPVG+okgnG5nd/hQWfbOpTZSqreg80PJggYaF+4oncqEuo1Ev5?=
 =?us-ascii?Q?zAKfsFcl1k//UnVYDbZhAnbB7lVsp3908ZR/b2kAn6sqV/n5eL67LE8A7AL1?=
 =?us-ascii?Q?rx/pT23hMt1BA5ptghszhK15PEZtPX3iVKGyLz1tWcqbFNsVjqo9k05Tlpub?=
 =?us-ascii?Q?FtiseGMNf2SMAu++Ff8OOyjLWY1bicuOE8TY3YufKjIxxWcXrK7Tu3Cif6kD?=
 =?us-ascii?Q?vt7SfXh45Ycu6vySEn6qniz1gkJwcumDuMjQv0zCyiQEVpWX0WJR9hND1MXe?=
 =?us-ascii?Q?FnVhkUMU2YwBE1b5O6oMfXZMly7tYEZ2VU0swekoJIS5Li9pPlNT2QX9F/nI?=
 =?us-ascii?Q?WiEttlbrIxNqkg73S+Q=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 02:25:12.3108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b1edf1-ec4b-40cd-998f-08de11db651b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4104

On Tue, Oct 21, 2025 at 01:43:17AM +0000, Suravee Suthikulpanit wrote:
> The GCR3TRPMode feature allows the DTE[GCR3TRP] field to be configured
> with GPA (instead of SPA). This simplifies the implementation, and is
> a pre-requisite for nested translation support.
> 
> Therefore, always enable this feature if available.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
