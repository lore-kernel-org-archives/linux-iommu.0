Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF6A8005C
	for <iommu@lists.linux.dev>; Tue, 11 Jun 2024 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718133127; cv=fail; b=tOZVLgytRRiMhcdTZ7VkzjKanDN87J23r1SxsZ9J8smpHQu1WKLzvctjCOTdZkRNrUSPWbwI1PctTIk2fKYZzVbsNpbly591T1GU2f4jIhZWHc/cO5X4MmsYBJpIooWvDpm2EqefJm8frv8yRZSNZ4U7WI3edDjU1snQ7v0QZnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718133127; c=relaxed/simple;
	bh=I902Xo5FonnQMHaKD5+oOfqKVnsxsIJTa6O+m3yQdFE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqLXcsP+qAQ2VTMgOWjVyTpZ57BuDfT8pzDujUULFSVsz6IitHTUuoAqLwBxVa25CjgHmtgX9Jga5YC1ZsxrIBlVeaiF1+AbdeyiT+/WfwErj6FU0qjrhNYBNVM3bIq/deRJYfjSXT4v+gUevtTmrv0jdgFUqi78qR8QRAZL7wQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IJV3tK8Q; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IJV3tK8Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExF1Xg4jJqG5KsQj49Vl7ouUlSzHTeSly3eWsmtEMSQS/tSpddgeYoEUE3Y4VShCMx5dAAoKqRVBS5IOc20CzAkEJf4M/3MqfZsxhQGoUZeNPa+J/dK9eMm+ZQemuvNeCbnyRDemDrcSdeY9ETIyWicPAzOYDWyLjkz9jEU/mHLZbw+V+dXKo663cDlUV3O5T7+k8yZjPw78Hbe4xr8P5nYESkak6oL4UqP0nKBxIdYfrioh2jqhEPK1Lz8u6q1bZBTLJNYh7qJXgfyEd5JK/bUocmj0mcrSdgSLZqH3t1zc9u+oNR0zW0KnRo40dJLgbJiuzXvShwGtRBFuPZ5JnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IiHN1MCl14aBsbww+pZL4jk3KMrg8dJ70ISEisuYsE=;
 b=BTaomVCNDzMYLW/CdBtRz4qsxSINYjoIOEjykrlolnvZmoICNGVc/7cJgnwEE5JVseeS25wtkqLGtU1f/lLsAthM/W7iDJ02ooUTw4AR5TUcuzreKjdIci7pOIbxCLBWyzYwlk9Ka72b+LKAASlUFpdQfTuxu29WrsFphftqRoKoo/r6OJj3h+oLwmRfl7BnMObGOGvnCHPU7wVN/eTkyvow+9Cx+3Mg7A+LmZqkhTfU+4hhP+7uCtE1FOtk74BhiBleMft720DgDRRle9pg9VVMK6uKyvdEuQ8btJJRwSLG2X35E1aR/OJ72GIi7Onqhq2WKrYNcuBOvJLrihMM4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IiHN1MCl14aBsbww+pZL4jk3KMrg8dJ70ISEisuYsE=;
 b=IJV3tK8QVQsESI8IWolECRhKd6KJFc/ut1nN6ndj8XWcFyuSQI63KYx0NH6CsDkgNOG/2JKbX+28S6BDAai/PDODn2hx1Jaxs4LeKVPAdVINPYKYboX6ujxMNlqP2yjC6cB1spwA+GDqBmeJV70E/2tgkt1WHr1Lp7NMGfuwlqoH4bx2MB4vb0YB9HQDJbVlPQDDrWbiZbGn0aZpYhYUL4MmWwx1DWSCnJRChVhDcD37S9QpqPnm93bfr21nutnzZFvDXHFdfV8gmxApXfW6i0OlIc2c+5LdjGROM9iqU05zNbvi81bKaHtCEDdqbALg0/aVOOjEEwzJx5rxByE9aw==
