Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5435A137750
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 22:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729551108; cv=fail; b=aI2aiBZwcakAT1sUdT591berNPe1rJGjkNPRIjAuiEniQqjExxMh2uoDOqLYsTO/89rQ5pvgPPgziYxMkIopFHzGNIE38paNNmy/uxI3Vcb7o9sz0zNFNAtJGZHAMGrSoHk94eqaeXwhtZwpssDbGOLRLR8KI3bF6SGHp7NAHiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729551108; c=relaxed/simple;
	bh=DQrht81B1ei/qUhgep84lsI137nZQrbfzXjIlORkIHA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFTRxpJI7bBYckzJEDGzDowjLxRTgJ1WZNiar1DyGojVVSJ6imVGy+LD4asYOcGXRSxs7YlcrtJGHDo9JFcWCsFNssCzGWSk8QLKjWJlBTqayrBrrmcYNpYd9uJEymQLaSf+bgraNFaIcmOSSkbVNrGd8H+HiFpAdbJf//U/HOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tcU9t6TE; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tcU9t6TE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLzSi6edMgeoTn/k+S7h9S998QBVSoW+CO7Bsrpl0bso6kWqosD0RhaOe39icJB7UOnI8u1jC0z82e3mlujhtIIkMY4yXMfTJKDkp3ggEWM8R2wrb9CA8ZJ87r4rk0p/XEx8H9oqzufBVDbnOLtF372AD5FU0lv7cRC5JjajxqasOURk3qnDDpWPnAaT1oK0JbkxVA0tx7iEIVttgxqiJXx2fXRHS2n5uOl1zwaQZ6KEJajk5/u6joKZJfbpgQODBxHZL9S/HhZJYo83lV1F9zbOTd78WUfTpJClaoAlGnV8zMfm/JsraGsjcCR7dKL80j1inWwERXjlQJMCcofhpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnTpIPAnu+SsSYWRyS+NoMUvz35x/fnk6M7nFpYc+Is=;
 b=dJJVSg0v1PMKriTDWdWS2ZnTWEZQwIOBctNnnn/0FiZx8qSSarLNOsnS7SYsu3mC8xjRQ1l2Nur/IvNFH+dDX+aMrEv+iHkhFJwknDicWC3cfnkbFVpoJWr+BDiCFkyPiYObfLj/oa+ysDRERPvtmTlIDTKSufTDh2e2pwVQ8gdL67sXc6Iz61DATTytCa49f1H6oo5dXKwZmbV6ahbU5soY8nVMWFMo5/ePMbnRA1cKo87aCePA2UDrOq7i8BcHEkb/DZHsWThFhbPa5Zqw2HZf+XsocTkdJxgupZhhe9baNGPp1bnewM9YTL+A4qSweIW3WgVAZ9fQdACFXnoVNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnTpIPAnu+SsSYWRyS+NoMUvz35x/fnk6M7nFpYc+Is=;
 b=tcU9t6TE152H5gh8PJoiiqAp8aph94zdSmuFjQKLlCSj7GS8Q8i35+WjofwlSDDQ+n4Vr0q4T67KsoVmL2OlhFttyQG5EKG8AoMKpJrJmuyGu5OdNxfBQhDpWRx1VJhSH1fcD0eyWvK8TyRBJdWGBBoMW1vZqMtQ9vhJQsOIiPb9HGMEEcJ0JpTO5fLkAgudq6M9+0yvdLzENSLh7oT8/PzgSjCsEv0CqY0Ttzhzi+P7WF9f6NIq3ayPRBc7eEqUC4vmq53L8cpKWn5NW94BRuBrlDc/T1Lk7uVO/D+1/OMxPQgGF61GGc+YXR5tzpt1y7bPqdKBarMIWWywrcaj5g==
Received: from SJ0P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::11)
 by MN2PR12MB4141.namprd12.prod.outlook.com (2603:10b6:208:1d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 22:51:42 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::f6) by SJ0P220CA0028.outlook.office365.com
 (2603:10b6:a03:41b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Mon, 21 Oct 2024 22:51:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 22:51:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 15:51:41 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 21 Oct 2024 15:51:41 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 15:51:41 -0700
Date: Mon, 21 Oct 2024 15:51:39 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>,
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 0/3] iommu/arm-smmu-v3: Parse out event records
Message-ID: <Zxba+8Ikho9Jf7v9@Asurada-Nvidia>
References: <20241018180022.807928-1-praan@google.com>
 <ZxMPVdRQzt//LBqG@Asurada-Nvidia>
 <ZxX1yxNBujmtYGL-@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZxX1yxNBujmtYGL-@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|MN2PR12MB4141:EE_
