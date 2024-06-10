Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCAD5B1F8
	for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 20:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718049712; cv=fail; b=g0cndGu2Fh7Ze/sd+23cSep9WbC3eHCtcIuVPG1d32JPNbYTYvkGqDlV3wNV6i6DBXiOfw2Kc/rliEq1mR0ysEXsheKIhdhORiN/OwRESyrYzVVYWf23Wmbo59SvkPOXYmO3zcpgXr8jH29PMd2NzgeRQ6B4UcJXmj9SF+JmvA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718049712; c=relaxed/simple;
	bh=cgrqCE1hRpyZMKCrREnn+VBgfi9GQLNf8CV1YcH2QqE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDQAK8bDuW/RrHtGy/Puk/qYiUCCyo0KCKP3uzXo5tr0JhW/JfwXrIx29NkhCgoWWa1RO0ENotEVSRzMA6GIroCZB1IRwTPQzLdn3h7vYOAYZzRqxIXNe2fZpuLIzXhVSXXQkaW+Y0VqMHVk54TWkG2zfjwL3uictUgqB/tNCCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z6OzYr1J; arc=fail smtp.client-ip=40.107.96.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z6OzYr1J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9P842k+24aSt2VMNvM7OIgkqiUvBNfsPUyZTJjrMiFgjyZOa6e89zMhUcJuf9DJOY/lWWY4cL2RcMNunaI7Z9B4KwF7sLZlZTdvm0sGaFNd7qwFBssLhSssUG2zLYKk8THzcGLK+fr9UEQJkkrpQAcYeILTaYm4sJwu/Vnw9L1z4Rv1Pxw5Q+WB9WHiHLcTsATwGW+TY+0w7UoeEFYRJShDT6C8VHTA9lFeMkqJSoiO6nbXhp6PA5ggQh/jsQlifwki4eNKICDvOadBa5Nug08fHeuBv+8Pmg4i7pNrIv3RhbU2cHj2V5Re42NHy7jAb4zQNsae37yQVSj3WRbHQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNo6M+bLkkArXwO9bJ0IOYVUs4cnTlkVIrg87Ch7B8o=;
 b=WbDXHgui4mZM0gjhR+1sY1uzlB2TinI0kW85tH/+k0oGEkZQ3dz44Q4dNQxgGK3zxF1ARZsj/zupUkk/v2170hRTDKOuHRgwwUiTeZPau4EQmWJ1jKQS32pdjDOPqStLgpxP0puhNwc95gHkphA4P2J/dCOHxS6+U5iVtqrsfiByab5aac5FmbAItAIbr2xBrsgT/T2z0QXgd/xvZYmGSMFQ1A18OkUrtIkUtJ9uveiigcn0xxxzsj0a+ayQvp19yD19/G/nBgqIHNze347y4OnM6lOv6DYOxbVDg5rEpvBb/AYemhUKSrCZDRIN55deJQSdOkKk0UIDHHP7qTM+9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNo6M+bLkkArXwO9bJ0IOYVUs4cnTlkVIrg87Ch7B8o=;
 b=Z6OzYr1JEuZIWbv9cqzcFLNy9cf1bjzYLkTIqqtiluAtrwaqqjmyd5L8iNStpVzUof5xy+Pe+r1LLcQxD08neoX6qy8PkEa1jBSTP+VEtKEkzbRhkOVZlNK4keVlIy0cs73U9BkWabJBJyfgHhPZOvKrfsdj13CrS0G8wSSNdPSq3uFxl1sQk1CMABq/fO89YjWSyuLClVoxsWKUL1xLVxgqKPDI6QRGIoz32/FW16M+R+hakqxVKyA77kkloA8yzNLadZUBAeegYYFeyv6IHDOq9juIqHhmKHrKOkEuVaqB8hmS6kG2CKmb8sBlX/2NUVnLOUrWuTWWLvE0aLo6Qw==
