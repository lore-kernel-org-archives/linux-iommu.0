Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDC8185C;
	Thu, 30 Nov 2023 01:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uh51OUED"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlQP7Lb0ByQdAGH5kYZwXD7SK6lNdYEtVPmXvEczUD7Dq+dlMH8BaGOZtB0MCdbOMm0Dw9tw84WVvLSBwKF/xGGawH4bpowbR4TSkNURP+jfzzWQOoWd0R7qk1YbHSsz8u4aOsVZp2Ir0BpiU8lslV7ZQxZ/vVULoad1r5iyXwces7Xtv5STnRYNOOjiHJzQ2WntH2bvvtRP8bvgYygFICutQmMv5IZ/jeHDC+YYFQUoAzcqAQAVyYtbAykCqlmchiExuQBNuGzXXwkXeVrbuDPoj8OvyHyNYPuGGS+PT/5ACSTZB4LMrbc9UTUew7FCRG4SM4O7ltHGscHSE5TQLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06r5Qbq2saKhsPii9Lq99kKq9DAA0tltBRXGbUvETIY=;
 b=UMG9urhfobe5phrxps7HryzWpzOo5TDeiZJfWl5jpnG6DJYXEuIjQNvlBRtkUP81y84rUqLn1Nc7NIs39hs15mnQMMQNrJMYb2WnB2ERB6gKKAILQ70tQaKt+UeB670sZPWLIgzWV2FO0pva75RN1Mn2u0cvobHfLEv3jwbmApyoBQwHCDC9JMVu0DfTeK+pZGoolLV5oKDLIkLl3rB+h1cL/JbjvLgIP1xL87k2L+kOE2ytnCF648zqnELzCcdXC3+cAEj6GHmcUrXBqenN2/IexessHyLz84/SlDwQ0ijCSkEoZsleqHvv/b3QwBW+kqzKTkLhj816ZSD3+993rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06r5Qbq2saKhsPii9Lq99kKq9DAA0tltBRXGbUvETIY=;
 b=Uh51OUED+IFgEoe6BKIB/arm0g+m+RDRdpUrErDXy6gnpb3hgisbRUK/X8ZUACfza98cWysJ+uCdcPsqgkwLGEZDZPpw7YHo95cDuZMzawHJd8U2pNO56NJ1cz23+lWT5utKx7wplsSdtQbAdv/Xflg7iQz+ij5F0tY5Aa9fslVXj9BonwZJ05eH+ae89BsWP10Lo1bNQYb3bBF1sQx4oGqVOZ/qXapy4sEFi3Jb4O7JU0iXEsDMJNP66g0jbGrc4pk4URl6tyxZF7bvhbW70BfzDfegV32sxk/+RclWDckklA+W5EBtYVuNoit62HXj5QeWYBfrKSVaFxD20TqJMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 01:14:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:14:40 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: acpica-devel@lists.linux.dev,
	=?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Hector Martin <marcan@marcan.st>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 00/30] Make a new API for drivers to use to get their FW
