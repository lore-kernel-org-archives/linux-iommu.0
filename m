Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEDB1B4248
	for <iommu@lists.linux.dev>; Mon,  9 Dec 2024 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756731; cv=fail; b=SEQAHct42aAOTGPFllXIv+hLOxKbywWY3trWrPldmY3163tl73XR1Nq+qrZhjdiU86xnu3YpHuEvayfl+8cqKCp5HYRwCbmZ4UpuA5GBPKfxO6iZqydjRf4SJPdmZ5tMQlJ59WUYOM+idNJ5JVzk9iaI3JDGR58pt6DerPFvvdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756731; c=relaxed/simple;
	bh=1EPokL5zzFKJ/JkIcFNibB27zIidVxmF4gtUmSv6Ofw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gxxWFuagZAOwrdukaoBfqPY5219rN5npYGhc8F0RYwn3wjt42oryw6z8dMKk6GDi6jhp1BP7akqc0LeafzW4SxYQ0x4OoUBBFtNn6CKKvmFqeSuBwP30trXMYQccCAn+J7ybkWFFt+8SPxaOJiZ0qSLWhaybuXzImgyMk0ZJtgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h8+BSzmc; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h8+BSzmc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QY/9urdZNcO9zg25VN5DN24hS34M7abXTMJ37Gf+cKGu3ddv50Fw9DtuoEPbRA+EhAIB4I8+IXFIMb74JhkfJpsR1u5b1d/h9y1pHrwzje9jgHLBLmF3oXulXLHFf8qLfwXIi7pIBKWj6jyF5fMqrJ5+rH6JVDdLA5eHu1cPtLcK73y26zhOVXgEAR2AVwImgPp4LUzESKlxByLTgihcEoVJqQmBEff6Zq1o545B7zEew6Z4Zq6Xh38F4GuodYKKyjOgOCTR+BwrtEo0PRuTQtURQSLAbljdk23y9/nrlk516LO+0CFcq0G+YfXmVdxMyjy6gcE1z3FJwxnilImKnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWi4qb42LYfuKHySOcngYp1YdNL95969Hk3jH78Vfq0=;
 b=ZYfBnv6am0m2GwIiLT/7bY6GBfU4Adoqom2j7k/Y3PhqJSwEgC6Dk/I1hU81MrDwxRMaPklBhlK9/svF5fQY8ltoksocqup02YZCJBx1tj44Rsz3+f3HOpR+kPGD99Ean95rDPNwWqV6ZOY9bSIEPqqkola3tNl8miTKoq0zNdpOe7/xzNeoE4El6Z4I3Wgb0AuMCvAc+j9Wc12rjus1aJwP05A0gGYhHHfKBdo2sHc2XoNrnyIBekyjsidW5MTeij8Uanbrw/Eseu4C9cNa3271agK2EP74g9i3YmXMAZYiRjzkUUnFafr0SHFGqOWWmZKwTA4zaH7103zEn7ivKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWi4qb42LYfuKHySOcngYp1YdNL95969Hk3jH78Vfq0=;
 b=h8+BSzmcjrEDWlFULDDw/eUWUI9UQtPt1YhyCMII/K8aurBLvWf59Y8/0J5pmSl3YatZBkxGaLbWC17XbTexb7V4vxL9EGChXGa3iDH4UyOuKcgIyLB4Js0ZOPDN7m4aU1NO/440YiG+7UidHixfLd3BuRIrUx9ZY48HV01WF1ZcFUsQ/68YeLr9PF6eBvGlb7IO2nYu7S1XIs9xDdomTijs7hkSlM33Mne2EkRTePl1bcIk5xFS/wO19rnfN9HYqnaYiIrvkLwTeAcbxoiX64W6sM8VZPh0xVl9LcQLRNvyVmuK5Y/5RzDvNF57HMk+63OwoGsTdiPP54dYu3+B0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Mon, 9 Dec
 2024 15:05:15 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 15:05:15 +0000
