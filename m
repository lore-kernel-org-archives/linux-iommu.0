Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEC12E3E0
	for <iommu@lists.linux.dev>; Mon, 13 May 2024 04:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715575175; cv=fail; b=gQjxZhwzYrTQDOucTVDnMOdvLh8Z5n2RyDXAyxKqQUKJAJ64CqI2NN5jR/gOc+g16PmP2zO76BV8CEnNFDjafdPjJ/H1jjWBA3q4z559guI5BTo3xWd76NDS922sxDI4gjh9YMZba9OUOAD/TbvvVFaYXBqqPihCoVfzxoi4Li8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715575175; c=relaxed/simple;
	bh=q6RmzsvwRxBHovmPuttZgjbOKL2ltpDhqjdGo9vquKU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tB3sWqvysMpX7c4bCZH+hLoIZN7gqAjVk9Q+y6PwykoyHmPn/Gq1omxM4GqMNBYElAJPGCvGeqXRu2qIFuaCROtE40fqKJoxwnSDhq+xuYygX5mH0tnTiD/bW3vwbBffn/qbztXPweGXz3IlXFwSJmFBkQNAmXRgXwTbY1YXThs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NS3mJxk7; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NS3mJxk7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N39CGn28mWNTCTEJDdhkVH1nCRwmr933DO0UwOdvTf53lKB/dx3vKy/vsLrTqte37TetnDyYgfIyzKI9uM4vs4ACho8CZon19vNOcsqo5xl7rrs2dFYx/1FC1c2DvGhZG1LfeiRWx5ZNv0ZqlZy1DVJcyzQkHhtqO49/tf2ldqHgibnW67J5wivMpSqX8+c7bQdjkMiBpplOi04IQG6QqCBEwTdQDxfPEDo+BTR9RUgbu4WwlezkrleTUNiy5ANUUz+x2ToLyiHhLdWzDYiLulgCdfWoj+E44jerpKS5Qo1M1qJDAGpRtmI3jDsMKK6lXCUcMWg2QjbjhSZxra8vrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ee5wORc9Rfw3/+7jf2NyRHKvp1jEZqXgjSyltmxJ7E0=;
 b=h+14C7fR/+Zn+miqaj5wjZodaxwbXSnTK3Jyxc7pH9ZRes6aS+pBWRhcAg8Xb1u271ioDZqLXbugtTWyxPMRK5v9ZIfKiQqR4olo1Dx/vxUcZLlDYJXIkV24sYfJrFVrtG2hUoWoDCbgx3oI8bw+Dlkd8N2JtzER/Kwt38Z9N8F7ceIcv/I2frY4Oddt2xTHN/266DQTpuE8fzpallkaop0uZnvr1/VcN+8Q/CchfmuDyV1M4dzbRbHaTR8ZFximervXxt7E2L0RD4gjc1qfj0+/bQMlzp6A0r8hVhfcmdX1+MF2u7J1dcyspTVJ84y6rKguxdz8ixPjlby/q5fCww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ee5wORc9Rfw3/+7jf2NyRHKvp1jEZqXgjSyltmxJ7E0=;
 b=NS3mJxk7JSGP3uKao17V/Y3nVV6stlB1LjZywTuOyRmbSDiUxW2uWsGmFCls6mgJr4e092JY8roi/PFIIXgyohneg6IWqQQsDfff/+ZKUV8z1ldsi3ywoZgTcN5J4i6Nt8vwwE98vlxhM/OsI3YZRuP+mXZl3LRFLlXkDO+WCYSboMIJKW7RYEtp98ZTzyXkSuKQaqHRTzrFju04kGSgr+Ea4wv9fsCVLSwBV8YIlmQL1Kja3wa1nwA7yIEQYNz/fdDWeh6HevNnKYVOWr+mw08axm6Kg+y5VgSoaWs/s/sIqHsSLma760cOOr0+pgXNbsROW78aYnzmC3axCBqKmg==
Received: from BYAPR01CA0070.prod.exchangelabs.com (2603:10b6:a03:94::47) by
 DS7PR12MB6192.namprd12.prod.outlook.com (2603:10b6:8:97::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Mon, 13 May 2024 04:39:31 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:94:cafe::10) by BYAPR01CA0070.outlook.office365.com
 (2603:10b6:a03:94::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.51 via Frontend
 Transport; Mon, 13 May 2024 04:39:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 04:39:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 21:39:22 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 21:39:21 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Sun, 12 May 2024 21:39:17 -0700
Date: Sun, 12 May 2024 21:39:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <kevin.tian@intel.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<yi.l.liu@intel.com>, <eric.auger@redhat.com>, <vasant.hegde@amd.com>,
	<jon.grimm@amd.com>, <santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 07/14] iommufd: Add viommu set/unset_dev_id ops
