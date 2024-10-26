Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE5A170A1B
	for <iommu@lists.linux.dev>; Sat, 26 Oct 2024 23:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729984195; cv=fail; b=M558QrSDz353bClOem5+oab6u1nGbR+fXu/e1aPfdtHLeIcjT/2O+wCFi/gCHwwG7qyOXx79NrtsW83ANBQSC9eIXxv71G7hlzc7aLST38YtVgvB0Cd4RI1Mlc/bkJZ5xJd+/K6DKUuEywWZ3ptjOaudoOavc9V5RZMG8aO8B0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729984195; c=relaxed/simple;
	bh=twZ7exb7I3DqRixGt52tZ/TN3QA5v/jLlPp33aSCn10=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdMfSVd4GsZQn5T1yF4sI1VtLclTvdmdpIbJn0vLQ2gj421C8au+5mcFkA9UlahMpXD6YrGwylphAyEQZLkhkjQYZlu198z4OrNUx7bG070nMWxb4Nw67f2Su2IXlEJ5k6lub8CjE+GsKsLFoGk42tMQKCO394+Hh/8jT9kHBVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t10W8PEZ; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t10W8PEZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8UeJo/GNk54R1hhr3bebuslYD7MpA1b2EpeByR/iu9ExKdPtVFWuCoNYB/032SKKoh4XJ8RksgEAgeEcuQlARm3/ruJMlud2XV2KGqEMx1PswqbUWHvmI1cMRN2KPJXFThbgzEKficqvF160YMgLIvhWuGqMHkXMYY0H9HXoHNUnL39NxUVSiP9ufv6FtWbexZOq7QOachMQlGc2oMyT/jEx7RPW6wAr0lozj8QuLwEvkrjukRrmGOY8yhckSgZi+0Elw2A8wW/zAadtazFTqR+OAvpDkG51rJaCdEyY/aQHTPjBI8L+PWp2TAjpiON40sY1BsphuN0jqFKtSOgJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6wEaEzuIaBGuOTNlDi45QtSLfzgNkV6SOqpteAc6Rg=;
 b=VA3IHOiTcrI8/+UZkLWuduJ44OpN1s5To0z3wPP3oFRSyge/l82OTys7S+6XJOdrWFfL1bmJy7/LZK7ZuZtzhQXU/teKBELmrD6gR3znLeF4YqEE6AaIWZS+broj5wVarEi4B/nFVFHy2lStSQMAvb+HUsXj5D6P46i5U5PrQHbtpNEbKaoa6YQ5bTd0Q8wFzk5IsZnQdTQSoeZkSCSkfzxhmrd+iypTZI5qAm/DpFxstWrHGU9y9B2dJE9GGIuruo7WJsGUzzkZTQu42N2Yq2rWhGbjrUhQTpkGHekh9kb7lDvbMwuR8EkpiM16WmaDWOQbOiqYWuxS5+mFT2WLKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6wEaEzuIaBGuOTNlDi45QtSLfzgNkV6SOqpteAc6Rg=;
 b=t10W8PEZ3LL0xFk+5WHCOigrsJ6C4xu1Vr84q9nN47Z6cWKvLoTytdTJWgSw71PYWKJGi5XZb+hT0VP7xJonFQYSxQYucSk97eA4+wFSw/u/4Im+ax9MC3qNAxG6L/bFSvRgh0YokecvPIwHnQ2VnijmUXstOv5SZy5p7xmbsm5iYr3RvMP3hFdLZEHbE+whp5j4S3SWNtjxwPZ2y1AhN1L/VDokQR18+u2YQF6DA+TzbPSR0LG+yV4Y5Os40WmOGnJTRK/vizSuQptlrC7AbfwFMeezkYdOt6ATcLkQoU+K0q+dp+l0Ad0sXvtewzvANM8x/f2BKTmr3El0XLHUKQ==
