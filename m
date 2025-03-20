Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807C32253F3
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742495098; cv=fail; b=DJZYE/FQCC1mSVNiJHan+vEFZX4sUosYNdla0MXt11WjNI1PtbSAMfKjaMgQ1u5ikrFHUV8qjA8Rrvenl0kIiFsgIggzblA5DB/Wq8nsgQ49xvNeG7lz1vbU3ZTMXQ3wxwFyHyt8NQxOBdLVGQg8oF6xbW42QTRs4VRhpAFX5/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742495098; c=relaxed/simple;
	bh=cn5z+Z3KAn11RxIRx3x0ekzmKYMPeh3raKesFgBxRBE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8AQSo3Sl+WmL9J52jo3KEQ5717ZN9M0pjr9A986Jma0BBQk1TEwasnPRLmnjQZzgF4og2Q5PcXpLzm80dSuGnpf35ekhrE+LXuPDOH+PuGb0S574Egts2iEb0VNWoXssMGRYMmi5Mp+iCDTFZCH2OkFQ/kWXF+J4ykrFWxajl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MSj2iu6a; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MSj2iu6a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRfQru4EsFbig7vlwJ2ZKmW8VVobLY2ydFxALVu8+xcYtUfvkYtRR/YC7mtigvX2TuDOPTVIQ/EOoTY8tlUMw23vSkNxKHJ6hQ6Qkfsk8hqzUbKgARDVu7zOMSXvzfVyStzaU5SsjEftujbpcYY/RgPaNY0klG+vxBwSAp3JGDgIJg9y9iT6zqx9RotDYGxnYpNzdHN6m8S59iRLYIaK/yjGHulLBjeXGm6Eo0QNiLMuL86JC+W0FkfUS4ilSa2pR/DxoP2kVezkLnw0/cSwxttYG3LxPvOfAAceDVJyG9qvOjoRHABruj5hLEKZspw3gpd5d8rHmdxbsplgpv7o4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1C1Vh4afnNx9WFN4LdPxCf/rbbiCP5mNqnJTzJRW8Q=;
 b=UiUmGpNbXSYLWGjycXGkZzx/LOFGTxKagTWQc3RHshJO8ZiZreH8Vsd7Ow+cREaBn3ybaehCCIwU8io6dBjwC5HR9TpyxvPtXjKBpAhjV3+oVRQD6vRIrQ9LGvYdf8eScjufF9Syx/EJeC6Db3LxItsH3vSMPAGwicp1Dp//4z3VWENI1dEe+W5s8KnjYayhU7JB8IgkcfqeGKEfX7QHJ31FuEJaEaK4VkVnthvj1GHKShPlWjHMwtIghPBYnSCF2hOXUnFji01T9yTJnYJPiFgrE/ZvzLNxndw/Nstj1BNLzLjVGl/GxNRh0WGDzRG2XICNfQDKaFbFa+aMg9TkSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1C1Vh4afnNx9WFN4LdPxCf/rbbiCP5mNqnJTzJRW8Q=;
 b=MSj2iu6aLNJl6BPZl5kNqiWrjDM+nN1rxR3EanHOEiltQfDQaZ85Rct+Tf0orAFanTudPL4mGi1IWDlotjUEV7BsncOlQwca9R+0V7pIYgVwsbVU4MwpLPZJc/HFSVjYfV6C6sEYpolcrRYK8N3UsZ8IQFaooJcxLHSQrzK9LFMxwaQWZcgIU85l24ojyZfLWacYObSNyeghWk2bYmg5m8hGyRnc0VVyZg/vo3+8Ws3ZSWX7kpoCh6PYUkj1NSeGrG07fS6lHJXsBqyEisQHl8SMpdDgkjYO/8Jz12XFuhJPEGU/2Xrwti+H5gMXajj+g0IM0XxgqBXCjlmi3pRhqQ==
Received: from BN9PR03CA0620.namprd03.prod.outlook.com (2603:10b6:408:106::25)
 by SA1PR12MB7294.namprd12.prod.outlook.com (2603:10b6:806:2b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Thu, 20 Mar
 2025 18:24:52 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:106:cafe::26) by BN9PR03CA0620.outlook.office365.com
 (2603:10b6:408:106::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Thu,
 20 Mar 2025 18:24:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 18:24:51 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Mar
 2025 11:24:40 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 11:24:40 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Mar 2025 11:24:40 -0700
Date: Thu, 20 Mar 2025 11:24:38 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Yi Liu <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v10 06/18] iommufd/device: Add helper to detect the first
 attach of a group