Received: from DM6PR08CA0022.namprd08.prod.outlook.com (2603:10b6:5:80::35) by
 MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 11 Jun
 2024 19:12:01 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:80:cafe::86) by DM6PR08CA0022.outlook.office365.com
 (2603:10b6:5:80::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Tue, 11 Jun 2024 19:12:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 19:12:01 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Jun
 2024 12:11:47 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 11 Jun 2024 12:11:47 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 11 Jun 2024 12:11:46 -0700
Date: Tue, 11 Jun 2024 12:11:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>, "Dhaval.Giani@amd.com"
	<Dhaval.Giani@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Message-ID: <ZmihcEA+7rU6Yt8x@Asurada-Nvidia>
References: <BN9PR11MB527604637EC37B3B03FBBE468CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240607144917.GK19897@nvidia.com>
 <ZmN5WZkvDeIS7RRH@Asurada-Nvidia>
 <20240610120446.GP19897@nvidia.com>
 <ZmdbnGnp73yR36N5@Asurada-Nvidia>
 <20240610220110.GQ19897@nvidia.com>
 <ZmeGfqp26c3sGBmF@Asurada-Nvidia>
 <20240611002839.GS19897@nvidia.com>
 <Zmed4AtFjuF7+lWd@Asurada-Nvidia>
 <20240611121756.GT19897@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240611121756.GT19897@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 06349bdf-2ee8-4f00-7baa-08dc8a4a5f88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|1800799016|7416006|376006|36860700005|82310400018;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?twTG0f/h71JOypTScagirRvZV2C3eWW+zviil59iIKJtxKw8BiH2VZMo7M+T?=
 =?us-ascii?Q?qtBqOsJHpowiHzMzvDzSKjZC91+tBFlHNCItieFRa8n0rg6XHd/lF0vSlqMY?=
 =?us-ascii?Q?2GUWY/yqzZqPkvfQxx2UU90m3Cd3m3I7/mY13HvnoOoFpDUDwsi6CnCMkAz8?=
 =?us-ascii?Q?uBAKuJXq42TEN7z0W4/q0kdhr37mB6gRPjSxyIYuV5aOKMRGecxP6D0AxFLe?=
 =?us-ascii?Q?rlvu1fJnalrkremkiJvfkznJfMVacQighZeZyY1a1eHhz4SRKIrl9SuUKJbB?=
 =?us-ascii?Q?6wHgUuAdoAGpChjd/FG3E5F9si8wL5tGpK5p/rlslHVZH8IJo7ZshDJeyr1o?=
 =?us-ascii?Q?EPu5wPk9g8tozrzb5ViqrGmbFO/IQvhZo7e8uS9ZHe4zI8ntzOCjQLxZIj+X?=
 =?us-ascii?Q?Ma+RBEVZyUvz+AKAvcTlwEaq/+JwfGNTSiTtsZtGvblmwemGNdlMpFK0Pw/7?=
 =?us-ascii?Q?KxEaMwEFDskZ8UwnGbvZwSbzabMsQZDC/kES2VGlJ8bGxYMK0+19vB/TPamB?=
 =?us-ascii?Q?R23OrpoySmtZTCHl6OWtpfr5jIBjjIQIubd/v4XhUd8JvzdhZKFJqy8vKHf/?=
 =?us-ascii?Q?lMZVJDSEnBwP69ZF6dcCEqOvcOMSyjZ9N6sMhAnbUDd/BT62OSh3HnBi/HX+?=
 =?us-ascii?Q?fDanvqxEYA6lxUPCOAQXmIKMJo/AdxlFsDfy9/2MW82QD1eta6RnGMJrbZj4?=
 =?us-ascii?Q?iNDN62Xd8S0GUcTZ6YljfBhJRvhjlZr4okeaROQTZEbP+q8jWcjn2ujGLOtw?=
 =?us-ascii?Q?7dRNJpjLvJH6pRrKe6rl3HWU0RObH3PHYgbKs0vA1NQlDsxyzTtwulPlcErr?=
 =?us-ascii?Q?d+00Cqul8jJ50GJV+2tpDYTy3ZSHJj9KqPRfNGhHjsLpgJe63MlRMN3up4sU?=
 =?us-ascii?Q?NAJwbe1Ay1bIaYTXlKS29R7FUVB1f4umRvG7vCKlJJ46wPeMCC1SmjW/L6iq?=
 =?us-ascii?Q?LjwQ57tcZg2L6S9XK2a70q2BZttNSR/5tczRJWW7UZfuzyKQ6LQ6ZtVarpn6?=
 =?us-ascii?Q?PCpghVpfJ/LcckCexwYPBLog1qUH6tIAIiYz056+NgkxlQ2fqLJGyvdcOsBI?=
 =?us-ascii?Q?sC21x5g+BaTNiQaPwZIUAaG8hvq16m9HLlYl1jCp0zDSHV4f3B5lsUl12JiO?=
 =?us-ascii?Q?oI3MIYheSu69XLnARQVOWkw8YNhLuFV//pQ3M6f8vysHBDiN61KHOiSnFVo8?=
 =?us-ascii?Q?JBQYJiOrgCMQU0TaDlU7oAR3QwTk1hOMqkIukpzIefiDyNDoz0A9slpk97wv?=
 =?us-ascii?Q?3HSqoaX1L2+GFptAYImyXLI2nSefvAo9COdC9ml7HzQzIaa26Kpg5LpLkm5Y?=
 =?us-ascii?Q?/D6/OApFXUHL97f8oTqol1n5YAON9c/ydnnk/w0IImeOID7WSC3v+X+Ky7rI?=
 =?us-ascii?Q?Sx1jyxtdSgOeJm7YL2V4bcVeC4oJnSLk6L6rWA8h+InViBkktQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230032)(1800799016)(7416006)(376006)(36860700005)(82310400018);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 19:12:01.3510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06349bdf-2ee8-4f00-7baa-08dc8a4a5f88
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883

