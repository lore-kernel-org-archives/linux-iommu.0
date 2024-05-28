Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B122FB2
	for <iommu@lists.linux.dev>; Tue, 28 May 2024 20:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716927785; cv=fail; b=rx+IdjAm6CzELvUI/HVhaQC7S5Ghr+apttmiXj6AM0EIIVXRSt5vKW8WJHwip1U7F1h7FwS8JhlGytPnvbJaDGwo+WIJz+KtJGiFYGhT/seBrMorURJIBbaN4yObs7wCtszmp+RPgNycYn4wORJWXFERKZg5q0TnlqlhwwrtePo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716927785; c=relaxed/simple;
	bh=ck5fGJJWvFmIb1iS86eVs2thqLwYvM3heCt3asUexPc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBkJs8uYqEiZ80JIcctNhetVmBOO0OUbQmh6c9sbeLopdXf3rdq+qJWgslob/jUIv82vRBeLPG6cMLWmvet/XOM4Mu/DF1AuSb5ZUj8sPBwpSiLtHrJG4aOt6hbi0ed/4n5b7cmg19abwkfbK6Mq8KSLM87trBXDuUwuL2End1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LrwialzZ; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LrwialzZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fI8QKK75ikzjM/dovl6R0p2z2Ixla0iFQRwCSGvhvy1MptBOBMlxj5MQLbB3cOq8rhkzBmCHFgvgEqnQ/hToioQkO57xMHmxVhFN1NV1u1z9ZxaYiv8boMrChL9X5J/EE76tji7wxsh4WuJhKPqKxMXdk0Agg5Kpe6I9XnlPcPtNJ5qII9eWirFHhEmYB1Nz6NjDGpYLFuB+1DpcL4beaGdhYMhgvyxBg+RybjL7Ck159aJgjG0/NVyAuzmjf0aWAtSZLPCnF5uyiJXPL7c+ekTm1ZLpTrfYgq1wUZ/2mdyJZilB5CtLp3q97RMKw1YjKnsw8ZhxdaV9IMUT5p+VJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFvxjiDnnYZjthMzcLRLTZfrr9svVBRX+WubtiFmNqg=;
 b=NDxCiErR6+No1VhpZd+0ZZDSG2u5m3bXMgVMl00/3Tvul/XfXmPxE+cKgSkW210yuyahl7tghmtremB0YfAtd8iEqd3hFBgYReplhcszK8NVWTQPPW2GeO7fbZPjoCs0D41j9VyW6Gb6mfp6vnEREjucXRtDdu7i+zrauZ9RbEWCeG80DulXPt7ywpsQ7kYOxZu08S2PTv3upNzuhhOdahh5wTUqyAaIqvlTRwdeWA7Ii2q9XgAiQ0zrVCm4s47GhEl0dTjBPWr+SOplzaI8YOJ2nT9BXWB6MDMd4nERPlcXakEhU56Y+d2ioxW2ytVfaV2Fx3GYHyGG735tJoIsSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFvxjiDnnYZjthMzcLRLTZfrr9svVBRX+WubtiFmNqg=;
 b=LrwialzZW4vfGNKvnznaIcHK9FqKnD3UB+dT6LIZju5Inw1wwKV+VphzHMXnbI4I2q9qHj9+7zOrIoFeOxGU3ekRpCoKv9A2NypV2AgKht/iGHzX9Dcs0gYuu/oVETOlCXpHgALw1WwgDYndObdQKO2Jv7ttCF5ldSMnW5iKz7RvJgs2D7zuvXXiutnxoxH6W057mj2j1Eystsl8xtYsZp4yGES5DMls5f0P36Q4u7duRMtuPN3F3nI/4hIJQQCCn1UlonJ4WJieA7zG5wPU3R3AaU/uXk5n8bj99fUwXfuLO8VEbCaUXyfg5g5gZKcARbRjopcAapjeTS0tHGxtOg==
