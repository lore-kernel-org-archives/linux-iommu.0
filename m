Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1C51AB6FF
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764433; cv=fail; b=ODtaaWS4DLcJS5jOS9h1Qn/8PYKPn6p05bIXPHaHkfb+qSlxpgCnbeB2CvBk0Dhy2vrtvXZFDMjit3BgpQjnRAQn1yLhZohviPj6fcKfj2gdvF/KcIba+WoTsseNf9vkWhPCKEL/N8XjYdlZVG2yaoj8v0ABcRdl4CnNWOZGIz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764433; c=relaxed/simple;
	bh=6WeVsEV0zyI7zBCGy7+IcrbFfD3SKR+f5c4OrMKvjOA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7NQhOsr56booLNQkM8NuyV/ESqEGNf+QAtE5xXq2v8SzlwnWewiasCNI+mMhOtOGAYlfReBkDEjpxEtqLpvqHQLmyEhWQPPH9NiNKXAHpU44kPJHvtNuqXT/uxv3y9xi/e2PGu6kbOrb9aoSOd0YpO2kfVaHIq5ah/S5kWVBhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KmCYfyP9; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KmCYfyP9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOd9cOqUi/7XRYP7eIOvIHmCvtCZfBBi+D+84aTUXabfG1D2/rIihpJ+h+865GC+L2wIU7xkhKL37RiZqQ6Gne97L9GjVVGeh3kRpvEesV85VMUXvuQgxaqyiTDXQ0EcDI9cPuc7Icc4IJYkVwFjQKs3dKbDgeZJYPWuRFrggzVg4XZNUKi2D4Gv3U5M1+M/oUrcGBpKy8RtXa2Lq2Wz0zjh1myn6Wn7P6H+e+ea+vVlCC/0jPn8q9xz+ZUWCBK+xq3QD6eeQ4YUP9E9MDJuNCaB9ISx70+zfAWIU7sDLMK6wlInCSl5W88DrBK8qOy9IDGgoDevH5+4NtYCH0hTmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5F52vcnvpraY2IaGMdXhwyhWZjk9ojqfGFSpuTUf5Y=;
 b=sFnmpCfck8NgeFgfnzMrlJWU6K851ajrh2BCvDTNyMhGpJW2M5i7x+K+b5dYpKDoe3AM8hOkiPB/3ejAc7Mohj1YG8wxHFt/+/46l2aY/VPStu+pvqoT8NwLl8MPL9dZauCsjcrmdmSdy26LM5SEpltSr+no2T2KebDePXvyNY29yiOHxSFFh2n2STsh298r3y5Xv5msrte8p+OXk2oXT/yn9Gy4jfEC+WupbKTdvEispwOHiLu+KnPF+cy8K3I+HhDBv40SFUBYsGa2YZLl/5opMWeQocMOH52IqIxpYmRVpwE8zBhfK3krHVVOjn9TW7rZNS2W1QYYXXtg/hDlOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5F52vcnvpraY2IaGMdXhwyhWZjk9ojqfGFSpuTUf5Y=;
 b=KmCYfyP9zawXRPnkGSHyBu10sHkIaGH34WxPdycpyYfxY+Mg3gSxkpua1J834kLlTek3cJ2HSp1W8fgPHJInoRYiMeuRTQEEUGmpjoDutEaRcSt8sLfCGxgVOakzpptwrJACzm9PJpcfwNFIQPD5lZ8HbdsgDXtvEMEwbWNwr41Tdw1D0p25GK4gfMf0YGxw1B/5aNhWBkVe9N6efGcouYi4k4B9nkL0bb3Dw/jUsPgrTfIzLMrFMJHqSdWKAzPJ/cXnxO017VZ55cYyKtiK3Q/NrWw+NwrzVrZ3rTPJPY0L8ywJ1RmY8tkjyWkRxrWVnt7magGW2ayBkFxJK3PW1w==
Received: from BLAPR05CA0017.namprd05.prod.outlook.com (2603:10b6:208:36e::29)
 by DS0PR12MB9322.namprd12.prod.outlook.com (2603:10b6:8:1bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 17:40:28 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::6e) by BLAPR05CA0017.outlook.office365.com
 (2603:10b6:208:36e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.10 via Frontend Transport; Fri,
 28 Feb 2025 17:40:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 17:40:26 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 28 Feb
 2025 09:40:08 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 28 Feb
 2025 09:40:08 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 28 Feb 2025 09:40:07 -0800
Date: Fri, 28 Feb 2025 09:40:06 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
	<will@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] iommu: Add private_data_owner to iommu_domain