Date: Wed, 29 Nov 2023 21:14:00 -0400
Message-ID: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c8ba64-a7e2-456b-e575-08dbf141b65c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BdFfi/wxPYo5TfH2sB/JJb5uQlCmJv1rp8UmdDIY7+KewJh9zjoESRUN9b0UzNpQIskXlrQ31v3s2vobuYJV6sEbHldQF3iXM1+inWqa2fz9JM3GSI69EzHkkMq0oFsuF65uXWFcIuv+O+Rawoeejlt6hX2IK6slxJk/7OcogFYE5YSScljFOWwzRhddcCXEHrc9Qj9OVjtP5tX+VNZc9a3F0ghwHUj50IRztw7EUZzn+RX0TnOireFb6Umh79KjZPecxgx35L+BOb4QP+071IhRpcepXNFjiLzwdIHq1UzUXW0ecJswGhIf2XZBBEG8JfFOdk1Invl94I4weuJf+gr2YYbB3WIPRHVxBsVW/ITPtRqCwSmaXbXKa2JeYtK+DEjQX42c3SoBLPwhBmXiaG0KjNHhksbWCgzggrMSg42jPa7N9BnY5zT7/CUbed6k2rLj/yZVWDekWKpgRgY6h6NzMzghBfP/L25Ar5FpHpfBACdIRRSYt1oeVDSiUUcTXpPKFhiKfxWo+38hIuuD6y+yqYAci0QN/S7xRmWDvmXoa+daTzfxYCkHlDk8/X9Aw3OZbmRqQOZMaDcIo+hpid5kaAX54AglRTpzxWy+dw3USvqwPmIEEl23NsWP8YK3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(109986022)(451199024)(6486002)(966005)(4326008)(478600001)(8676002)(86362001)(5660300002)(8936002)(54906003)(66476007)(66556008)(66946007)(6506007)(2906002)(316002)(6666004)(6512007)(36756003)(26005)(2616005)(83380400001)(41300700001)(38100700002)(4216001)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UlJPicI4Zh+dNJNPb9oAjVtjE7yzLbPl3AeX7qDTW2dQCXDLKeVLOLozcHfM?=
 =?us-ascii?Q?cRb95jf4JK+UQVnlL7x0gkDpAzoWvs2d0CLnGg2HfVIsbLNdrryO4W24EkW7?=
 =?us-ascii?Q?z/YzEF1Gqq7JbCQziXrcaH6Sj+bkaSFB9r9Hi9oN06xXVVIpv+ukpGYBP78M?=
 =?us-ascii?Q?pPrl75IFMDF7jpJJLd/B0n7iHQj+w6qkNueymD5VSWvz7WRXXjst7FTVtEks?=
 =?us-ascii?Q?wIgcmLn8mNU7M4tQN8S9V8mWmC2qvxSqndqk0iWZHXac+zv1iGnmonTsdKgf?=
 =?us-ascii?Q?Iza50oPTBtbIGb6gQ2AJsT8d3hfBGSqxSfrMuNWyJQS3P44lmOQThTfAhkDq?=
 =?us-ascii?Q?EBjFsOi7EFJXkCaDGgtW64dV9fltKh9ObUTY5hodjMkWjgpiWnd4ok0Emlic?=
 =?us-ascii?Q?iaNF5VHSeNtJIBKMxZt94WEBPLzPXPffGUFEd5c6Pff2vt3aFVvNjNjOFN0T?=
 =?us-ascii?Q?uOYcvhortaO65eB4IO8/JBnbdFYem98DuaeXP/tCYR5iQYbScLy/N/LaxEI3?=
 =?us-ascii?Q?To0HnDWiZoPKjfIHRJF0Jx8qXH70uKrleHaC6O/jxQk3VK4+3H1U3IZdGajJ?=
 =?us-ascii?Q?fekOvcExsh1k0zBn3qAcL+IdV3R9Q8ehHPJ5ckZtGCLCbqfismE5YWZ2H3Tw?=
 =?us-ascii?Q?IkXJGeXpQYVuougv+3T9WEZ1WA6835USBarIzYloG0/LkJrrYxAEWdHxQgpG?=
 =?us-ascii?Q?alKV4DtJHdQD+bdisvd/ok+z45XkjEn990CsqgqvzJjVGfSCKz3SUkdkWiPn?=
 =?us-ascii?Q?b9wPXkQDbiGhOLNQUsc/d+z4/a6ftLcU3ejMVjx/RFu1HMfWt0K5lmSRNtQF?=
 =?us-ascii?Q?ZPvJ1xhTUATMWIKOZCYyggynJi5qLmNjgTc5geEhHTNlPNAuQEcfuE360YGZ?=
 =?us-ascii?Q?h252Ob6xCrZm9UZGmw45kiD1KqfVAI67H+IWMQrlZeWNQ352IbgEJqo/QbjZ?=
 =?us-ascii?Q?qBaxb+AkOy2WD1uILNEHPwTIu0ZPcJ88uI3EMWsJkMuZvblG3UML3Df1Bkri?=
 =?us-ascii?Q?YMt9FI7y+7Ktyh+MMJUThDjCrkxFvmbzvzeqHz2W2iQWNwhrr3OsCB4eOsFu?=
 =?us-ascii?Q?FaYPbinB9w3TrVbf1HcQpfABFh76Ena683KBgBoqvQBeI+zU7JNq8FGHnw6t?=
 =?us-ascii?Q?MwN9hEPYjJ0Pwk8TV2OwhktYEyUI/wHlqwIUB/W5pJM8GydvDJPglZcNhshE?=
 =?us-ascii?Q?Si2aY7uBW8mrgAajSXLtv5wxqhiZB0GtfRMmId4WWzgDObZBdnguoNIfKLV+?=
 =?us-ascii?Q?3g2tUzQ91OZ7qZJ4NEnQfq/qCttSIFfguOOzq8qKtVMfg7fkyOwKAa/KkIyv?=
 =?us-ascii?Q?DVDlf7GIOb01J4A+3Mn3mH3f8tyNkt9C0MRpuzbG5PT7sRxnVhm4q5NgXW8N?=
 =?us-ascii?Q?nXz1IhdA7NwyiTHJCIqzlc4uMU2cPxs2I0ryU90YTYtJWz8Gn0up9iSMX7Xx?=
 =?us-ascii?Q?sR135fMjS4bqfO2vR6xORY4r7eFL8C3o32f6a9nUnr/BOgWJaXlx3L80feMH?=
 =?us-ascii?Q?b0SOEt0rMuF3qj9mjoB1hUPC6KzzgypRzyB0zCmfuu3VuuHyTj/LeO6wflKE?=
 =?us-ascii?Q?sJrUibVidl3kuWc6DyaAlGVXhSQdylFINMajg7Um?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c8ba64-a7e2-456b-e575-08dbf141b65c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:33.9397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xv8W8wk4lOGoK+2a1uk/FaFprUSQl6g5+6SVbngozkNaI6DG9P7go8hDSWPfmKK3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836

