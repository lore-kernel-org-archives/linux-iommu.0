Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467F563C7
	for <iommu@lists.linux.dev>; Mon, 13 May 2024 02:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715567746; cv=fail; b=fyXlWF8oRp30aUnq+VghhLA4YMMQsJWh8dFAxW6DOr8MwGXS+Zxed66dzgGwaKlvHeyPoWzA08ukm3dsuSYSeDkaw2FiXTyRqMqURErXK17xIvKY/HoHND7e5ro/KEB/8ciHr1EuyBCEgMvrjQ4ubAKBL3G12UMa+Dp8Kzi1zSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715567746; c=relaxed/simple;
	bh=I0oyRPQuNoYqh7vNZND8xUBHD9bBG/EfZqwxbjG9NGM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XietHGHomzSCVh/5+X+vAnTd3wX/8OmepCXFMMMqmynM2o72TyscKO60DbGmMe/soAzzT8IhI4l2FbWRzDNiyKvhEYfOh6gZPiz07sfKH9ThvzjRazCyccolujNFaTUhy8/XNFWc2ST+ZaaKa+eOPDe7Rq6PQHncZhF6OLY+9u8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d3Dk2NXi; arc=fail smtp.client-ip=40.107.100.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d3Dk2NXi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMnfvcSxakQ6wFhyEzmZiuhIWNgzO/IrpTk2H+B32eAUV0acTus/7LR4wgEsD/1Ne3db/D5W2+pQkZxtQ8Z7aDMIkrzuDscEsYDSkD4+B1b416KwRS872HeUWcOqwH/RUv57jwMQE+TNzJlqgBodOwgc7m4jIQ57ZihGiINxHNcmG5pZoyZQznbk8cDb/wNjWJCqcSl4bNBeQKRW/ytf9InbmbtInkI0A02PyZS+QinFGXX3Wmiib4JwxBtwBSQLyQJHOUe7yeeciS3tzL3tXLedZKvME7EUOilnR93FTMqKG+kof18WDVDXUw6jMe3QojAnbSvIVvlJ3XTGhA9qhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNfcMMV6b/5wPVBaiduOYAEKqL40c3g7wsCrg0oyEJU=;
 b=U5M4/YXvv+WARyn5+laxn1pFvJDW/G3Twy/YjRoMOZAgT9ZqYuhYDSoxQhq2uJXSbb+wK14BaWhxkkgCY805sReHIaJDmZ/AZxQgCRRSoYuvLavuXUFM/i0UMYdEzHxqVkdhad9DGcabKHDK1KfGSVexRi4fzIBvnxiuWaVtQvogyUStrsGF2Oi1QZ2iTAgcpHOAP1zffb1PucJiR8/9eSr0KBbIvPQK86gptrGRhbcqJtZbiRSqcshNqtl6CfgJModw+trdXZNCKBcg56EILaRJlAwwHLNndIl0L3u5yO1uNHD4AQ35jjL7xmgEfdtzN+h9rA3RxapCxbyvkFH0eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNfcMMV6b/5wPVBaiduOYAEKqL40c3g7wsCrg0oyEJU=;
 b=d3Dk2NXiNLAAKrWOeOCmfH6tkXjrS8kdJFrTFtXFbOS5PHm0M7sMstqtiKJQafa3sDMDV+Zsg6tRM5idRFLDg2d4SqqlsCh24VB7jd41b3ovcNujgE2FNrsS3P4bwii8zVwkfrVToond18TOF/AyqTOwPOHCpWiCO+Xljtj3BRGXoxo52jVwfj5O71JyN5wkhiSBtw2ey+NeWnvcX5K18hXce6CXq9ateGna3sAR2OIvEs2G3vWEoJpSA3SBQN5Nb4oawgOCxFhm33C9tnG3fSWEKD1CEanR9llCSjGTdG4G49XezqPtPFR9fb+JRBb6Aisw4DzFotVTH4sa35Fcww==
Received: from BYAPR02CA0043.namprd02.prod.outlook.com (2603:10b6:a03:54::20)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 02:35:41 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::ae) by BYAPR02CA0043.outlook.office365.com
 (2603:10b6:a03:54::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Mon, 13 May 2024 02:35:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 02:35:41 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 19:35:39 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 19:35:39 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Sun, 12 May 2024 19:35:35 -0700
Date: Sun, 12 May 2024 19:35:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <kevin.tian@intel.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<yi.l.liu@intel.com>, <eric.auger@redhat.com>, <vasant.hegde@amd.com>,
	<jon.grimm@amd.com>, <santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 03/14] iommufd: Prepare for viommu structures and
 functions
Message-ID: <ZkF8dA+IZc8qv/qv@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <734ef2f4b2b3e743e276d65f775062c5996064f4.1712978212.git.nicolinc@nvidia.com>
 <ZkDHNP/sCxqxeyRq@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZkDHNP/sCxqxeyRq@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|MW3PR12MB4396:EE_