Received: from SJ0PR13CA0004.namprd13.prod.outlook.com (2603:10b6:a03:2c0::9)
 by CH3PR12MB7665.namprd12.prod.outlook.com (2603:10b6:610:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 20:01:46 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::19) by SJ0PR13CA0004.outlook.office365.com
 (2603:10b6:a03:2c0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.16 via Frontend
 Transport; Mon, 10 Jun 2024 20:01:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 10 Jun 2024 20:01:45 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Jun
 2024 13:01:34 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 10 Jun 2024 13:01:34 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 10 Jun 2024 13:01:33 -0700
Date: Mon, 10 Jun 2024 13:01:32 -0700
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
Message-ID: <ZmdbnGnp73yR36N5@Asurada-Nvidia>
References: <ZlfPPwsnY6P4SoGF@Asurada-Nvidia>
 <ZluWXYQjroz0fqqn@nvidia.com>
 <Zl03rsgZl/msa3I+@nvidia.com>
 <20240606182423.GF19897@nvidia.com>
 <ZmIDqgfINXfB0i3L@Asurada-Nvidia>
 <20240607002707.GJ19897@nvidia.com>
 <BN9PR11MB527604637EC37B3B03FBBE468CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240607144917.GK19897@nvidia.com>
 <ZmN5WZkvDeIS7RRH@Asurada-Nvidia>
 <20240610120446.GP19897@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240610120446.GP19897@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|CH3PR12MB7665:EE_
X-MS-Office365-Filtering-Correlation-Id: 310c3c6c-050a-46bb-d30c-08dc898827f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|7416005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bPBJP+koOqYe+KXbcT4vKKR+u1vPSf5zlz5cUZLz805qWLuKsCrRjMntAdAp?=
 =?us-ascii?Q?eBP95XrrCFwbZQrnsI6QnITPUmX0/1O8FHDSA1z60T1yZgXFkBXUJtmbnCTW?=
 =?us-ascii?Q?O5zZZZttIx/D4oUQDvvHBRXF7x6Yh68nAIoVGMsIOqtbzLO3Z7AUVtZtzeVg?=
 =?us-ascii?Q?h9WU+fCJ6QS0MX6p0wSFqDVlzI6/FRSWIFQLl/Wo2h5iJk4t5P6NymKAaYjW?=
 =?us-ascii?Q?/tOlmVTv3rOIckIaRdaYWrZEjFt4m6prKCoVUs182uzRaCFIELfyo2Oj/Pwz?=
 =?us-ascii?Q?MtheVgR7zy4XuCgRNV9DPaRTGD5+E2rSQAxyowlyROVJ25YiRwczk/qifsiZ?=
 =?us-ascii?Q?WsEbR3k/DWfpENX0C5yCLCN6uyDVYAyrxRpdVJGaZvBjDZ0mvsdrCiSXfAse?=
 =?us-ascii?Q?vF1Pu5CBY+gtiXHKoH5SvXN6RmCUShpsq60DQ/VQt+VdvHnnuWsXO2vZO2Ht?=
 =?us-ascii?Q?wOf4IeLqz0iZalxIe9i5HXm04grvliLfgLyzqK/oi1U9JjXXruS6qwycJykf?=
 =?us-ascii?Q?wBTHmvueGJL5DTCzx3SL7QvA2/M7reseELzImPNaLZq0l4CHcIdH326VMV6C?=
 =?us-ascii?Q?xwn7bzjgZ4IetKjyqwPJdZEDVMcwTfmK2CfSaKrny004Fvor0Tik5wZdYtrg?=
 =?us-ascii?Q?OgySfYt3RhHPuOHszdnVC2oUFgCxXZV4btQnTUeLnY71xqieRLd5egGjShE7?=
 =?us-ascii?Q?BFaHxWsJEhVJdUXBBOGqQ4MiL2gMWKzBYoVpampvcUIHOE9rOS30Wpk/F0li?=
 =?us-ascii?Q?h+Na8Q77WM1rahe6ZZD7SIvRiDJ6XhXel1hpBGj3bW/tYgHZa+CD3/vWCzxO?=
 =?us-ascii?Q?zeL6dE+Ysp7EwjvycucmQvhqanC2fh+o5pfSRfacM94Eo0IgraPp2jAZdZrS?=
 =?us-ascii?Q?dXjYVmRFe2dbwhR10fJyVwIBlnzUJmJ41kNeKKEvQ9nPulHBHjetjxDLhMeT?=
 =?us-ascii?Q?b1+84DqfzRqxf5Q87z/5D2F0FyVVnWSc4ltSlRlvZFc468C1Qd98Oy+D6WqM?=
 =?us-ascii?Q?D+qTK78MASoNQt6A4fdPF+o0/PlYFlj9or2UNWb52FfeXxKvrRSESYGASPH6?=
 =?us-ascii?Q?joETzX4t7XGvjROxdgIxj/0lQ9cx2Q9zEYidS8veoZUFNwShor16EN0+ldo+?=
 =?us-ascii?Q?CIFhLU5sxI3CF526XLii9ItOU+6vlBjYEszL7eBlbw7kbZ3LvxWB0hoyPGM9?=
 =?us-ascii?Q?Ud15iV/r6Zy6rpTEN5RafyLGBbA4RxHz7rxcYR2vAsRomyPBdoKWfIpTsXZO?=
 =?us-ascii?Q?tyCgaVo9qEFDVT9M35jJAmJs40LnpFySgF3m928CSZfCrzHS/jNYRxvC1B+b?=
 =?us-ascii?Q?cSzsfDmI4FDgwHWOR0bWEPX6A9lQ+jOFejm+i4J/rQOpQqAw60dC2mNYWNsz?=
 =?us-ascii?Q?0e77ecYhq3pQayv35JlgVt1eKb+JsW9qMH8hkBWERCWOQQ7DkA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(7416005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 20:01:45.8696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 310c3c6c-050a-46bb-d30c-08dc898827f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7665

On Mon, Jun 10, 2024 at 09:04:46AM -0300, Jason Gunthorpe wrote:
> On Fri, Jun 07, 2024 at 02:19:21PM -0700, Nicolin Chen wrote:
> 
> > > IOTLB efficiency will suffer though when splitting 1p -> 2v while
> > > invalidation performance will suffer when joining 2p -> 1v.
> > 
> > I think the invalidation efficiency is actually solvable. So,
> > basically viommu_invalidate would receive a whole batch of cmds
> > and dispatch them to different pSMMUs (nested_domains/devices).
> > We already have a vdev_id table for devices, yet we just need a
> > new vasid table for nested_domains. Right?
> 
> You can't know the ASID usage of the hypervisor from the VM, unless
> you also inspect the CD table memory in the guest. That seems like
> something we should try hard to avoid.

Actually, even now as we put a dispatcher in VMM, VMM still does
decode the CD table to link ASID to s1_hwpt. Otherwise, it could
only broadcast a TLBI cmd to all pSMMUs.

Doing in the other way by moving it to the kernel, we'd just need
a pair of new ioctls and use them when VMM traps CFGI_CD cmds, so
kernel driver instead of VMM user driver manages the links between
ASIDs to nested domains. Either a master ASID or SVA ASIDs can be
linked to the same nested_domain that's allocated per vSTE.

> > With that being said, it would make the kernel design a bit more
> > complicated. And the VMM still has to separate the commands for
> > passthrough devices (HW iotlb) from commands for emulated devices
> > (emulated iotlb), unless we further split the topology at the VM
> > level to have a dedicated vSMMU for all passthrough devices --
> > then VMM could just forward its entire cmdq to the kernel without
> > deciphering every command (likely?).
> 
> I would not include the emulated devices in a shared SMMU.. For the
> same reason, we should try hard to avoid inspecting the page table
> memory.

I wouldn't like the idea of attaching emulated devices to a shared
vSMMU. Yet, mind elaborating why this would inspect the page table
memory? Or do you mean we should avoid VMM inspecting user tables?

> If a viommu is needed for emulated then virtio-iommu may be more
> appropriate..
> 
> That said I'm sure someone will want to do this, so as long as it is
> possible in the VMM, as slow as it may be, then it is fine.

Eric hasn't replied my previous query regarding how to design this,
yet I guess the same. And looks like Intel is doing so for emulated
devices, since there is only one intel_iommu instance in a VM.

Thanks
Nicolin
