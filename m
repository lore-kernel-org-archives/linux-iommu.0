Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEC41E480
	for <iommu@lists.linux.dev>; Wed, 13 Mar 2024 23:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710373888; cv=fail; b=RTrOhmXEU3q1BQXUf9v2er7qxWoXLGgUtYgYjJUSHP525qFDq8oSKUP7xupvZ50ER+sGIz/2oHZrjr3/8XmReiXNl/iCnnwtgIH7R2lma81WSDrX8dbiM3wLaUe9ufaUT2bC2UKuLpFUYluhOOOu/RWT8FbbkibNBZNS0QkTO3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710373888; c=relaxed/simple;
	bh=ZQPlTHC3vRUVGFRYG1ZsceOlmjN4uB4ySzNwdn4zYzA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ord5ql6q01/UAPuR/MH6Bhb8z8XZA0Er4RRYQy+NE1NYa7VI9qUaOmVqzKrnPm3jsLUKmVQLzMu3JzHfBP6zFhdg865Yk9UzMXjBqPEf2X+FD3DVRHAL/adFxaDtnsFDSgcdb+0/BbBGU8XO95nB+dDVy1Eka6EXEfPXknKYeHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lv6GVHnN; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lv6GVHnN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBGa6VkirM75ThHsbDXz+VGLBNXjRg9EHPQAaaqAd+lT9yfjowdrDRKnWrEV6cfD0BhuqIoLMBEpZcb4t8xhjuLgqk7pEbaX8STG4+jE9cCRLBy64+6fsr5jPXRkgVc/YKhM1+3hI4am2LyPIuAUJTp9SJr0XbPz/6IaDQsQui9vGkAl/M1SEFc4dp6r67KMGVL02p/6mFHfXc+ab+e6feFunaZusj6/pKV0SVb3SfxKOaKfBBS0puVftwueEoPQocGtPY4SUwadYGi7B4McywfiQlRnjlZ4w9m8NmG/bT4lFaUK1mWMF5HQz0eBmO7u3RVqDMF0lbK7h+CYdNth9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltVsRxKIx6B60l+Oa6F5ntVzJJV8lbS43MgQWBfwqvI=;
 b=A8gpBtd37sYW7odqDZ98E2kl74LFz9CITeDGTfSG4MvED8AP0NdYZYVPoFeL5/nl/HEEZnFf2i3WjLzgOF/251d/oCVmd+k3a6QM3fQWPFPaZOW+EA2+Q4NeXLVr6RLgMN1iD42X2mtcdSBvB6FCbOdCbBL6h/7EqNuA7oIF0UPWWhEvT5KUHeRSPzJeN8BZba02TeCBk33OuZ3rPGkdlFaEx3CTYhOC83nnTOImt2C59v6z+gKrqNO+Ta/bBL8GRbrIbUm6MBjphQ6ryFB+o3WbmRdAUoCTDKd3pMGXwTLKwtsUYZ7tMFokvYRi8KXyUhwZSRmimwINDcP8F6XwMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltVsRxKIx6B60l+Oa6F5ntVzJJV8lbS43MgQWBfwqvI=;
 b=Lv6GVHnNpECH8wlucimNuycCWx6Gw3bbQTQpqO9uXsGtZIftr8c4gf8iVIcuWTit3EWUL2z0MFi4mHNKn6mUltfjyPuqqgJgZcejDuqVSjxsXTQWZBaFxvm+BS0hGC8v2GvwW2yU+P81fNFKft1l5NKZn8dZvgdtDQrteDcLyIHcjJ7fnCVMlh6JzGc1U6uf3hfUDsSPbJTs12lhd7anyoIxLSAQwjwE6q3I56vmoTzNh9syrzBoQKYNXYZcN9pGrewDPXhJ/AQ/rUirKtxnj8bKiQTaKdZlmK7yaEBduA3uqSJjXqcSPRl90iqZweAAEr/bP1pnCpjOdSa5FhUedw==
Received: from PH1PEPF000132FF.namprd07.prod.outlook.com (2603:10b6:518:1::10)
 by DS0PR12MB8814.namprd12.prod.outlook.com (2603:10b6:8:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 23:51:22 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2a01:111:f403:f90c::) by PH1PEPF000132FF.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Wed, 13 Mar 2024 23:51:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 23:51:20 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 13 Mar
 2024 16:51:00 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 13 Mar
 2024 16:51:00 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Wed, 13 Mar 2024 16:50:59 -0700
Date: Wed, 13 Mar 2024 16:50:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Linuxarm <linuxarm@huawei.com>, Zhangfei Gao
	<zhangfei.gao@linaro.org>, Michael Shavit <mshavit@google.com>, Eric Auger
	<eric.auger@redhat.com>, Moritz Fischer <mdf@kernel.org>
