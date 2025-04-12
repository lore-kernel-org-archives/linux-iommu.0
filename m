Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0731FDD
	for <iommu@lists.linux.dev>; Sat, 12 Apr 2025 00:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744416438; cv=fail; b=FhFZv1ArYA30DZxYX6Cp7uolCOlWjOa+8OTmQIbR8Uty86tVhQVGPz4Iw3tZnDU0VOrmAXDv5f/1WQtuuww4dsnyD6dZaSD3W22SzrGBUln3bfpKAbQWkaTKwnW2XkThUmKOfS1VZk+EFP57WYb15rDzFU8X8OxoY87pqHUQURo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744416438; c=relaxed/simple;
	bh=oUtT0YV56UwBzKkkDdSjo4wQLAxspa3xWUXHLmIwtKg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5ifEv47tGTMKvZxnIStcwh4FPp/s/HSsGiABbot5KDDze8TNAE7mnEGrC4BAQA6gKDnqYwnHTxKWi+YCjoWemn4G1dq6w9teQx7nGZ2Nc1dbPpDicH5YDT8Pl7onL6/aSuABE0dQWTpIHRSNE90bJEjAfJDOSn75uU22ooz5NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IC13N/l6; arc=fail smtp.client-ip=40.107.96.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IC13N/l6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhRp85pOW1Blo6wfFT7kwBME/sCAdhrsaOd1P6Ek1ES5jDdh2DDPLLQ2uelQxSnBn5Xw5oc0KynbIbpUir/EtoOVk9GlINqA3USaxkDc5apnSUbikVfpWZuwTx/aJoqnoskBacCKeZU3k0LM9edyA6Facc1HILDMOQXVrUt5+tP0jwa10/Qig4NWCA/YZ6wqARQ39OvyarwHAKYxKEL3MDwWhsyf85ulQE1aPJ63tvpxgSukbTgPA7wiI86uXGvObzKF4mIphiGHChwIHzmm3OJS+Pv9w3OBofAZXckL6DSGhY2PWT79EyK1rbxpNtAoZ5fRXwPbO83nGSjT6Zontw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWyxd8gfpz0AV9PMS9YG/QYmu3jTOva7itur88xgFZc=;
 b=gVi8wsXPmmtcFChBr0sd7E+E4xzKYOaOTeMRV3LfNZZVEyOMijAtkk2CEH4WZ73pLhIwFOo5R6gPXTNARu2rqGI4mElHg36rmHAe+qSNt8VLHvOCxTVnIiFMa8jCzJg7FFpTYILfyYLJPUnLKH2gi49d7Zyoix0Vop/bQdshDO+vWIk5RxVGrqlmptJjiz2yExKixGB9sCcMZZOL89Rd2zmpUMa5jzeQMC4sgVT1LjvSOiazRNjpSB/FhAyFWYY0WU5P0k56a59+W5wmsrJNgOLGODvFHLP4eg5MgNrXR24BnrQpXjgcwaQ2TZtVe3Mrv+q6xy2RL1AVa/xm91k4Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWyxd8gfpz0AV9PMS9YG/QYmu3jTOva7itur88xgFZc=;
 b=IC13N/l6+ej3fxWwrHKSTkgKZood8L4SFTfkn4YTMJlJMR7nKJIzQwiLfzaOT1ezAis64NHmnvhBJoOF6IU+cJXDiRGZWHjcPdSxB5DSM3iVr3WR+EhfJ+MV/CBQwD+sL583mru79nPas8JgWwXNsHA9m1Dx/i8Xw+RdZFlWtlvB9DvRyYH1UD7tOXHidV0Fgur2Kii8FnZlrKB3tGMVommIf3MB4H1MWBV52+DfT2twHHpHR/EDY+8qn077DxMpqYZI6V98qPNWn8MgMkYu8HqGwFk2smwhTuB8rCguXoA76Rf5W2gtDunX1ZUijxQSfVW8C/b4+xHu00WLVdzwdw==