Date: Mon, 9 Dec 2024 11:05:14 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org,
	kevin.tian@intel.com, eric.auger@redhat.com, nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
	vasant.hegde@amd.com, will@kernel.org
Subject: Re: [PATCH] iommufd: Deal with IOMMU_HWPT_FAULT_ID_VALID in iommufd
 core
Message-ID: <20241209150514.GD2347147@nvidia.com>
References: <20241207120108.5640-1-yi.l.liu@intel.com>
 <b1e8ad5e-e149-4502-8242-b971ac1d4eff@linux.intel.com>
 <3f9e3172-dffb-449d-8bd5-23f9cb2de73a@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f9e3172-dffb-449d-8bd5-23f9cb2de73a@intel.com>
X-ClientProxiedBy: BN1PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:408:e2::30) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM6PR12MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab79bf2-e5e5-4f6a-4ddc-08dd1862e348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GU79gbxJ/BDCA3hkjUnD3cSdb2faZVBUGiXvRqHOBIYegxvUDSIvyUNsvmKf?=
 =?us-ascii?Q?WBHZZcbgAqx8NUhMyQ9kOvI5w+ML3l6uEDGmscVo7VW9MmaVnWdrpUlcO+Ge?=
 =?us-ascii?Q?hJimUwcMYemX4YVCDy4YFk42odJ4wN4qOb2DChLz9lTsCkl7MD8LwrkcECiG?=
 =?us-ascii?Q?ryyFRIQm5p0ksmQjr2xZ+lmt1NB8Lms+Ze7Kw99JbepiJW0kUg/DECqWcA7C?=
 =?us-ascii?Q?nqMDIa5Q69uvpUKE8KrHeiC+8cmx3FWV69M42fz7WFb+76J/QQz6A4kY36aX?=
 =?us-ascii?Q?yPs8Jacgyz2ED6q0Tt8zL99R16QVgAzF5Ee99CHNqo0oudSOixbc96V1oL+s?=
 =?us-ascii?Q?oyxbDnZdYjLuGq3PT0ZITzdGPeEa8mCEIWY5GVlCygED+jeEX9z1IGuzRoQp?=
 =?us-ascii?Q?Zsu3XYcHsUuxsuGI03i0GshmxXFoZqNVWBqPM0tmKDjoXqTuxHO38TWaB3ZR?=
 =?us-ascii?Q?ydfo3XHT/tYcFjuUFgliRxqxkH43oCMLknfz/E1+DQrqjfXLT4tWnePKzBf4?=
 =?us-ascii?Q?N3fflX4zXp81Rc3BPx3Yzr/0yUbHqBEAkdjfqusdfThtgElTV2kpAXOJGbhT?=
 =?us-ascii?Q?3sMbVgSKoVrfXtvmOoo8ISOCemP7Wg2dASrRp72JyqoYYre+OCVjQdVBDInk?=
 =?us-ascii?Q?UC0yHYP9O8GwSNstepLGU9CJ4a6h56avOT5/lgk17UVFXmnU9/5V4uogOA4o?=
 =?us-ascii?Q?tOiDYWLyV7zMtPH9mDJIJHnX6wQwcC92HxMai7jh3mNwJO9yND+21D5RjSEs?=
 =?us-ascii?Q?4xCfBgqCqE2KS7MEfSO0QzSl5JeUEf33Lej2G5Xn1sp58zYav/V9k515N6D4?=
 =?us-ascii?Q?kqz2o9WomgPj3TjO/rcgNPFR4YOcFLOANl9RqzizHJMychbAY/hTUw5yTVZd?=
 =?us-ascii?Q?N8GsDMEHmxVi6TJQlo61GsEjQyf9iH9wscWyZWkyJbrRE04nNuh+TuvNOYrW?=
 =?us-ascii?Q?3m7VqziUKTCOqyIPRIA6XHMpAQDT+uAjR0TslNE7E5kOyvsYAQVrcHPS6+Di?=
 =?us-ascii?Q?Rd+C8StP0iC9NItoqT5JJlQL86y26L+ox9GhPEmy099VWkgZE4kvhTRajoDd?=
 =?us-ascii?Q?BCaiiJZZhNE7Xigs6B/vwzoZmpRDH5yautdyBrrqRo984kNXi+o0D/ZmwbMr?=
 =?us-ascii?Q?edME8hrUprFYgJkGACUgRKXdD5KfeZe1Kg/HCS00XB8Wpc1CYN24sYmU1j/C?=
 =?us-ascii?Q?SZW1khKSUNcBc6Uxp3JVwt946eza5/2pWOv0nIzgLyPV09EE70iey0zfsm0F?=
 =?us-ascii?Q?KHPhSpX+swn2diQBEJonU8wUJHaUa7mKg3xiDXbFaF8NqtmEvuQ8vVKlRzso?=
 =?us-ascii?Q?kH7YA/7emJTTBTmg1k5wyiWCEQczX+/vOShRAVw7+AY6Mg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KcfpJJ1Wi6QSqhztdGZiblnG3ABkr43GMOtAQAIo8v+h2H9gS5hthUnMMHZ+?=
 =?us-ascii?Q?D7ampi1D235FFUeaGSSC8eCUOcCMulAT/jKsRjM/LeFWUjGTwRYzX+V15qek?=
 =?us-ascii?Q?891BuD4790sxBA6Xy83IHEd/VLcrLyPUt8x5FCN7uUfX6QY6FYz+/eRdijoE?=
 =?us-ascii?Q?wpPFCq26zhqvoNGNn2qC/VoppuHvKMEpIpyL9fj78TBcnULEiLqEkCkqsUBO?=
 =?us-ascii?Q?mOg3FiDCfBYeJ9duVirZXKNKJBQt8B1hJPightdqI6/3jhLyfi6WGv7rXGvW?=
 =?us-ascii?Q?2FqnYSJuIQxupHEy9bhax/viaEpPzNGafjf7BsNOd0GvI7aK0ITDdXc3JDr+?=
 =?us-ascii?Q?raKZlq5mLFyIuGNPS8bdKxMWyNc87jZOanVfqY/Rej/43FviDcyekiY/VXbA?=
 =?us-ascii?Q?bFYuCJ/zvpfHrVsJ1PSZg4VbJmGHRrzk1GQxztXGRuDWwz4vYrG2Nhs536ON?=
 =?us-ascii?Q?fAdbXUJAaPs7ZveMxq8J2Tqq+y2PRo/a/4OwNTKzCF0X7ozt9lG0tychxUQ+?=
 =?us-ascii?Q?8wYQ3IaVPLgdCckYrqEFMzWwHU/UMxw4mewGq4bCsvV7EHz0Nt80IzG2EPF4?=
 =?us-ascii?Q?/s8fBKChqCJJWOz2Ut4F8SFWNE3cPBFxY2DYOctuCwCfBT35Dsd5zp0xbRVT?=
 =?us-ascii?Q?zurTBIiEWx/dyvF4JOAzwbTYGhbNfCLmDlHQvdbORoylQOFd4aiUbyY1DfN5?=
 =?us-ascii?Q?GeGSPup5tstK0Ch1ZoXhsO3UfXjM+afagvuOR4Vjh/A2JgnMOLeKBxBPOoyh?=
 =?us-ascii?Q?vN2v1oHMaR86EAMm4XnY3xz23Bfd/g6qzvAvFccOl6ZEUAeFFatGFi2qWlyQ?=
 =?us-ascii?Q?nAajQ7s40OHtt8LBGTIU6jzKbsYqIh/EeFBiGjtccq3OayojKuAvHONIa4lU?=
 =?us-ascii?Q?hBYIuOo5pM+fcy28yDgo+CjiXBlzImUSSYFnAw9NhUE1q1N6LpezZIiR52vx?=
 =?us-ascii?Q?rdbOOhLv1VahX7cdzeRy5FLyS46c0LTfYnYxLVd3XXdKivNA+nz8tq6NBtg1?=
 =?us-ascii?Q?VhEZjOG3kYEmcR3o3PAi9vRdHKhY7Yh9CSS2ej+fbK/QElDlAf4rF7+Jh5sO?=
 =?us-ascii?Q?CXvOn5qfCFa8TXDOfenvS2afu+TdIQx4a8N1+XdnweSa+Ligu0y+0NDFejAD?=
 =?us-ascii?Q?gwQ2QE7RXW2OczKIvJnYmMXCtKHFzt6HO2JiDTx3TTJroJoUjskzckj316E3?=
 =?us-ascii?Q?IzhcnDiL8+iGhthsydRlgsbhgAiSiUfrx0s8KT24pGS1sCIkB7bD5nhMGFRh?=
 =?us-ascii?Q?q0CodJDk1bOQfP26Gg7dvu+kj3CwFsrzqpxuezQrAXLKbIzD0F2M6WpiVGm6?=
 =?us-ascii?Q?/d/F6J33COdZxnYv50DXJAUfU/AU3x9u9poObVLBIgDTnc3rn5CFDGkuD+f8?=
 =?us-ascii?Q?II5AZhMop7bBT3kag9QxIA/CAZWBZnf+wvx+PlLui9srNlaN8gq++61m/CdY?=
 =?us-ascii?Q?ko/Pi3PrOk+WNzmlOAM38PB45jEM06WQyYhBmI5aGxp/rv8oscoW+1ji8hAP?=
 =?us-ascii?Q?Pxe9EDk1DcdLXfreCxkhmZtybi5p/gcj1hbgrI+bCVew6sds64DAecH4cT0R?=
 =?us-ascii?Q?orUL0yo0/vJKLdg/F5nvU1CQpC/M9Zi0H4ocmrV3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab79bf2-e5e5-4f6a-4ddc-08dd1862e348
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 15:05:15.6953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8XVUdV4hBg3iO4r1scte2yrDxFBsVmxV0usmFOid8WegNkoE8yjp/WWw8LWNMUK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106

