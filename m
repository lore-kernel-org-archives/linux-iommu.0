Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8EAF4EB
	for <iommu@lists.linux.dev>; Tue, 28 May 2024 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716928252; cv=fail; b=acOEHV7mljRUxSo+T5ZC9vdOl08AOteBOXaPatbJl/kcmZGPo8yqOD/zIGk1F5y9O1Y2Dpcu039lZm1WTe4vNX/jdfVB3Oe9mfw/SSdkPvCMQp4E6OSQOTgsg4auMkg+ngDTEEBxNqcJFhiTo6m+i8FoUCHVxm3h58QjhBdaaMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716928252; c=relaxed/simple;
	bh=Ikclv5ftWDv+VQqHLnLmffBezs4hxn5V2G7iBUvSLT0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6mxmU2cC1He0SjBkDYLJKdlApAGvcNPHKYtNZ5SPndSqzcsyLBbLE4qDHk6f9e09wfe+JiRuH9rqdPFQXqM2GwMZR6yT8XVCUVX7Cwg/5lSC9QeUPskosVadqWuof+UTRjD8oQiBfvqsoxZj8ab5nEKl8Qq37v84ATOyp5nz3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m8a+0ODU; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m8a+0ODU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCatqqbPfR3n2f380sgPo9Bk0vdRcNC+/3dNm7LbPw0gopyTJ1z5FNRKkiZdU4BW5bz+qPyc+ufum7bjvk8OSz1kxLraE7WfE0/XPtFrVHL6xUNvqPb371ulYlnAEaD594tyoGamkFZsoWe5EgzhrbSDTWZfE4dz9zm8RGpQwhDDmPSNkA0f8y2xTFh5dteylCSY2y5MsHJ5kILuKyE7nvxYmd5vPwOJyJ0DJi+3/o7wsq6PRqUsla5hcdpVhkInMu7FXWQvnzIXXrfTYizVXwfLQJJwwRw74qwX935HTE8GXInqpqqhODKjZCC35ZwGgtMtzDG31VzQWqqzmapCBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGCevllixuW+plcCwPjnSjeqGZgEc/j7tbqjoMZL724=;
 b=MY6mizoLzLfU39Vs3kRY+lZ/OZfjdJPENwM5db+7Es0RKErpPcnntuBeTVkSasO3rTzhlx1lTrUbweuHmdXpBZsvYEkIdGHWpXAH2AIbb4ZHuA/H4fl4hFj2bYbzFtLaKJyaiVu1XWCH/i4mut03gME3tOcFBNmMVFwgj13o9QBlRSZpC+KKddA0B3snoy5eC2Yah6CJU5mebNJkAzJiTQKG1IgBvgqFcQsq7xTGsnjAXDcRKEvq35u6pH1IOyedg9WIH+Zbm/SMmXqtaEtuTnCGnjdx8GUQElHBppgZvy3MYQ96WRkfoFR9nrF1pEtXLASH2ur8Oi1nz5YEdkeGDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGCevllixuW+plcCwPjnSjeqGZgEc/j7tbqjoMZL724=;
 b=m8a+0ODURKqHNlEMsvcBdWNXQbcdOE4DKIV1kPHw30HpZvKblifYA+O62Mg4UdDlnl3Kj/i6uzmNjh3OVnDoRd/fTH/SZBU6RDtl9O4u8emHnFMTnr8zXx8vRx3VfZVhpBRLtLVQyDlffztSnS9drO11/ZvQWwV0AOPXz1kJ9yyrEXZLxQaZMfDJfsU7XgpMoZGE85J+Q2ZKS8BrVEnUVvhLhHpacliIS0PDpnEszQKJ76NDEKqOQb7gYhVlEzC53vVL62O6TYL7Sop+udaVdg0sz1yuJpPdcXW3G+gpi1fh8ZlTtIozr7p23gKqKsW+XKpIkcioPD4KfpFmjfQZyw==
