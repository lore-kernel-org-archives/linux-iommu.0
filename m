Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF64F4C79
	for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752262867; cv=fail; b=YISAq0YilPFRbOWjtjndAWu1YlMorwpITt3JfJDOxFyczp22yvC8XHxoewIYnn1TowBbWWIOTb4CnTgWuZFB4aGn9KpAclSBPrQuM2/nbj+ceMwsClg7HX2gjqhOKbrz6K/A3KU83oYs4y9G4tuljo5DPLuXQnhAdImedp+onX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752262867; c=relaxed/simple;
	bh=057pjwFwSYwnGtfViiOAeISF6TsjUf2/l4BT89uxy1c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJwY4eOn/e2Cxahg+fghooKs3+4tf9jamHPNYI4tqFM6dc4U3h4OBdKBNCOpz8xnws1k2/zd4tqFMc6crKqIj5EurLMVEYoXjYxHbDkLBdapzpP4BzVx5VHyOVT6M39rMsPlZ+TT1Eo1oS/c5IlYzKF6jPGjyrnbcFGVHbqTTos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TKJAmGol; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TKJAmGol"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mj+dqKISFqnfaeIl5NThJIABGpdJ2hSdWfkJF6A6WHw54dri2S1TackPgHOL5YKDZ01xOmEjSpWzC9TcIi9oR3GKwu60d1vhTXFkPfp199hlf0qIIHryaURDajtb2Zsy06S5QmbZHCorULcOYxRIkesnSB5TzYJVUdpFpNiYZxnQ5AdXWy3Oaw4dLYxBgxva26sYLmNeHGNmedPb4LXfuNJ4AtkFCMG8T3LAwI07vRS559LRmPpdAHDiKJm3rmiehKxOVXsK2MtrTy7GcFmqM1cqmI4Tjun5ZLVo7A8fBcxR7G++URY61FFp3g3qgsDIPBJbZ2wZsrCRMXXN2gEraQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HDpD8cEwX3VGV2PGnBcQNJmIZcdlOeX7Zo+E4EV5yw=;
 b=nrVvf7Nq6QQe2+46P0/0sctIMDre0/M3UjH+Q6uIM9SkY2PQ2gV4R+wZ04UM28wIOv/YjrycElkFEETzkezH2ne+P5uILBv4ULqP1BKCtJXow0DsUFt+CXO/4ZjmEEAl7U18uWqB977JSkMVO9wmbSN0C20wUrb4MW1RZclPt2xIksbCvPP+8hleCJZrJplMTASr8IrSzbYPgnHBDtj6LKot2W+wzw15Z09X7Nj/XdUngWK6k9yRlBGNCx/W5N6SGcVjAUXb69nr52zwX0AEXG0gi7SA8NLQoJkRrdAAys3WUUwVRJe6+JGpJv8D0oDK7RHH1tz6abQcy4PNG6D+3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HDpD8cEwX3VGV2PGnBcQNJmIZcdlOeX7Zo+E4EV5yw=;
 b=TKJAmGolThoV4ZQ4UvdINXduwX7iy1+46Mq7PFh8zw29HwFO7yT1uVOAqiY9/ZR//pez2Gx3SpESmaqy9UlaBs/XfFN1Vyg8CailzoTyMIRbdcrFqVEO+0FafPNgWpOXEqgJ2HnLb48TBxhrRACBkJqvGlEyMZUPJTwuL19vxaHhv1yDY+yaKXxwY+S5dJde+8lCAs4RDMIPDMvRTQzz42Jg6k/OmoKHtTrUEbFO7O5skrEYijb55eXgBnHEF9gY0jbC+hbhMIvcCZjMMC2PgrpfAE0zEIqV676pltXmJ6aYPWesKOguXMrMn/oCmSRr7McvcFh7/iCRUhK+Ejk/pQ==