On Mon, Dec 09, 2024 at 10:51:51AM +0800, Yi Liu wrote:
> On 2024/12/9 09:08, Baolu Lu wrote:
> > On 12/7/24 20:01, Yi Liu wrote:
> > > IOMMU_HWPT_FAULT_ID_VALID is used to mark if the fault_id field of
> > > iommu_hwp_alloc is valid or not. As the fault_id field is handled in
> > > the iommufd core, so it makes sense to sanitize the
> > > IOMMU_HWPT_FAULT_ID_VALID flag in the iommufd core, and mask it out
> > > before passing the user flags to the iommu drivers.
> > 
> > Is it a valid use case for an iommu driver to intercept the
> > IOMMU_HWPT_FAULT_ID_VALID flag as an indication that user space requests
> > an iopf-capable domain?

For now we have no use case, so we can drop it from drivers, I think.

PRI support or not is decided when the domain is attached based on the
fault_handler in the struct iommu_domain.

As a general rule drivers should not know the *userspace* is doing
something as much as we can manage.

> > If the device and its associated iommu do not support PRI, the domain
> > allocation should be aborted and a failure returned?
 
> Agreed, it is better to fail the hwpt allocation. BTW. We may also check it
> by reading the enable bit in PCI config space of the device. Which one
> would be better?

We should not be reading pci config space in iommufd. iommufd is
generic and not tied to PCI.

It would be nice if domain allocation fails, but also I wouldn't
contort things to achieve that. Failing attach is also OK and must
also be supported as a fault capable domain allocated on a fault
capable device can still fail to be attached to a non fault capable
device.

"fault capable" is complicated unfortunately because we have driver
specific page fault reporting, and it may be that vfio userspace is
processing fault...

Jason