Message-ID: <Z8H09l8PzqfGjC8s@Asurada-Nvidia>
References: <cover.1740705776.git.nicolinc@nvidia.com>
 <45c03a1bc86528c9194589cc3a5afe3eb2a15c9e.1740705776.git.nicolinc@nvidia.com>
 <2754908e-f345-43ca-9cb1-9300abe5d402@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2754908e-f345-43ca-9cb1-9300abe5d402@arm.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|DS0PR12MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: 37b58797-e0af-4089-0fcd-08dd581efcc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u4jcGZBIzD5eZ5aBfVjSC1aNM3pmKQgHPauONaYx4BBN1+K482VC9CUIl/Ig?=
 =?us-ascii?Q?LBCwAkpGNE3LUJTANdmhnFf2Co0segxq6o2nm4dqb6mjgStxtyCxZVtMZkSt?=
 =?us-ascii?Q?q8mO3QDiU1pd0UuvGEm6DUQKttfRjc3i7zfj+lPU3zUZr7rACxLBrIA80Wn+?=
 =?us-ascii?Q?mi7ojVPwvJijq6spZlDZwrQLnsBTeEG3jhYL93deyO1cIGcn+LYA/RGE6dEL?=
 =?us-ascii?Q?WMVVnsvU5wySfyQEH4ZBMjffHdk+TMxsMnu6Poiq2n8k5RBPUx6aYLseYdL7?=
 =?us-ascii?Q?pjNtWfyQDPVj4aT2yWRwRvGoFXwZQ4oa1RMBipf2NZjFYEnsLyXj1jsZxep1?=
 =?us-ascii?Q?a6CC3v9/67ViXJ3/FSgNXv38a9xFb4sPgkf6ZTw2ySI6FcrXtPbPfWfPnu9i?=
 =?us-ascii?Q?hyEZRcN5kstpIXFHzSi264E/SWGbW4M04cg1hVgUtkRPj1K66kgscWhiTm4x?=
 =?us-ascii?Q?in9F/39ufChh/EkvhJj9tjqvEjH649oXtRji7Haa+BkdN9CvFqVQ6SN03q4y?=
 =?us-ascii?Q?BqDn5Ww9npmQCc8cY2pr5u4kjOraEFVrvTeEwcV3NC9JvY3A4GW8TyYNG8dq?=
 =?us-ascii?Q?oXbNJgBemTXu4Dr8ePuO5i28dBL77cGir3J9it2mX8URoMsZzzMU2G5J4ALl?=
 =?us-ascii?Q?QMSzDwFV1oyF/WwHtXXj5HgSNMYNMMNlZuoWmheD62YlU89neE21PPCpLRII?=
 =?us-ascii?Q?QdJoGNdpkWLN5y26HqlpG2aRMTZ1kylJ6IoRW/JysxkySjA8AlAgTjNDruVd?=
 =?us-ascii?Q?FkJJ4y18TIQ/I96ITOf5KVu7r0W6OPxt6lI8HZP7KiXV0x5r9ADaZe5PxwDx?=
 =?us-ascii?Q?gaMAsgppHwS8UTJT6R5/q2gpRbzqUFg3PARPNpV3D0CSZrzdWui6F73wXaSv?=
 =?us-ascii?Q?q0QX2++tfDoIqELTUsQL68L/gMbgCZwBShJIiG6HnCVhM7R7nb343hTPmUV9?=
 =?us-ascii?Q?x6J55Tq42CFzrLUoXRHqFFP5rePGeTAwLVg4JxxnZRzQkwATpAFNpuIFxVzI?=
 =?us-ascii?Q?1A6QRRHD1YZbk2YcglT3MHt2LhSSS4zkUux4ylY4tqyGVb1P4WwyFDgbvd/j?=
 =?us-ascii?Q?+ijMk43+IY1P+uW2YjVb6VWrq7NYZMuGG61nYTRV8BHDnqf+dujAT7/scm65?=
 =?us-ascii?Q?uifCd+YqWE7N1W6EoYlYf6tvNxMBosss9WhwvT4GlT+QqpAXmCWlFV4p4xkx?=
 =?us-ascii?Q?o9LMSVdsy/uZlP6vdzC80NLAki6m3i2gDrqok/a6u8u1dQpQmnZdUo2v3jD1?=
 =?us-ascii?Q?jJSmJK98vA9R08XtncQRBN1SJkOUM++r+2YmYe5/5jX9kv8hVrc8O3Ci391x?=
 =?us-ascii?Q?otH/60WI8nx4pMRiCvFloYQoO7yRnLzPur04kJ35mvpZqnPyhnU9QePEHtKH?=
 =?us-ascii?Q?rLJZgBiEdNRqfkCyp10eEGbUjKQvxJfeGWTf4dEuT7rjFMr3hrE96ABb3aBi?=
 =?us-ascii?Q?pomCQ0JwRjTPyh7Uz9IutoKU3T5bx6p0hMdxvg+e3+Z0sfycKFAoLpXsyBtg?=
 =?us-ascii?Q?sfvg/aG+JOPICAU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 17:40:26.7286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b58797-e0af-4089-0fcd-08dd581efcc2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9322

On Fri, Feb 28, 2025 at 04:29:17PM +0000, Robin Murphy wrote:
> On 28/02/2025 1:31 am, Nicolin Chen wrote:
> > @@ -435,6 +436,7 @@ int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
> >   	cookie->msi_iova = base;
> >   	domain->iova_cookie = cookie;
> >   	iommu_domain_set_sw_msi(domain, iommu_dma_sw_msi);
> > +	domain->private_data_owner = IOMMU_DOMAIN_DATA_OWNER_DMA;
> 
> This doesn't help all that much when it can still be called on any old
> unmanaged domain and silently overwrite whatever the previous user thought
> they owned...

We could add another validation on top of this function to reject
private_data_owner != IOMMU_DOMAIN_DATA_OWNER_NONE?

> And really the "owner" of MSI cookies is VFIO, it just happens that all the
> code for them still lives in iommu-dma because it was written to piggyback
> off the same irqchip hooks. TBH I've long been keen on separating them
> further from "real" IOVA cookies, and generalising said hooks really removes
> any remaining reason to keep the implementations tied together at all,
> should they have cause to diverge further (e.g. with makign the MSI cookie
> window programmable). What I absolutely want to avoid is a notion of having
> two types of MSI-mapping cookies, one of which is two types of MSI-mapping
> cookies.
> 
> Hopefully that is all clear in the patch I proposed.

Yea, decoupling the MSI cookie from the iova_cookie makes sense
to me. I had the same feeling last week when I was preparing the
cleanup patch that added a iommu_put_msi_cookie(), but hesitated
after foreseeing a big rework that I was not sure you would like
or not. Glad that you did it..

With your patch now we even merged the two unions, which is nicer
from my point of view.

Thanks
Nicolin