This series improves the way drivers get their FW data. It introduces a
series of driver facing APIs and converts every driver to use them and
replaces fwspec with this mechanism.

The new API allows drivers to do less stuff in alot of cases, and permits
all drivers to sequence their operations in a logical way with correct
error handling. It doesn't force the idea of pre or post parse on the
driver, though I choose to implement post-parse here.

Aside from the API change this takes on a few other goals:

 1) New API for drivers to simplify drivers and make them more robust
 2) Remove all FW parsing from _dma_configure()
 3) Make the global lock back into a static
 4) Organize things to reduce the probe time memory allocations from
     fw_spec, N*realloc, dev_iommu, device-private
    To just allocating device-private. The last step to merge dev_iommu
    and device-private would be a follow on couple of patches.
 5) Get everything setup to allow all devices to probe during bus scan,
    not during _dma_configure.
 6) Better layering between the ACPI and IOMMU code, less
    iommu related things in the ACPI directory.

The drivers break down into two broad approaches for accessing FW in a
driver's probe_device() function. AMD, Intel, mtk_v1, omap, S390,
smmu-legacy and tegra can "self probe" using code in their probe_device()
functions to parse their associated FW descriptions.

The rest (DART, smmu-modern, qcom, smmu-v3, exynos, ipmmu, msm, mtk,
rockchip, sprd, sun50i, virtio) use the iommu_fwspec system and rely on
the core code to do the FW parsing for them before invoking
probe_device().