Received: from CH0PR03CA0213.namprd03.prod.outlook.com (2603:10b6:610:e7::8)
 by IA1PR12MB6065.namprd12.prod.outlook.com (2603:10b6:208:3ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Fri, 11 Jul
 2025 19:41:02 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::ad) by CH0PR03CA0213.outlook.office365.com
 (2603:10b6:610:e7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 19:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 19:41:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 11 Jul
 2025 12:40:45 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 11 Jul
 2025 12:40:45 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 11 Jul 2025 12:40:44 -0700
Date: Fri, 11 Jul 2025 12:40:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rc] iommu/arm-smmu-v3: Revert vmaster in the error path
Message-ID: <aHFoulc0HBUKQWzm@Asurada-Nvidia>
References: <20250710233003.1662029-1-nicolinc@nvidia.com>
 <20250711164226.GE1951027@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250711164226.GE1951027@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|IA1PR12MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: eabbe004-434f-4637-93fa-08ddc0b2ddc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jHE9eeWOwLO2RejcaD+aU0IZ2vtPi6ECcUOZsoBuUnYJIKK9wtmFTBaII+Ij?=
 =?us-ascii?Q?+VEzeMiCvlf76Iyljk06HTyizkzALjJ+PlI5mBwz7ahwO3/wGRTnUQoYF6eR?=
 =?us-ascii?Q?BWLHnEXLvx+6POko6AeWVv+MzsNDhh+lR/6ybpHcgpBJDKRiAbnx26wErsjL?=
 =?us-ascii?Q?Nu3RQWThc6bi9BAhCcCCagCd5vrgDog6QcGLXYjnzgdrbySmsUfH9dTy78Q1?=
 =?us-ascii?Q?z8AnqbNtT+H7mevCnUcD9qeLmcyNdVl0FeKfkqVZGX6VbrA4VejtlphmDWeM?=
 =?us-ascii?Q?sauyAgLn9i8EuUYTURgW6LpLdQzoFAZBRZ7SdkH/O01IUoNul+eGuTjcUBLN?=
 =?us-ascii?Q?ljAuVc+GjQH8SKUD/6DxJYcJE7GopPa9H/JwPqXOCZHWB7dqbw1i2hByttuH?=
 =?us-ascii?Q?2LBuPNNPQIU3jGoL0Vej+wZ2aIlFsoAsaBml+YuHTem7ZZZGoqrYNx3EYDmu?=
 =?us-ascii?Q?A0j4B32v10G6Am1qGuwiq9NKHJbtv5pa1HtkzYUXvzqPTYoiP7w8ol5clk4A?=
 =?us-ascii?Q?29wknlZkpEknmhkh7nxoODKUPISl0YMH+Ege9PidjElRAkozkgD529dFszNw?=
 =?us-ascii?Q?eTv0cC15wnDyjS9cmcL5hnStoZW1SfIx9phld5dnKcWTnD/0zlSX68+yg8lx?=
 =?us-ascii?Q?OfRSzXra3cO/ID9qvFVGTT2oSqNd4ZFL8LtG2P7yWitbcOY7+/dBW9Z+P0yb?=
 =?us-ascii?Q?mS4oIkti5Mm5p2ON9SFuZFdDh44GrCU/rVCFupmXWZ8biLw63GrYLGEPWky1?=
 =?us-ascii?Q?IW5sKUIcBYKOIq8YFG+fldRWvlk204cH3vdQzKXCia1Goj98ybqz++5HpJNG?=
 =?us-ascii?Q?n/GD2snDIOoltH4LobvBdMTIrYwTbHk5oaIrJhqO3FOh6p2DpZhkVpfq50Fj?=
 =?us-ascii?Q?JZHNcOx2NJh25nArNuRnt+2O9er/5jW8L1DSnhsJ6aJa/0R2qVN/7dX1omT2?=
 =?us-ascii?Q?/B+L0QT+CHR2fZu539qkrkeEBl4O47upmiVIaB/l6rAh6XdjEBtCmL3PTUvs?=
 =?us-ascii?Q?gs6T3woesM97vbIgV2tbtgnhehWE3HbUXKuW/PzC/vJW7QyBeaUBXdHb3D/Y?=
 =?us-ascii?Q?/grOKvF7K8/E46mSTR+zJu1251sUrZmzqeG7vIVxcoTIEEPaWuadOi7oeTKe?=
 =?us-ascii?Q?FXFrYbig1THov4bMr6dp+pPflzecA1B5FWyfEUokqP6AUf5Ihs5Z9FneT9l9?=
 =?us-ascii?Q?rHVhOgQzT6CpNt02nYNp2oteYqC5P+yuhEqrGRT7YP0jTNP/nr7Ssk4zre1Y?=
 =?us-ascii?Q?3LQ4bgc7T44joTwZxZbNg26yyLe9FKEPZKF/aHD3HBb/Kt7SnjVSUh9hu07Y?=
 =?us-ascii?Q?wNMMGKH9G3ZHNd/M/GwA56jNJbXHVIpM0P3ySwos21RguDVlzaAfIoxdrtFa?=
 =?us-ascii?Q?9KwUXasQry8haV7DtRZTQeP3hTeRv6Aw2SKnzJejdIICouAu6G+JYKdzF1PF?=
 =?us-ascii?Q?8/Z/gsvgyqhbNiMemcxB36gQ0epH7fgTwESQKSCa63Qiy3T0FvvooHV1CM6k?=
 =?us-ascii?Q?uypVTmttrYdE6aqhj7CoROlhrp2FktROwTiv?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 19:41:01.2275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eabbe004-434f-4637-93fa-08ddc0b2ddc4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6065

On Fri, Jul 11, 2025 at 01:42:26PM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 10, 2025 at 04:30:03PM -0700, Nicolin Chen wrote:
> > The error path in the arm_smmu_attach_prepare() was introduced with the
> > arm_smmu_enable_iopf(). Due to a rebase issue, it forgot to include the
> > revert of the vmaster.
> > 
> > Move kfree(state->vmaster) to the error path, to prevent memory leak.
> > 
> > Fixes: cfea71aea921 ("iommu/arm-smmu-v3: Put iopf enablement in the domain attach path")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> The patch is fine but the commit message is a bit confusing
> 
> The error path for err_free_master_domain leaks the vmaster. Move all
> the kfrees for vmaster into the goto error section..
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

OK. I will respin one fixing that.

Thanks!
Nicolin