X-MS-Office365-Filtering-Correlation-Id: f60b2eaa-c33d-4a90-81b0-08dc72f56203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|1800799015|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N1CGhJYZhvFrmj1OEsW11Cvhx7E+aOw2P866hiWAi73IAKPR6W/sEvXd8ZGZ?=
 =?us-ascii?Q?f7jaT10OwbMzGeOkiU0YqW4AlYq7rXVPuks5iIhkQjMgO/7C/NjVSizxc1Fx?=
 =?us-ascii?Q?vlvZS3t7t8JxxXcdphMwF1Gqye60Ck6C8YMMPOw/Sc7ZRE6NNj382Jk5AqVs?=
 =?us-ascii?Q?1OG0kFc6mnB57CZoksdZAmApKzgahlO4UrJZNnWY1KvsOV/3LvREImOme/BR?=
 =?us-ascii?Q?vlMsRkEpAyjfHMRcG9aXneOozjiL+WmH14eEinXOudkUMw+Gy1iIXazH2wsR?=
 =?us-ascii?Q?fb8WsUTBQ19ipp+5mv8t8wmIsRWndOyTMKRxOwU2lkOntvGqHD8wm0dpaZgy?=
 =?us-ascii?Q?tUPOf9EqTqWVBMdcsJ4LGYtNTwoDofk0t+Ld+kwVTACPq1pxauYpdde6RwFt?=
 =?us-ascii?Q?WEwJ5n9gx6ODd/NNExSZ4Str8I6zJ0edCYmz6FKO/GLWhe1Tpex1M1v/m2kD?=
 =?us-ascii?Q?wrkRWZY0UNzE1ixW1mVUHgpmUi7NxPhGMCpc92t1JlUNxHASBrUEfDE4TqMy?=
 =?us-ascii?Q?w9Orh4/tDbLGTxYDtLSG6//1GP9QSu+Ei8sDA3Bp9d4yPEsRva3cMOFEwaU8?=
 =?us-ascii?Q?f+7U9/pNAH6ojmXkZYiomc3+LBmo/CGw0cxX1V/GeIGqwz0pCekEf9GyDgEF?=
 =?us-ascii?Q?UwhkzjA3tOPIHeYkwPaqs0oel1d7TEIHkw/2Cfrm/sD3gVWaEuC1dve2aaCQ?=
 =?us-ascii?Q?Ho26eCtt8/RXoWLjrEXkb+Bn5T+6zF/ZCALizqWd634mv8iP9hbBSuRuZNVi?=
 =?us-ascii?Q?rWQDtokrA5uvfXby3RmpDWfpuU5frBMo2qoWDP285EY6JIdx5Ajwy1EoEw8q?=
 =?us-ascii?Q?qr7X0W71agvmqDtj4gecYCmEQ7WB44sgXvHJe/mX0h4WdjzaXxd7uO+KHPc0?=
 =?us-ascii?Q?N5THP/Qyx/39kAX8fbh+Guqexh8MsHMjrjl1wU98GLgXSNKMCmntOcBlLSNN?=
 =?us-ascii?Q?Z3HVMmsBRrEspNCiL/ntFsavSUPp0AA+8JoejecxgPSkJSlokYHg0yX1wrl9?=
 =?us-ascii?Q?ygE6dyXyzOM0Q0qiyy1dJ9EBpmF1HotWarVAeQeiRHysuEOddKjDK3o2Xg5z?=
 =?us-ascii?Q?mfl79zNp1QigsA/XiEHlbQFM0QQKv/usQZkSHjptlOA2gHvUrx6Alob5/0uu?=
 =?us-ascii?Q?X+whszuJ1/ci7mNtkpsbrQBTOs51abpYw0rGc9aWk/als98tRXgI5+7AzSq9?=
 =?us-ascii?Q?6CVRQvyAGuUn4BF8Exe2lxooEpeGLAr0PDCMGrlNkYEm3XKa4vX+NrB9PqCW?=
 =?us-ascii?Q?FTQE7lBIuLbamZ8tUw9Imin29OJtOAuC6dA3aWKcMnDvLL2peZFbU7Uvh3J/?=
 =?us-ascii?Q?IpTe2mGQvA/2kHBlHG7FWceD7tsyvjSCnOupZRI5pARQvqp+LOw+GeM/EUB0?=
 =?us-ascii?Q?VaPNDeE6JTB4wjUUKCpnbqWMyxNn?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 02:35:41.6093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f60b2eaa-c33d-4a90-81b0-08dc72f56203
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396

On Sun, May 12, 2024 at 10:42:12AM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 12, 2024 at 08:47:00PM -0700, Nicolin Chen wrote:
> 
> > +static inline struct iommufd_object *___iommufd_object_alloc(size_t size)
> > +{
> > +	struct iommufd_object *obj;
> > +
> > +	obj = kzalloc(size, GFP_KERNEL_ACCOUNT);
> > +	if (!obj)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	/* Starts out bias'd by 1 until it is removed from the xarray */
> > +	refcount_set(&obj->shortterm_users, 1);
> > +	refcount_set(&obj->users, 1);
> > +
> > +	/*
> > +	 * The allocation of an obj->id needs an ictx, so it has to be done
> > +	 * after this ___iommufd_object_alloc() callback.
> > +	 */
> > +
> > +	return obj;
> > +}
> 
> It is probably cleaner to just make the existing allocation work with
> a NULL ictx for this case? Then we can use the existing alloc
> functions.
> 
> > +#define viommu_struct_alloc(name)                                              \
> > +	struct iommufd_##name *_iommufd_##name##_alloc(size_t size)            \
> > +	{                                                                      \
> > +		struct iommufd_object *obj;                                    \
> > +		if (WARN_ON(size < sizeof(struct iommufd_##name)))             \
> > +			return NULL;                                           \
> 
> Then here you'd just use the exisint container_of based flow with the
> driver sub struct name passed as the 'obj'

Yes. And then we can probably unwrap this macro too since it's
no long that verbose to duplicate in viommu/vqueue allocators.

Thanks
Nicolin
