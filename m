Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C33D23B0
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 01:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729041342; cv=fail; b=Yt0T/wbTtuCOIiPjqTOLcvxtR6xcH3SAbgC8qW72htHqrlXsIoRczApG4BD5mqlbxgW8V2fSErp/9OB88xu9ohBfPMIkrvaVUw9dnjMy6Hx/mLuqPak54nNQpS9DpusBxrYMGh6hdbaA0lmDyfBnR2drUdA4F8fvSBx2r7JrVgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729041342; c=relaxed/simple;
	bh=51jEunZCHebvyiWlCqBosMgyf9G4BQwjUeHiAdf2mWk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeX6R8wPILn4siMZ9vubDJbRRjrneO3x6sIQfkI625L0AUZMdpG0Oykg6cfAwDVb5v0tNfSLJlwkGmX9QLJdZbPqaHJoDfEs1/1xWZsdmBX7i3g8N4ZLe/Cdk7e1X7HxXutbeZZ27oSCs6X6UQCkTFGkTUSATA8g9waO+OdlmRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WoAFB+aU; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WoAFB+aU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K61ms+k8QA1bq1/OAs14vz5uEDr7qtpRFxHIVZkScUT7ixLNZbB6DrZvqNITaaDswZK8e4C9hkVXpo/7ubofG/mrZeemGn2UGhQSZB0r08ewvTXcyzQnlvCYiIix3IDC7zUD2xwYjs31u9XQqoNm7KzbH+arDHY+4faSrxLAD0OJBqILzcwLvTI7Y/dHazDSSUr6nmFxSAYMthztR1hNpNntpoGaJ31hh2JJY1G8JWOPFo5W/tThZWKoEF2S+nSMBm2Xgvhpls/uQcZNybPV9fIQp9Bx0LHX3VmYp6itkOGah1BEyGa7B8Izf9QvzhfURsaNEZ0st73d2AMoE7DajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHab1wJQgGVxame0m+/0juJ00rtb5Orx7QPiYhGAp2g=;
 b=HR92J3S+nyGcsSW5YbsXjek7fIVH1aCf6DTOho/6dm1cr/Sab9k/y2q2JMklcEtu4sfqE9nDtpgkr8hJUWTRFoJgjsg2GDI/v4dOSCEELjrXLsbKYoVVQR6zKeAZTiR4RRWAnNP8NfmaHa3cm85Hh0FHUhfSIelcSYAWHHE0aq05ZK5N4HzGDinvm/msWO29joiMMNNDcREH5xatXWFLTR0FHZ8nul2gqUSxjXRZpdxbdm5U5OeyH51IVc08YVpIGaLVU0prfUz/b5k0hQySEscVV9zzK2yog6WJhfUO4xdUQb5IPnkBno+skkgQNHdILNeH4Kv3mW5pgVj0GPgyew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHab1wJQgGVxame0m+/0juJ00rtb5Orx7QPiYhGAp2g=;
 b=WoAFB+aUvm0dFUoKjhkYH4KlOa403YtUJEpaiZG5Fcea0YiIwpW7SAOY1KawMR6wzh101kQKHAPf2CFd8gflCZCRu1yQrEV91Jx3J2i75zpgHiUC/2zH6bU8BBIBXR0dLX1x6BzrOuwKqAROfn85ka+xBbkUVrn8MPsMaglcNO8Mee+QI5uS4HFgSXreUkNEXMVn7/8d9ywEgrCjjkYybh4+uLYjFaWxeTq+/NxcsD11SPbr5h6PX+Kyw+Vny0nWQZ+fM24q12ZUlyr8lk8cB0AzKzMP9sMAWV/APUD1i4YYCPrlyWfmZ8bpOmECyk4K2CHOIkb64iK7zREwF74aAw==
Received: from SJ0PR13CA0137.namprd13.prod.outlook.com (2603:10b6:a03:2c6::22)
 by DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Wed, 16 Oct
 2024 01:15:36 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::3f) by SJ0PR13CA0137.outlook.office365.com
 (2603:10b6:a03:2c6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Wed, 16 Oct 2024 01:15:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.1 via Frontend Transport; Wed, 16 Oct 2024 01:15:36 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 18:15:21 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 18:15:21 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 15 Oct 2024 18:15:20 -0700
Date: Tue, 15 Oct 2024 18:15:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Peng Fan <peng.fan@nxp.com>
CC: Robin Murphy <robin.murphy@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joy Zou
	<joy.zou@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH RFC 0/2] iommu/arm-smmu-v3: bypass streamid zero on i.MX95
