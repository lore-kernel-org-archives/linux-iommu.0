Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD85615534D
	for <iommu@lists.linux.dev>; Fri,  7 Jun 2024 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717795291; cv=fail; b=TxUuppX/tjC/dDTxGGvvAVEp259h8H0i97e0z3lUh9JZW7epVNHtW96O5XtUuRCSy4OUF1S73hadEGxxyHzDkgglPbt1K7G3poTBsV+ZsGDXpWru6ozrJR2y5TG0gOccj/q4dYJfoj7iCda5mTK5duxmv2SAO3nleYyXnv6dJFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717795291; c=relaxed/simple;
	bh=r0S59ATIoPnV1nVvYaSBLLmSblnRnZ397mdUjh4DEzw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaZIqcyC8RqGw3obNMvnASRCfVfgu5H/T2wAn7QBbtTH30lkdQU0l2iUnYVAlzqy4wqxz4ewGjekAm8vO6WsNCOKDg7oEXs5uNpUL7Q55ZyWHuln4soigxoVNYke3KytLqNLvYx7/rm0TkhL4kMrWy7/J5v2I9FWnM2T/MSCR6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lxs4otqJ; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lxs4otqJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4hVTaDzGEFZxfRYdK/vkDme3hsbwyvlgOrFth2yyd0d+qrPYKm//9XmP9Eb8NJKpJNB53QiYu06hlf6x44fYj2pSVlXMlCYD3u28l+K9vYvUuY4CCkZiatmtn1fhVSSTlG1M+66JMzrkyYZhJb9ZG0T4cWe3do+llEAIV3Z6JdqevdK7IQSJ5+laX24lndf1JZ/3a/kpGShDnX0aNj9rRdp0/WljX1OrmhwHm5jZeHh9nkZ8ztjK8kwgj/iBVgjm/G/rNYgHLSDzwVRAG1K/wAT+JzTAkeGJH/zHw5dvl3jAnAVzbtWdPE6KJK7PgCHWV5X3ymymc1ecPfS5nzlrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBAXDjMMmSaSdrqqQoxhyQTR19r45OJsmaRhKwzk4Vk=;
 b=QP3IVin58i/mQ2Yfm7tX+pCLapRRknLelKo87ZJl6qG0BTpvKZ65ZdkYZ2GHFc44HbOqU5TXi45EV6mSTkNTZW6GI61dkpCpatCY7rwi6hJ+7RSVPdwBYussuLA37lwgpElYUfLdFavzS8lPsgTyNdCRSjTm1CdJM3b4aH5z9QHJYtxbrQWMwLvDM5wXKGI7Myq+OFmWTsUSUSUhRHPBNdjp3cqCv/2HgNwSJoIw/uLttQxhcc7tpKPgMjpDsbLRuHpjr/mSltBGM7sQvmEGywNhnMcS16McdgZmFJnTHip0DjV7R1We+8pBgCr5peakjcSBEpmdRXZw4ct6BYXIWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBAXDjMMmSaSdrqqQoxhyQTR19r45OJsmaRhKwzk4Vk=;
 b=Lxs4otqJC8e+xM/J4eBzzAwcRH5XaGtMhvI9CDqLl2AJHlgDlu4w9glcUb8475put+p4RMSq300GojuEiovnOZLM20XQo89K5DM/lNj+3nfcmN8PRr0uIWz/MHJHWZoH0jnMsN7SGugMZUqhhwlw4llnVinx3/7FNq6eCElcn/tWJmKCwPGirPgK+LAUG4+LARpv0pGFnd9cfA0q0E30VLhcxkAVrU4rM3h8fxl9mdSACzATNR6MSyIU6703iZHQ/74gaX65v3qymJNyGNZDbsJ2C//WrQUrwgCTf7m2vBlBOSaAW08RF0SxAe2XWdGAOkpdtHsrldnb4bMcNooBug==
Received: from DM6PR06CA0015.namprd06.prod.outlook.com (2603:10b6:5:120::28)
 by CH3PR12MB8284.namprd12.prod.outlook.com (2603:10b6:610:12e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 21:21:26 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:120:cafe::ac) by DM6PR06CA0015.outlook.office365.com
 (2603:10b6:5:120::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.22 via Frontend
 Transport; Fri, 7 Jun 2024 21:21:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 21:21:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 14:21:12 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 14:21:11 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 7 Jun 2024 14:21:10 -0700
Date: Fri, 7 Jun 2024 14:21:09 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "kevin.tian@intel.com"
	<kevin.tian@intel.com>, "mshavit@google.com" <mshavit@google.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, jiangkunkun <jiangkunkun@huawei.com>, zhukeqian
	<zhukeqian1@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v5 3/6] iommu/arm-smmu-v3: Add feature detection for HTTU
Message-ID: <ZmN5xZi9Qs/gQLIZ@Asurada-Nvidia>
References: <20240606133302.17540-1-shameerali.kolothum.thodi@huawei.com>
 <20240606133302.17540-4-shameerali.kolothum.thodi@huawei.com>
 <ZmJB/IjP+RVTKp/5@Asurada-Nvidia>
 <e4e6c50d181641d086cb3ef1d60b6732@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e4e6c50d181641d086cb3ef1d60b6732@huawei.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|CH3PR12MB8284:EE_