To understand the philosophy of this design it is worth to take a moment
and review the 2009 LWN article on Kernel Design
patterns (https://lwn.net/Articles/336262/) exploring the "midlayer
mistake". While I do not entirely agree that midlayers are unconditionally
bad, the discussion does nicely frame the architectural choice I've made
in this series.

Organize the FW parsing so the drivers have an toolbox style API to
extract the information they require from the FW. Create a set of APIs for
the drivers to call that do exactly what the current set of drivers need
in an efficient and understandable way. The API is designed to
significantly clean and simplify the drivers.

The API transforms the iommu_fwspec from a long-term allocated struct into
a short-term on-stack struct iommu_probe_info. Using a short-term
structure means we no longer have to be memory efficient and can store
temporary details about the ongoing parsing in the structure which is the
key to allowing the new API.

Further, philosophically, the API changes to make the iommu driver
responsible to provide per-device storage for any parsed FW data. It is
stored in whatever format the driver finds appropriate. The API provides
concise helpers to make this easy for the standard 'u32 id[]' cases. The
unusual cases were already using unique per-driver storage and continue to
do so in a cleaner, less convoluted way.

The design allows the API to be implemented either as a 'parse on demand'
or 'parse and cache in advance' (more like fwspec) approach. I've
implemented the 'parse on demand' version here, but I'm not fixed on
it. Let's discuss.

The choice is deliberately not baked into the driver facing API,
iommu_probe_info combined with the generic *_iommu_for_each_id() lower
layer provides a lot of flexibility to do whatever organization we want.

The specific commit messages provide details, but the drivers break down
into three basic idiomatic sequences for their probe_device with the new
API.

Single iommu with no ID list:
  iommu_driver = iommu_of_get_single_iommu(pinf, ops, num_cells,
                                iommu_driver_struct, iommu_member);
  per_driver = kzalloc(..)
  per_driver->iommu = iommu_driver;
  dev_iommu_priv_set(dev, per_driver);
  return &iommu_driver->iommu_member;

Single iommu with a simple u32 ID list:
  iommu_driver = iommu_of_get_single_iommu(pinf, ops, num_cells,
                                iommu_driver_struct, iommu_member);
  per_driver = iommu_fw_alloc_per_device_ids(pinf, per_driver);
  per_driver->iommu = iommu_driver;
  dev_iommu_priv_set(dev, per_driver);
  return &iommu_driver->iommu_member;

The iommu_fw_alloc_per_device_ids() helper allocates a correctly sized
per-driver struct and places a u32 ID list into the flex array
per_driver->ids[]. This removes the need for a fw_spec allocation.

Complex multi-iommu or complex ID list:
  static int driver_of_xlate(struct iommu_device *iommu,
			 struct of_phandle_args *args, void *priv);

  per_driver = kzalloc(...);
  iommu_of_xlate(pinf, &ops, num_cells, &driver_of_xlate, per_driver);

  dev_iommu_priv_set(dev, per_driver);
  return &per_driver->iommu; // The first iommu_device parsed

The driver will process the given (iommu, args) tuples and store them into
the per_driver struct in its own way (eg DART encodes things into a 2D
array). Allocating the per_driver struct before running the parse cleans
all the tortured logic.

The VIOT and IORT ACPI parsers provide the same API. Drivers supporting
ACPI will call the ACPI helper (ie iommu_iort_get_single_iommu()) which
understands how to parse OF if no ACPI is present. Since the SMMU drivers
directly invoke the IORT parser they also get back the extra IORT ACPI
data in a "struct iort_params", which eliminates the need to create SW
properties or store SMMU only stuff in the fwspec.

The bulk of the series is converting each driver to this toolbox API. The
design of the toolbox functions are lightweight from a driver perspective
and generally replace existing steps that the drivers already had to do. A
significant amount of inefficient boiler plate is removed from all drivers
related to how the driver obtains the iommu_device pointers.

The implementation of the three flavours of FW parsers (OF/IORT/VIOT) are
all structured the same. The lower FW level provides
a *_iommu_for_each_id() function which parses and iterates over the actual
FW table and calls a function pointer for each (instance, id). The iommu
layer then uses this for_each primitive to do the IOMMU specific stuff and
create the above APIs.

To allow the iommu_of_get_single_iommu()/iommu_fw_alloc_per_device_ids()
split API the get_single will count all of the IDs and then alloc will
size the flex array. The iommu_probe_info has scratch space for some ids
which can then be memcpy'd without a reparse. Reparse is kept as a backup
so we can handle arbitary complexity without burdening the typical fast
path.

The removal of all FW parsing from _dma_configure leaves only the
initialization of the iommu_probe_info behind. My plan is to add a new bus
op 'init iommu probe info' that will do this step and then we can fully
execute probe outside the *_dma_configure() context.

The big win here is the extensive cleaning of the driver's probe
paths. There is alot of "creative" stuff there, this cleans almost all of
it away.

This is on github: https://github.com/jgunthorpe/linux/commits/iommu_fwspec

Jason Gunthorpe (30):
  iommu/of: Make a of_iommu_for_each_id()
  ACPI: VIOT: Make a viot_iommu_for_each_id()
  ACPI: IORT: Make a iort_iommu_for_each_id()
  ACPI: IORT: Remove fwspec from the reserved region code
  iommu: Add iommu_probe_info
  iommu: Make iommu_ops_from_fwnode() return the iommu_device
  iommu/of: Call of_iommu_get_resv_regions() directly
  iommu/of: Add iommu_of_get_single_iommu()
  iommu/rockchip: Move to iommu_of_get_single_iommu()
  iommu/sprd: Move to iommu_of_get_single_iommu()
  iommu/sun50i: Move to iommu_of_get_single_iommu()
  iommu/of: Add iommu_of_xlate()
  iommu/dart: Move to iommu_of_xlate()
  iommu/exynos: Move to iommu_of_xlate()
  iommu/msm: Move to iommu_of_xlate()
  iommu/tegra: Route tegra_dev_iommu_get_stream_id() through an op
  iommu: Add iommu_fw_alloc_per_device_ids()
  iommu/tegra: Move to iommu_fw_alloc_per_device_ids()
  iommu/mtk: Move to iommu_fw_alloc_per_device_ids()
  iommu/ipmmu-vmsa: Move to iommu_fw_alloc_per_device_ids()
  iommu/mtk_v1: Move to iommu_fw_alloc_per_device_ids()
  iommu/qcom: Move to iommu_fw_alloc_per_device_ids()
  iommu/viot: Add iommu_viot_get_single_iommu()
  iommu/virtio: Move to iommu_fw_alloc_per_device_ids()
  iommu/iort: Add iommu_iort_get_single_iommu()
  iommu/arm-smmu-v3: Move to iommu_fw_alloc_per_device_ids()
  iommu/arm-smmu: Move to iommu_of_xlate()
  iommu: Call all drivers if there is no fwspec
  iommu: Check for EPROBE_DEFER using the new FW parsers
  iommu: Remove fwspec and related

 drivers/acpi/arm64/iort.c                   | 233 +++++++---------
 drivers/acpi/scan.c                         |  58 +---
 drivers/acpi/viot.c                         |  67 ++---
 drivers/iommu/Makefile                      |   2 +
 drivers/iommu/apple-dart.c                  |  62 +++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  73 ++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   4 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c  |   6 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 209 +++++++-------
 drivers/iommu/arm/arm-smmu/arm-smmu.h       |  13 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     | 160 +++++------
 drivers/iommu/dma-iommu.c                   |  22 --
 drivers/iommu/dma-iommu.h                   |   6 -
 drivers/iommu/exynos-iommu.c                |  78 +++---
 drivers/iommu/iommu.c                       | 271 ++++++++++++------
 drivers/iommu/iort_iommu.c                  |  99 +++++++
 drivers/iommu/ipmmu-vmsa.c                  |  95 +++----
 drivers/iommu/msm_iommu.c                   |  92 +++----
 drivers/iommu/mtk_iommu.c                   | 115 ++++----
 drivers/iommu/mtk_iommu_v1.c                | 162 +++++------
 drivers/iommu/of_iommu.c                    | 288 ++++++++++++++------
 drivers/iommu/rockchip-iommu.c              |  73 ++---
 drivers/iommu/sprd-iommu.c                  |  31 +--
 drivers/iommu/sun50i-iommu.c                |  59 ++--
 drivers/iommu/tegra-smmu.c                  | 158 ++++-------
 drivers/iommu/viot_iommu.c                  |  71 +++++
 drivers/iommu/virtio-iommu.c                |  71 ++---
 include/acpi/acpi_bus.h                     |   3 -
 include/linux/acpi_iort.h                   |  24 +-
 include/linux/acpi_viot.h                   |  16 +-
 include/linux/iommu-driver.h                | 250 +++++++++++++++++
 include/linux/iommu.h                       | 101 +------
 include/linux/of_iommu.h                    |   8 -
 33 files changed, 1649 insertions(+), 1331 deletions(-)
 create mode 100644 drivers/iommu/iort_iommu.c
 create mode 100644 drivers/iommu/viot_iommu.c
 create mode 100644 include/linux/iommu-driver.h


base-commit: 68ec454bc1514f557686b5895dd9719e18d31705
-- 
2.42.0

