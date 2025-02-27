Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0E419C57C
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 16:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673605; cv=fail; b=hkjDx75ROYPgzfNn7hHkuaj326BK2pvTvgMDHz2gAhl8an3hIdtW8d//g0Ck0w6rMJxc/dchONNKcN7MUFogLxjogp9ynEMn/sXQzVD+ivICDB51mka96sNTgtLsTds6GM03Yjl9L8SfhdNY8pxx4NoFlyITLk7Vzjccfs5KxSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673605; c=relaxed/simple;
	bh=czdbHpJ7e+HZKImPH/4gC07UVpwtdEsQUmecxf/huPk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGxCQtBnA0uMOjd0fFVdNo3qPW6JjXRWbuJ+sqy0HqGP1MJH6mBw5QA6dmShf0hF6OM0j0kWiNCjJmRAnGmYO4quPNonHI6wvBKnwEZUMKkPsbal2wPypzeSCh6UrVotFjTq54k0z2L83NUlPtyUpMavE/kj2BUMtD6lxgUBH10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CxWUr8eM; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CxWUr8eM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zb+9ysUTr/0lMt9CZx9cvBg9t0qlKzQqWd+gjWTHqgYc3MjXQ4ZEHmsFpHTYuPbp6+nediY7755cGl2Hu6Zj14dD21F9k1F+ESPSatBYYCJ5K/knA9079Tnpkx0xwoU4BbMme5IijSS0ulBHDEY/08+3nOS/Ojzel7jq0lHMGB38w5cOAm1diQX6qHKPh5hFAaSW7mIe256obENSXdJsQOm4IJjE0tr9p7tsvq+ez2XVP+l/Ct3I6yERYVrCgB2YvBLI00gAjuPZ8CY/B+Ft4Z7Bx+J47cuRsdioq3iZ/IBLopu/u06MxiojG/mPtciCEp+CGoFhaCLR9W80qA672w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4IEWp23gB8aREjamd4DTnF7xGtzK4nih2FXOMqLoYQ=;
 b=V+q9WTDM99nLzu9VAaGPmxDZm+bu7nTqSkQ6jpsGkr6kMHhG8Zgk1hrXzKQ0ocAghZ8N2mFZ4Muw9VJWRMhpa1F5Dzltr/S7bDCHSt/OmBnICz1Vbb8enRbB44+Irmy2a0CiXm7zyMMWzoXdsLl0vZsyNPO2+gZvVoqkAxK/xmSS4QcwpSWRcwuja52st3INax1SHbsgKlByCd+zRmk1n/LL8kbg/+jgSQ9LBfJMe65+Zt0i/4xTMNufUjosLCHDtfTTKx4+0pHO2LbAEsXD/D0WieO3Q/gzqRxFyIxdIDEgBNHyWSZcr1eYEZszURXRLUftuR8rhIajZ4nQ6bMSRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4IEWp23gB8aREjamd4DTnF7xGtzK4nih2FXOMqLoYQ=;
 b=CxWUr8eMbE10jynMHH5J8EyT1Y86LAIxsDUKHeB6r3fyqW7JD/mX1riMY8dXIHHgv2Z4jFZEOgvCuApqQAlx1AChPWX+KU3AXkQCeF03yna97n7C46RXM+6X+ysjoVWRnq9FnJSC53cklS3XHByRhx8QaDP9/9AGNCGxB39exh+Thy0MvUMX+FWFqNfnOG8Zsvgwje4vBaBJnLzkx4yZQzrpBTBItQ8iZCw+WNi7cAwJCsDcw3P0jAC3+YoWdu/PcJPn4QC+fpSdybIXK3k4uNtFa33wd8u48vxNioLuJWhI0xLsTR2s79LY4gpGauhO5OoPJswKEck925b3SvxrRg==