Received: from BY1P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::10)
 by SJ2PR12MB9192.namprd12.prod.outlook.com (2603:10b6:a03:55d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Sat, 12 Apr
 2025 00:07:13 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::2c) by BY1P220CA0003.outlook.office365.com
 (2603:10b6:a03:59d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.30 via Frontend Transport; Sat,
 12 Apr 2025 00:07:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sat, 12 Apr 2025 00:07:12 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 11 Apr
 2025 17:07:03 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 11 Apr
 2025 17:07:03 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 11 Apr 2025 17:07:02 -0700
Date: Fri, 11 Apr 2025 17:07:00 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Robin Murphy <robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<jsnitsel@redhat.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Allow stream table to have nodes with
 the same ID
Message-ID: <Z/mupP6m0gRbeYtg@Asurada-Nvidia>
References: <20250411044706.356395-1-nicolinc@nvidia.com>
 <5c8d16f9-246e-45d0-aaac-45b7712cefb5@arm.com>
 <Z/mm2EQAQtOqpVCy@Asurada-Nvidia>
 <20250411234419.GC252886@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250411234419.GC252886@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|SJ2PR12MB9192:EE_
X-MS-Office365-Filtering-Correlation-Id: e1545979-8db3-43f0-0c5a-08dd7955f9c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/6aggSSesGO1KQ2hUABeppOJ80BBr8H+pwxqQQIhQPKR1Bwx8J1j5to9+jvX?=
 =?us-ascii?Q?NlGwYnvBir+hm1JevJI8saFZCmjJs/BrCXk7WRbSpCiq5ldZvHi2MAjJAhWC?=
 =?us-ascii?Q?CklzHq1y4RprDpPp5kIQsvetuPK0qQdMSpny6h0rylpE9GPwaeeYDCwKhizY?=
 =?us-ascii?Q?G2M1I7fmyXf5sjemfOJrIfuNKRyO+h6mlJriyZlVw8RnE8n65drlwewJhkhJ?=
 =?us-ascii?Q?uC59jNxq1YjWm090iq1TdRcloojzpBLGlVNiP1Zon5fXa1hjmnXEZzTrtmM0?=
 =?us-ascii?Q?n7s5cYYfBf5+wja6Mcwu3QluNbgopuf7luur81EvSDLWIxw9szAqnC0loa29?=
 =?us-ascii?Q?i1puBpGnSSIfof/mi5DFPBCZAd52BXZ82qqy7cbdEY33dfUB842NIvrrf/zo?=
 =?us-ascii?Q?InRz34KVhjPPRposJIVa31tWQ+umOsD1dfAJFWC9FAmxuwFgHbFdtiU01gVH?=
 =?us-ascii?Q?OLT2FZJS9b9KLtY3DxRjs5NYvLRcM8BvVF1BoM/lfbJlpssZyGeKLcPEYSjs?=
 =?us-ascii?Q?/FzXVi6xM54gQKgMI3hh7JGaYBYta4END2gW0f6A08JTkj5WTxtaFiDNx4jM?=
 =?us-ascii?Q?oYnzbst/8ds9cs0k9y4xVQHiodb7c9JKRNTSDjpa5qnl2aZMaWl3azFASyrO?=
 =?us-ascii?Q?dyqY64zCa+1DiUDFrIIWBoQU+maCh8Ptp3o7bNapEvbfsDSdOQdwQVCgO54d?=
 =?us-ascii?Q?SKCxo03moP0NUg6XKwbRsPgBZ/b2lMOsC0f8iObbwcus2/jx5zAjVmo8REaY?=
 =?us-ascii?Q?oGn0Alrz/pdgqHqlOxlhfKuaN4hwgaa72P4r4+Yfp4rWFjox764t7lLrEv/G?=
 =?us-ascii?Q?5MQKX/We5ts+seMuKKUhcFic/YsuCRba8nuUgMuuritwVmy2kwLzhojD4yg8?=
 =?us-ascii?Q?WLb9j4LGIFTS9HyC12ZRJIUHlFwkAQApJIDjC95nw2EQ2oCfU/FTi6KEdLmh?=
 =?us-ascii?Q?8XU0PEBosMHCo4mGXM9G06pgFA5hslGaz2QHT6CkzWaocgFcktdjGet40YHL?=
 =?us-ascii?Q?Li5Txbxv7bNRvFMBMtBAxBMhxBhmbmfU62RYOzI8i2WYuDeIcOl7eGsBQlo4?=
 =?us-ascii?Q?EC8LnpP3p0NPuhYKeLI6EqZwfMMN7Zuv8/ODTAF6zQF9jL0QrDvUvQoFbOwn?=
 =?us-ascii?Q?1wqHhclB4C+uTXq9EcwC1k1YQRhaQS1l3BC2mGMv/wjL4VrTc6pPHPQWLsM7?=
 =?us-ascii?Q?uLW+2WzwTQZ9cNac2gbwp4IFbdH0b6ZpP0gUcIRqWiE2Vqm1QK1rcjvIpAq1?=
 =?us-ascii?Q?o2opNOmY6OPfL54hVcd8YmzW6N8JkN1ghXxbP08H9TEFYSuvJrs7Ney1knaT?=
 =?us-ascii?Q?l+XuEzarDsbo9YXWOkv8o5UUrml8LjEjq4b9wf+Bvw7ugGaz2QeZPlzrefoU?=
 =?us-ascii?Q?zwIJ6Ext0lizvJT5O5+sQ/U8cq+jZtdm6kPj/jX19eSxqfStgGC5raS3Ypah?=
 =?us-ascii?Q?PuPk0WsxpMHbv3J7D5effPHR5/0VvTu0uby1ddjTBwyTWGPmQ/KpCgZViwq0?=
 =?us-ascii?Q?Ja3Of/APJXJ+ydlqMi0bhVVYfL29LWsSGg/y?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2025 00:07:12.4406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1545979-8db3-43f0-0c5a-08dd7955f9c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9192

On Fri, Apr 11, 2025 at 08:44:19PM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 11, 2025 at 04:33:44PM -0700, Nicolin Chen wrote:
> 
> > > The bridge *does* claim its own RID, and per the aliasing rules the
> > > devices behind it claim both their own RID and the alias to function
> > > 00.0 on the bridge's secondary bus, like so in action:
> > 
> > Yea, I just found out that the bridge does have a different SID.
> > It was actually the VGA controller itself having two fwspec->ids
> > populated by the IORT code. Then, the SMMU driver allocated two
> > separate streams with the same set of device pointer and SID:
> >   pci 0008:06:00.0: arm_smmu_insert_master: fwspec index=0, sid=0x10600
> >   pci 0008:06:00.0: Adding to iommu group 21
> >   pci 0008:07:00.0: arm_smmu_insert_master: fwspec index=0, sid=0x10700
> >   pci 0008:07:00.0: arm_smmu_insert_master: fwspec index=1, sid=0x10700
> >   pci 0008:07:00.0: Adding to iommu group 21
> > 
> > Perhaps the duplicated fwspec->id should be avoided in the IORT
> > code at the first place v.s. bypassing the fwspec->ids[1]?
> 
> It is a much easier fix if all you have to do is ignore hits in the RB
> tree that match to the same master, just don't fail on duplicates and
> don't add the duplicate rb node at all?
>
> Seem strange though. Where did the duplicate come from?

iort_iommu_configure_id
 |=> pci_for_each_dma_alias
      |=> iort_pci_iommu_init
      |    |=> iort_iommu_xlate
      |         |=> acpi_iommu_fwspec_init
      |              |=> iommu_fwspec_add_id(sid=0x10700) //index=0
      |=> iort_pci_iommu_init
           |=> iort_iommu_xlate
                |=> acpi_iommu_fwspec_init
                     |=> iommu_fwspec_add_id(sid=0x10700) //index=1

We could add a piece of code in iommu_fwspec_add_ids() rejecting
a duplicated ID, which would be smaller than we do in SMMU driver
that requires a device_group change too?

Thanks
Nicolin