Received: from CH0PR03CA0367.namprd03.prod.outlook.com (2603:10b6:610:119::24)
 by BY5PR12MB4195.namprd12.prod.outlook.com (2603:10b6:a03:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Sat, 26 Oct
 2024 23:09:48 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::27) by CH0PR03CA0367.outlook.office365.com
 (2603:10b6:610:119::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Sat, 26 Oct 2024 23:09:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Sat, 26 Oct 2024 23:09:48 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 26 Oct
 2024 16:09:38 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 26 Oct
 2024 16:09:38 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Sat, 26 Oct 2024 16:09:37 -0700
Date: Sat, 26 Oct 2024 16:09:36 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, <iommu@lists.linux.dev>, Kevin Tian
	<kevin.tian@intel.com>
Subject: Re: [PATCH V7 9/9] iommufd: map file selftest
Message-ID: <Zx12sBalOPZBlZOm@Asurada-Nvidia>
References: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
 <1729861919-234514-10-git-send-email-steven.sistare@oracle.com>
 <ZxvPhQZOBR7g56eh@Asurada-Nvidia>
 <2c7edd3b-61c7-4012-b825-4972c0efcec5@oracle.com>
 <Zxvl7J0mWkKPS4GD@Asurada-Nvidia>
 <20241025235849.GL6956@nvidia.com>
 <37483959-3ff1-44fb-b3f5-f1c0859de1ef@oracle.com>
 <1af8d6b6-6640-4299-b279-eaf943707664@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1af8d6b6-6640-4299-b279-eaf943707664@oracle.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|BY5PR12MB4195:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b63e464-65c6-4a3f-e4ba-08dcf61349c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mKim4QMii0+QV0haKS4juH0DO/UgS5lYQX9U9iFHt/Ut27xqv1m532/SwCes?=
 =?us-ascii?Q?KjKdYvfuPw+1+DkGw2iOSSf92Pp4ETdxUtkVrOSilpeZHDD2M3q0yinq1iep?=
 =?us-ascii?Q?eOq+9OA6RQtUS1qoTQ+g8XUbBo9xEjzdnPzIw1SUpHZIMTer5hLuQqRv8T3X?=
 =?us-ascii?Q?lft2RlrP9VXaC/5gS0ykH+AB+8vYz7WlNMfhEMmugrFmxiov78PuU2r6hGVc?=
 =?us-ascii?Q?h6cIlHYqRCKPwHGF2dRQRRGcrgZeOt6oB5JIXNP89Qkz8BPXZwFBWVSGDbVL?=
 =?us-ascii?Q?DYEMvDkakIOgDzXCcdijoTWCcFxnZVMESmIARR8KfzZFDesQcLRjMdQ42NGC?=
 =?us-ascii?Q?KeItWJhAwVboMG8v97U9wEbaOzIaG7dnpnd9memuLvuG32y3kdG2z1HqnrFx?=
 =?us-ascii?Q?ekX4BbKflgzR3wMh+xWOmkL81su6fKiDjoRGL12vjbpucy5rVyPMpB2SeUWN?=
 =?us-ascii?Q?KtTXhQ7qfcp6o459EX6VznQO2h0JPfcUR0Cu8X0mhRRxTXRpW/zttulS/qcO?=
 =?us-ascii?Q?x2nwKz3mMaZSg2F53E0libSH1vidzAoBsbnj9Aj0WvaDTfF8Rx5htvUGYVWS?=
 =?us-ascii?Q?atd8c9OklHKc8/edLIVQqfOOeytzQlgV65KI15gKcUtS3cyA+af5+HvBoZZh?=
 =?us-ascii?Q?ND1UCNyCacz/f0At28fmJ4e1Q0KDGD2AZR5vEGh243kBvAhHp9dwOmL+hkCP?=
 =?us-ascii?Q?Vt/V/d23fxh/ELfIoIdxQthaRS4Oj0oQL0OAMWg5pEnT/rhSf5AshF+s+7zk?=
 =?us-ascii?Q?cjuXe5VyDzblkpjrSlyzjhOLepI8KiIM8DDZi+USnqDVdJaBPRovanEUGkjr?=
 =?us-ascii?Q?s1MhCsvoUtejUhsMLVtDP+l3c+Mbf/NLH/ULX6HiXcHrVH52X2TKMXhOt2sp?=
 =?us-ascii?Q?0Yc60ZYWLzSEtV9uqSR0QtcprK8REECsD+KyLMzEwMWV9ZyksljtbsKRBCyl?=
 =?us-ascii?Q?WxLqOoq7a8yYM8PYCLZ551StMeXShhIsGRbTS3yuepDz3Sl9vWYZgkInZcRR?=
 =?us-ascii?Q?F9QRVS1adhg8VopfW5q4OdZ+kwXevBFPkCE25bB9pMFROILIWnPzlFZrMtRW?=
 =?us-ascii?Q?JUC2N2alhVw2xXnQBTjkadrcuQAbTuc4+UoqKk+KI/O1vjxT0EJ7Q1oqXKF3?=
 =?us-ascii?Q?UxFtlhU+qWpivE0U7qchSUTeavDi+pj68VObTxCBwF6zHOOH/ZngBt6Zfb5t?=
 =?us-ascii?Q?HFj+6rb+1957yXDxv8WMhRMHtWjnomU6IVeS1hDVtyf5ia7VqlQPlpyifPSy?=
 =?us-ascii?Q?wcOM751mae+0oNpoXp+0InlgSld43qYXW47AS9gHBwh0RotlZ74jbANQTe5F?=
 =?us-ascii?Q?rsL6WCe2SBxDPr2Oe0b596ctF4eOs199zGCOJxXLZpMLTxttol8DAUjumDRH?=
 =?us-ascii?Q?XmfeeRoNETYl1n1sFBok1Jyhkaiu3ZIF7wZtGyRhFA5n9MaV4g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2024 23:09:48.0657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b63e464-65c6-4a3f-e4ba-08dcf61349c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195

On Sat, Oct 26, 2024 at 03:16:36PM -0400, Steven Sistare wrote:
> On 10/26/2024 3:13 PM, Steven Sistare wrote:
> > On 10/25/2024 7:58 PM, Jason Gunthorpe wrote:
> > > On Fri, Oct 25, 2024 at 11:39:40AM -0700, Nicolin Chen wrote:
> > > 
> > > > > I will try to reproduce your failures.
> > > > > What is your base commit?
> > > > 
> > > > I was using the for-next tree (rc1) from:
> > > > git git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git
> > > > 
> > > > And it was failing, so I guess rc1 is missing something for memfd.
> > > > So, it should be a false alarm.
> > > 
> > > Oh, that's exciting. So I will have to base it on a rc that works so
> > > bisection works :\
> > 
> > I'll test builds on arm to identify the minimum requirement.
> 
> BTW this is likely an arm-specific issue, because I have been using
> for-next rc1 on x86, and all tests pass.

I did a clean build today. And it passes with for-next tree.

Looks like something wrong with my yesterday's build. Sorry.

Nicolin