X-MS-Office365-Filtering-Correlation-Id: 7578aaf8-d44f-434e-acc0-08dcf222ee78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aegDcNoE9m5OcKsgezsfj66v+CwLNmNgjWgsDGKPWH9uDgiG4UT0iIvOtUP3?=
 =?us-ascii?Q?piGFj4JBaDKahzqeFpgNXULDPw2oBixgoUdYX2MZ+oUkwSvK5lff0M1rxm7j?=
 =?us-ascii?Q?o0bCkz90b1XnPH6QJ6EBzGd/9zUS7XVbg5VrsJIj3AIge7zyYE9LcsmSRkvk?=
 =?us-ascii?Q?5tKAwKMqB5INnT4K1ZyWpdSEGZHTST2QWKf6apkt4dRABCPmIpjYnL2S3Kuf?=
 =?us-ascii?Q?yOtw9sgthYjzI38TIo3ncuPcKCPpbJfd+SWV8RHZ0sWt7NB8bBTytiHDueRi?=
 =?us-ascii?Q?ImGeBiGb53OTcJFWqbuP+TNeVj+zjOjWjT/Ardl4WbZjivErEtUoVcNqc698?=
 =?us-ascii?Q?GXTltif9HOSCMB153tAThWWreJ5a3xHPc0UQTZ0Huuh+g+od3mR2OBBaSRvB?=
 =?us-ascii?Q?7w0R69ajStKgAh28P9wwI5uAaP5pXPh93AKl1lhZcNXfW8/CfuxMyAvzedfb?=
 =?us-ascii?Q?wMdO10ip8jCl7TpmlsQu0r2VSGL9rC+E2ctpISFcI13oJcfZvuCLStH3qYNm?=
 =?us-ascii?Q?DgSBuSsP1U4NrL4/3EHD4Mcn+eGLzngOU0L6mw3ydmgMkTT3/U5XmcZLKPgh?=
 =?us-ascii?Q?SQCBnvSUCCs9v8DLyerOY2TcjcGBNKO+QNkiV4smdgRBEiq3Yz1pTNrsqATf?=
 =?us-ascii?Q?qH8ad/mSNqbVyEvO0Yucf7IOb+chUxJ5Ktgz6Y77bLtGji2bNZjHvspX3neE?=
 =?us-ascii?Q?yLCaT4QiAlSvhc/fElx4if9XxGdnbM6aMqLBChHMo6cTbASiOxAOEuB2xYOt?=
 =?us-ascii?Q?/LrqqjCJcJoLPu16uluAN+Zv0l6M15ZMCQYL51VX4dko7jgvpqk0OMb0Y9vb?=
 =?us-ascii?Q?fK1LR23OkIwMsyYPYqGJP3xObZKcVNmtxD7cPRP17GnDV6etq/HfQIjxwxLK?=
 =?us-ascii?Q?/VNlRKa/QXcU6AGQsAEosUUIxf/DahHKPCs/vUWRo0BBgb/8vMt5raY8Hpdb?=
 =?us-ascii?Q?FGRxwJmge7KsGOOSsryCD57ymvSJ3WyXhPX3Hlgiu3SqPPzV4vlVTQTFK3p0?=
 =?us-ascii?Q?JycsRAvVVMcNJ/8pav1VJ/Snv7B9u/kjT6mnJ9uZLj/TXD+oJ1Tn5FG5HeN3?=
 =?us-ascii?Q?jpiG5cXSFJocH4ZqG6w84NSoabkFRJBxFcflKhVt6DHNeDzNbMBdKN9q8TMn?=
 =?us-ascii?Q?J9gFVjsu1JCqxUvbJMCyObHrm6HAf5nQ/+Nqa0Ktt3/l5eoGPhInUDwz7PnK?=
 =?us-ascii?Q?P+dV0hXTVaZ+9e98sf8QcOLCNZfboTVKde9UQ+qO41/SxuV7o2n2IEYe7L39?=
 =?us-ascii?Q?DXn7J09lq5e6tm1XX45TwsV4B7NFkVBo1P+oABc9JfyWK3G8psxOptjg3IpY?=
 =?us-ascii?Q?/2LBjqFsq2oBzUZe5TSO2fyoSSNjlBlIsQsITjV8hHJMSzvPzHj36dYIvRY+?=
 =?us-ascii?Q?NbuQEjU3mJWsnwGwXrXbf8tfym4nlznv0y4ikcLQKmXTQn9z9Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 22:51:42.3151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7578aaf8-d44f-434e-acc0-08dcf222ee78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4141

On Mon, Oct 21, 2024 at 06:33:47AM +0000, Pranjal Shrivastava wrote:
> On Fri, Oct 18, 2024 at 06:45:57PM -0700, Nicolin Chen wrote:
> > On Fri, Oct 18, 2024 at 06:00:19PM +0000, Pranjal Shrivastava wrote:
> >
> > > As requested by Nicolin, some sample logs powered by QEMU:
> > >
> > > [   85.410290] arm-smmu-v3 arm-smmu-v3.0.auto: Unexpected event received: F_PERMISSION
> > > [   85.410290]  master: 0000:00:01.0 sid: 0x00000008.0x00000
> >
> > Thanks!
> >
> > Should we print "sid.ssid:" v.s. "sid:"?
> 
> Ack. I like the idea. Btw, a sample of the longest log would be:
> 
> [   85.410290] arm-smmu-v3 arm-smmu-v3.0.auto: Unexpected event received: F_PERMISSION
> [   85.410290]  master: 0000:00:01.0 sid.ssid: 0x00000008.0x00000
> [   85.410290]  iova = 0xffffc0d0 ipa = 0x0
> [   85.410290]  Unpriv | Data | Write | S2 | Stage 1 translation table fetch | TTD Write
> [   85.410290]  STAG = 0x0 Stall = 0x0
> 
> (Note: I've hacked something manually to print the longest strings)

LGTM!
