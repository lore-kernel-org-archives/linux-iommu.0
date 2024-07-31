Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA455C613
	for <iommu@lists.linux.dev>; Wed, 31 Jul 2024 18:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722450227; cv=fail; b=t/ECMbnzLy55MlhlzmyAyAUUbHw2ykPNNhUqRIVxnQr1XhSqiPYp0yRUw3JSY5VlpNUcxpf9E3H+zI/+NuFXB3Ct+ZVgszMn7JA02yO2HMLz55YGEHssG0b1cj6rr83kJaft/KRO9lx1bGjRWZswlqkqeyK7REoPZNC41zPwn3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722450227; c=relaxed/simple;
	bh=F8QFxQ0BE1ep5vkvZ7Xko8Apbu+zbpdVzuayHvxoc7E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFw1PMUziepAio4Bv7z5EYskJMA3hl6svPYDUJFa7ak3SmJEyK5mTw4FSo20ARlxL/DmpzJFZa/7+MUVOBww0bfpR8VDz2igVhksVjnLaIm8VrM4TQZEAW00kgt2KUXm2qOtVmYwaOEPmBgKcRBOwpjYU6uQdKk5U6re9AWX6yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MTPx0y8f; arc=fail smtp.client-ip=40.107.102.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MTPx0y8f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Epmkm2OQjE9Gt1Y7DD575TxhLb1t57Z5AXja1MclBn+YeHcOe9hxF5pExB2I4FvzdZiHRU1ox2BBS8WEiEpgjCcjMxP8ZEtSVtQDOkzndZzFGe8C6DR4THHTw2BlFmI7Qlytau3mp7lWziT0BQ7BmcpMoqIhjbXxeG6lo8R5x0S8GS2wFPzvrdXn1pE0507XKNDrTJhtGb92ybISWWSf1GL9e8TeGnEeBgDGQVFCzOIJZyn/jpG3Z0ppSgawLNXNA3SpyM1rka4eWGmzJawuG30IvokKRSraH8VeFJYONHWKQHujgghEcJc3OT6cwbxlLwDWYncuSfkFhAVCujcTMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+tXPdxmIXlprDye405kD3AUGHPTo7N8U4SVrSsxEyU=;
 b=fQ+9r+Ey5zKhT7TpqgMtyljkLnrZrUAhJ09SAzL0AVbQWosero2cASSXCIKOhwGi81xpZYsCY7PNrD4UkiNZMX0srrgdAtF88ciBoAuICUgzP+IahHLFeu0q6/JzqtonAEcUgSQBzBtTAPNTGdbx7oPd8nuMFDaNBf9PMzmXO0eppP7ImY6O/xcdJJF5TIblT6kQCkX8HL/f5mlKlTHHNFdMP0wNtprb8NB1JJRLT19MIUcLftr9aAmNukOZZAWKyMeSCkLR/7rWn7pAPceJPrMxItjJNy69Fa/EUoyMEMbWi6AM0WUXNs7SedO8DxU2L9xk0RSQIGshbLFsDIhtbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+tXPdxmIXlprDye405kD3AUGHPTo7N8U4SVrSsxEyU=;
 b=MTPx0y8f4hMv3kbAvfGG8UJYVj5GrF3mjyDDzimvul5gfF55hCw3ucYkYjmR6NsLFSsWQwFz0lff7lJBRxayEJm5KyCyS3x49FezIdOD2D6ekMv3c5kxtVa51CqsPBwFOtKFMH7im5cwLYGS+TRAy1QzbHFJyeXnluTgw6IOAetqn+cHUvMgBYG+ZfBbvvINQmqGrGxk9Rr9ksz35Im6BJylM2Gky91vJJD/OOP3eI0fn6AqRvZYYn/RQDGUoMoJiFmUraxNHHydLV+Lt05Cxr4Wfzj8K9Rc/3lBZywLtobcj2KMGDokefKxbgPDm4uG/b5oIcSa3lJaETsA4I6RTw==