Message-ID: <ZkGZc5dvLigXcWib@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <6e57d7b5aa1705bdd547b1cd2aca93d3bf70dfa4.1712978212.git.nicolinc@nvidia.com>
 <ZkDWXnPW7CaX5TtA@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZkDWXnPW7CaX5TtA@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|DS7PR12MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a6b5f92-9ffc-4bc0-61e2-08dc7306ae6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400017|36860700004|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+zksWXrP+WDIYlBQWfE6uMCsxUTc7UGszpwvd8iQLMoDn57ng6lH7ttNIXCQ?=
 =?us-ascii?Q?dEjxKOY/aMGIaPR6nk7AVK8AjdSBU3Vtn1oxy+JcU+f/jVcylZhMXkC1tRrx?=
 =?us-ascii?Q?9YNG691ZZVXBZzcpWFe85R954JHjJGNDl5v2yHEzBBYhIzp+b9dUDJTvcZHM?=
 =?us-ascii?Q?U27Sf+I4Cf52LNtH+aujfTxqAKtflFR7F0r3vV5y9+LeXx1GxFuwppmkXwN/?=
 =?us-ascii?Q?7Udxk9o4U120vGRAtcAdJUmNLq/cDLyUbPYgQNPurj5M5l6J1iyR8+CstEA7?=
 =?us-ascii?Q?sr0vUJpn02DncyU5BMsZKJrW3ucF7sX/tUYLz7bwdXgCCEf1YwLRF0vpAyED?=
 =?us-ascii?Q?NLxTq+NMsKHNMKJSxT/K48UZrBxQH73CWppJatV7fJPxZHhqnYStrnZF0DxZ?=
 =?us-ascii?Q?ipZFulsHY1rHy+Mmi7WLQEUHw2ca5U505BTJIknlsrEbv6hFTUBMi1r/Rom7?=
 =?us-ascii?Q?Du55OS0+LXG/NS7DRwMP+I7UYN4eXGwntli3TJbMRyF9wNvg4Rg6yHleP46r?=
 =?us-ascii?Q?xrHpcjeMkq6rHutKMRiIl+pOGQ49B0OwneLaVC/hHWmEiS1isRFaeIEkNvEd?=
 =?us-ascii?Q?e8B7qU5o7ZJZT7onYcHqfcxOJTdWfJn5k/Yn2farV1/jHLEeBMWEb/HbJwwO?=
 =?us-ascii?Q?M/4kFZYoERKxKBLTVu2u5ZCuaElZRGw0FTRxA0ct6mjTbEO+JdX0Feavh+4I?=
 =?us-ascii?Q?G5AnHuEeoF+ZF45bFE57QMc97RsT7IoZ60a2Of8KRWn6vHMEyT5JOwWZ7/nK?=
 =?us-ascii?Q?fta78K7+gAIEUbO1bvIVl+MAgaciaXeNFP4xNd4jpw2Zf0wz8p9Op+tP6XJj?=
 =?us-ascii?Q?QWf/66WwxQoDpg95+WQeBHJLxCbToEmVeor0V0WbZhSdY44cSw+hFncS7jik?=
 =?us-ascii?Q?kCcsOA3M/JBewbDNxooXjmtcJDS4fxIVNxq8CXPdZFzDYogBoBkDWhpmHe86?=
 =?us-ascii?Q?QKANe5R6zpgJmWq4ALQBRFvo55kBzPfnpNwnogawy0VmyR8jrlxMfSyxC90F?=
 =?us-ascii?Q?1MWUo1fSyypVLFWHhnkSMmm8ARvxyG2S6xE9dTz0dIVuFNSjb+SiwPOCd7YE?=
 =?us-ascii?Q?navVa7JTHSRxvDB6li3adtL+nK7LVqbqxw72JIa9lHHgkNvwWqBWPRR+nJDv?=
 =?us-ascii?Q?709WHJRvs08++NY3fqrRnbVc7X3LQf6fPLEAjhVdHeHHttpAlgem71Utl7SD?=
 =?us-ascii?Q?vxrOvvC5RAPWinXZwuSNmh+us+FMhesY5AYl+JNRYNRvHccj9sOHdqE3nW9S?=
 =?us-ascii?Q?YG+XD+Uy+dev4z+pX667mWlavC4Xio9ZFfWy0w84u7knGtTu3SfUUnVCZItE?=
 =?us-ascii?Q?vImg3RRXJLk9SXNay0d2pazNjBQzvaAbUCXT8K+TErCGEtigttBkKdxZJP2v?=
 =?us-ascii?Q?1M0mO6euuNMngTEnQNkRvnauXUq6?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 04:39:31.1567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6b5f92-9ffc-4bc0-61e2-08dc7306ae6a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6192

On Sun, May 12, 2024 at 11:46:54AM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 12, 2024 at 08:47:04PM -0700, Nicolin Chen wrote:
> > Add a pair of ops to set and unet device's virtual ID that belongs to
> > a viommu object. They will be used, in the following patch, by iommufd
> > to support some HW-acceleration feature from the host level.
> > 
> > For instance, every device behind an ARM SMMU has a Stream ID. The ID
> > is used by ATC invalidation commands so SMMU HW can direct invalidation
> > requests to the corresponding PCI device where the ID belongs to. In a
> > virtualization use case, a passthroughed device in the VM will have a
> > virtuail Stream ID, used by the ATC invalidation commands in the guest
> > system. NVIDIA's CMDQV extension for SMMUv3 provides a v-interface to
> > execute the guest-level ATC invalidation commands directly, yet needs
> > the HW to be aware of its virtual Stream ID so it can replace with its
> > physical Stream ID.
> 
> I imagine using this as well for the ATC invalidation commands. It
> would be very easy and simplifying if the command fixup just extracted
> the vSID from the ATC invalidation and used an xarray to turn it into
> a pSID and then pushed the resulting command.

You mean the nested SMMU series right? Actually the set_dev_id
ioctl was a part of that until we wanted to try DEV_INVALIDATE.

So again, yes, it makes sense to me that we move viommu and the
set_dev_id to the nested series, and then drop DEV_INVALIDATE.

Thanks
Nicolin
