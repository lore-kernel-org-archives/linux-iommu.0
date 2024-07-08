Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934B514A62B
	for <iommu@lists.linux.dev>; Mon,  8 Jul 2024 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720463837; cv=fail; b=bTAaPQaNCfeK0ZevSodBn0Nz+2aGzrmd63VijmHIjEgZxCegTM03+FgQcxvg6xW9P2z0JNuDEo1N73QuJa+9w+SI+PXbjvu6950VeX2/JTZpyj49OJj3+atuWlXICNX3FNZ0MHqTvwh2IVI5kLHY6WIuqGvmfXu8QYXAYnsMt8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720463837; c=relaxed/simple;
	bh=3PA3l1wvqTfFV0sLaKeSOLi+MaNvWpErUKszcZd6Q6k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRAjZtj+LlySaX7yI5JTiowbkvlcjEf6IiKLjSL5nVxCDBqZH6Tc7z5k4K+0E++2qr9ynT/3g4uF7gJpOulV5K83XF+bsy9UP98+Dov4Y5XKVbknY6ioyJcSfJPzfbwmHG0sLkKNoaEslrXbGPM24S6oLzcjgdR4Ha5LeKPMnhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a+PZMV+6; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a+PZMV+6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVoKwNVvc1/uWEcHP5LG0iwOpTVOjwPkq6ruLp5G9ZKBJfDBFp7j1iB4xgo6qSskVAYJvEP/huArnEDrN3KsPrSHuQE+fSmq1SMLDuSB4OMqUba3YjhC+T+OfZNoKakHwaVec4HDmIA7wxMoHEE/8GQVvnjjEOh/aX3jegGstU6fyMwHr7ywZ2tyVaNhQjO0UoA/drmtHx9ZwsY2QHOraWwXpbfn0CFcFGxnZ4509V3lTnAlym0P4BQXnRsHbrAiJZh0jfYrkpUAD5i/yGBc0N9M99sFVqUnlx6QlgAW1g7vZ/ZaYzruJCUdzKSBtlW4cB9qsslFAK1hcYqqEV4kNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slz+61tt8SAKCxAqxA8vu78StbLvXWUn4f/hvhF/xLA=;
 b=GyuttGtkxa3eGcmgRE3cv92EnbixtMg+YN4mKTcgDEyl3dH9iDvCZTF5AeBw2HCjQUdlnipbLuC/qAaKKfwVx7e7nq2kwjr78U8t/z/N0uOj0bOTdiMdh88fmvEouOq36XzZNhP9v1OxNbtNL2ZDRJqZ2UX2o/Vbm+VBXC2/ZzWUmJ/Wt2xl5NeHCudN8aMmRV/FdJPVwRfcR+luzAM/7TYpI3dqQD1O0xlskeTvoWc0GDliWzwrEZ2aVLqsOMK57qvVinTrGGznSU2x9ombNOYS3pyh8KwBGjPFkt1HwnMy4espdW8hIwrm9DoYbycUmOwzWCIl+V9QiSUDpwNUGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slz+61tt8SAKCxAqxA8vu78StbLvXWUn4f/hvhF/xLA=;
 b=a+PZMV+60Kak5QAFxp5c99xafY//TO7AUOjKsVLyt1JJjVq65ZIQA5ImH1G8GurfR+9IyCNSh6K0XZ3rFXBvqNsB3xexpvuluzdcnP7IyBssmPrkL3WH/eszF2SKL1sH2UaEeWEjBR8dMlaY+Gecw718dsEJ2fhYkSqmWqZEwePclawUJkp8xH5cLcYjCgNrnn9vgTRpLP6Lb68Z2p0rNa9wxCYHgsHeQ6IqSt5jm8zSNTGz4yUCTb+8xedNFD/Ie2LCCZk7fxAej5fwWANjoh3FIyywD8ssM8FY4QnAmA8PF8tVYijRKyvS+jyNijLdJQCIyOjHxy9PEf99A1shgw==
