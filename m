Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F867181CFD
	for <iommu@lists.linux.dev>; Tue, 14 May 2024 22:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715725251; cv=fail; b=kWSYcX8AEEaRVuD9Z2ogAlBH1/W4ISrFvmKOX1DyFupqioPjTHEiwvSclVhXxfUmyC4hVy7ERawSU2WJKNjBnz3VtBZJLEZn+kW1kya+fX9Z9Mkt+UqGyUypeja6P+pXb9doqySo8HGsOmBt2SceT4CZLOIW6qaQy31wX6uCjBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715725251; c=relaxed/simple;
	bh=scaNhGZ+IBbkzGgM6rMAhrx4IlUxVU0a/13EQrgMR94=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlLOzPKA+li24skwQ/Vo+Wt1sKcnAzyc5v8GXxHkeFjWw2knZePjgYC2xcN7QSRYu7c2CmkxLL8CJVBGKGyDX+eqGPvtpespWw4cCn4RugII2yF2tEkrWVEfzXqGJ46hUSS0lKg8Fyhzf4LZ07pPdSekE6MO9BEWRB94HJkWKsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rT6T/uD3; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rT6T/uD3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lO1vJuhIBLQ3nFzXJpNgrz7cnYk1lgcio8oDYBjW7fKUD1aJkmnnZpxzuIHR9n7Hed6eh5bMUYIRPcTeHIXs00yA7ld/bJOppZNTOojsuda2/QgRE8arDYMwApgE76JYhuCk90XZQKBrGM0MnqueQ/yHTpUeMOnVmahB131RDA+UWmvx+H6rFITThkaEQofvZHi4HJWLqHTNjir12VrIk+in1gEqa8YP6bTWrEtqFsjcBv0iqHcP2yhjlEN6RAGqTUxtup7QPkI88dUqoRFwxq0ziq97sxyRwxfsuz2LMkgb0eeAqtKf3CGs8F7Pm/5sqAK7ly1GNYkS+XzRSohh2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvRQBHIiwdBFgn2W+o0Xeak3LSScd7JZ5d9au2/c6HM=;
 b=nfpFrEwztC//OKHn1C9pDRNj1oqk6VbZMaqtTRp9/TXY391duDzzH1Ra23TY4zDseHESauMsAKiTqYmf8p3BBQFKS/W0M+od7J9c6akTFWakZ4u3diRF3AlVoV6FGuPVZFweNyRgJ9+WiwaFvkhBB2VuLpZwRoBV+A1d8j0/1tdiEb/65nDcRuOhJELKrOizUmVChkfe+ia6dAmSzY+YFQ/D6sfbSjpQiliLKCjYj89TawUoSuylC9Aq8emwfKha/Bu8GptKfxPejyaCJgz3hoD4fazXfyAy7Iek7lmORyd2LwHVCs5OAvtJxHu4TzX8WPTjZhLCyfZ5f94POZEhCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvRQBHIiwdBFgn2W+o0Xeak3LSScd7JZ5d9au2/c6HM=;
 b=rT6T/uD3TZ8F3erLKWmQ6Jw1vZ9DZay6251bbPSuXQw/5K2B/x2e/WqG5Mhz8LLgK0QLppphu/qm5sXyU8nUh+B/E3Eb6VBDMw9IEFG1yU3am7N3cYFKKiAiJW59i4YucxKX8uMp4A26fSK6WreMTTvQ8UDLQ92d9Mzghin4dAz2aIW9ym3qZYnGGah3AOG0wlgh0YiSYQZ/D2Typ0kAoeBjtte3Cihn/L/mHTcFJ2gBAaR9RRXf4tvcb2hDuNMtM/AFDxgSOPgTPC36m/boCrw8wY2v2Lc80/8wZ5GgEC1JM4rWgAGDzEC7evT4rYPTlt3xQcOSYyTbnPioR67rXw==
