Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D911AAC9
	for <iommu@lists.linux.dev>; Fri, 30 May 2025 04:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748579555; cv=fail; b=tQIE6n+frfcuSqEkoTQ+ceXkD87uOWhmQaZLL/G4fX5dMR16GbIrHf0ZxCeum6XNFDE6/SJOg72DwOWv0eS0A+2gJky07k5gLw5DLPtrb+ITAVItyvdl6KAZ+Skyk/4PRllO6LHA6gYULvGnRYdLU6VEWnSMavwiwDivfmOpBuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748579555; c=relaxed/simple;
	bh=bbzSVqGp93wAh7DQp0uSiTjDHRK3Na/o+7+jrXof9aY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gN/b4z5pVikPb8ZWSzmQIVtjSTeOYXFwv6srkf3OCTqKgLw5f1Yt8rxhKmzorkLKG0e5/Md1vRWMZF5LbfRameKdTq+q8C+N7iBSOuUYfXg7PLbs1A4fz7Jm4Q1qXIkwOJdZ3DsdSbigvufSUIBnYsQfPslohhH19ByS2iW3Gyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X84Va0mb; arc=fail smtp.client-ip=40.107.102.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X84Va0mb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3Dahj7YiMoahoBSZGuS1o3bG9cXHDSW3kOH/Ba3f3+6y4x6q6EG223kLZ9qLsd8cTWjDmmG0M5ONpnzdjXBjVVkQ0H8qWg0bkDVZwtX1Hf6vWQyHxKbMk0bBgRFxbLuBlABfVoYMxN5IU2eTm1545wmQ7y9xArWP+aFNQB5DEDQ+vZ2jB9dijwr4jM7j7RSTvLczh9dOdeGfKzHRHoIu8AzPcqF8Tb86/wBPNlYrV7XtKf/jaU1ZNCgdIpAK/dXFXUV00wZDsl31/+A2IXIWXOmECC80Jl/1FY6McSxFXdbuRMbfF8+ydXmwQF5AC12V6d3A18uywNo/RlXUj2CJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3MK30WJdWRDpN6zQWnkD7fbCR1g6nTgTphFiHCdLWM=;
 b=M3nbGNS4R+dAJIeUreNPymsVwBhJXNPBiaS1R8yOp5XHlk0AnCoTaIK1JlX1EFOmAfyjdrPTU+4qCbwYRArAKPlRPwN/DGmhorM7gNzJj3TFNmDITXVFM/HNn96x8EawReGmzloFtq8dQhPgHxgfrlLkCLU/7iONYXGv4dBCKrituLZC/6CKEBynATL6s06cMNq8k8cVVkCJ3eJAi7A5JntHvxn5ln8U5Ezg3C+0O6OLsmhUIxMO70rqQ9/BaFY496Mu1S5v88EzyRQikx1Iu+Eg0stcUmSs7WjMaiLFX7rZZsJX2tE8hotFYS/2gBqwWfISeCVZ/VRvD7MtWn6DAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3MK30WJdWRDpN6zQWnkD7fbCR1g6nTgTphFiHCdLWM=;
 b=X84Va0mb5VfOUqMuX1lOXyb6nNPd5sCM5f/vtzorV/m2tn/rGs7ks88XVX597/LuA4i4KOCr7bgXwsHCexIbhVCwC6jRvkBtoBEcW5VbfxluCMMr2FpEBCUK5N/9EH+1RlmaEMat4huC/6RxBVfa0+wIc/ze7VzuU9twzBKiQbA=
