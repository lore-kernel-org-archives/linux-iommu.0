Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459B71662E7
	for <iommu@lists.linux.dev>; Sat, 12 Apr 2025 17:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744477442; cv=fail; b=myOJhfw0PIvbxNQX1tILGDaOW9ObnJiRHqtwRoIVDbrBKz12PGFuEmOhqNpZbWF44vjJSsW3YflJbZzjeLjv4lv1LJI/ScNJzP2pcsisnqdTyXziKWtZDvI7NNAnBgnOKEPFG725UTyV5c1264+7sK0AbPCw3BeMY7qKV/ycqJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744477442; c=relaxed/simple;
	bh=j+/xg7BJOAXXoYMtOwNDffiiMdx+YQhmsmrkzFEqJYE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3DH/r+M9CR2oGCXTvX49fDN6laSpgK+hbQ+q7oKYnvqqxSDS5q5L8rbjIIHA2vd0Lw9c3W8PWRUMS2P7TWeM7yKAQZ+rQ5mpSZxcSO6a3maXIGe+wJ19lJxTN0tTyD8llbn/J67RC8tPn8/2KCSBCwRWfVEJ02s1rLt0rmmZj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gcm5TOHw; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gcm5TOHw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tv0ohIEGIFjgMSPgdyNuoeDQr65r3yWFRs5Hqc8gtOH+5MR7y4b/VQrc7wy7EBZAx1tPDcg+HhsFgJ1fBAEII7odlcUFMFkFUevEwlBcyyddnRdZQs3pr/pIseDhhkgSIJuynR1vFi472VfuNsA84dh13d94h9Aup/aGmQKXDY4A2lMibLj8W0bGSIxg36khhOSluMHhQ1ZNJDLO/wSo1M0gOhngkpwxIYoM6/XmZYB+ZClcvSqliVR06xdIgRxs5fE9Yr0yrN9FtyWTYUe6OBowO64FEfgstOCHZecP0uwj38w/jIyKktI0F+Ujh+/oGl3jk3i0mDaVz41WIeoSOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQrCr4jFqBJqbwyEsfHeJYH83hNE6HlbuFqIe21u7NM=;
 b=j6EhUq8onFPDRYzdYkHdTJigfZPEW0qLW1CuAEcFqQ+9G+rB0mya//LwXVSQc55NuxfDwnYEpOhw852HgN9781Cy76cx1oMn+8zI146kDKB9H4LA0WPmBnucsTtzwZDOmPxyifzKa1PfLDHRLASlCewOQ9ECTp4BifTiD99crsK9jRh1n0FdsMFEZf0BLUt9PrQT0kw9pvRnfEM9zmUJDmy4YCYkJU07pmHTVXjhxsEyMnhPJ0U2uqr3pX909a8gLUwKzyYm/Y5bNEotDUf5kThCzhHtwnDIpqr4Os32HkVQ/RBLArlXI38tgniAcPMLhnvqQRdxSSvjxQz9cWa4qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQrCr4jFqBJqbwyEsfHeJYH83hNE6HlbuFqIe21u7NM=;
 b=gcm5TOHwgXse0u988ihkg8X3w1ShWs/ydzkc2sEgq185lddiTFvqRzzCmElrjCFdm+0KOtp6ToLasJ1jiVt/B87TVw+kPpA1Xoq9QrsSovKITE8/Nf4z1rNirmQ7oPaAC1MkiIIg4wwkDGHbb4c/vUAGrrJxu0D7ahyT/5rLvNr6DxKKMy/Tvh4Xa9gRrl6cdBDhPOt2RwyjFktBjxAy/O8nHnKfyOeH9yfsqED0Tnqa8D5q65mzurF1jO8egUzh+tK6mdYj8kFNdVK1Po7qd0c9Q7dMXj9BOX6p0fAbGSFywOQE+pAcFdNcRNz4W0bpZYCzARQEuJmZy6LBLHtFgg==