Subject: Re: Query on ARM SMMUv3 nested support
Message-ID: <ZfI74miZ1ss9+Kz0@Asurada-Nvidia>
References: <b8c1b2fb281246da94b35ceb5e27b538@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b8c1b2fb281246da94b35ceb5e27b538@huawei.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|DS0PR12MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: 267eec97-7b7f-43d1-a4a2-08dc43b87ba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MMm7tJqQssXRzUsHbsleI8PfdIV9Nxg/V4gOOnNBFmt2YrQrVevTs2Y/9ROXg8NsVLdbEsfGK2E/DYvDCG1XapaiUI285xiTEXWhPYhRS6VEDxN4sR6ZXoLTuNxtUWOADqqbKJXx4O8lYlIQvdtReIXsmNVvAbN9py1X9j/N0E/A+5U3Eg9zhZEc2/uAPwnXiC8HmYTGcVJPjF97qFq5wTMCurL1n8NwpEnIncGTv//yYIpJwSBQo0/o/xQ9bPwAXH98Ve7XRnyZexpuNmu3jIA+/ZlAV0A+PxuJpHbTaON/njEB1uXPdTmdvUghWLBs2s+IrWzDrJYhOKlTnAZ0TiqTMhqNfL3QfuMPQGtaM98B61qnyR3Baj1nXayiqLbFK/SdHj3o3fTyuN5hk+gG4x0dwBfPu5y7AyGk0bU06aGyjHI8syASgvUU1ZwHNzOWX1r3x3tN8nEddMz+Kiu4Y6+c2afvpAq5BGucp15q3miu7cRxdSJn23EKly7/QUBBHJqIp5Hb2wcwl/ywZ0VLe1GdLJndY3XZGFOEYUMKJBow2ztD4viJx0aEMLUSYxvNoUQDj9QqTFRPAtVwiBwOoIGEZxpWpUdYXRruOcvIiXUe2JCcoFCyZjoYiACFqU7QlW/44KesTVqNtaB51LPK3tFMohehePx1nWtZoWWTJ/WJAL8cct4RYUjP8EbH7wioxM8++3slFp5N8xtACJXf+7OvIGVu1wQF4Gu3d8ourfjDcgj3WMrA0bIAPwpm8u5VjiD/oIhdEXweXPOPiD3zGg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 23:51:20.5859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 267eec97-7b7f-43d1-a4a2-08dc43b87ba5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8814

On Wed, Mar 13, 2024 at 10:13:58AM +0000, Shameerali Kolothum Thodi wrote:
> Hi Nicolin,
> 
> Thanks for the latest repos with basic SMMUv3 nested support enabled[1].
> I did some  basic sanity runs on a HiSilicon platform and they seems to work as
> expected. The only problem being we can't assign two devices to the VM if
> they are on different physical SMMUs.
> 
> qemu-system-aarch64: -device
> vfio-pci,host=0000:75:00.1,iommufd=iommufd0: [iommufd=29] error attach
> 0000:75:00.1 (36) to id=4: Invalid argument
> qemu-system-aarch64: -device
> vfio-pci,host=0000:75:00.1,iommufd=iommufd0: Unable to attach dev to
> stage-2 HW pagetable: -1
> Segmentation fault (core dumped)
> ...
> 
> I see that on the Qemu side we now allocate a single s2 hwpt and attach that into
> all the devices . But this will only work currently if all the assigned devices
> are under the same physical SMMUv3 as we have a check in kernel
> whether domains are having the same SMMUv3. I remember Jason mentioning
> that he is planning to relax that. So are the Qemu side changes based on that
> assumption? And any idea how we are planning to relax that restriction? We
> do a check for compatibility of the phys SMMUv3s and then allow/restrict in kernel?
> Do Qemu can then try allocating a separate s2 hwpt for those and attach again?
> Sorry if this was already discussed elsewhere and I missed that.

You are very right about this. I haven't thought about supporting
that case yet. Likely I need to spare some time to refine the QEMU
part in the coming weeks or so (have been waiting for Zhenzhong's
full nesting patches).

Also, NVIDIA has an interest to support CMDQ-V accelerator, where
we need more vSMMU instances, than just one. I haven't decided how
to handle this for both single-vSMMU and multi-vSMMU versions.

Yet, some of the ongoing work might help:
https://github.com/nicolinc/iommufd/commit/b7520901184fd9fa127abb88c1f0be16b9967cff
https://github.com/nicolinc/iommufd/commit/d969ffeac899491d3a6e54557bf6a46d52b95865
So, each device should poll hw_info to get its SMMU ID, if it is
not in the S2 list of the vSMMU's, add it and allocate a new S2.

Jason is on vacation. I believe we'll have a more solid discussion
later.

Thanks
Nicolin
