Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7817B15532E
	for <iommu@lists.linux.dev>; Fri,  7 Jun 2024 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717795189; cv=fail; b=IFS0xDUR4m9w2XixVYFlVYYGXj1Nr+QCzwd0hJBRA5NHszM0p6qdt1pK3XCAo28BvpseTXcqcKdtdJ0SGtJNFJls5z8wHJpeZIUP0968VdShswq81SyqT9Sa/X0/hcleOaNj4Qe9alCZuT5f2jSd1O2bhC4b2VrayUoGCRkowqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717795189; c=relaxed/simple;
	bh=Y0jWRUz1YPbEebCxLTOhAThKGllKkh5yOrBz+ssad2Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQxaJUR5qgJFDEBHKW3dAtO3zCoVFWmI62+u62OMqWDTk+4Z1sReC7PMp2KBhMnV6c8MwjQ2E4Mq6rGp82UbD+4La0blZtfg77LZ07XnLXJRvD4c8aJGAm4VZvLpASPCsY1CutGYAOKvxtu2rjwck0f1StKeRgl3fJLqz8ImA88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KaMaNpG8; arc=fail smtp.client-ip=40.107.101.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KaMaNpG8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M14hMtOQlZCqoaamXATejCR4DKggJFIWRKl5Qo2NObHe2ZBcI/UsotIRZwb4SG/aKaCP2f536F0pt+Kldv5CfVDAsgOh/uMuxm2rcwYgvaU4tw67POJBqdw70TIVn5lCn+i4bjr3yBuqC+7t89pdTXFBVynKIyAfDvDG/5bxnR/HHa8KyKp/r1HsiG12YDO//CToPaBUDEZ7Qu/RLnGrV2wOCjS6ZPVctBHfKBsjOVLr+culsOHyxFvAIRSNpdkZAL5CjMPhdb7izXphh65qmpZIodwak0W1qgGwZgvZS/k0ca/Bt5kWY1zljjD7xR4N56YV4E6ry+VoAkgYR22/XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akowE2/+w2kcNkGTSHheO3yjOOqvfdw87hQWnUmCny4=;
 b=Bu6B04Su57Fq0akEqVOZSK7FhTZnN9X2rL0kuprsnX4DgOm+trwgHjCf6NuylJ8BLHrij2Po7hcTmRhs70H7vNyouGsEoGP549Us7ZzpQD0fgHqaQfYVTQnghE9G6kSmdLhXt+DnWyH6LDKbBhnZDCc5GTP7AJLE+NJeryy8zXEeJi7/RrIvG5wHBsCuxXqV2SVKbXLxeOtZyNB6XWMEZuf5pV1cfA3LHYGv0A+N9SJSotPAw8qeagR9SoNS7QbNXLCPA68fyZi73gG4+QWa043ZnZh0tk7UBk4midDJfYHoV9+G8fNzhU1H+ChxsKPSDwbUKQ62aE/zrpIUQDfeQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akowE2/+w2kcNkGTSHheO3yjOOqvfdw87hQWnUmCny4=;
 b=KaMaNpG8O3Uj4Dog+T+voScUp7WzSGzqyTppi5ZOMLnWAJ7huxS/+AOkSW9kLRyRtYj4k9UllB5HDw3D0OOY1VMnEkZuyyq4y+4wiWzmcMQQgTCJx3vVSe2Kw3rLG3OfcZ4OlAbPnwiHfJKTmmRD8DEGj5PvvRXQRrTJlDJ9vUg9lAy+CA7g8mAv3FsBzuH9fauICk8KYKwgTm6jKUa9A5mFVZoq6/1TsdXXtMKDxHJ7rSR92WgpdHH/8W4PsuuR8nKiYyOTG+9WPdYOtEoKU6vKN9VEo1kztqc1/7kgxNu/ilnqXCvFB756MGFQvkq/ZfcWQbX70IXZ10B+cIue7w==