Received: from BN8PR04CA0039.namprd04.prod.outlook.com (2603:10b6:408:d4::13)
 by DS0PR12MB6438.namprd12.prod.outlook.com (2603:10b6:8:ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 22:20:46 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:d4:cafe::e3) by BN8PR04CA0039.outlook.office365.com
 (2603:10b6:408:d4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Tue, 14 May 2024 22:20:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.0 via Frontend Transport; Tue, 14 May 2024 22:20:45 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 May
 2024 15:20:28 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 14 May 2024 15:20:27 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 14 May 2024 15:20:24 -0700
Date: Tue, 14 May 2024 15:20:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v7 6/6] iommu/tegra241-cmdqv: Limit CMDs for guest owned
 VINTF
Message-ID: <ZkPjqDJvkXc84At3@nvidia.com>
References: <cover.1715147377.git.nicolinc@nvidia.com>
 <062cf0a1e2b8ec6f068262cc68498b8d72b04bcc.1715147377.git.nicolinc@nvidia.com>
 <ZkDo9US02pD6vysO@nvidia.com>
 <ZkE+Fa4BS+LTxvgi@nvidia.com>
 <ZkOAAdugARILEeBh@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZkOAAdugARILEeBh@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|DS0PR12MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f9ddeaa-2898-4758-3343-08dc74641a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5mchgi8Yp2423GphFpcCBjFLzj413/nXfWu5r6/cunx5/rglOkRqluNOENSH?=
 =?us-ascii?Q?/KXoc7EPx9v8b9iKybKmAMrB/Gs5t08qql0V76/fHMiKKZfw1a9Kax8ISqJK?=
 =?us-ascii?Q?vlypLUfkUkogPft7Cqb+wXiqg4+3lSi83kPqTSsDW3ywe0sdjxKfHCcdVGfv?=
 =?us-ascii?Q?Rzto0youdrIlUXxowVOMZGppr8LRmQFP7DLUQO0hKUzdIa1F8W0GOYzhvbW1?=
 =?us-ascii?Q?fEb7RCsuLFBjBfV4L3NPexCXzI4t575em3/vTWygdjdL5cShjSpp0dKmr6H3?=
 =?us-ascii?Q?bUFDaxb1H63EwGuShBl5xnq0ozG9AhLflXXFNc+QDSZXthtYxCpzbskWNyP+?=
 =?us-ascii?Q?J7fwPus5j/O3gtndN9febUeia21KrlUE5KkpQXa9ZnI03wZqcOmgXgO5Ukuf?=
 =?us-ascii?Q?m49umgLIttlMpL3J9CB72d3Wn8mLyaY4csXdPd6fwzui5p0aJlURTBbTQtl0?=
 =?us-ascii?Q?Qku0Vv6WvLIf44wmNflPI/2TSlYKry9EVLwZikWfHnoGpDjNl/QDBN2Yuszq?=
 =?us-ascii?Q?ifDfTBQHj2CKP+DUTWJssMgupEtqUqA44LRY06WnnSsYE+xPkUggq/Bq93X2?=
 =?us-ascii?Q?DIY0Ny53T1KIrnOHpgGY7mk4Lq7oHkK1kHhwsfYSkBWaXgDExStoSEkEAKFk?=
 =?us-ascii?Q?SMJ+19Dua3Aiax+/LHYf2kSIYkkZMhPA1hYweKONTY2vQ2SKgc6SN+wRmZG5?=
 =?us-ascii?Q?oN+7aMLkwN+aXvgpXQLvx3EHLzdAzZGSJe72bkdA2owwasueDNpGzbiokRPj?=
 =?us-ascii?Q?uka5v0wAVIyiiLEsQOu68wJB+/SmVYodYQ20Ha7j8hxm+C/iF8TXXMhbaj+M?=
 =?us-ascii?Q?+2q+liPEfP34AQzbstebKH6sU3iZFQI+L05d69CP3EJt07R7z4fQK951emb8?=
 =?us-ascii?Q?fGGcBO2w3YUxktMLivrxVRSlW/Xs19Xfw4D0gr0HDuDYD1Mzb1AfDcKZXx8Z?=
 =?us-ascii?Q?X97nYYBFCTh1h8WclYw0E47W4VYStGLQ3kn8jlpj8D5AfJuo2aN30P0P5e1Y?=
 =?us-ascii?Q?m7u4fL3Ixd1WaX9ZDFP/HIlloftLFUpL4b6lkNswjSnHXrxluBAVojH93Cxt?=
 =?us-ascii?Q?D8mVtaQVya7ed2kFHuQNFh8GZCUy3SSDp0YycNrdcLktVIlgj2IMqTR/UnVU?=
 =?us-ascii?Q?4dYMS5tJfV4PQzWI4+VFgGdyCru+0iQlxbcHVYFPS3ycB49kvEj0/DvINGOR?=
 =?us-ascii?Q?9XSt/Ks1A5rH8nC64DoH7eK1p8i1LXHJglao5RJb9QmLVOkf9PWMnzyoAm2V?=
 =?us-ascii?Q?FivsqFuPwwiUUPlegFd7Ze10BAvkDa0IIcaNN3hQ0xIjS3DICzFReIVKVeif?=
 =?us-ascii?Q?lLiZ1LOd3V6QzO+pr38JOXahTNry9B4RQHpiE9DkHTNnxg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 22:20:45.9705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9ddeaa-2898-4758-3343-08dc74641a03
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6438