Received: from CH5PR02CA0006.namprd02.prod.outlook.com (2603:10b6:610:1ed::16)
 by DM4PR12MB6135.namprd12.prod.outlook.com (2603:10b6:8:ac::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.17; Tue, 28 May 2024 20:23:00 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::f4) by CH5PR02CA0006.outlook.office365.com
 (2603:10b6:610:1ed::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.31 via Frontend
 Transport; Tue, 28 May 2024 20:23:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 20:23:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 13:22:47 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 28 May 2024 13:22:47 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 28 May 2024 13:22:46 -0700
Date: Tue, 28 May 2024 13:22:46 -0700
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
Message-ID: <ZlY886FT3HHLC8Cf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|DM4PR12MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: 13bc06e9-c394-40cd-e289-08dc7f53f857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400017|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0hZ5c3p16O3vXFy1ta/N3fzGoZuGSl3LeabiLM9IEUvr7ckO5sLwB5XiAuLY?=
 =?us-ascii?Q?6KHlo5aihHXebT/XsZUsEB1rNsFqCwsmkGn9hZrs6JXwPvTde/I+bNQibJnI?=
 =?us-ascii?Q?rMV75WfJLKyuXD1ofjaZE7c6PlsPC+9J66DgSAlbgr9zSZoin3CGgWgEqOj1?=
 =?us-ascii?Q?kfpAWsCJv2CHsANrhBevrKajJwAXoc9OAtfp2wF4KitlBqclNK7sXeIWP2As?=
 =?us-ascii?Q?n+Ptj13Y2CdspYt43UbhHqsOktvtdoewq9RtwV5bbBMKcsdAiW1+ddLnwUwN?=
 =?us-ascii?Q?9CnQF+wVXfF1a0fRWoOlVTdZE59pAgImxG/6liK09xWhE95Ovhb8MDpTXoJN?=
 =?us-ascii?Q?HAICTva1v9zQXiVCtbENz6znAXcAbxVWxkYsFhpC4Hd+eHXTqGwbDMmKzvdQ?=
 =?us-ascii?Q?GKBWcP6aV8mZ4mKvdsS4fH36bC0FBzoy9ifFp9S6/qsKKHEgRdAYU/uF712a?=
 =?us-ascii?Q?6N9lg8sZuUtx4ijhyH9wSKRID3DsWj52efAtLZhlMRZ0tqBqMlL0yyaZ1Ge9?=
 =?us-ascii?Q?RIFAj8LEyomlKh4ILZ7jPmujSy5cZBuNIdI3XZoQGsI4+Gmz8khn4RIzcG4y?=
 =?us-ascii?Q?3JwstypICtOLOOJokl2ZhW+tI/PIgz5AjKOz6ofZFGVC/IBZf64RfeTGoUZt?=
 =?us-ascii?Q?8rRCc/d3tHVpHddZ7wm5z89TwOK7cycWvwvR4ZP+KfQelT4HQtyBAC4+H0UR?=
 =?us-ascii?Q?YoCO3k6E53wN5EohCt8mkuPhM2MT3Q31VB9FseDhZdO51zEru3D23lU2L+f0?=
 =?us-ascii?Q?UKMuHjQn1pEyMThTHgS80OMCvG194Ckmx7G4AzPsGa1QoI11AI4TEmV49kWq?=
 =?us-ascii?Q?opYz7lCDQDj4b8/1AD6fQcg3/6MeuCfzm+21RGVxW7r8Srv6oDh4wJdjesZk?=
 =?us-ascii?Q?IkpzDzOH6lbFYKrz/a+Xvs5UTO8N/TWvYJEdye5xLUCCKkKkYV3LQSV1y3wV?=
 =?us-ascii?Q?9i+jzqO+i4G7i4xb4PlYpQ/ufYiUB9iCUWieBMc6hnOpSozvESm6KUNYNnBS?=
 =?us-ascii?Q?90NRAkuwj0S+/RVq/SyD0jDsKXneaJDBMUGMMeqP82tBnUKqx6azinocY/8l?=
 =?us-ascii?Q?Uu7BW2+V1nuUwEKpaPRqNXBDqOp+fJh4esBRzhJjjMX9st/EhR7KSYM5TDxv?=
 =?us-ascii?Q?M+lUPbi0t7R10yXCTDn2+Bac/mCiR6uyVJ+6VXOYcbnzVrsx9zueD9J2rxn2?=
 =?us-ascii?Q?MKkYXFSSyzXdJ1J5tJqSAKdrOiRVeUJK2p3nDcSQZtitViL28z1/R+OKHifD?=
 =?us-ascii?Q?VlvlLePmE1ixnz7YxGsQ2Km64lu+o+LzllDDWwcc3XGrzHXC7+9wuohut+Wo?=
 =?us-ascii?Q?fDI/qajQnPtfTnmJxN7tOwCBhAOUmbE/eEdupEQfpvPdXmVDgn7U7WAU8UNG?=
 =?us-ascii?Q?K9BIVWc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 20:23:00.3727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bc06e9-c394-40cd-e289-08dc7f53f857
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6135

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

What I mean is for regular vSMMU. Without VCMDQ, a regular vSMMU
on a multi-pSMMU setup will look like (e.g. three devices behind
different SMMUs):
|<------ VMM ------->|<------ kernel ------>|
       |-- viommu0 --|-- pSMMU0 --|
vSMMU--|-- viommu1 --|-- pSMMU1 --|--s2_hwpt
       |-- viommu2 --|-- pSMMU2 --|

And device would attach to:
|<---- guest ---->|<--- VMM --->|<- kernel ->|
       |-- dev0 --|-- viommu0 --|-- pSMMU0 --|
vSMMU--|-- dev1 --|-- viommu1 --|-- pSMMU1 --|
       |-- dev2 --|-- viommu2 --|-- pSMMU2 --|

When trapping a device cache invalidation: it is straightforward
by deciphering the virtual device ID to pick the viommu that the
device is attached to.

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