Received: from PH7PR03CA0026.namprd03.prod.outlook.com (2603:10b6:510:339::11)
 by BL1PR12MB5993.namprd12.prod.outlook.com (2603:10b6:208:399::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Fri, 7 Jun
 2024 21:19:40 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::c7) by PH7PR03CA0026.outlook.office365.com
 (2603:10b6:510:339::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.22 via Frontend
 Transport; Fri, 7 Jun 2024 21:19:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 21:19:39 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 14:19:24 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 14:19:24 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 7 Jun 2024 14:19:23 -0700
Date: Fri, 7 Jun 2024 14:19:21 -0700
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
Message-ID: <ZmN5WZkvDeIS7RRH@Asurada-Nvidia>
References: <ZlafEktUu5znDsNt@Asurada-Nvidia>
 <BN9PR11MB5276AC43120376A2502D3D148CF32@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlfPPwsnY6P4SoGF@Asurada-Nvidia>
 <ZluWXYQjroz0fqqn@nvidia.com>
 <Zl03rsgZl/msa3I+@nvidia.com>
 <20240606182423.GF19897@nvidia.com>
 <ZmIDqgfINXfB0i3L@Asurada-Nvidia>
 <20240607002707.GJ19897@nvidia.com>
 <BN9PR11MB527604637EC37B3B03FBBE468CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240607144917.GK19897@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240607144917.GK19897@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|BL1PR12MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: c25aa394-519e-4cbf-0bba-08dc87378aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|82310400017|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?37y0ZkhrLvflV3+qqbU+0hORHeX5WETtPr9XqKtYnczJlbIqffDGVC881iWd?=
 =?us-ascii?Q?tduCOYnsWXiKo7RCoQrpwyyyBiXVOqm5fm/f23pQEd74TQWZK4cj3LUsk/rY?=
 =?us-ascii?Q?7IRM3XMtFCk+aOF0nxEA0vVDXtEeY5ivYuoD2Om63+jEY95paNkvYvdWMqzc?=
 =?us-ascii?Q?yJxdJCSViiuEuwyMAzATp5PjbQRQNCA6/22Kcj9TH9yo5oqnCtPopN+dqOJo?=
 =?us-ascii?Q?jrxQlooWKhM3oTulDRxb0Yo9fElcq5ZjhIOIfL3Eptec9xURCN+Dep8DMpmP?=
 =?us-ascii?Q?lVGjQtMKlGmsIMy/1mYvbAH2AKFPiPkNf6sPspZpD8b+CpfwH0WR1Q6uuGZE?=
 =?us-ascii?Q?3IhKFJ70PsoCcuywukAmgttX/MnAB7lK5O5IwEAdd3Chf8SKS3Wc33L1E021?=
 =?us-ascii?Q?16Jg+mmgIDF2WY7sar/BG5Y38b9phgUgW2SU/KCNGisve47IGku9GNjqH8c7?=
 =?us-ascii?Q?OT+pUBIe3/vpxyHwOXV6uymejxKL56Pf/P4+ZWF97BfKh1Xl44QrYyw/tc3F?=
 =?us-ascii?Q?23J1I+BeBt41gUwmZrvr3xy24IpyOd5iKVnn58KJCdHt8bqXC07z0Z56CrUB?=
 =?us-ascii?Q?u3LkaButkmrG/eI9sbQbdwVYbGUDTeBaZbNz5beHwlij1dKhpBxdpRdcKJVU?=
 =?us-ascii?Q?G1tTnyWrvC4mv13886nizF8JbuJ8dvwc4OOKBALjfvzak3ti3OfwhTCBdRZp?=
 =?us-ascii?Q?E8uJfSaMLwcnXrwYdTj//BLHz2TX4HVrRfubNKTieQEFkmkdd22l/smNGU13?=
 =?us-ascii?Q?u8AuH4ah+AT5sYRzcnf66Abs80svLtXVxz7kU7R5DtIj6KKQBczdA+1WsdZK?=
 =?us-ascii?Q?+Yu9ibTwEFmAM0TxtAPhgYeSfdkl9uGtxdaKM80aU2Czqqfo5M67YN/6z6jE?=
 =?us-ascii?Q?eQnHHRWLUVwZHjF3G/pAEHoMelmE+efafUcCpChEB65TEDYQjFrdCXs99Zxt?=
 =?us-ascii?Q?AxKuqcFmfVVoPgIbnWp5CoP2kSMGKONFJJ+P6sGs9gftUm00Har861dNglDl?=
 =?us-ascii?Q?qKJAzJEhXKDFU9Dun+kbYuHJmjYZOinwcNy6/ToxeJYC7L6785lak1erMRS3?=
 =?us-ascii?Q?Y7qw2YANh8bVROC8o+bH6sjAB4+A0Ew1Oj40T0DTvERs9kqVf2JT7pkNNRYR?=
 =?us-ascii?Q?//uQFKgl5DGJeHziBIqLyCfmg2gmnCAtqG5tuKVEYMWS4mz6NndSVDhQ4GZh?=
 =?us-ascii?Q?KkbLXLdxIn/FKuiXPUnW35bx/MRYsT7MvIFEit8RiVGrA2gL+HpM8D96hAcM?=
 =?us-ascii?Q?iR8iXgjCHArPy4OOSiNmtWLTuflsM/xTofcOwdvCVRZWTnpR0vFGykGM/se2?=
 =?us-ascii?Q?pzUw4scndJBqxrkRXy3ztoxxaPcLf4vcppFKkshfDuCAXXQ3q6pRemPrUNOf?=
 =?us-ascii?Q?JFykEXnCdP13TOzlOI7mMroF3B+SyDeY8/zilWDHSP3shY54wA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(82310400017)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 21:19:39.7909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c25aa394-519e-4cbf-0bba-08dc87378aad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5993

On Fri, Jun 07, 2024 at 11:49:17AM -0300, Jason Gunthorpe wrote:
> On Fri, Jun 07, 2024 at 12:36:46AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Friday, June 7, 2024 8:27 AM
> > > 
> > > On Thu, Jun 06, 2024 at 11:44:58AM -0700, Nicolin Chen wrote:
> > > > On Thu, Jun 06, 2024 at 03:24:23PM -0300, Jason Gunthorpe wrote:
> > > > > On Sun, Jun 02, 2024 at 08:25:34PM -0700, Nicolin Chen wrote:
> > > > >
> > > > > > > I understand the appeal of doing this has been to minimize qemu
> > > > > > > changes in its ACPI parts if we tackle that instead maybe we should
> > > > > > > just not implement viommu to multiple piommu. It is somewhat
> > > > > > > complicated.
> > > > > >
> > > > > > Would you please clarify that suggestion "not implement viommu
> > > > > > to multiple piommu"?
> > > > > >
> > > > > > For regular nesting (SMMU), we are still doing one vSMMU in the
> > > > > > VMM, though VCMDQ case would be an exception....
> > > > >
> > > > > This is what I mean, always do multiple vSMMU if there are multiple
> > > > > physical pSMMUs. Don't replicate any virtual commands across pSMMUs.
> > > >
> > > > Thanks for clarifying. That also means you'd prefer putting the
> > > > command dispatcher in VMM, which is what we have at this moment.
> > > 
> > > Unless someone knows a reason why we should strive hard to have only a
> > > single vSMMU and accept some invalidation inefficiency?
> > > 
> > 
> > migration? a single vSMMU provides better compatibility between
> > src/dest...
> 
> Maybe, though I think we can safely split a single pSMMU into multiple
> vSMMUs using the IOMMUFD vIOMMU interface. So if your machine model
> has two vSMMUs and your physical HW has less we can still make that
> work.
> 
> IOTLB efficiency will suffer though when splitting 1p -> 2v while
> invalidation performance will suffer when joining 2p -> 1v.

I think the invalidation efficiency is actually solvable. So,
basically viommu_invalidate would receive a whole batch of cmds
and dispatch them to different pSMMUs (nested_domains/devices).
We already have a vdev_id table for devices, yet we just need a
new vasid table for nested_domains. Right?

The immediate benefit is that VMMs won't need to duplicate each
other's dispatcher pieces, and likely helps migrations as Kevin
pointed out.

With that being said, it would make the kernel design a bit more
complicated. And the VMM still has to separate the commands for
passthrough devices (HW iotlb) from commands for emulated devices
(emulated iotlb), unless we further split the topology at the VM
level to have a dedicated vSMMU for all passthrough devices --
then VMM could just forward its entire cmdq to the kernel without
deciphering every command (likely?).

Thanks
Nicolin
