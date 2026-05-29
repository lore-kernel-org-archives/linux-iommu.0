Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013068.outbound.protection.outlook.com [40.93.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA0D3655CC
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 23:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780096839; cv=fail; b=p+hfIsBYHGI0Zfzk9S1gvGCudng5Vmn4tfx9bg5wDsKi4gU+iq1quX6AyGCpp+mmGLW7f4cJQ0XdbBNL6EJjBeOSqhW3x00a64hglW1kuwh1buw+ZpgXhmsTchDe888HfvnlRNkLkoZn9nAT3D508+ovLmDRD7QbD9/2/rcwg8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780096839; c=relaxed/simple;
	bh=T9mC6V0E7Q1o+zF03nDhJZflLS7PU3/f9EDd+VGTjKg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1Q2fcg2VW3ZGOCn6M1HHSrcrBUCopbpmp2B8FqnonVh7CezdznM1YWY2SqHhko1lCS7SkUmDGgBEr4S7YGdQhVBt4Q0lLgZNFY7pUpEn79/0FDhwzgVEpKSd8mr+LZhcLMjTxyydO38h1uMiQ0dEMEAJjRmdJ2H/vts26F3BnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t5Cb0+b0; arc=fail smtp.client-ip=40.93.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t5Cb0+b0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OVbgx261+1M1qHJjXrGu/+Q2G7ZFGcSEfdTDcRAq1CtiiTLKsf4DqbX2xvA7ncyeSyGfFouLICS+djy3ET+KuqeEvn4cx6izfPqS6Ab8tKh1zHe+AssLVNkw+ZfNIGeA/qvx8Dj2G0nHULXph6YRMQ4gzEyrtMB3Jjz6AXOWhxyEhYUaGFWYukeKDACsn6rykD9VcoXv1Pf9zsy1A4cmu+ZTpx8An1qMvM7SMAvAU7ipSuHrSnTGvv2LwMlffHYULhPmnXwPxyJG3FI6+az999ehMiKIPTYFxRKv0n/DuVWHrn82fp4fr2TG2/CiqOwvLxbz8ZXx2JCZxsO5sokOnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6P4IcnEeMDAGWEi8Tvgh9WpKIPUwKGbm9uGUADN+scQ=;
 b=ke5ny0H4sfxwqtlHtFDfjm+yq3YkE5l8pJCz1vMky6NmhFTbgzyXmgDmuwmlvMfk/Q+YH+5LoUlu7cXB7/L7FdkPsZ9nX1Q5rL6TYqB9wcIagcQSx83eAmi7zll+0V15ACucAPj2LyK8MDF1bRadNtRhJBeotF2FJjkk8uISl/GTRXsAoHXYO2EtEvuUwMdPMfGYvlaIsR7OctmvHWcHRsE3wgxewc+t3ENVHg8t5NHtlEJHKcP1UxzORLYnmN6rjDaToY8g7fkvvHrXnpWOLVGyoLcqlNMrDyLSLw9TE6b/EnYIqYi/p4aGUVa/MYpj7LJ5DGRVunYniuOMoEuHJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6P4IcnEeMDAGWEi8Tvgh9WpKIPUwKGbm9uGUADN+scQ=;
 b=t5Cb0+b0BO2ng49/hRPiNxQ7URR4cZfQB08r/w7XacXO3Xoys8jEyM077HE/UJ2G30scT8Xxh+YfJo3x+VOAP/vn1T4WiK13pt9X0q/mzWGxC/elwYqPYnQa4pDsD+vw5rSfoDDAlablv2clKe3KhP5fOHp0bCwde0QbIcm4v6s66elqHOxnI/urBSpdv1rCGvF/wis+yJx5YpCWPeW8RANgg1Nq90pjl16nWfBvQLj+vObBnNAslkNExaiH61wQQiMacKKuslBz8+wd4Sqbc1GhmMRetVhSY82XNXeDtVfUIL5/4zb2cawCRhbBYPkSfU6QZL8Zh53o3HA+RanHxw==
Received: from SJ0PR13CA0103.namprd13.prod.outlook.com (2603:10b6:a03:2c5::18)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 23:20:33 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::a8) by SJ0PR13CA0103.outlook.office365.com
 (2603:10b6:a03:2c5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Fri, 29
 May 2026 23:20:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 23:20:32 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 29 May
 2026 16:20:20 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 29 May 2026 16:20:19 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 29 May 2026 16:20:19 -0700
Date: Fri, 29 May 2026 16:20:17 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>, <yi.l.liu@intel.com>,
	<kevin.tian@intel.com>, <vasant.hegde@amd.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>,
	<wvw@google.com>, <wnliu@google.com>, <dantuluris@google.com>,
	<chriscli@google.com>, <kpsingh@google.com>
Subject: Re: [PATCH v2 25/26] iommu/amd: Handle set/get command for AMD vIOMMU
Message-ID: <ahofMQGl6TzvIwnL@Asurada-Nvidia>
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
 <20260528051738.596013-26-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260528051738.596013-26-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|SJ0PR12MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d66aec-ffb1-456a-7170-08debdd8e1aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|7416014|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nfKi/TvogqpcrW6UAOV2ic1Y+cU2qK4DcrNI5p5hkVjkW3k4/YO3QQh10DwTl9yL2j4o+O6EEaXsbhwPlIdZT4BoH3+RazcfHuT3G2s85tOejGmuHk4v9BO1wm8zGBw3qBm7CiWH5DBCuH+TEkpxrAnjd/p2u1h3JK+IZdYlp+Nwsg6Jriqzarn4eyhDH48u4BJvtGvnoxDd9s2eLXzIXUj7BJg9Sb0+8foneqoD+HInluuje3+2MNDUAaS+VdBODYuYS78wzOTAJIdkSkXGHiUEEX4+mg87EOo5cPW19TID62VNoxSAw8BvugEoWwiPK1LMDd1i4WlwRRAoY6uHbQuh9Os+zGJqMDA0f9MK+VPIAsQK6KwTvb8UYrI6e3nbd0KpI7SFF5026IVSOCLBSq+l26Xm8zZ+0B7/Ek1CJ8BYKMm9QTiHcDQfrGkmd/gLoLqtQ7qM+CFQDvp8Z7E0rE8NyXLS5FWkksIQ5oMsmRqJy0O2EiTcgy0h+UuciAImTMVO59jtsYTEmGr60b0hfU2Fo1SJfjhAwlmpUQP7knqQuR1oTNc0wggjxAPApuvPE8sRnZkYU+a5nf2i3HNQ3i/We28MhBh3Dv0srbDex8oDrGJsabBjx73wcpXseNUPleHuhT+MZlBaaY0lLYj+vo6ksUViunw5TelDijVbYD8vHofgTr1JSUsaIyXbGoSrg8KZsDuA8Ttu0h66LBfLgGHQTmDuSkEuCouoNvgtHLw=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(7416014)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	n550gDw8jpsuQa9BoUCJBuborxXL/Nt8nKgf6kj6ec3hqPmWBbDpfrkF6yCCBfJkhGbAyLxIzyNv86zPDR4kb0qRKjAeqV0/GyqiVdrhsNrKVmRLtK+esdneCfYCnPH8JT6D8YouzFcfBf5j44FD/4m+HVFgY0UEJ0ZOAnNDtEQpP+6VH15/bSsV6UeyKa0af3r7BaFwXW0CDAyaXg61C6zl/17M5wDxlgit1ui4tN3mfvmHkBj9Xh0Rk39V4IlmwmLiqijGledVKadYOX+SV9dckNX+wZfAyArorZt0UfztqlR+SYXWi7CHsvoUQ2Yp1zBNYVte9vvzQUHRDXNtgGlK1cd+QiUw+M/UWixx97ZMIK/7zmAZPeythwz5tOq4I7bM8mEmAyJ8rkNxy5h3xvDibxJ1kylacHMvpdsgbzFixiF/6y+8YW+6MJ4wyX0u
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 23:20:32.9660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d66aec-ffb1-456a-7170-08debdd8e1aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006

On Thu, May 28, 2026 at 05:17:37AM +0000, Suravee Suthikulpanit wrote:
> Guest kernel programs guest Command Buffer, Event Log, and PPR Log
> (a.k.a hardware queue) settings via guest control MMIO register
> (guest MMIO offset 0x18). Accesses to the register is trapped by VMM (QEMU)
> and information is passed as IOMMU_VIOMMU_OPTION to host IOMMU driver via
> struct iommufd_viommu_ops set_command() and get_command().
> 
> Provides AMD IOMMU driver hooks to handle set/get operations for the
> guest control MMIO register, which uses key parameter as AMD IOMMU MMIO
> offset. The value parameter contains the value of the corresponding guest
> MMIO register, which is converted to the format of AMD vIOMMU VF Control
> MMIO registers then programed onto the hardware.

So the whole set_command/get_command thing is to MMIO a control
register? I doubt this is a right ioctl(s) as it can be abused.

Looking at the details:

> +	switch (offset) {
> +	case MMIO_CONTROL_OFFSET:
> +	{
> +		/* VFCTRL offset 20h */
> +		val = readq(vfctrl + 0x20);
> +		val &= ~(0x3ULL << 8);
> +		tmp = GET_CTRL_BITS(ctrl, CONTROL_CMDBUF_EN, 1); // [12]
> +		val |= (tmp << 8);

This is to enable a hw_queue. So it could be marked when a hw_queue
is allocated; IMHO, VMM should only allocate the hw_queue, when the
guest really uses (enables) the buffer.

> +		tmp = GET_CTRL_BITS(ctrl, CONTROL_COMWAIT_EN, 1); // [4]
> +		val |= (tmp << 9);
> +		writeq(val, vfctrl + 0x20);

The spec suggests to set this with CmdBufEn, so it may be a vendor
(or hw_queue type) specific flag in structu iommu_hw_queue_alloc?

And similar comments to the event log and pri log buffers as well.

Overall, VMM should control the timings of allocating these viommu
hw_queue objects; then kernel would just enable them accordingly.

Nicolin
