Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013019.outbound.protection.outlook.com [40.93.196.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBB57D07D
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425374; cv=fail; b=ENx8J8TJbV1x4C4cZR9m8NigInO2bSSrnZkITb+ePTdegt1o778v7M5KWoG7FuRy/1Z4Yitf/8phh2LtFq67Vkhjec1HlTxZBW+8N5qG2zsgalUdCfFW5ENfjr1hykJTAWuzY4u+119mVrmh86uWS1PtvLA7XikvLPzptlXwuEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425374; c=relaxed/simple;
	bh=BgBHpl44PtEs9VZ9rH/uNUifvaArnZDVlAxyojz8bHM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iByXO8Jl05uCOfYQZhqD8sd2axekm0UR3LSHymlDEZF2kX6zYfvI40dYGHiJGoQoVaIFVjwleMa1OmLC60JwynsAiViwpWiJ8DcpglYotiIz3Z+TUmQA4aatSd8EWyvkfSSrJXMF6hhXWuUZl2KVGfqhIhyPmfHyenbWQv5mSkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TdwQgSyt; arc=fail smtp.client-ip=40.93.196.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TdwQgSyt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yiutlzse7qb/2vnNfxNzDZnFm3yq5K7r7z2BIVwuRiHQ4INyu334FvvP3c9mJF9IS1emdfTC9BfMBZgERPB7N9fFV+kEoMwtQ7lxTOub9GGQm8nVzV4IQNUVFR9H+lG3J+udCrMI5Iv/kHdfaZu96N0j93EiGIut9fNpAq7FdQyoZIym1pXrK12YauriA0y1TWzM611r3JHwwZO8Daqdqh12BqmUuPRKwX7RSLPBTPG8f6uu6ZHs/yjLhJY3WqSj5t/RhN1Cazp7jF/0z9e9jc1bV9QZFZ7/oWZOtsxcazro2uhYe+JysXnr4jbh4jG6CMB7Yg7pvg4kG0qhH1CdmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKJfxuBcAjKaIxWDQ7XOO7dMEvjkDuMFfffKP8qVSy4=;
 b=NGMfOgIv/tD+WsC/CzoEtZo+SBYtfp05Zu3adWQ+zV5+l3u6RUcPZpHGLs1ElpR7JaWg2RJ89o4F00xtIsvopr9owBRMyH9Mfee5NXmgXiKBC8TrNww2piMzuP0o/55YrOwrRzC0yqH83azMYUNFsODJ5ugB4Vq4Oozgs7pPoIpJ0SRQibDgiZF7VFyPu57XtBXnIuNKCJ6mg1p8dfL14Cl6dL5tITJhABj2jxRk/RabRmW8B9mLKCRB8YwOo2MMydWOTo4Lm3Di2YkkqcGfkrLrVaCJpv2RLqIoUzEKIsE3Zldz9Qv9w7DbnEDEHgqZYAlgbAc1Fnc9tWzFnrKkpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKJfxuBcAjKaIxWDQ7XOO7dMEvjkDuMFfffKP8qVSy4=;
 b=TdwQgSytgvBiuM3vIx86uI1UNv3SfFVEqCVf/cVGVA6JqQUKDu7Zibahf7b3tBPprM9YFDY0UiFST2j9BpwI60rvwo7gnR0QTuP4u8iEPUJfQNevpWLQnIYqzpVuACTONXttCzlExnFxHqk/+VTEyvoK+QERZyFlRA40OVNuP7nt2+fFxEJKa32k42nR3+1YMUeVAlUe6FVaEXD7ITM68AP7ilH0hYw9EOsvzUSc1uvQlhBFteSQv3xFvnJk3Ss7MKqrObofTneCKMjwwWTEFlMTPg7qMpmWIqWdhaqknRPcBE/yQFX5fth6olEErrReTwajBmSbkL/Gie5yEyKs+g==
Received: from SA9PR13CA0075.namprd13.prod.outlook.com (2603:10b6:806:23::20)
 by LV2PR12MB5797.namprd12.prod.outlook.com (2603:10b6:408:17b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.14; Thu, 2 Oct
 2025 17:16:08 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:23:cafe::d) by SA9PR13CA0075.outlook.office365.com
 (2603:10b6:806:23::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.7 via Frontend Transport; Thu, 2
 Oct 2025 17:16:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 17:16:04 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 2 Oct
 2025 10:15:53 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Oct
 2025 10:15:52 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Oct 2025 10:15:51 -0700
Date: Thu, 2 Oct 2025 10:15:49 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<jsnitsel@redhat.com>, <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH v2 05/12] iommu/amd: Make amd_iommu_update_dte256()
 non-static
Message-ID: <aN6zRQbrIu8quWtB@Asurada-Nvidia>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
 <20251001060954.5030-6-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251001060954.5030-6-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|LV2PR12MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: 25a1584a-9b31-4055-d3ec-08de01d75e50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MmsLM1lrNoJPnLh3p6dYd19qS8PIu8HCWsidSccubOZjsrojtKubBz3kG1Ml?=
 =?us-ascii?Q?j9QU5DqB5mkoQlsywKjmW+DIZP2tUGOPI6rHYolrAfs7MIBDgDeUEcgajczB?=
 =?us-ascii?Q?SEiYfmHBe95IZABg5J9tWGdEbiiUeKA5F8Ej7mPMmgUuDd3VMa7swEw96YKg?=
 =?us-ascii?Q?EntZRBX0FnzgxE2RfMRgjVKWQXjznn3u8OzrZC5Nyemg4mglFdeocFrZarRq?=
 =?us-ascii?Q?8ISdNjtr57pCA4iohR2dO/u3RECZpqthth3lqW/IqIZsEqyjS3GKMNWkGoos?=
 =?us-ascii?Q?zX1kygb+4Iw8dpqjmJPPUKsBeW0zG2lisFYZ900hukpVMzW1kOC00/J8Ee3Y?=
 =?us-ascii?Q?UJpUByuCNSBBHGAVxKuE1cGce3Wy21J0eug3BzmYHEjYZR1YUIYxqLtiuOWn?=
 =?us-ascii?Q?bc6qL6mn8l9TaavxmMMTD+Y6sK+Z+kZ2f5u814Zs6IBVjRCw6uQ/x06Rf5M4?=
 =?us-ascii?Q?AD75D1aRE0S8LDeuGs9sYNMt+h+q9V0unjNkFu5OnOsYuyaU83PUCwKFx8vX?=
 =?us-ascii?Q?kmihK9nBGuK/CUaBfgdgIKkAJlWHaKWKyC3wlaHqy7kyeGM+2Qfl7V+KLgdx?=
 =?us-ascii?Q?BvdmW9JDoWDkIXA3NSpcMxVZAZhzQU47/21suuVuAWE+s2bVQq+GmAUnORys?=
 =?us-ascii?Q?hpZF+pC7iqj+Rnmx3vDSCLtKe7QRFCZJp4dpWdWmjGvHcN3igS+UIPBkSN4J?=
 =?us-ascii?Q?hYPJC8o1XGUjw4zUGqeOgmoGaICyC/SO+AKR8tI7rYAFrZ4MNJgodzxXsio6?=
 =?us-ascii?Q?zv8PnsloqaI+JjoSof6CRsrAGees7LBiKtexO3aSpgtet8AgTKrCcNSpOpmw?=
 =?us-ascii?Q?GWGtLfyXNOvR2pEG5xWWf8pXbrz4iCzHJ5BC7j8mdU9TogHDpVaKSZNZpZnP?=
 =?us-ascii?Q?6uQDHPSoSjna31eX/nxtaadzU5Q699nN3EFj5Hgg/OdPvIDSuWKfKxrz0k6V?=
 =?us-ascii?Q?uT/5u/Hg0UG1YClNLpPLwOx/dFihmWqBRePR4PGzWo37dvPdLTii3z9rm+gN?=
 =?us-ascii?Q?QObEB7MIMtuEMQUQ5MCorflSYC8pMVlmiI/dGs/ZV0zPNutStk4ItlJvKQ5B?=
 =?us-ascii?Q?uAwkcN6X3r/U+VQJ56R/g3bGsBxpawX1jRkuIDtRosBbq+xMfOsvKCUkwKf4?=
 =?us-ascii?Q?RRZ2sYXtb7H3jGzQlEzDlmnYHW/eoswQszNv4PO+aY80bHM9cktZKO2zJpOO?=
 =?us-ascii?Q?ABqejlOFefkH4L9aFtekHZZaPb+XkTCnTa2fQKZ3J2vhuVLKFBhDHADqfwAo?=
 =?us-ascii?Q?pz5EJL2u1LiKCkEzdsXRlagQeNmxSX7lEdv/tfzsk1XHw2/sg+CGu4/Yopbk?=
 =?us-ascii?Q?+455CbgKYcS2a81uQpMnNyPswJRbTU5dVOxbTepEzP/RlnY+hdr9L63htSuW?=
 =?us-ascii?Q?4FKQLUcjzNgJhnKamIE2rQstXM/rbmIm3ra/urg3DMKSkgWRS4hbSUe/+7RY?=
 =?us-ascii?Q?8Tio7jF4XjTKB3+7qHzPsS5RpAACoP+gqTbJpfqF7KSG/z5n5Tzpr07tj7HV?=
 =?us-ascii?Q?G/flijZhHhExFn/ojvwyW4x97THx6L/kgY8+o2PYq75eZt0yEp99nPaLlcjy?=
 =?us-ascii?Q?zhHYY4j0YT+1tD3yEb0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 17:16:04.4074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a1584a-9b31-4055-d3ec-08de01d75e50
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5797

On Wed, Oct 01, 2025 at 06:09:47AM +0000, Suravee Suthikulpanit wrote:
> To allow reuse in other files in subsequent patches.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