Message-ID: <Z9xdZpG+2R9OAD29@Asurada-Nvidia>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-7-yi.l.liu@intel.com>
 <Z9xSO6pIPZZLP4lf@Asurada-Nvidia>
 <20250320180420.GE206770@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250320180420.GE206770@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|SA1PR12MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e8e497a-781c-488b-7ee7-08dd67dc8172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iNs6VpUui9E1Bmx1CacDNJhNgk8bXYK9lVXtHCIdg875AX7/3+YbVx1WForN?=
 =?us-ascii?Q?rFcaeQ9jo//Xrt2rldzS9CHOzUilN9kSs3nez5Y0cH4UBSJbDDdflqTU6dci?=
 =?us-ascii?Q?B5Zvle8KnG+3CIRTaj7o4KJPo62eSKxQdv+8POL1cOg4cr8Swyuz/dreYoPt?=
 =?us-ascii?Q?xMwaLrdHNyG+HDxKt9dX6COdCMfmfMX+xbP7vYoYajh1Jc0XOET/3hfqrY+L?=
 =?us-ascii?Q?8wdjma5dU+iSWqedUU+3qGe4sFShvkM6RLwAAiAnyUMD8u/JQohauk86IC0n?=
 =?us-ascii?Q?/Du0Ls+FmCCBvsYsTvUyDMcEAHC8lPjwH3q572GzYwPOrHhdYNILKAOMNrBq?=
 =?us-ascii?Q?wDQCTuAOrqSCszDLJNmwlShrSgl3gmz8nVjZcaiU3zHtLGPHw8+M9jFckXox?=
 =?us-ascii?Q?sDFmRdG1eJNvUgd1DxYUOm6yj5hHmBVO/6pjkZo/B2fDsLmyOKl3BMsxu9WR?=
 =?us-ascii?Q?j8wDYS4ffM4kcR4IOz4XEZuOmZVBE6G9i2mqa6vMYxZI+OpYMIrjQgTDVDQv?=
 =?us-ascii?Q?Psx60sQ619hx362fK5EdgBq9aDWm8g7GsF575yAJ+Ae05jVmXOEW77DLug7a?=
 =?us-ascii?Q?5UliAD6n2J255URlpZeo5kfw2Um/MKq/jIBiROSFdT79LLn+oSn3xV+A2IIh?=
 =?us-ascii?Q?r2WI2PYvsAzat6+jkcR/YDHpb2tAP2P4x/rIDwDJLenvRYoITgqh2hKfzLu6?=
 =?us-ascii?Q?sXhDXQv5FPv9EUViUl55CZMo3pX6H6U+256cliDdGpwLOC4ua/aJ2Us0uNy2?=
 =?us-ascii?Q?C9GRzWh5e0LgbDPZXUg1WU4ZXslZeq1zQ6maMSzLf4divrvSpHrw4cuRAlLT?=
 =?us-ascii?Q?eRzt9ZUiK4KNmaSL0LRdl0re2UCpYUdrp5S2rzpwG/zwGkCDDg8yxxHa4vkJ?=
 =?us-ascii?Q?pDn4tG+NSWn+LPhqScC+lclaciAXIbe84bt7hb8MXJIDGM/3K3ux0KiCGN1l?=
 =?us-ascii?Q?6DvyaPAyXr+IyDcyC2iT1VMoFUpBD1PsD/bd/OpL6GNBXk8XN7aS0N8JeFOa?=
 =?us-ascii?Q?Z3jvUiX3Ai4QO0eYDlxbHxzZqwhfXPf+JDeK4JXfv9L616dLLFc4E0v/yM20?=
 =?us-ascii?Q?Knvq15KEm6irv/l2rIFw1Ehx6dMboQKvNkCgLVWlBqBJfGfPhsNGOcAF9E/P?=
 =?us-ascii?Q?flJ5D46Rgw/2WC/oolNN7iwMOCwKjzTIVktIkpyneGfNroCJu0/nV0vZFDi+?=
 =?us-ascii?Q?BfTpUMF+xnb0cBRNVOCuPaAcFmH1lpJUbsC5FA6BWjeUl7mlATqE1/I1oXU6?=
 =?us-ascii?Q?Vx0MvQ/Z8PwXX5VUpVbPIvCJGZGWteOUEB5ORu5Kzd9JrWpKrC5lreOT7JhZ?=
 =?us-ascii?Q?UbnsA/ZnRM5pUxS2facMRLh3Pt3Fgg36Ge2PbNz7jl5xwWN+DH8Ok3RzubAb?=
 =?us-ascii?Q?t5ZITFmeRfb9RJ/IHvmzPU8HBlJApw7cWB/1EZ3At51+zYJT3ktUQBrvEA1g?=
 =?us-ascii?Q?XUdf1sBXiw1Yj0nnQaxwcXz+TfS3OR0nSuB8iH/GCr+KGwQqqaOKHw6LmrHZ?=
 =?us-ascii?Q?0CKSTmYP1BbD2oQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 18:24:51.6833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8e497a-781c-488b-7ee7-08dd67dc8172
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7294

On Thu, Mar 20, 2025 at 03:04:20PM -0300, Jason Gunthorpe wrote:
> On Thu, Mar 20, 2025 at 10:36:59AM -0700, Nicolin Chen wrote:
> > We have the same list_empty in the iommufd_hw_pagetable_detach()
> > and iommufd_group_release() too?
> 
> The one in iommufd_group_release() is checking that all devices have
> been cleaned up before the device and
> is replaced by:
> 
> 	WARN_ON(!xa_empty(&igroup->pasid_attach));

Yea, I hadn't read till the end.

> And the one in iommufd_hw_pagetable_detach().. it can't use
> igroup_first_attach() because it hasn't erased the xarray yet.

And yes, iommufd_hw_pagetable_detach() can't use this helper,
since igroup->hwpt = NULL is behind the check.

Thanks
Nicolin