Received: from PH7P220CA0046.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::10)
 by CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 18:23:41 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::b4) by PH7P220CA0046.outlook.office365.com
 (2603:10b6:510:32b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Wed, 31 Jul 2024 18:23:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Wed, 31 Jul 2024 18:23:39 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 31 Jul
 2024 11:23:26 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 31 Jul
 2024 11:23:26 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 31 Jul 2024 11:23:25 -0700
Date: Wed, 31 Jul 2024 11:23:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommufd: Enforce IOMMU_RESV_SW_MSI upon hwpt_paging
 allocation
Message-ID: <ZqqBHKEJCm4XXFq5@Asurada-Nvidia>
References: <20240728235106.2435208-1-nicolinc@nvidia.com>
 <20240729182446.GH3371438@nvidia.com>
 <Zqf2HFUf/75hRcUU@Asurada-Nvidia>
 <BN9PR11MB5276B125671FEC70EDAFF50C8CB12@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276B125671FEC70EDAFF50C8CB12@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|CH2PR12MB4326:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa8b5aa-c8c4-448d-fc7a-08dcb18de65b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wvMbOyy3RpSm6xg+9uJcHudDB56sSZaLXypvXz5ePOO6aIfZ1UMcUZYIdLaf?=
 =?us-ascii?Q?ehDbuOnfkBOS9l1boJJpI+YD8IlEhF+PkRkDgAe1ikW4/fh9L20PoQUMPLBK?=
 =?us-ascii?Q?pQT8i3NKv/Yo7Qo6zaMvIualKH9bmXRejURezuARMc9eP/XYsqCP2Glh20tO?=
 =?us-ascii?Q?uNUCLfpn3TGS/mf1e15HCavpbRCBJCCo+X2fxYeCJAAB4NGgOtW0Pzc6ki1U?=
 =?us-ascii?Q?yLrlBiA1XpabzblTSCT8vRBHQwQ3iEx2U/aBTHsQiPo4KxeRu9BkeLdvn5B5?=
 =?us-ascii?Q?H1GgCIPeCQFSlPRVasOvhN8h0edw1V3ePIhwdnA6csitNsdqLjh11tpOaP8J?=
 =?us-ascii?Q?8ji11Hdk3wp7bLMeEKZVOhlMB7xPi6p55sqDNfefdxcjE1IzZE4HqwzJgEIl?=
 =?us-ascii?Q?JPZVvvexjPxwSXSjHQ3oYRKl1Lsptt+6brgRN9b2xw0bb0ZVZ0178Vk1GSPy?=
 =?us-ascii?Q?XMQIXjy800mmqR3eDxIaSESkZWaVkDNPzN0qT8NIjsglw28RcqxMwRdtLlTD?=
 =?us-ascii?Q?nsMf9ESrCglyp496YED40yDd7Mrn09svy+XhnccxCarKLI4CRRA9lGIH452s?=
 =?us-ascii?Q?dDf7B5ke7epa5IVtvQzurSjRcktIlZbKLd9Pv4FKw0hLxi6R+ue2FFERow1z?=
 =?us-ascii?Q?b2zkVqgoGz8K8wvOnU4+gZzMKjBRMIcSTg3OfRqyUTsEPbslbdQO/JTphFdP?=
 =?us-ascii?Q?gWKKHw7Cu3eB1f8ZhIBoU93rb8yy7Lw0sBlDW02hDYqQ0WUwxKmDWW2w/l8I?=
 =?us-ascii?Q?uKcXi87cNZWbEA/0Hd8KHvr/9Qq6rbivAgBLsYMEIuoTYXyXKRkLn2I/AySC?=
 =?us-ascii?Q?9mdMaVJpf1sy3CCvwRSpMhLxE96Xwb9kMgo68PAVIJnBhkvegutxwRK+iQLD?=
 =?us-ascii?Q?R7uPX92bIhbqMFigWBMtx8Nw0KemMzkzvQo+CcQhZKhqWDxg2D/lTnNO6oYT?=
 =?us-ascii?Q?3DBLaSp6SbIKQ4cXmrWrxk/jbnHZ0VrnGatbACAAiVlETsW9FAq2NLA7/LPU?=
 =?us-ascii?Q?zY3RVU4rzjjhJXw/cNy+Wkl3y90F1zDhwjWFjOzFGj9/Z6jo2oLGOmQVQ4Pp?=
 =?us-ascii?Q?tVHALwg5GE0LVOsTOK8jXfzLHqhpKEVlBhwAh+lHKaLy7m55hqqjpPZr3Lqw?=
 =?us-ascii?Q?Hl11dbs6j6xQXlfULQbxFLdK7gnBrHWW+F4GV7Ln3NjCX7ujUNl40V3EnOKy?=
 =?us-ascii?Q?ltOICEoaJGdLVaaJ6JW7ifbH2MowiJgRVAb2qPO5Yw8gYJLS7Ksbj3ljmopy?=
 =?us-ascii?Q?DpdEct45OBfxqCzIPsFwU0ju44qIouM7iLeEOA4SpHPleX8euOBLPciDEXRz?=
 =?us-ascii?Q?RnS8iIvX0vL/mR046AFZTWqbCmLE+a2kvHRI1F5Ss0pFAuzdjOVhiTZoj+al?=
 =?us-ascii?Q?qmgo6daq6WJWJdmUvkVUHjTRx/yaldEJLK8j1E0xrdz/FtZniunAg6/uOQre?=
 =?us-ascii?Q?86Ai12kkmeq+VJdAivaB3sHiXJkxu8LZ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 18:23:39.1654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa8b5aa-c8c4-448d-fc7a-08dcb18de65b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326

On Wed, Jul 31, 2024 at 07:50:53AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Tuesday, July 30, 2024 4:06 AM
> >
> > On Mon, Jul 29, 2024 at 03:24:46PM -0300, Jason Gunthorpe wrote:
> > > On Sun, Jul 28, 2024 at 04:51:06PM -0700, Nicolin Chen wrote:
> > > > IOMMU_RESV_SW_MSI is a unique region defined by an IOMMU driver.
> > Though it
> > > > is eventually used by a device for address translation to an MSI location
> > > > (including nested cases), practically it is a universal region across all
> > > > domains allocated for the IOMMU that defines it.
> > > >
> > > > Currently IOMMUFD core fetches and reserves the region during an
> > attach to
> > > > an hwpt_paging. It works with a hwpt_paging-only case, but might not
> > work
> > > > with a nested case where a device could directly attach to a hwpt_nested,
> > > > bypassing the hwpt_paging attachment.
> > >
> > > Well, it does this because the attach is the only place where we have
> > > *all* the devices available.
> > >
> > > Doing it doing allocation means you get only one device.
> > >
> > > So, I'd imagine more like we allocate the MSI region during allocation
> > > for the device specific during allocation
> > >
> > > But continue to enforce that every attached device also has its MSI
> > > region allocated.. Which probably just means checking that the
> > > driver's reported MSI address is the same as the address during
> > > allocation?
> >
> > The idea here is to treat IOMMU_RESV_SW_MSI as a per-IOMMU thing
> > v.s. a per-device thing, because it's defined by SW for an IOMMU
> > that doesn't have a HW MSI window. In another word, devices don't
> > really matter, so long as we know which IOMMU that can be decided
> > by any "one device".
> >
> 
> The problem is that the entire reserved region interface in IOMMU is
> per-device, leaving the room that though IOMMU_RESV_SW_MSI
> is per-IOMMU on existing platforms there might be a new
> implementation future with per-device difference.
>
> Then we'll have trouble in the callers which assume a specific type
> is per-IOMMU.
 
Looking at the existing cases, we are fine. But yes, I agree it
would potentially break if an IOMMU defines an IOMMU_RESV_SW_MSI
for one device not for another, i.e. one device has MSI behind
the IOMMU while another one doesn't.

> If we really want to go this route I wonder whether a per-IOMMU
> get_resv_regions() API should first exist then there is a clear definition
> what types are per-IOMMU and what are not.

Probably it'd be necessary.

Thanks
Nic