Received: from MW4PR03CA0179.namprd03.prod.outlook.com (2603:10b6:303:8d::34)
 by DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 16:26:38 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::c3) by MW4PR03CA0179.outlook.office365.com
 (2603:10b6:303:8d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Thu,
 27 Feb 2025 16:26:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 16:26:38 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Feb
 2025 08:26:18 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 27 Feb
 2025 08:26:18 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 27 Feb 2025 08:26:17 -0800
Date: Thu, 27 Feb 2025 08:26:16 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v8 01/12] iommu: Add iommu_attach_device_pasid_handle()
Message-ID: <Z8CSKOpsl0eDh9sC@Asurada-Nvidia>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-2-yi.l.liu@intel.com>
 <Z7+SrQFXdheJQzuK@Asurada-Nvidia>
 <db3df4f2-445a-49e5-9362-70cdaf363420@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <db3df4f2-445a-49e5-9362-70cdaf363420@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|DS0PR12MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: dc813975-0695-485e-cf2b-08dd574b82d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZQnakkBvr987LiuLhOizz2jZji8wTLxpkH/tWL6Ztas8nUWgF90T98yshn5/?=
 =?us-ascii?Q?8eKxOYP4gPUyhIZXAZAwGspTzMuIdfoWPuyelS6U4gEdZVK+Wj2fwaPTtw6x?=
 =?us-ascii?Q?/6YmJx8f+6wK2qycqivEBnzRbomGiO6INgBjRZt5zoA5AF6zkYrXWvo3mpsy?=
 =?us-ascii?Q?1EiUgU0ZBbofGi2llquQNDXTLNRSc0/ignJwYUfYeoFxJpm+KOEj0mV5zbGV?=
 =?us-ascii?Q?/LixYVB+0spVE8gjH3n+/D+FiI8kd32OQBro7QgVcz+2cYFSVypsf9p61lmf?=
 =?us-ascii?Q?3AuzEGHS12IFaCLdFG3ZKIAbdaX99EdrheJHJjDLIL1wuCmBYAnG2TjGPm8Q?=
 =?us-ascii?Q?HeT8l4nJqr03dbbeOEt4zz5nPwTUxMjs1UcSd9cHE3rCESvGaopoMyYOPJh8?=
 =?us-ascii?Q?1dasdw4YSE4cZgdUbEjsBbfbd6HxoHVPj7y0KPGDVwPPNy48poifwsrqFM4z?=
 =?us-ascii?Q?A2udo0nfe2TeAyGxPnx2MtOvN9fiwtpaBJ0qukSudRHhkmkq1o1t0GYsyTXv?=
 =?us-ascii?Q?zh9cT4x9dZyiJrRQjUGPSC7WN2iWWxnGQinxoAj3sdPr/G15MIUzOwpAZJ72?=
 =?us-ascii?Q?rdN7Kefe8anfiXo9e3fpHCd4MTDES+dxO6zNFEoNamK+cL/EzP82gtR10p4x?=
 =?us-ascii?Q?swRr049GrfSvydIMyVIcvEo6mzZL+7cxHzbFiPoGIOFfl4RJetv2rwbnwtup?=
 =?us-ascii?Q?ON9sE/HlJftSq0uqPIUUX61NtpbbP2mVRD8d+u7/0+WVr4jlbjeoUx99HxH7?=
 =?us-ascii?Q?hGTVPfU+l8dbaxoM5YMcwo2VS8mNRlGxeHVFYjf3tQsRJ47Mk6Yu9K9ymgQ8?=
 =?us-ascii?Q?YLH3zgtDxNFgdBGs1dEZ7gwiSDNDXFsdB8ZH8lIHRL7Ejy0d8Etj7QxDqVTE?=
 =?us-ascii?Q?Iwq/WB2f4e/T6dDW1trkG+ifaH7SfHrZDifczYiXCI8lkOq+HxtjXnwrO+d0?=
 =?us-ascii?Q?LQsm6zZ8vyLrF+aNTL3tHq7Ay4/zsTZRb1pSWPh2LitD0p4J8lpmehChC9j7?=
 =?us-ascii?Q?7Ybv7wNoPME3bX9Yy8/T2KcHmrjDCUM1jJr6102KZUOXtvaYgMh7WK0wkmFT?=
 =?us-ascii?Q?KLjg45knr9Mgy+EZcguQMKWhjKm1tgbQ4QG4Jl10/st2Ro0u3V9Ej9oe1vfy?=
 =?us-ascii?Q?60GFtgcqA02ny6xa2QHnsW2AAemQuMppam2GYm4UeARZp94BWm9ludXqLUTc?=
 =?us-ascii?Q?i3e5ZCHZ84qtb75VaKTRcvGBo2vRxAUz1T6zirmzUtqFWRGtRaZiAmryu8hr?=
 =?us-ascii?Q?O4614eDMKo8NSbZenk1hkfpGp3H56n7t9WOPElcDgY07RuJBQ6vBFh3zOVcs?=
 =?us-ascii?Q?G/rbmWWyoFR8SHpQPYkrsccNYR09GHC1SnxA6MrR9TWlTd5jK37yO3/ko+4Q?=
 =?us-ascii?Q?ADfDunl8ILvPx0/pXILXnl0S9j2H2W82dj5J0Y4+PMj0Zg0DPl4Aqa5zi7kW?=
 =?us-ascii?Q?5sn0IgCF7gp4zAsSApAl3A0zxVxzFBemCMqtdWfulgk9zRh+oFyMusuuqHJ0?=
 =?us-ascii?Q?l0oxB0nEX3Sqvhs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:26:38.3998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc813975-0695-485e-cf2b-08dd574b82d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8245

On Thu, Feb 27, 2025 at 09:27:12AM +0800, Yi Liu wrote:
> On 2025/2/27 06:16, Nicolin Chen wrote:
> > On Wed, Feb 26, 2025 at 03:40:21AM -0800, Yi Liu wrote:
> > > The existing iommu_attach_device_pasid() function allows both a valid
> > > handle and a NULL handle, which is not consistent with the RID path where
> > > iommu_attach_group() and iommu_attach_group_handle() coexist. To refine
> > > it, this adds iommu_attach_device_pasid_handle() to cover the case with
> > > valid handle, while let the iommu_attach_device_pasid() only deals with
> > > the case with NULL handle.
> > 
> > Hmm, I am not very sure about the necessity of this change. The
> > underlying function being called from those two helpers (with/
> > without handle) is still taking a NULL handle, which looks very
> > straightforward to me already, so this extra layer feels a bit
> > redundant..
> 
> I think I should have added a if (!handle) check in the beginning of
> iommu_attach_device_pasid_handle() just like the other _handle() APIs.
> If so, this should be clearer. is it?

My point is that the extra layer of these two helpers really do
nothing but be two wrappers around the exact same function with
just different "handle" inputs which only introduces some extra
complicity to the core code, not to mention that the underlying
function __iommu_attach_device_pasid is even in the header :-/

So, overall it doesn't feel very necessary to me...

The iommu_attach_group/iommu_attach_group_handle() case, on the
other hand, does take care of some underlying difference. Thus,
having two separate functions could make things clear.

Thanks
Nic