Received: from BY3PR04CA0007.namprd04.prod.outlook.com (2603:10b6:a03:217::12)
 by CH3PR12MB8353.namprd12.prod.outlook.com (2603:10b6:610:12c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Sat, 12 Apr
 2025 17:03:56 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:217:cafe::7e) by BY3PR04CA0007.outlook.office365.com
 (2603:10b6:a03:217::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.27 via Frontend Transport; Sat,
 12 Apr 2025 17:03:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sat, 12 Apr 2025 17:03:56 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 12 Apr
 2025 10:03:45 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 12 Apr
 2025 10:03:44 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Sat, 12 Apr 2025 10:03:44 -0700
Date: Sat, 12 Apr 2025 10:03:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Robin Murphy <robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<jsnitsel@redhat.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Allow stream table to have nodes with
 the same ID
Message-ID: <Z/qc7vdko9bU3otR@Asurada-Nvidia>
References: <20250411044706.356395-1-nicolinc@nvidia.com>
 <5c8d16f9-246e-45d0-aaac-45b7712cefb5@arm.com>
 <Z/mm2EQAQtOqpVCy@Asurada-Nvidia>
 <20250411234419.GC252886@nvidia.com>
 <Z/mupP6m0gRbeYtg@Asurada-Nvidia>
 <Z/ngeFHmygxnPn6f@Asurada-Nvidia>
 <20250412135514.GA329420@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250412135514.GA329420@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|CH3PR12MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: 04f5e161-9ddc-49ad-23e1-08dd79e402ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l/eAAurym+xdZCPmnZEUCCuPrJ0SV1ubGfZR42fyrMyrCtZ+cZExf14qfnf8?=
 =?us-ascii?Q?1T10ZqZ48UzNnSogdInVPnipQJSfTJGsRFS1fNzuwb7xr9Sp+khtComqeVXF?=
 =?us-ascii?Q?R3gQ8tJuzLIiE7UsNH7yj7T7TJbphc8ydIOQCLTvrR28Vt08lTouJwS4Q4Q3?=
 =?us-ascii?Q?poQwGITFcPNwonV6Ky6uZ1NP/pWmxZvtkepnxOQdT6kvQk23BK7YdMuoVed6?=
 =?us-ascii?Q?O9HzYf4P7975bYLOk4A+MD97gWo+RMwLlxoxYYTE7UbEMvUDHa+0D9RFTy8v?=
 =?us-ascii?Q?Tjgc/gtIyoCAnbMWpj+6LxQ6bihac9TFZcMYDqE16YL7fwxREE40e37Z5vuM?=
 =?us-ascii?Q?n0wBOoL+Ir6Vu9fSChKeeOar0bVzmQk79w7V7yAEOnIXV2q+qEIoOiLZgoqL?=
 =?us-ascii?Q?CjN4IfJNz8k/QVps1kCjXSswY3zbs3WmlLECFI7h/8OMmL+9RYi7l78sB0En?=
 =?us-ascii?Q?3ojb1VSb8rvQ8ZOBjuctRMrb7Q0wDsHpHH+jN4ElzBG8C9ZQd2n6SwV7pkxd?=
 =?us-ascii?Q?AQFPfRuB1yRvTycfK70BcQWdyYlOtdEhVAihNgBBnCMYLYsraCys8XNRFfLy?=
 =?us-ascii?Q?hq3RdcAUz7QySOy/e1P5ZgUulmDyJ+auv7raciiPrRvOi/f/PeKWMB2yvrb7?=
 =?us-ascii?Q?0cXTmUBMVUgTqJ0eh4nDB/YQO7WZAEjgeYJhH/pAuEE2mYmTZVLCf6x2r7ky?=
 =?us-ascii?Q?eyADK9AJnWV3aXMIF2JOHJYbwEG7mzP3GaxBhPl2od/UDblU3eJXf38n3LZB?=
 =?us-ascii?Q?FyivvwddEug3XjrDs3b64JFzWnEv+TjQ2Kadjz3ikYsFL9ve4qmt1ouNpaSP?=
 =?us-ascii?Q?Qaicb8anAV2kIg0gHISHwwPfyoHyWtvS8xZZqPF+BWiL3zVt+k75K8YgsEnt?=
 =?us-ascii?Q?/Dmg4r131/JgAhT0pVzFYZNQkLACcl/Uib6k/MItEfwCYXX1ipRjNHGTmA1U?=
 =?us-ascii?Q?hDWc4U4KVZ/YnONVW6A/HekxdbOu5r6Kid2ALYhfOkYdWZzER1JA9mGvqRX+?=
 =?us-ascii?Q?sxU6tPffwIlXUviaUysy4B3R7f9vGy3KZXfnMy5mr+MA/XS2MxxHJrW9v3iJ?=
 =?us-ascii?Q?GhvjlNfWrLevg+B89xOxVfknMwYWNZSDWTU3oxjobqau2U85KpPW9OmWOpy1?=
 =?us-ascii?Q?4c11oi3OgBbU6tx0oqp2QIAi0gRsnYjJ+irubWVbg617mlBTApFlyxpLh8J6?=
 =?us-ascii?Q?I4P3aXRrgGOgZS4+VPPQNHMyI4BaBXN47Ou+Nek6rZ7wvPzqcyPpiqIlVPxa?=
 =?us-ascii?Q?vaGncexCNyIXydQuROvRSWgCXjxlHCmYsE/mK2zQcZJ3dCKN571Apek8rvaD?=
 =?us-ascii?Q?YTPxI489OiGP2mQYVrves/70nUsJUDeS9wXnqzUq4BM860tAbhO2e/C9h0rA?=
 =?us-ascii?Q?XIHRE2FjlTp+DAThR2itlIUqNOF/M3Ar0igc4uZVr+BgY6/1tSRa+AfqnXIU?=
 =?us-ascii?Q?uOKBLEd7AxJTNhhMigKISLW4yS/BkzbsSSomSJdNE8XyxmTWLDqWSwRsr7t4?=
 =?us-ascii?Q?rp5uufQxuOHGid0BNuZrfrBrklr7bILG3maT?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2025 17:03:56.0440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f5e161-9ddc-49ad-23e1-08dd79e402ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8353

On Sat, Apr 12, 2025 at 10:55:14AM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 11, 2025 at 08:39:36PM -0700, Nicolin Chen wrote:
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index b4c21aaed1266a..97b9f8d7fb3340 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3389,6 +3389,7 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
>  	for (i = 0; i < fwspec->num_ids; i++) {
>  		struct arm_smmu_stream *new_stream = &master->streams[i];
>  		u32 sid = fwspec->ids[i];
> +		struct rb_node *existing;
>  
>  		new_stream->id = sid;
>  		new_stream->master = master;
> @@ -3398,10 +3399,20 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
>  			break;
>  
>  		/* Insert into SID tree */
> -		if (rb_find_add(&new_stream->node, &smmu->streams,
> -				arm_smmu_streams_cmp_node)) {
> -			dev_warn(master->dev, "stream %u already in tree\n",
> -				 sid);
> +		existing = rb_find_add(&new_stream->node, &smmu->streams,
> +				       arm_smmu_streams_cmp_node);

Oh right, it does find() already.

> +		if (existing) {
> +			struct arm_smmu_master *existing_master =
> +				rb_entry(existing, struct arm_smmu_stream, node)
> +					->master;
> +
> +			/* Bridged PCI devices may end up with duplicated IDs */
> +			if (existing_master == master)
> +				continue;
> +
> +			dev_warn(master->dev,
> +				 "stream %u already in tree from dev %s\n", sid,
> +				 dev_name(existing_master->dev));
>  			ret = -EINVAL;
>  			break;
>  		}
> 
> It seems like a reasonable rc fix, and if nobody has cared about DMA
> Alias support since it was broken in 2021 maybe we just leave it.

I will wrap it up and make a note with that.

Thanks!
Nicolin