Received: from BN9PR03CA0210.namprd03.prod.outlook.com (2603:10b6:408:f9::35)
 by MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Fri, 30 May
 2025 04:32:29 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:f9:cafe::e0) by BN9PR03CA0210.outlook.office365.com
 (2603:10b6:408:f9::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Fri,
 30 May 2025 04:32:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 04:32:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 23:32:29 -0500
Received: from amd.com (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 29 May 2025 23:32:26 -0500
Date: Fri, 30 May 2025 04:32:13 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Vasant Hegde <vasant.hegde@amd.com>
CC: Joao Martins <joao.m.martins@oracle.com>, <iommu@lists.linux.dev>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>, Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 1/2] iommu/amd: Add HATDis feature support
Message-ID: <oxaboinp6alkzsutgwa3szea4exw2ipnfowxjyspcwt55qnkri@x6bwklyqzoil>
References: <cover.1745389415.git.Ankit.Soni@amd.com>
 <6282a5c349812a311a67a8522dc5e4aabfe3ec3a.1745389415.git.Ankit.Soni@amd.com>
 <596ed125-c995-4e2b-824c-b7929c852754@oracle.com>
 <g3xrnjfs6zekogfohud2s7kdvphx43e6mdh3vfpllynrwokxwf@vvetz2j2nrai>
 <4f04d596-685e-4e48-9038-8aee6c927ebc@oracle.com>
 <lpbeiyyzoxuankxzgcms2iwkoydvj2vcpv5jftiy26nkslliwr@juykyxhdwwzv>
 <deb1603a-96df-46d8-9cb5-86121f334a88@oracle.com>
 <m5ageqedj5otmfo4yuld4es72esfmlc7vb5htolj5pcffurjl5@mi5xemcd4fgi>
 <3b38fc9d-83c6-4db8-8a83-eb4265796b03@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3b38fc9d-83c6-4db8-8a83-eb4265796b03@amd.com>
Received-SPF: None (SATLEXMB04.amd.com: Ankit.Soni@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|MN0PR12MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fefaf22-490e-428c-e4f3-08dd9f32fcee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TvQBatDhMhmW8PFian2wB0twb4CRD2Q7DVbWbvSJ7wXOicluS9eB7A72mc+N?=
 =?us-ascii?Q?tULuTNNwvimsqd0bTnE5K99uKvvEaXq/lJ81VwFEGhq42mVztgdPJez5414G?=
 =?us-ascii?Q?IOiAKCCgt9n8og1uP5GJqGC5fNm7+I3Z3OyAph7E4FHxU58ZrzWSvah7fmA5?=
 =?us-ascii?Q?tryjm43LIW8MaH6DHdkwq3hyAl6F90S3/GbwwvBKKs+U1aUn/QM0Yxxl2LF8?=
 =?us-ascii?Q?dmTfO5EYaGm7oWppOSvt5AU4uptPGnl4P9szgtwmebb9ebprduHqCXejMs1J?=
 =?us-ascii?Q?brubu4Mjj1GASNpOjWHB0sQsX3EN8iQu+ZG+G0l8x7DpsElGDP74rYZL3PEx?=
 =?us-ascii?Q?6rEB1ivaQ59mjdLA9x7mx8t2CGFLtrf/xLrNBABnMLvfquop1cC7/aiN0WKh?=
 =?us-ascii?Q?bQL7jaoWfESY1ZzkZOzrNkoU28gYjDVr0beeA7gI8AhHFyUj8UI+yGiK6Tjm?=
 =?us-ascii?Q?n9wUciEvcym2Cksl51zI2xrE51UylGl9BjgMbeOSP2O3YA4bDliWEXniVm1R?=
 =?us-ascii?Q?JSNQdqJd/1oay5tbd6Pocg+cbXtyp4b93seHRGUu7Gtvs7Gaa8q4ckYNQdWq?=
 =?us-ascii?Q?A8c/cuUxZ2wMa02gF/OM56h6k9XY1SKCuVtf9OREQ2W9Etx4u/AK2sm+ZOgC?=
 =?us-ascii?Q?pYnsALwjnvRRZMpUWvgTmN3m0TVxyTy+dT9KjDC628TYP/ap6k9GbM8ppKLZ?=
 =?us-ascii?Q?FD8bdIP3Z6yxnInSJRJV5g87nXPlyHFe43X977OzGqqqq4JRXkU0L10LHeVA?=
 =?us-ascii?Q?582a8hagSI49EIkCzeR9oTOlqjTlgDDqJCnOIKYcA9YBKqWmlSHbG1qZyIjF?=
 =?us-ascii?Q?T36KXP4cYIy+FR+5sQnpqjbPl3qY3Hs/ZHK6wJ6emEzCcdRSYcFmFD0Y0G+z?=
 =?us-ascii?Q?R5r++gb+tZkqUzwNUQX3NU0ojcV1GXLSLJQZraSXLXpACyK6Yfk4//IlFdhi?=
 =?us-ascii?Q?oNU/91fw02r5gT/qd5dnc2blNjxB7ppDJlM2bzAb8kcA/ah5DmuViAnzL4l0?=
 =?us-ascii?Q?soxWiiqYolXbIT4d2BEGhNeBdQg72IELrq2LfE7Uqqjciw5oK0zcucnPcrAA?=
 =?us-ascii?Q?rl0sivaR+K0nF6RQoNGie8tJYINrfBCipOift7WbkI+uj8wev3lUOQGEhRnW?=
 =?us-ascii?Q?uKbsdWo7vXZCK705A4yvyRJ5l8r424I1sDyOxOOgq4f2ZnyjD+Mgt8klddXT?=
 =?us-ascii?Q?VPn+inJg/D6CCRnrTWFJ6RDVOfQRZx3zWY2bInCCPiyOFFg3DkaD/psnv9Po?=
 =?us-ascii?Q?2I0Ql5vWKyQNi4ud0wpbUmpIKYodXe1GQGS4gNmUSR4czmJLpaszfiZ1tXP1?=
 =?us-ascii?Q?9nuaNLWbURyLt5/oh6r4T1vGMsEbgGDcCpHXp4hWbNXBzqkDIHebm/cIJLnZ?=
 =?us-ascii?Q?PMRQuXROD71+yaz44KNgMPHQSVPLX5tpdgJwmZdYbp4q1tZLUK8jPwXtKRZf?=
 =?us-ascii?Q?7AuEUetxWpr0nM126fubTRMmDUSYYPmsJj3jMuRQ09j9Zyf1lf8vtTfNv8Hn?=
 =?us-ascii?Q?jWHCh5swCUpCYO2TvbWf8xQnm0I4Y9FSMqW8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 04:32:29.6740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fefaf22-490e-428c-e4f3-08dd9f32fcee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930

On Wed, May 28, 2025 at 05:49:35PM +0530, Vasant Hegde wrote:
> Hi Ankit,
> 
> 
> On 5/12/2025 12:00 PM, Ankit Soni wrote:
> > Hi,
> > 
> > On Thu, May 08, 2025 at 06:03:44PM +0100, Joao Martins wrote:
> >> On 06/05/2025 06:12, Ankit Soni wrote:
> >>> On Wed, Apr 30, 2025 at 12:41:04PM +0100, Joao Martins wrote:
> >>>>> With intel patch you mentioned above, it seems that it is mostly handling 
> >>>>> "second stage translation support" disable, which will eventually disable dma 
> >>>>> translation. And in AMD case, HATDis bit indicates host(v1) translation is not
> >>>>> available, then attempt to use guest(v2) translation, and if both page
> >>>>> table modes are not available then disable dma tranlation.
> >>>>
> >>>> OK, I guess it makes sense if HATDis is v1 only.
> >>>>
> >>>> My other call out was that when we disable dma-translation all together (aka
> >>>> both modes), then we shouldn't advertise the IOMMU groups (internally and to
> >>>> userspace) by not calling iommu_device_register()/iommu_device_sysfs_add().
> >>>>
> >>>
> >>> Sorry for the late reply. I had cross-checked it; if the probe fails,
> >>> then IOMMU groups will not be populated, and eventually, it will not
> >>> have significance for calling iommu_device_register()/iommu_device_sysfs_add().
> >>>
> >>
> >> It would nonetheless populate a ivhd entry in sysfs needlessly but with an empty
> >> devices list (qemu diff at the tail end for how I checked it; it's only missing
> >> the ILLEGAL_DEVICE_TABLE_ENTRY event being generated, but enough to check the
> >> first patch with sw iommu) e.g. as far as I checked:
> >>
> >> $ find /sys | grep ivhd
> >> /sys/class/iommu/ivhd0
> >> /sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0
> >> /sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0/uevent
> >> /sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0/amd-iommu
> >> /sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0/amd-iommu/cap
> >> /sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0/amd-iommu/features
> >> /sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0/devices
> >> /sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0/device
> >> /sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0/subsystem
> >>
> > 
> > I was assuming, since iommu is still active for interrupt remapping,
> > user may need info for cap and feature using /sys fs.
> > @vasant: can you please suggest on this?
> 
> I don't have strong preference. But it looks like intel skips populating sysfs
> properties. May be we can match the behaviour and skip populating ivdh entries.
> 
> -Vasant
> 
> 

Sure vasant, thanks for confirming. I'll post v3 soon with this change.
Thanks,
-Ankit