Received: from BYAPR05CA0033.namprd05.prod.outlook.com (2603:10b6:a03:c0::46)
 by DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Mon, 8 Jul
 2024 18:37:07 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:c0:cafe::b) by BYAPR05CA0033.outlook.office365.com
 (2603:10b6:a03:c0::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.18 via Frontend
 Transport; Mon, 8 Jul 2024 18:37:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 18:37:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 11:36:59 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 8 Jul 2024 11:36:59 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 11:36:58 -0700
Date: Mon, 8 Jul 2024 11:36:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, "Yi
 Liu" <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, "Joel
 Granados" <j.granados@samsung.com>, <iommu@lists.linux.dev>,
	<virtualization@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 06/10] iommufd: Add iommufd fault object
Message-ID: <ZowxyUQAcqDJ4yZ6@Asurada-Nvidia>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-7-baolu.lu@linux.intel.com>
 <ZoXZZ2SJ/WdlMJaX@Asurada-Nvidia>
 <20240708162957.GB14050@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240708162957.GB14050@ziepe.ca>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|DS0PR12MB8502:EE_
X-MS-Office365-Filtering-Correlation-Id: 09fa7c5c-fff0-46a0-b8a9-08dc9f7cf856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GWJeH7wwmJwDSunchi/qDAxJdSb8lwuw+Yr6gwdyTuZ+kDztJBCbwclzPTRs?=
 =?us-ascii?Q?RoFhPwUTp977xPV8siV7aUmxzGpzMZBNK9ReG6tSWNS+XAYOHbCVCRwk4iLO?=
 =?us-ascii?Q?CfmNqWv6D0gSaHhsDvvmzl4iHyL6ZNO8EmB8AJJA5s4+CYY+Lw8/RMAWHl9m?=
 =?us-ascii?Q?koOPTrTMHZ4ulO7XySamBhKg6YexkwKL+kVpLWQ2wVUn2vAZ/OSo5EieKiRD?=
 =?us-ascii?Q?I56/YFwiIgBXyDrIzMeb4pAIAkp2Wdao2rHL/+s3Ox423thOC5/1pr/rv5as?=
 =?us-ascii?Q?0OLg8PmR6xngIF73Py/S9n/5kcz9GgvqWuZVf27J0Qa6CIm2DYo0XHAROuLs?=
 =?us-ascii?Q?zAhVrLeLyPNlLl5FSG/CEpaqbLPb2u44ERsqR3w3sgk6msbV0M9fXka/Q5ig?=
 =?us-ascii?Q?ul7z1WHhqZ7A8pN88SkhHeLUhpAqzLrJ4g4TnPKpYCLPD/YZj8jtpGK04nzv?=
 =?us-ascii?Q?rP7B11NmD1WpsCDU434huF1o6193jfheeSivqQp8tb9c8bKPu/zsm0b2r0rU?=
 =?us-ascii?Q?mj2/NhIbRMp+1eX4G4eS/2a02VVKqbNCKOKLs6GkfAWO6yuL6vYcHyW7rj16?=
 =?us-ascii?Q?b/6AqzNzyFvGAoGy3B1WDWo/Rw5bPXKsb+TbFTUbKBIkkxClTndNFdz8A8Cj?=
 =?us-ascii?Q?mSRQ88ogCfC5FJQ1NhdVEY545VnAVlFIVxY4HjE6lUJJ/oLS92XNY81bucdx?=
 =?us-ascii?Q?sgSyZJzgKZQdm6ugsaajsWhg2Y4MEt/LtYYynvDtrteMlEGjx5PHpTPvB4iv?=
 =?us-ascii?Q?veAFNSKithBmtQQJmo6dpPUNa/4Gf6NjI1JW9/eqkSHwN8UDlhI6bHBqXeso?=
 =?us-ascii?Q?LnfBlJuugYX5VhTjyzoMn9Q8s11xmtC8fjq+NHYkxmKFeZDWUn3f0txaFlKo?=
 =?us-ascii?Q?10GanfmtAnAZ1uDMnlXkznbEgqgEvLezy0TDtOscRuw3KuIU221Z62UZE8tB?=
 =?us-ascii?Q?pRmf65FRUAl7ctthGHn4RvjtDSb2cLkYzzyFS0+p1isbvi7CW3G6+qFSCUpJ?=
 =?us-ascii?Q?FakovmSRcV9x1yb8xs97RpyDY+x8uL8oEIHmC7EMm6OOVOy5MlyT9VDiRaEi?=
 =?us-ascii?Q?O5MB3KsIC+Q0I+vEXCQXjyMbElQW2I7WKNhjaU96f2E6JDgyP539KIeUN3EO?=
 =?us-ascii?Q?kjaP06ISuU4t4SJAzeY6dI+0M70H1QhUu5YnFJo4wZejHvoRDBVPAeN81KMl?=
 =?us-ascii?Q?33CJBAkNFB2+eIWVSN7yKt4D6SVFJ4bY3Z7ILDEmWqgYh1nf2GgD71RoLWXB?=
 =?us-ascii?Q?oKagY6QKVPvpgdyZpBmiavqlJQnzSfYdNKY1eBo51E++V2cjHKECgO8RZzVy?=
 =?us-ascii?Q?Uxjnl1aioLZEnQhW1nWfKvmuhAqrC2HTWF+69KXwASEMaAWYjskCu2hm5TJ5?=
 =?us-ascii?Q?JTpC8S5JDCIRljxODyngO0W7baShHoVtnswRKS88jqyjfucsLSQFZH87CKzV?=
 =?us-ascii?Q?y2YrUn9D2GsaFkHrtGvVSi6sC0kyp46Y?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 18:37:07.0649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09fa7c5c-fff0-46a0-b8a9-08dc9f7cf856
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8502