Message-ID: <Zw8Tp4RuVgCdGcc8@Asurada-Nvidia>
References: <20241015-smmuv3-v1-0-e4b9ed1b5501@nxp.com>
 <a8c42a6c-bac3-4ebc-8a29-e6c0ed4567c3@arm.com>
 <PAXPR04MB8459AB654150BED2FB5FFDE188462@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8459AB654150BED2FB5FFDE188462@PAXPR04MB8459.eurprd04.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|DS0PR12MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a3178e9-ee2f-46bd-8d94-08dced800a39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z3E+aVbbMNOgjhPXneQW72YTL1a5XUlrsO1x/kP+Wu4C+l0tcKhc9ZCe2WYz?=
 =?us-ascii?Q?AfJPw3xxstXlMzAoOWq+405UVsNc66FHYG4WmLKyYmLokD5lzRfxxsJjnIZ4?=
 =?us-ascii?Q?cVv2JGyK1I8XBSS18BHBs+jOM4ISnY4N+nR8hGkTJopO87TD0x7RylLgsH5m?=
 =?us-ascii?Q?Ie4zxQvZ6sDM1xOFbx1gHQetCVA+vQgxPR1f2qhXOpC39vSSVJ9CdfIgBVF6?=
 =?us-ascii?Q?EkjohhlHgtXrgqS+f7XHrYazpHWM9jGeuOB3aZZJdMH9Uv8S+DkOnOIJNAPA?=
 =?us-ascii?Q?2CWDFsHHrs8r9BT0FfD/b46w+ajJ9PH8NP6wgsYsQZvGJ8VmHVdH3rD6I6Sq?=
 =?us-ascii?Q?hSMRHX8Bq2cGCCjSCgz72V/pIOwkAJeXlvvvJzgoYOGpem4ApHMc2ff6jFh2?=
 =?us-ascii?Q?7SsuYLTaLhMvkr6GzmNG/6K1WWeI0DlPx4eR6foRSx4kwx0MFPjshtn5838H?=
 =?us-ascii?Q?+cH2l5MbqtJGaNJCb+P8LIHVW+c2TPjgJPdnCeyVFOdpovArqZfDZOJaI9wl?=
 =?us-ascii?Q?7w2pbwIng6MZHx3q1Va+ubPG+XFmja9493qoby8kIOLZEXRlJH+pXfeWFuqk?=
 =?us-ascii?Q?YmR4ipd5ul6oM7dAOPVNSPttj1HrXpOulbutWTI/a3xGOiVRcrv9/OrISbLl?=
 =?us-ascii?Q?1myGIc6GSD9fCCh1aYE23N12Ai4rfOhUE7yJ9pfdhe360WLOjBFaPQT19caM?=
 =?us-ascii?Q?qgnb3NTKd5vh9H5gYLs/zDkNjX3iznL4egBm5dudAqSS/4D7pKIarOa0GSY2?=
 =?us-ascii?Q?8h11yF/eWW8YGaq+j7V1Ob7ySI+EEtkV91+6l0FznOEQnDNKUsSC70VRmERj?=
 =?us-ascii?Q?Uodzfzvai7yo9zKF6hbiAIDIZo+dFJaSfpUmDqOjIfOnUVm3y9EGCNdxnJ5a?=
 =?us-ascii?Q?6Lee+c1xChgdxNp96LxCsCp+SZ6bsTtZxsSCweL7eWUc2lYEr5YVwTYvuFNq?=
 =?us-ascii?Q?ZyyqCT4RvxACC0nDZkvUYGMUzotOlFTMTXCpIV8KYLcfHNRPsUu7oT4vOnjd?=
 =?us-ascii?Q?R3it4489C2VXl1e7IeLy1gEOumfp65+7oFfLXyN4vds4Q2mEklMcZnTa4ZQs?=
 =?us-ascii?Q?lHlxfKhcc3TK7pO1oCTytZQzTQeTi7+gN606sfxHCqowE50cFmNEILIIvpL3?=
 =?us-ascii?Q?VF9ihAwyU1uoISX6hZwgAm7k62Hpow1ImVsdqNR/roCVx3xnI5ztz2Co9q2c?=
 =?us-ascii?Q?YzsumivXGbN3dQQFvJMcQVsDLHXsaLRb1Xoph0QYdsB5hj0bL6gR/iCp2e4E?=
 =?us-ascii?Q?LFTGRqx7JYkh4TSdFHBPIyMxucGbuUn9uoE7mh5aw3xCXQ7LmkXsl5z2JgcH?=
 =?us-ascii?Q?wW2NRSsisiDChUPgbkfKzhtrTggBBcRG7pKFB8ib6ZbyjC4U5iGebzBL+x3a?=
 =?us-ascii?Q?e638A5aJh65rNRIelJhBIoo2i3Tj?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 01:15:36.1814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3178e9-ee2f-46bd-8d94-08dced800a39
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8442

On Wed, Oct 16, 2024 at 12:56:54AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH RFC 0/2] iommu/arm-smmu-v3: bypass streamid
> > zero on i.MX95
> >
> > On 2024-10-15 4:14 am, Peng Fan (OSS) wrote:
> > > i.MX95 eDMA3 connects to DSU ACP, supporting dma coherent
> > memory to
> > > memory operations. However TBU is in the path between eDMA3
> > and ACP,
> > > need to bypass the default SID 0 to make eDMA3 work properly.
> >
> > I'm confused, why not just describe that the device owns this StreamID
> > in the DT the normal way, i.e, "iommus = <&smmu 0>;"?
> 
> Current SMMU-v3 driver not support streamID sharing, but we have
> limited streamIDs(i.MX95 max supports 64 SIDs). However the eDMA
> supports 64 channels, each channel may have a SID, but not supported
> by current smmuv3 driver.
> 
> We see smmu would degrade the performance in somecases, so
> we wanna to give user an option to bypass SMMU for eDMA.

If it's a system-wise global need, adding "iommu.passthrough=y"
to the bootargs string should work for all trusted devices. And
particular group can be changed to the IDENTITY domain too upon
cmdline setting, e.g.
echo identity | sudo tee /sys/class/pci_bus/0009\:01/device/iommu_group/type

Thanks
Nicolin
