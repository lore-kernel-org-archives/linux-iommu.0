Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012041.outbound.protection.outlook.com [52.101.43.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A1E21CC7B
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769531942; cv=fail; b=Xlp666ooujGnxAaoYfcqTVUAjFC062z3QSADzQE+I9C0eiS8fEUbTLyMBI5+Et6Re+pi2RKwD8XqTAKxE+9q6xY1zLRoKBIB8C4xJgzuuOu7QB3vz839tFSTfqnumP1qI1nEXrPJxZa/dsDT4jO9b27rBM7h0APgcxtY0jc+Uos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769531942; c=relaxed/simple;
	bh=V5E18wgLWGr762OS44jnrl2pjcvJ0Mhuy6OO9UNsQUg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjEvPwuNAkHBHoTT2QGmrMv/wen0E/NrQQUpp9ZEws5DKE+zt3TfengrRnqZVKF8g+9RjTn5U3Np3zACo0fozbSE8V7ucuobvbH6B6LREhqsMRauPtr5uilfWc+pI6w2LmhxksJpUE2ir4ypTCl5X/bdqiHLzaSEYqFjQdIeCgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l39RjM64; arc=fail smtp.client-ip=52.101.43.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l39RjM64"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CmAxk87CWoC78If8/gELExGXa5+HAaN0qFZiIFtdecVJlKnDrmdfCcf5QIKPi9LheaLibqJav1iAuHh/k/88/GEwdZXckzTyIt/yT4Rp27eiPNsROtIZ3zkZAFT05EC4Znl6hbG43pkYYMgANt46tVHx/G/ESUkDNPn6OTaXASkVRlCrxG36wrv+byOlKA7Kxol2VpWtwaTKPshxU0izKpTShWTb490hYko7NdRDGqM8R8k4kqqtRdplOJZ/SgLRNiI90bzF5qRbivktWvWNNiSdoyEkgVtYy/GHoAsXeyDJA7eAbASKdm+1pdstfFChO0TCwgvLquj1Yb8XaFKLWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBnEH2TUcdXc4W7xQBKCM4C/o6CyLMaBab9UbKGPTrg=;
 b=tIpkTjuU5DKnSXWrfdfF1eFlzI1XCncJ6XXkk5VWZaz9EP6Pgc2R+idwdOuuF6dhcrtXIPZvVtlRhjpsmSAUiGbLQj1yXIlgAGcb81LCCX37ID9HvIjFu44sFstxEVawPPMvGW7nRNJuiu8AuPNFgYEIK2TgNAeYHQ4544b2Ujci1r/5jFV6cbqCbCvblLVJ14noPjtOQfETisozmTNAB7JyldeiqeuEqJ1mEuzEhKNYvhxfU727nvoTRC+GIb7/SvWdYXCdfDqEk4kBO06Q+lvc92G3pmR6qG7VD5EhwHtpb5ufdZMG303pOLLOa+tmqAeZ/+p0omm83Q/OlPI2dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBnEH2TUcdXc4W7xQBKCM4C/o6CyLMaBab9UbKGPTrg=;
 b=l39RjM64i097t08E+XJQj8SFEet+pllvJ4oT8sEqZaZ4TCLSRVMQoTvNzZOcGaecP55fAeiP/Ix0NnNSmYZALrGF13icMui7H7IAGOV7NxsjbCKXhD5G/asw9N4rCMOAQEQgXFdteGPh5jJ4iGFhyZbtJzG+n+jBhz4jboJIZGyuCn5fo23jgUZ6A4MvKkdDVJbcBdre8u+P+5KHBj766rYcSG/VcqqzqQ61Thy+lTfey0zBJIeEkideJxZt/5my03UP+DKbUAQfZe4aMCv1jNaDOfPe/s15/eDmJaWZjCPmynV64MipvpKb/aRT7+VOiW8sDWkOM/dOhUn0m5TbmQ==
Received: from SJ0PR13CA0073.namprd13.prod.outlook.com (2603:10b6:a03:2c4::18)
 by DS7PR12MB5886.namprd12.prod.outlook.com (2603:10b6:8:79::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.15; Tue, 27 Jan 2026 16:38:55 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::d1) by SJ0PR13CA0073.outlook.office365.com
 (2603:10b6:a03:2c4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 16:38:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 16:38:53 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 08:38:34 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 08:38:33 -0800
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 08:38:32 -0800
Date: Tue, 27 Jan 2026 08:38:31 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, Pranjal Shrivastava <praan@google.com>
CC: <will@kernel.org>, <jean-philippe@linaro.org>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based
 arm_smmu_domain_inv_range()
Message-ID: <aXjqBy2sWAUMm/aY@Asurada-Nvidia>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <06999367d001283744fd98eb7c1823afd516ce84.1766174731.git.nicolinc@nvidia.com>
 <aXND9YJTwm6om689@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aXND9YJTwm6om689@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|DS7PR12MB5886:EE_
X-MS-Office365-Filtering-Correlation-Id: 53840c5c-b7e1-4810-8c7e-08de5dc28eef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|1800799024|82310400026|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U6SJG0Pz2FuteLo5gw0vy184JPgXJ3KwG+EEeT0Dhq9MjcM/fyjkcUIEtRuK?=
 =?us-ascii?Q?rJ8NEyMj3TuxhDzAzyxCa7gJikTI/Ei+ujmc5A0wjKZANsn9PrA5bpCeFAvx?=
 =?us-ascii?Q?kRsUkiLh7RquMre7PSZss/YbRBJxcRAQ3FLz2ZTOAaiqRFwtaINwqtN5RQ6h?=
 =?us-ascii?Q?laD5kr1fAliXVfHx0nvf5LDmhpSIlYC7kkp/yWiOuOdcU2vc2Qbp7uNxGsty?=
 =?us-ascii?Q?0LKgDLzOuwHUhNIyMzCgvm2rGlG7u6+2QfFix1OTaBX0H5P6RmeULy0aBFVl?=
 =?us-ascii?Q?fCWaUr8CB5IK9Fmn+MTQ6JhTZEUxG8hQxlMDQEp0CmG6DSkbzKPSILRFDQiY?=
 =?us-ascii?Q?ZNkwqmCjeboyx/zmeE8fGFlHTb9nRzjj1T+F6UiPl7BC5/tUWoMaYD2m6bpT?=
 =?us-ascii?Q?CfQEOedWLawZ/AITrNWn+4VAA1hNXzuPAj8j1kKbiN/nLLIBfeseuPF6iRMi?=
 =?us-ascii?Q?QNdx8UrJnZtbCFxKywcQKdFobvT7ObgL73iy9FVrJ8J3tHm+q35/1FR3oxd/?=
 =?us-ascii?Q?3khFYOQfnGp9PXzcdlGCK4v0aXofl3jBA1BUF2bbOsFPF3QhH6V1eg/uO1V/?=
 =?us-ascii?Q?katlRg+C+BGc1rPFQRtnbZg6t9ScrKlJrgryV6PvjedklFHHXmdKLMrd97lS?=
 =?us-ascii?Q?ZtyfIRT05rO6El7DVQQUNWvK/X/KV+fFDcpKWhmhqpBULHAuG/6yT+NApXUv?=
 =?us-ascii?Q?GME5PwA6dDIUcOUN6Wx/pu+g4PmhFe1b7gUzowYIU9xa+P0IG7Sd6r8TN7bq?=
 =?us-ascii?Q?OwbI6V8ocedFrpAMODNzKL+MGFe4WQ3tDgsixfbQidnTs/X8atPlFHQGun3G?=
 =?us-ascii?Q?lAD7/CgGnVJTZ91E5PLfvsg2Qrg+5fM0Td6zKTT/UglR+xu83vJxXVV7sjoc?=
 =?us-ascii?Q?iYvkRHnkDETmsk0Y44AXh/A+VchDJEjz+s/aVguFbFDoNA0Tas9hBkbWxnhQ?=
 =?us-ascii?Q?ojGYRybfnjVODEyIv7ZtVg7ZIoB06iaWwVPwnOpGJWLUPwWdPt/SHX31f7pB?=
 =?us-ascii?Q?sGFFlGgKDCcN0wq6SU1mL++pe5BNbm/EYF4riqZ761ruw63w2CN3kJU0p49c?=
 =?us-ascii?Q?gDL2onbhaX4NghW8M55pfpWnxa9Dxc26VekM8y+vO/zm2TJvG1011TO/7wjU?=
 =?us-ascii?Q?r+taNlz3OBUyQv8D3ajrXWddG+9WgVYnhm0h+UfoZeN7Bsj0xx9HRtU7z/o6?=
 =?us-ascii?Q?/H4tCmqMw/qeQ1sR1Z5GTPMxXW7QH9+awgzHVM7l8P+jwPAQ7gRG6quPaGbw?=
 =?us-ascii?Q?1g9N/DF86hM3dkPRUXxcP3ZBAZDHhXHC4XGuOURAJAzvz/N+m6yyjpYgHasg?=
 =?us-ascii?Q?e7Q3hVIZyLnADR9mvfrN83csuwdzh+P1//p1XTFiW1YOARUFDcgsCbLw8+Vm?=
 =?us-ascii?Q?aL+w2AzrbCWgc67ZuLDwga0eoGxFBAwUhE8fa2qf+C7vHMn4fsrwSMl3dHp5?=
 =?us-ascii?Q?MWHC9L6EPXvBudx2jTjH48OwbNiyRNiYdX0PSHeau6JsiGg09K2RLOADamrP?=
 =?us-ascii?Q?WUfuYHoFy1e6AoKGhkOvwhHOo6D2BIT5hIssnJUTuBX5ceaCrkxLWJFxEZYS?=
 =?us-ascii?Q?N1td0d9FAkY644/NX6A+1mbB46WJfNq+7KtvnSkzcfSnVon39Zq0xGZgIZxF?=
 =?us-ascii?Q?smYTfBm9i6BOQ937c9W7qj0KTAYbcW5K07gpXSaEZYUgxC2WXiAW/F2oWm1F?=
 =?us-ascii?Q?v/1QJdz0k+z4/le4O8hn+/5SF5k=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(1800799024)(82310400026)(3613699012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 16:38:53.5743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53840c5c-b7e1-4810-8c7e-08de5dc28eef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5886

Hi Pranjal,

Sorry, I missed this!

On Fri, Jan 23, 2026 at 09:48:37AM +0000, Pranjal Shrivastava wrote:
> On Fri, Dec 19, 2025 at 12:11:28PM -0800, Nicolin Chen wrote:
> > +	/*
> > +	 * Avoid locking unless ATS is being used. No ATC invalidation can be
> > +	 * going on after a domain is detached.
> > +	 */
> > +	if (invs->has_ats) {
> > +		read_lock(&invs->rwlock);
> 
> Shouldn't these be read_lock_irqsave for all rwlock variants here? 
> Invalidations might happen in IRQ context as well..
> 
> > +		__arm_smmu_domain_inv_range(invs, iova, size, granule, leaf);
> > +		read_unlock(&invs->rwlock);

It was kept from the older versions where we had a trylock. Jason
had an insight about this, mainly for less latency on invalidation
threads.

Yet, now we have a plain locking. TBH, I can't find a good reason
justifying this. And it does look a bit unsafe to me. So, I think
I will just change to the _irqsave version. (Jason?)

Thanks
Nicolin