On Mon, Jul 08, 2024 at 01:29:57PM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 03, 2024 at 04:06:15PM -0700, Nicolin Chen wrote:
> 
> > I learned that this hwpt->fault is exclusively for IOPF/PRI. And
> > Jason suggested me to add a different one for VIOMMU. Yet, after
> > taking a closer look, I found the fault object in this series is
> > seemingly quite generic at the uAPI level: its naming/structure,
> > and the way how it's allocated and passed to hwpt, despite being
> > highly correlated with IOPF in its fops code. So, I feel that we
> > might have a chance of reusing it for different fault types:
> >
> > +enum iommu_fault_type {
> > +     IOMMU_FAULT_TYPE_HWPT_IOPF,
> > +     IOMMU_FAULT_TYPE_VIOMMU_IRQ,
> > +};
> >
> >  struct iommu_fault_alloc {
> >       __u32 size;
> >       __u32 flags;
> > +     __u32 type;  /* enum iommu_fault_type */
> >       __u32 out_fault_id;
> >       __u32 out_fault_fd;
> >  };
> 
> I think I would just add the type at the end of the struct and rely on
> our existing 0 is backwards compat mechanism. 0 means HWPT_IOPF. ie no
> need to do anything now.

Yea, I figured that it would work too, so let's add one in the
VIOMMU series (if we eventually decide to reuse the same ioctl).

> It would make some sense to call this a "report" object than "fault"
> if we are going to use it for different things. We could probably
> rename it without much trouble. There is also not a significant issue
> with having two alloc commands for FDs.

Ack.

> I'd also think VIOMMU_IRQ is probably not that right abstraction,
> likely it makes more sense to push driver-specific event messages sort
> of like IOPF and one of the messages can indicate a arm-smmu-v3 VCDMQ
> interrupt, other messages could indicate BAD_CD and similar sorts of
> events we might want to capture and forward.

Maybe something like this?

struct iommu_viommu_event_arm_smmuv3 {
	u64 evt[4];
};

struct iommu_viommu_event_tegra241_cmdqv {
	u64 vcmdq_err_map[2];
};

enum iommu_event_type {
	IOMMM_HWPT_EVENT_TYPE_IOPF,
	IOMMU_VIOMMU_EVENT_TYPE_SMMUv3,
	IOMMU_VIOMMU_EVENT_TYPE_TEGRA241_CMDQV,
};

struct iommu_event_alloc {
	__u32 size;
	__u32 flags;
	__u32 out_event_id;
	__u32 out_event_fd;
	__u32 type;
	__u32 _reserved;
};

It can be "report" if you prefer.

Thanks
Nicolin