Received: from SJ0PR13CA0073.namprd13.prod.outlook.com (2603:10b6:a03:2c4::18)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 20:30:42 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::88) by SJ0PR13CA0073.outlook.office365.com
 (2603:10b6:a03:2c4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Tue, 28 May 2024 20:30:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 20:30:42 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 13:30:18 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 13:30:18 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 28 May 2024 13:30:17 -0700
Date: Tue, 28 May 2024 13:30:16 -0700
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
Message-ID: <ZlY+2NyRW+Pod9OD@Asurada-Nvidia>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <c97a98a72ee3498c587e5898d6b899553ccd9b27.1712978212.git.nicolinc@nvidia.com>
 <BN9PR11MB5276A897A5386DFAC9A35F9D8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlAoN3s96HL7ROth@nvidia.com>
 <BN9PR11MB52762A0BC67B64D4171480C78CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240524131912.GT20229@nvidia.com>
 <BN9PR11MB5276BBD592021507C3A0EBB38CF02@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276BBD592021507C3A0EBB38CF02@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 367a26bb-6b4c-4b97-4d9a-08dc7f550ba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|7416005|1800799015|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6DP8JKAgkQ3AOv1ySnMmCttKMTq5Ivg3296pZRexaL6jg2amAbUF80bucsoH?=
 =?us-ascii?Q?fI4ogMDVOAkIIPPc6v26y5TI5b2W4raCxQqdzhSkyvI1Jh5Lee3SBO6ui7hS?=
 =?us-ascii?Q?8DYF0Zg/BqJrxU69jYlXjWMm/hLt0rRVCTp7HlHhVN9wvEashNoPJP/r7ylH?=
 =?us-ascii?Q?RpM0ujSI3ifJhK1r/0xDYuA/OKbEWzB1ql+7rlCKnbR1xC3mIJFp1tV0l9mX?=
 =?us-ascii?Q?W+M+CQVBohYgabu/C5FE//iIuxv50HBeWDcxVsX3uLCN3PQaMVqHyNfNshcU?=
 =?us-ascii?Q?wz5hkCAsqvEf5CmE0vZHrxtR7X1vmbQ3wJZUep9+siser0YMCuL1idFotlGQ?=
 =?us-ascii?Q?P8aDBAT6YiPOdLi2DN6buIN+ekLlWXzGRo4gxWedppiGIgXCUM1zfgfRSrah?=
 =?us-ascii?Q?a3ECfu7sPv8j7pFaOlsS5fkjMXlv02bbWgKKdza71S+qbrENzEMsXF5tnYlb?=
 =?us-ascii?Q?Xsq7V3qz1Aj61CADfvccdzGD+rLnnSfMbs4zfYPQGyKOejyvFQ/dtJyXd9gY?=
 =?us-ascii?Q?bBAyY/wyRXX7QewmFOAR9xCGzyAqAvIYSqh66Eltc8xsWelU0NQR03XeUEe0?=
 =?us-ascii?Q?tMDRHM6+1/f0UomGnhWQeUd2D/8A7PzeY3z1blnmwwF09eJ0QSVJ+uTm9w2I?=
 =?us-ascii?Q?SLolERDSgB+bTBrXGM8tdndk1L4VqRdaGBRcjH6NTt5mdoJQ+0f8P/a1qp6h?=
 =?us-ascii?Q?AZB2s7sjD4AI0HCAWbTAppxk+xUqBuWDNAYfiLPNHwn+O2LaeUlQx9GBAR9+?=
 =?us-ascii?Q?qlh8SqSF5ypGVeMGlB6ig0Aw5K/9RvRPufOAQRdMxLBGQv1KBg9d8K3mAsx3?=
 =?us-ascii?Q?HtyiUS4ffDW7ycoLEYjvRm2zarVqDr/vdkjbC3NYUgAiPkk5PZBCubpySoAj?=
 =?us-ascii?Q?Jat6b1C2CWNA5e6m3nCp/Ds6f/yTq0V3YPUMKTh9hNVyn2W522WWIF+DtCZD?=
 =?us-ascii?Q?3qRtEivI6S+xi+IWKgUEZy8hVCh3vrwI+zc1QfJHGi+NoXtD632dRx8vuFxh?=
 =?us-ascii?Q?YosRB3FiPyw5KtX5OIZ0cOTBNMX4aOjWDkFKqf2SloJtxlWJpvz9wTCaaxQE?=
 =?us-ascii?Q?vOtVkvrfb5Gt2kh5a380TG4xvgVatptUDYS2tJ+y4il5P1435dE76mDGgeGM?=
 =?us-ascii?Q?JMrmkHiWuGC3jVnfHIashDwH/PLF8xKCwX0EUSXcxoCWhETahdyj8WtowgHH?=
 =?us-ascii?Q?zlkSLVWnNPqf3U3F8Q+JUgzW1gsfZw6i3L48TreQMnjJs6I6A/LQ0KfT57t/?=
 =?us-ascii?Q?AJ99w3rGB5lhbF3TKwFzJMtkoNf51lSejXKwomSpMF/RPTOOHUXyqyiErWIJ?=
 =?us-ascii?Q?HG78kL3m6024bXGAP0MZnJg22RdpfTwSZkn/XN8/3fKJ92R4NSs/EDQjKdP1?=
 =?us-ascii?Q?RPnXt/I=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(1800799015)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 20:30:42.3160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 367a26bb-6b4c-4b97-4d9a-08dc7f550ba5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954

On Mon, May 27, 2024 at 01:08:43AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Friday, May 24, 2024 9:19 PM
> >
> > On Fri, May 24, 2024 at 07:13:23AM +0000, Tian, Kevin wrote:
> > > I'm curious to learn the real reason of that design. Is it because you
> > > want to do certain load-balance between viommu's or due to other
> > > reasons in the kernel smmuv3 driver which e.g. cannot support a
> > > viommu spanning multiple pSMMU?
> >
> > Yeah, there is no concept of support for a SMMUv3 instance where it's
> > command Q's can only work on a subset of devices.
> >
> > My expectation was that VIOMMU would be 1:1 with physical iommu
> > instances, I think AMD needs this too??
> >
>
> Yes this part is clear now regarding to VCMDQ.
>
> But Nicoline said:
>
> "
> One step back, even without VCMDQ feature, a multi-pSMMU setup
> will have multiple viommus (with our latest design) being added
> to a viommu list of a single vSMMU's. Yet, vSMMU in this case
> always traps regular SMMU CMDQ, so it can do viommu selection
> or even broadcast (if it has to).
> "
>
> I don't think there is an arch limitation mandating that?

What I mean is for regular a nested SMMU case. Without VCMDQ, a
regular vSMMU on a multi-pSMMU setup will look like (e.g. three
devices behind different SMMUs):
|<---- guest ---->|<--------- VMM -------->|<- kernel ->|
       |-- dev0 --|-- viommu0 (s2_hwpt0) --|-- pSMMU0 --|
vSMMU--|-- dev1 --|-- viommu1 (s2_hwpt0) --|-- pSMMU1 --|
       |-- dev2 --|-- viommu2 (s2_hwpt0) --|-- pSMMU2 --|

When trapping a device cache invalidation: it is straightforward
by deciphering the virtual device ID to pick the viommu that the
device is attached to. So, only one pSMMU would receive the user
invalidation request.

When doing iotlb invalidation, a command may or may not contain
an ASID (a domain ID, and nested domain in this case):
a) if a command doesn't have an ASID, VMM needs to broadcast the
   command to all viommus (i.e. pSMMUs)
b) if a command has an ASID, VMM needs to initially maintain an
   S1 HWPT list by linking an ASID when adding an HWPT entry to
   the list, by deciphering vSTE and its linked CD. Then it needs
   to go through the S1 list with the ASID in the command, and to
   find all corresponding HWPTs to issue/broadcast the command.

Thanks
Nicolin