On Tue, May 14, 2024 at 12:15:13PM -0300, Jason Gunthorpe wrote:
> On Sun, May 12, 2024 at 03:09:25PM -0700, Nicolin Chen wrote:
> > > > -static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
> > > > +static struct arm_smmu_cmdq *
> > > > +arm_smmu_get_cmdq(struct arm_smmu_device *smmu, u8 opcode)
> > > >  {
> > > >  	if (arm_smmu_has_tegra241_cmdqv(smmu))
> > > > -		return tegra241_cmdqv_get_cmdq(smmu);
> > > > +		return tegra241_cmdqv_get_cmdq(smmu, opcode);
> > > 
> > > It is worth a comment descrbing opcode here, I think.. At least the
> > > nesting invalidation will send mixed batches.
> > 
> > Right, this makes the "opcode" look bad, though we know that the
> > "opcode" in the nesting invalidation doesn't matter because VCMDQ
> > in that case supports all commands with HYP_OWN=1.
> 
> Yeah, it isn't a real problem, it just looks a little messy and
> should have a small comment someplace at least..
>  
> > A CMD_SYNC, on the other hand, is outside the batch struct. And
> > here is another assumption that CMD_SYNC is always supported by a
> > VCMDQ..
> > 
> > I could clarify the "opcode" here with these assumptions. Or maybe
> > we should think think of a better alternative?
> 
> I don't think it really needs to be more complex, but we should
> document that invalidation is going to be special and doesn't quite
> follow this rule.

Yea. I just added this:

@@ -333,10 +333,22 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 	return 0;
 }
 
-static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
+static struct arm_smmu_cmdq *
+arm_smmu_get_cmdq(struct arm_smmu_device *smmu, u8 opcode)
 {
+	/*
+	 * TEGRA241 CMDQV has two modes to execute commands: host and guest.
+	 * The host mode supports all the opcodes, while the guest mode only
+	 * supports a few invalidation ones (check tegra241_vintf_support_cmd)
+	 * and also a CMD_SYNC added by arm_smmu_cmdq_issue_cmdlist(..., true).
+	 *
+	 * Here pass in the representing opcode for either a single command or
+	 * an arm_smmu_cmdq_batch, assuming that this SMMU driver will only add
+	 * same type of commands into a batch as it does today or it will only
+	 * mix supported invalidation commands in a batch.
+	 */
 	if (arm_smmu_has_tegra241_cmdqv(smmu))
-		return tegra241_cmdqv_get_cmdq(smmu);
+		return tegra241_cmdqv_get_cmdq(smmu, opcode);
 
 	return &smmu->cmdq;
 }

Thanks
Nicolin
