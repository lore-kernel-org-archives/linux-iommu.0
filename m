Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7014D9F6
	for <iommu@lists.linux.dev>; Wed, 29 May 2024 03:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716952873; cv=fail; b=g1+LgemPOZrLZWHIFUvf7zb1sbyXyJl83Wxg3F7dLzQzafTv1xdCh/zaNA+Tvr/E2jmEBCV45UcrzhKEQ6W5cktfpXFGrumGauimifdQ5ap6s+FVxZxWVtMmTtQ7TuA+9u6zTIGqXMY5QFSdL4uGoNoGHzEX29XgVkxZe2lrY9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716952873; c=relaxed/simple;
	bh=SOMm15IT+JkhWYZa++LFvmzrrNSLuy1gh4Z/HKUcfwQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPC3LhCRQDd6RoqLFra9alLhnTSXkMF2FrweuHpElmo0hU8Q+/CbHIJEjmToJ1cM3Zxe6vA/wJ6TXUVAfdBaCp4o+qSOOsM2yfdQmOT6v5iLZv9B3t306clcrOErRWIY4iP8/x0vI9xtC6VBiXyN6YQ/OhV1KgDpUQbvjzrq+y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SCZLt4Tk; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SCZLt4Tk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjA7xYFm49K6WMTqznCCVgtUTaw9dJM+TjspRNwMA1di6uLE1SYeuE0FUPER34E1dFyhj6gjmQuUBWfI0AFH5tt+SwsyHaFceKxZ4TWdQ/finC0KBfiILy1Bg3fN1kB42y2IyEYjdtbQOev/kbrZPHGE+vMueHbzY1FutCLpz99MilKd+4EBh11u11anF2h1WnVLMnKVnkMue/FGKPjZcSwaw2EcBuinCaHEU5KeDI4BmAR1JrrtxG/OBzDAJlHIrounuZxJ0r+SHhDukytuh4oL2yYm5ringNiK0HFgTg1e1vcq3ecIb584LnuCGGczWxWrXFRCJiSuBUMJOLD5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTTunXqXtujk54sWHoY347iA3cWxu+VHyjCJ2mW72eQ=;
 b=hyTBwlbJ5oNvdTPmdr674q8YkTfkY8lyo9hgzobsrViaaxmqsrkoCF7+ygKGtUZChK7e6nWUrBXP6pLnjGXIX+kgofAIMDqfvuUYXOwf9n/Z+r6yWOB4EF8I8TUf94AphqBuWNRKeTYpGm7umX3neWbvoWRjy2f+J7bysv2ziAaa5pfVrT0fX5HVsycr3ubK632TQKgksODRfqjypmyJhlnZBp2qh+hZUKvN28oDwm5BNS4MpHk2AfLfLbelnGTqwAp5fE7Wq2F/EUdL/p4RCZTNzt6AvwlRdEbKAxqcw3vkENO+BHNcRdqI7SmG4ddkbvDz6MFLcKEbPAc2n702eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTTunXqXtujk54sWHoY347iA3cWxu+VHyjCJ2mW72eQ=;
 b=SCZLt4TkrLDNOtMZhF5FtZYVwSA5WnauYy/aS00jYvEE8Zcchk+uC6teniWEh/MUKGZkup/qnObMPy3sIzDv96sl42LZD5md4eqNErpWL8b1216lObtY7DtyFpWPPcjdyRDCXD5U+zG3wTYGSIEIXex1gW7UN+7Kbquxp0+Za6/ELAI5Wb5+JgHokc0zc8t8u1r199CwGAzcXmHDCPEwQ2P7qOXH0pPcKLjwDaiV3tZu5yFehWMbcYbKQ5dhUtW4l0cRgW4BI95MR23ESpxAL4hsmqpnQsXRTP6Ynhe1aHayk/b8kcmcPdon9kdSADvM3CkexpbAMkAqQQc5G739sw==