On Tue, Jun 11, 2024 at 09:17:56AM -0300, Jason Gunthorpe wrote:
> On Mon, Jun 10, 2024 at 05:44:16PM -0700, Nicolin Chen wrote:
> > On Mon, Jun 10, 2024 at 09:28:39PM -0300, Jason Gunthorpe wrote:
> > > On Mon, Jun 10, 2024 at 04:04:30PM -0700, Nicolin Chen wrote:
> > > 
> > > > > > Actually, even now as we put a dispatcher in VMM, VMM still does
> > > > > > decode the CD table to link ASID to s1_hwpt. Otherwise, it could
> > > > > > only broadcast a TLBI cmd to all pSMMUs.
> > > > > 
> > > > > No, there should be no CD table decoding and no linking ASID to
> > > > > anything by the VMM.
> > > > > 
> > > > > The ARM architecture is clean, the ASID can remain private to the VM,
> > > > > there is no reason for the VMM to understand it.
> > > > 
> > > > But a guest-level TLBI command usually has only ASID available to
> > > > know which pSMMU to dispatch the command. Without an ASID lookup
> > > > table, how could VMM then dispatch a command to the corresponding
> > > > pSMMU?
> > > 
> > > It can broadcast. The ARM architecture does not expect a N:1 mapping
> > > of SMMUs. This is why I think it is not such a good idea..
> > 
> > Hmm, I thought we had an agreed idea that we shouldn't broadcast
> > a TLBI (except global NH_ALL/VAA) for invalidation performance?
> 
> I wouldn't say agree, there are just lots of different trade offs to
> be made here. You can reduce broadcast by parsing the CD table from
> the VMM. You can reduce broadcast with multiple vSMMUs.
> 
> VMM needs to pick a design. I favour multiple vSMMUs.

Yea, having multiple vSMMUs for nesting too seems to be a cleaner
design. The thing is that we have to put a certain complexity in
the VMM, and it should be more efficient by having it at the boot
stage (creating multi-vSMMUs/PCIs and IORT nodes) v.s. runtime
(trappings and distributing at every command).

> > CD table walkthrough would be always done only by VMM, while the
> > lookup table could be created/maintained by the kernel. I feel a
> > vasid table could make sense since we maintain the vdev_id table
> > in the kernel space too.
> 
> I'm not convinced we should put such a micro optimization in the
> kernel. If the VMM cares about performance then split the vSMMU,
> otherwise lets just put all the mess in the VMM and give it the tools
> to manage the invalidation distribution.
> 
> In the long run things like vCMDQ are going to force the choice to
> multi-smmu, which is why I don't see too much value with investing in
> optimizing the single vSMMU case. The optimization can be done later
> if someone does have a use case.

I see. That makes sense to me.

Nicolin
