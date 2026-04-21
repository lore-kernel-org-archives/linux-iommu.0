Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011034.outbound.protection.outlook.com [52.101.62.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA2F31E84F
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776793454; cv=fail; b=ZOLbXrtjYJwF5GsHqElRvMk1HJH7LjEoNsgZ1NM7bpfdYVrZuTu/6oUktk/s9wNWzlCSx78oCC6W8o6ZB0dFoFzp1Ssk9xm367hAs1ITzNNQmYipuO5vGskxcc/a2s7RMIxOngRygCsHWKdmXOkKyd799rw5A7lQ6R0V5YgNtR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776793454; c=relaxed/simple;
	bh=89ACIs3Ds1tfmSMfqlbOXNIhty2CjYY3uwbib7ep0nA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0OXIdgWeWXFYJvFjzdQvrgYJaz8SVt6UVunUYBiY2qv+EjGgJA2T7TdcOqcxQqizcCT+jw0pVDVxX9Txl/OuzAPNhw1pY5hPsqOjlQlIU/+CJpQvV/TQgnai/GjRaT9gQ9+HQXnKVL6bc3YjRlWfZGVGku/jDc/WLsg7WjXyWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n838M7VO; arc=fail smtp.client-ip=52.101.62.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n838M7VO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsAPOTRJJbf+eAMCGZe39aTRk8Qdfr6gOp++oBaBYkXR+ucUdhhk6K7YRhFKvSqWr4odC6RBXGP/U+0YLodSw4JILYZuQB9a4C6M5bu5DZXfyrJHDhplOiogmzHDYFihKAhS9TFK6AyqEiygizjY30sFvTaAZ0CyECvmwWIQ5oA0mlatsIsl/NTUkLzVE+o1sjW+oJ3A02CSoMN4r7z1W3RJaszG+OK1vesDDnaTAFd4rnfYl01czWn514+ubEMsE4ppd6vi8i910KkOIi5KkezhAyYGZVvMoFoG/D7qk/wxuB5AqzFJ7fWPsFk0MXfPkoyRcuvDulPqoX8Rk0xRTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EX6KyABS8O2T+hyMiI2rcL6RgTETSZrEcfx0M1/wdXA=;
 b=ArJ60V+CaVo/9qxx8i1KHwnTIaFxmh6wcHBnx0scjL4euxCev44sV9dEgw4T6DXXKhPf+HwbNl+qhVbW1ZVrv634Zmst1HcZFttRSwJXnaVnoMq+37ybiXprdqiNVmtSnwoEPzeXBQEset7OWCcXPP1qPnAELfVmTlJhFIMzLfv/Yr0vFEprFzJJeRyoLMjaCZp/c4RtiVrdJE1+fEsqeBtNB4bUDpoc/na+Rbg56NOtKF5CBCXPxdtXM9j0TuMTPROORNTxhmy658khXPhl3MUAwR/v1YUwte4A2ydsEkhjGkuGGnzvVrAx7Pjfa0BbOPd/lgYwG6mnPgJV+TMGaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EX6KyABS8O2T+hyMiI2rcL6RgTETSZrEcfx0M1/wdXA=;
 b=n838M7VOW445Z0KqQaejkBdrv/93XwBXbPo0eUV7HraQrVEvAhDvcg4nGlT69aXoJJIHY4vhb5timfplJGGnuCt3WIz8i75Zq9pSKsBBOtT4z076M1byzm0XLKmyBYQPEd1hD64YWnlK/6CK87hWTwtNfi8i1sB25H/8YUVxq7PEo7eGVi1buhh2P5Q+N+5f4HqOBB88s8HfMjQ9LMGIFBI9sNc211wygz5btR9nf1fD7wwv+WOiB4njnVlLuY2qvKAvU4wA66hLKIDxi5HTX2Mxdp1eRWZjMHhd5DskPJcibxrx6a1PbMWWG0wbj8790nf6XcnVGrf3UPcWq0AGYA==
Received: from DM6PR02CA0127.namprd02.prod.outlook.com (2603:10b6:5:1b4::29)
 by LV3PR12MB9267.namprd12.prod.outlook.com (2603:10b6:408:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Tue, 21 Apr
 2026 17:44:03 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::68) by DM6PR02CA0127.outlook.office365.com
 (2603:10b6:5:1b4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 17:44:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Tue, 21 Apr 2026 17:44:03 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Apr
 2026 10:43:47 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Apr
 2026 10:43:46 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Apr 2026 10:43:46 -0700
Date: Tue, 21 Apr 2026 10:43:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH rc v6] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
Message-ID: <aee3UHxqIOWoqbrw@Asurada-Nvidia>
References: <20260407194644.171304-1-nicolinc@nvidia.com>
 <BN9PR11MB5276D60096EBF15C5753C4BB8C202@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aeKpxLiykT8O4k1X@Asurada-Nvidia>
 <aeMO0whi7pPKE7FH@nvidia.com>
 <BN9PR11MB52769FE4DAB38B80D73AE6258C2C2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52769FE4DAB38B80D73AE6258C2C2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|LV3PR12MB9267:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c07350-0616-458b-bcfb-08de9fcd9412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uB4LG2e2Bvxb/FupvxL7/AVjwYsxN9YY3JUQJydTYbamyv/bIZ+jEINbYOZFTA/Lj3ls1TisUGcBZeVZz+PgSzWNeq9rKelsSS4WXCBBjJOGzTzw7KsZ6OsK5ZA3gol5Y2vk3cRVra6VsBQzKCzRnWVWrdnGMRC6CekCk3wAbakJWZWfrkmfEBxaYNKT1HOj8nXKeyzjTvLNqAsQiWei2/QsTbu/yd3XmGZF52vlV4iGjpqfwvR/zSR0Y6EJivNcoIAUDzCW9dNmSov5HTOmcPYIkpipAgnExyjs3c/dNqD5o2lJxlwb7g4IHt/79c2MFZ4TGCd4HfNjl+w0n93AMgIFUsOJwthwzZ4K45d0mRp6CDpgQFfRlD6waHTz0QUWDwnvkNDQMIXIFkpza4e+vVXq8TMLDzMVOtYSR+/UmgdRNhTly8+FMwHl0+4R/AStiptCItd2nxot/mvlQ3Gy6a6NlJMG6QmIJRZ1wYdQ69CSiY1KrhhC/ukT0B6SCovxRynoqjM4MZPBJ0qgcIwhL9DT72/KFEk5wz87P5NI7C1fHDIXcdRk6vUOiehv/w7RFH3CaYsSGDuQljo0kWag/TSpTmQusNIVpTlickPMpmy1Iqi4lzgA9r8L/H5hhCNubuWGBhHo1QjPw/hUjSf27F5yk0PbatvvIP/2xG4r8ZFHuX5SNZ1HgNlqND6RtdiIrGtkkruyzQ4miwTGCADZ3OPYNciV5F2dqk+LZHlCQKWugk9hmkmeXP8Z+DiwEfM9Ypc3O8zruG9gXcEGpjG/4g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aFgUJtLgf4pc4i1LHEG+vfDQ+a+BhxcunzmMbm7kQ522je7VRfMSLJBqzt5RllGgIlt53UdcSh2Kuj4Ygn5J5qqhYY2X+V3TMdklOUiEYGDwL0s70l5yvo5IeLTvl53QYAa5SXDTcSHb05cgQRKwDUcCbzL156dMZvuSPt70Bmb6IDSlb2QUV+rdJEQcb2KuX9SFvSCar+Nf6yonjpjGtCUZFp/KvTmK6M9ziOBmwnWifLN4G+t63zzlHT9/kmtp8B/ybMR221SskgGxQ8py3lvWToiNJxiYgh34/MVQTBWP0Pr+WXyGUFMvUFA/a2vYJcKMB2Q1GFGfzLT1/Q8Hwn5bVkhl7/zr0nHzv2EdwXXvt6EcrIhCZlSf8NwMbikk7RCBqnY0hhn+aesN2CBqfeesOnC0V7gKw3jhSelqlg+w+/ugenEcUvUBT5cfv2xP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 17:44:03.2923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c07350-0616-458b-bcfb-08de9fcd9412
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9267

On Tue, Apr 21, 2026 at 07:01:22AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, April 18, 2026 12:57 PM
> > 
> > On Fri, Apr 17, 2026 at 02:44:41PM -0700, Nicolin Chen wrote:
> > > @@ -2469,9 +2469,2 @@ static int
> > __iommu_group_set_domain_internal(struct iommu_group *group,
> > >
> > > -       /*
> > > -        * This is a concurrent attach during device recovery. Reject it until
> > > -        * pci_dev_reset_iommu_done() attaches the device to group->domain.
> > > -        */
> > > -       if (group->recovery_cnt)
> > > -               return -EBUSY;
> > > -
> > 
> > On a second thought, we may not simply drop this -- IIRC, we added
> > it particularly to fence a case where gdevs share the same RID or
> > some corner case like that?
> > 
> 
> this is by design according to the original commit:
> 
> "
>     Note that there are two corner cases:
>      1. Devices in the same iommu_group
>         Since an attachment is always per iommu_group, this means that any
>         sibling devices in the iommu_group cannot change domain, to prevent
>         race conditions.
>     ...
> "

Well, we changed the implementation a few times, and it isn't in
the merged v8 cover-letter..

Nicolin