Received: from MN2PR16CA0036.namprd16.prod.outlook.com (2603:10b6:208:134::49)
 by CH3PR12MB9121.namprd12.prod.outlook.com (2603:10b6:610:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 03:21:08 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:134:cafe::71) by MN2PR16CA0036.outlook.office365.com
 (2603:10b6:208:134::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Wed, 29 May 2024 03:21:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 03:21:07 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 20:20:54 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 20:20:53 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 28 May 2024 20:20:52 -0700
Date: Tue, 28 May 2024 20:20:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
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
Message-ID: <ZlafEktUu5znDsNt@Asurada-Nvidia>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <c97a98a72ee3498c587e5898d6b899553ccd9b27.1712978212.git.nicolinc@nvidia.com>
 <BN9PR11MB5276A897A5386DFAC9A35F9D8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlAoN3s96HL7ROth@nvidia.com>
 <BN9PR11MB52762A0BC67B64D4171480C78CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240524131912.GT20229@nvidia.com>
 <BN9PR11MB5276BBD592021507C3A0EBB38CF02@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlY886FT3HHLC8Cf@nvidia.com>
 <BN9PR11MB52762EA9B444DA71F551C3868CF22@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52762EA9B444DA71F551C3868CF22@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|CH3PR12MB9121:EE_
X-MS-Office365-Filtering-Correlation-Id: ea5b4631-7ccb-46c5-e081-08dc7f8e61ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|7416005|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1ggiU19qpYBnYc7Ac6b+p+e33zMPo5jzqGr3xoDFvvKT/FckeHcp0EBLIEPk?=
 =?us-ascii?Q?gzqJ5Jn7umursg3I4KaD5xUNkYDdCJQ10GKOueMPYPw8SIM1NXLtxT7I7Q6W?=
 =?us-ascii?Q?/AakyH7u2vOQH2zl38IN8mBWD6b2hobTI1BjEs9k4Ogh3IYd73HLHIBP7m3B?=
 =?us-ascii?Q?co5VFi2WvrT7iq7uQgNB19Djpfx46T4js5LGbQtYtyXT5r45/UBES0y0MB+l?=
 =?us-ascii?Q?EFvX8ZGh64P0KLuMEWxb02gT6IDsJ3frrsK2or2cP1xnzf4leL2mQWQmaEHH?=
 =?us-ascii?Q?MKtUdx+U2otZIRN+x2X28OBz6uqg94KsNJ7Z0nUE0WL85Gd/DR7uJcSTUU9v?=
 =?us-ascii?Q?r+MheXCbztEl4KzkGKWFcertF2doM+8rvFvUUU+4KWBuiPgNMTNHNE8UfQCx?=
 =?us-ascii?Q?7bUFtENV3V+irTUgOWKsCX40/nfTL1MnFE0668Tf+feYOMVZjOKEAsqU4WFA?=
 =?us-ascii?Q?Qe16I6bRL3g3dSM0QToO+klz13eTftUIw0FXyF4Lmrm0ixO81bOKzZhA75MT?=
 =?us-ascii?Q?jknyx4UxSC+3v85gS8wA7pYAwuQnAHFGOs7n2UmwI9VKLPLa2Rd9GCej4dQb?=
 =?us-ascii?Q?fLjqrywGIVIpu9qWpTbQbvk59s0yQGxyAEN90rr2LhHufp2aaafLX/+3p2IV?=
 =?us-ascii?Q?Q+I6buW8Wgb3d/VACbd2OyXwA3VR+U0U8ocyg5ofIeHLqvydNxsJnFGuH98i?=
 =?us-ascii?Q?mtDPWYzt2EESUWE+qvMDf/ZfuH4+1jYStNg7pqBIivEh2ocdxAxeHnSHmC1K?=
 =?us-ascii?Q?SxFFDhucMxR6mkn3U70dHGyBg9AzAgNU/GnwEzVCbIiD9HMuGHiUsHTMxY04?=
 =?us-ascii?Q?pcJ30bNhNTrMf9xOHEcngxI1V9CkZ38+AuIQ/h3ygMQkOCgB6JgYb1/iBZvn?=
 =?us-ascii?Q?koDxw9Og8Mavj3aQhQfiJoAlaIGaoHNn+r4FiYGw0Js7w4LmWO9n2oDVcQH5?=
 =?us-ascii?Q?FBHtLhNLY/7TFXgjp+T9kgA2feICeFd0PRZo1yGcVU6OEJ9sKJo3qK8B4gOE?=
 =?us-ascii?Q?F9U2NIbR4GE5nhlzMOe0+6lgKicZIpr/7GPL2evscROajrUbL2ou398vxdKq?=
 =?us-ascii?Q?6NUuv+l7uB/GoNkgI7mpsP3xNxvQFghnZks4DfVfvqOf/siXuB7KRJ8T2Ebw?=
 =?us-ascii?Q?uO2phZH5+aY0Eya4AXsCYYCPIjGM+UeR4xYoqOsL+cBoVgaFA/o8rSdduhZ4?=
 =?us-ascii?Q?xFXcR7OgGoqQeY0mh6WsfqbKR7I6zGnN2My+8ylWnMYNavhRo25lPD/i8rGI?=
 =?us-ascii?Q?xONZuXdLn1WtGV/sdKebLHzzXR0lQjZAiddTVtaVFw//advwf+eiFIVVmLww?=
 =?us-ascii?Q?//tZSk2FquG1fxBi/4mgaP2gwJv9I+mGneTN383IOkR9tq4nlC0nlm139yVy?=
 =?us-ascii?Q?7zUasbU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(7416005)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 03:21:07.8449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5b4631-7ccb-46c5-e081-08dc7f8e61ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9121

On Wed, May 29, 2024 at 02:58:11AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, May 29, 2024 4:23 AM

> > What I mean is for regular vSMMU. Without VCMDQ, a regular vSMMU
> > on a multi-pSMMU setup will look like (e.g. three devices behind
> > different SMMUs):
> > |<------ VMM ------->|<------ kernel ------>|
> >        |-- viommu0 --|-- pSMMU0 --|
> > vSMMU--|-- viommu1 --|-- pSMMU1 --|--s2_hwpt
> >        |-- viommu2 --|-- pSMMU2 --|
> >
> > And device would attach to:
> > |<---- guest ---->|<--- VMM --->|<- kernel ->|
> >        |-- dev0 --|-- viommu0 --|-- pSMMU0 --|
> > vSMMU--|-- dev1 --|-- viommu1 --|-- pSMMU1 --|
> >        |-- dev2 --|-- viommu2 --|-- pSMMU2 --|
> >
> > When trapping a device cache invalidation: it is straightforward
> > by deciphering the virtual device ID to pick the viommu that the
> > device is attached to.
> 
> I understand how above works.
> 
> My question is why that option is chosen instead of going with 1:1
> mapping between vSMMU and viommu i.e. letting the kernel to
> figure out which pSMMU should be sent an invalidation cmd to, as
> how VT-d is virtualized.
> 
> I want to know whether doing so is simply to be compatible with
> what VCMDQ requires, or due to another untold reason.

Because we use viommu as a VMID holder for SMMU. So a pSMMU must
have its own viommu to store its VMID for a shared s2_hwpt:
        |-- viommu0 (VMIDx) --|-- pSMMU0 --|
 vSMMU--|-- viommu1 (VMIDy) --|-- pSMMU1 --|--s2_hwpt
        |-- viommu2 (VMIDz) --|-- pSMMU2 --|

Thanks
Nicolin