X-MS-Office365-Filtering-Correlation-Id: d562420f-9c84-4903-7d46-08dc8737ca22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|376005|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9NOTGUtJ/JOuM2DSOQzqxBZDA/lVKIOvSD1hhPl2ZMr4FWFqDU5FcInasW+r?=
 =?us-ascii?Q?Q+UG4GYGgOKS2T4Eyv3lTTGLOmWDm7sb2tKrA/PHfT6O34ruN+/oHEcfQORD?=
 =?us-ascii?Q?fx+uJTZY1OBj0xlr7+bhrZau2I+3BUZD1m5kCSwjjFVQedFv5kjrBi9sP0vm?=
 =?us-ascii?Q?iwA6xQriXsr4eGZslDTAvseYaXKtAmcLeyLzV6rjQLkFhgnSWHbxbvEuGG2S?=
 =?us-ascii?Q?i8F2Kvfe00aQKpFWOwN/36Ro9yOh96tCFTHJJdvjWdwSVOjeEVGc7bXo/tAZ?=
 =?us-ascii?Q?FvB1QmqWIhq8X5GT3FS0V479EjCicYGhJOpoUPNQhPoPHI+bMDcEOIZzo5NI?=
 =?us-ascii?Q?cqRgl8MfyZm3G39QHWeWwL59K+O8ZMc1WuDj+ebea4fAOVUsNG78hV5Q3o1x?=
 =?us-ascii?Q?KVMM6DUd/gqJowZv5/tEZQQcOMY6PHuvQrqKKaRiZdI2Rd3D2MjIiXurmdWz?=
 =?us-ascii?Q?4arPmtP2xCElSoC0qZ9mHVaq20/K5dmDIw9VOZb4/VJO52Z9A6tEcDJnpml8?=
 =?us-ascii?Q?2yRdn2hh0MQeuGhBE/QuS4jrdMo9qGclu2DUbLeR4ERKIGdswPqm1A8MlPU/?=
 =?us-ascii?Q?KlaXO/0hgzeV6NHK3oXq0Y5Y3GbnGyBzeqlKnNo32UcWGehNxvOWKE7kyUsF?=
 =?us-ascii?Q?erz0Gk4SUH6Ec6lz7OQxIUnVPnI9T8UNkDWOKPUj2VEVcCo7oJ5vq9NDLiFS?=
 =?us-ascii?Q?2m49qoZwru+6kK/ovxql39sB6W6ChRvJbKPFfAXwjgTOJDnKgMYAop7EpnzE?=
 =?us-ascii?Q?dzISH58vUaBLsFhDOV8JoGMRaKk71+RppoqO9LHNMmotee45gEY2Ylcyhn8O?=
 =?us-ascii?Q?7ADcIO4q55+8eicG6q9Ze/V3m/s9bMFxx4FEg/Bb+RSpnbqp6mC2N94OPIx/?=
 =?us-ascii?Q?MHxssdeSUMUdUVyFpIdKLLQEU3tE7kOijUEHLVjm2VsZf0R3t8vETvMM12mX?=
 =?us-ascii?Q?7tLBc6+Crys9KoKMTfwKQruXfpErQaApp6IDcAKUKGRt0nLXeLbtEKc/TpgN?=
 =?us-ascii?Q?nG5OGU53lscUWK2PQQFVeXE742JqDGgMw/3OzuDnCEFvIdC72DcO6RDHv1gy?=
 =?us-ascii?Q?7arHQp6FeuBdNmL36D8KZkLuxMrAw1Cw3bMoP4C/qZo67Lvq86FDtaZ/Jytg?=
 =?us-ascii?Q?i2eaBL9Pdb4zvZfVWh+RTsFGGPEJ0veuKzyxUY89ZA6DNXlfy2mo50lXYQJ3?=
 =?us-ascii?Q?su5hFznV/qd8cGrBSblzsNG/j/qZkiRS9weYEZMpgEkM/BJxeXtIrVlPXbH1?=
 =?us-ascii?Q?/7DGb51x0h4BSZtD7OdOn4PvQv6R/BaoGb8qgadA41+fuz+dx46k75e1TfLJ?=
 =?us-ascii?Q?PapwCs4bNgpj9RrAHq34cRlCMLltgpUoH3jYco8C92VRVZhwheeGNZUrWtrE?=
 =?us-ascii?Q?qN/VPSzT/2QGNELq6OUTUvKhkPoF9TF2gnefECs2n4kZXz9mLg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 21:21:26.2570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d562420f-9c84-4903-7d46-08dc8737ca22
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8284

On Fri, Jun 07, 2024 at 08:04:45AM +0000, Shameerali Kolothum Thodi wrote:
> > On Thu, Jun 06, 2024 at 02:32:59PM +0100, Shameer Kolothum wrote:
> >
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > index e30ce55ed1af..c05a74aa52a4 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > @@ -3738,6 +3738,29 @@ static void arm_smmu_device_iidr_probe(struct
> > arm_smmu_device *smmu)
> > >         }
> > >  }
> > >
> > > +static void arm_smmu_get_httu(struct arm_smmu_device *smmu, u32
> > reg)
> >
> > Following the other helper arm_smmu_device_iidr_probe, how about
> > arm_smmu_device_httu_probe?
> 
> Hmm..I don't have any objection per se but "_get_" feels like more simple
> and straightforward to me. Let me know if you feel strongly about this.
> 
> > And we could pass in FIELD_GET(IDR0_HTTU, reg) too?
> 
> Same here.

They are not critical. So I'd say keep it as is if you prefer :)

Thanks
Nicolin
